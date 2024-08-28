import 'package:flutter/material.dart';

import '../../infrastructure/theme/themes.dart';

class ContentTitleWidget extends StatelessWidget {
  const ContentTitleWidget({
    Key? key,
    required this.title,
    this.subtitle,
    this.childs,
    this.lefttextSize,
    this.righttextSize,
    this.leftTextColor,
    this.rightTextColor,
    this.margin,
    this.padding,
  }) : super(key: key);

  final String? title, subtitle;
  final Widget? childs;

  final lefttextSize, righttextSize;
  final Color? leftTextColor, rightTextColor;
  final margin, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      child: Row(
        children: [
          Expanded(
              child: Text(
            title ?? "",
            style: lefttextSize ?? tsBodyLargeSemibold(leftTextColor ?? black),
          )),
          Text(
            subtitle ?? "",
            style: righttextSize ?? tsLabelLargeMedium(rightTextColor ?? grey),
          ),
          childs ?? SizedBox(),
        ],
      ),
    );
  }
}
