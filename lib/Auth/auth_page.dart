// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:threadhub_system/Pages/login_page.dart';
import 'package:threadhub_system/Pages/register_page.dart';


//auth_page.dart
class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  //Firebase Authentication Instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //Firestore Instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Function To Handle

  bool showLoginPage = true;

  void toggleScreen() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(showRegisterPage: toggleScreen);
    } else {
      return RegisterPage(showLoginPage: toggleScreen);
    }
  }
}
