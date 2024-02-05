import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_simple_text_editor/shared/file_model.dart';
import 'package:flutter_simple_text_editor/shared/file_system_manager.dart';

class FileController {
  FileSystemManager fileSystemManager = FileSystemManager();
  var currentFile = FileModel(absolutePath: "", relativePath: " ").obs;
  var currentFileContent = "";
  var currentFileController = TextEditingController().obs;
  var needSave = false.obs;

  void setCurrentFileForFirstTime(FileModel current) async {
    currentFile.value = current;
    needSave.value = false;
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

  void save() {
    fileSystemManager.save(
        currentFile.value.absolutePath, currentFileController.value.text);
    setCurrentFileForFirstTime(currentFile.value);
  }
}
