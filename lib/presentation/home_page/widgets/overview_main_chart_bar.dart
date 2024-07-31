import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washit_admin/infrastructure/navigation/routes.dart';
import 'package:washit_admin/presentation/home_page/controllers/orverview_main_controller.dart';
import 'package:washit_admin/widget/common/content_title_widget.dart';
import 'package:washit_admin/widget/common/detail_widget.dart';
import 'package:washit_admin/widget/common/main_container_widget.dart';
import '../../../infrastructure/theme/themes.dart';

class OverviewMainChartBar extends StatelessWidget {
  const OverviewMainChartBar({super.key});

  @override
  Widget build(BuildContext context) {
    final OrverviewMainController controller = Get.put(OrverviewMainController());

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
            padding: const EdgeInsets.only(bottom: 15),
            child: InkWell(
              onTap: () => Get.toNamed(Routes.TRANSACTION_PAGE),
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
                                "No. Transaksi",
                                style: tsLabelLargeMedium(grey),
                              ),
                              Text(
                                "ORD001",
                                style: tsLabelLargeMedium(black),
                              ),
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
                                  "Estimasi: ",
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
                                "Cuci Setrika - Marlen",
                                style: tsBodySmallSemibold(black),
                              ),
                              Text(
                                "7 Kg",
                                style: tsLabelLargeSemibold(darkGrey),
                              ),
                              Text(
                                "Rp 42.000",
                                style: tsLabelLargeSemibold(darkGrey),
                              ),
                              Text(
                                "Nama Laundry",
                                style: tsBodySmallSemibold(successColor),
                              ),
                            ],
                          ),
                          Container(
                            width: 120,
                            child: Text(
                              "Jl.Pala no 108, Binagritya blok A, Medono, Pekalongan Barat, Pekalongan, Indonesia",
                              style: tsLabelLargeSemibold(grey),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                              maxLines: 4,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
