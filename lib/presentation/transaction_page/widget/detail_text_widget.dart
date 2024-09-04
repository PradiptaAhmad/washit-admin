import 'package:flutter/material.dart';

import '../../../infrastructure/theme/themes.dart';

class DetailDataWidget extends StatelessWidget {
  final String leftTitle;
  final String rightTitle;

  final TextStyle? leftTitleStyle;
  final TextStyle? rightTitleStyle;
  final TextAlign? leftTitleAlignment;
  final TextAlign? rightTitleAlignment;
  final TextOverflow? textTitleOverflow;

  const DetailDataWidget({
    required this.leftTitle,
    required this.rightTitle,
    this.leftTitleStyle,
    this.rightTitleStyle,
    this.leftTitleAlignment,
    this.rightTitleAlignment,
    this.textTitleOverflow,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  leftTitle,
                  style: leftTitleStyle ?? tsBodySmallRegular(darkGrey),
                  textAlign: leftTitleAlignment ?? TextAlign.left,
                ),
              ),
              Expanded(
                child: Text(
                  rightTitle,
                  style: rightTitleStyle ?? tsBodySmallRegular(black),
                  textAlign: rightTitleAlignment ?? TextAlign.right,
                  overflow: textTitleOverflow ?? TextOverflow.ellipsis,
                  maxLines: 5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
