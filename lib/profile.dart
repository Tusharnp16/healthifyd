// profile.dart

import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'navigation.dart'; // Import your NavigationMenu file

class Profile extends StatefulWidget {
  final String? phoneNumber; // Define phoneNumber as a parameter
  Profile({Key? key, this.phoneNumber}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController nameController = TextEditingController();
  String gender = '';
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  String? selectedSpecialist;
  TextEditingController hospitalController = TextEditingController();
  String imagePath = '';
  String doctorId = ''; // Add doctorId variable
  final _formKey = GlobalKey<FormState>(); // Add a global key for the form
  AutovalidateMode _autovalidateMode =
      AutovalidateMode.disabled; // Autovalidate mode initially disabled

  @override
  void initState() {
    super.initState();
    // Fill the phone number field if provided
    if (widget.phoneNumber != null) {
      mobileNoController.text = widget.phoneNumber!;
    }
    // Generate and set the doctor ID on initialization
    doctorId = generateDoctorId(mobileNoController.text);
  }

  String generateDoctorId(String mobile) {
    // Generate a unique doctor ID using a random number
    int randomNumber = math.Random().nextInt(999999);
    return 'DOC$randomNumber'; // Prefixing with 'DOC' to indicate Doctor
  }

  void addDataToFirebase(String name, String gender, String mobile, String email,
      String specialist, String hospital, String imagePath) async {
    if (_formKey.currentState!.validate()) {
      // Check if the form is valid before submitting
      FirebaseFirestore.instance.collection("Users").doc(mobile).set({
        "Name": name,
        "Gender": gender,
        "Mobile": mobile,
        "Email": email,
        "Specialist": specialist,
        "Hospital": hospital,
        "DoctorId": doctorId, // Include doctor ID in the document
        "ProfileImage": imagePath,
      }).then((value) => print("Data Inserted"));
    } else {
      // If the form is not valid, enable autovalidation mode
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Set the imagePath to the picked image file path
      setState(() {
        imagePath = pickedFile.path;
      });
    } else {
      // Handle case when the user cancels image picking
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode, // Set autovalidate mode
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Container(
                      height: 100,
                      width: 100,
                      child: imagePath.isEmpty
                          ? Image.asset("assets/images/admin.jpg")
                          : Image.network(imagePath),
                    ),
                    onTap: _pickImage,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Doctor ID: $doctorId',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      // Dropdown button decoration
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(220, 59, 206, 255),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(220, 59, 206, 255),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      prefixIcon: Icon(
                        Icons.local_hospital,
                        color: Color.fromARGB(220, 59, 206, 255),
                      ),
                      hintText: "Specialist",
                    ),
                    value: selectedSpecialist,
                    onChanged: (String? value) {
                      setState(() {
                        selectedSpecialist = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a specialist';
                      }
                      return null;
                    },
                    items: [
                      "Orthopedists (bones, muscles)",
                      "Obstetricians and gynecologists (women's health, including pregnancy and childbirth)",
                      "Neurologists (nervous system)",
                      "Cardiologists (heart and circulatory system)",
                      "Dermatologists (hair, skin)",
                      "Gastroenterologists (digestive system)",
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      // Name text field decoration
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(220, 59, 206, 255),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(220, 59, 206, 255),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Color.fromARGB(220, 59, 206, 255),
                      ),
                      hintText: "Name",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(220, 59, 206, 255),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.male_outlined,
                          color: Colors.lightBlueAccent,
                        ),
                        SizedBox(width: 8),
                        Row(
                          children: [
                            Radio<String>(
                              value: 'Male',
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value!;
                                });
                              },
                              activeColor: Color.fromARGB(220, 59, 206, 255),
                            ),
                            Text(
                              'Male',
                              style: TextStyle(
                                color: Color.fromARGB(220, 59, 206, 255),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              value: 'Female',
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value!;
                                });
                              },
                              activeColor: Color.fromARGB(220, 59, 206, 255),
                            ),
                            Text(
                              'Female',
                              style: TextStyle(
                                color: Color.fromARGB(220, 59, 206, 255),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              value: 'Other',
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value!;
                                });
                              },
                              activeColor: Color.fromARGB(220, 59, 206, 255),
                            ),
                            Text(
                              'Other',
                              style: TextStyle(
                                color: Color.fromARGB(220, 59, 206, 255),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: mobileNoController,
                    decoration: InputDecoration(
                      // Mobile number text field decoration
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(220, 59, 206, 255),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(220, 59, 206, 255),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Color.fromARGB(220, 59, 206, 255),
                      ),
                      hintText: "Mobile No",
                    ),
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your mobile number';
                      }
                      if (value.length != 10) {
                        return 'Mobile number must be 10 digits';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: emailIdController,
                    decoration: InputDecoration(
                      // Email text field decoration
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(220, 59, 206, 255),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(220, 59, 206, 255),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Color.fromARGB(220, 59, 206, 255),
                      ),
                      hintText: "Email Id",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: hospitalController,
                    decoration: InputDecoration(
                      // Hospital text field decoration
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(220, 59, 206, 255),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(220, 59, 206, 255),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      prefixIcon: Icon(
                        Icons.local_hospital_outlined,
                        color: Color.fromARGB(220, 59, 206, 255),
                      ),
                      hintText: "Hospital",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter hospital name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(220, 59, 206, 255),
                        borderRadius: BorderRadius.circular(37),
                      ),
                      child: const Text(
                        "Update",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Validate the form before submitting
                        if (gender.isEmpty) {
                          // If gender is empty, show an error message
                          setState(() {
                            _autovalidateMode = AutovalidateMode.always;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please select your gender'),
                            ),
                          );
                        } else if (selectedSpecialist == null || selectedSpecialist!.isEmpty) {
                          // If specialist is not selected, show an error message
                          setState(() {
                            _autovalidateMode = AutovalidateMode.always;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please select a specialist'),
                            ),
                          );
                        } else {
                          // All fields are valid, proceed with data submission
                          addDataToFirebase(
                            nameController.text.toString(),
                            gender,
                            mobileNoController.text.toString(),
                            emailIdController.text.toString(),
                            selectedSpecialist ?? "",
                            hospitalController.text.toString(),
                            imagePath,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NavigationMenu()),
                          );
                        }
                      } else {
                        // If the form is not valid, enable autovalidation mode
                        setState(() {
                          _autovalidateMode = AutovalidateMode.always;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
