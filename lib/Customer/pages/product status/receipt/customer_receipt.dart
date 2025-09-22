import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threadhub_system/Customer/pages/font_provider.dart';

class ReceiptPage extends StatefulWidget {
  const ReceiptPage({super.key});

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  final GlobalKey _receiptKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final fontSize = context.watch<FontProvider>().fontSize;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF262633),
        title: Text(
          'Appointment Receipt',
          style: TextStyle(color: Colors.white, fontSize: fontSize),
        ),
      ),
      backgroundColor: const Color(0xFFEEEEEE),
      body: SingleChildScrollView(
        child: RepaintBoundary(
          key: _receiptKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Center(
                child: Container(
                  height: 50,
                  width: 350,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 1.7),
                  ),
                  child: Text(
                    'RECEIPT OF APPOINTMENT',
                    style: TextStyle(
                      fontFamily: 'HermeneusOne',
                      fontSize: fontSize,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 350,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 1.7),
                ),
                child: Text(
                  'This is a receipt. You can download and print this, or present the file to the tailor or tailor shop. This is proof that you have already secured an appointment. Keep this as it serves as a reservation.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontFamily: 'HermeneusOne',
                    fontSize: fontSize,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              //Appointment Details
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Appointment Details',
                  style: TextStyle(
                    fontFamily: 'HermeneusOne',
                    fontSize: fontSize,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),

              Container(
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),

                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1.5),
                      1: FlexColumnWidth(2.5),
                    },
                    border: TableBorder.symmetric(
                      inside: BorderSide(color: Colors.black12),
                    ),
                    children: [
                      buildTableRow(
                        context,
                        label: "Full Name",
                        value: "Ash Ketchum",
                        leftColor: const Color(0xFFE8F9FF),
                        rightColor: Colors.white,
                      ),
                      buildTableRow(
                        context,
                        label: "Garment Specification",
                        value: "Black gloves, Yellow backpack",
                        leftColor: const Color(0xFFE8F9FF),
                        rightColor: Colors.white,
                      ),
                      buildTableRow(
                        context,
                        label: "Service",
                        value: "Custom Design",
                        leftColor: const Color(0xFFE8F9FF),
                        rightColor: Colors.white,
                      ),
                      buildTableRow(
                        context,
                        label: "Customization Detail",
                        value:
                            "Cotton for gloves, canvas for backpack, Have a pokeball embroidery in pocket side of the backpack.",
                        leftColor: const Color(0xFFE8F9FF),
                        rightColor: Colors.white,
                      ),
                      buildTableRow(
                        context,
                        label: "Media Upload",
                        value: "backpack.png, gloves.png",
                        leftColor: const Color(0xFFE8F9FF),
                        rightColor: Colors.white,
                      ),
                      buildTableRow(
                        context,
                        label: "Address",
                        value:
                            "Purok Gumamela Wescom Road\nBarangay San Miguel, PPC",
                        leftColor: const Color(0xFFE8F9FF),
                        rightColor: Colors.white,
                      ),
                      buildTableRow(
                        context,
                        label: "Message",
                        value:
                            "Need a new set of gloves before my next tournament.",
                        leftColor: const Color(0xFFE8F9FF),
                        rightColor: Colors.white,
                      ),
                      buildTableRow(
                        context,
                        label: "Quantity",
                        value: "3",
                        leftColor: const Color(0xFFE8F9FF),
                        rightColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              //Contact Details
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Contact Details',
                  style: TextStyle(
                    fontFamily: 'HermeneusOne',
                    fontSize: fontSize,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),

              Container(
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),

                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1.5),
                      1: FlexColumnWidth(2.5),
                    },
                    border: TableBorder.symmetric(
                      inside: BorderSide(color: Colors.black12),
                    ),
                    children: [
                      buildTableRow(
                        context,
                        label: "Email(Optional)",
                        value: "ash.ketchum@gmail.com",
                        leftColor: const Color(0xFFE8F9FF),
                        rightColor: Colors.white,
                      ),
                      buildTableRow(
                        context,
                        label: "Mobile Number",
                        value: "+9876543210",
                        leftColor: const Color(0xFFE8F9FF),
                        rightColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              //Contact Details
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Deadline Details',
                  style: TextStyle(
                    fontFamily: 'HermeneusOne',
                    fontSize: fontSize,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              //Deadline Details
              Container(
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),

                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1.5),
                      1: FlexColumnWidth(2.5),
                    },
                    border: TableBorder.symmetric(
                      inside: BorderSide(color: Colors.black12),
                    ),
                    children: [
                      buildTableRow(
                        context,
                        label: "Needed By Date",
                        value: "November 31, 2024, 4:30 pm",
                        leftColor: const Color(0xFFE8F9FF),
                        rightColor: Colors.white,
                      ),
                      buildTableRow(
                        context,
                        label: "Prioritization",
                        value: "High Priority",
                        leftColor: const Color(0xFFE8F9FF),
                        rightColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              //Appointment Details
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Appointment Date and Number',
                  style: TextStyle(
                    fontFamily: 'HermeneusOne',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),

              Container(
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),

                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1.5),
                      1: FlexColumnWidth(2.5),
                    },
                    border: TableBorder.symmetric(
                      inside: BorderSide(color: Colors.black12),
                    ),
                    children: [
                      buildTableRow(
                        context,
                        label: "Appointment Date",
                        value: "November 28,2024, 3:30 pm",
                        leftColor: const Color(0xFFE8F9FF),
                        rightColor: Colors.white,
                      ),
                      buildTableRow(
                        context,
                        label: "Appoint. Number",
                        value: "1221",
                        leftColor: const Color(0xFFE8F9FF),
                        rightColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              //Tailor Assigned and Price Details
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Tailor Assigned and Price',
                  style: TextStyle(
                    fontFamily: 'HermeneusOne',
                    fontSize: fontSize,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),

              Container(
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),

                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1.5),
                      1: FlexColumnWidth(2.5),
                    },
                    border: TableBorder.symmetric(
                      inside: BorderSide(color: Colors.black12),
                    ),
                    children: [
                      buildTableRow(
                        context,
                        label: "Tailor Assigned",
                        value: "Kylie Jenner - Rizal Tailoring Shop",
                        leftColor: const Color(0xFFE8F9FF),
                        rightColor: Colors.white,
                      ),
                      buildTableRow(
                        context,
                        label: "Price",
                        value: "PHP 4,000.00",
                        leftColor: const Color(0xFFE8F9FF),
                        rightColor: Colors.white,
                      ),
                      buildTableRow(
                        context,
                        label: "Location",
                        value:
                            "Santa Monica Highway, Puerto Princesa City, Palawan",
                        leftColor: const Color(0xFFE8F9FF),
                        rightColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: null, // disables the button

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 14,
                  ),
                ),
                child: Text(
                  'Download Receipt',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

TableRow buildTableRow(
  BuildContext context, {
  required String label,
  required String value,
  Color leftColor = const Color(0xFFC4E1E6),
  Color rightColor = Colors.white,
}) {
  final fontSize = context.watch<FontProvider>().fontSize;
  Color textColor = Colors.black;

  // Handle Prioritization coloring
  if (label == "Prioritization") {
    if (value.toLowerCase().contains("low")) {
      textColor = Colors.green;
    } else if (value.toLowerCase().contains("medium")) {
      textColor = Colors.yellow[800]!;
    } else if (value.toLowerCase().contains("high")) {
      textColor = const Color(0xFF900707);
    }
  }

  // Handle Appointment Number
  if (label == "Appoint. Number") {
    textColor = const Color(0xFF008000);
  }

  // Handle Tailor Assigned
  if (label == "Tailor Assigned") {
    textColor = const Color(0xFF008000);
  }

  return TableRow(
    children: [
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.fill,
        child: Container(
          color: leftColor,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'HermeneusOne',
              fontSize: fontSize, // 👈 dynamic font size
            ),
          ),
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Container(
          color: rightColor,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontFamily: 'HermeneusOne',
              fontSize: fontSize, // 👈 dynamic font size
              color: textColor,
            ),
          ),
        ),
      ),
    ],
  );
}
