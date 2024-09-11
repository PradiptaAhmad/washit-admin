import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washit_admin/infrastructure/theme/themes.dart';
import 'package:washit_admin/presentation/home_page/controllers/home_page.controller.dart';
import 'package:washit_admin/presentation/home_page/widgets/tabs/center_tab_widget.dart';
import 'package:washit_admin/presentation/home_page/widgets/tabs/left_tab_widget.dart';
import 'package:washit_admin/presentation/home_page/widgets/tabs/right_tab_widget.dart';
import 'package:washit_admin/widget/shimmer/shimmer_widget.dart';

import '../../widget/common/main_container_widget.dart';
import '../../widget/common/oval_tab_indicator.dart';

class HomePageScreen extends GetView<HomePageController> {
  HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey.withOpacity(0.1),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 70),
        child: _buildAppbar(context, controller),
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

Widget _buildAppbar(BuildContext context, HomePageController controller) {
  return MainContainerWidget(
    color: primaryColor,
    borderRadius: 25,
    childs: Column(
      children: [
        SizedBox(height: screenHeight(context) / 18),
        _buildMainTitleWidget(context, controller),
        Divider(color: lightGrey.withOpacity(0.2), thickness: 2, height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: TabBar(
            labelColor: black,
            unselectedLabelColor: darkGrey,
            indicatorColor: darkGrey,
            dividerColor: Colors.transparent,
            labelStyle: tsBodySmallMedium(black),
            controller: controller.tabController,
            splashBorderRadius: BorderRadius.circular(10),
            indicator: RoundedRectTabIndicator(
                color: black, radius: 3, width: 30, height: 3),
            tabs: const [
              Tab(text: "Ringkasan"),
              Tab(text: "Pesanan"),
              Tab(text: "Transaksi"),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildMainTitleWidget(
    BuildContext context, HomePageController controller) {
  return Obx(
    () => !controller.isLoading.isTrue
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 45,
                    height: 45,
                    child: Image.network(
                      controller.userData['image_path'] == null
                          ? 'https://ui-avatars.com/api/?name=${controller.userData['username']}&background=random&size=128'
                          : 'https://pradiptaahmad.tech/image/${controller.userData['image_path']}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Halo,",
                          style: tsBodyLargeMedium(darkGrey),
                        ),
                        Text(
                          controller.userData['username'] ?? "Anon",
                          style: tsBodyLargeSemibold(black),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                ShimmerWidget(
                  height: 45,
                  width: 45,
                  radius: 10,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerWidget(
                          height: 20,
                          width: 60,
                          radius: 5,
                        ),
                        SizedBox(height: 10),
                        ShimmerWidget(
                          height: 20,
                          width: 160,
                          radius: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
  );
}
