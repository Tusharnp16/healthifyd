import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'navigation.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController nameController = TextEditingController();
  String gender = ''; // Store the selected gender
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController specialistController = TextEditingController();
  TextEditingController hospitalController = TextEditingController();
  String imagePath = ''; // Store the path of the selected image

  // Function to pick an image from gallery
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        imagePath = pickedImage.path!;
      });
    }
  }

  // Function to add data to Firebase
  void addDataToFirebase(String name, String gender, String mobile, String email,
      String specialist, String hospital, String imagePath) async {
    if (name.isEmpty ||
        gender.isEmpty ||
        mobile.isEmpty ||
        email.isEmpty ||
        specialist.isEmpty ||
        hospital.isEmpty ||
        imagePath.isEmpty) {
      log("Field is Empty");
    } else {
      FirebaseFirestore.instance.collection("Users").doc(mobile).set({
        "Name": name,
        "Gender": gender,
        "Mobile": mobile,
        "Email": email,
        "Specialist": specialist,
        "Hospital": hospital,
        "ProfileImage": imagePath, // Store image path in Firestore
      }).then((value) => log("Data Inserted"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  controller: nameController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Color.fromARGB(220, 59, 206, 255)),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(220, 59, 206, 255)),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
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
                  // Gender selection container
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(220, 59, 206, 255),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                  controller: mobileNoController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Color.fromARGB(220, 59, 206, 255)),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(220, 59, 206, 255)),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
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
                  controller: emailIdController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Color.fromARGB(220, 59, 206, 255)),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(220, 59, 206, 255)),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
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
                TextField(
                  controller: specialistController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Color.fromARGB(220, 59, 206, 255)),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(220, 59, 206, 255)),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    prefixIcon: Icon(
                      Icons.local_hospital,
                      color: Color.fromARGB(220, 59, 206, 255),
                    ),
                    hintText: "Specialist",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: hospitalController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Color.fromARGB(220, 59, 206, 255)),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(220, 59, 206, 255)),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
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
                    addDataToFirebase(
                      nameController.text.toString(),
                      gender,
                      mobileNoController.text.toString(),
                      emailIdController.text.toString(),
                      specialistController.text.toString(),
                      hospitalController.text.toString(),
                      imagePath,
                    );
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
