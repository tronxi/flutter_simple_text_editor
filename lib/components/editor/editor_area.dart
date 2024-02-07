import 'package:flutter/material.dart';
import 'package:flutter_simple_text_editor/components/editor/editor_controller.dart';
import 'package:flutter_simple_text_editor/shared/colors.dart';
import 'package:flutter_simple_text_editor/shared/file_model.dart';
import 'package:get/get.dart';

class EditorArea extends StatelessWidget {
  final EditorController editorController;
  final FileModel fileModel;
  const EditorArea(
      {super.key, required this.editorController, required this.fileModel});

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomPaint(
          foregroundPainter: _EditorAreaPainter(
              backgroundColor: Theme.of(context).primaryCustomColor,
              lineNumberColor: Theme.of(context).fileExplorerBorder,
              editorController: editorController,
              fileModel: fileModel),
          child: Container(
            padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
            child: TextField(
              onChanged: (String string) {
                editorController.updateNeedSave(string);
              },
              maxLines: null,
              controller: editorController
                  .getOpened(editorController.openedFile.value)!
                  .currentFileController
                  .value,
              style: TextStyle(
                  color: Theme.of(context).editorFontColor, fontSize: 12),
            ),
          ),
        ));
  }
}

class _EditorAreaPainter extends CustomPainter {
  final Color backgroundColor;
  final Color lineNumberColor;
  final EditorController editorController;
  final FileModel fileModel;

  const _EditorAreaPainter(
      {required this.backgroundColor,
      required this.lineNumberColor,
      required this.editorController,
      required this.fileModel});

  @override
  void paint(Canvas canvas, Size size) {
    String text =
        editorController.getOpened(fileModel)!.currentFileController.value.text;

    for (int i = 1; i <= _getTotalLines(text); i++) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: i.toString(),
          style: TextStyle(
            color: lineNumberColor,
            fontSize: 12,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      final offset = Offset(8, _calculateLineNumberPosition(textPainter, i));
      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  int _getTotalLines(String text) {
    return text.split("\n").length;
  }

  double _calculateLineNumberPosition(TextPainter textPainter, int i) {
    const lineHeight = 14;
    const offset = 4;
    final textHeight = textPainter.height;
    double y = (lineHeight * i) + (lineHeight / 2) - (textHeight / 2);
    return y - offset;
  }
}
