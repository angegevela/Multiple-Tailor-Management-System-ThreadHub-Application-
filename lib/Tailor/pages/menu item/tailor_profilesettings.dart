import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:threadhub_system/Tailor/pages/menu%20item/tailor_availabilitysettings.dart';
import 'package:threadhub_system/Tailor/pages/menu%20item/tailor_profilesettings/tailor_fontprovider.dart';
import 'package:threadhub_system/Tailor/pages/menu%20item/tailor_profilesettings/tailor_help.dart';
import 'package:threadhub_system/Tailor/pages/menu%20item/tailor_profilesettings/tailor_personalinfo.dart';
class TailorProfileSettingsPage extends StatefulWidget {
  const TailorProfileSettingsPage({super.key});

  @override
  State<TailorProfileSettingsPage> createState() =>
      _TailorProfileSettingsPageState();
}

class _TailorProfileSettingsPageState extends State<TailorProfileSettingsPage> {
  // final GoogleSignIn googleSignIn = GoogleSignIn();
  // final firebaseUser = FirebaseAuth.instance.currentUser;
  String? fullName;
  String? role; // store role
  String? _profileImageUrl;

  // @override
  // void initState() {
  //   super.initState();
  //   _loadUserProfile();
  //   _loadUserData();
  // }

  // Future<void> _loadUserProfile() async {
  //   final user = Supabase.instance.client.auth.currentUser;
  //   if (user == null) return;

  //   final response = await Supabase.instance.client
  //       .from('profile-users')
  //       .select('pictures')
  //       .eq('id', user.id)
  //       .maybeSingle();

  //   if (response != null && response['pictures'] != null) {
  //     setState(() {
  //       _profileImageUrl = response['pictures'];
  //     });
  //   }
  // }

  // Future<void> _loadUserData() async {
  //   if (firebaseUser == null) return;

  //   final doc = await FirebaseFirestore.instance
  //       .collection("Users") // Make sure this matches exactly
  //       .doc(firebaseUser!.uid)
  //       .get();

  //   if (doc.exists) {
  //     final data = doc.data();
  //     setState(() {
  //       fullName = "${data?['firstName']} ${data?['surname']}";
  //       role = data?['role'] ?? "No role";
  //     });
  //   }
  // }

  bool notificationsEnabled = false;
  bool darkModeEnabled = false;
  //Font Size Logic
  String? _chosenValue;
  Map<String, double> fontMap = {
    'Small': 14.0,
    'Medium': 16.0,
    'Large': 18.0,
    'Extra Large': 20.0,
  };

  bool pushNotifications = true;
  bool reviewFeedbackAlerts = false;
  bool appointmentReminders = false;
  bool customerMessages = true;

