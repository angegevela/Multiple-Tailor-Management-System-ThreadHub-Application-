import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:threadhub_system/Customer/pages/font_provider.dart';
import 'package:threadhub_system/Customer/pages/product%20status/customer%20report/customer_report.dart';
import 'package:threadhub_system/Customer/pages/product%20status/receipt/customer_receipt.dart';

class ProductStatusPage extends StatefulWidget {
  const ProductStatusPage({super.key});

  @override
  State<ProductStatusPage> createState() => _ProductStatusPageState();
}

class _ProductStatusPageState extends State<ProductStatusPage> {
  bool isAscending = true;
  int currentPage = 0;
  int sectionPageIndex = 0;
  final int rowsPerPage = 7;

  final List<List<String>> sectionHeaders = [
    ['Service Type', 'Status'],
    ['Needed By Date', 'Product Order'],
    ['Tailor Assigned', 'Yeild ID'],
    ['Receipt', 'Report'],
  ];

  final List<List<Map<String, String>>> sectionData = [
    [
      {'Service Type': 'Repair', 'Status': 'Pending'},
      {'Service Type': 'Item C', 'Status': 'Completed'},
      {'Service Type': 'Item D', 'Status': 'Not Yet Taken'},
    ],
    [
      {'Needed By Date': '2024-06-29', 'Product Order': 'Tuxedo'},
      {'Needed By Date': '2025-07-02', 'Product Order': 'Gloves'},
      {
        'Needed By Date': '2025-07-03',
        'Product Order': 'Measurement for Formal Attire',
      },
    ],
    [
      {
        'Tailor Assigned': 'Vilma Santos - ABS Tailoring Shop',
        'Yeild ID': '1212',
      },
      {'Tailor Assigned': 'Diamond Tailoring Shop', 'Yeild ID': '1212'},
      {'Tailor Assigned': 'Tes Garcia', 'Yeild ID': '2090'},
    ],
    [
      {'Receipt': 'RC456', 'Report': ''},
      {'Receipt': 'RC457', 'Report': ''},
    ],
  ];

  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final fontSize = context.watch<FontProvider>().fontSize;
    final headers = sectionHeaders[sectionPageIndex];
    final filteredData = sectionData[sectionPageIndex]
        .where(
          (item) => item.values.any(
            (value) => value.toLowerCase().contains(searchQuery.toLowerCase()),
          ),
        )
        .toList();

