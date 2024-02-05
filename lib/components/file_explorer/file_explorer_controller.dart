import 'package:flutter_simple_text_editor/shared/file_model.dart';
import 'package:get/get.dart';
import 'package:flutter_simple_text_editor/shared/file_system_manager.dart';

class FileExplorerController extends GetxController {
  FileSystemManager fileSystemManager = FileSystemManager();
  var currentFiles = <FileModel>[].obs;
  var selectedDirectoryName = "".obs;
  var selectedPath = "".obs;

  void retrieveFiles() async {
    String? directoryPath = await fileSystemManager.selectDirectoryPath();
    if (directoryPath != null) {
      selectedPath.value = directoryPath;
      selectedDirectoryName.value =
          fileSystemManager.retrieveDirectoryName(directoryPath);
      currentFiles.value = await fileSystemManager.retrieveFiles(directoryPath);
    }
  }

  void refreshFiles() async {
    if (selectedPath.value != "") {
      currentFiles.value =
          await fileSystemManager.retrieveFiles(selectedPath.value);
    }
  }
}
