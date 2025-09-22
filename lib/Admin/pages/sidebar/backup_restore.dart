import 'package:flutter/material.dart';
import 'package:threadhub_system/Admin/pages/sidebar/menu.dart';

class BackupRestorePage extends StatefulWidget {
  const BackupRestorePage({super.key});

  @override
  State<BackupRestorePage> createState() => _BackupRestorePageState();
}

class _BackupRestorePageState extends State<BackupRestorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment'),
        backgroundColor: const Color(0xFF6082B6),
      ),
      body: const Center(child: Text('Appointment Page')),
      drawer: const Menu(),
    );
  }
}
