import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_simple_text_editor/shared/file_model.dart';
import 'package:flutter_simple_text_editor/shared/file_system_manager.dart';

class FileController {
  FileSystemManager fileSystemManager = FileSystemManager();
  var currentFile =
      FileModel(absolutePath: "", relativePath: " ", isDirectory: false).obs;
  var currentFileContent = "";
  var currentOffset = 0.obs;
  var currentFileController = TextEditingController().obs;
  var needSave = false.obs;
  var currentPosition = 0.obs;

  void setCurrentFileForFirstTime(FileModel current, int position) async {
    currentFile.value = current;
    needSave.value = false;
    currentOffset.value = 0;
    currentPosition.value = position;
    currentFileContent =
        await fileSystemManager.retrieveFile(current.absolutePath);
    currentFileController.value =
        TextEditingController(text: currentFileContent);
  }

  void setCurrentFileForOpenedFile(FileModel current) async {
    currentFile.value = current;
  }

  void updateNeedSave(String newText) {
    needSave.value = currentFileContent != newText;
  }

  void setCurrentOffset(int offset) {
    currentOffset.value = offset;
  }

  void save() {
    fileSystemManager.save(
        currentFile.value.absolutePath, currentFileController.value.text);
    setCurrentFileForFirstTime(currentFile.value, currentPosition.value);
  }
}
