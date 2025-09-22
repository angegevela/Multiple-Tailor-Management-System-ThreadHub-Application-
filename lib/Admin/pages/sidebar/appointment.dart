import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:threadhub_system/Admin/pages/sidebar/menu.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class UploadFile {
  final PlatformFile file;
  final String filePath;
  double progress;
  bool isUploading;
  bool isPaused;

  UploadFile(
    this.file, {
    required this.filePath,
    this.progress = 0.0,
    this.isUploading = true,
    this.isPaused = false,
  });
}

class _AppointmentPageState extends State<AppointmentPage> {
  bool _showExportOptions = false;
  bool isAscending = true;
  int currentPage = 0;
  int sectionPageIndex = 0;
  final int rowsPerPage = 7;

  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  void _toggleExportOptions() {
    setState(() {
      _showExportOptions = !_showExportOptions;
    });
  }

  List<UploadFile> uploadedFiles = [];
  final Map<UploadFile, Timer> uploadTimers = {};
  bool _wantsToUpload = false;

  Future<void> selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null || result.files.isEmpty) return;

    if (uploadedFiles.length + result.files.length > 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You can upload a maximum of 5 files.")),
      );
      return;
    }

    for (var file in result.files) {
      final upload = UploadFile(file, filePath: file.path ?? '');
      setState(() {
        uploadedFiles.add(upload);
      });
      simulateUpload(upload);
    }
  }

  void simulateUpload(UploadFile uploadFile) {
    const duration = Duration(milliseconds: 100);
    final timer = Timer.periodic(duration, (timer) {
      if (!uploadFile.isPaused) {
        setState(() {
          if (uploadFile.progress >= 1) {
            uploadFile.isUploading = false;
            timer.cancel();
          } else {
            uploadFile.progress += 0.02;
          }
        });
      }
    });
    uploadTimers[uploadFile] = timer;
  }

  void removeFile(UploadFile file) {
    uploadTimers[file]?.cancel();
    setState(() {
      uploadedFiles.remove(file);
      uploadTimers.remove(file);
    });
  }

  bool DocUpload(String path) {
    final ext = path.split('.').last.toLowerCase();
    return ['pdf', 'csv', 'docx', 'xlsx', 'xls'].contains(ext);
  }

  String truncateFilename(String filename, int maxLength) {
    if (filename.length <= maxLength) return filename;
    final dotIndex = filename.lastIndexOf('.');
    if (dotIndex == -1) return '${filename.substring(0, maxLength - 3)}...';

    final extension = filename.substring(dotIndex);
    final base = filename.substring(0, dotIndex);
    final allowedLength = maxLength - extension.length - 3;
    return '${base.substring(0, allowedLength)}...$extension';
  }

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

  final Map<DateTime, List<Map<String, dynamic>>> events = {
    DateTime(2025, 9, 16): [
      {
        "title": "Allie's Custom Design Deadline",
        "time": "4:30 pm",
        "color": Colors.blue,
        "icon": Icons.event,
      },
      {
        "title": "Developer Zahid Consultation",
        "time": "1:30 pm",
        "color": Colors.redAccent,
        "icon": Icons.event,
      },
      {
        "title": "General Meeting with Co-Workers",
        "time": "7:30 pm",
        "color": Colors.purple,
        "icon": Icons.groups,
      },
    ],
  };

  List<Map<String, dynamic>> _getEventsForDay(DateTime day) {
    final localDay = DateTime(day.year, day.month, day.day);
    return events[localDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text('Appointment'),
        backgroundColor: const Color(0xFF6082B6),
      ),
      drawer: const Menu(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Numbers of Appointment',
                style: GoogleFonts.sometypeMono(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Container(
                  height: 60,
                  width: 250,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4F607A),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'Container Content',
                      style: GoogleFonts.sometypeMono(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Appointment Details",
                style: GoogleFonts.sometypeMono(fontSize: 15),
              ),
              SizedBox(height: 10),
              //Appointment Tables
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
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
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
              // Appointment Calendar
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  children: [
                    TableCalendar(
                      firstDay: DateTime.utc(2020, 1, 1),
                      lastDay: DateTime.utc(2030, 12, 31),
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      onDaySelected: (selectedDay, focusedDay) {
                        print("Selected: $selectedDay");
                        print("Events: ${_getEventsForDay(selectedDay)}");

                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      },

                      calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors.deepPurple,
                            width: 2,
                          ),
                          shape: BoxShape.circle,
                        ),
                        todayTextStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        selectedDecoration: const BoxDecoration(
                          color: Colors.deepPurple,
                          shape: BoxShape.circle,
                        ),
                      ),
                      headerStyle: const HeaderStyle(
                        titleCentered: true,
                        formatButtonVisible: false,
                      ),
                    ),

                    const SizedBox(height: 12),

                    if (_selectedDay != null &&
                        _getEventsForDay(_selectedDay!).isNotEmpty)
                      Column(
                        children: _getEventsForDay(_selectedDay!)
                            .map(
                              (event) => _buildEventCard(
                                icon: event['icon'] ?? Icons.event,
                                title: event['title'],
                                time: event['time'],
                                color: (event['color'] as Color).withOpacity(
                                  0.15,
                                ),
                                iconColor: event['color'],
                              ),
                            )
                            .toList(),
                      ),
                  ],
                ),
              ),
              //Elevated Button
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          if (_wantsToUpload) {
                            _wantsToUpload = false;
                            uploadedFiles.clear();
                            uploadTimers.forEach((_, timer) => timer.cancel());
                            uploadTimers.clear();
                          } else {
                            _wantsToUpload = true;
                          }
                        });
                      },

                      label: Text('Import File'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5D8AA8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        foregroundColor: Colors.black,
                        minimumSize: const Size(300, 56),
                        textStyle: GoogleFonts.mPlus1(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    if (_wantsToUpload) ...[
                      Text(
                        "Media Upload",
                        style: GoogleFonts.sometypeMono(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Add your files here, and you can upload up to 5 files max.",
                        style: GoogleFonts.sometypeMono(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),

                      //Upload Box
                      DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        dashPattern: const [10, 4],
                        strokeCap: StrokeCap.round,
                        color: Color(0xFF4D6BFF),

                        child: Container(
                          width: double.infinity,
                          height: 190,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/upload.png',
                                height: 50,
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton.icon(
                                onPressed: selectFile,
                                label: const Text('Browse Files'),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: 12,
                                  ),
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: const BorderSide(
                                      color: Color(0xFF4D6BFF),
                                      width: 2,
                                    ),
                                  ),
                                  foregroundColor: const Color(0xFF1A2A99),
                                  backgroundColor: const Color(0xFFDDE4FF),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 10),
                    ...uploadedFiles.map((upload) {
                      final fileSizeInMB = (upload.file.size) / (1024 * 1024);
                      final fileName = upload.file.name;

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 150,
                              color: Colors.grey[200],
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.insert_drive_file,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      truncateFilename(fileName, 25),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 4),
                                          Text(
                                            upload.isUploading
                                                ? '${((1 - upload.progress) * 50).round()} seconds remaining'
                                                : '${fileSizeInMB.toStringAsFixed(2)} MB',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          if (upload.isUploading)
                                            IconButton(
                                              icon: Icon(
                                                upload.isPaused
                                                    ? Icons.play_arrow
                                                    : Icons.pause,
                                              ),
                                              tooltip: upload.isPaused
                                                  ? 'Resume'
                                                  : 'Pause',
                                              onPressed: () {
                                                setState(() {
                                                  upload.isPaused =
                                                      !upload.isPaused;
                                                });
                                              },
                                            ),
                                          GestureDetector(
                                            onTap: () => removeFile(upload),
                                            child: Container(
                                              width: 24,
                                              height: 24,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey[350],
                                                border: Border.all(
                                                  color: Colors.grey.shade500,
                                                  width: 2,
                                                ),
                                              ),
                                              child: const Icon(
                                                Icons.close,
                                                size: 20,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  if (upload.isUploading)
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: LinearProgressIndicator(
                                        value: upload.progress,
                                        minHeight: 6,
                                        backgroundColor: Colors.grey[300],
                                        valueColor:
                                            const AlwaysStoppedAnimation<Color>(
                                              Color(0xFF1849D6),
                                            ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),

                    //Administrator - Elevated Button
                    SizedBox(
                      width: 300,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: _toggleExportOptions,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5D8AA8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          foregroundColor: Colors.black,
                          textStyle: GoogleFonts.mPlus1(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Export This File as'),
                            Icon(
                              _showExportOptions
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                              color: Colors.black,
                              size: 28,
                            ),
                          ],
                        ),
                      ),
                    ),

                    if (_showExportOptions)
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Column(
                          children: [
                            //Save as PDF
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF5D8AA8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                                foregroundColor: Colors.black,
                                minimumSize: const Size(300, 56),
                                textStyle: GoogleFonts.mPlus1(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 17,
                                ),
                              ),
                              child: Text('.CSV'),
                            ),
                            //Save as CSV
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF5D8AA8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                                foregroundColor: Colors.black,
                                minimumSize: const Size(300, 56),
                                textStyle: GoogleFonts.mPlus1(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 17,
                                ),
                              ),
                              child: Text('.PDF'),
                            ),
                            //Save as DOCX
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF5D8AA8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                                foregroundColor: Colors.black,
                                minimumSize: const Size(300, 56),
                                textStyle: GoogleFonts.mPlus1(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 17,
                                ),
                              ),
                              child: Text('.DOCX'),
                            ),
                            //Save as DOCS
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF5D8AA8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                                foregroundColor: Colors.black,
                                minimumSize: const Size(300, 56),
                                textStyle: GoogleFonts.mPlus1(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 17,
                                ),
                              ),
                              child: Text('.DOCS'),
                            ),
                            //Save as XLSX
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF5D8AA8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                                foregroundColor: Colors.black,
                                minimumSize: const Size(300, 56),
                                textStyle: GoogleFonts.mPlus1(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 17,
                                ),
                              ),
                              child: Text('.XLSX'),
                            ),
                            //Save as XLS
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF5D8AA8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                                foregroundColor: Colors.black,
                                minimumSize: const Size(300, 56),
                                textStyle: GoogleFonts.mPlus1(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 17,
                                ),
                              ),
                              child: Text('.XLS'),
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
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      color: const Color(0xFFF2F2F2),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.tune, size: 18),
            label: Text('Filter'),
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
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
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
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
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
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => ReceiptPage()),
            // );
          },
          child: const Text("View Receipt"),
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
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => ReportPage()),
            // );
          },
          child: Text(
            "Report",
            style: GoogleFonts.chauPhilomeneOne(color: Colors.red),
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
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF3A8326),
              fontWeight: FontWeight.w500,
            ),
          ),
          if (shop.isNotEmpty)
            Text(
              shop,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF3A8326),
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      );
    }

    return Text(
      _formatCellValue(header, value),
      style: const TextStyle(fontSize: 16),
      textAlign: TextAlign.left,
    );
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

  Widget _buildEventCard({
    required IconData icon,
    required String title,
    required String time,
    required Color color,
    required Color iconColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: iconColor,
              ),
            ),
          ),
          Text(
            time,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: iconColor,
            ),
          ),
        ],
      ),
    );
  }
}
