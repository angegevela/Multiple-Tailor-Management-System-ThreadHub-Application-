import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:threadhub_system/Pages/login_page.dart';
// import 'package:threadhub/admin/admin_homepage.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..forward();

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    // Navigate after delay
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,

        MaterialPageRoute(
          builder: (context) => LoginPage(showRegisterPage: () {}),
        ),
        // MaterialPageRoute(builder: (context) => CustomerHomePage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _animation,
              child: Image.asset(
                'assets/icons/threadhub-applogo.png',
                width: 250,
                height: 250,
              ),
            ),
            SizedBox(height: 20),
            FadeTransition(
              opacity: _animation,
              child: Text(
                'THREADHUB',
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(height: 10),
            FadeTransition(
              opacity: _animation,
              child: Text(
                'Crafted Connections',
                style: GoogleFonts.merriweather(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
