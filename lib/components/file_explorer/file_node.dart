import 'package:flutter_simple_text_editor/shared/file_model.dart';

class FileNode {
  FileModel value;
  int depth;
  List<FileNode> children = [];

  FileNode(this.value, this.depth);

  void add(FileNode child) {
    children.add(child);
  }
}
