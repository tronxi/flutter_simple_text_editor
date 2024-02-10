import 'package:flutter/material.dart';
import 'package:flutter_simple_text_editor/components/editor/editor_controller.dart';
import 'package:flutter_simple_text_editor/shared/file_model.dart';

class EditorAreaPainter extends CustomPainter {
  final Color backgroundColor;
  final Color lineNumberColor;
  final Color selectedLineColor;
  final EditorController editorController;
  final int currentOffset;
  final FileModel fileModel;

  const EditorAreaPainter(
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

    int lineNumber = _calculateLineNumber(currentOffset, text);
    double y = _calculateSelectedLineNumberPosition(lineNumber);
    final Paint paint = Paint()
      ..color = selectedLineColor
      ..strokeWidth = 18;
    final Offset start = Offset(0, y);
    final Offset end = Offset(size.width, y);
    canvas.drawLine(start, end, paint);

    for (int i = 1; i <= _getTotalLines(text); i++) {
      final textPainter = TextPainter(
        text: TextSpan(
            text: i.toString(),
            style: TextStyle(
              color: lineNumberColor,
              fontSize: 12,
            )),
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

  double _calculateSelectedLineNumberPosition(int i) {
    const lineHeight = 14;
    const offset = 4;
    double y = (lineHeight * i) + (lineHeight / 2);
    return y - offset;
  }
}