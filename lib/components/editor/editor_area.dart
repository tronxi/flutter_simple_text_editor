import 'package:flutter/material.dart';
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
        foregroundPainter: _EditorAreaPainter(
            backgroundColor: Theme.of(context).primaryCustomColor,
            lineNumberColor: Theme.of(context).fileExplorerBorder,
            selectedLineColor: Theme.of(context).editorBackgroundSelectedLine,
            editorController: editorController,
            currentOffset:
                editorController.getOpened(fileModel)!.currentOffset.value,
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
      ),
    ));
  }
}

class _EditorAreaPainter extends CustomPainter {
  final Color backgroundColor;
  final Color lineNumberColor;
  final Color selectedLineColor;
  final EditorController editorController;
  final int currentOffset;
  final FileModel fileModel;

  const _EditorAreaPainter(
      {required this.backgroundColor,
      required this.lineNumberColor,
      required this.editorController,
      required this.selectedLineColor,
      required this.currentOffset,
      required this.fileModel});

  @override
  void paint(Canvas canvas, Size size) {
    String text =
        editorController.getOpened(fileModel)!.currentFileController.value.text;
    final textStyle = TextStyle(
      color: lineNumberColor,
      fontSize: 12,
    );
    final textPainter = TextPainter(
      text: TextSpan(style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout();

    int lineNumber = _calculateLineNumber(currentOffset, text);
    double y = _calculateLineNumberPosition(textPainter, lineNumber) + 6;
    final Paint paint = Paint()
      ..color = selectedLineColor
      ..strokeWidth = 16;
    final Offset start = Offset(0, y);
    final Offset end = Offset(size.width, y);
    canvas.drawLine(start, end, paint);

    for (int i = 1; i <= _getTotalLines(text); i++) {
      textPainter.text = TextSpan(
        text: i.toString(),
        style: textStyle,
      );
      textPainter.layout();
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

  int _calculateLineNumber(int offset, String text) {
    final textBeforeCursor = text.substring(0, offset);
    final newLineRegex = RegExp(r'\n');
    return newLineRegex.allMatches(textBeforeCursor).length + 1;
  }

  double _calculateLineNumberPosition(TextPainter textPainter, int i) {
    const lineHeight = 14;
    const offset = 4;
    final textHeight = textPainter.height;
    double y = (lineHeight * i) + (lineHeight / 2) - (textHeight / 2);
    return y - offset;
  }
}
