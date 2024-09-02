import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:washit_admin/presentation/history_page/history_page.screen.dart';
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
          showUnselectedLabels: false,
          showSelectedLabels: true,
          selectedItemColor: Colors.black.withOpacity(0.7),
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.receipt_outlined,
                size: 22,
              ),
              activeIcon: Icon(Icons.receipt_rounded,
                  size: 22, color: Colors.black.withOpacity(0.7)),
              label: 'Riwayat', // Label will always be visible
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.local_laundry_service_outlined,
                size: 22,
              ),
              activeIcon: Icon(Icons.local_laundry_service_rounded,
                  size: 22, color: Colors.black.withOpacity(0.7)),
              label: 'Berlangsung', // Label will always be visible
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 22),
              activeIcon: Icon(Icons.home_rounded, size: 22),
              label: 'Beranda', // Label will always be visible
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                size: 22,
              ),
              activeIcon: Icon(Icons.person_rounded,
                  size: 22, color: Colors.black.withOpacity(0.7)),
              label: 'Pengguna', // Label will always be visible
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.more_horiz_outlined,
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
  var selectedIndex = 2.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  Widget get currentScreen {
    switch (selectedIndex.value) {
      case 0:
        return HistoryPageScreen();
      case 1:
        return StatusPageScreen();
      case 2:
        return HomePageScreen();
      case 3:
        return UsersPageScreen();
      case 4:
        return SettingPage();
      default:
        return HomePageScreen();
    }
  }
}
