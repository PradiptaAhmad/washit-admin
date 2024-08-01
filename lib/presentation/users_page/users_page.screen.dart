import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/themes.dart';
import '../../widget/common/circle_tab_indicator.dart';
import 'controllers/users_page.controller.dart';
import '../review_page/review_page.screen.dart';

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
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: defaultMargin),
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
                              margin: EdgeInsets.symmetric(vertical: 5.0),
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.withOpacity(0.5)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: AssetImage(user.imagePath),
                                    onBackgroundImageError: (exception, stackTrace) {
                                      print('Error loading asset: ${user.imagePath}');
                                    },
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(user.name, style: TextStyle(fontWeight: FontWeight.bold)),
                                            SizedBox(width: 8),
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                "Status",
                                                style: TextStyle(color: Colors.white, fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Text(user.phoneNumber, style: TextStyle(color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('12:00', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                      SizedBox(height: 4),
                                      Icon(Icons.more_vert, color: Colors.grey),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }),
                      ReviewPageScreen(),
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
