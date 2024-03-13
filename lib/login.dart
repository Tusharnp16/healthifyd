import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthifyd/otpscreen.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';

import 'profile.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String _phoneNumber = "";

  bool _processing = false; // To control the visibility of the animation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(220, 174, 255, 255),
            Color.fromARGB(220, 137, 238, 255),
            Color.fromARGB(220, 176, 226, 255),
            Color.fromARGB(220, 59, 206, 255),
          ]),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 175, top: 1),
              child: Opacity(
                opacity: 0.5,
                child: Lottie.asset('assets/animate/logind.json',
                    fit: BoxFit.cover, height: 300, width: 200),
              ),
            ),
            SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 50, top: 150)),
                    Text(
                      "Welcome Back !!,\nSign In",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                  ],
                ),
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
                            onPressed: _processing ? null : () async {
                              setState(() {
                                _processing = true;
                              });
                              try {
                                String phoneNumber = _phoneNumber; // Store phone number before verification

                                await FirebaseAuth.instance.verifyPhoneNumber(
                                  phoneNumber: phoneNumber,
                                  verificationCompleted: (PhoneAuthCredential credential) async {
                                    // Handle verification completion if necessary
                                  },
                                  verificationFailed: (FirebaseAuthException ex) {
                                    log(ex.message ?? '');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(ex.message ?? ''),
                                      ),
                                    );
                                  },
                                  codeSent: (String verificationId, int? resendToken) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OTPScreen(
                                          verificationId: verificationId,
                                          phoneNumber: phoneNumber, // Pass the original phone number
                                        ),
                                      ),
                                    );
                                  },
                                  codeAutoRetrievalTimeout: (String verificationID) {},
                                );
                              } catch (e) {
                                log(e.toString());
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(e.toString()),
                                  ),
                                );
                              } finally {
                                setState(() {
                                  _processing = false;
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(220, 176, 226, 255),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(37),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: _processing
                                  ? SizedBox(
                                width: 35,
                                height: 35,
                                child: Lottie.asset('assets/animate/logind_1.json', height: 40),
                              )
                                  : Text(
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
          ],
        ),
      ),
    );
  }
}
