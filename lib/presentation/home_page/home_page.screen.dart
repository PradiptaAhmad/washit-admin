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
    return Scaffold(
      backgroundColor: lightGrey.withOpacity(0.1),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(kToolbarHeight + screenHeight(context) * 0.1),
        child: _buildAppbar(controller),
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

Widget _buildAppbar(HomePageController controller) {
  return MainContainerWidget(
    color: primaryColor,
    borderRadius: 25,
    childs: Column(
      children: [
        SizedBox(height: 55.00),
        _buildMainTitleWidet(controller),
        Divider(color: lightGrey.withOpacity(0.2), thickness: 2, height: 10),
        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
            child: TabBar(
              labelColor: black,
              unselectedLabelColor: darkGrey,
              indicatorColor: secondaryColor,
              dividerColor: Colors.transparent,
              labelStyle: tsBodySmallSemibold(black),
              controller: controller.tabController,
              splashBorderRadius: BorderRadius.circular(50),
              indicator: CircleTabIndicator(color: black, radius: 4),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              tabs: const [
                Tab(text: "Overview"),
                Tab(text: "Order"),
                Tab(text: "Transaksi"),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget _buildMainTitleWidet(HomePageController controller) {
  return Padding(
    padding:
        const EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 10),
    child: Row(
      children: [
        Expanded(
            flex: 1,
            child: Obx(() => !controller.isLoading.value
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 45,
                      width: 45,
                      child: Image.network(
                        controller.userData['image_path'] == null
                            ? 'https://ui-avatars.com/api/?name=${controller.userData['username']}&background=random&size=128'
                            : 'https://pradiptaahmad.tech/image/${controller.userData['image_path']}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : ShimmerWidget(radius: 10, height: 50))),
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
                          child:
                              ShimmerWidget(radius: 8, height: 20, width: 80),
                        ),
                ),
                Obx(() => !controller.isLoading.value
                    ? ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 300),
                        child: Text(
                          controller.userData['username'] ?? "Anon",
                          style: tsBodyLargeSemibold(black),
                          overflow: TextOverflow.ellipsis,
                        ))
                    : ShimmerWidget(radius: 8, height: 20, width: 200)),
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
              height: 45,
              width: 45,
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
