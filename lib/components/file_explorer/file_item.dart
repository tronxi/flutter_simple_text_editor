import 'package:flutter/material.dart';
import 'package:flutter_simple_text_editor/components/file_explorer/file_explorer_controller.dart';
import 'package:flutter_simple_text_editor/components/file_explorer/file_name_dialog.dart';
import 'package:flutter_simple_text_editor/components/file_explorer/file_node.dart';
import 'package:flutter_simple_text_editor/shared/file_model.dart';
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
      onSecondaryTap: _showContextualFileMenu,
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
                    fontWeight: FontWeight.bold,
                    color: isHover
                        ? Theme.of(context).fileExplorerItemSelected
                        : Theme.of(context).fileExplorerItemUnselected)),
          ],
        ),
      ),
    );
  }

  void _showContextualFileMenu() {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    final Offset offset = referenceBox.localToGlobal(Offset.zero);

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        offset,
        offset.translate(referenceBox.size.width, referenceBox.size.height),
      ),
      Offset.zero & overlay.size,
    );
    showMenu(
        context: context,
        position: position,
        color: Theme.of(context).editorBackground,
        items: [
          PopupMenuItem(
            onTap: () => _onRename(context),
            child: Text("Rename",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).editorFontColor)),
          ),
          PopupMenuItem(
            onTap: _onDelete,
            child: Text("Delete",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).editorFontColor)),
          )
        ]);
  }

  Future<void> _onRename(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return FileNameDialog(
              title: "New Name",
              onSelect: (String newFileName) {
                FileExplorerController fileExplorerController =
                    Get.put(FileExplorerController());
                EditorController editorController = Get.put(EditorController());
                FileModel oldFileModel = widget.fileNode.value;
                fileExplorerController.renameFile(widget.fileNode, newFileName);
                FileModel newFileModel = widget.fileNode.value;
                editorController.updateFileModelIfExist(oldFileModel, newFileModel);
              });
        });
  }

  void _onDelete() {
    FileExplorerController fileExplorerController =
        Get.put(FileExplorerController());
    EditorController editorController = Get.put(EditorController());

    fileExplorerController.removeFile(widget.fileNode);
    editorController.closeOpenFile(widget.fileNode.value);
  }

  void _onSelectItem() {
    EditorController editorController = Get.put(EditorController());
    editorController.setCurrentFile(widget.fileNode.value);
  }
}
