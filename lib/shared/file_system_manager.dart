import 'dart:io';
import 'package:flutter_simple_text_editor/components/file_explorer/file_node.dart';
import 'package:flutter_simple_text_editor/shared/file_model.dart';
import 'package:path/path.dart' as path;

import 'package:file_picker/file_picker.dart';

class FileSystemManager {
  Future<String?> selectDirectoryPath() async {
    return FilePicker.platform.getDirectoryPath();
  }

  String retrieveDirectoryName(String directoryPath) {
    Directory directory = Directory(directoryPath);
    return directory.uri.pathSegments[directory.uri.pathSegments.length - 2];
  }

  Future<List<FileModel>> retrieveFiles(String selectedDirectory) async {
    List<FileModel> files = [];
    var systemTempDir = Directory(selectedDirectory);

    await for (var entity
        in systemTempDir.list(recursive: false, followLinks: false)) {
      String relativePath = path.relative(entity.path, from: selectedDirectory);
      bool isFile = entity is Directory;
      files.add(FileModel(
          absolutePath: entity.path,
          relativePath: relativePath,
          isDirectory: isFile));
    }
    return files;
  }

  Future<String> retrieveFile(String filePath) async {
    try {
      File file = File(filePath);

      if (await file.exists()) {
        String contents = await file.readAsString();
        return contents;
      } else {
        return "";
      }
    } catch (e) {
      return "File: $filePath not supported \n $e";
    }
  }

  void save(String filePath, String newText) {
    File file = File(filePath);
    file.writeAsString(newText);
  }

  void removeFile(String filePath) {
    File file = File(filePath);
    file.deleteSync(recursive: true);
  }

  FileNode createFile(FileNode fileNode, String fileName) {
    String newFilePath = path.join(fileNode.value.absolutePath, fileName);
    File newFile = File(newFilePath);
    newFile.createSync();
    FileModel fileModel = FileModel(
        absolutePath: newFilePath, relativePath: fileName, isDirectory: false);
    return FileNode(
        value: fileModel,
        depth: fileNode.depth + 1,
        showChildren: false,
        markAsDeleted: false);
  }

  FileNode createFolder(FileNode fileNode, String folderName) {
    String newFolderPath = path.join(fileNode.value.absolutePath, folderName);
    Directory newFolder = Directory(newFolderPath);
    newFolder.createSync();
    FileModel fileModel = FileModel(
        absolutePath: newFolderPath,
        relativePath: folderName,
        isDirectory: true);
    return FileNode(
        value: fileModel,
        depth: fileNode.depth + 1,
        showChildren: false,
        markAsDeleted: false);
  }
}
