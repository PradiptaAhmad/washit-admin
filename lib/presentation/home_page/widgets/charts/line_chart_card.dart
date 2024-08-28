import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washit_admin/infrastructure/theme/themes.dart';
import 'package:washit_admin/presentation/home_page/controllers/home_page.controller.dart';
import 'package:washit_admin/widget/common/main_container_widget.dart';

import '../../data/line_chart_data.dart';

class LineChartCard extends GetView<HomePageController> {
  const LineChartCard({
    this.chartData,
    this.title,
    Key? key,
  }) : super(key: key);

  final List<FlSpot>? chartData;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final data = LineData();

    return MainContainerWidget(
      margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
      padding: const EdgeInsets.all(20),
      childs: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "null",
            style: tsLabelLargeSemibold(grey),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: AspectRatio(
              aspectRatio: 16 / 6,
              child: LineChart(
                LineChartData(
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipColor: (touchedSpot) => secondaryColor,
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map(
                          (touchedSpot) {
                            return LineTooltipItem(
                              touchedSpot.y.toString(),
                              TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ).toList();
                      },
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    horizontalInterval: 5,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey[300],
                        strokeWidth: 1,
                      );
                    },
                    drawVerticalLine: true,
                    verticalInterval: 10,
                    getDrawingVerticalLine: (value) {
                      return FlLine(
                        color: lightGrey,
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    rightTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return data.orderBottomTitle[value.toInt()] != null
                              ? SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  child: Text(
                                      data.orderBottomTitle[value.toInt()]
                                          .toString(),
                                      style:
                                          TextStyle(fontSize: 12, color: grey)),
                                )
                              : const SizedBox();
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return data.orderleftTitle[value.toInt()] != null
                              ? Text(
                                  data.orderleftTitle[value.toInt()].toString(),
                                  style: TextStyle(fontSize: 12, color: grey))
                              : const SizedBox();
                        },
                        showTitles: true,
                        interval: 1,
                        reservedSize: 30,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                        color: secondaryColor,
                        barWidth: 2.5,
                        belowBarData: BarAreaData(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              secondaryColor.withOpacity(0.5),
                              primaryColor,
                            ],
                          ),
                          show: true,
                        ),
                        dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) {
                              return FlDotCirclePainter(
                                radius: 3,
                                color: secondaryColor,
                                strokeWidth: 0,
                                strokeColor: secondaryColor,
                              );
                            }),
                        spots: chartData!)
                  ],
                  minX: 0,
                  maxX: 60,
                  maxY: 20,
                  minY: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
