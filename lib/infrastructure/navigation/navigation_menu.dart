import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:washit_admin/presentation/home_page/home_page.screen.dart';
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
              icon: Icon(Iconsax.home),
              selectedIcon: Icon(
                Iconsax.home1,
                color: darkGrey,
              ),
              // New line: selected icon
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(Iconsax.status),
              selectedIcon: Icon(
                Iconsax.status5,
                color: darkGrey,
              ),
              // New line: selected icon
              label: "Status",
            ),
            NavigationDestination(
              icon: Icon(Iconsax.message),
              selectedIcon: Icon(
                Iconsax.message5,
                color: darkGrey,
              ),
              // New line: selected icon
              label: "Messages",
            ),
            NavigationDestination(
              icon: Icon(Iconsax.setting),
              selectedIcon: Icon(
                Iconsax.setting1,
                color: darkGrey,
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
    Container(color: Colors.red),
    Container(color: Colors.blue),
    Container(color: Colors.yellow),
  ];
}
