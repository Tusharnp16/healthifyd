import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:healthifyd/profile.dart';
import 'package:healthifyd/trsting.dart';
import 'package:healthifyd/updatenn.dart';
import 'package:healthifyd/usermodel.dart';
import 'package:healthifyd/util.dart';

import 'Userrepository.dart';
import 'navigation.dart';

class UserPagee extends StatefulWidget {

  final String userId;

  UserPagee({required this.userId});

  @override
  State<UserPagee> createState() => _UserPageeState();
}

class _UserPageeState extends State<UserPagee> {
  final userRepo = Get.put(UserRepository());

  TextEditingController namecontrolletr = TextEditingController();

  TextEditingController gendercontroller = TextEditingController();

  TextEditingController mobilenocontroller = TextEditingController();

  TextEditingController emailidcontroller = TextEditingController();

  TextEditingController specialistcontroller = TextEditingController();

  TextEditingController hospitalcontroller = TextEditingController();

  Future<void> createuser(usermodel user) async {
    await userRepo.createuser(user);
  }

  final controller = Get.put(ImagePickerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(widget.userId) // Assuming 'users' is the collection name
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Or any other loading indicator
          }

          if (!snapshot.hasData || snapshot.data!.data() == null) {
            return Text('No data found for this user.');
          }

          // Explicitly cast the data to Map<String, dynamic>
          var userData = snapshot.data!.data() as Map<String, dynamic>;

          // Access user data
          var name = userData['Name'] as String?;
          var email = userData['Email'] as String?;
          var mobile = userData['Mobile'] as String?;
          var gender = userData['Gender'] as String?;
          var specialist = userData['Specialist'] as String?;
          var hospital = userData['Mobile'] as String?;

          return SingleChildScrollView(
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
                  controller: namecontrolletr,
                  initialValue: name,
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
                  controller: gendercontroller,
                  initialValue: gender,
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
                  controller: mobilenocontroller,
                  initialValue: mobile,
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
                  controller: emailidcontroller,
                  initialValue: email,
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
                  controller: specialistcontroller,
                  initialValue: specialist,
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
                  controller: hospitalcontroller,
                  initialValue: hospital,
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

                    final user = usermodel(
                        mobile: mobilenocontroller.text.trim(),
                        name: namecontrolletr.text.trim(),
                        gender: gendercontroller.text.trim(),
                        specialist: specialistcontroller.text.trim(),
                        hospital: hospitalcontroller.text.trim(),
                        email: emailidcontroller.text.trim(),
                        imagePath: '');

                    createuser(user);

                    //       controller.uploadImageToFirebase();
                    //adddatatofirebase(namecontrolletr.text.toString(), gendercontroller.text.toString(), mobilenocontroller.text.toString(), emailidcontroller.text.toString(), specialistcontroller.text.toString(), hospitalcontroller.text.toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserPage(userId: 'Tonybhai',)),
                    );
                  },

                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
