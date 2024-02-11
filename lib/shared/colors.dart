import 'package:flutter/material.dart';

extension Colors on ThemeData {
  Color get primaryCustomColor {
    return const Color.fromRGBO(105, 182, 173, 1);
  }

  Color get sideBarBackground {
    return const Color.fromRGBO(23, 29, 33, 1);
  }

  Color get fileExplorerBackground {
    return const Color.fromRGBO(23, 29, 33, 1);
  }

  Color get fileExplorerBorder {
    return const Color.fromRGBO(69, 88, 101, 1.0);
  }

  Color get fileExplorerItemUnselected {
    return const Color.fromRGBO(69, 88, 101, 1.0);
  }

  Color get fileExplorerItemSelected {
    return const Color.fromRGBO(105, 182, 173, 1);
  }

  Color get openFolderBackground {
    return const Color.fromRGBO(38, 55, 57, 1);
  }

  Color get sideBarIconBackground {
    return const Color.fromRGBO(105, 182, 173, 1);
  }

  Color get editorBackground {
    return const Color.fromRGBO(28, 38, 42, 1);
  }

  Color get editorBackgroundSelectedLine {
    return const Color.fromRGBO(9, 12, 13, 0.3);
  }

  Color get editorFontColor {
    return const Color.fromRGBO(255, 255, 255, 1.0);
  }

  Color get editorFileTab {
    return const Color.fromRGBO(37, 53, 56, 1);
  }
}
