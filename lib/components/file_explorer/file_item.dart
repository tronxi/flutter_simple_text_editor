import 'package:flutter/material.dart';
import 'package:flutter_simple_text_editor/components/file_explorer/file_node.dart';
import 'package:get/get.dart';
import 'package:flutter_simple_text_editor/components/editor/editor_controller.dart';
import 'package:flutter_simple_text_editor/shared/colors.dart';

class FileItem extends StatefulWidget {
  final FileNode fileNode;
  const FileItem({super.key, required this.fileNode});

  @override
  State<FileItem> createState() => _FileItemState();
}

class _FileItemState extends State<FileItem> {
  bool isHover = false;

  @override
  void initState() {
    super.initState();
    isHover = false;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onSelectItem,
      onHover: (value) {
        setState(() {
          isHover = value;
        });
      },
      child: Container(
        constraints: const BoxConstraints(minWidth: 240),
        child: Row(
          children: [
            SizedBox(width: widget.fileNode.depth * 20.0),
            Text(widget.fileNode.value.relativePath,
                style: TextStyle(
                    fontSize: 16,
                    color: isHover
                        ? Theme.of(context).fileExplorerItemSelected
                        : Theme.of(context).fileExplorerItemUnselected)),
          ],
        ),
      ),
    );
  }

  void _onSelectItem() {
    EditorController editorController = Get.put(EditorController());
    editorController.setCurrentFile(widget.fileNode.value);
  }
}
