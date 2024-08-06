import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../infrastructure/navigation/routes.dart';
import '../../infrastructure/theme/themes.dart';
import '../../widget/common/categories_button_widget.dart';
import '../../widget/common/main_container_widget.dart';
import 'controllers/status_page.controller.dart';

class StatusPageScreen extends GetView<StatusPageController> {
  const StatusPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StatusPageController controller = Get.put(StatusPageController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(kToolbarHeight + 50), // Add extra height for margin
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              backgroundColor: secondaryColor,
              title: Text('Status Pesanan',
                  style: tsTitleSmallMedium(primaryColor)),
            ),
            SizedBox(height: 10),
            Container(
              color: primaryColor,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: defaultMargin),
                    CategoriesButtonWidget(
                      controller: controller,
                      title: "Semua status",
                      onTap: () => controller.tabController.animateTo(0),
                    ),
                    SizedBox(width: 5),
                    CategoriesButtonWidget(
                      controller: controller,
                      title: "Baru dibuat",
                      onTap: () => controller.tabController.animateTo(1),
                    ),
                    SizedBox(width: 5),
                    CategoriesButtonWidget(
                      controller: controller,
                      title: "Menunggu konfirmasi",
                      onTap: () => controller.tabController.animateTo(2),
                    ),
                    SizedBox(width: 5),
                    CategoriesButtonWidget(
                      controller: controller,
                      title: "Sedaang diproses",
                      onTap: () => controller.tabController.animateTo(3),
                    ),
                    SizedBox(width: 5),
                    CategoriesButtonWidget(
                      controller: controller,
                      title: "Selesai",
                      onTap: () => controller.tabController.animateTo(4),
                    ),
                    SizedBox(width: defaultMargin),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        physics: AlwaysScrollableScrollPhysics(),
        controller: controller.tabController,
        children: [
          RefreshIndicator(
            onRefresh: () async {
              await controller.fetchOrders();
            },
            child: StatusOrdersWidget(
              controller: controller,
            ),
          ),
          Center(
            child: Text('Second tab'),
          ),
          Center(
            child: Text('Third tab'),
          ),
          Center(
            child: Text('Fourth tab'),
          ),
          Center(
            child: Text('Fifth tab'),
          ),
        ],
      ),
    );
  }
}

class StatusOrdersWidget extends StatelessWidget {
  const StatusOrdersWidget({
    super.key,
    required this.controller,
  });

  final StatusPageController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? Center(
              child: CupertinoActivityIndicator(),
            )
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: controller.ordersList.length,
              itemBuilder: (context, index) {
                // var order = controller.ordersList[index];
                return Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 15, right: 15),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(
                        Routes.TRANSACTION_PAGE,
                        arguments: controller.ordersList[index],
                      );
                    },
                    child: MainContainerWidget(
                      childs: Padding(
                        padding: const EdgeInsets.all(defaultMargin),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "id Pesanan",
                                      style: tsLabelLargeMedium(grey),
                                    ),
                                    Text(
                                      "${controller.ordersList[index]['no_pemesanan']}",
                                      style: tsLabelLargeMedium(black),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 5,
                                        vertical: 2,
                                      ),
                                      child: Text(
                                        "${DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.parse(controller.ordersList[index]['tanggal_estimasi'].toString()))}",
                                        style: tsLabelLargeMedium(darkGrey),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 1),
                              child: Divider(color: lightGrey, thickness: 0.5),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${controller.ordersList[index]['nama_pemesan']}",
                                      style: tsBodySmallSemibold(black),
                                    ),
                                    Text(
                                      controller.ordersList[index]
                                                  ['jenis_pemesanan'] ==
                                              "antar_jemput"
                                          ? "Antar Jemput"
                                          : "Antar Mandiri",
                                      style: tsLabelLargeSemibold(darkGrey),
                                    ),
                                    Text(
                                      controller.ordersList[index]
                                                  ['berat_laundry'] ==
                                              null
                                          ? "Berat Belum tercatat"
                                          : "${controller.ordersList[index]['berat_laundry']} Kg",
                                      style: tsLabelLargeSemibold(darkGrey),
                                    ),
                                    Text(
                                      "${controller.ordersList[index]['nama_laundry']}",
                                      style: tsBodySmallSemibold(successColor),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 120,
                                  child: Text(
                                    "${controller.ordersList[index]['alamat']}",
                                    style: tsLabelLargeSemibold(grey),
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.right,
                                    maxLines: 4,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 18),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total harga",
                                      style: tsLabelMediumMedium(black),
                                    ),
                                    Text(
                                      controller.ordersList[index]
                                                  ['total_harga'] ==
                                              null
                                          ? "Belum Tercatat"
                                          : "${controller.ordersList[index]['total_harga']}",
                                      style: tsBodySmallSemibold(black),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Status laundry",
                                      style: tsLabelMediumMedium(black),
                                    ),
                                    Text(
                                      '${controller.ordersList[index]['status']}',
                                      style:
                                          tsBodySmallSemibold(secondaryColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
