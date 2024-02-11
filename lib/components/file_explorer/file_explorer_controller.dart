import 'package:flutter_simple_text_editor/components/file_explorer/file_node.dart';
import 'package:flutter_simple_text_editor/shared/file_model.dart';
import 'package:get/get.dart';
import 'package:flutter_simple_text_editor/shared/file_system_manager.dart';

class FileExplorerController extends GetxController {
  FileSystemManager fileSystemManager = FileSystemManager();
  var currentFilesTree = FileNode(
          FileModel(absolutePath: "", relativePath: "", isDirectory: false), 0)
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
      FileNode parentNode = FileNode(parent, 0);
      await retrieveFilesInDirectory(parentNode, parentNode.depth);
      currentFilesTree.value = parentNode;
    }
  }

  Future<void> retrieveFilesInDirectory(FileNode fileNode, int depth) async {
    List<FileModel> filesInDirectory =
        await fileSystemManager.retrieveFiles(fileNode.value.absolutePath);
    for (var file in filesInDirectory) {
      if (!file.isDirectory) {
        FileNode newFileNode = FileNode(file, depth);
        fileNode.add(newFileNode);
      } else {
        FileNode newFileNode = FileNode(file, depth);
        fileNode.add(newFileNode);
        await retrieveFilesInDirectory(newFileNode, depth + 1);
      }
    }
  }

  void refreshFiles() async {
    if (selectedPath.value != "") {
      // currentFiles.value =
      //     await fileSystemManager.retrieveFiles(selectedPath.value);
    }
  }
}
