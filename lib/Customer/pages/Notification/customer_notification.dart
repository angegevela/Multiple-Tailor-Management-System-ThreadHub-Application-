import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:threadhub_system/Customer/pages/font_provider.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart' as tz;

class CustomerNotification extends StatefulWidget {
  const CustomerNotification({super.key});

  @override
  State<CustomerNotification> createState() => _CustomerNotificationState();
}

class _CustomerNotificationState extends State<CustomerNotification> {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Manila'));

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/launcher_icon',
    );
    const iosSettings = DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await notificationsPlugin.initialize(initializationSettings);
    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  void _showMessageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => MessageDialog(
        onYes: () {
          Navigator.pop(context);
          _scheduleTestNotification();
        },
        onNo: () {
          Navigator.pop(context);
        },
        onAskLater: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Future<void> _scheduleTestNotification() async {
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        'test_channel',
        'Test Channel',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: const DarwinNotificationDetails(),
    );

    await notificationsPlugin.zonedSchedule(
      0,
      'Reminder',
      'This is a scheduled test notification!',
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }


  Future<void> _showInstantNotification() async {
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        'instant_channel',
        'Instant Channel',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: const DarwinNotificationDetails(),
    );

    await notificationsPlugin.show(
      1,
      'Hello!',
      'This is an instant test notification.',
      details,
    );
  }

  @override
  Widget build(BuildContext context) {
    final fontSize = context.watch<FontProvider>().fontSize;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: const Color(0xFF262633),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                'Notifications',
                style: GoogleFonts.chauPhilomeneOne(
                  color: Colors.white,
                  fontSize: fontSize,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFD9D9D9),
      body: ListView(
        children: [
          NotificationTile(
            title: "Your appointment has been processed",
            subtitle:
                "We will update you for some time to the tailor and shops that can cater your appointment. Thank you!",
          ),
          const BlackDivider(),
          NotificationTile(
            title: "New Message from Diamond Tailor Shop",
            subtitle: "",
            onTap: () => _showMessageDialog(context),
          ),
          const BlackDivider(),
          NotificationTile(
            title: "Tailors inputted some price in your appointment",
            subtitle:
                "You can check some tailor in the area that can cater your appointment!",
          ),
          const BlackDivider(),
          NotificationTile(
            title: "Someone reported you",
            subtitle:
                "You can check this report if needed and you can appeal if it is not you.",
          ),
          const BlackDivider(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showInstantNotification,
        child: const Icon(Icons.notifications),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const NotificationTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final fontSize = context.watch<FontProvider>().fontSize;
    return InkWell(
      onTap: onTap,
      child: Container(
        color: const Color(0xFFC6D7E5),
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 45,
              height: 45,
              child: Icon(Icons.image, color: Colors.black54, size: 52),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.notoSerifMyanmar(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.montserrat(
                      fontSize: fontSize,
                      color: Colors.black87,
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
}

class BlackDivider extends StatelessWidget {
  const BlackDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(height: 1.5, color: Colors.black);
  }
}

class MessageDialog extends StatelessWidget {
  final VoidCallback onYes;
  final VoidCallback onNo;
  final VoidCallback onAskLater;

  const MessageDialog({
    super.key,
    required this.onYes,
    required this.onNo,
    required this.onAskLater,
  });

  @override
  Widget build(BuildContext context) {
    final fontSize = context.watch<FontProvider>().fontSize;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: StatefulBuilder(
        builder: (context, setState) {
          String selected = "yes";
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLineIndicator(selected),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.zero,
                ),
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Checking in...",
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Image.asset(
                      "assets/icons/notif-message.png",
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "The shop noticed the date of your due date, "
                      "is there a possibility that you can move it?",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.workSans(fontSize: fontSize),
                    ),
                    const SizedBox(height: 16),
                    const Divider(height: 1, color: Colors.black26),
                    TextButton(
                      onPressed: () {
                        setState(() => selected = "yes");
                        onYes();
                      },
                      style: TextButton.styleFrom(
                        minimumSize: const Size.fromHeight(45),
                        backgroundColor: selected == "yes"
                            ? const Color(0xFF4F959D)
                            : Colors.transparent,
                        foregroundColor: selected == "yes"
                            ? Colors.white
                            : Colors.black,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: Text(
                        "Yes",
                        style: GoogleFonts.workSans(
                          fontWeight: FontWeight.w500,
                          fontSize: fontSize,
                        ),
                      ),
                    ),
                    const Divider(height: 1, color: Colors.black26),
                    TextButton(
                      onPressed: () {
                        setState(() => selected = "no");
                        onNo();
                      },
                      style: TextButton.styleFrom(
                        minimumSize: const Size.fromHeight(45),
                        backgroundColor: selected == "no"
                            ? const Color(0xFF4F959D)
                            : Colors.transparent,
                        foregroundColor: selected == "no"
                            ? Colors.white
                            : Colors.black,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: Text(
                        "No",
                        style: GoogleFonts.workSans(
                          fontWeight: FontWeight.w500,
                          fontSize: fontSize,
                        ),
                      ),
                    ),
                    const Divider(height: 1, color: Colors.black26),
                    const SizedBox(height: 16),
                    Text(
                      "Diamond Tailor Shop",
                      style: GoogleFonts.workSans(
                        fontWeight: FontWeight.w900,
                        fontSize: fontSize,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  setState(() => selected = "later");
                  onAskLater();
                },
                child: Text(
                  "ASK ME LATER",
                  style: GoogleFonts.workSans(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

Widget _buildLineIndicator(String selected) {
  return Row(
    children: [
      Expanded(
        child: Container(
          height: 4,
          color: selected == "yes" ? Colors.teal : Colors.grey[300],
        ),
      ),
      const SizedBox(width: 4),
      Expanded(
        child: Container(
          height: 4,
          color: selected == "no" ? Colors.teal : Colors.grey[300],
        ),
      ),
      const SizedBox(width: 4),
      Expanded(
        child: Container(
          height: 4,
          color: selected == "later" ? Colors.teal : Colors.grey[300],
        ),
      ),
    ],
  );
}
