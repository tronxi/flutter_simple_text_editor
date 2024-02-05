import 'package:flutter/material.dart';
import 'package:flutter_simple_text_editor/shared/file_model.dart';
import 'package:get/get.dart';
import 'package:flutter_simple_text_editor/components/editor/editor_controller.dart';
import 'package:flutter_simple_text_editor/shared/colors.dart';

class FileItem extends StatefulWidget {
  final FileModel file;
  const FileItem({super.key, required this.file});

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
      child: Text(widget.file.relativePath,
          style: TextStyle(
              color: isHover
                  ? Theme.of(context).fileExplorerItemSelected
                  : Theme.of(context).fileExplorerItemUnselected)),
    );
  }

  void _onSelectItem() {
    EditorController editorController = Get.put(EditorController());
    editorController.setCurrentFile(widget.file);
  }
}
