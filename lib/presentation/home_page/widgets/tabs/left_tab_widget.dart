import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washit_admin/infrastructure/navigation/routes.dart';
import 'package:washit_admin/widget/common/main_container_widget.dart';
import 'package:washit_admin/widget/shimmer/shimmer_widget.dart';

import '../../../../infrastructure/theme/themes.dart';
import '../../../../widget/common/content_title_widget.dart';
import '../../controllers/home_page.controller.dart';
import '../overview_main_chart_bar.dart';

class LeftTabWidget extends GetView<HomePageController> {
  const LeftTabWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => controller.onRefresh(),
        child: Obx(() {
          final overview = controller.overviewData.value;
          final List<Map<String, dynamic>> visualData = [
            {
              'mainIcons': Icons.people_rounded,
              'mainNum': overview.totalUsers.toString(),
              'secIcon': Icons.trending_up_rounded,
              'mainDesc': "TOTAL PENGGUNA",
              'descNum': "+2,5%",
              'mainColor': successColor,
            },
            {
              'mainIcons': Icons.receipt_rounded,
              'mainNum': overview.totalOrders.toString(),
              'secIcon': Icons.trending_down_rounded,
              'mainDesc': "TOTAL PESANAN",
              'descNum': "-2,5%",
              'mainColor': warningColor,
            },
            {
              'mainIcons': Icons.attach_money_rounded,
              'mainNum': "Rp ${overview.totalTransactions / 1000}K",
              'secIcon': Icons.trending_up_rounded,
              'mainDesc': "TOTAL PENDAPATAN",
              'descNum': "+2,5%",
              'mainColor': successColor,
            },
            {
              'mainIcons': Icons.star_rate_rounded,
              'mainNum': overview.averageRatings.toStringAsFixed(1),
              'secIcon': Icons.trending_down_rounded,
              'mainDesc': "TOTAL RATING",
              'descNum': "-2,5%",
              'mainColor': warningColor,
            },
          ];

          return _buildVerticalLayout(visualData);
        }),
      ),
    );
  }

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
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.5,
              ),
              itemCount: visualData.length,
              itemBuilder: (context, index) {
                final data = visualData[index];
                return Obx(
                  () => !controller.isLoading.value
                      ? visualCardWidget(
                          mainIcons: data['mainIcons'],
                          mainNum: data['mainNum'],
                          secIcon: data['secIcon'],
                          mainDesc: data['mainDesc'],
                          descNum: data['descNum'],
                          mainColor: data['mainColor'],
                        )
                      : ShimmerWidget(radius: 10),
                );
              },
            ),
          ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
            child: ContentTitleWidget(
              title: "SERVICE",
              lefttextSize: tsBodySmallSemibold(grey),
            ),
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              Get.toNamed(Routes.FITUR_PAGE);
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
              child: MainContainerWidget(
                padding: EdgeInsets.all(15),
                childs: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.local_laundry_service_rounded,
                            color: black, size: 20),
                        SizedBox(width: 10),
                        Text("Fitur Layanan",
                            style: tsBodySmallSemibold(black)),
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
          ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
            child: ContentTitleWidget(
              title: "SEDANG BERLANGSUNG",
              lefttextSize: tsBodySmallSemibold(grey),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
            child: OverviewMainChartBar(),
          ),
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
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    mainDesc,
                    style: tsLabelLargeMedium(grey),
                    overflow: TextOverflow.ellipsis, // Prevent overflow
                  ),
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
          ],
        ),
      ),
    ),
  );
}
