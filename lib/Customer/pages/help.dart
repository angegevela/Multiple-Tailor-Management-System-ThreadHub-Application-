import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threadhub_system/Customer/pages/font_provider.dart';

class CustomerHelpPage extends StatefulWidget {
  const CustomerHelpPage({super.key});

  @override
  State<CustomerHelpPage> createState() => _CustomerHelpPageState();
}

class _CustomerHelpPageState extends State<CustomerHelpPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final fontSize = context.watch<FontProvider>().fontSize;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        // title: Text(
        //   "Help Support * How to",
        //   style: GoogleFonts.roboto(
        //     color: Colors.white,
        //     fontSize: 20,
        //     fontWeight: FontWeight.w600,
        //   ),
        // ),
        backgroundColor: const Color(0xFF262633),
      ),
      backgroundColor: const Color(0xFFEEEEEE),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Help Support * How to',
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 3.0),

                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            // Perform the search here
                          },
                        ),
                      ],
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
