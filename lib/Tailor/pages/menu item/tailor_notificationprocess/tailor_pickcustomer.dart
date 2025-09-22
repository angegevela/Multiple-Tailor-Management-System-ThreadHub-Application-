import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:threadhub_system/Tailor/pages/menu%20item/tailor_notificationprocess/tailor_customerseemore.dart';

class TailorPickCustomer extends StatefulWidget {
  const TailorPickCustomer({super.key});

  @override
  State<TailorPickCustomer> createState() => _TailorPickCustomerState();
}

class _TailorPickCustomerState extends State<TailorPickCustomer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF6082B6),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),

            // Title Bar
            Center(
              child: Container(
                height: 50,
                width: 330,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xFFB0C4DE),
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 1.5),
                  ),
                ),
                child: Text(
                  'Customer Available in the Area',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Two cards side by side
            Row(
              children: const [
                Expanded(
                  child: GarmentCard(
                    image: 'assets/img/yamato.png',
                    title: 'Garment Specification',
                    subtitle: 'Taken',
                  ),
                ),
                Expanded(
                  child: GarmentCard(
                    image: 'assets/img/natalia simpson.png',
                    title: 'Garment Specification',
                    subtitle: 'Not Yet Taken',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // Inside _TailorPickCustomerState build()
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 120, // set width manually
              child: ElevatedButton(
                onPressed: () {
                  debugPrint("Decline pressed");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C3030),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                ),
                child: Text(
                  "Decline",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 120, // Accept button slightly bigger
              child: ElevatedButton(
                onPressed: () {
                  debugPrint("Accept pressed");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF478778),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                ),
                child: Text(
                  "Accept",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GarmentCard extends StatefulWidget {
  final String image;
  final String title;
  final String subtitle;

  const GarmentCard({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  State<GarmentCard> createState() => _GarmentCardState();
}

class _GarmentCardState extends State<GarmentCard> {
  bool ispicked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: -20,
                right: -15,
                child: Checkbox(
                  value: ispicked,
                  onChanged: (val) {
                    setState(() => ispicked = val ?? false);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  activeColor: Colors.blueGrey,
                  checkColor: Colors.white,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
          // Title box
          Container(
            width: double.infinity,
            height: 50,
            color: const Color(0xFFC4C4C4),
            alignment: Alignment.center,
            child: Text(
              widget.title,
              style: GoogleFonts.poppins(
                color: const Color(0xFF25651A),
                fontWeight: FontWeight.w800,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 10),

          // Subtitle box
          Container(
            width: double.infinity,
            height: 50,
            color: const Color(0xFFC4C4C4),
            alignment: Alignment.center,
            child: Text(
              widget.subtitle == 'Taken' ? 'Taken' : 'Not yet taken',
              style: TextStyle(
                color: widget.subtitle == 'Taken'
                    ? const Color(0xFFD32828)
                    : const Color(0xFF1CAC78),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),

          const SizedBox(height: 15),

          // Button
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Navigate to another screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TailorCustomerSeeMore(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.black, width: 1.5),
                ),
                elevation: 4,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'SEE MORE',
                    style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_downward, size: 18, weight: 700),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
