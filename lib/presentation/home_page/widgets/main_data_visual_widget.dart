import 'package:flutter/material.dart';
import 'package:washit_admin/presentation/home_page/widgets/charts/line_chart_card.dart';
import 'package:washit_admin/presentation/home_page/widgets/charts/mini_line_chart_card.dart';

import '../../../infrastructure/theme/themes.dart';
import '../../../widget/common/box_shadow.dart';

class MainDataVisualWidget extends StatelessWidget {
  const MainDataVisualWidget({
    super.key,
    this.title1,
    this.desc1,
    this.title2,
    this.desc2,
    this.titleStyle,
    this.numStyle,
  });

  final String? title1, desc1, title2, desc2;
  final TextStyle? titleStyle, numStyle;

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const SizedBox(
              width: 15,
            ),
            miniVisualCardWidget(
                context,
                title1,
                desc1,
                successColor,
                Icons.arrow_drop_up,
                tsLabelLargeSemibold(darkGrey),
                tsTitleLargeSemibold(black)),
            const SizedBox(
              width: 10,
            ),
            miniVisualCardWidget(
                context,
                title2,
                desc2,
                warningColor,
                Icons.arrow_drop_down,
                tsLabelLargeSemibold(darkGrey),
                tsTitleLargeSemibold(black)),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultMargin, vertical: 10),
          child: Container(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [localMainShadow()],
            ),
            height: screenWidth * 0.51,
            width: double.infinity,
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: LineChartCard(),
            ),
          ),
        ),
      ],
    );
  }
}

Widget miniVisualCardWidget(
    context, title, num, mainColor, icons, titleStyle, numStyle) {
  return Expanded(
    child: InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [localMainShadow()],
        ),
        height: MediaQuery.of(context).size.width * 0.365,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title ?? "Loading...",
                              style: titleStyle ??
                                  tsLabelMediumSemibold(darkGrey)),
                          Text(
                            num ?? "Null",
                            style: numStyle ?? tsHeadlineMediumSemibold(black),
                          ),
                        ],
                      ),
                      Icon(
                        icons ?? Icons.error,
                        color: mainColor ?? warningColor,
                        size: 40,
                      ),
                    ],
                  ),
                  MiniLineChartCard(
                    graphColor: mainColor,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
