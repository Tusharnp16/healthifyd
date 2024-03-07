import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:healthifyd/util.dart';
import 'package:image_picker/image_picker.dart';

import 'navigation.dart';

class profile extends StatefulWidget {
  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  TextEditingController nameController = TextEditingController();
  String gender = ''; // Store the selected gender
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController specialistController = TextEditingController();
  TextEditingController hospitalController = TextEditingController();

  addDataToFirebase(String name, String gender, String mobile, String email,
      String specialist, String hospital) async {
    if (name == "" ||
        gender == "" ||
        mobile == "" ||
        email == "" ||
        specialist == "" ||
        hospital == "") {
      log("Field is Empty");
    } else {
      FirebaseFirestore.instance.collection("Users").doc(mobile).set({
        "Name": name,
        "Gender": gender,
        "Mobile": mobile,
        "Email": email,
        "Specialist": specialist,
        "Hospital": hospital
      }).then((value) => log("Data Inserted"));
    }
  }

  final controller = Get.put(ImagePickerController());

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
                Obx(() {
                  return Container(
                    height: 100,
                    width: 100,
                    child: controller.image.value.path == ''
                        ? ClipOval(
                            child: Image.asset("assets/images/admin.jpg"),
                          )
                        : ClipOval(
                            child: Image.network(
                              controller.image.value.path,
                            ),
                          ),
                  );
                }),
                GestureDetector(
                  child: const Text(
                    "Edit Photo",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                    ),
                  ),
                  onTap: () {
                    controller.pickimage();
                  },
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Gender",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
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
                        ),
                        Text('Male'),
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
                        ),
                        Text('Female'),
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
                        ),
                        Text('Other'),
                      ],
                    ),
                  ],
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
                      color:Color.fromARGB(220, 59, 206, 255),
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
