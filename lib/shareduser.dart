import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:healthifyd/home.dart';
import 'package:healthifyd/login.dart';

class shareduser extends GetxController{
  static shareduser get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseuser;

  @override
  void onReady() {
    firebaseuser = Rx<User?>(_auth.currentUser);
    firebaseuser.bindStream(_auth.userChanges());
    ever(firebaseuser, _setIntialscreen);
  }

    _setIntialscreen(User? user){
      user == null ? Get.offAll(()=> const loginscreen()) : Get.offAll(()=>  home());
    }
}