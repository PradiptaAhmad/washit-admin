import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washit_admin/infrastructure/theme/themes.dart';
import 'package:washit_admin/presentation/home_page/controllers/home_page.controller.dart';
import 'package:washit_admin/presentation/home_page/widgets/tabs/center_tab_widget.dart';
import 'package:washit_admin/presentation/home_page/widgets/tabs/left_tab_widget.dart';
import 'package:washit_admin/presentation/home_page/widgets/tabs/right_tab_widget.dart';

import '../../widget/common/circle_tab_indicator.dart';
import '../../widget/common/main_container_widget.dart';
import '../../widget/shimmer/shimmer_widget.dart';

class HomePageScreen extends GetView<HomePageController> {
  HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth >= 600;

    return Scaffold(
      backgroundColor: lightGrey.withOpacity(0.1),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(isTablet ? screenHeight * 0.15 : screenHeight * 0.2),
        child: _buildAppbar(controller, screenWidth, screenHeight, isTablet),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: [
          LeftTabWidget(),
          CenterTabWidget(),
          RightTabWidget(),
        ],
      ),
    );
  }
}

Widget _buildAppbar(HomePageController controller, double screenWidth, double screenHeight, bool isTablet) {
  return MainContainerWidget(
    color: primaryColor,
    borderRadius: 25,
    childs: Column(
      children: [
        SizedBox(height: isTablet ? screenHeight * 0.05 : screenHeight * 0.07),
        _buildMainTitleWidget(controller, screenWidth, isTablet),
        Divider(color: lightGrey.withOpacity(0.2), thickness: 2, height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: TabBar(
            labelColor: black,
            unselectedLabelColor: darkGrey,
            indicatorColor: secondaryColor,
            dividerColor: Colors.transparent,
            labelStyle: tsBodySmallSemibold(black),
            controller: controller.tabController,
            splashBorderRadius: BorderRadius.circular(50),
            indicator: CircleTabIndicator(color: black, radius: 4),
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
            tabs: const [
              Tab(text: "Overview"),
              Tab(text: "Order"),
              Tab(text: "Transaksi"),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildMainTitleWidget(HomePageController controller, double screenWidth, bool isTablet) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: 4),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Obx(
                () => !controller.isLoading.value
                ? ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: isTablet ? screenWidth * 0.08 : screenWidth * 0.1,
                width: isTablet ? screenWidth * 0.08 : screenWidth * 0.1,
                child: Image.network(
                  controller.userData['image_path'] == null
                      ? 'https://ui-avatars.com/api/?name=${controller.userData['username']}&background=random&size=128'
                      : 'https://pradiptaahmad.tech/image/${controller.userData['image_path']}',
                  fit: BoxFit.cover,
                ),
              ),
            )
                : ShimmerWidget(radius: 10, height: isTablet ? screenWidth * 0.1 : screenWidth * 0.12),
          ),
        ),
        Expanded(
          flex: 7,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                      () => !controller.isLoading.value
                      ? Text(
                    "Halo,",
                    style: tsBodyLargeMedium(darkGrey),
                  )
                      : Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: ShimmerWidget(radius: 8, height: 20, width: 80),
                  ),
                ),
                Obx(
                      () => !controller.isLoading.value
                      ? ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: screenWidth * 0.6),
                    child: Text(
                      controller.userData['username'] ?? "Anon",
                      style: tsBodyLargeSemibold(black),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                      : ShimmerWidget(radius: 8, height: 20, width: 200),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              print(controller.weeklyOrderChartDatas);
            },
            borderRadius: BorderRadius.circular(50),
            child: Container(
              height: isTablet ? screenWidth * 0.08 : screenWidth * 0.1,
              width: isTablet ? screenWidth * 0.08 : screenWidth * 0.1,
              child: const Icon(
                Icons.notification_add_rounded,
                color: darkGrey,
                size: 22,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
