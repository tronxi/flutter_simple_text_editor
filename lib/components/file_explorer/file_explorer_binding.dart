import 'package:get/get.dart';
import 'package:flutter_simple_text_editor/components/file_explorer/file_explorer_controller.dart';

class FileExplorerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FileExplorerController());
  }

}