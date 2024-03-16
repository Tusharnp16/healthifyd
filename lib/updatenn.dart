import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:healthifyd/Userrepository.dart';

import 'package:healthifyd/login.dart';
import 'package:healthifyd/shareduser.dart';
import 'package:healthifyd/usermodel.dart';
import 'package:healthifyd/util.dart';
import 'package:image_picker/image_picker.dart';

import 'navigation.dart';

class update extends StatefulWidget {
  @override
  State<update> createState() => _update();
}

class _update extends State<update> {
  final _auth = FirebaseAuth.instance;
  final UserRepository userRepo=new UserRepository();


   getuserdata() {
     const mobileno = "7984569840";
      if (mobileno != null) {
        userRepo.getuserdetailes(mobileno);
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
            child: FutureBuilder(
              future: getuserdata(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    usermodel model = snapshot.data as usermodel;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(() {
                          return Container(
                              height: 100,
                              width: 100,
                              child: controller.image.value.path == ''
                                  ? ClipOval(
                                      child: Image.asset(
                                          "assets/images/admin.jpg"))
                                  : ClipOval(
                                      child: Image.network(
                                          controller.image.value.path),
                                    ));
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
                        TextFormField(
                          initialValue: model.name,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            prefixIcon: Icon(
                              Icons.person_2_rounded,
                              color: Colors.purple,
                            ),
                            hintText: "Name",
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: model.gender,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            prefixIcon: Icon(
                              Icons.person_2_rounded,
                              color: Colors.purple,
                            ),
                            hintText: "Gender",
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: model.mobile,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            prefixIcon: Icon(
                              Icons.person_2_rounded,
                              color: Colors.purple,
                            ),
                            hintText: "Mobile No",
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: model.email,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            prefixIcon: Icon(
                              Icons.person_2_rounded,
                              color: Colors.purple,
                            ),
                            hintText: "Email Id",
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: model.specialist,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            prefixIcon: Icon(
                              Icons.person_2_rounded,
                              color: Colors.purple,
                            ),
                            hintText: "Specialist",
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: model.hospital,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            prefixIcon: Icon(
                              Icons.person_2_rounded,
                              color: Colors.purple,
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NavigationMenu()),
                            );
                          },
                        ),
                      ],
                    );
                  }else if(snapshot.hasError){
                    return  Center(child : Text(snapshot.error.toString()));

                  }
                } else {
                  return const Center(
                    child: Center(child: Text(
                         "Look Like error has been occured"),),
                  );
                }
                return Divider();
              },
            ),
          ),
        ),
      ),
    );
  }
}
