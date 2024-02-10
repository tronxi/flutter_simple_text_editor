import 'package:flutter/material.dart';
import 'package:flutter_simple_text_editor/components/editor/editor_controller.dart';
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
                      .map((fileName) => _OpenedFileItem(
                          editorController: controller, fileModel: fileName))
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
      {super.key, required this.editorController, required this.fileModel});

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
        child: Center(
          child: Obx(() => Text(
                fileModel.relativePath,
                style: TextStyle(
                    color: Theme.of(context).editorFontColor,
                    fontStyle:
                        editorController.getOpened(fileModel)!.needSave.value
                            ? FontStyle.italic
                            : null),
              )),
        ),
      ),
    );
  }

  void _onTap() {
    editorController.setCurrentFile(fileModel);
  }
}
