import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:threadhub_system/Customer/pages/font_provider.dart';

class RatingandReviewPage extends StatefulWidget {
  const RatingandReviewPage({super.key});

  @override
  State<RatingandReviewPage> createState() => _RatingandReviewPageState();
}

class _RatingandReviewPageState extends State<RatingandReviewPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final double _rating = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fontSize = context.watch<FontProvider>().fontSize;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF262633),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFFD9D9D9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Profile Info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        child: Image.asset(
                          "assets/img/Seb.jpg",
                          width: 120,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Section Header
                          Container(
                            width: 190,
                            height: 30,
                            color: const Color(0xFFC4C4C4),
                            alignment: Alignment.center,
                            child: Text(
                              'Personal Information',
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Info box
                          Container(
                            width: 190,
                            padding: const EdgeInsets.all(10),
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name: Giana Gabrielo",
                                  style: GoogleFonts.montserrat(
                                    color: const Color(0xFF4F607A),
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Phone: +9876543210",
                                  style: GoogleFonts.montserrat(
                                    color: const Color(0xFF4F607A),
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  "Email: gianaGab@gmail.com",
                                  style: GoogleFonts.montserrat(
                                    color: const Color(0xFF4F607A),
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Availability
                          Container(
                            width: 190,
                            height: 30,
                            color: const Color(0xFFC4C4C4),
                            alignment: Alignment.center,
                            child: Text(
                              'Availability',
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: 190,
                            padding: const EdgeInsets.all(10),
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    "Tue–Fri, Sun",
                                    style: GoogleFonts.montserrat(
                                      color: const Color(0xFF4F607A),
                                      fontSize: fontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Center(
                                  child: Text(
                                    "7:30–9:00 PM",
                                    style: GoogleFonts.montserrat(
                                      color: const Color(0xFF4F607A),
                                      fontSize: fontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Expertise & Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Expertise
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            height: 30,
                            color: const Color(0xFFC4C4C4),
                            alignment: Alignment.center,
                            child: Text(
                              'Expertise',
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: 150,
                            padding: const EdgeInsets.all(10),
                            color: Colors.white,
                            child: Text(
                              "Custom Design",
                              style: GoogleFonts.montserrat(
                                color: const Color(0xFF4F607A),
                                fontWeight: FontWeight.bold,
                                fontSize: fontSize,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 10),

                      // Status
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            height: 30,
                            color: const Color(0xFFC4C4C4),
                            alignment: Alignment.center,
                            child: Text(
                              'Status',
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: 150,
                            padding: const EdgeInsets.all(10),
                            color: Colors.white,
                            child: Text(
                              "Available",
                              style: GoogleFonts.montserrat(
                                color: const Color(0xFF4F607A),
                                fontWeight: FontWeight.bold,
                                fontSize: fontSize,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Location
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 30,
                        color: const Color(0xFFC4C4C4),
                        alignment: Alignment.center,
                        child: Text(
                          'Location',
                          style: GoogleFonts.montserrat(
                            color: const Color(0xFF00796B), // teal-ish color
                            // fontSize: 15,
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Address box
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8ECF5),
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: Text(
                          "Quezon Street Extension Palawan, Puerto Princesa 5300",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            color: const Color(0xFF4F607A),
                            fontWeight: FontWeight.bold,
                            // fontSize: 13,
                            fontSize: fontSize,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Google Maps Button
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8ECF5),
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "See in Google Maps",
                                style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  // fontSize: 12,
                                  fontSize: fontSize,
                                ),
                              ),
                              const SizedBox(width: 20),
                              const Icon(
                                Icons.arrow_right,
                                size: 20,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            //Tabs
            Container(
              height: 35,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFF6082B6),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.white,
                dividerColor: Colors.transparent,
                tabs: [
                  Tab(
                    child: Text(
                      'Reviews',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Portfolio',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //Tab Contents of Review + Portfolio
            SizedBox(
              height: 450,
              child: TabBarView(
                controller: _tabController,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 250,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                elevation: 4,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                child: Container(
                                  width: 300,
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Excellent ${index + 1}",
                                        style: GoogleFonts.montserrat(
                                          // fontSize: 22,
                                          fontSize: fontSize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      RatingBarIndicator(
                                        rating: 5,
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.green,
                                        ),
                                        itemCount: 5,
                                        itemSize: 28,
                                      ),
                                      const SizedBox(height: 10),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            const TextSpan(text: "Based on "),
                                            TextSpan(
                                              text: "${456 + index} Reviews",
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.bold,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                          ],
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.green,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'ThreadHub',
                                            style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w500,
                                              // fontSize: 16,
                                              fontSize: fontSize,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF261E27),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 70,
                              vertical: 18,
                            ),
                          ),
                          onPressed: () {
                            // Submit logic
                          },
                          child: Text(
                            "Write A Review",
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigate to another screen
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         TailorCustomerSeeMore(), // Replace with your screen
                              //   ),
                              // );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Colors.black,
                                  width: 1.5,
                                ),
                              ),
                              elevation: 4,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'SEE MORE',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontSize: fontSize,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.arrow_downward,
                                  size: 18,
                                  weight: 700,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Portfolio
                  Center(
                    child: Text(
                      'Portfolio Content Coming Soon',
                      style: GoogleFonts.montserrat(
                        // fontSize: 18,
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
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
