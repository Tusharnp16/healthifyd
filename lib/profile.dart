import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:healthifyd/usermodel.dart';
import 'package:image_picker/image_picker.dart';
import 'Userrepository.dart';
import 'navigation.dart'; // Import your NavigationMenu file

class Profile extends StatefulWidget {
  final String? phoneNumber; // Define phoneNumber as a parameter
  Profile({Key? key, this.phoneNumber}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  TextEditingController namecontrolletr = TextEditingController();
  TextEditingController gendercontroller = TextEditingController();
  TextEditingController mobilenocontroller = TextEditingController();
  TextEditingController emailidcontroller = TextEditingController();
  TextEditingController specialistcontroller = TextEditingController();
  TextEditingController hospitalcontroller = TextEditingController();
  String imagePath = '';

  String selectedSpecialist = "Select-specialist";

  final userRepo = Get.put(UserRepository());

  String gender = '';
  Future<void> createuser(usermodel user) async {
    await userRepo.createuser(user);
  }

  //
  // @override
  // void initState() {
  //   super.initState();
  //   // Fill the phone number field if provided
  //   if (widget.phoneNumber != null) {
  //     mobileNoController.text = widget.phoneNumber!;
  //   }
  // }
  //
  String generateDoctorId() {
    // Generate a unique doctor ID using a random number
    int randomNumber = math.Random().nextInt(999999);
    return 'DOC$randomNumber'; // Prefixing with 'DOC' to indicate Doctor
  }
  //
  // void addDataToFirebase(
  //     String name,
  //     String gender,
  //     String mobile,
  //     String email,
  //     String specialist,
  //     String hospital,
  //     String imagePath,
  //     ) async {
  //   if (name.isEmpty ||
  //       gender.isEmpty ||
  //       mobile.isEmpty ||
  //       email.isEmpty ||
  //       specialist.isEmpty ||
  //       hospital.isEmpty ||
  //       imagePath.isEmpty) {
  //     print("Field is Empty");
  //   } else {
  //     FirebaseFirestore.instance.collection("Users").doc(mobile).set({
  //       "Name": name,
  //       "Gender": gender,
  //       "Mobile": mobile,
  //       "Email": email,
  //       "Specialist": specialist,
  //       "Hospital": hospital,
  //       "DoctorId": generateDoctorId(),
  //       "ProfileImage": imagePath,
  //     }).then((value) => print("Data Inserted"));
  //   }
  // }

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
                TextField(
                  readOnly: true,
                  controller: TextEditingController(text: generateDoctorId()),
                  decoration: InputDecoration(
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
                    hintText: "Doctor ID",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: namecontrolletr,
                  decoration: InputDecoration(
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
                TextField(
                  controller: mobilenocontroller,
                  decoration: InputDecoration(
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
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: emailidcontroller,
                  decoration: InputDecoration(
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
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField<String>(
                  value: selectedSpecialist,
                  items: [
                    DropdownMenuItem(
                      child: Text("Select-specialist"),
                      value: "Select-specialist",
                    ),
                    DropdownMenuItem(
                      child: Text("Orthopedists (bones, muscles)"),
                      value: "Orthopedists (bones, muscles)",
                    ),
                    DropdownMenuItem(
                      child: Text("Ophthalmologists (eye doctors)"),
                      value: "Ophthalmologists (eye doctors)",
                    ),
                    DropdownMenuItem(
                      child: Text("Obstetricians and gynecologists (women's health, including pregnancy and childbirth)"),
                      value: "Obstetricians and gynecologists (women's health, including pregnancy and childbirth)",
                    ),
                    DropdownMenuItem(
                      child: Text("Neurologists (nervous system)"),
                      value: "Neurologists (nervous system)",
                    ),
                    DropdownMenuItem(
                      child: Text("Gastroenterologists (digestive system)"),
                      value: "Gastroenterologists (digestive system)",
                    ),
                    DropdownMenuItem(
                      child: Text("Endocrinologists (endocrine system)"),
                      value: "Endocrinologists (endocrine system)",
                    ),
                    DropdownMenuItem(
                      child: Text("Dermatologists (skin)"),
                      value: "Dermatologists (skin)",
                    ),
                    // Include other DropdownMenuItem widgets as needed...
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedSpecialist = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Specialist',
                    prefixIcon: Icon(
                      Icons.local_hospital_outlined,
                      color: Color.fromARGB(220, 59, 206, 255),
                    ),
                    border: OutlineInputBorder(),
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
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || value == 'Select-specialist') {
                      return 'Please select a specialist';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: hospitalcontroller,
                  decoration: InputDecoration(
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
                      color: Colors.purpleAccent,
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

                    final user = usermodel(
                        mobile: mobilenocontroller.text.trim(),
                        name: namecontrolletr.text.trim(),
                        gender: gender,
                        specialist: selectedSpecialist,
                        hospital: hospitalcontroller.text.trim(),
                        email: emailidcontroller.text.trim(),
                        imagePath: ''
                    );

                    createuser(user);

                    //       controller.uploadImageToFirebase();
                    //adddatatofirebase(namecontrolletr.text.toString(), gendercontroller.text.toString(), mobilenocontroller.text.toString(), emailidcontroller.text.toString(), specialistcontroller.text.toString(), hospitalcontroller.text.toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NavigationMenu()),
                    );
                  },

                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}