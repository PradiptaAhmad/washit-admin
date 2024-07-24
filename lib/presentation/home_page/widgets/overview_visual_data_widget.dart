import 'package:flutter/material.dart';

import '../../../infrastructure/theme/themes.dart';
import '../../../widget/common/box_shadow.dart';
import 'overview_main_chart_bar.dart';

class OverviewVisualDataWidget extends StatelessWidget {
  const OverviewVisualDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> visualData = [
      {
        'mainIcons': Icons.people_rounded,
        'mainNum': "106",
        'secIcon': Icons.trending_up_rounded,
        'mainDesc': "Total Pengguna",
        'descNum': "+2,5%",
        'mainColor': successColor,
      },
      {
        'mainIcons': Icons.receipt_rounded,
        'mainNum': "20",
        'secIcon': Icons.trending_down_rounded,
        'mainDesc': "Total Pesanan",
        'descNum': "-2,5%",
        'mainColor': warningColor,
      },
      {
        'mainIcons': Icons.attach_money_rounded,
        'mainNum': "20%",
        'secIcon': Icons.trending_up_rounded,
        'mainDesc': "Total Pendapatan",
        'descNum': "+2,5%",
        'mainColor': successColor,
      },
      {
        'mainIcons': Icons.star_rate_rounded,
        'mainNum': "4.8",
        'secIcon': Icons.trending_down_rounded,
        'mainDesc': "Total Rating",
        'descNum': "-2,5%",
        'mainColor': warningColor,
      },
    ];

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // For larger screens (e.g., tablets), use horizontal scrolling
            return _buildHorizontalLayout(visualData);
          } else {
            // For smaller screens (e.g., phones), use vertical grid
            return _buildVerticalLayout(visualData);
          }
        },
      ),
    );
  }

  Widget _buildHorizontalLayout(List<Map<String, dynamic>> visualData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.5,
            ),
            itemCount: visualData.length,
            itemBuilder: (context, index) {
              final data = visualData[index];
              return visualCardWidget(
                mainIcons: data['mainIcons'],
                mainNum: data['mainNum'],
                secIcon: data['secIcon'],
                mainDesc: data['mainDesc'],
                descNum: data['descNum'],
                mainColor: data['mainColor'],
              );
            },
          ),
        ),
        SizedBox(height: 25),
        Container(
          decoration: BoxDecoration(
            color: lightGrey,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 1,
          width: double.infinity,
        ),
        OverviewMainChartBar(),
      ],
    );
  }

  Widget _buildVerticalLayout(List<Map<String, dynamic>> visualData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.5,
            ),
            itemCount: visualData.length,
            itemBuilder: (context, index) {
              final data = visualData[index];
              return visualCardWidget(
                mainIcons: data['mainIcons'],
                mainNum: data['mainNum'],
                secIcon: data['secIcon'],
                mainDesc: data['mainDesc'],
                descNum: data['descNum'],
                mainColor: data['mainColor'],
              );
            },
          ),
        ),
        SizedBox(height: 25),
        Container(
          decoration: BoxDecoration(
            color: lightGrey,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 1,
          width: double.infinity,
        ),
        SizedBox(height: 15),
        OverviewMainChartBar(),
      ],
    );
  }
}

Widget visualCardWidget({
  required IconData mainIcons,
  required String mainNum,
  required IconData secIcon,
  required String mainDesc,
  required String descNum,
  required Color mainColor,
}) {
  return InkWell(
    onTap: () {},
    child: Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [localMainShadow()],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: black.withOpacity(0.2),
                              blurRadius: 2,
                              blurStyle: BlurStyle.solid,
                            )
                          ],
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        height: 40,
                        width: 40,
                        child: Icon(
                          mainIcons,
                          color: secondaryColor,
                          size: 22,
                        ),
                      ),
                      Text(mainNum, style: tsHeadlineMediumSemibold(darkBlue)),
                      Container(
                        decoration: BoxDecoration(
                          color: mainColor.withOpacity(0.04),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        height: 22,
                        width: 22,
                        child: Icon(
                          secIcon,
                          color: mainColor,
                          size: 16,
                        ),
                      ),
                      SizedBox(width: 0),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(mainDesc, style: tsLabelLargeSemibold(darkGrey)),
                      SizedBox(width: 5),
                      Container(
                        decoration: BoxDecoration(
                          color: mainColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        height: 22,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              descNum,
                              style: tsLabelLargeSemibold(mainColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
