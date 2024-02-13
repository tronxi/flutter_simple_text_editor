import 'package:flutter_simple_text_editor/shared/file_model.dart';

class FileNode {
  FileModel value;
  int depth;
  bool showChildren;
  List<FileNode> children = [];
  bool markAsDeleted;

  FileNode(
      {required this.value,
      required this.depth,
      required this.showChildren,
      required this.markAsDeleted});

  void add(FileNode child) {
    children.add(child);
  }
}
