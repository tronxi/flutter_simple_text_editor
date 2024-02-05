import 'package:get/get.dart';
import 'package:flutter_simple_text_editor/components/main/main_controller.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController());
  }
}
