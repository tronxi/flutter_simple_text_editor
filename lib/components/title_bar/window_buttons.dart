import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_text_editor/shared/colors.dart';

class WindowButtons extends StatefulWidget {
  const WindowButtons({super.key});

  @override
  State<WindowButtons> createState() => _WindowButtonsState();
}

class _WindowButtonsState extends State<WindowButtons> {
  void maximizeOrRestore() {
    setState(() {
      appWindow.maximizeOrRestore();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: Theme.of(context).windowButtonColor),
        appWindow.isMaximized
            ? RestoreWindowButton(
                colors: Theme.of(context).windowButtonColor,
                onPressed: maximizeOrRestore,
              )
            : MaximizeWindowButton(
                colors: Theme.of(context).windowButtonColor,
                onPressed: maximizeOrRestore,
              ),
        CloseWindowButton(colors: Theme.of(context).windowCloseButtonColor),
      ],
    );
  }
}
