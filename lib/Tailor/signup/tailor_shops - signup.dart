import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:threadhub_system/Pages/home_page.dart';
import 'package:threadhub_system/Tailor/pages/tailorhomepage.dart';
import 'package:threadhub_system/Tailor/signup/terms&conditions.dart';
import 'package:threadhub_system/Tailor/signup/upload_media.dart';

class TailorSignUpPage extends StatefulWidget {
  final String role;
  final bool acceptedTerms;

  const TailorSignUpPage({
    super.key,
    required this.role,
    this.acceptedTerms = false,
  });

  @override
  State<TailorSignUpPage> createState() => _TailorSignUpPageState();
}

class _TailorSignUpPageState extends State<TailorSignUpPage> {
  bool _businessPermitError = false;
  List<UploadFile>? _businessPermitFiles;

  //Error States of textfields
  bool _shopNamer = false;
  bool _username = false;
  bool _ownerName = false;
  bool _businessNumber = false;
  bool _address = false;
  final bool _numEmployee = false;
  bool _password = false;
  bool _confirmPass = false;

  //TextFields
  final bool _validate = false;
  final TextEditingController _shopnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _businessNumberController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _numberEmployeesController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

  //Remember Me
  bool _rememberMe = false;
  @override
  void initState() {
    super.initState();
    _rememberMe = widget.acceptedTerms;
  }

  Future<void> signUp() async {
    setState(() {
      _shopNamer = _shopnameController.text.trim().isEmpty;
      _username = _usernameController.text.trim().isEmpty;
      _ownerName = _ownerNameController.text.trim().isEmpty;
      _businessNumber = _businessNumberController.text.trim().isEmpty;
      _address = _addressController.text.trim().isEmpty;
      _password = _passwordController.text.trim().isEmpty;
      _confirmPass = _confirmpasswordController.text.trim().isEmpty;
    });

    if (_shopNamer ||
        _username ||
        _ownerName ||
        _businessNumber ||
        _address ||
        _password ||
        _confirmPass) {
      return;
    }

    if (!_rememberMe) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Terms & Conditions'),
          content: Text(
            'You must agree to the terms and conditions to continue.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    if (_passwordController.text.trim() !=
        _confirmpasswordController.text.trim()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Passwords do not match.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
      return;
    }

    String email = _emailController.text.trim();
    if (email.isEmpty) {
      email =
          '${_usernameController.text.trim().toLowerCase()}_${DateTime.now().millisecondsSinceEpoch}@example.com';
    }

    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: email,
          password: _passwordController.text.trim(),
        );

    final user = userCredential.user;

