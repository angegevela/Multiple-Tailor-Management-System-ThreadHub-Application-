import 'package:flutter/material.dart';

class TailorFacebiometrics extends StatefulWidget {
  const TailorFacebiometrics({super.key});

  @override
  State<TailorFacebiometrics> createState() => _TailorFacebiometricsState();
}

class _TailorFacebiometricsState extends State<TailorFacebiometrics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF262633),
        iconTheme: IconThemeData(color: Colors.white),
      ),
    );
  }
}