  @override
  Widget build(BuildContext context) {
    final tailorfontSize = context.watch<TailorFontprovider>().fontSize;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: const Color(0xFF262633),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFFD9D9D9),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            CircleAvatar(
              radius: 90,
              backgroundColor: Colors.grey.shade300,
              child: _profileImageUrl != null && _profileImageUrl!.isNotEmpty
                  ? CircleAvatar(
                      radius: 88,
                      backgroundImage: NetworkImage(_profileImageUrl!),
                    )
                  : const CircleAvatar(
                      radius: 88,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, size: 60, color: Colors.white),
                    ),
            ),

            const SizedBox(height: 20),
            Text(
              fullName ?? "Loading name...",
              style: GoogleFonts.moul(
                textStyle: TextStyle(
                  fontSize: tailorfontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              role ?? "Loading role...",
              style: GoogleFonts.montserratAlternates(
                textStyle: TextStyle(
                  fontSize: tailorfontSize,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Personal Information Header
            Container(
              decoration: BoxDecoration(color: const Color(0xFF002244)),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TailorPersonalInformation(),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 70,
                    vertical: 5,
                  ),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Personal Information',
                  style: GoogleFonts.prompt(
                    fontSize: tailorfontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, bottom: 10),
                child: Text(
                  'Preferences',
                  style: GoogleFonts.prompt(
                    fontWeight: FontWeight.w500,
                    fontSize: tailorfontSize,
                  ),
                ),
              ),
            ),

            // Notification toggle
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Theme(
                data: Theme.of(
                  context,
                ).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(horizontal: 12),
                  title: Text(
                    'Notifications Settings',
                    style: GoogleFonts.prompt(
                      fontWeight: FontWeight.w500,
                      fontSize: tailorfontSize,
                    ),
                  ),
                  children: [
                    Divider(
                      height: 9,
                      thickness: 10,
                      color: Colors.grey.shade300,
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              'Push Notifications',
                              style: GoogleFonts.prompt(
                                fontWeight: FontWeight.w500,
                                fontSize: tailorfontSize,
                              ),
                            ),
                            trailing: CupertinoSwitch(
                              activeTrackColor: Color(0xFF5B7DB1),
                              inactiveTrackColor: Colors.grey.shade400,
                              value: pushNotifications,
                              onChanged: (val) {
                                setState(() {
                                  pushNotifications = val;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text(
                              'Review and Feedback Alerts',
                              style: GoogleFonts.prompt(
                                fontWeight: FontWeight.w400,
                                fontSize: tailorfontSize,
                              ),
                            ),
                            trailing: CupertinoSwitch(
                              activeTrackColor: Color(0xFF5B7DB1),
                              inactiveTrackColor: Colors.grey.shade400,
                              value: reviewFeedbackAlerts,
                              onChanged: (val) {
                                setState(() {
                                  reviewFeedbackAlerts = val;
                                });
                              },
                            ),
                          ),

                          ListTile(
                            title: Text(
                              'Appointment Reminders',
                              style: GoogleFonts.prompt(
                                fontWeight: FontWeight.w400,
                                fontSize: tailorfontSize,
                              ),
                            ),
                            trailing: CupertinoSwitch(
                              activeTrackColor: Color(0xFF5B7DB1),
                              inactiveTrackColor: Colors.grey.shade400,
                              value: appointmentReminders,
                              onChanged: (val) {
                                setState(() {
                                  appointmentReminders = val;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text(
                              'Customer Messages',
                              style: GoogleFonts.prompt(
                                fontWeight: FontWeight.w400,
                                fontSize: tailorfontSize,
                              ),
                            ),
                            trailing: CupertinoSwitch(
                              activeTrackColor: Color(0xFF5B7DB1),
                              inactiveTrackColor: Colors.grey.shade400,
                              value: customerMessages,
                              onChanged: (val) {
                                setState(() {
                                  customerMessages = val;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 2),
            // dark mode toggle
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,

                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: SwitchListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                title: Text(
                  'Dark Mode',
                  style: GoogleFonts.prompt(
                    fontWeight: FontWeight.w500,
                    fontSize: tailorfontSize,
                  ),
                ),
                value: darkModeEnabled,
                onChanged: (bool value) {
                  setState(() {
                    darkModeEnabled = value;
                  });
                },
              ),
            ),

            // Help ListTile
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,

                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                title: Text(
                  'Help',
                  style: GoogleFonts.prompt(
                    fontWeight: FontWeight.w500,
                    fontSize: tailorfontSize,
                  ),
                ),
                trailing: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Icon(
                    Icons.question_mark,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TailorHelpPage()),
                  );
                },
              ),
            ),

            // Face Biometrics Set Up
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,

                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                title: Text(
                  'Availabilty Settings',
                  style: GoogleFonts.prompt(
                    fontWeight: FontWeight.w500,
                    fontSize: tailorfontSize,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward, size: 24),
                onTap: () {
                  Navigator.push(
                    context,
                    // Navigate to BackupRestorePage()
                    MaterialPageRoute(
                      builder: (context) => TailorAvailabilitySettings(),
                    ),
                  );
                },
              ),
            ),

            // Font Size Dropdown
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                title: Text(
                  'Font Size',
                  style: GoogleFonts.prompt(fontWeight: FontWeight.w500),
                ),
                trailing: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _chosenValue,
                    style: GoogleFonts.montserratAlternates(
                      textStyle: TextStyle(
                        color: Colors.black87,
                        fontSize: tailorfontSize,
                      ),
                    ),

                    dropdownColor: const Color(0xFFD9EAFD),

                    icon: const Icon(Icons.arrow_downward, size: 24),
                    items: fontMap.keys.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),

                    onChanged: (value) {
                      setState(() {
                        _chosenValue = value!;
                      });
                    },
                  ),
                ),
              ),
            ),

            // Face Biometrics Set Up
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,

                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                title: Text(
                  'Face Biometrics Set Up',
                  style: GoogleFonts.prompt(
                    fontWeight: FontWeight.w500,
                    fontSize: tailorfontSize,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward, size: 24),
                // onTap: () {
                //   Navigator.push(
                //     context,
                //     // Navigate to BackupRestorePage()
                //     MaterialPageRoute(
                //       builder: (context) => TailorFacebiometrics(),
                //     ),
                //   );
                // },
              ),
            ),

            // Logout Container
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                title: Text(
                  'Logout',
                  style: GoogleFonts.prompt(
                    fontWeight: FontWeight.w500,
                    fontSize: tailorfontSize,
                  ),
                ),
                // trailing: IconButton(
                //   onPressed: () => widget.signUserOut(context),
                //   icon: const Icon(Icons.logout),
                // ),
              ),
            ),
            const SizedBox(height: 30),

            // Save Changes Container
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF72A0C1),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 70,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                print("First button clicked");
              },
              child: Text(
                "Save Changes",
                style: GoogleFonts.noticiaText(
                  fontWeight: FontWeight.w600,
                  fontSize: tailorfontSize,
                ),
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
