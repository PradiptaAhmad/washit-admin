import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:washit_admin/infrastructure/navigation/routes.dart';
import 'package:washit_admin/presentation/home_page/controllers/home_page.controller.dart';
import 'package:washit_admin/widget/common/main_container_widget.dart';
import 'package:washit_admin/widget/shimmer/shimmer_widget.dart';

import '../../../infrastructure/theme/themes.dart';

class OverviewMainChartBar extends GetView<HomePageController> {
  const OverviewMainChartBar({super.key});

  @override
  Widget build(BuildContext context) {
    // final OverviewMainController controller = Get.put(OverviewMainController());

    return Column(
      children: [
        Obx(() {
          if (controller.isLoading.isTrue) {
            return ListView.builder(
                itemCount: 4,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return _shimmerItemList();
                });
          }
          if (controller.ordersList.isEmpty) {
            return Center(
              child: Text(
                "Tidak ada transaksi",
                style: tsBodyMediumMedium(darkGrey),
              ),
            );
          }
          return ListView.builder(
              itemCount: 4,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final order = controller.ordersList[index];
                return _buildItemList(context, order);
              });
        }),
      ],
    );
  }
}

Widget _shimmerItemList() {
  return Column(
    children: [
      ShimmerWidget(height: 154, radius: 10),
      SizedBox(height: 10),
    ],
  );
}

Widget _buildItemList(BuildContext context, Map<String, dynamic> order) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10),
    child: MainContainerWidget(
      onPressed: () =>
          Get.toNamed(Routes.TRANSACTION_PAGE, arguments: order),
      padding: EdgeInsets.all(15),
      childs: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ID Pesanan",
                      style: tsLabelLargeMedium(grey),
                    ),
                    Text(
                      '${order['no_pemesanan']}',
                      style: tsLabelLargeMedium(black),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Estimasi: ${DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.parse(order['tanggal_estimasi'].toString()))}",
                    style: tsLabelLargeMedium(darkGrey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical:
                    MediaQuery.of(context).size.height * 0.01), // Responsive
            child: Divider(color: lightGrey, thickness: 0.5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Column(
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
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: Text(
                    "${order['alamat']}",
                    style: tsLabelLargeSemibold(grey),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                    maxLines: 4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
