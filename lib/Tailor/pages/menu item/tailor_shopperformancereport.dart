import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:threadhub_system/Tailor/pages/menu%20item/tailor_notification.dart';
import 'package:threadhub_system/Tailor/pages/menu%20item/tailor_profilesettings.dart';
import 'package:threadhub_system/Tailor/pages/menu%20item/tailor_ratingsandreviews.dart';
import 'package:threadhub_system/Tailor/pages/tailorhomepage.dart';


class TailorShopperformancereport extends StatefulWidget {
  const TailorShopperformancereport({super.key});

  @override
  State<TailorShopperformancereport> createState() =>
      _TailorShopperformancereportState();
}

class _TailorShopperformancereportState
    extends State<TailorShopperformancereport> {
  String _selectedGraph = "This 6 Months";
  List<BarChartGroupData> _getBarGroups() {
    final labels = _graphLabels[_selectedGraph] ?? [];

    switch (_selectedGraph) {
      case "This Month":
        return [
          makeGroupData(0, 100, 50, 30),
          makeGroupData(1, 120, 40, 20),
          makeGroupData(2, 80, 30, 10),
          makeGroupData(3, 150, 70, 50),
        ];

      case "Last Month":
        return [
          makeGroupData(0, 200, 100, 60),
          makeGroupData(1, 180, 80, 40),
          makeGroupData(2, 220, 90, 50),
          makeGroupData(3, 160, 70, 30),
        ];

      case "Past 6 Months":
      case "This 6 Months":
        return List.generate(labels.length, (i) {
          // Example placeholder data
          return makeGroupData(i, 300 - i * 20, 150 - i * 10, 100 - i * 5);
        });

      default:
        return [];
    }
  }

  void _openMenu() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (BuildContext dialogContext) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.only(top: 56),
              width: 250,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildMenuItemTap(
                    Icons.notifications,
                    "Notification",
                    backgroundColor: const Color(0xFFD9D9D9),
                    onTap: () {
                      Navigator.pop(dialogContext);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TailorNotificationPage(),
                        ),
                      );
                    },
                  ),
                  _buildMenuItemTap(
                    Icons.home,
                    "Home",
                    backgroundColor: const Color(0xFF4C516D),
                    textColor: Colors.white,
                    iconColor: Colors.white,
                    onTap: () {
                      Navigator.pop(dialogContext);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => TailorHomePage()),
                      );
                    },
                  ),
                  _buildMenuItemTap(
                    Icons.person,
                    "Profile Settings",
                    backgroundColor: const Color(0xFFD9D9D9),
                    onTap: () {
                      Navigator.pop(dialogContext);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TailorProfileSettingsPage(),
                        ),
                      );
                    },
                  ),
                  _buildMenuItemTap(
                    Icons.rate_review,
                    "Rating and Reviews",
                    backgroundColor: const Color(0xFF4C516D),
                    textColor: Colors.white,
                    iconColor: Colors.white,
                    onTap: () {
                      Navigator.pop(dialogContext);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TailorRatingsandreviewsPage(),
                        ),
                      );
                    },
                  ),
                  _buildMenuItemTap(
                    Icons.bar_chart,
                    "Shop Performance Report",
                    backgroundColor: const Color(0xFFD9D9D9),
                    onTap: () {
                      Navigator.pop(dialogContext);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TailorShopperformancereport(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //Month Labels
  List<String> _generateMonthLabel({
    required int startOffset,
    required int count,
  }) {
    final now = DateTime.now();
    return List.generate(count, (i) {
      final date = DateTime(now.year, now.month + startOffset + i, 1);
      return _monthShort(date.month);
    });
  }

  String _monthShort(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return months[month - 1];
  }

  Map<String, List<String>> get _graphLabels {
    return {
      "This Month": ["W1", "W2", "W3", "W4"],
      "Last Month": ["W1", "W2", "W3", "W4"],
      "Past 6 Months": _generateMonthLabel(startOffset: -6, count: 6),
      "This 6 Months": _generateMonthLabel(startOffset: 0, count: 6),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6082B6),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: _openMenu,
        ),
        title: Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: 230,
            height: 36,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
              child: TextField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  hintText: 'Search...',
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search, color: Colors.black),
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFD9D9D9),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 15),
              Container(
                height: 50,
                width: 300,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFB0C4DE),
                  border: Border.all(color: Colors.black, width: 1.5),
                ),
                child: Text(
                  'Shop Performance Report',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _buildInfoCard("48%", "Store Performance Ratings", "+2.5%"),
                  _buildInfoCard("₱3,966", "Inventory Expenses", "+2.5%"),
                ],
              ),
              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _buildInfoCard(
                    "28,019",
                    "Total Visitor in this Period",
                    "-1.5%",
                    isNegative: true,
                  ),
                  _buildInfoCard(
                    "3,966",
                    "New Customer in this Period",
                    "+2.5%",
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Chart Card
              Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                margin: const EdgeInsets.all(16.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'CUSTOMER GROWTH',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          DropdownButton<String>(
                            value: _selectedGraph,
                            items:
                                <String>[
                                  "This Month",
                                  "Last Month",
                                  "Past 6 Months",
                                  "This 6 Months",
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedGraph = newValue!;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildLegendDot(Colors.blue, "Returnee"),
                          const SizedBox(width: 15),
                          _buildLegendDot(Colors.lightBlue, "Cancelled"),
                          const SizedBox(width: 15),
                          _buildLegendDot(Colors.grey, "New Customer"),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 400,
                        child: BarChart(
                          BarChartData(
                            maxY: 800,
                            barGroups: _getBarGroups(),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 200,
                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                      value.toInt().toString(),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.left,
                                    );
                                  },
                                  reservedSize: 40,
                                ),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    final labels =
                                        _graphLabels[_selectedGraph] ?? [];
                                    if (value.toInt() >= 0 &&
                                        value.toInt() < labels.length) {
                                      return Text(
                                        labels[value.toInt()],
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      );
                                    }
                                    return const Text("");
                                  },
                                ),
                              ),
                            ),
                            gridData: FlGridData(show: true),
                            borderData: FlBorderData(show: false),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItemTap(
    IconData icon,
    String title, {
    required VoidCallback onTap,
    Color backgroundColor = Colors.white,
    Color textColor = Colors.black,
    Color iconColor = Colors.black,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Row(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 16),
            Text(title, style: TextStyle(color: textColor)),
          ],
        ),
      ),
    );
  }
}

// -------------------- Helper Widgets & Chart Utils -------------------- //

Widget _buildInfoCard(
  String value,
  String title,
  String percent, {
  bool isNegative = false,
}) {
  return Card(
    elevation: 4.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
    child: Container(
      width: 150,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Text(
            percent,
            style: TextStyle(
              color: isNegative ? Colors.red : Colors.green,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildLegendDot(Color color, String label) {
  return Row(
    children: [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: 6),
      Text(label, style: const TextStyle(fontSize: 13)),
    ],
  );
}

BarChartGroupData makeGroupData(
  int x,
  double returnee,
  double cancelled,
  double newCustomer,
) {
  return BarChartGroupData(
    x: x,
    barRods: [
      BarChartRodData(
        toY: returnee + cancelled + newCustomer,
        width: 20,
        borderRadius: const BorderRadius.all(Radius.circular(0)),
        rodStackItems: [
          BarChartRodStackItem(0, returnee, Colors.blue),
          BarChartRodStackItem(
            returnee,
            returnee + cancelled,
            Colors.lightBlue,
          ),
          BarChartRodStackItem(
            returnee + cancelled,
            returnee + cancelled + newCustomer,
            Colors.grey,
          ),
        ],
      ),
    ],
  );
}
