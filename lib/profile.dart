import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'navigation.dart';

class profile extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: 100,
                    width: 100,
                    child: ClipOval(
                        child: Image.asset("assets/images/admin.jpg"))
                ),
                const Text("Edit Photo", style: TextStyle(
                  fontSize: 15,
                  color: Colors.blue,
                ),
                ),
                SizedBox(
                  height: 20,
                ),
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
                    hintText: "Name",
                  ),
                ),
                SizedBox(height: 10,),
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
                    hintText: "Gender",
                  ),
                ),
                SizedBox(height: 10,),
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
                ),
                SizedBox(height: 10,),
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
                    hintText: "Email Id",
                  ),
                ),
                SizedBox(height: 10,),
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
                    hintText: "Specialist",
                  ),
                ),
                SizedBox(height: 10,),
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
                    hintText: "Hospital",
                  ),
                ),
                SizedBox(height: 10,),
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
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>  NavigationMenu()),);
                  },
                ),
              ],

            ),
          ),
        ),
      ),
    );
  }
}