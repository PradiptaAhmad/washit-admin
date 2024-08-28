import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washit_admin/infrastructure/navigation/routes.dart';
import 'package:washit_admin/widget/common/main_container_widget.dart';

import '../../../../infrastructure/theme/themes.dart';
import '../../../../widget/common/content_title_widget.dart';
import '../../controllers/home_page.controller.dart';
import '../overview_main_chart_bar.dart';

class LeftTabWidget extends GetView<HomePageController> {
  const LeftTabWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> visualData = [
      {
        'mainIcons': Icons.people_rounded,
        'mainNum': "106",
        'secIcon': Icons.trending_up_rounded,
        'mainDesc': "TOTAL PENGGUNA",
        'descNum': "+2,5%",
        'mainColor': successColor,
      },
      {
        'mainIcons': Icons.receipt_rounded,
        'mainNum': "20",
        'secIcon': Icons.trending_down_rounded,
        'mainDesc': "TOTAL PESANAN",
        'descNum': "-2,5%",
        'mainColor': warningColor,
      },
      {
        'mainIcons': Icons.attach_money_rounded,
        'mainNum': "20%",
        'secIcon': Icons.trending_up_rounded,
        'mainDesc': "TOTAL PENDAPATAN",
        'descNum': "+2,5%",
        'mainColor': successColor,
      },
      {
        'mainIcons': Icons.star_rate_rounded,
        'mainNum': "4.8",
        'secIcon': Icons.trending_down_rounded,
        'mainDesc': "TOTAL RATING",
        'descNum': "-2,5%",
        'mainColor': warningColor,
      },
    ];

    return Scaffold(
      body: RefreshIndicator(
          onRefresh: () => controller.onRefresh(),
          child: _buildVerticalLayout(visualData)),
      // LayoutBuilder(
      //   builder: (context, constraints) {
      //     if (constraints.maxWidth > 600) {
      //       // For larger screens (e.g., tablets), use horizontal scrolling
      //       return _buildHorizontalLayout(visualData);
      //     } else {
      //       // For smaller screens (e.g., phones), use vertical grid
      //       return _buildVerticalLayout(visualData);
      //     }
      //   },
      // ),
    );
  }

  // Widget _buildHorizontalLayout(List<Map<String, dynamic>> visualData) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       SizedBox(height: 20),
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
  //         child: GridView.builder(
  //           shrinkWrap: true,
  //           physics: NeverScrollableScrollPhysics(),
  //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //             crossAxisCount: 4,
  //             crossAxisSpacing: 10,
  //             mainAxisSpacing: 10,
  //             childAspectRatio: 1.5,
  //           ),
  //           itemCount: visualData.length,
  //           itemBuilder: (context, index) {
  //             final data = visualData[index];
  //             return visualCardWidget(
  //               mainIcons: data['mainIcons'],
  //               mainNum: data['mainNum'],
  //               secIcon: data['secIcon'],
  //               mainDesc: data['mainDesc'],
  //               descNum: data['descNum'],
  //               mainColor: data['mainColor'],
  //             );
  //           },
  //         ),
  //       ),
  //       SizedBox(height: 25),
  //       Container(
  //         decoration: BoxDecoration(
  //           color: lightGrey,
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //         height: 1,
  //         width: double.infinity,
  //       ),
  //       OverviewMainChartBar(),
  //     ],
  //   );
  // }

  Widget _buildVerticalLayout(List<Map<String, dynamic>> visualData) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1.8,
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
          ContentTitleWidget(
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            title: "SERVICE",
            lefttextSize: tsBodySmallSemibold(grey),
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              Get.toNamed(Routes.FITUR_PAGE);
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: MainContainerWidget(
              margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              padding: EdgeInsets.all(15),
              childs: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.local_laundry_service_rounded,
                          color: black, size: 20),
                      SizedBox(width: 10),
                      Text("Fitur Layanan", style: tsBodySmallSemibold(black)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Lihat fitur layanan yang tersedia",
                    style: tsLabelLargeMedium(darkGrey),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 25),
          ContentTitleWidget(
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            title: "SEDANG BERLANGSUNG",
            lefttextSize: tsBodySmallSemibold(grey),
          ),
          OverviewMainChartBar(),
        ],
      ),
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
    child: MainContainerWidget(
      borderRadius: 10,
      color: primaryColor,
      childs: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  mainDesc,
                  style: tsLabelLargeMedium(grey),
                ),
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
              ],
            ),
            Text(mainNum, style: tsHeadlineSmallSemibold(black)),
            SizedBox(height: 10),
            // Row(
            //   children: [
            //     Text(mainDesc, style: tsLabelLargeSemibold(darkGrey)),
            //     SizedBox(width: 5),
            //     Container(
            //       decoration: BoxDecoration(
            //         color: mainColor.withOpacity(0.05),
            //         borderRadius: BorderRadius.circular(50),
            //       ),
            //       height: 22,
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 5.0),
            //         child: Align(
            //           alignment: Alignment.centerLeft,
            //           child: Text(
            //             descNum,
            //             style: tsLabelLargeSemibold(mainColor),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    ),
  );
}
