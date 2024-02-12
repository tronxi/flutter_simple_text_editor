import 'package:flutter/material.dart';

class FileCloseDialog extends StatelessWidget {
  final String filePath;
  final Function() onSave;
  final Function() onDontSave;
  final Function() onCancel;
  const FileCloseDialog(
      {super.key,
      required this.filePath,
      required this.onSave,
      required this.onCancel,
      required this.onDontSave});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Do you want to save the changes you made to $filePath?"),
      content: const Text("Your changes will be lost if you don't save them"),
      actions: <Widget>[
        TextButton(
          child: const Text("Don't Save"),
          onPressed: () {
            onDontSave();
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text("Cancel"),
          onPressed: () {
            onCancel();
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text("Save"),
          onPressed: () {
            onSave();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
