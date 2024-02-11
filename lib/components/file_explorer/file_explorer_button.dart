import 'package:flutter/material.dart';
import 'package:flutter_simple_text_editor/shared/colors.dart';

class FileExplorerButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  const FileExplorerButton(
      {Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color?>(
                Theme.of(context).openFolderBackground),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)))),
        child: Text(
          text,
          style:
              TextStyle(fontSize: 14, color: Theme.of(context).editorFontColor),
        ));
  }
}
