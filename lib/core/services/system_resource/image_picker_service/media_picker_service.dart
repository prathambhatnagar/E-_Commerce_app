import 'dart:io';
import 'package:file_picker/file_picker.dart';

class MediaPickerService {
  Future<List<File>> pickImages() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);
    if (result != null && result.files.isNotEmpty) {
      return result.files.map((file) => File(file.path!)).toList();
    }
    return [];
  }
}
