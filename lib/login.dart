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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(240, 37, 166, 255),
              Color.fromARGB(240, 18, 103, 122),
              // Color.fromARGB(240, 27, 124, 196),
              // Color.fromARGB(240, 22, 95, 141),
              // Color.fromARGB(246, 105, 185, 207),


            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(children: [
            Padding(padding: EdgeInsets.only(left:50)),
            Text(
              "Welcome Back !!,\nSign In",
              style: TextStyle(
                fontSize: 30,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40
            ),
            Lottie.asset(
              'assets/animate/logind.json',
              fit: BoxFit.cover,
              height:300,
              width: 250,
            ),
            ],),
            SizedBox(height: 50), // Adjust spacing
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
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
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            await FirebaseAuth.instance.verifyPhoneNumber(
                              verificationCompleted:
                                  (PhoneAuthCredential credential) {},
                              verificationFailed:
                                  (FirebaseAuthException ex) {},
                              codeSent: (String verificationId, int? resendtoken) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => otpscreen(
                                        verificationid: verificationId),
                                  ),
                                );
                              },
                              codeAutoRetrievalTimeout: (String verificationID) {},
                              phoneNumber: _phoneNumber,
                            );
                          } catch (e) {
                            log(e.toString());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(246, 138, 246, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(37),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            "Continue",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
