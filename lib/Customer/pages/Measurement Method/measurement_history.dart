import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductMeasurementHistory extends StatefulWidget {
  const ProductMeasurementHistory({super.key});

  @override
  State<ProductMeasurementHistory> createState() =>
      _ProductMeasurementHistoryState();
}

class _ProductMeasurementHistoryState extends State<ProductMeasurementHistory> {
  bool _showDetails = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF262633),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFFEEEEEE),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10.0),
                Container(
                  width: 350.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 1.5),
                  ),
                  child: Center(
                    child: Text(
                      'Measurement History',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  width: 350.0,
                  height: 130.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 1.5),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/img/longsleeve.png',
                          width: 60,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 8.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Used For',
                                    style: GoogleFonts.jetBrainsMono(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Custom Long Sleeves',
                                    style: GoogleFonts.jetBrainsMono(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _showDetails = !_showDetails;
                                });
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFFD9D9D9),
                                padding: EdgeInsets.symmetric(
                                  vertical: 12.0,
                                  horizontal: 20.0,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide(
                                    color: Colors.black,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              child: Text(
                                _showDetails ? 'Hide Details' : 'Details',
                                style: GoogleFonts.jetBrainsMono(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    backgroundColor: const Color(0xFFC7D9DD),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    content: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxHeight: 100,
                                        maxWidth: 400,
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8.0,
                                            horizontal: 10.0,
                                          ),
                                          child: Text(
                                            "Do you want to use this measurement for the new product project?",
                                            style: GoogleFonts.jetBrainsMono(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    actionsPadding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    actions: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor: const Color(
                                                0xFF819067,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 20,
                                                vertical: 10,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(ctx).pop(true);
                                            },
                                            child: Text(
                                              "Yes",
                                              style: GoogleFonts.jetBrainsMono(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor: const Color(
                                                0xFFD25D5D,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 20,
                                                vertical: 10,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(ctx).pop(false);
                                            },
                                            child: Text(
                                              "No",
                                              style: GoogleFonts.jetBrainsMono(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFFD9D9D9),
                                padding: EdgeInsets.symmetric(
                                  vertical: 12.0,
                                  horizontal: 20.0,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide(
                                    color: Colors.black,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              child: Text(
                                'Used This',
                                style: GoogleFonts.jetBrainsMono(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                AnimatedCrossFade(
                  firstChild: SizedBox.shrink(),
                  secondChild: Container(
                    height: 400,
                    width: 350,
                    margin: EdgeInsets.only(top: 8),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xff0f4f2de),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black, width: 1.5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Sizes
                        Text(
                          'Here are the additional details about the product or measurement.',
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            // Image box
                            Container(
                              height: 150,
                              width: 120,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.5,
                                ),
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/img/longsleeve.png',
                                  ),
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),

                            SizedBox(width: 10), // Optional spacing
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 90,
                                      color: const Color(0xFFD9D9D9),
                                    ),
                                    SizedBox(width: 5),
                                    Container(
                                      height: 40,
                                      width: 90,
                                      color: const Color(0xFFD9D9D9),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 90,
                                      color: const Color(0xFFD9D9D9),
                                    ),
                                    SizedBox(width: 5),
                                    Container(
                                      height: 40,
                                      width: 90,
                                      color: const Color(0xFFD9D9D9),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Left Arrow Container with Gesture
                                    GestureDetector(
                                      onTap: () {
                                        // Your left navigation logic here
                                        print('Navigate Left');
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.arrow_left,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 70),
                                    GestureDetector(
                                      onTap: () {
                                        // Your right navigation logic here
                                        print('Navigate Right');
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.arrow_right,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        
                        SizedBox(height: 20),
                        // Notes
                        Text(
                          'Notes',
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          height: 120,
                          width: 360,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD9D9D9),
                            border: Border.all(color: Colors.black, width: 1.5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Note: Handle with care. Do not expose to direct sunlight.',
                              style: GoogleFonts.jetBrainsMono(
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  crossFadeState: _showDetails
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: Duration(milliseconds: 300),
                ),

                SizedBox(height: 10.0),

                // Container(
                //   width: 350.0,
                //   height: 130.0,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     border: Border.all(color: Colors.black, width: 1.5),
                //   ),
                //   child: Row(
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Image.asset(
                //           'assets/img/pants.png',
                //           width: 60,
                //           height: 80,
                //           fit: BoxFit.cover,
                //         ),
                //       ),
                //       Expanded(
                //         child: Padding(
                //           padding: const EdgeInsets.symmetric(
                //             vertical: 16.0,
                //             horizontal: 8.0,
                //           ),
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   Text(
                //                     'Used For',
                //                     style: GoogleFonts.jetBrainsMono(
                //                       fontWeight: FontWeight.bold,
                //                       fontSize: 16,
                //                     ),
                //                   ),
                //                   SizedBox(height: 4),
                //                   Text(
                //                     'Alterations of Pants',
                //                     style: GoogleFonts.jetBrainsMono(
                //                       fontSize: 14,
                //                       fontWeight: FontWeight.bold,
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.only(right: 8.0),
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             TextButton(
                //               onPressed: () {
                //                 setState(() {
                //                   // _showDetails = !_showDetails;
                //                 });
                //               },
                //               style: TextButton.styleFrom(
                //                 backgroundColor: const Color(0xFFD9D9D9),
                //                 padding: EdgeInsets.symmetric(
                //                   vertical: 12.0,
                //                   horizontal: 20.0,
                //                 ),
                //                 shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(8.0),
                //                   side: BorderSide(
                //                     color: Colors.black,
                //                     width: 1.5,
                //                   ),
                //                 ),
                //               ),
                //               child: Text(
                //                 _showDetails ? 'Hide Details' : 'Details',
                //                 style: GoogleFonts.jetBrainsMono(
                //                   fontSize: 14,
                //                   fontWeight: FontWeight.bold,
                //                   color: Colors.black,
                //                 ),
                //               ),
                //             ),
                //             SizedBox(height: 8),
                //             TextButton(
                //               onPressed: () {
                //                 showDialog(
                //                   context: context,
                //                   builder: (ctx) => AlertDialog(
                //                     backgroundColor: const Color(0xFFC7D9DD),
                //                     shape: RoundedRectangleBorder(
                //                       borderRadius: BorderRadius.circular(15),
                //                     ),
                //                     content: ConstrainedBox(
                //                       constraints: BoxConstraints(
                //                         maxHeight: 100,
                //                         maxWidth: 400,
                //                       ),
                //                       child: Center(
                //                         child: Padding(
                //                           padding: const EdgeInsets.symmetric(
                //                             vertical: 8.0,
                //                           ),
                //                           child: Text(
                //                             "Do you want to use this measurement for the new product project?",
                //                             style: GoogleFonts.jetBrainsMono(
                //                               fontSize: 15,
                //                               fontWeight: FontWeight.bold,
                //                             ),
                //                             textAlign: TextAlign.center,
                //                           ),
                //                         ),
                //                       ),
                //                     ),
                //                     actionsPadding: EdgeInsets.symmetric(
                //                       horizontal: 16,
                //                     ),
                //                     actions: <Widget>[
                //                       Row(
                //                         mainAxisAlignment:
                //                             MainAxisAlignment.spaceEvenly,
                //                         children: [
                //                           TextButton(
                //                             style: TextButton.styleFrom(
                //                               backgroundColor: const Color(
                //                                 0xFF819067,
                //                               ),
                //                               shape: RoundedRectangleBorder(
                //                                 borderRadius:
                //                                     BorderRadius.circular(8),
                //                               ),
                //                               padding: EdgeInsets.symmetric(
                //                                 horizontal: 20,
                //                                 vertical: 10,
                //                               ),
                //                             ),
                //                             onPressed: () {
                //                               Navigator.of(ctx).pop(true);
                //                             },
                //                             child: Text(
                //                               "Yes",
                //                               style: GoogleFonts.jetBrainsMono(
                //                                 color: Colors.black,
                //                                 fontWeight: FontWeight.bold,
                //                               ),
                //                             ),
                //                           ),
                //                           TextButton(
                //                             style: TextButton.styleFrom(
                //                               backgroundColor: const Color(
                //                                 0xFFD25D5D,
                //                               ),
                //                               shape: RoundedRectangleBorder(
                //                                 borderRadius:
                //                                     BorderRadius.circular(8),
                //                               ),
                //                               padding: EdgeInsets.symmetric(
                //                                 horizontal: 20,
                //                                 vertical: 10,
                //                               ),
                //                             ),
                //                             onPressed: () {
                //                               Navigator.of(ctx).pop(false);
                //                             },
                //                             child: Text(
                //                               "No",
                //                               style: GoogleFonts.jetBrainsMono(
                //                                 color: Colors.black,
                //                                 fontWeight: FontWeight.bold,
                //                               ),
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                     ],
                //                   ),
                //                 );
                //               },
                //               style: TextButton.styleFrom(
                //                 backgroundColor: const Color(0xFFD9D9D9),
                //                 padding: EdgeInsets.symmetric(
                //                   vertical: 12.0,
                //                   horizontal: 20.0,
                //                 ),
                //                 shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(8.0),
                //                   side: BorderSide(
                //                     color: Colors.black,
                //                     width: 1.5,
                //                   ),
                //                 ),
                //               ),
                //               child: Text(
                //                 'Used This',
                //                 style: GoogleFonts.jetBrainsMono(
                //                   fontSize: 14,
                //                   fontWeight: FontWeight.bold,
                //                   color: Colors.black,
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                // AnimatedCrossFade(
                //   firstChild: SizedBox.shrink(),
                //   secondChild: Container(
                //     height: 400,
                //     width: 350,
                //     margin: EdgeInsets.only(top: 8),
                //     padding: EdgeInsets.all(12),
                //     decoration: BoxDecoration(
                //       color: const Color(0xFF0F4F2DE),
                //       borderRadius: BorderRadius.circular(8),
                //       border: Border.all(color: Colors.black, width: 1.5),
                //     ),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         // Sizes
                //         Text(
                //           'Here are the additional details about the product or measurement.',
                //           style: GoogleFonts.jetBrainsMono(
                //             fontSize: 13,
                //             fontWeight: FontWeight.bold,
                //             color: Colors.black87,
                //           ),
                //           textAlign: TextAlign.center,
                //         ),
                //         SizedBox(height: 10.0),
                //         Row(
                //           children: [
                //             // Image box
                //             Container(
                //               height: 150,
                //               width: 120,
                //               decoration: BoxDecoration(
                //                 color: Colors.white,
                //                 border: Border.all(
                //                   color: Colors.black,
                //                   width: 1.5,
                //                 ),
                //                 image: DecorationImage(
                //                   image: AssetImage('assets/img/pants.png'),
                //                   fit: BoxFit.scaleDown,
                //                 ),
                //               ),
                //             ),

                //             SizedBox(width: 10), // Optional spacing
                //             Column(
                //               children: [
                //                 Row(
                //                   children: [
                //                     Container(
                //                       height: 40,
                //                       width: 90,
                //                       color: const Color(0xFFD9D9D9),
                //                     ),
                //                     SizedBox(width: 5),
                //                     Container(
                //                       height: 40,
                //                       width: 90,
                //                       color: const Color(0xFFD9D9D9),
                //                     ),
                //                   ],
                //                 ),
                //                 SizedBox(height: 5),
                //                 Row(
                //                   children: [
                //                     Container(
                //                       height: 40,
                //                       width: 90,
                //                       color: const Color(0xFFD9D9D9),
                //                     ),
                //                     SizedBox(width: 5),
                //                     Container(
                //                       height: 40,
                //                       width: 90,
                //                       color: const Color(0xFFD9D9D9),
                //                     ),
                //                   ],
                //                 ),
                //                 SizedBox(height: 5),
                //                 Row(
                //                   mainAxisAlignment:
                //                       MainAxisAlignment.spaceBetween,
                //                   children: [
                //                     // Left Arrow Container with Gesture
                //                     GestureDetector(
                //                       onTap: () {
                //                         // Your left navigation logic here
                //                         print('Navigate Left');
                //                       },
                //                       child: Container(
                //                         height: 30,
                //                         width: 40,
                //                         decoration: BoxDecoration(
                //                           color: Colors.white,
                //                           border: Border.all(
                //                             color: Colors.black,
                //                             width: 1.5,
                //                           ),
                //                         ),
                //                         child: const Icon(
                //                           Icons.arrow_left,
                //                           size: 20,
                //                         ),
                //                       ),
                //                     ),
                //                     SizedBox(width: 70),
                //                     // Right Arrow Container with Gesture
                //                     GestureDetector(
                //                       onTap: () {
                //                         // Your right navigation logic here
                //                         print('Navigate Right');
                //                       },
                //                       child: Container(
                //                         height: 30,
                //                         width: 40,
                //                         decoration: BoxDecoration(
                //                           color: Colors.white,
                //                           border: Border.all(
                //                             color: Colors.black,
                //                             width: 1.5,
                //                           ),
                //                         ),
                //                         child: const Icon(
                //                           Icons.arrow_right,
                //                           size: 20,
                //                         ),
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ],
                //             ),
                //           ],
                //         ),
                //         SizedBox(height: 20),
                //         // Notes
                //         Text(
                //           'Notes',
                //           style: GoogleFonts.jetBrainsMono(
                //             fontSize: 16,
                //             fontStyle: FontStyle.italic,
                //             fontWeight: FontWeight.bold,
                //             color: Colors.black,
                //           ),
                //         ),
                //         Container(
                //           height: 120,
                //           width: 360,
                //           decoration: BoxDecoration(
                //             color: const Color(0xFFD9D9D9),
                //             border: Border.all(color: Colors.black, width: 1.5),
                //           ),
                //           child: Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: Text(
                //               'Pwede ba lagyan ng bulaklakin na embroidery sa tuhod banda.',
                //               style: GoogleFonts.jetBrainsMono(
                //                 fontSize: 12,
                //                 fontStyle: FontStyle.italic,
                //                 color: Colors.black,
                //               ),
                //             ),
                //           ),
                //         ),
                //         SizedBox(height: 10),
                //       ],
                //     ),
                //   ),
                //   crossFadeState: _showDetails
                //       ? CrossFadeState.showSecond
                //       : CrossFadeState.showFirst,
                //   duration: Duration(milliseconds: 300),
                // ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
