import 'package:flutter/material.dart';
import 'package:flutter_simple_text_editor/shared/colors.dart';

class SideBarButton extends StatelessWidget {
  final IconData iconData;
  final bool isDisabled;
  final Function() onPressed;
  const SideBarButton(
      {Key? key,
      required this.iconData,
      required this.isDisabled,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: isDisabled ? null : onPressed,
        icon: Icon(
          iconData,
          color: Theme.of(context).sideBarIconBackground,
        ));
  }
}
