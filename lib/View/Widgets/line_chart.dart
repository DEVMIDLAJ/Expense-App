import 'package:expence_app/const/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartHome extends StatelessWidget {
  const LineChartHome({super.key});

  @override
  Widget build(BuildContext context) {
        Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        SizedBox(
          height: size.height * 0.22,
          width: size.width,
          child: LineChart(
            LineChartData(
              minX: 1,
              maxX: 7.1,
              minY: 0,
              maxY: 7,
              borderData: FlBorderData(show: false),
              titlesData: const FlTitlesData(show: false),
              gridData: const FlGridData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: const [
                    FlSpot(0.2, 0.3),
                    FlSpot(0, 1),
                    FlSpot(1.8, 2.8),
                    FlSpot(2.9, 1.2),
                    FlSpot(3.7, 4.1),
                    FlSpot(4.9, 2.3),
                    FlSpot(6.1, 6.9),
                    FlSpot(6.9, 2.9),
                    FlSpot(8, 1.8),
                  ],
                  isCurved: true,
                  barWidth: 6,
                  color: kfirstColor,
                  dotData: const FlDotData(
                    show: false,
                  ),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: const LinearGradient(
                      end: Alignment.bottomCenter,
                      begin: Alignment.topCenter,
                      colors: [
                        ksecondColor,
                        ksecondColor,
                        kWhite,
                      ],
                    ),
                  ),
                  aboveBarData: BarAreaData(show: false),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
