import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washit_admin/infrastructure/theme/themes.dart';
import 'package:washit_admin/presentation/home_page/widgets/charts/line_chart_card.dart';
import 'package:washit_admin/widget/common/main_container_widget.dart';

import '../../controllers/home_page.controller.dart';

class RightTabWidget extends GetView<HomePageController> {
  RightTabWidget({Key? key}) : super(key: key);

  final dayToXValue = {
    'Senin': 0.0,
    'Selasa': 10.0,
    'Rabu': 20.0,
    'Kamis': 30.0,
    'Jumat': 40.0,
    'Sabtu': 50.0,
    'Minggu': 60.0,
  };

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => controller.onRefresh(),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            UpperInformationWidget(controller),
            const SizedBox(height: 10),
            _buildIncomeWidgets(context),
            const SizedBox(height: 10),
            LineChartCard(
              title: "TRANSAKSI MINGGU INI",
              chartData: controller.weeklyTransactionChartDatas
                  .map((e) => FlSpot(dayToXValue[e.createdAt] ?? 0.0,
                  double.parse(e.totalTransactions.toString())))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIncomeWidgets(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            _buildIncomeWidget(
              context,
              title: "PENDAPATAN HARI INI",
              amount: "Rp. ${controller.dailyTransactionData['total_income']}",
              margin: constraints.maxWidth * 0.05,
            ),
            const SizedBox(height: 10),
            _buildIncomeWidget(
              context,
              title: "PENDAPATAN MINGGU INI",
              amount: "Rp. ${controller.sumTotalEarnings.value}",
              margin: constraints.maxWidth * 0.05,
            ),
          ],
        );
      },
    );
  }

  Widget _buildIncomeWidget(BuildContext context, {required String title, required String amount, required double margin}) {
    return MainContainerWidget(
      margin: EdgeInsets.symmetric(horizontal: margin),
      padding: const EdgeInsets.all(15),
      childs: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MainContainerWidget(
            height: 50,
            width: 50,
            childs: Icon(
              Icons.monetization_on_rounded,
              size: 30,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: tsLabelLargeSemibold(grey)),
                Text(amount, style: tsBodyLargeSemibold(black)),
              ],
            ),
          ),
          // Uncomment if needed
          // InkWell(
          //   onTap: () => print("Lihat Detail"),
          //   child: Container(
          //     child: Icon(Icons.keyboard_arrow_right_rounded),
          //   ),
          // )
        ],
      ),
    );
  }
}

Widget UpperInformationWidget(HomePageController controller) {
  return LayoutBuilder(
    builder: (context, constraints) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.05),
        child: Row(
          children: [
            Expanded(
              child: MainContainerWidget(
                padding: const EdgeInsets.all(15),
                childs: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("TOTAL HARI INI", style: tsLabelLargeSemibold(grey)),
                    const SizedBox(height: 5),
                    Text("${controller.dailyTransactionData['total_transactions']}",
                        style: tsTitleLargeSemibold(black)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: MainContainerWidget(
                padding: const EdgeInsets.all(15),
                childs: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("TOTAL MINGGU INI", style: tsLabelLargeSemibold(grey)),
                    const SizedBox(height: 5),
                    Text(
                        "${controller.dailyTransactionData['total_transactions'] ?? 0}",
                        style: tsTitleLargeSemibold(black)),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
