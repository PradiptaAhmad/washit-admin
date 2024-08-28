import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washit_admin/infrastructure/theme/themes.dart';
import 'package:washit_admin/presentation/home_page/data/line_chart_data.dart';
import 'package:washit_admin/presentation/home_page/widgets/charts/line_chart_card.dart';
import 'package:washit_admin/widget/common/main_container_widget.dart';

import '../../controllers/home_page.controller.dart';

class RightTabWidget extends GetView<HomePageController> {
  RightTabWidget({Key? key, required this.data}) : super(key: key);

  final LineData data;

  final dayToXValue = {
    'Senin': 0.0, //  M o n d a y
    'Selasa': 10.0, //  T u e s d a y
    'Rabu': 20.0, //  W e d n e s d a y
    'Kamis': 30.0, //  T h u r s d a y
    'Jumat': 40.0, //  F r i d a y
    'Sabtu': 50.0, //  S a t u r d a y
    'Minggu': 60.0, //  S u n d a y
  };

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
                          Text("${controller.sumTotalEarnings.value}",
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
              title: "TRANSAKSI MINGGU INI",
              chartData: controller.weeklyTransactionChartDatas
                  .map((e) => FlSpot(dayToXValue[e.createdAt] ?? 0.0,
                      double.parse(e.totalTransactions.toString())))
                  .toList(),
            ),
            ElevatedButton(
                onPressed: () => print(controller.weeklyTransactionChartDatas),
                child: Text("data")),

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
