import 'package:flutter/material.dart';
import 'package:flutter_simple_text_editor/components/file_explorer/file_explorer_controller.dart';
import 'package:flutter_simple_text_editor/components/file_explorer/file_node.dart';
import 'package:get/get.dart';
import 'package:flutter_simple_text_editor/shared/colors.dart';

class DirectoryItem extends StatefulWidget {
  final FileNode fileNode;
  const DirectoryItem({super.key, required this.fileNode});

  @override
  State<DirectoryItem> createState() => _DirectoryItemState();
}

class _DirectoryItemState extends State<DirectoryItem> {
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
            Text(widget.fileNode.showChildren ? "▼ " : "▶ ",
                style: TextStyle(
                    fontSize: 12,
                    color: isHover
                        ? Theme.of(context).fileExplorerItemSelected
                        : Theme.of(context).fileExplorerItemUnselected)),
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
    FileExplorerController fileExplorerController =
        Get.put(FileExplorerController());
    fileExplorerController.toggleShowChildren(widget.fileNode);
  }
}
