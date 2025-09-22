import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:threadhub_system/Admin/login/admin_login.dart';
import 'package:threadhub_system/Customer/signup/customer_signup.dart';
import 'package:threadhub_system/Tailor/signup/tailor_shops%20-%20signup.dart';

// role button for three users(customer, tailor, administrator)
class User_Button extends StatelessWidget {
  final String role;
  const User_Button({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Hello, User!',
                style: GoogleFonts.jockeyOne(
                  fontSize: 44,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                'Please choose a button that suits \n you',
                textAlign: TextAlign.center,
                style: GoogleFonts.mPlusCodeLatin(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 7),

              //Customer Button Navigation
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const SignupRegister(role: 'Customer'),
                    ),
                  );
                },
                child: userTile(
                  imagePath: 'assets/img/customer.png',
                  label: 'Customer',
                ),
              ),

              const SizedBox(height: 7),

              //Tailor Button Navigation
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TailorSignUpPage(role: 'Tailor'),
                    ),
                  );
                },
                child: userTile(
                  imagePath: 'assets/img/tailor.png',
                  label: 'Tailor/Tailor Shop',
                ),
              ),

              const SizedBox(height: 7),

              //Administrator Button Navigation
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminLoginPage(),
                    ),
                  );
                },
                child: userTile(
                  imagePath:
                      'assets/img/admin 1.png',
                  label: 'Admin',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget userTile({required String imagePath, required String label}) {
    return SizedBox(
      width: 300,
      height: 190,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white70,
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.scaleDown,
              ),
              border: Border.all(width: 0, color: Colors.transparent),
              borderRadius: BorderRadius.circular(0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black45,
                  offset: Offset(5.0, 5.0),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.labrada(color: Colors.black, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
