import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FileSystemManager {
  var systemTempDir = Directory.systemTemp;

  Future<List<String>> retrieveFiles() async {
    List<String> files = [];
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    var systemTempDir = Directory(selectedDirectory!);

    await for (var entity
        in systemTempDir.list(recursive: true, followLinks: false)) {
      files.add(entity.path);
    }
    return files;
  }
}
