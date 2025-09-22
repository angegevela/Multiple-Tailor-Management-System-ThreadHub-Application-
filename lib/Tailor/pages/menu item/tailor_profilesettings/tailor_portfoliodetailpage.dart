import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:threadhub_system/Tailor/pages/menu%20item/tailor_profilesettings/tailor_fontprovider.dart';
class TailorPortfolioDetailPage extends StatelessWidget {
  final String title;
  final String image;
  final int index;
  final int totalindex;

  const TailorPortfolioDetailPage({
    super.key,
    required this.title,
    required this.image,
    this.index = 0,
    this.totalindex = 1,
  });

  @override
  Widget build(BuildContext context) {
    final tailorfontSize = context.watch<TailorFontprovider>().fontSize;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF262633),
      ),
      backgroundColor: const Color(0xFFD9D9D9),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 45,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img/flowerbackground.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Stack(
                    children: [
                      Text(
                        'Portfolio',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.chauPhilomeneOne(
                          fontSize: 24,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 4
                            ..color = Colors.black,
                          letterSpacing: 15,
                        ),
                      ),

                      Text(
                        'Portfolio',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.chauPhilomeneOne(
                          fontSize: 24,
                          color: const Color(0xFF68D2E8).withOpacity(0.8),
                          letterSpacing: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (index > 0) const Icon(Icons.arrow_back, size: 40),

                ClipRRect(
                  child: Image.asset(image, fit: BoxFit.contain, height: 285),
                ),

                if (index < totalindex - 1)
                  const Icon(Icons.arrow_forward, size: 40),
              ],
            ),

            const SizedBox(height: 20),

            // Title and divider
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.chauPhilomeneOne(
                      fontSize: tailorfontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 2,
                    indent: 20,
                    endIndent: 20,
                  ),
                ],
              ),
            ),

            // Description Box
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Text(
                  'Showcasing a blend of traditional textiles with modern silhouettes, this collection highlights cultural craftsmanship and contemporary aesthetics.',
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.cormorantInfant(
                    fontSize: tailorfontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
