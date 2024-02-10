import 'package:flutter/material.dart';
import 'package:flutter_simple_text_editor/components/file_explorer/file_explorer_button.dart';
import 'package:flutter_simple_text_editor/components/file_explorer/file_item.dart';
import 'package:get/get.dart';
import 'package:flutter_simple_text_editor/components/file_explorer/file_explorer_controller.dart';
import 'package:flutter_simple_text_editor/shared/colors.dart';

class FileExplorerComponent extends StatefulWidget {
  const FileExplorerComponent({super.key});

  @override
  State<FileExplorerComponent> createState() => _FileExplorerComponentState();
}

class _FileExplorerComponentState extends State<FileExplorerComponent> {
  late final FileExplorerController controller;
  @override
  void initState() {
    super.initState();
    controller = Get.put(FileExplorerController());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FileExplorerController>(builder: (controller) {
      return Container(
        width: 240,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).fileExplorerBackground,
          border: Border(
              left: BorderSide(
                  width: 1.0, color: Theme.of(context).fileExplorerBorder),
              right: BorderSide(
                  width: 1.0, color: Theme.of(context).fileExplorerBorder)),
        ),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FileExplorerButton(
                  text: "Open Folder", onPressed: _onPressOpenFolder),
              const SizedBox(width: 10),
              FileExplorerButton(
                  text: "Refresh", onPressed: _onPressRefresh),
              const SizedBox(width: 10),
            ],
          ),
          const SizedBox(height: 10),
          Obx(() => Text(controller.selectedDirectoryName.value,
              style: TextStyle(
                  color: Theme.of(context).editorFontColor,
                  fontWeight: FontWeight.bold))),
          Divider(
            height: 20,
            thickness: 1,
            color: Theme.of(context).fileExplorerBorder,
          ),
          Obx(() => Expanded(
                child: ListView.builder(
                  itemCount: controller.currentFiles.length,
                  itemBuilder: (context, index) {
                    return FileItem(file: controller.currentFiles[index]);
                  },
                ),
              ))
        ]),
      );
    });
  }

  void _onPressRefresh() {
    controller.refreshFiles();
  }

  void _onPressOpenFolder() {
    controller.retrieveFiles();
  }
}
