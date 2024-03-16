import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthifyd/usermodel.dart';

class UserRepository extends GetxController{
  static UserRepository get instance => Get.find();

  final _db =FirebaseFirestore.instance   ;

  createuser(usermodel user) async {
  await _db.collection("Users").add(user.toJson()).whenComplete(
            () => Get.snackbar("Success","Data Updated",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.purpleAccent.withOpacity(0.1),
            colorText: Colors.black),
            )
      .catchError((error,stackTrace){
    Get.snackbar("Error","Please try again",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.black);

    print(error.toString());
  });
  }

  Future<usermodel> getuserdetailes(String mobileno)async{
    final snapshot = await _db.collection("Users").where("Mobile",isEqualTo: mobileno).get();
    final userdata = snapshot.docs.map((e) => usermodel.fromSnapshot(e)).single;
    return userdata;
  }
}