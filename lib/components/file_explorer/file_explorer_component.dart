import 'package:flutter/material.dart';
import 'package:flutter_simple_text_editor/components/file_explorer/create_files_helper.dart';
import 'package:flutter_simple_text_editor/components/file_explorer/directory_item.dart';
import 'package:flutter_simple_text_editor/components/file_explorer/file_explorer_button.dart';
import 'package:flutter_simple_text_editor/components/file_explorer/file_item.dart';
import 'package:flutter_simple_text_editor/components/file_explorer/file_node.dart';
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
              FileExplorerButton(text: "Refresh", onPressed: _onPressRefresh),
              const SizedBox(width: 10),
            ],
          ),
          const SizedBox(height: 10),
          Obx(() {
            if (controller.selectedPath.isNotEmpty) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FileExplorerButton(
                      text: "New File",
                      onPressed: () => CreateFilesHelper.showFileNameDialog(
                          context, controller.currentFilesTree.value, true)),
                  const SizedBox(width: 10),
                  FileExplorerButton(
                      text: "New Folder",
                      onPressed: () => CreateFilesHelper.showFolderNameDialog(
                          context, controller.currentFilesTree.value, true)),
                  const SizedBox(width: 10),
                ],
              );
            } else {
              return Container();
            }
          }),
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
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          _retrieveFiles(controller.currentFilesTree.value),
                    ),
                  ),
                ),
              ))
        ]),
      );
    });
  }

  List<Widget> _retrieveFiles(FileNode parent) {
    List<Widget> widgets = [];
    for (var fileNode in parent.children) {
      if (!fileNode.markAsDeleted) {
        if (!fileNode.value.isDirectory) {
          widgets.add(FileItem(fileNode: fileNode));
        } else {
          widgets.add(DirectoryItem(fileNode: fileNode));
          if (fileNode.showChildren) {
            widgets.addAll(_retrieveFiles(fileNode));
          }
        }
      }
    }
    return widgets;
  }

  void _onPressRefresh() {
    controller.refreshFiles();
  }

  void _onPressOpenFolder() {
    controller.retrieveFiles();
  }
}
