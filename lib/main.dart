import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_simple_text_editor/shared/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: Routes.mainRoute,
      getPages: Routes.appRoutes(),
    );
  }
}
