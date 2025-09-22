import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminNotification extends StatefulWidget {
  const AdminNotification({super.key});

  @override
  State<AdminNotification> createState() => _AdminNotificationState();
}

class _AdminNotificationState extends State<AdminNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color(0xFF262633),
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Notifications',
            textAlign: TextAlign.right,
            style: GoogleFonts.chauPhilomeneOne(
              color: Colors.white,
              fontSize: 27,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFEEEEEE),
      body: const Center(child: Text('Appointment Page')),
    );
  }
}
