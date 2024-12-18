import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/themes.dart';

class MainpageAppbarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const MainpageAppbarWidget({
    Key? key,
    this.onPressed,
    this.title,
    this.icon,
    this.backgroundColor,
    this.textStyle,
    this.elevation,
    this.noLeading = false,
    this.iconSize,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String? title;
  final IconData? icon;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final bool noLeading;
  final double? elevation, iconSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: noLeading
          ? null
          : IconButton(
              splashColor: Colors.transparent,
              icon: Icon(
                Icons.close_rounded,
                color: darkGrey,
                size: iconSize ?? 25,
              ),
              onPressed: onPressed ?? Get.back,
            ),
      elevation: elevation,
      automaticallyImplyLeading: !noLeading,
      backgroundColor: backgroundColor,
      title: Text(
        title ?? 'default text title',
        style: textStyle ?? tsBodyMediumMedium(black),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
