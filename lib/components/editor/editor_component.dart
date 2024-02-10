import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_simple_text_editor/components/editor/editor_area.dart';
import 'package:flutter_simple_text_editor/components/editor/empty_editor.dart';
import 'package:flutter_simple_text_editor/components/editor/opened_files_menu.dart';
import 'package:flutter_simple_text_editor/shared/colors.dart';
import 'package:get/get.dart';
import 'package:flutter_simple_text_editor/components/editor/editor_controller.dart';

class EditorComponent extends StatelessWidget {
  final EditorController editorController = Get.put(EditorController());

  EditorComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditorController>(builder: (controller) {
      return Obx(() {
        if (controller.getOpened(controller.openedFile.value) == null) {
          return const EmptyEditor();
        } else {
          return Expanded(
            child: Container(
              color: Theme.of(context).editorBackground,
              child: Column(
                children: [
                  const OpenedFilesMenu(),
                  Expanded(
                    child: CallbackShortcuts(
                      bindings: <ShortcutActivator, VoidCallback>{
                        LogicalKeySet(LogicalKeyboardKey.metaRight,
                            LogicalKeyboardKey.keyS): () {
                          _save();
                        },
                        LogicalKeySet(LogicalKeyboardKey.control,
                            LogicalKeyboardKey.keyS): () {
                          _save();
                        },
                      },
                      child: SingleChildScrollView(
                        child: EditorArea(
                          editorController: controller,
                          fileModel: controller.openedFile.value,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      });
    });
  }

  void _save() {
    editorController.save();
  }
}
