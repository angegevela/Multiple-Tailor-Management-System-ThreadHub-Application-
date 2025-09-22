import 'package:flutter/material.dart';

class Facebiometrics extends StatefulWidget {
  const Facebiometrics({super.key});

  @override
  State<Facebiometrics> createState() => _FacebiometricsState();
}

class _FacebiometricsState extends State<Facebiometrics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF262633),
        iconTheme: IconThemeData(color: Colors.white),
      ),
    );
  }
}
