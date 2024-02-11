import 'package:flutter_simple_text_editor/shared/file_model.dart';

class FileNode {
  FileModel value;
  int depth;
  bool showChildren;
  List<FileNode> children = [];

  FileNode(this.value, this.depth, this.showChildren);

  void add(FileNode child) {
    children.add(child);
  }
}
