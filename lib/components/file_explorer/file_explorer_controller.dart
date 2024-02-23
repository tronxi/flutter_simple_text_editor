import 'package:flutter_simple_text_editor/components/file_explorer/file_node.dart';
import 'package:flutter_simple_text_editor/shared/file_model.dart';
import 'package:get/get.dart';
import 'package:flutter_simple_text_editor/shared/file_system_manager.dart';

class FileExplorerController extends GetxController {
  FileSystemManager fileSystemManager = FileSystemManager();
  var currentFilesTree = FileNode(
          value:
              FileModel(absolutePath: "", relativePath: "", isDirectory: false),
          depth: 0,
          showChildren: false,
          markAsDeleted: false)
      .obs;

  var selectedDirectoryName = "".obs;
  var selectedPath = "".obs;

  void retrieveFiles() async {
    String? directoryPath = await fileSystemManager.selectDirectoryPath();
    if (directoryPath != null) {
      selectedPath.value = directoryPath;
      selectedDirectoryName.value =
          fileSystemManager.retrieveDirectoryName(directoryPath);
      FileModel parent = FileModel(
          absolutePath: directoryPath,
          relativePath: directoryPath,
          isDirectory: true);
      FileNode parentNode = FileNode(
          value: parent, depth: 0, showChildren: false, markAsDeleted: false);
      await retrieveFilesInDirectory(parentNode, parentNode.depth);
      currentFilesTree.value = parentNode;
    }
  }

  Future<void> retrieveFilesInDirectory(FileNode fileNode, int depth) async {
    List<FileModel> filesInDirectory =
        await fileSystemManager.retrieveFiles(fileNode.value.absolutePath);
    for (var file in filesInDirectory) {
      if (!file.isDirectory) {
        FileNode newFileNode = FileNode(
            value: file,
            depth: depth,
            showChildren: false,
            markAsDeleted: false);
        fileNode.add(newFileNode);
      } else {
        FileNode newFileNode = FileNode(
            value: file,
            depth: depth,
            showChildren: false,
            markAsDeleted: false);
        fileNode.add(newFileNode);
        await retrieveFilesInDirectory(newFileNode, depth + 1);
      }
    }
  }

  void refreshFiles() async {
    if (selectedPath.value != "") {
      FileModel parent = FileModel(
          absolutePath: selectedPath.value,
          relativePath: selectedPath.value,
          isDirectory: true);
      FileNode parentNode = FileNode(
          value: parent, depth: 0, showChildren: false, markAsDeleted: false);
      await retrieveFilesInDirectory(parentNode, parentNode.depth);
      currentFilesTree.value = parentNode;
    }
  }

  void toggleShowChildren(FileNode fileNode) {
    fileNode.showChildren = !fileNode.showChildren;
    update();
  }

  void removeFile(FileNode fileNode) {
    fileSystemManager.removeFile(fileNode.value.absolutePath);
    fileNode.markAsDeleted = true;
    update();
  }

  void createFile(FileNode fileNode, String fileName, bool isInParent) {
    FileNode newFileNode =
        fileSystemManager.createFile(fileNode, fileName, isInParent);
    fileNode.add(newFileNode);
    update();
  }

  void createFolder(FileNode fileNode, String folderName, bool isInParent) {
    FileNode newFileNode =
        fileSystemManager.createFolder(fileNode, folderName, isInParent);
    fileNode.add(newFileNode);
    update();
  }

  void renameFile(FileNode fileNode, String newFileName) {
    FileModel newFileModel =
        fileSystemManager.renameFile(fileNode, newFileName);
    fileNode.value = newFileModel;
    update();
  }

  void renameFolder(FileNode fileNode, String newFolderName) {
    FileModel newFileModel =
    fileSystemManager.renameFolder(fileNode, newFolderName);
    fileNode.value = newFileModel;
    //TODO rename children recursive
    update();
  }
}
