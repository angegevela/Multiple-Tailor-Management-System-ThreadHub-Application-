import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:threadhub_system/Admin/login/admin_homepage.dart';
import 'package:threadhub_system/Admin/login/tc_admin.dart';
import 'package:threadhub_system/Pages/forgot_pw_page1.dart';


class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void _signInAdmin(BuildContext context) async {
    final enteredId = idController.text.trim();
    final enteredPassword = passwordController.text.trim();

    if (enteredId.isEmpty || enteredPassword.isEmpty) {
      _showError("Please fill in all fields.");
      return;
    }

    setState(() => isLoading = true);

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('admins')
          .where('adminid', isEqualTo: enteredId)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        _showError("Admin ID not found.");
        return;
      }

      final data = querySnapshot.docs.first.data();
      final storedPassword = data['password'];

      if (enteredPassword != storedPassword) {
        _showError("Incorrect password.");
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return AdminHomePage();
            }, // to email flow
          ),
        );
      }
    } catch (e) {
      _showError("An error occurred: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  //Remember Me - Checklist
  bool _rememberMe = false;

  //Password hide - Icon/Transition
  bool passwordVisible = false;

  //Terms and Conditions - Checklist Logic
  bool _agreeToTerms = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      body: Container(
        color: const Color(0xFF31507F),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Stack(
              children: [
                // Background image
                Positioned.fill(
                  child: Opacity(
                    opacity: 1.0,
                    child: Image.asset(
                      'assets/img/Group 63.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 150, 20, 20),
                    child: Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(maxWidth: 500),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Please Fill In Your Unique Admin Details Below",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black45,
                            ),
                          ),

                          const SizedBox(height: 40),

                          //Administration Identification - UI
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Administrator Identification",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black45,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: idController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 22,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 1.5),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black54,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          //Password
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Password",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black45,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: passwordController,
                            obscureText: !passwordVisible,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              labelText: 'Password',
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 22,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 1.5),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black54,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),
                          //Remember Me and Forgot Password - Row
                          Row(
                            children: [
                              Transform.scale(
                                scale: 0.7,
                                child: Checkbox(
                                  value: _rememberMe,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _rememberMe = value ?? false;
                                    });
                                  },
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _rememberMe = !_rememberMe;
                                  });
                                },
                                child: const Text(
                                  'Remember Me',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              const SizedBox(width: 45),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ForgotPasswordbutton();
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 30),

                          //Sign In Button
                          GestureDetector(
                            onTap: isLoading
                                ? null
                                : () => _signInAdmin(context),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: isLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text(
                                        'Sign in',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Checkbox with Terms and Conditions navigation
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: _agreeToTerms,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _agreeToTerms = value ?? false;
                                    });
                                  },
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      // Navigate to Terms page and wait for result
                                      final accepted =
                                          await Navigator.push<bool>(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const AdminTermsCondition(),
                                            ),
                                          );

                                      // If user accepted terms, check the box
                                      if (accepted == true) {
                                        setState(() {
                                          _agreeToTerms = true;
                                        });
                                      }
                                    },
                                    child: Text(
                                      'I agree to the Terms and Conditions',
                                      style: GoogleFonts.chivo(
                                        fontSize: 10,
                                        fontStyle: FontStyle.italic,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
        ),
      ),
    );
  }
}
