import 'package:get/get.dart';

class MainController extends GetxController {
  var showFileExplorer = false.obs;

  void toggleShowFileExplorer() {
    showFileExplorer.value = !showFileExplorer.value;
  }
}
