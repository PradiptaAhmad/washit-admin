import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:washit_admin/infrastructure/navigation/routes.dart';
import 'package:washit_admin/presentation/home_page/controllers/orverview_main_controller.dart';
import 'package:washit_admin/widget/common/content_title_widget.dart';
import 'package:washit_admin/widget/common/main_container_widget.dart';
import '../../../infrastructure/theme/themes.dart';

class OverviewMainChartBar extends StatelessWidget {
  const OverviewMainChartBar({super.key});

  @override
  Widget build(BuildContext context) {
    final OrverviewMainController controller =
        Get.put(OrverviewMainController());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: ContentTitleWidget(
              title: "Sedang Berlangsung",
              subtitle: "Lihat Selengkapnya",
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: InkWell(
              onTap: () {},
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (controller.ordersList.isEmpty) {
                  return Center(
                    child: Text(
                      "Tidak ada transaksi",
                      style: tsBodyMediumMedium(darkGrey),
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount: controller.ordersList.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final order = controller.ordersList[index];
                        return MainContainerWidget(
                          childs: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "id Pesanan",
                                          style: tsLabelLargeMedium(grey),
                                        ),
                                        Text(
                                          '${order['no_pemesanan']}',
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
                                            "Estimasi: ${DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.parse(order['tanggal_estimasi'].toString()))}}",
                                            style: tsLabelLargeMedium(darkGrey),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 1),
                                  child:
                                      Divider(color: lightGrey, thickness: 0.5),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${order['nama_pemesan']}",
                                          style: tsBodySmallSemibold(black),
                                        ),
                                        Text(
                                          order['jenis_pemesanan'] ==
                                                  'antar_jemput'
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
                                          style:
                                              tsBodySmallSemibold(successColor),
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
                                )
                              ],
                            ),
                          ),
                        );
                      });
                }
              }),
            ),
          ),
          SizedBox(
            height: 0,
          )
        ],
      ),
    );
  }
}
