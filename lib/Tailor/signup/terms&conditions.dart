import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndConditionsPage extends StatefulWidget {
  const TermsAndConditionsPage({super.key});

  @override
  State<TermsAndConditionsPage> createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  final ScrollController _scrollController = ScrollController();
  //scroll button + scroll navigation
  bool _showScrollButton = false;
  bool _isAtBottom = false;
  double _previousOffset = 0.0;

  //termsAccepted
  final bool _termsAccepted = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final position = _scrollController.position.pixels;
      final max = _scrollController.position.maxScrollExtent;

      setState(() {
        _showScrollButton = position > 20 || position < max - 20;
        _isAtBottom = position >= max - 50;
      });
    });
  }

  void _scrollToBottom() async {
    _previousOffset = _scrollController.offset;

    await _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToPrevious() async {
    await _scrollController.animateTo(
      _previousOffset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> terms = [
    {
      "title": "Account Registration",
      "bullets": [
        "Provide valid business details and necessary verification documents.",
        "Ensure all information provided is accurate and up-to-date.",
        "Abide by all local laws and regulations governing your business.",
      ],
    },
    {
      "title": "Use of Services",
      "bullets": [
        "Use the platform solely for its intended purposes and comply with local laws.",
        "Respect the rights of other users, including privacy and intellectual property rights.",
      ],
    },
    {
      "title": "Payments and Fees",
      "bullets": [
        "Clearly state your pricing and payment terms and ensure transparency.",
      ],
    },
    {
      "title": "Privacy and Data Protection",
      "bullets": [
        "Respect user privacy and protect personal data.",
        "Do not give any of your data outside the application unless your are contacted by the administrator on this system",
        "You can also report fellow tailor and customer if they violate any of your privacy or business.",
      ],
    },
    {
      "title": "Termination of Privacy",
      "bullets": [
        "Administrator reserve the right to terminate accounts that violate these terms.",
        "Administrator may notify you if you have any violation.",
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF6082B6),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "AGREEMENT",
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              Text(
                "Terms of Service",
                style: GoogleFonts.montserrat(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
              Text(
                "Last updated on 5/12/2022",
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),

      body: Stack(
        children: [
          // Scrollable Terms Content
          Scrollbar(
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...List.generate(terms.length, (i) {
                    final term = terms[i];
                    final bullets = term['bullets'] as List<dynamic>;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${i + 1}. ${term['title']}",
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...bullets.map<Widget>((b) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                bottom: 6,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "• ",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Expanded(
                                    child: Text(
                                      b,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),

          // Accept & Continue Button — only visible when at bottom
          if (_isAtBottom)
            Positioned(
              bottom: 90,
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6082B6), 
                    foregroundColor: Colors.white,
                    elevation: 6, 
                    shadowColor: Colors.deepPurple, 
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "Accept & Continue",
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

          // Scroll to bottom - top button navigation logic
          if (_showScrollButton)
            Positioned(
              bottom: 20,
              right: 0,
              left: 0,
              child: Center(
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 6, // shadow depth
                  hoverColor: Colors.blueGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(
                      color: Colors.black,
                      width: 2,
                    ), 
                  ),
                  label: Text(
                    _isAtBottom ? 'Scroll to Top' : 'Scroll to Bottom',
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    if (_isAtBottom) {
                      _scrollToPrevious();
                    } else {
                      _scrollToBottom();
                    }
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
