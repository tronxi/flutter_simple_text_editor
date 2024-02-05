import 'package:get/get.dart';
import 'package:flutter_simple_text_editor/components/main/main_binding.dart';
import 'package:flutter_simple_text_editor/components/main/main_component.dart';

class Routes {

  static const String mainRoute = "/main";
  static appRoutes() => [
    GetPage(
        name: mainRoute,
        page: () => const MainComponent(),
        binding: MainBinding(),
        transition: Transition.noTransition)
  ];
}