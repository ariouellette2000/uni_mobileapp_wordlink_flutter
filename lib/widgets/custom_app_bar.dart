import 'package:flutter/material.dart';
import 'package:namer_app/styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.titleText,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titleText, style: appBarTextStyle),
      backgroundColor: primaryColor,
      elevation: 0,
      actions: actions,
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight);
}
