import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washit_admin/presentation/users_page/tabs/feedback_tab_view.dart';
import 'package:washit_admin/presentation/users_page/tabs/user_tab_view.dart';
import 'package:washit_admin/widget/common/main_container_widget.dart';
import 'package:washit_admin/widget/common/mainpage_appbar_widget.dart';
import 'package:washit_admin/widget/common/oval_tab_indicator.dart';

import '../../infrastructure/theme/themes.dart';
import 'controllers/users_page.controller.dart';

class UsersPageScreen extends GetView<UsersPageController> {
  const UsersPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UsersPageController controller = Get.put(UsersPageController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainpageAppbarWidget(
              title: "Pengguna",
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: MainContainerWidget(
                childs: TabBar(
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
                    Tab(text: "Pengguna"),
                    Tab(text: "Ulasan"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: controller.tabController,
          children: [
            UserTabView(),
            FeedbackTabView(),
          ],
        ),
      ),
    );
  }
}
