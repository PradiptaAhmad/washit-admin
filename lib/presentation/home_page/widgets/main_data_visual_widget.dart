import 'package:flutter/material.dart';
import 'package:washit_admin/presentation/home_page/widgets/charts/line_chart_card.dart';
import 'package:washit_admin/presentation/home_page/widgets/charts/mini_line_chart_card.dart';

import '../../../infrastructure/theme/themes.dart';

class MainDataVisualWidget extends StatelessWidget {
  const MainDataVisualWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            SizedBox(
              width: 15,
            ),
            miniVisualCardWidget(
              title: "Pesanan Baru",
              num: "11",
              mainColor: successColor,
              icons: Icons.arrow_drop_up,
            ),
            SizedBox(
              width: 10,
            ),
            miniVisualCardWidget(
              title: "Total Pesanan",
              num: "25",
              mainColor: warningColor,
              icons: Icons.arrow_drop_down,
            ),
            SizedBox(
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
              boxShadow: [LocalMainShadow()],
            ),
            height: screenWidth * 0.51,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: LineChartCard(),
            ),
          ),
        ),
      ],
    );
  }
}

BoxShadow LocalMainShadow() {
  return BoxShadow(
    color: Colors.grey.withOpacity(0.2),
    spreadRadius: 2,
    blurRadius: 4,
    offset: Offset(0.5, 2),
  );
}

class miniVisualCardWidget extends StatelessWidget {
  const miniVisualCardWidget({
    this.title,
    this.num,
    this.mainColor,
    this.icons,
    super.key,
  });

  final String? title;
  final String? num;
  final Color? mainColor;
  final IconData? icons;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [LocalMainShadow()],
          ),
          height: 150,
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
                                style: tsLabelLargeSemibold(darkGrey)),
                            Text(
                              num ?? "Null",
                              style: tsHeadlineMediumSemibold(black),
                            ),
                          ],
                        ),
                        Icon(
                          icons ?? Icons.error,
                          color: mainColor ?? warningColor,
                          size: 40,
                        )
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
}
