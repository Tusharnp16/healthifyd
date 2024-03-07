import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'navigation.dart';

class OTPScreen extends StatefulWidget {
  String verificationId;
  final String phoneNumber;

  OTPScreen({Key? key, required this.verificationId, required this.phoneNumber}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  List<TextEditingController> otpControllers =
  List.generate(6, (index) => TextEditingController());
  bool isLoading = false;
  int _start = 60; // 1 minute timeout for resending OTP
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
        } else {
          _timer!.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent going back to the OTP screen when using the back button
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
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
              child: const Padding(
                padding: EdgeInsets.only(top: 60.0, left: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Doctor !!,\nSign In",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.white,
                ),
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(left: 18.0, right: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Enter OTP for ${formatPhoneNumber(widget.phoneNumber)}", // Display the phone number here
                        style: TextStyle(
                          color: Color.fromARGB(255, 73, 83, 93),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          6,
                              (index) => otpBoxBuilder(context, index),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Resend OTP in $_start seconds"),
                          GestureDetector(
                            onTap: () {
                              _resendOTP();
                            },
                            child: Text(
                              "Resend OTP",
                              style: TextStyle(
                                color: Color.fromARGB(115, 97, 112, 124),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 232, 59, 234),
                              Color.fromARGB(220, 251, 137, 255),
                              Color.fromARGB(220, 137, 238, 255) ,
                              Color.fromARGB(220, 137, 238, 255), // Add your desired gradient colors here
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(37),
                        ),
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () async {
                            setState(() {
                              isLoading = true;
                            });
                            if (validateOTP()) {
                              await _verifyOTP();
                            }
                            setState(() {
                              isLoading = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            elevation: 0, // Remove button elevation
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(37),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: isLoading
                                ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.black87),
                              ),
                            )
                                : Text(
                              "Continue",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
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

  Widget otpBoxBuilder(BuildContext context, int index) {
    return SizedBox(
      width: 40,
      height: 40,
      child: TextField(
        controller: otpControllers[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: TextStyle(fontSize: 16),
        decoration: InputDecoration(
          counter: Offstage(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purpleAccent),
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: EdgeInsets.zero,
          hintText: "-",
          hintStyle: TextStyle(color: Colors.grey[400]),
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (index < 5) {
              FocusScope.of(context).nextFocus();
            } else {
              FocusScope.of(context).unfocus();
              if (validateOTP()) {
                _verifyOTP();
              }
            }
          }
        },
      ),
    );
  }

  String formatPhoneNumber(String phoneNumber) {
    // Get first three characters and remaining digits
    final firstThreeChars = phoneNumber.substring(0, 3);
    final remainingDigits = phoneNumber.substring(3);

    // Replace middle digits with asterisks
    final maskedDigits = remainingDigits.replaceRange(
        0, remainingDigits.length - 4, "******");

    return "$firstThreeChars $maskedDigits";
  }

  int _resendAttempts = 0;
  void _resendOTP() async {
    if (_resendAttempts >= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Maximum number of resend attempts reached. Please try again later.'),
        ),
      );
      return;
    }

    final shouldResend = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Resend OTP?'),
        content: Text('Are you sure you want to resend the OTP?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Resend'),
          ),
        ],
      ),
    );

    if (shouldResend ?? false) {
      try {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: widget.phoneNumber, // Use the complete verification ID
          timeout: Duration(seconds: 60),
          verificationCompleted: (PhoneAuthCredential credential) async {
            // Handle verification completion if necessary
          },
          verificationFailed: (FirebaseAuthException e) {
            log(e.message!);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to resend OTP: ${e.message!}'),
              ),
            );
          },
          codeSent: (String verificationId, int? resendToken) {
            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('OTP successfully resent!'),
              ),
            );
            // Reset the timer to 1 minute
            setState(() {
              _start = 60;
            });
            _startTimer(); // Restart the timer
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            setState(() {
              widget.verificationId = verificationId;
            });
          },
        );
        _resendAttempts++; // Increment attempts after successful resend
      } catch (e) {
        log(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred while resending OTP.'),
          ),
        );
      }
    }
  }

  bool validateOTP() {
    if (otpControllers.any((controller) => controller.text.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all OTP fields'),
        ),
      );
      return false;
    }
    return true;
  }

  Future<void> _verifyOTP() async {
    String otp = otpControllers.map((controller) => controller.text).join();
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: otp);

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => NavigationMenu()));
    } catch (e) {
      if (e is FirebaseAuthException &&
          e.message!
              .contains('The SMS verification code used to create the phone auth credential is invalid')) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invalid OTP Please try again.')));
        setState(() {
          otpControllers.forEach((controller) => controller.clear());
        });
      } else {
        log(e.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }
}
