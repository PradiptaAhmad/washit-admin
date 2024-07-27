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
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            margin: EdgeInsets.all(defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabBar(
                  labelColor: black,
                  unselectedLabelColor: darkGrey,
                  indicatorColor: secondaryColor,
                  dividerColor: Colors.transparent,
                  labelStyle: tsBodySmallSemibold(black),
                  controller: controller.tabController,
                  splashBorderRadius: BorderRadius.circular(75),
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
                      Obx(() {
                        return ListView.builder(
                          itemCount: controller.users.length,
                          itemBuilder: (context, index) {
                            final user = controller.users[index];
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: AssetImage(user.imagePath),
                                  onBackgroundImageError: (exception, stackTrace) {
                                    print('Error loading asset: ${user.imagePath}');
                                  },
                                ),
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(user.name),
                                    Text(user.phoneNumber),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }),
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
      ),
    );
  }
}