import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washit_admin/presentation/screens.dart';

import '../theme/themes.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          backgroundColor: primaryColor,
          indicatorColor: Color(0xFFFFFBFE),
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(
              icon: Icon(
                Icons.home_filled,
                color: darkGrey,
              ),
              selectedIcon: Icon(
                Icons.home_filled,
                color: black,
              ),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(
                Icons.reorder_rounded,
                color: darkGrey,
              ),
              selectedIcon: Icon(
                Icons.reorder_rounded,
                color: black,
              ),
              label: "Status",
            ),
            NavigationDestination(
              icon: Icon(
                Icons.person,
                color: darkGrey,
              ),
              selectedIcon: Icon(
                Icons.person,
                color: black,
              ),
              label: "Users",
            ),
            NavigationDestination(
              icon: Icon(
                Icons.settings,
                color: darkGrey,
              ),
              selectedIcon: Icon(
                Icons.settings,
                color: black,
              ),
              label: "Settings",
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    HomePageScreen(),
    StatusPageScreen(),
    UsersPageScreen(),
    SettingsPageScreen(),
  ];
}
