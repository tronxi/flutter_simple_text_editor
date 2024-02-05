import 'package:get/get.dart';
import 'package:flutter_simple_text_editor/shared/file_system_manager.dart';

class FileExplorerController extends GetxController {
  FileSystemManager fileSystemManager = FileSystemManager();
  var currentFiles = <String>[].obs;

  void retrieveFiles() async{
    currentFiles.value = await fileSystemManager.retrieveFiles();
  }
}
