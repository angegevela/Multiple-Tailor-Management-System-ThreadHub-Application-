import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:threadhub_system/Customer/pages/Measurement%20Method/manual_measurement.dart';
import 'package:threadhub_system/Customer/pages/calendar_appoint.dart';
import 'package:threadhub_system/Customer/pages/customization.dart';
import 'package:threadhub_system/Customer/pages/duedate_product.dart';
import 'package:threadhub_system/Customer/pages/font_provider.dart';

class AppointmentFormPage extends StatefulWidget {
  const AppointmentFormPage({super.key});

  @override
  State<AppointmentFormPage> createState() => _AppointmentFormPageState();
}

enum MeasurementType { assisted, manual }

class _AppointmentFormPageState extends State<AppointmentFormPage> {
  //Display Selected Appointment Date in Form
  DateTime? appointmentDateTime;
  String? priority;

  //Display Selected Due Date in Form
  DateTime? dueDateTime;
  String? duepriority;

  //Not Empty Measurement Method
  final bool _hasBeenPressed = false;
  MeasurementType? _selectedType;
  String? _errorText;
  // ignore: unused_element
  void _bookNow() {
    setState(() {
      if (_selectedType == null) {
        _errorText = 'Please select one of the measurement method';
      } else {
        _errorText = null;
      }
    });
  }

  //Textfield Controllers
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _garmentSpecController = TextEditingController();
  final TextEditingController _servicesController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _phonenumberController.dispose();
    _garmentSpecController.dispose();
    _servicesController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void submitForm() {
    //for book now logic
  }

