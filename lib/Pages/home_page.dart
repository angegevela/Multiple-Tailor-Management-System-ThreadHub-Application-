import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:threadhub_system/Pages/login_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser;

  final googleSignIn = GoogleSignIn();

  void signUserOut(BuildContext context) async {
    final googleSignIn = GoogleSignIn();

    try {
      // Sign out from Firebase
      await FirebaseAuth.instance.signOut();

      // Attempt to sign out from Google if applicable
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }

      // Navigate to login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(showRegisterPage: () {}),
        ),
      );
    } catch (e) {
      print('Sign out failed: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Sign out failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => signUserOut(context),
            icon: const Icon(Icons.logout),
          ),
        ],
        backgroundColor: const Color(0xFF6082B6),
      ),
      body: Center(
        child: Text(
          'LOGGED IN AS: ${user!.email}',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
