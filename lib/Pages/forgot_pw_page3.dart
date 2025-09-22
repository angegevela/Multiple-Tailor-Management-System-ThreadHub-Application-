import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:threadhub_system/Pages/reset_password.dart';


class ForgotPasswordverify extends StatefulWidget {
  const ForgotPasswordverify({super.key});

  @override
  State<ForgotPasswordverify> createState() => _ForgotPasswordStateverify();
}

class _ForgotPasswordStateverify extends State<ForgotPasswordverify> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _phoneController = TextEditingController();
  String _verificationId = '';
  String _otp = '';
  bool _otpSent = false;

  void _sendOTP() async {
    String phone = _phoneController.text.trim();
    if (phone.isEmpty || !phone.startsWith('+')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Enter a valid phone number with country code")),
      );
      return;
    }

    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-resolved, rarely happens
        await _auth.signInWithCredential(credential);
        _goToReset();
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Verification failed: ${e.message}")),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
          _otpSent = true;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  void _verifyOTP() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _otp,
      );
      await _auth.signInWithCredential(credential);
      _goToReset();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Invalid OTP: $e")));
    }
  }

  void _goToReset() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ResetPassword()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6082B6),
        title: Text(
          'Verify OTP',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/img/OTP.png"),
                    fit: BoxFit.fitHeight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _otpSent ? 'Enter OTP' : 'Enter Phone Number',
                  style: GoogleFonts.chivo(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              if (!_otpSent)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(18, 22, 48, 20),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 2.5,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: 'Phone Number',
                      hintText: '+91234567890',
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
              if (_otpSent)
                OtpTextField(
                  numberOfFields: 6,
                  borderColor: Color(0xFF512DA8),
                  showFieldAsBox: true,
                  onCodeChanged: (String code) {},
                  onSubmit: (String verificationCode) {
                    setState(() => _otp = verificationCode);
                    _verifyOTP();
                  },
                ),
              const SizedBox(height: 30),
              MaterialButton(
                onPressed: _otpSent ? _verifyOTP : _sendOTP,
                color: Colors.blueGrey,
                textColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _otpSent ? 'Verify OTP' : 'Send OTP',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
