import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  const CustomScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
    );
  }
}
