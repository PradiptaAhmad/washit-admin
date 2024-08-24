import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:washit_admin/infrastructure/theme/themes.dart';

import '../../../../widget/common/custom_card_widget.dart';
import '../../data/line_chart_data.dart';

class LineChartCard extends StatelessWidget {
  const LineChartCard({
    this.dataChart = const [],
    Key? key,
  }) : super(key: key);

  final List<FlSpot>? dataChart;

  @override
  Widget build(BuildContext context) {
    final data = LineData();

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Grafis aktivitas pesanan",
            style: tsBodySmallSemibold(black),
          ),
          const SizedBox(height: 20),
          AspectRatio(
            aspectRatio: 16 / 6,
            child: LineChart(
              LineChartData(
                lineTouchData: const LineTouchData(
                  handleBuiltInTouches: true,
                ),
                gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: true,
                  horizontalInterval: 10,
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
                      color: Colors.grey[300],
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
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
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey[400])),
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
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey[400]))
                            : const SizedBox();
                      },
                      showTitles: true,
                      interval: 1,
                      reservedSize: 40,
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    color: successColor,
                    barWidth: 2.5,
                    belowBarData: BarAreaData(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          successColor.withOpacity(0.5),
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
                            color: successColor,
                            strokeWidth: 0,
                            strokeColor: successColor,
                          );
                        }),
                    spots: dataChart ?? [],
                  )
                ],
                minX: 0,
                maxX: 60,
                maxY: 55,
                minY: -5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
