import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_text_editor/components/title_bar/window_buttons.dart';
import 'package:flutter_simple_text_editor/main.dart';
import 'package:flutter_simple_text_editor/shared/colors.dart';

class TitleBarComponent extends StatelessWidget {
  const TitleBarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).sideBarBackground,
      child: WindowTitleBarBox(
          child: Row(
        children: [
          Expanded(
              child: MoveWindow(
            child: Center(
              child: Text(
                appName,
                style: TextStyle(color: Theme.of(context).editorFontColor),
              ),
            ),
          )),
          Container(
              color: Theme.of(context).sideBarBackground,
              child: const WindowButtons())
        ],
      )),
    );
  }
}
