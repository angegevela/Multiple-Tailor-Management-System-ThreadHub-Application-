import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportDetailPage extends StatefulWidget {
  final Map<String, dynamic> report;
  const ReportDetailPage({super.key, required this.report});

  @override
  State<ReportDetailPage> createState() => _ReportDetailPageState();
}

class _ReportDetailPageState extends State<ReportDetailPage> {
  bool showExtraButtons = false;

  Color getStatusColor(String status) {
    switch (status) {
      case "No Action Yet":
        return Colors.red;
      case "Pending Approval":
        return Colors.orange;
      case "Completed":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = getStatusColor(widget.report["status"] ?? "Unknown");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.report["title"] ?? "Report Detail"),
        backgroundColor: const Color(0xFF6082B6),
      ),
      backgroundColor: const Color(0xFFD9D9D9),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 50,
                width: 330,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.zero,
                ),
                child: Text(
                  'Information Report',
                  style: GoogleFonts.robotoMono(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Reportent Name",
              style: GoogleFonts.sometypeMono(fontWeight: FontWeight.w900),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey[200], // background for the badge
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: Text(
                widget.report["subtitle"] ?? "No subtitle",
                style: GoogleFonts.robotoMono(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Reportee's Name",
              style: GoogleFonts.sometypeMono(fontWeight: FontWeight.w900),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: Text(
                widget.report["details"] ?? "No details provided.",
                style: GoogleFonts.robotoMono(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Report Description",
              style: GoogleFonts.sometypeMono(fontWeight: FontWeight.w900),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: Text(
                "Status: ${widget.report["status"] ?? "Unknown"}",
                style: GoogleFonts.robotoMono(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.report_off),
                  onPressed: () {
                    // handle action
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // handle delete
                  },
                ),
              ],
            ),
            Column(
              children: [
                if (!showExtraButtons)
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showExtraButtons = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: const BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                        ),
                        elevation: 6,
                      ),
                      child: Text(
                        "Take an Action",
                        style: GoogleFonts.cuteFont(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 12),
                if (showExtraButtons)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      children: [
                        // Hide Actions button
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                showExtraButtons = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: const BorderSide(
                                  color: Colors.black,
                                  width: 1.5,
                                ),
                              ),
                              elevation: 6,
                            ),
                            child: Text(
                              "Hide Actions",
                              style: GoogleFonts.cuteFont(
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            child: Text(
                              "Notify Tailor Shop",
                              style: GoogleFonts.cuteFont(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            child: Text(
                              "Disable Account of \n Tailor Shop",
                              style: GoogleFonts.cuteFont(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            child: Text(
                              "Message Tailor Shop",
                              style: GoogleFonts.cuteFont(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
