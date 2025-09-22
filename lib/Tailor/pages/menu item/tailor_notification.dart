import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:threadhub_system/Tailor/pages/menu%20item/tailor_notificationprocess/tailor_pickcustomer.dart';

import 'package:threadhub_system/Tailor/pages/menu%20item/tailor_profilesettings/tailor_fontprovider.dart';

class TailorNotificationPage extends StatefulWidget {
  const TailorNotificationPage({super.key});

  @override
  TailorNotificationPageState createState() => TailorNotificationPageState();
}

class TailorNotificationPageState extends State<TailorNotificationPage> {
  @override
  Widget build(BuildContext context) {
    final tailorfontSize = context.watch<TailorFontprovider>().fontSize;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: const Color(0xFF262633),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                'Notifications',
                style: GoogleFonts.chauPhilomeneOne(
                  color: Colors.white,
                  fontSize: 27,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFD9D9D9),
      body: ListView(
        children: [
          NotificationTile(
            title: "New Customer!",
            subtitle:
                "New customer has been add their appointment, see profile to check details.",
            tailorFontSize: tailorfontSize,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TailorPickCustomer(),
                ),
              );
            },
          ),

          BlackDivider(),
          NotificationTile(
            title: "Fellow tailor move some appointment!",
            subtitle:
                "New appointment were moved to your account, check details.",
            tailorFontSize: tailorfontSize,
          ),

          BlackDivider(),
        ],
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final double tailorFontSize;

  const NotificationTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.tailorFontSize,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: const Color(0xFFC6D7E5),
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 45,
              height: 45,
              child: const Icon(Icons.image, color: Colors.black54, size: 52),
            ),
            const SizedBox(width: 12),
            // Texts
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.notoSerifMyanmar(
                      fontSize: tailorFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.montserrat(
                      fontSize: tailorFontSize,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlackDivider extends StatelessWidget {
  const BlackDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(height: 1.5, color: Colors.black);
  }
}
