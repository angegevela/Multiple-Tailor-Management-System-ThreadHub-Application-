import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:threadhub_system/Tailor/pages/menu%20item/tailor%20report/tailor_reportpage.dart';
import 'package:threadhub_system/Tailor/pages/menu%20item/tailor_notification.dart';
import 'package:threadhub_system/Tailor/pages/menu%20item/tailor_profilesettings.dart';
import 'package:threadhub_system/Tailor/pages/menu%20item/tailor_profilesettings/help%20center/chatbox.dart';
import 'package:threadhub_system/Tailor/pages/menu%20item/tailor_profilesettings/tailor_fontprovider.dart';
import 'package:threadhub_system/Tailor/pages/menu%20item/tailor_ratingsandreviews.dart';
import 'package:threadhub_system/Tailor/pages/menu%20item/tailor_shopperformancereport.dart';

class TailorHomePage extends StatefulWidget {
  const TailorHomePage({super.key});

  @override
  State<TailorHomePage> createState() => _TailorHomePageState();
}

class _TailorHomePageState extends State<TailorHomePage> {
  void _openMenu() {
    final tailorfontSize = Provider.of<TailorFontprovider>(
      context,
      listen: false,
    ).fontSize;

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
                      Navigator.pop(dialogContext); // close the menu
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

  //Pill Containers
  int selectedIndex = 0;

  Widget _buildOrderFrame() {
    switch (selectedIndex) {
      case 0:
        return _pendingOrdersFrame(
          activeDetail: activeDetail,
          onMeasurement: () {
            setState(() {
              activeDetail = "measurement";
            });
          },
          onMedia: () {
            setState(() {
              activeDetail = "media";
            });
          },
          onOtherDetails: () {
            setState(() {
              activeDetail = "otherdetails";
            });
          },
          onBack: () {
            setState(() {
              activeDetail = "";
            });
          },
          context: context,
        );

      case 1:
        return _finishedOrdersFrame(
          activeDetail: '',
          onMeasurement: () {},
          onMedia: () {},
          onBack: () {},
        );
      case 2:
        return _canceledOrdersFrame(
          activeDetail: '',
          onBack: () {},
          onMeasurement: () {},
        );
      default:
        return _pendingOrdersFrame(
          activeDetail: activeDetail,
          onMeasurement: () {
            setState(() {
              activeDetail = "measurement";
            });
          },
          onMedia: () {
            setState(() {
              activeDetail = "media";
            });
          },
          onOtherDetails: () {
            setState(() {
              activeDetail = "otherdetails";
            });
          },
          onBack: () {
            setState(() {
              activeDetail = "";
            });
          },
          context: context,
        );
    }
  }

  final List<String> tabs = [
    "Pending Orders",
    "Finished Orders",
    "Canceled Orders",
  ];

  //Color Changing Search Bar
  final TextEditingController _searchbarController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();

    //Listen for text changes
    _searchbarController.addListener(() {
      setState(() {
        _isSearching = _searchbarController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _searchbarController.dispose();
    super.dispose();
  }

  String activeDetail = "";
  @override
  Widget build(BuildContext context) {
    final tailorfontSize = context.watch<TailorFontprovider>().fontSize;
    return WillPopScope(
      onWillPop: () async {
        if (activeDetail.isNotEmpty) {
          setState(() {
            activeDetail = "";
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _isSearching
              ? const Color(0xFF262633)
              : const Color(0xFF6082B6),
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: _isSearching ? Colors.white : Colors.black,
            ),
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
                  controller: _searchbarController,
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
                  width: 330,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFB0C4DE),
                    border: Border.all(color: Colors.black, width: 1.5),
                  ),
                  child: Text(
                    'Work Orders',
                    style: GoogleFonts.poppins(
                      fontSize: tailorfontSize,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: List.generate(tabs.length, (index) {
                      bool isSelected = index == selectedIndex;
                      BorderRadius radius;
                      if (index == 0) {
                        radius = const BorderRadius.horizontal(
                          left: Radius.circular(50),
                        );
                      } else if (index == tabs.length - 1) {
                        radius = const BorderRadius.horizontal(
                          right: Radius.circular(50),
                        );
                      } else {
                        radius = BorderRadius.zero;
                      }

                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF7C9A9A)
                                  : Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius: radius,
                            ),
                            child: Text(
                              tabs[index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 15),

                _buildOrderFrame(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Table Widget
  TableRow buildTableRow({
    required BuildContext context,
    required String label,
    required String value,
    Color leftColor = const Color(0xFFC4E1E6),
    Color rightColor = Colors.white,
    VoidCallback? onPressed,
  }) {
    final tailorFontSize = context.watch<TailorFontprovider>().fontSize;
    Color textColor = Colors.black;

    // Handle Prioritization coloring
    if (label == "Priority") {
      if (value.toLowerCase().contains("low")) {
        textColor = Colors.green;
      } else if (value.toLowerCase().contains("medium")) {
        textColor = Colors.yellow[800]!;
      } else if (value.toLowerCase().contains("high")) {
        textColor = const Color(0xFF900707);
      }
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
              style: GoogleFonts.bebasNeue(
                fontWeight: FontWeight.w400,
                fontSize: tailorFontSize,
              ),
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            color: rightColor,
            padding: const EdgeInsets.all(8.0),
            child:
                (label == "Measurement" ||
                    label == "Media Upload" ||
                    label == "Other Details")
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF72A0C1),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: const BorderSide(color: Colors.black, width: 1.5),
                      ),
                    ),
                    onPressed: onPressed,
                    child: Text(
                      value,
                      style: GoogleFonts.bebasNeue(
                        fontWeight: FontWeight.w400,
                        fontSize: tailorFontSize + 3,
                      ),
                    ),
                  )
                : Text(
                    value,
                    style: GoogleFonts.inknutAntiqua(
                      fontWeight: FontWeight.w400,
                      fontSize: tailorFontSize - 2,
                      color: textColor,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  //Pending Orders Widget
  Widget _pendingOrdersFrame({
    required BuildContext context,
    required String activeDetail,
    required VoidCallback onMeasurement,
    required VoidCallback onMedia,
    required VoidCallback onOtherDetails,
    required VoidCallback onBack,
  }) {
    final tailorFontSize = context.watch<TailorFontprovider>().fontSize;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // White Header
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Name + dot + ID + status in one line
                            Row(
                              children: [
                                Text(
                                  "Alilie Rea",
                                  style: GoogleFonts.bebasNeue(
                                    fontWeight: FontWeight.bold,
                                    fontSize: tailorFontSize + 4,
                                  ),
                                ),

                                const SizedBox(width: 8),

                                // Circle dot
                                Container(
                                  width: 5,
                                  height: 5,
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle,
                                  ),
                                ),

                                const SizedBox(width: 8),

                                // ID number
                                Text(
                                  "119",
                                  style: GoogleFonts.noticiaText(
                                    fontSize: tailorFontSize - 2,
                                    color: Colors.grey,
                                  ),
                                ),

                                const SizedBox(width: 8),

                                // Status
                                Text(
                                  "Pending",
                                  style: GoogleFonts.noticiaText(
                                    fontSize: tailorFontSize - 2,
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              print("Edit button tapped!");
                              // Your edit logic here
                            },
                            borderRadius: BorderRadius.circular(40),
                            child: Container(
                              width: 45,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFFF5F7F9),
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/icons/pen-circle.png',
                                  width: 28,
                                  height: 28,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ChatPage(),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(40),
                            child: Container(
                              width: 45,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFFF5F7F9),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.message_rounded,
                                  color: Colors.black54,
                                  size: 28,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  width: double.infinity,
                  // height: 700,
                  decoration: const BoxDecoration(
                    color: Color(0xFF8DA399),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Upper White Table - First
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: activeDetail == "measurement"
                                ? _measurementDetailsTable()
                                : activeDetail == "media"
                                ? _mediaDetailsTable()
                                : activeDetail == "otherdetails"
                                ? _otherDetailsTable()
                                : Table(
                                    columnWidths: const {
                                      0: FlexColumnWidth(1.5),
                                      1: FlexColumnWidth(2.5),
                                    },
                                    border: TableBorder.symmetric(
                                      inside: BorderSide(color: Colors.black12),
                                    ),
                                    children: [
                                      buildTableRow(
                                        context: context,
                                        label: "Measurement",
                                        value: activeDetail == "measurement"
                                            ? "Back"
                                            : "Details",
                                        leftColor: activeDetail == "measurement"
                                            ? Colors.green[100]!
                                            : const Color(0xFFE8F9FF),
                                        rightColor: Colors.white,
                                        onPressed: activeDetail == "measurement"
                                            ? onBack
                                            : onMeasurement,
                                      ),
                                      buildTableRow(
                                        context: context,
                                        label: "Payment Status",
                                        value: "Fully Paid",
                                        leftColor: const Color(0xFFE8F9FF),
                                        rightColor: Colors.white,
                                      ),
                                      buildTableRow(
                                        context: context,
                                        label: "Order History",
                                        value: "None",
                                        leftColor: const Color(0xFFE8F9FF),
                                        rightColor: Colors.white,
                                      ),
                                      buildTableRow(
                                        context: context,
                                        label: "Tailor Assigned",
                                        value: "Catty Villar",
                                        leftColor: const Color(0xFFE8F9FF),
                                        rightColor: Colors.white,
                                      ),
                                      buildTableRow(
                                        context: context,
                                        label: "Quantity",
                                        value: "3 Sets",
                                        leftColor: const Color(0xFFE8F9FF),
                                        rightColor: Colors.white,
                                      ),
                                      buildTableRow(
                                        context: context,
                                        label: "Media Upload",
                                        value: activeDetail == "media"
                                            ? "Back"
                                            : "See Media",
                                        leftColor: activeDetail == "media"
                                            ? Colors.green[100]!
                                            : const Color(0xFFE8F9FF),
                                        rightColor: Colors.white,
                                        onPressed: activeDetail == "media"
                                            ? onBack
                                            : onMedia,
                                      ),
                                      buildTableRow(
                                        context: context,
                                        label: "Other Details",
                                        value: activeDetail == "otherdetails"
                                            ? "Back"
                                            : "See Other Details",
                                        leftColor:
                                            activeDetail == "otherdetails"
                                            ? Colors.green[100]!
                                            : const Color(0xFFE8F9FF),
                                        rightColor: Colors.white,
                                        onPressed:
                                            activeDetail == "otherdetails"
                                            ? onBack
                                            : onOtherDetails,
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                      if (activeDetail == "measurement" ||
                          activeDetail == "media" ||
                          activeDetail == "otherdetails")
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 20,
                              bottom: 8,
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF72A0C1),
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                    color: Colors.black,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              onPressed: onBack,
                              child: const Text("Back"),
                            ),
                          ),
                        ),

                      const SizedBox(height: 12),
                      // Middle - Second white table
                      if (activeDetail == "")
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
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
                                    context: context,
                                    label: "Order",
                                    value: "Government Uniform",
                                    leftColor: const Color(0xFFE8F9FF),
                                    rightColor: Colors.white,
                                  ),
                                  buildTableRow(
                                    context: context,
                                    label: "Appointment Date",
                                    value: "October 10, 2025, 2:00 PM",
                                    leftColor: const Color(0xFFE8F9FF),
                                    rightColor: Colors.white,
                                  ),
                                  buildTableRow(
                                    context: context,
                                    label: "Priority",
                                    value: "Medium Priority",
                                    leftColor: const Color(0xFFE8F9FF),
                                    rightColor: Colors.white,
                                  ),
                                  buildTableRow(
                                    context: context,
                                    label: "Price",
                                    value: "PHP 1,500",
                                    leftColor: const Color(0xFFE8F9FF),
                                    rightColor: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                      const SizedBox(height: 12),
                      if (activeDetail == "")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF72A0C1),
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 13,
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                    color: Colors.black,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                print("First button clicked");
                              },
                              child: Text(
                                "Approve this Appointment",
                                style: GoogleFonts.noticiaText(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10.5,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFB82132),
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 13,
                                  vertical: 5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                    color: Colors.black,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                final TextEditingController
                                reasoningController = TextEditingController();

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: const Color(0xFFC7C8CC),
                                      title: Text('Reject Appointment'),
                                      content: SizedBox(
                                        width: 500,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 1,
                                            ),
                                          ),
                                          padding: const EdgeInsets.all(8),
                                          child: TextField(
                                            minLines: 5,
                                            maxLines: null,
                                            decoration: const InputDecoration(
                                              hintText:
                                                  "Enter your reasoning...",
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text(
                                            'Cancel',
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          onPressed: () {
                                            final reasoning =
                                                reasoningController.text;
                                            debugPrint(
                                              "User reasoning: $reasoning",
                                            );

                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Save',
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },

                              child: Text(
                                "Reject this Appointment",
                                style: GoogleFonts.noticiaText(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10.5,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        //Approved Appointment That is On-Going
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // White Header
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Alice Doe",
                                  style: GoogleFonts.bebasNeue(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),

                                const SizedBox(width: 8),

                                // Circle dot
                                Container(
                                  width: 5,
                                  height: 5,
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle,
                                  ),
                                ),

                                const SizedBox(width: 8),

                                // ID number
                                Text(
                                  "124",
                                  style: GoogleFonts.noticiaText(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),

                                const SizedBox(width: 8),

                                // Status
                                Text(
                                  "On going",
                                  style: GoogleFonts.noticiaText(
                                    fontSize: 14,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          // EDIT BUTTON (image inside circle)
                          InkWell(
                            onTap: () {
                              print("Edit button tapped!");
                              // Your edit logic here
                            },
                            borderRadius: BorderRadius.circular(40),
                            child: Container(
                              width: 45,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFFF5F7F9),
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/icons/pen-circle.png',
                                  width: 28,
                                  height: 28,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: () {
                              print("Delete button tapped!");
                            },
                            borderRadius: BorderRadius.circular(40),
                            child: Container(
                              width: 45,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFFF5F7F9),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.message_rounded,
                                  color: Colors.black54,
                                  size: 28,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  width: double.infinity,
                  height: 530,
                  decoration: const BoxDecoration(
                    color: Color(0xFF8DA399),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // First white table
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
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
                                  context: context,
                                  label: "Measurement",
                                  value: activeDetail == "measurement"
                                      ? "Back"
                                      : "Details",
                                  leftColor: activeDetail == "measurement"
                                      ? Colors.green[100]!
                                      : const Color(0xFFE8F9FF),
                                  rightColor: Colors.white,
                                  onPressed: activeDetail == "measurement"
                                      ? onBack
                                      : onMeasurement,
                                ),

                                buildTableRow(
                                  context: context,
                                  label: "Payment Status",
                                  value: "Partially Paid",
                                  leftColor: const Color(0xFFE8F9FF),
                                  rightColor: Colors.white,
                                ),
                                buildTableRow(
                                  context: context,
                                  label: "Order History",
                                  value: "None",
                                  leftColor: const Color(0xFFE8F9FF),
                                  rightColor: Colors.white,
                                ),
                                buildTableRow(
                                  context: context,
                                  label: "Tailor Assigned",
                                  value: "Jhogelien Fowler",
                                  leftColor: const Color(0xFFE8F9FF),
                                  rightColor: Colors.white,
                                ),
                                buildTableRow(
                                  context: context,
                                  label: "Quantity",
                                  value: "2",
                                  leftColor: const Color(0xFFE8F9FF),
                                  rightColor: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Second white table
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
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
                                  context: context,
                                  label: "Order",
                                  value: "Alteration Pants",
                                  leftColor: const Color(0xFFE8F9FF),
                                  rightColor: Colors.white,
                                ),
                                buildTableRow(
                                  context: context,
                                  label: "Due Date",
                                  value: "October 10, 2025, 2:00 pm",
                                  leftColor: const Color(0xFFE8F9FF),
                                  rightColor: Colors.white,
                                ),
                                buildTableRow(
                                  context: context,
                                  label: "Priority",
                                  value: "Low Priority",
                                  leftColor: const Color(0xFFE8F9FF),
                                  rightColor: Colors.white,
                                ),
                                buildTableRow(
                                  context: context,
                                  label: "Price",
                                  value: "PHP 500",
                                  leftColor: const Color(0xFFE8F9FF),
                                  rightColor: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF72A0C1),
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 13,
                                vertical: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                  color: Colors.black,
                                  width: 1.5,
                                ),
                              ),
                            ),
                            onPressed: () {
                              print("First button clicked");
                            },
                            child: Text(
                              "Mark As Done",
                              style: GoogleFonts.noticiaText(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),

                          const SizedBox(width: 5),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFB82132),
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 13,
                                vertical: 5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                  color: Colors.black,
                                  width: 1.5,
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const TailorReportPage(),
                                ),
                              );
                            },

                            child: Text(
                              "Report this Person",
                              style: GoogleFonts.noticiaText(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF9AA6B2),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                color: Colors.black,
                                width: 1.5,
                              ),
                            ),
                          ),
                          onPressed: () {
                            final TextEditingController reasoningController =
                                TextEditingController();

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: const Color(0xFFC7C8CC),
                                  title: const Text('Cancel Appointment'),
                                  content: SizedBox(
                                    width: 500,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 1,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      child: TextField(
                                        minLines: 5,
                                        maxLines: null,
                                        decoration: const InputDecoration(
                                          hintText:
                                              "Include an reason to cancel this appointment",
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    ElevatedButton(
                                      child: const Text('Save'),
                                      onPressed: () {
                                        final reasoning =
                                            reasoningController.text;
                                        debugPrint(
                                          "User reasoning: $reasoning",
                                        );
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(
                            "Cancel Appointment",
                            style: GoogleFonts.noticiaText(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  //Measurement Code
  Widget _measurementDetailsTable() {
    return Table(
      columnWidths: const {0: FlexColumnWidth(1.5), 1: FlexColumnWidth(2.5)},
      border: TableBorder.symmetric(inside: BorderSide(color: Colors.black12)),
      children: [
        buildTableRow(context: context, label: "Neckline", value: "15.5 in"),
        buildTableRow(
          context: context,
          label: "Shoulder Width",
          value: "18 in",
        ),
        buildTableRow(context: context, label: "Chest", value: "40 in"),
        buildTableRow(context: context, label: "Cuffs", value: "9 in"),
        buildTableRow(context: context, label: "Armhole", value: "20 in"),
        buildTableRow(
          context: context,
          label: "Sleeve Length",
          value: "24.5 in",
        ),
        buildTableRow(context: context, label: "Bicep", value: "13 in"),
        buildTableRow(context: context, label: "Wrist", value: "7 in"),
        buildTableRow(context: context, label: "Back Length", value: "18.5 in"),
        buildTableRow(context: context, label: "Jacket Length", value: "30 in"),
        buildTableRow(context: context, label: "Waist", value: "34 in"),
      ],
    );
  }

  Widget _mediaDetailsTable() {
    final List<String> mediaFiles = [
      "assets/img/design1.jpg",
      "assets/img/design2.jpg",
    ];

    return Container(
      color: const Color(0xFF8DA399),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1, // square cells
        ),
        itemCount: mediaFiles.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.zero,
            child: Image.asset(
              mediaFiles[index],
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          );
        },
      ),
    );
  }

  Widget _otherDetailsTable() {
    return Table(
      columnWidths: const {0: FlexColumnWidth(1.5), 1: FlexColumnWidth(2.5)},
      border: TableBorder.symmetric(inside: BorderSide(color: Colors.black12)),
      children: [
        buildTableRow(
          context: context,
          label: "Full Name",
          value: "Alilie Rea",
          leftColor: const Color(0xFFE8F9FF),
          rightColor: Colors.white,
        ),
        buildTableRow(
          context: context,
          label: "Contact",
          value: "+63 912 345 6789",
          leftColor: const Color(0xFFE8F9FF),
          rightColor: Colors.white,
        ),
        buildTableRow(
          context: context,
          label: "Email",
          value: "alilie.rea@example.com",
          leftColor: const Color(0xFFE8F9FF),
          rightColor: Colors.white,
        ),
        buildTableRow(
          context: context,
          label: "Address",
          value: "Quezon City, Metro Manila",
          leftColor: const Color(0xFFE8F9FF),
          rightColor: Colors.white,
        ),
      ],
    );
  }

  //Finished Order Widget
  Widget _finishedOrdersFrame({
    required String activeDetail,
    required VoidCallback onMeasurement,
    required VoidCallback onMedia,
    required VoidCallback onBack,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // White Header
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Name + dot + ID + status in one line
                            Row(
                              children: [
                                Text(
                                  "Kyro Permaran",
                                  style: GoogleFonts.bebasNeue(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),

                                const SizedBox(width: 8),

                                // Circle dot
                                Container(
                                  width: 5,
                                  height: 5,
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle,
                                  ),
                                ),

                                const SizedBox(width: 8),

                                // ID number
                                Text(
                                  "121",
                                  style: GoogleFonts.noticiaText(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),

                                const SizedBox(width: 8),

                                // Status
                                Text(
                                  "Completed",
                                  style: GoogleFonts.noticiaText(
                                    color: Colors.lightGreen,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          // EDIT BUTTON (image inside circle)
                          InkWell(
                            onTap: () {
                              print("Edit button tapped!");
                              // Your edit logic here
                            },
                            borderRadius: BorderRadius.circular(40),
                            child: Container(
                              width: 45,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFFF5F7F9),
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/icons/pen-circle.png',
                                  width: 28,
                                  height: 28,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: () {
                              print("Chat button tapped!");
                            },
                            borderRadius: BorderRadius.circular(40),
                            child: Container(
                              width: 45,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFFF5F7F9),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.message_rounded,
                                  color: Colors.black54,
                                  size: 28,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF8DA399),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: activeDetail == "measurement"
                                ? _measurementDetailsTable()
                                : activeDetail == "media"
                                ? _mediaDetailsTable()
                                : Table(
                                    columnWidths: const {
                                      0: FlexColumnWidth(1.5),
                                      1: FlexColumnWidth(2.5),
                                    },
                                    border: TableBorder.symmetric(
                                      inside: BorderSide(color: Colors.black12),
                                    ),
                                    children: [
                                      buildTableRow(
                                        context: context,
                                        label: "Measurement",
                                        value: activeDetail == "measurement"
                                            ? "Back"
                                            : "Details",
                                        leftColor: const Color(0xFFE8F9FF),
                                        rightColor: Colors.white,
                                        onPressed: activeDetail == "measurement"
                                            ? onBack
                                            : onMeasurement,
                                      ),
                                      buildTableRow(
                                        context: context,
                                        label: "Payment Status",
                                        value: "Fully Paid",
                                        leftColor: const Color(0xFFE8F9FF),
                                        rightColor: Colors.white,
                                      ),
                                      buildTableRow(
                                        context: context,
                                        label: "Order History",
                                        value: "Custom Suit",
                                        leftColor: const Color(0xFFE8F9FF),
                                        rightColor: Colors.white,
                                      ),
                                      buildTableRow(
                                        context: context,
                                        label: "Tailor Assigned",
                                        value: "Zumic",
                                        leftColor: const Color(0xFFE8F9FF),
                                        rightColor: Colors.white,
                                      ),
                                      buildTableRow(
                                        context: context,
                                        label: "Quantity",
                                        value: "3 Sets",
                                        leftColor: const Color(0xFFE8F9FF),
                                        rightColor: Colors.white,
                                      ),
                                      buildTableRow(
                                        context: context,
                                        label: "Media Upload",
                                        value: activeDetail == "media"
                                            ? "Back"
                                            : "See Media",
                                        leftColor: const Color(0xFFE8F9FF),
                                        rightColor: Colors.white,
                                        onPressed: activeDetail == "media"
                                            ? onBack
                                            : onMedia,
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                      if (activeDetail == "measurement" ||
                          activeDetail == "media")
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 20,
                              bottom: 8,
                            ),
                            child: ElevatedButton(
                              onPressed: onBack,
                              child: const Text("Back"),
                            ),
                          ),
                        ),

                      const SizedBox(height: 12),

                      // Second white table
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
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
                                  context: context,
                                  label: "Order",
                                  value: "Short Sleeve Polo",
                                  leftColor: const Color(0xFFE8F9FF),
                                  rightColor: Colors.white,
                                ),
                                buildTableRow(
                                  context: context,
                                  label: "Due Date",
                                  value: "December 31, 2024, 4:30 am",
                                  leftColor: const Color(0xFFE8F9FF),
                                  rightColor: Colors.white,
                                ),
                                buildTableRow(
                                  context: context,
                                  label: "Priority",
                                  value: "High Priority",
                                  leftColor: const Color(0xFFE8F9FF),
                                  rightColor: Colors.white,
                                ),
                                buildTableRow(
                                  context: context,
                                  label: "Price",
                                  value: "PHP 2,000",
                                  leftColor: const Color(0xFFE8F9FF),
                                  rightColor: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF72A0C1),
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 13,
                                vertical: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                  color: Colors.black,
                                  width: 1.5,
                                ),
                              ),
                            ),
                            onPressed: () {
                              print("First button clicked");
                            },
                            child: Text(
                              "Notify this Person",
                              style: GoogleFonts.noticiaText(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFB82132),
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 13,
                                vertical: 5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                  color: Colors.black,
                                  width: 1.5,
                                ),
                              ),
                            ),
                            onPressed: () {
                              print("Second button clicked");
                            },
                            child: Text(
                              "Report this Person",
                              style: GoogleFonts.noticiaText(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  //Canceled Order Widget
  Widget _canceledOrdersFrame({
    required String activeDetail,
    required VoidCallback onBack,
    required VoidCallback onMeasurement,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // HEADER
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              "Sisa Lolit",
                              style: GoogleFonts.bebasNeue(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Cancelled",
                              style: GoogleFonts.noticiaText(
                                fontSize: 14,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // BODY
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF8DA399),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // FIRST WHITE TABLE
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: activeDetail == "measurement"
                                ? _measurementDetailsTable()
                                : Table(
                                    columnWidths: const {
                                      0: FlexColumnWidth(1.5),
                                      1: FlexColumnWidth(2.5),
                                    },
                                    border: TableBorder.symmetric(
                                      inside: BorderSide(color: Colors.black12),
                                    ),
                                    children: [
                                      buildTableRow(
                                        context: context,
                                        label: "Measurement",
                                        value: activeDetail == "measurement"
                                            ? "Back"
                                            : "See More",
                                        leftColor: const Color(0xFFE8F9FF),
                                        rightColor: Colors.white,
                                        onPressed: activeDetail == "measurement"
                                            ? onBack
                                            : onMeasurement,
                                      ),
                                      buildTableRow(
                                        context: context,
                                        label: "Tailor Assigned",
                                        value: "Teresita Santos",
                                        leftColor: const Color(0xFFE8F9FF),
                                        rightColor: Colors.white,
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),

                      if (activeDetail == "measurement")
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 20,
                              bottom: 8,
                            ),
                            child: ElevatedButton(
                              onPressed: onBack,
                              child: const Text("Back"),
                            ),
                          ),
                        ),

                      const SizedBox(height: 12),

                      // SECOND WHITE TABLE
                      if (activeDetail == "")
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
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
                                    context: context,
                                    label: "Order",
                                    value: "Government Uniform",
                                    leftColor: const Color(0xFFE8F9FF),
                                    rightColor: Colors.white,
                                  ),
                                  buildTableRow(
                                    context: context,
                                    label: "Due Date",
                                    value: "December 23, 2024",
                                    leftColor: const Color(0xFFE8F9FF),
                                    rightColor: Colors.white,
                                  ),
                                  buildTableRow(
                                    context: context,
                                    label: "Reason for \nCancellation",
                                    value:
                                        "Wala akong sapat na tela at mabibilhan na malapit sa area.",
                                    leftColor: const Color(0xFFE8F9FF),
                                    rightColor: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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
