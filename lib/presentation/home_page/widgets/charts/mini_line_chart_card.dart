import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../infrastructure/theme/themes.dart';
import '../../../../widget/common/custom_card_widget.dart';
import '../../data/line_chart_data.dart';

class MiniLineChartCard extends StatelessWidget {
  const MiniLineChartCard({
    this.graphColor,
    this.dataChart = const [],
    Key? key,
  }) : super(key: key);

  final Color? graphColor;
  final List<FlSpot>? dataChart;

  @override
  Widget build(BuildContext context) {
    final data = LineData();
    final Color colorToUse = graphColor ??
        primaryColor; // Use graphColor if provided, otherwise use successColor

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          AspectRatio(
            aspectRatio: 16 / 6,
            child: LineChart(
              LineChartData(
                lineTouchData: const LineTouchData(
                  handleBuiltInTouches: true,
                ),
                gridData: FlGridData(
                  show: false,
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
                      showTitles: false,
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
                      showTitles: false,
                      interval: 1,
                      reservedSize: 40,
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    color: colorToUse,
                    barWidth: 2.5,
                    belowBarData: BarAreaData(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          colorToUse.withOpacity(0.5),
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
                            color: colorToUse,
                            strokeWidth: 0,
                            strokeColor: colorToUse,
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
