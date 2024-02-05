import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_simple_text_editor/components/editor/empty_editor.dart';
import 'package:flutter_simple_text_editor/shared/colors.dart';
import 'package:get/get.dart';
import 'package:flutter_simple_text_editor/components/editor/editor_controller.dart';

class EditorComponent extends StatelessWidget {
  final EditorController editorController = Get.put(EditorController());

  EditorComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditorController>(builder: (controller) {
      return Expanded(
        child: Obx(() {
          if (controller.getOpened(controller.openedFile.value) == null) {
            return const EmptyEditor();
          } else {
            return Container(
              color: Theme.of(context).editorBackground,
              child: Column(
                children: [
                  Obx(() => Container(
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.topLeft,
                        color: Theme.of(context).editorFileTab,
                        child: Text(
                            controller
                                .getOpened(controller.openedFile.value)!
                                .currentFile
                                .value
                                .relativePath,
                            style: TextStyle(
                                color: Theme.of(context).editorFontColor,
                                fontStyle: controller
                                        .getOpened(controller.openedFile.value)!
                                        .needSave
                                        .value
                                    ? FontStyle.italic
                                    : null)),
                      )),
                  Obx(() => Expanded(
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
                            child: TextField(
                              onChanged: (String string) {
                                controller.updateNeedSave(string);
                              },
                              maxLines: null,
                              controller: controller
                                  .getOpened(controller.openedFile.value)!
                                  .currentFileController
                                  .value,
                              style: TextStyle(
                                  color: Theme.of(context).editorFontColor,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            );
          }
        }),
      );
    });
  }

  void _save() {
    editorController.save();
  }
}
