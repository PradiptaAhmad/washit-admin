import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:washit_admin/presentation/screens.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize the NavbarController
    final NavigationController controller = Get.put(NavigationController());

    return Scaffold(
      body: Obx(() {
        return controller.currentScreen;
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          // Ensure labels are fixed
          currentIndex: controller.selectedIndex.value,
          onTap: (index) {
            controller.changeIndex(index);
          },
          selectedFontSize: 11,
          unselectedItemColor: Colors.grey,
          unselectedLabelStyle: TextStyle(
            fontSize: 11,
            color: Colors.grey,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
          selectedLabelStyle: TextStyle(
            color: Colors.black.withOpacity(0.7),
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
          selectedItemColor: Colors.black.withOpacity(0.7),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.local_laundry_service_rounded, size: 22),
              activeIcon: Icon(Icons.local_laundry_service_rounded, size: 22),
              label: 'Beranda', // Label will always be visible
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.donut_large_rounded,
                size: 22,
              ),
              activeIcon: Icon(Icons.donut_large_rounded,
                  size: 22, color: Colors.black.withOpacity(0.7)),
              label: 'Status', // Label will always be visible
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_rounded,
                size: 22,
              ),
              activeIcon: Icon(Icons.person_rounded,
                  size: 22, color: Colors.black.withOpacity(0.7)),
              label: 'Pengguna', // Label will always be visible
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.more_horiz_rounded,
                size: 22,
              ),
              activeIcon: Icon(Icons.more_horiz_rounded,
                  size: 22, color: Colors.black.withOpacity(0.7)),
              label: 'Lainnya', // Label will always be visible
            ),
          ],
        );
      }),
    );
  }
}

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  Widget get currentScreen {
    switch (selectedIndex.value) {
      case 0:
        return HomePageScreen();
      case 1:
        return StatusPageScreen();
      case 2:
        return UsersPageScreen();
      case 3:
        return SettingPage();
      default:
        return HomePageScreen();
    }
  }
}
