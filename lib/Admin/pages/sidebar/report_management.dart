import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:threadhub_system/Admin/pages/sidebar/admin_reportdetails/admincard_report.dart';
import 'package:threadhub_system/Admin/pages/sidebar/menu.dart';


class ReportManagementPage extends StatefulWidget {
  const ReportManagementPage({super.key});

  @override
  State<ReportManagementPage> createState() => _ReportManagementPageState();
}

class _ReportManagementPageState extends State<ReportManagementPage> {
  final List<Map<String, dynamic>> reports = [
    {
      "title": "Report 1",
      "name": "Alice Doe",
      "subtitle": "Network Issue causing frequent drops",
      "details": "This report is about a network connectivity issue.",
      "status": "No Action Yet",
    },
    {
      "title": "Report 2",
      "name": "Jhogelien Fowler",
      "subtitle": "Login Failure (users can't sign in)",
      "details": "User unable to login due to invalid credentials error.",
      "status": "Pending Approval",
    },
    {
      "title": "Report 3",
      "name": "Cathlyne Gray",
      "subtitle": "Data Mismatch in user table",
      "details": "Database shows inconsistent records for users.",
      "status": "Completed",
    },
    {
      "title": "Report 4",
      "name": "Angelina Lino",
      "subtitle": "UI Bug: buttons misaligned on small screens",
      "details": "Some buttons are misaligned on smaller screens.",
      "status": "No Action Yet",
    },
    {
      "title": "Report 5",
      "name": "Joan Hevela",
      "subtitle": "Payment Failure intermittently failing",
      "details": "Payments are not being processed correctly.",
      "status": "Pending Approval",
    },
    {
      "title": "Report 6",
      "name": "Sasa Mia",
      "subtitle": "Crash on Launch on Android 11",
      "details": "App crashes immediately after starting.",
      "status": "Completed",
    },
  ];

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

  final List<Color> cardColors = [
    const Color(0xFF6D9886),
    const Color(0xFFE4EFE7),
    const Color(0xFF79B4B7),
    const Color(0xFFA4B787),
    const Color(0xFF30475E),
    const Color(0xFF4F8A8B),
    const Color(0xFF4F8A8B),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFF6082B6)),
      drawer: const Menu(),
      body: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.57,
          ),
          itemCount: reports.length,
          itemBuilder: (context, index) {
            final report = reports[index];
            final statusColor = getStatusColor(report["status"]);

            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ReportDetailPage(report: reports[index]),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      width: double.infinity,
                      color: cardColors[index % cardColors.length],
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      constraints: const BoxConstraints(minHeight: 120),
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Report Status:",
                            style: GoogleFonts.sometypeMono(
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            reports[index]["name"],
                            style: GoogleFonts.sometypeMono(
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic,
                              fontSize: 13.5,
                            ),
                          ),
                          Text(
                            reports[index]["status"],
                            style: GoogleFonts.sometypeMono(
                              color: getStatusColor(reports[index]["status"]),
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic,
                              fontSize: 11.5,
                            ),
                          ),

                          //Icons row at bottom
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.info),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ReportDetailPage(
                                          report: reports[index],
                                        ),
                                      ),
                                    );
                                  },
                                ),
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
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
