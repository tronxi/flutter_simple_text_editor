import 'package:flutter/material.dart';
import 'package:flutter_simple_text_editor/components/editor/editor_area_painter.dart';
import 'package:flutter_simple_text_editor/components/editor/editor_controller.dart';
import 'package:flutter_simple_text_editor/shared/colors.dart';
import 'package:flutter_simple_text_editor/shared/file_model.dart';
import 'package:get/get.dart';

class EditorArea extends StatelessWidget {
  final EditorController editorController;
  final FileModel fileModel;
  EditorArea(
      {super.key, required this.editorController, required this.fileModel}) {
    editorController
        .getOpened(fileModel)!
        .currentFileController
        .value
        .addListener(() {
      int currentOffset = editorController
          .getOpened(fileModel)!
          .currentFileController
          .value
          .selection
          .baseOffset;
      editorController.getOpened(fileModel)!.setCurrentOffset(currentOffset);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
        child: Obx(
      () => CustomPaint(
        foregroundPainter: EditorAreaPainter(
            backgroundColor: Theme.of(context).primaryCustomColor,
            lineNumberColor: Theme.of(context).fileExplorerBorder,
            selectedLineColor: Theme.of(context).editorBackgroundSelectedLine,
            editorController: editorController,
            currentOffset:
                editorController.getOpened(fileModel)!.currentOffset.value,
            fileModel: fileModel),
        child: Container(
          padding: const EdgeInsets.fromLTRB(50, 12, 0, 12),
          child: TextField(
            onChanged: (String string) {
              editorController.updateNeedSave(string);
            },
            maxLines: null,
            minLines: 10,
            controller: editorController
                .getOpened(editorController.openedFile.value)!
                .currentFileController
                .value,
            style: TextStyle(
                color: Theme.of(context).editorFontColor,
                fontSize: 12,
                leadingDistribution: TextLeadingDistribution.proportional),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none
            ),
          ),
        ),
      ),
    ));
  }
}
