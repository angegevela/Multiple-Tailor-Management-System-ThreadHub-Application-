import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:threadhub_system/Admin/login/admin_homepage.dart';
import 'package:threadhub_system/Admin/pages/sidebar/appointment.dart';
import 'package:threadhub_system/Admin/pages/sidebar/backup_restore.dart';
import 'package:threadhub_system/Admin/pages/sidebar/people.dart';
import 'package:threadhub_system/Admin/pages/sidebar/report_management.dart';


class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFFD6E5FA),
      width: 254,
      child: ListView(
        children: [
          SizedBox(
            height: 50,
            child: Center(
              child: Text(
                'ADMIN',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          //Dashboard Menu Bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              color: Color(0xFF334257),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: const Icon(Icons.dashboard, color: Colors.white),
              title: Text(
                'Dashboard',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        AdminHomePage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                    transitionDuration: const Duration(
                      milliseconds: 300,
                    ), // Optional: adjust speed
                  ),
                );
              },
            ),
          ),

          //Appointment Menu Bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              color: Color(0xFF334257),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: const Icon(Icons.calendar_month, color: Colors.white),
              title: Text(
                'Appointments',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // navigate to SettingsPage...
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppointmentPage()),
                );
              },
            ),
          ),

          //People Menu Bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              color: Color(0xFF334257),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: Text(
                'People',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // navigate to
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UsersPage()),
                );
              },
            ),
          ),

          //Report Management Menu Bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              color: Color(0xFF334257),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: const Icon(Icons.report, color: Colors.white),
              title: Text(
                'Report Management',
                style: GoogleFonts.poppins(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // navigate to Report Management Page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReportManagementPage(),
                  ),
                );
              },
            ),
          ),

          //Backup and Restore Menu Bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              color: Color(0xFF334257),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.restore_page_rounded,
                color: Colors.white,
              ),
              title: Text(
                'Backup And Restore',
                style: GoogleFonts.poppins(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.pop(
                  context,
                ); // Navigation to Go Back to Previous Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BackupRestorePage()),
                );
              },
            ),
          ),

          //Logout Menu Bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 320),
            decoration: BoxDecoration(
              color: Color(0xFF334257),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: const Icon(Icons.logout_sharp, color: Colors.white),
              title: Text(
                'Logout',
                style: GoogleFonts.poppins(
                  fontSize: 19,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // navigate to SettingsPage...
              },
            ),
          ),
        ],
      ),
    );
  }
}
