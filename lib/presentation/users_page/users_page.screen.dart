import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washit_admin/presentation/users_page/components/user_tab_view.dart';

import '../../infrastructure/theme/themes.dart';
import '../../widget/common/circle_tab_indicator.dart';
import '../review_page/review_page.screen.dart';
import 'controllers/users_page.controller.dart';

class UsersPageScreen extends GetView<UsersPageController> {
  const UsersPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UsersPageController controller = Get.put(UsersPageController());

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(kToolbarHeight), // Add extra height for margin
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              backgroundColor: secondaryColor,
              title: Text('Laman Pengguna',
                  style: tsTitleSmallMedium(primaryColor)),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              TabBar(
                labelColor: black,
                unselectedLabelColor: darkGrey,
                indicatorColor: secondaryColor,
                dividerColor: Colors.transparent,
                labelStyle: tsBodySmallSemibold(black),
                controller: controller.tabController,
                splashBorderRadius: BorderRadius.circular(10),
                indicator: CircleTabIndicator(
                  color: black,
                  radius: 4,
                ),
                tabs: const [
                  Tab(text: "Pengguna"),
                  Tab(text: "Feedback"),
                ],
              ),
              SizedBox(height: 5),
              SizedBox(
                height: screenHeight * screenWidth,
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    UserTabView(),
                    ReviewPageScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
