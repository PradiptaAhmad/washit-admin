import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washit_admin/presentation/users_page/tabs/feedback_tab_view.dart';
import 'package:washit_admin/presentation/users_page/tabs/user_tab_view.dart';

import '../../infrastructure/theme/themes.dart';
import '../../widget/common/circle_tab_indicator.dart';
import 'controllers/users_page.controller.dart';

class UsersPageScreen extends GetView<UsersPageController> {
  const UsersPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UsersPageController controller = Get.put(UsersPageController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(kToolbarHeight + 60), // Add extra height for margin
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              backgroundColor: secondaryColor,
              title: Text('Laman Pengguna',
                  style: tsTitleSmallMedium(primaryColor)),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TabBar(
                labelColor: black,
                unselectedLabelColor: darkGrey,
                indicatorColor: secondaryColor,
                dividerColor: Colors.transparent,
                labelStyle: tsBodySmallSemibold(black),
                controller: controller.tabController,
                splashBorderRadius: BorderRadius.circular(10),
                indicator: CircleTabIndicator(color: black, radius: 4),
                tabs: const [
                  Tab(text: "Pengguna"),
                  Tab(text: "Feedback"),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => null,
          child: TabBarView(
            controller: controller.tabController,
            children: [
              UserTabView(),
              FeedbackTabView(),
            ],
          ),
        ),
      ),
    );
  }
}
