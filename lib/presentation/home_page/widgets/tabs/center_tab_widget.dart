import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washit_admin/presentation/home_page/widgets/charts/line_chart_card.dart';
import 'package:washit_admin/widget/common/main_container_widget.dart';
import 'package:washit_admin/widget/shimmer/shimmer_widget.dart';

import '../../../../infrastructure/theme/themes.dart';
import '../../controllers/home_page.controller.dart';

class CenterTabWidget extends GetView<HomePageController> {
  CenterTabWidget({Key? key}) : super(key: key);

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
          children: [
            const SizedBox(height: 10),
            UpperInformationWidget(controller),
            const SizedBox(height: 10),
            Obx(
                  () => !controller.isLoading.value
                  ? LineChartCard(
                title: "PESANAN MINGGU INI",
                chartData: controller.weeklyOrderChartDatas
                    .map((e) => FlSpot(dayToXValue[e.createdAt] ?? 0.0,
                    double.parse(e.totalOrders ?? '0')))
                    .toList(),
              )
                  : ShimmerWidget(
                height: 201.5,
                margin: defaultMargin,
                radius: 10,
              ),
            ),
            const SizedBox(height: 15),
            // Uncomment and implement if needed
            // ContentTitleWidget(
            //   margin: const EdgeInsets.symmetric(horizontal: 15),
            //   title: "STATUS PESANAN",
            //   lefttextSize: tsBodySmallSemibold(grey),
            // ),
            // const SizedBox(height: 10),
            // ListView.builder(
            //   physics: const NeverScrollableScrollPhysics(),
            //   itemCount: 2,
            //   shrinkWrap: true,
            //   itemBuilder: (context, index) => _buildItemList(),
            // ),
          ],
        ),
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
                    Text("${controller.dailyOrderData['total_orders']}",
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
                      "${controller.sumTotalOrders}",
                      style: tsTitleLargeSemibold(black),
                    ),
                ]),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildItemList() {
  return LayoutBuilder(
    builder: (context, constraints) {
      final margin = constraints.maxWidth * 0.03;
      return MainContainerWidget(
        margin: EdgeInsets.symmetric(horizontal: margin),
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        childs: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Marlen Edzel Satriani",
              style: tsBodySmallMedium(black),
            ),
            SizedBox(
              width: constraints.maxWidth * 0.8,
              child: Text(
                "Jl. Pala no 108 Binagriya Blok A, Medono, Pekalongan Barat, Pekalongan, Jawa Tengah 51111",
                style: tsLabelLargeMedium(grey),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              "ID19012093709189080",
              style: tsLabelLargeMedium(darkGrey),
            ),
          ],
        ),
      );
    },
  );
}
