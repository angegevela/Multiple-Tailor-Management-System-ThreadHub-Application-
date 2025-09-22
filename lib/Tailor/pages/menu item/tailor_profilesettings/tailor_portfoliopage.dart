import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:threadhub_system/Tailor/pages/menu%20item/tailor_profilesettings/tailor_fontprovider.dart';
import 'package:threadhub_system/Tailor/pages/menu%20item/tailor_profilesettings/tailor_portfoliodetailpage.dart';


class TailorPortfoliopage extends StatefulWidget {
  const TailorPortfoliopage({super.key});

  @override
  State<TailorPortfoliopage> createState() => _TailorPortfoliopageState();
}

class _TailorPortfoliopageState extends State<TailorPortfoliopage> {
  final List<Map<String, String>> fashionItems = [
    {
      "image": "assets/img/dress1.png",
      "title":
          "Modern Elegance: A Fusion of Tradition and Contemporary Fashion",
    },
    {
      "image": "assets/img/up.png",
      "title": "Timeless Textiles: Reinventing Classic Attire",
    },
    {
      "image": "assets/img/dress2.png",
      "title":
          "Cultural Threads: A Celebration of Traditional and Modern Styles",
    },
    {
      "image": "assets/img/dress3.png",
      "title": "Refined Traditions: Blending Heritage with Contemporary Style",
    },
    {
      "image": "assets/img/dress5.png",
      "title": "Cultural Elegance: A Modern Take on Traditional Textiles",
    },
    {
      "image": "assets/img/dress7jpg.png",
      "title": "Timeless Craftsmanship: Bridging Tradition and Modernity",
    },
  ];
  @override
  Widget build(BuildContext context) {
    final tailorfontSize = context.watch<TailorFontprovider>().fontSize;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF262633),
      ),
      backgroundColor: const Color(0xFFD9D9D9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            Center(
              child: Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF6082B6),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Portfolio',
                        style: GoogleFonts.chauPhilomeneOne(
                          fontWeight: FontWeight.w400,
                          fontSize: 22,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 70,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 2,
                                offset: const Offset(1, 1),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/icons/hexagon_x.png',
                              width: 25,
                              height: 25,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 18,
                  mainAxisExtent: 260,
                ),

                itemCount: fashionItems.length,
                itemBuilder: (context, index) {
                  final item = fashionItems[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        child: Image.asset(
                          item["image"]!,
                          fit: BoxFit.fitWidth,
                          height: 185,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TailorPortfolioDetailPage(
                                title: item["title"]!,
                                image: item["image"]!,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 65,
                          decoration: BoxDecoration(
                            color: const Color(0xFF6082B6),
                            border: Border.all(color: Colors.black, width: 1.5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 2,
                                offset: const Offset(1, 1),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(6),
                          alignment: Alignment.center,
                          child: Text(
                            item["title"]!,
                            textAlign: TextAlign.center,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.chauPhilomeneOne(
                              fontSize: tailorfontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // action 1
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 6,
                      shadowColor: Colors.black.withOpacity(0.9),
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 20,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/icons/upload.png',
                          width: 22,
                          height: 22,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 15),
                        Text(
                          "Media Upload",
                          style: GoogleFonts.chauPhilomeneOne(
                            fontSize: tailorfontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
