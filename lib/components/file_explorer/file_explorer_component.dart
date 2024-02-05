import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_simple_text_editor/components/file_explorer/file_explorer_controller.dart';
import 'package:flutter_simple_text_editor/shared/colors.dart';

class FileExplorerComponent extends StatefulWidget {
  const FileExplorerComponent({super.key});

  @override
  State<FileExplorerComponent> createState() => _FileExplorerComponentState();
}

class _FileExplorerComponentState extends State<FileExplorerComponent> {
  @override
  void initState() {
    super.initState();
    final FileExplorerController controller = Get.put(FileExplorerController());
    controller.retrieveFiles();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FileExplorerController>(builder: (controller) {
      return Container(
        width: 200,
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
          Text("Project",
              style: TextStyle(
                  color: Theme.of(context).fileExplorerBorder,
                  fontWeight: FontWeight.bold)),
          Obx(() => Expanded(
                child: ListView.builder(
                  itemCount: controller.currentFiles.length,
                  itemBuilder: (context, index) {
                    return Text(controller.currentFiles[index],
                        style: TextStyle(
                            color: Theme.of(context).fileExplorerBorder));
                  },
                ),
              ))
        ]),
      );
    });
  }
}
