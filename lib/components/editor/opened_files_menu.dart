import 'package:flutter/material.dart';
import 'package:flutter_simple_text_editor/components/editor/editor_controller.dart';
import 'package:flutter_simple_text_editor/components/editor/file_close_dialog.dart';
import 'package:flutter_simple_text_editor/shared/colors.dart';
import 'package:flutter_simple_text_editor/shared/file_model.dart';
import 'package:get/get.dart';

class OpenedFilesMenu extends StatelessWidget {
  const OpenedFilesMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditorController>(builder: (controller) {
      return Obx(() => Container(
            width: double.infinity,
            color: Theme.of(context).editorFileTab,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: controller
                      .retrieveOpenedFilesNames(controller.openedFile.value)
                      .map((fileModel) => _OpenedFileItem(
                          editorController: controller, fileModel: fileModel))
                      .toList()),
            ),
          ));
    });
  }
}

class _OpenedFileItem extends StatelessWidget {
  final EditorController editorController;
  final FileModel fileModel;
  const _OpenedFileItem(
      {required this.editorController, required this.fileModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: editorController.isCurrentOpened(fileModel)
              ? Theme.of(context).editorBackground
              : Theme.of(context).sideBarBackground,
          border: Border(
              left: BorderSide(
                  width: 1.0, color: Theme.of(context).fileExplorerBorder),
              right: BorderSide(
                  width: 1.0, color: Theme.of(context).fileExplorerBorder)),
        ),
        height: 40,
        child: Obx(() => Row(
              children: [
                Text(
                  fileModel.relativePath,
                  style: TextStyle(
                      color: Theme.of(context).editorFontColor,
                      fontWeight: FontWeight.bold,
                      fontStyle:
                          editorController.getOpened(fileModel)!.needSave.value
                              ? FontStyle.italic
                              : null),
                ),
                const SizedBox(width: 10),
                IconButton(
                    onPressed: () => _onClosed(context),
                    icon: Container(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.close_sharp,
                        size: 12,
                        color: Theme.of(context).editorFontColor,
                      ),
                    ),
                    padding: EdgeInsets.zero)
              ],
            )),
      ),
    );
  }

  void _onTap() {
    editorController.setCurrentFile(fileModel);
  }

  void _onClosed(BuildContext context) {
    if (editorController.getOpened(fileModel)!.needSave.value) {
      _closeDialogBuilder(context);
    } else {
      editorController.closeOpenFile(fileModel);
    }
  }

  Future<void> _closeDialogBuilder(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return FileCloseDialog(
              filePath: fileModel.relativePath,
              onSave: _onSave,
              onCancel: _onCancel,
              onDontSave: _onDontSave);
        });
  }

  void _onSave() {
    editorController.save();
    editorController.closeOpenFile(fileModel);
  }

  void _onCancel() {}

  void _onDontSave() {
    editorController.closeOpenFile(fileModel);
  }
}
