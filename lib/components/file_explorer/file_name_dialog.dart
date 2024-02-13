import 'package:flutter/material.dart';

class FileNameDialog extends StatelessWidget {
  final Function(String fileName) onSelect;
  final TextEditingController textEditingController = TextEditingController();
  FileNameDialog({super.key, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("File name"),
      content: TextFormField(
        autofocus: true,
        controller: textEditingController,
        onFieldSubmitted: (_) => _onSave(context),
      ),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text("Save"),
          onPressed: () => _onSave(context),
        ),
      ],
    );
  }

  void _onSave(BuildContext context) {
    onSelect(textEditingController.text);
    Navigator.of(context).pop();
  }
}
