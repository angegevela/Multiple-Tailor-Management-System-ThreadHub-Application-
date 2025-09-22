import 'package:file_picker/file_picker.dart';

class UploadFile {
  final PlatformFile file;
  final String filePath;
  double progress;
  bool isUploading;
  bool isPaused;

  UploadFile(
    this.file, {
    required this.filePath,
    this.progress = 0.0,
    this.isUploading = true,
    this.isPaused = false,
  });
}
