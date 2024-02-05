import 'package:flutter/material.dart';
import 'package:flutter_simple_text_editor/shared/colors.dart';

class EmptyEditor extends StatelessWidget {
  const EmptyEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      color: Theme.of(context).editorBackground,
      child: const Center(child: Text("Empty")),
    ));
  }
}
