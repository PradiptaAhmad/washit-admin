import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washit_admin/infrastructure/theme/themes.dart';
import 'package:washit_admin/presentation/home_page/data/line_chart_data.dart';
import 'package:washit_admin/presentation/home_page/widgets/charts/line_chart_card.dart';
import 'package:washit_admin/widget/common/main_container_widget.dart';

import '../../controllers/home_page.controller.dart';

class RightTabWidget extends GetView<HomePageController> {
  const RightTabWidget({Key? key, required this.data}) : super(key: key);

  final LineData data;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => controller.onRefresh(),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 10),
            MainContainerWidget(
              margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
              padding: const EdgeInsets.all(15),
              childs: Row(
                children: [
                  MainContainerWidget(
                    height: 50,
                    width: 50,
                    childs: Icon(
                      Icons.monetization_on_rounded,
                      size: 30,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("PENDAPATAN HARI INI",
                              style: tsLabelLargeSemibold(grey)),
                          Text("Rp. 220.000,000",
                              style: tsBodyLargeSemibold(black)),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => print("Lihat Detail"),
                    child: Container(
                      child: Icon(Icons.keyboard_arrow_right_rounded),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            LineChartCard(
              chartData: data.transactionSpotsWeekly,
            )
            // const SizedBox(height: 10),
            // MainDataVisualWidget(
            //   title1: "Hari Ini",
            //   desc1: "25000",
            //   dataChart1: data.transactionSpotsDaily,
            //   title2: "Bulan Ini",
            //   desc2: "250000",
            //   dataChart2: data.transactionSpotsMonthly,
            //   dataChart3: data.transactionSpotsWeekly,
            // ),
            // const SizedBox(
            //   height: 15,
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //       color: lightGrey, borderRadius: BorderRadius.circular(10)),
            //   height: 1,
            //   width: double.infinity,
            // ),
            // const SizedBox(
            //   height: 5,
            // ),
            // NewestTransactionWidget(
            //   mainTitle: "Invoice Transaksi",
            // ),
          ],
        ),
      ),
    );
  }
}
