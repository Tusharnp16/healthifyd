import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:healthifyd/appoiment.dart';
import 'package:healthifyd/home.dart';
import 'package:healthifyd/login.dart';
import 'package:healthifyd/navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBdXfG0HI9WUnbf3iARa7rBA8IXjyjcV1M",
      appId: "1:237419669384:android:592966f7f0621bdc4ebc3d",
      messagingSenderId: "237419669384",
      projectId: "healthify-7e48b",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: loginscreen(),
    );
  }
}
