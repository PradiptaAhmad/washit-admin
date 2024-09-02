import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:washit_admin/infrastructure/navigation/routes.dart';
import 'package:washit_admin/presentation/history_page/widget/history_filter_button.dart';
import 'package:washit_admin/widget/common/main_container_widget.dart';
import 'package:washit_admin/widget/common/warning/data_is_empty.dart';
import 'package:washit_admin/widget/shimmer/shimmer_widget.dart';

import '../../infrastructure/theme/themes.dart';
import 'controllers/history_page.controller.dart';

class HistoryPageScreen extends GetView<HistoryPageController> {
  const HistoryPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HistoryPageController controller = Get.put(HistoryPageController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 50),
        child: _buildAppbar(controller),
      ),
      body: RefreshIndicator(
          onRefresh: () => controller.onRefresh(),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return _buildLoading(controller);
                }
                if (controller.ordersList.isEmpty) {
                  return DataIsEmpty("Riwayat pesanan kamu masih kosong");
                }
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.isSelected.value == 0
                        ? controller.ordersList.length
                        : controller.filteredOrdersList.length,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final order = controller.ordersList[index];
                      return MainDetailView(
                          order: order, controller: controller);
                    });
              }))),
    );
  }
}

Widget _buildAppbar(controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppBar(
        backgroundColor: secondaryColor,
        title: Text('Riwayat Pesanan', style: tsTitleSmallMedium(primaryColor)),
      ),
      SizedBox(height: 10),
      HistoryFilterButton(),
    ],
  );
}

Widget _buildLoading(controller) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: 4,
    physics: NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: defaultMargin),
        child: ShimmerWidget(
          height: 200,
          radius: 10,
        )),
  );
}

class MainDetailView extends StatelessWidget {
  const MainDetailView(
      {super.key, required this.order, required this.controller});

  final Map<String, dynamic> order;
  final controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: () => Get.toNamed(
          Routes.DETAIL_HISTORY_PAGE,
          arguments: {'orderId': order['id']},
        ),
        child: MainContainerWidget(
          childs: Padding(
            padding: const EdgeInsets.all(15),
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
                          "${order['no_pemesanan']}",
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
                            "Estimasi: ${DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.parse(order['tanggal_estimasi'].toString() == 'null' ? "2007-07-31 00:00:00" : order['tanggal_estimasi'].toString()))}",
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
                          "${order['nama_pemesan']}",
                          style: tsBodySmallSemibold(black),
                        ),
                        Text(
                          order['jenis_pemesanan'] == 'antar_jemput'
                              ? "Antar Jemput"
                              : "Antar Mandiri",
                          style: tsLabelLargeSemibold(darkGrey),
                        ),
                        Text(
                          order['berat_laundry'] == null
                              ? "Berat belum tercatat"
                              : "${order['berat_laundry']} Kg",
                          style: tsLabelLargeSemibold(darkGrey),
                        ),
                        Text(
                          "${order['nama_laundry']}",
                          style: tsBodySmallSemibold(successColor),
                        ),
                      ],
                    ),
                    Container(
                      width: 120,
                      child: Text(
                        "${order['alamat']}",
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
                          order['total_harga'] == null
                              ? "Harga belum tercatat"
                              : '${NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0).format(order['total_harga'])}',
                          style: tsBodySmallSemibold(black),
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
  }
}