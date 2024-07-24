import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washit_admin/infrastructure/navigation/routes.dart';
import 'package:washit_admin/presentation/home_page/controllers/orverview_main_controller.dart';
import 'package:washit_admin/widget/common/content_title_widget.dart';
import 'package:washit_admin/widget/common/detail_widget.dart';
import '../../../infrastructure/theme/themes.dart';

class OverviewMainChartBar extends StatelessWidget {
  const OverviewMainChartBar({super.key});

  @override
  Widget build(BuildContext context) {
    final OrverviewMainController controller = Get.put(OrverviewMainController());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Column(
                children: [
                  ContentTitleWidget(
                    title: "Sedang Berlangsung",
                    subtitle: "Lihat Selengkapnya",
                  ),
                  Obx(() {
                    if (controller.isLoading.value) {
                      return Padding(
                        padding: const EdgeInsets.all(defaultMargin),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (controller.ordersList.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(defaultMargin),
                        child: Center(
                          child: Text(
                            'Order Tidak Bisa Ditemukan',
                            style: tsBodySmallMedium(black),
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.ordersList.length > 4
                          ? 4
                          : controller.ordersList.length,
                      itemBuilder: (context, index) {
                        final order = controller.ordersList[index];
                        final laundryId = int.parse(order.laundryId.toString());

                        int adjustedIndex = laundryId - 1;
                        adjustedIndex = adjustedIndex >= 0 ? adjustedIndex : 0;

                        final jenisPesanan = controller.jenisList.isNotEmpty
                            ? controller.jenisList[adjustedIndex]
                            : 'Loading...';
                        return DetailWidget(
                          onPressed: () {
                            controller.goToDetailTransactionPage(index);
                          },
                          paddingValues: 10,
                          transcationNum:
                          "No. Transaksi - ${order.noPemesanan}",
                          title: "${jenisPesanan} - ${order.namaPemesan}",
                          subTitle: order.beratLaundry == null
                              ? "Berat Belum Di Hitung"
                              : "${order.beratLaundry}",
                          bottomTitle: order.totalHarga == null
                              ? "Harga Belum Di Hitung"
                              : "Rp. ${order.totalHarga}",
                          childs: Container(
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  order.tanggalPemesanan ?? "",
                                  style: tsLabelLargeRegular(black),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(6),
                                    color: successColor,
                                  ),
                                  height: 30,
                                  width: 80,
                                  child: Center(
                                    child: Text("Selesai",
                                        style: tsLabelLargeSemibold(
                                            primaryColor)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