  @override
  Widget build(BuildContext context) {
    final fontSize = context.watch<FontProvider>().fontSize;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6082B6),
        title: Text(
          'Appointment Booking Form',
          style: GoogleFonts.notoSerifOldUyghur(
            fontSize: 20,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: Scaffold(
        backgroundColor: const Color(0xFFEEEEEE),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Schedule Your Appointment Today',
                    style: GoogleFonts.medulaOne(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // Full Name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Full Name',
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _fullNameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Enter your Full Name',
                          contentPadding: EdgeInsets.fromLTRB(18, 22, 48, 2),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2.5,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),

                //Phone Number TextField
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Phone Number',
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _phonenumberController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'e.g 09012345678',
                          contentPadding: EdgeInsets.fromLTRB(18, 22, 48, 2),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2.5,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10),
                // Garment Specification
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Garment Specification',
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _garmentSpecController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'e.g cargo pants, dresses, etc.',
                          contentPadding: EdgeInsets.fromLTRB(18, 22, 48, 2),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2.5,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10),
                // Service/s availment
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Service/s',
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _servicesController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'e.g alterations, custom made, etc.',
                          contentPadding: EdgeInsets.fromLTRB(18, 22, 48, 2),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2.5,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Customization Options',
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 45,
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.all(2),
                        padding: const EdgeInsets.all(10),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "More Options",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: fontSize,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 145),
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_right_alt,
                                color: Colors.black,
                                size: 25,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CustomizationPage(),
                                  ),
                                );
                              },
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),

                //Message Textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Message',
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black, width: 1.5),
                        ),
                        padding: EdgeInsets.all(8),
                        child: TextField(
                          controller: _messageController,
                          decoration: InputDecoration(
                            hintText: 'Enter any additional messages here',
                            border: InputBorder.none,
                          ),
                          maxLines: 4,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10),
                // Select Date and Time for Appointment and Product
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Date and Time',
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      ElevatedButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                insetPadding: EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                backgroundColor: Colors.transparent,
                                child: SingleChildScrollView(
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                          0.95,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Is this date and time for :',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: fontSize,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  Navigator.of(context).pop();

                                                  final result =
                                                      await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              CalendarHome(),
                                                        ),
                                                      );

                                                  if (result != null &&
                                                      result
                                                          is Map<
                                                            String,
                                                            dynamic
                                                          >) {
                                                    setState(() {
                                                      appointmentDateTime =
                                                          result['appointmentDateTime'];
                                                      priority =
                                                          result['priority'];
                                                    });
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Color(
                                                    0xFF90C3D4,
                                                  ),
                                                  shape: StadiumBorder(),
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 10,
                                                  ),
                                                ),
                                                child: Text(
                                                  'Appointment',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: fontSize,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  final result =
                                                      await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              DueDateProductPage(),
                                                        ),
                                                      );
                                                  if (result != null &&
                                                      result
                                                          is Map<
                                                            String,
                                                            dynamic
                                                          >) {
                                                    setState(() {
                                                      dueDateTime =
                                                          result['dueDateTime'];
                                                      duepriority =
                                                          result['duepriority'];
                                                    });
                                                  }
                                                },

                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Color(
                                                    0xFF90C3D4,
                                                  ),
                                                  shape: StadiumBorder(),
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 3,
                                                    vertical: 3,
                                                  ),
                                                ),
                                                child: FittedBox(
                                                  child: Text(
                                                    'Due Date of your \n Product',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: fontSize,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 45),
                          backgroundColor: const Color(0xFF6082B6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Select',
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),

                      //Show Appointment Date if set
                      if (appointmentDateTime != null && priority != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Confirmed Appointment:',
                                  style: TextStyle(
                                    fontFamily: 'JainiPurva',
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Container(
                                      width: 205,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          DateFormat(
                                            'MMMM d, y, h:mm a',
                                          ).format(appointmentDateTime!),
                                          style: GoogleFonts.chathura(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: Text(
                                        '$priority Priority',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.chathura(
                                          color: priority == 'High'
                                              ? Color(0xFFBF360C)
                                              : priority == 'Medium'
                                              ? Colors.orange
                                              : Colors.green,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 29,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                      //Show Product Due Date if set
                      if (dueDateTime != null && duepriority != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Product Due Date:',
                                  style: TextStyle(
                                    fontFamily: 'JainiPurva',
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Container(
                                      width: 205,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          DateFormat(
                                            'MMMM d, y, h:mm a',
                                          ).format(dueDateTime!),
                                          style: GoogleFonts.chathura(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: Text(
                                        '$duepriority Priority',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.chathura(
                                          color: duepriority == 'High'
                                              ? Color(0xFFBF360C)
                                              : duepriority == 'Medium'
                                              ? Colors.orange
                                              : Colors.green,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 29,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                //Measurement Input Method Choices
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 12.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Measurement input method:",
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if (_selectedType ==
                                      MeasurementType.assisted) {
                                    _selectedType = null; // unselect
                                  } else {
                                    _selectedType = MeasurementType.assisted;
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(48),
                                backgroundColor:
                                    _selectedType == MeasurementType.assisted
                                    ? Colors.blue.withOpacity(0.3)
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(
                                    color:
                                        _selectedType ==
                                            MeasurementType.assisted
                                        ? Colors.blue.withOpacity(0.3)
                                        : const Color(0xFF6082B6),
                                  ),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                'Assisted\nMeasurement',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      _selectedType == MeasurementType.assisted
                                      ? const Color(0xFF6082B6).withOpacity(0.5)
                                      : const Color(0xFF6082B6),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if (_selectedType == MeasurementType.manual) {
                                    _selectedType = null; // unselect
                                  } else {
                                    _selectedType = MeasurementType.manual;
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ManualMeasurement(),
                                      ),
                                    );
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(48),
                                backgroundColor:
                                    _selectedType == MeasurementType.manual
                                    ? Colors.blue.withOpacity(0.3)
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(
                                    color:
                                        _selectedType == MeasurementType.manual
                                        ? Colors.blue.withOpacity(0.3)
                                        : const Color(0xFF6082B6),
                                  ),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                '  Enter\nManually',
                                style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.w600,
                                  color: _selectedType == MeasurementType.manual
                                      ? const Color(0xFF6082B6).withOpacity(0.5)
                                      : const Color(0xFF6082B6),
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(0, 45),
                          backgroundColor: const Color(0xFF6082B6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          'Confirm',
                          style: GoogleFonts.cormorantSc(
                            fontSize: fontSize,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
