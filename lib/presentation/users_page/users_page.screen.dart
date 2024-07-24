import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/themes.dart';
import '../../widget/common/circle_tab_indicator.dart';
import 'controllers/users_page.controller.dart';

class UsersPageScreen extends GetView<UsersPageController> {
  const UsersPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UsersPageController controller = Get.put(UsersPageController());

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          margin: EdgeInsets.all(defaultMargin),
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
                splashBorderRadius: BorderRadius.circular(50),
                indicator: CircleTabIndicator(
                  color: black,
                  radius: 4,
                ),
                tabs: const [
                  Tab(text: "Pengguna"),
                  Tab(text: "Feedback"),
                ],
              ),
              SizedBox(
                height: screenHeight * screenWidth,
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    Container(
                      child: Center(
                        child: Text("Tidak ada Riwayat"),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text("Tidak ada Riwayat"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
