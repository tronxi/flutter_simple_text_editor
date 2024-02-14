import 'package:flutter/material.dart';
import 'package:flutter_simple_text_editor/components/file_explorer/file_explorer_controller.dart';
import 'package:flutter_simple_text_editor/components/file_explorer/file_name_dialog.dart';
import 'package:flutter_simple_text_editor/components/file_explorer/file_node.dart';
import 'package:get/get.dart';

class CreateFilesHelper {
  static Future<void> showFileNameDialog(
      BuildContext context, FileNode fileNode, bool isInParent) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return FileNameDialog(
              title: "File Name",
              onSelect: (String fileName) {
                FileExplorerController fileExplorerController =
                    Get.put(FileExplorerController());
                fileExplorerController.createFile(
                    fileNode, fileName, isInParent);
              });
        });
  }

  static Future<void> showFolderNameDialog(
      BuildContext context, FileNode fileNode, bool isInParent) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return FileNameDialog(
              title: "Folder Name",
              onSelect: (String folderName) {
                FileExplorerController fileExplorerController =
                    Get.put(FileExplorerController());
                fileExplorerController.createFolder(
                    fileNode, folderName, isInParent);
              });
        });
  }
}
