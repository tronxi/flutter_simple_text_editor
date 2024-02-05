import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_simple_text_editor/components/editor/editor_component.dart';
import 'package:flutter_simple_text_editor/components/file_explorer/file_explorer_component.dart';
import 'package:flutter_simple_text_editor/components/main/main_controller.dart';
import 'package:flutter_simple_text_editor/components/side_bar/side_bar_component.dart';
import 'package:flutter_simple_text_editor/widgets/scaffold.dart';

class MainComponent extends StatelessWidget {
  const MainComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (controller) {
      return CustomScaffold(
        body: Row(
          children: [
            const SideBarComponent(),
            Obx(() => controller.showFileExplorer.value
                ? const FileExplorerComponent()
                : Container()),
            const EditorComponent()
          ],
        ),
      );
    });
  }
}
