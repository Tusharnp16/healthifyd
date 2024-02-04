import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class ImagePickerController extends GetxController{

  Rx<File> image = File('').obs;

  Future pickimage() async {

    try {
      final imagepick = await ImagePicker().pickImage(
          source: ImageSource.gallery);

      if (imagepick == null) {
        return;
      }
      final imagetemp = File(imagepick.path);
      image.value = imagetemp;
    }catch(e){
    return e;
    }

  }

}
