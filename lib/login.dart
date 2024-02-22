import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthifyd/home.dart';
import 'package:healthifyd/otpscreen.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'navigation.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({Key? key}) : super(key: key);

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  late String _phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(246, 138, 246, 255),
                  Color.fromARGB(246, 105, 185, 207),
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 22),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 22,bottom: 450),
                    child: Text(
                      "Welcome Back !!,\nSign In",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                   child: Padding(
                      padding: EdgeInsets.only(
                          right: 150,bottom: 450),
                    child: Lottie.asset('assets/animate/logind_1.json',
                        fit: BoxFit.cover, height: 150, width: 150),
                    )
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 250
                ),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 8, right: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IntlPhoneField(
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.lightBlue,
                            ),
                          ),
                        ),
                        initialCountryCode: 'IN',
                        onChanged: (phone) {
                          _phoneNumber = phone.completeNumber ?? '';
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color.fromARGB(246, 138, 246, 255),
                                Color.fromARGB(246, 207, 88, 80),
                                Color.fromARGB(246, 105, 185, 207),
                              ]),
                              borderRadius: BorderRadius.circular(37),
                            ),
                            child: const Text(
                              "Continue",
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          onPressed: () async {
                            try {
                              await FirebaseAuth.instance.verifyPhoneNumber(
                                verificationCompleted:
                                    (PhoneAuthCredential credential) {},
                                verificationFailed:
                                    (FirebaseAuthException ex) {},
                                codeSent:
                                    (String verificationId, int? resendtoken) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => otpscreen(
                                          verificationid: verificationId),
                                    ),
                                  );
                                },
                                codeAutoRetrievalTimeout:
                                    (String verificationID) {},
                                phoneNumber: _phoneNumber,
                              );
                            } catch (e) {
                              log(e.toString());
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
