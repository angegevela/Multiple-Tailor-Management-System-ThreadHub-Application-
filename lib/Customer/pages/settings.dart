import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:threadhub_system/Customer/pages/facebiometrics.dart';
import 'package:threadhub_system/Customer/pages/help.dart';
import 'package:threadhub_system/Customer/pages/personal_info.dart';
import 'package:threadhub_system/Pages/login_page.dart';
import 'font_provider.dart';

class CustomerSettings extends StatefulWidget {
  const CustomerSettings({super.key});

  @override
  State<CustomerSettings> createState() => _CustomerSettingsState();
}

class _CustomerSettingsState extends State<CustomerSettings> {
  final firebaseUser = FirebaseAuth.instance.currentUser;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  String? fullName;
  String? role;
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
    _loadUserData();
  }

  Future<void> signUserOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(showRegisterPage: () {}),
      ),
    );
  }

  Future<void> _loadUserProfile() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    final response = await Supabase.instance.client
        .from('profile-users')
        .select('pictures')
        .eq('id', user.id)
        .maybeSingle();

    if (response != null && response['pictures'] != null) {
      setState(() {
        _profileImageUrl = response['pictures'];
      });
    }
  }

  Future<void> _loadUserData() async {
    if (firebaseUser == null) return;

    final doc = await FirebaseFirestore.instance
        .collection("Users") 
        .doc(firebaseUser!.uid)
        .get();

    if (doc.exists) {
      final data = doc.data();
      setState(() {
        fullName = "${data?['firstName']} ${data?['surname']}";
        role = data?['role'] ?? "No role";
      });
    }
  }

  bool notificationsEnabled = false;

  //Dark Mode Logics
  bool darkmode_toggle = false;

  @override
  Widget build(BuildContext context) {
    final fontSize = context.watch<FontProvider>().fontSize;
    return Scaffold(
      backgroundColor: Color(0xFFD9D9D9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6082B6),
        title: Text(
          'Back',
          style: GoogleFonts.moul(
            fontSize: 18,
            fontWeight: FontWeight.w300,
            color: Colors.black,
          ),
        ),
      ),
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

            const SizedBox(height: 10),
            const SizedBox(height: 10),
            Text(
              fullName ?? "Loading name...",
              style: GoogleFonts.moul(
                textStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              role ?? "Loading role...",
              style: GoogleFonts.montserratAlternates(
                textStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Personal Information Header
            Container(
              height: 50,
              width: 350,
              decoration: BoxDecoration(color: const Color(0xFF002244)),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PersonalInformationPage(),
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
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Personal Information',
                    style: GoogleFonts.moul(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Notification toggle
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              decoration: BoxDecoration(color: Colors.white),
              child: SwitchListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                title: Text(
                  'Notifications',
                  style: GoogleFonts.montserratAlternates(fontSize: fontSize),
                ),
                value: notificationsEnabled,
                onChanged: (bool value) {
                  setState(() {
                    notificationsEnabled = value;
                  });
                },
              ),
            ),

            //Dark Mode toggle
            const SizedBox(height: 2),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              decoration: BoxDecoration(color: Colors.white),
              child: SwitchListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                title: Text(
                  'Dark Mode',
                  style: GoogleFonts.montserratAlternates(fontSize: fontSize),
                ),
                value: darkmode_toggle,
                onChanged: (bool value) {
                  setState(() {
                    darkmode_toggle = value;
                  });
                },
              ),
            ),

            // Help ListTile
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              decoration: BoxDecoration(color: Colors.white),
              child: ListTile(
                title: Text(
                  'Help',
                  style: GoogleFonts.montserratAlternates(fontSize: fontSize),
                ),
                trailing: const Icon(Icons.chevron_right, size: 32),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CustomerHelpPage()),
                  );
                },
              ),
            ),

            // Face Biometrics Set Up
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              decoration: BoxDecoration(color: Colors.white),
              child: ListTile(
                title: Text(
                  'Face Biometrics Set Up',
                  style: GoogleFonts.montserratAlternates(fontSize: fontSize),
                ),
                trailing: const Icon(Icons.chevron_right, size: 32),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Facebiometrics()),
                  );
                },
              ),
            ),

            // Font Size Dropdown
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              decoration: const BoxDecoration(color: Colors.white),
              child: ListTile(
                title: Text(
                  'Font Size',
                  style: GoogleFonts.montserratAlternates(
                    textStyle: TextStyle(
                      fontSize: context.watch<FontProvider>().fontSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                trailing: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: context
                        .watch<FontProvider>()
                        .chosenValue, // current value
                    style: GoogleFonts.montserratAlternates(
                      textStyle: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    dropdownColor: const Color(0xFFD9EAFD),
                    icon: const Icon(Icons.arrow_drop_down, size: 28),
                    items: context.read<FontProvider>().fontOptions.keys.map((
                      String value,
                    ) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        context.read<FontProvider>().setFontSize(value);
                      }
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 5),
            //Logout Listtile
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              decoration: BoxDecoration(color: Colors.white),
              child: ListTile(
                title: Text(
                  'Logout',
                  style: GoogleFonts.montserratAlternates(fontSize: fontSize),
                ),
                trailing: IconButton(
                  onPressed: () => signUserOut(context),
                  icon: const Icon(Icons.logout),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