    final totalPages = (filteredData.length / rowsPerPage).ceil();
    final start = currentPage * rowsPerPage;
    final end = (start + rowsPerPage).clamp(0, filteredData.length);
    final pagedData = filteredData.sublist(start, end);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6082B6),
        title: Text(
          'Back',
          style: GoogleFonts.moul(
            fontSize: fontSize,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      backgroundColor: const Color(0xFFEEEEEE),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              'Product Status',
              style: TextStyle(
                fontFamily: 'JainiPurva',
                fontSize: fontSize,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: [
                  _buildSearchBar(),
                  _buildTableHeader(headers),
                  ...pagedData.asMap().entries.map((entry) {
                    final index = entry.key;
                    final row = entry.value;
                    return _buildDataRow(
                      headers,
                      row,
                      index == pagedData.length - 1,
                    );
                  }),
                  if (totalPages > 1)
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: const BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.grey)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(totalPages, (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                currentPage = index;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: currentPage == index
                                    ? Colors.blueGrey
                                    : Colors.grey[300],
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
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

  Widget _buildSearchBar() {
    final fontSize = context.watch<FontProvider>().fontSize;
    return Container(
      color: const Color(0xFFF2F2F2),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.tune, size: 18),
            label: Text('Filter', style: TextStyle(fontSize: fontSize)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search_sharp),
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: (value) => setState(() {
                searchQuery = value;
                currentPage = 0;
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader(List<String> headers) {
    final fontSize = context.watch<FontProvider>().fontSize;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey, width: 1.0),
          bottom: BorderSide(color: Colors.grey, width: 1.0),
        ),
      ),
      child: Row(
        children: [
          // Column 1
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    headers[0],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: fontSize,
                    ),
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 4),
                if (headers[0] != 'Receipt' && headers[0] != 'Report')
                  Icon(
                    isAscending ? Icons.arrow_upward : Icons.arrow_downward,
                    size: 16,
                    color: Colors.grey[600],
                  ),
              ],
            ),
          ),

          //Column 2
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    headers[1],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: fontSize,
                    ),
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 4),
                if (headers[1] != 'Receipt' && headers[1] != 'Report')
                  Icon(
                    isAscending ? Icons.arrow_upward : Icons.arrow_downward,
                    size: 16,
                    color: Colors.grey[600],
                  ),
              ],
            ),
          ),

          Row(
            children: [
              _pageNavIcon(Icons.arrow_back_ios, sectionPageIndex > 0, () {
                setState(() {
                  sectionPageIndex--;
                  currentPage = 0;
                });
              }),
              const SizedBox(width: 5),
              _pageNavIcon(
                Icons.arrow_forward_ios,
                sectionPageIndex < sectionHeaders.length - 1,
                () {
                  setState(() {
                    sectionPageIndex++;
                    currentPage = 0;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDataRow(
    List<String> headers,
    Map<String, String> row,
    bool isLast,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: isLast
            ? null
            : const Border(bottom: BorderSide(color: Colors.grey)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final header in headers)
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: _buildCellContent(header, row[header] ?? ''),
              ),
            ),
        ],
      ),
    );
  }

  Widget _pageNavIcon(IconData icon, bool enabled, VoidCallback onTap) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Tooltip(
        message: icon == Icons.arrow_back_ios
            ? 'Previous section'
            : 'Next section',
        child: Container(
          decoration: BoxDecoration(
            color: enabled ? Colors.grey[300] : Colors.grey[200],
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            size: 15,
            color: enabled ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildCellContent(String header, String value) {
    final fontSize = context.watch<FontProvider>().fontSize;
    if (header == 'Receipt') {
      return Padding(
        padding: const EdgeInsets.only(right: 6.0),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.blueGrey),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReceiptPage()),
            );
          },
          child: Text("View Receipt", style: TextStyle(fontSize: fontSize)),
        ),
      );
    }

    if (header == 'Report') {
      return Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.red),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReportPage()),
            );
          },
          child: Text(
            "Report",
            style: GoogleFonts.chauPhilomeneOne(
              color: Colors.red,
              fontSize: fontSize,
            ),
          ),
        ),
      );
    }

    if (header == 'Status') {
      Color borderColor;
      Color backgroundColor;
      Color dotColor;

      switch (value.toLowerCase()) {
        case 'pending':
          borderColor = Colors.orange;
          backgroundColor = Colors.orange.withOpacity(0.1);
          dotColor = Colors.orange;
          break;
        case 'not yet taken':
          borderColor = Colors.red;
          backgroundColor = Colors.red.withOpacity(0.1);
          dotColor = Colors.red;
          break;
        case 'completed':
          borderColor = Colors.green;
          backgroundColor = Colors.green.withOpacity(0.1);
          dotColor = Colors.green;
          break;
        default:
          borderColor = Colors.grey;
          backgroundColor = Colors.grey.withOpacity(0.1);
          dotColor = Colors.grey;
      }

      return FittedBox(
        fit: BoxFit.scaleDown,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                margin: const EdgeInsets.only(right: 6),
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: borderColor,
                  fontWeight: FontWeight.w500,
                  fontSize: fontSize,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (header == 'Tailor Assigned') {
      final parts = value.split('\n');
      final name = parts.isNotEmpty ? parts[0] : '';
      final shop = parts.length > 1 ? parts[1] : '';

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF3A8326),
              fontWeight: FontWeight.w500,
            ),
          ),
          if (shop.isNotEmpty)
            Text(
              shop,
              style: TextStyle(
                fontSize: fontSize,
                color: Color(0xFF3A8326),
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      );
    }

    return Text(
      _formatCellValue(header, value),
      style: TextStyle(fontSize: fontSize),
      textAlign: TextAlign.left,
    );
  }
}

String _formatCellValue(String header, String value) {
  if (header.toLowerCase().contains('date') ||
      header.toLowerCase().contains('assigned')) {
    try {
      final parsedDate = DateTime.tryParse(value);
      if (parsedDate != null) {
        return DateFormat('MMMM dd, yyyy • hh:mm a').format(parsedDate);
      }
    } catch (_) {}
  }
  return value;
}
