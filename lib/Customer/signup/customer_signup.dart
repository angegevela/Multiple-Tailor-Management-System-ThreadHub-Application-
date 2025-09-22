import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:threadhub_system/Customer/signup/customer_homepage.dart';
import 'package:threadhub_system/Customer/signup/terms&condition_customer.dart';
import 'package:threadhub_system/Pages/home_page.dart';


class SignupRegister extends StatefulWidget {
  final String role;
  final bool acceptedTerms;

  const SignupRegister({
    super.key,
    required this.role,
    this.acceptedTerms = false, // Optional default
  });

  @override
  State<SignupRegister> createState() => _SignupRegisterState();
}

class _SignupRegisterState extends State<SignupRegister> {
  //accept terms and conditions
  late bool _isChecked;
  @override
  void initState() {
    super.initState();
    _isChecked = widget.acceptedTerms;
  }

  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _phonenumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _firstnameController.dispose();
    _surnameController.dispose();
    _phonenumberController.dispose();
    _addressController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  Future signUp() async {
    //Terms and Conditions
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

    // Authenticate user
    if (passwordConfirmed()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Add user details
        await addUserDetails(
          _firstnameController.text.trim(),
          _surnameController.text.trim(),
          _emailController.text.trim(),
          int.parse(_phonenumberController.text.trim()),
          widget.role,
          _addressController.text.trim(),
          _usernameController.text.trim(),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } on FirebaseAuthException catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Registration Error"),
            content: Text(e.message ?? "Something went wrong."),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Passwords do not match.'),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  Future addUserDetails(
    String firstName,
    String surname,
    String email,
    int phoneNumber,
    String role,
    String address,
    String username,
  ) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
        'firstName': firstName,
        'surname': surname,
        'email': email,
        'phoneNumber': phoneNumber,
        'role': role,
        'address': address,
        'username': username.toLowerCase(),
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  // Confirmed password
  bool passwordConfirmed() {
    return _passwordController.text.trim() ==
        _confirmpasswordController.text.trim();
  }

  //Remember me checkbox - i agree with terms and conditions
  bool _rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Account',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                'Create Account Now!',
                style: GoogleFonts.jockeyOne(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ],
          ),

          backgroundColor: const Color(0xFF6082B6),
        ),
        backgroundColor: Color(0xFFEEEEEE),
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                //First Name Textfield
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'First Name',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        decoration: BoxDecoration(),
                        child: TextField(
                          controller: _firstnameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: const Color(0xFFE1EBEE),
                            labelText: 'Enter your first name',
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
                      ),
                    ],
                  ),
                ),

                // Surname Textfield
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Surname',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(),
                        child: TextField(
                          controller: _surnameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: const Color(0xFFE1EBEE),
                            labelText: 'Enter your surname',
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
                      ),
                    ],
                  ),
                ),

                //Username Textfield
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Username',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(),
                        child: TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: const Color(0xFFE1EBEE),
                            labelText: 'Enter your desired username',
                            contentPadding: EdgeInsets.fromLTRB(18, 22, 48, 2),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2,
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

                //Email Textfield
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(),
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: const Color(0xFFE1EBEE),
                            labelText: 'example@email.com(Optional)',
                            contentPadding: EdgeInsets.fromLTRB(18, 22, 48, 2),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2,
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

                //Phone Number Textfield
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Phone Number',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(),
                        child: TextField(
                          controller: _phonenumberController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: const Color(0xFFE1EBEE),
                            labelText: 'e.g. +639012345678',
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
                      ),
                    ],
                  ),
                ),

                //Address Textfield
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Address',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(),
                        child: TextField(
                          controller: _addressController,
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFE1EBEE),
                            labelText: 'Enter your address',
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
                      ),
                    ],
                  ),
                ),

                //Create Password Textfield
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password',
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
                            labelText: 'Create a password',
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

                //Confirm Password Textfield
                SizedBox(height: 5),
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

                // Checkbox with Terms and Conditions navigation
                SizedBox(height: 10),
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
                            final accepted = await Navigator.push<bool>(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CustTermsAndConditionsPage(),
                              ),
                            );

                            // If user accepted terms, check the box automatically
                            if (accepted == true) {
                              setState(() {
                                _rememberMe = true;
                              });
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

                //Sign in Button Textfield
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: GestureDetector(
                    onTap: () async {
                      await signUp();
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

                const SizedBox(height: 10),

                //Redirect to Login Screen
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomerHomePage(),
                        ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
