import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:threadhub_system/Customer/pages/font_provider.dart';

class PersonalInformationPage extends StatefulWidget {
  const PersonalInformationPage({super.key});

  @override
  _PersonalInformationPageState createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  String? _profileImageUrl;
  File? _imageFile;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      setState(() => _isLoading = false);
      return;
    }

    try {
      final doc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .get();

      if (doc.exists) {
        final data = doc.data()!;
        setState(() {
          _fullNameController.text =
              "${data['firstName'] ?? ''} ${data['surname'] ?? ''}";
          _usernameController.text = data['username'] ?? '';
          _phoneController.text = data['phoneNumber']?.toString() ?? '';
          _emailController.text = data['email'] ?? user.email ?? '';
          _addressController.text = data['address'] ?? '';
          _profileImageUrl = data['profileImageUrl'] ?? '';
        });
      }

      setState(() => _isLoading = false);
    } catch (e) {
      debugPrint("Load error: $e");
      setState(() => _isLoading = false);
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile == null) return;

    final file = File(pickedFile.path);
    setState(() => _imageFile = file);

    try {
      // Use FirebaseAuth since you’re not authenticating via Supabase
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        debugPrint("Firebase user not found.");
        return;
      }

      final userId = user.uid;
      final fileExt = file.path.split('.').last;
      final fileName = '$userId.$fileExt';
      final filePath = 'pictures/$fileName';

      debugPrint("Uploading to Supabase: $filePath");

      // Upload to the correct bucket
      await Supabase.instance.client.storage
          .from('profile-user')
          .upload(filePath, file, fileOptions: const FileOptions(upsert: true));

      debugPrint("Upload complete.");

      // Get the public URL
      final publicUrl = Supabase.instance.client.storage
          .from('profile-user')
          .getPublicUrl(filePath);

      debugPrint("Generated URL: $publicUrl");

      // Update Firestore
      await FirebaseFirestore.instance.collection('Users').doc(userId).update({
        'profileImageUrl': publicUrl,
      });

      debugPrint("Firestore updated with profileImageUrl.");

      // Update state to show uploaded image
      setState(() {
        _profileImageUrl = publicUrl;
        _imageFile = null; // remove temporary file
      });
    } catch (e, st) {
      debugPrint("Upload error: $e");
      debugPrint(st.toString());
    }
  }

  Future<void> _saveChanges() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .update({
            'username': _usernameController.text.trim(),
            'phoneNumber': _phoneController.text.trim(),
            'address': _addressController.text.trim(),
            'profileImageUrl': _profileImageUrl ?? '',
          });

      await _loadUserData();

      if (!mounted) return;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text("Saved"),
          content: const Text("Your changes have been saved."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("Agree"),
            ),
          ],
        ),
      );
    } catch (e) {
      debugPrint("Save error: $e");
    }
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    bool readOnly = false,
    String? hint,
    int maxLines = 1,
  }) {
    return Builder(
      builder: (context) {
        final fontSize = context
            .watch<FontProvider>()
            .fontSize;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: fontSize, 
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              TextFormField(
                controller: controller,
                readOnly: readOnly,
                maxLines: maxLines,
                decoration: InputDecoration(
                  hintText: hint ?? label,
                  contentPadding: const EdgeInsets.all(12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: Colors.deepPurple,
                      width: 2.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final fontSize = context.watch<FontProvider>().fontSize;

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
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 90,
                    backgroundColor: Colors.black,
                    child: _imageFile != null
                        ? CircleAvatar(
                            radius: 88,
                            backgroundImage: FileImage(_imageFile!),
                          )
                        : (_profileImageUrl != null &&
                              _profileImageUrl!.isNotEmpty)
                        ? CircleAvatar(
                            radius: 88,
                            backgroundImage: NetworkImage(_profileImageUrl!),
                          )
                        : const CircleAvatar(
                            radius: 88,
                            backgroundColor: Colors.grey,
                            child: Icon(
                              Icons.person,
                              size: 60,
                              color: Colors.white,
                            ),
                          ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.blueGrey,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.image_outlined,
                          size: 25,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildInputField(
              label: 'Full Name',
              controller: _fullNameController,
              readOnly: true,
            ),
            _buildInputField(
              label: 'Username',
              controller: _usernameController,
            ),
            _buildInputField(
              label: 'Phone Number',
              controller: _phoneController,
            ),
            _buildInputField(
              label: 'Email Address',
              controller: _emailController,
              readOnly: true,
            ),
            _buildInputField(
              label: 'Address',
              controller: _addressController,
              maxLines: 3,
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: _saveChanges,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 14,
                ),
              ),
              child: Text(
                'Save Changes',
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
