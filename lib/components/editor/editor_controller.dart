import 'package:flutter_simple_text_editor/components/editor/file_controller.dart';
import 'package:flutter_simple_text_editor/shared/file_model.dart';
import 'package:flutter_simple_text_editor/shared/file_system_manager.dart';
import 'package:get/get.dart';

class EditorController extends GetxController {
  Map<FileModel, FileController> openedFiles = {};
  FileSystemManager fileSystemManager = FileSystemManager();
  var openedFile = FileModel(absolutePath: "", relativePath: " ").obs;

  void setCurrentFile(FileModel current) async {
    openedFile.value = current;
    if (openedFiles[openedFile.value] == null) {
      openedFiles.putIfAbsent(current, () => FileController());
      openedFiles[current]?.setCurrentFileForFirstTime(current);
    } else {
      openedFiles.putIfAbsent(current, () => FileController());
      openedFiles[current]?.setCurrentFileForOpenedFile(current);
    }
  }

  void updateNeedSave(String newText) {
    openedFiles[openedFile.value]?.updateNeedSave(newText);
  }

  void save() {
    openedFiles[openedFile.value]?.save();
  }

  FileController? getOpened(FileModel opened) {
    return openedFiles[opened];
  }
}
