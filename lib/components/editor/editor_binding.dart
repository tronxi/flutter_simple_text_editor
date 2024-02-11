import 'package:get/get.dart';

class EditorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditorBinding());
  }
}
