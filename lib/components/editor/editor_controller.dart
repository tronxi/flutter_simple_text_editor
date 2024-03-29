import 'package:flutter_simple_text_editor/components/editor/file_controller.dart';
import 'package:flutter_simple_text_editor/components/file_explorer/file_node.dart';
import 'package:flutter_simple_text_editor/shared/file_model.dart';
import 'package:flutter_simple_text_editor/shared/file_system_manager.dart';
import 'package:get/get.dart';

class EditorController extends GetxController {
  Map<FileModel, FileController> openedFiles = {};
  FileSystemManager fileSystemManager = FileSystemManager();
  var openedFile =
      FileModel(absolutePath: "", relativePath: " ", isDirectory: false).obs;

  void setCurrentFile(FileModel current) async {
    openedFile.value = current;
    if (openedFiles[openedFile.value] == null) {
      openedFiles.putIfAbsent(current, () => FileController());
      openedFiles[current]
          ?.setCurrentFileForFirstTime(current, openedFiles.entries.length);
    } else {
      openedFiles.putIfAbsent(current, () => FileController());
      openedFiles[current]?.setCurrentFileForOpenedFile(current);
    }
    update();
  }

  void updateNeedSave(String newText) {
    openedFiles[openedFile.value]?.updateNeedSave(newText);
  }

  void save() {
    openedFiles[openedFile.value]?.save();
  }

  void setCurrentOffset(int offset) {
    openedFiles[openedFile.value]?.setCurrentOffset(offset);
  }

  FileController? getOpened(FileModel opened) {
    return openedFiles[opened];
  }

  List<FileModel> retrieveOpenedFilesNames(FileModel opened) {
    List<MapEntry<FileModel, FileController>> entries =
        openedFiles.entries.toList();
    entries.sort((a, b) =>
        a.value.currentPosition.value.compareTo(b.value.currentPosition.value));
    List<FileModel> sortedKeys = entries.map((entry) => entry.key).toList();
    return sortedKeys;
  }

  bool isCurrentOpened(FileModel fileModel) {
    return fileModel == openedFile.value;
  }

  void closeOpenFile(FileModel fileModel) {
    if (fileModel == openedFile.value && openedFiles.keys.length > 1) {
      openedFiles.remove(fileModel);
      setCurrentFile(openedFiles.keys.first);
    } else {
      openedFiles.remove(fileModel);
    }
    update();
  }

  void closeOpenDirectory(FileNode fileNode) {
    if (!fileNode.value.isDirectory) {
      closeOpenFile(fileNode.value);
    } else {
      for (var child in fileNode.children) {
        closeOpenDirectory(child);
      }
    }
  }

  void updateFileModelIfExist(FileModel oldFileModel, FileModel newFileModel) {
    if (openedFiles.containsKey(oldFileModel)) {
      if (oldFileModel == openedFile.value) {
        final fileController = openedFiles.remove(oldFileModel);
        openedFiles.putIfAbsent(newFileModel, () => fileController!);
        openedFile.value = newFileModel;
        fileController!.setCurrentFileForOpenedFile(newFileModel);
      } else {
        final fileController = openedFiles.remove(oldFileModel);
        openedFiles.putIfAbsent(newFileModel, () => fileController!);
        fileController!.setCurrentFileForOpenedFile(newFileModel);
      }
      update();
    }
  }
}
