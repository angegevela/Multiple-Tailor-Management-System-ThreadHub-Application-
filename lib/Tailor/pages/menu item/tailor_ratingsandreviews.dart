import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:threadhub_system/Tailor/pages/menu%20item/tailor_profilesettings/tailor_fontprovider.dart';

class TailorRatingsandreviewsPage extends StatefulWidget {
  const TailorRatingsandreviewsPage({super.key});

  @override
  State<TailorRatingsandreviewsPage> createState() =>
      _TailorRatingsandreviewsPageState();
}

class _TailorRatingsandreviewsPageState
    extends State<TailorRatingsandreviewsPage> {
  @override
  Widget build(BuildContext context) {
    final tailorfontSize = context.watch<TailorFontprovider>().fontSize;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: const Color(0xFF262633),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
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
    );
  }
}
