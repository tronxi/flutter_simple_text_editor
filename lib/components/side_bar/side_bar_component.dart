import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_simple_text_editor/components/main/main_controller.dart';
import 'package:flutter_simple_text_editor/components/side_bar/side_bar_button.dart';
import 'package:flutter_simple_text_editor/shared/colors.dart';

class SideBarComponent extends StatelessWidget {
  const SideBarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).sideBarBackground,
      child: Column(
        children: [
          SideBarButton(
              iconData: Icons.file_copy,
              isDisabled: false,
              onPressed: toggleShowFileExplorerController)
        ],
      ),
    );
  }

  void toggleShowFileExplorerController() {
    final MainController mainController = Get.put(MainController());
    mainController.toggleShowFileExplorer();
  }
}