    if (user != null) {
      final supabase = Supabase.instance.client;
      List<String> permitUrls = [];

      if (_businessPermitFiles != null && _businessPermitFiles!.isNotEmpty) {
        for (final file in _businessPermitFiles!) {
          final filePath = file.file.path;

          if (filePath == null) {
            continue;
          }

          final fileName = filePath.split('/').last;
          final path = 'Permits/$fileName';

          await supabase.storage.from('Tailor').upload(path, File(filePath));
          final publicUrl = supabase.storage.from('Tailor').getPublicUrl(path);
          permitUrls.add(publicUrl);
        }
      }

      await FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
        'role': 'Tailor',
        'shopName': _shopnameController.text.trim(),
        'username': _usernameController.text.trim().toLowerCase(),
        'ownerName': _ownerNameController.text.trim(),
        'businessNumber': '+63${_businessNumberController.text.trim()}',
        'email': email,
        'address': _addressController.text.trim(),
        'numberEmployees':
            int.tryParse(_numberEmployeesController.text.trim()) ?? 0,
        'businessPermits': permitUrls,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TailorHomePage()),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign up successful! Welcome to ThreadHub 🎉'),
            backgroundColor: Colors.blueGrey,
            duration: Duration(seconds: 6),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _shopnameController.dispose();
    _usernameController.dispose();
    _ownerNameController.dispose();
    _businessNumberController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _numberEmployeesController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: Text(
          'Create Account Now!',
          style: GoogleFonts.jockeyOne(
            fontSize: 30,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF6082B6),
      ),
      backgroundColor: const Color(0xFFD9D9D9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Shop Name
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Shop Name',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: _shopnameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFE1EBEE),
                        labelText: 'Enter your shop name',
                        errorText: _shopNamer ? 'Shop name is required' : null,
                        contentPadding: EdgeInsets.fromLTRB(18, 22, 48, 2),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.5,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Username
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Username',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color(0xFFE1EBEE),
                        labelText: 'Enter your desired username',
                        errorText: _username ? 'Username is required' : null,
                        contentPadding: EdgeInsets.fromLTRB(18, 22, 48, 2),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.5,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Owner Name
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Owner Name',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: _ownerNameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color(0xFFE1EBEE),
                        labelText: 'Enter the Owners Name',
                        errorText: _ownerName
                            ? 'Owner\'s name is required'
                            : null,
                        contentPadding: EdgeInsets.fromLTRB(18, 22, 48, 2),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.5,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Business Number
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Business Phone Number',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: _businessNumberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color(0xFFE1EBEE),
                        labelText: 'eg. +63 9123456789',
                        prefixText: '+63 ',
                        errorText: _businessNumber
                            ? 'Business number is required'
                            : null,
                        contentPadding: EdgeInsets.fromLTRB(18, 22, 48, 2),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.5,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Email
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color(0xFFE1EBEE),
                        labelText: 'Optional',
                        contentPadding: EdgeInsets.fromLTRB(18, 22, 48, 2),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.5,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Address
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Address',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: _addressController,
                      maxLines: 4,
                      textAlign: TextAlign.left,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFE1EBEE),
                        labelText: 'Enter your business address',
                        errorText: _address ? 'Address is required' : null,
                        alignLabelWithHint: true,
                        contentPadding: EdgeInsets.all(18),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.5,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Business Permit - photo media upload
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Business Permit',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () async {
                        final uploadedFiles = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UploadMediaPage(
                              initialFiles: _businessPermitFiles,
                            ),
                          ),
                        );

                        if (uploadedFiles != null) {
                          setState(() {
                            _businessPermitFiles = uploadedFiles;
                            _businessPermitError = false;
                          });
                        }
                      },

                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE1EBEE),
                          border: Border.all(
                            color: _businessPermitError
                                ? Colors.red
                                : Colors.black,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          _businessPermitFiles != null &&
                                  _businessPermitFiles!.isNotEmpty
                              ? "${_businessPermitFiles?.length} file(s) uploaded"
                              : "Click To Upload Media",
                          style: TextStyle(
                            fontSize: 16,
                            color: _businessPermitError
                                ? Colors.red
                                : Colors.grey[700],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Number of Employees
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Number of Employees',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: _numberEmployeesController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: const Color(0xFFE1EBEE),
                        labelText:
                            'Enter the number of person operates the business',
                        errorText: _numEmployee
                            ? 'Number of Employee is required'
                            : null,
                        contentPadding: EdgeInsets.fromLTRB(18, 22, 48, 2),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.5,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              // Password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(),
                      child: TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: const Color(0xFFE1EBEE),
                          labelText: 'Create password',
                          errorText: _password
                              ? 'Creating a password is required'
                              : null,
                          contentPadding: EdgeInsets.fromLTRB(18, 22, 44, 2),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2.5,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15),
              //Confirm Password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Confirm Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(),
                      child: TextField(
                        controller: _confirmpasswordController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: const Color(0xFFE1EBEE),
                          labelText: 'Re-enter password',
                          errorText: _confirmPass
                              ? 'Confirm Password is required'
                              : null,
                          contentPadding: EdgeInsets.fromLTRB(18, 22, 44, 2),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2.5,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Terms & Conditions Checkbox
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (bool? value) {
                        setState(() {
                          _rememberMe = value ?? false;
                        });
                      },
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final accepted = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const TermsAndConditionsPage(),
                            ),
                          );
                          if (accepted == true) {
                            if (mounted) {
                              setState(() {
                                _rememberMe = true;
                              });
                            }
                          }
                        },
                        child: Text(
                          'I agree to the Terms and Conditions',
                          style: GoogleFonts.chivo(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Sign Up Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: GestureDetector(
                  onTap: () async {
                    await signUp();
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4A789E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.chakraPetch(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),

              // Redirect to Login Screen
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF335E7A),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Have an Account? Sign In',
                        style: GoogleFonts.chakraPetch(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
