import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  // Email Disposal
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6082B6),
        title: Text(
          'Forgot Password',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                'Please Enter Your Email to Reset the Password',
                style: GoogleFonts.inter(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Email TextField
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                    ? 'Enter a valid email'
                    : null,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(18, 22, 48, 20),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 2.5,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Input Your Email',
                  hintText: 'info@example.com',
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            MaterialButton(
              onPressed: () {
                // Reset Logic Navigation
                resetPassword();
              },
              color: Colors.blueGrey,
              textColor: Colors.white,
              elevation: 4,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Reset Password',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> resetPassword() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final email = _emailController.text.trim();

      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent')),
      );

      // Close all dialogs and go to the first route
      Navigator.of(
        context,
        rootNavigator: true,
      ).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print('Password reset error: $e');

      Navigator.of(
        context,
        rootNavigator: true,
      ).pop(); //Dismissal of the dialog once it exit
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? 'An error occurred')));
    }
  }
}
