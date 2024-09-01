import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washit_admin/widget/common/main_container_widget.dart';

import '../../infrastructure/theme/themes.dart';
import 'controllers/history_page.controller.dart';

class HistoryPageScreen extends GetView<HistoryPageController> {
  const HistoryPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HistoryPageController controller = Get.put(HistoryPageController());

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              backgroundColor: secondaryColor,
              title: Text('Riwayat Pesanan',
                  style: tsTitleSmallMedium(primaryColor)),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                shrinkWrap: true,
                itemCount: controller.orderList.length,
                itemBuilder: (context, index) {
                  var order = controller.orderList[index];
                  return MainContainerWidget(
                    margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    height: 100,
                  );
                },
              ),
      ),
    );
  }
}
