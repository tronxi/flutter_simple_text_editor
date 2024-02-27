import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_text_editor/shared/colors.dart';
import 'package:get/get.dart';
import 'package:flutter_simple_text_editor/shared/routes.dart';

const appName = "AppName";

void main() {
  const initialSize = Size(800, 600);
  appWindow.size = initialSize;
  appWindow.show();
  runApp(const MyApp());
  doWhenWindowReady(() {
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = appName;
    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Theme.of(context).primaryCustomColor),
        useMaterial3: true,
      ),
      initialRoute: Routes.mainRoute,
      getPages: Routes.appRoutes(),
    );
  }
}
