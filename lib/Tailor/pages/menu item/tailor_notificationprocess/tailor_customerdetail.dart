import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:threadhub_system/Tailor/pages/menu%20item/tailor_profilesettings/tailor_fontprovider.dart';


class CustomerDetailPage extends StatelessWidget {
  final String name;
  final String garmentSpec;
  final String service;
  final String customization;
  final String address;
  final String phone;
  final String email;
  final String message;
  final String price;
  final String priority;
  final String appointmentDate;
  final String neededBy;

  const CustomerDetailPage({
    super.key,
    required this.name,
    required this.garmentSpec,
    required this.service,
    required this.customization,
    required this.address,
    required this.phone,
    required this.email,
    required this.message,
    required this.price,
    required this.priority,
    required this.appointmentDate,
    required this.neededBy,
  });

  @override
  Widget build(BuildContext context) {
    final tailorfontSize = context.watch<TailorFontprovider>().fontSize;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF262633),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFFD9D9D9),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pricing
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.monetization_on,
                    size: 30,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Given Price For The Product",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: tailorfontSize,
                      ),
                    ),
                  ),
                  Text(
                    "PHP $price",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: tailorfontSize,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Details
            detailRow("Full Name", name, tailorFontSize: tailorfontSize),
            detailRow(
              "Garment Specification",
              garmentSpec,
              tailorFontSize: tailorfontSize,
            ),
            detailRow("Service", service, tailorFontSize: tailorfontSize),
            detailRow(
              "Customization Detail",
              customization,
              tailorFontSize: tailorfontSize,
            ),
            detailRow("Address", address, tailorFontSize: tailorfontSize),
            detailRow("Message", message, tailorFontSize: tailorfontSize),
            detailRow("Quantity", "3", tailorFontSize: tailorfontSize),
            detailRow("Email", email, tailorFontSize: tailorfontSize),
            detailRow("Mobile Number", phone, tailorFontSize: tailorfontSize),
            detailRow(
              "Needed by Date",
              neededBy,
              tailorFontSize: tailorfontSize,
            ),
            detailRow(
              "Prioritization",
              priority,
              valueColor: priority == "High Priority"
                  ? Colors.red
                  : Colors.black,
              tailorFontSize: tailorfontSize,
            ),
            detailRow(
              "Appointment Date",
              appointmentDate,
              tailorFontSize: tailorfontSize,
            ),
          ],
        ),
      ),
    );
  }

  Widget detailRow(
    String label,
    String value, {
    Color valueColor = Colors.black,
    required double tailorFontSize,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: tailorFontSize,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(
                color: valueColor,
                fontSize: tailorFontSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
