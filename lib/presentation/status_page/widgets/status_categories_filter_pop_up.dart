import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washit_admin/presentation/status_page/controllers/status_page.controller.dart';

import '../../../infrastructure/theme/themes.dart';

Future statusCategoriesFilterPopUp(
    BuildContext context, StatusPageController controller) {
  return showModalBottomSheet(
    context: context,
    isDismissible: true,
    isScrollControlled:
        true, // Ensures the bottom sheet height can adjust dynamically
    builder: (context) {
      final screenHeight = MediaQuery.of(context).size.height;
      final sheetHeight =
          screenHeight * 0.35; // Adjust height based on screen size

      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(defaultMargin),
        constraints: BoxConstraints(maxHeight: sheetHeight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () => Get.back(),
                  child: Icon(Icons.close_rounded, color: black),
                ),
                SizedBox(width: 10),
                Text("Filter konten status", style: tsBodyMediumMedium(black)),
              ],
            ),
            SizedBox(height: defaultMargin),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  buildFilterOption(controller, "Semua status", 0),
                  SizedBox(height: defaultMargin),
                  buildFilterOption(controller, "Baru dibuat", 1),
                  SizedBox(height: defaultMargin),
                  buildFilterOption(controller, "Menunggu konfirmasi", 2),
                  SizedBox(height: defaultMargin),
                  buildFilterOption(controller, "Sedang diproses", 3),
                  SizedBox(height: defaultMargin),
                  buildFilterOption(controller, "Belum dibayar", 4),
                  SizedBox(height: defaultMargin),
                  buildFilterOption(controller, "Selesai", 5),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget buildFilterOption(
    StatusPageController controller, String text, int index) {
  return InkWell(
    onTap: () {
      controller.selectedFilter.value = index;
      controller.statusSelectedFilterName.value = text;
      controller.applyFilter();
      Get.back();
    },
    splashColor: Colors.transparent,
    child: Container(
      height: 40, // Increased height for better touch targets
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              text,
              style: tsBodySmallMedium(black),
              overflow:
                  TextOverflow.ellipsis, // Ensures long text doesn't overflow
            ),
          ),
          circleRadioButton(
            selected: controller.selectedFilter.value == index,
          ),
        ],
      ),
    ),
  );
}

class circleRadioButton extends StatelessWidget {
  const circleRadioButton({
    Key? key,
    required this.selected,
  }) : super(key: key);

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              border:
                  Border.all(color: selected ? secondaryColor : grey, width: 2),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              color: selected ? secondaryColor : Colors.transparent,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ],
      ),
    );
  }
}
