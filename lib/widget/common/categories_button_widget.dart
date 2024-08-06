import 'package:flutter/material.dart';

import '../../infrastructure/theme/themes.dart';

class CategoriesButtonWidget extends StatelessWidget {
  const CategoriesButtonWidget(
      {Key? key, this.controller, this.title, this.onTap, this.highlighted})
      : super(key: key);
  final controller;
  final String? title;
  final void Function()? onTap;
  final bool? highlighted;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(defaultMargin),
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultMargin),
          border: Border.all(
              color: highlighted == true ? secondaryColor : lightGrey),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Text(
              title.toString(),
              style: tsBodySmallMedium(
                  highlighted == true ? secondaryColor : darkGrey),
            ),
          ),
        ),
      ),
    );
  }
}
