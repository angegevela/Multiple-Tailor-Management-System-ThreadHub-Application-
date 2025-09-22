import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:threadhub_system/Customer/pages/Measurement%20Method/measurement_history.dart';
import 'package:threadhub_system/Customer/pages/help.dart';

class ManualMeasurement extends StatefulWidget {
  const ManualMeasurement({super.key});

  @override
  State<ManualMeasurement> createState() => _ManualMeasurementState();
}

class _ManualMeasurementState extends State<ManualMeasurement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF262633),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Center(
                child: Text(
                  "Three-Dimensional Measurement",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 400,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      "3D Model Placeholder",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Top Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      side: BorderSide(color: Colors.black, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      textStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    child: Text("Previous"),
                  ),
                  Text(
                    "Back Shoulder",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      side: BorderSide(color: Colors.black, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      textStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    child: Text("Next"),
                  ),
                ],
              ),

              SizedBox(height: 10),

              // Middle Row
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Enter value",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                      ),
                      hint: Text(
                        "PICK A MEASUREMENT TYPE",
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                        ),
                      ),

                      items: ["Inches", "Centimeters", "Meter"]
                          .map(
                            (type) => DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),
              // Bottom Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Save Button
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        textStyle: GoogleFonts.lisuBosa(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      child: Text("Save"),
                    ),
                  ),

                  SizedBox(width: 12),

                  // Remove All Button
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        textStyle: GoogleFonts.lisuBosa(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      child: Text("Remove All"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.topRight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomerHelpPage(),
                          ),
                        );
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 1.5),
                        ),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: const Color(0xFF7E99A3),
                          child: Icon(
                            Icons.menu_book,
                            size: 20,
                            color: const Color(0xFF292D32),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        // Avoid navigating to same screen
                        if (ModalRoute.of(context)?.settings.name !=
                            '/ProductMeasurementHistory') {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductMeasurementHistory(),
                            ),
                          );
                        }
                      },

                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 1.5),
                        ),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: const Color(0xFF7E99A3),
                          child: Icon(
                            Icons.bookmark_border_rounded,
                            size: 20,
                            color: const Color(0xFF292D32),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.topLeft,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        5,
                      ), // square-ish corners
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    textStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Cancel", style: GoogleFonts.lisuBosa(fontSize: 17)),
                      SizedBox(width: 25),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Icon(Icons.close, color: Colors.black, size: 15),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
