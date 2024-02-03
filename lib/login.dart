import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthifyd/home.dart';

import 'navigation.dart';


class loginscreen extends StatefulWidget{
  const loginscreen({Key? key}) : super(key: key);

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
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
              gradient: LinearGradient(colors: [
                Color(0xffe056fd),
                Color(0xff9402b6),
              ]),
            ),
            child: const Padding(padding: EdgeInsets.only(top:60.0, left: 22),
              child: Text("Welcome Doctor !!,\nSign In",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),),),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(padding: const EdgeInsets.only(left: 18.0,right: 18),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30,left:8,right: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          focusedBorder:OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                              borderRadius: BorderRadius.all(Radius.circular(20))),
                          prefixIcon: Icon(Icons.person_2_rounded,color: Colors.purple,),
                          hintText: "Mobile No",
                        ),
                        maxLength: 10,
                      ),
                      const SizedBox(height : 20),
                      const TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                          focusedBorder:OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                              borderRadius: BorderRadius.all(Radius.circular(20))),
                          prefixIcon: Icon(Icons.lock_open,color: Colors.purple,),
                          border: InputBorder.none,
                          hintText: "OTP",
                        ),
                      ),
                      const SizedBox(height: 30,),
                      Container(
                        child: CupertinoButton(
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
                              "Continue",
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>  const NavigationMenu()),);
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