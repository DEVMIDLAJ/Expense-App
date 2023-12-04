import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartHome extends StatelessWidget {
  const LineChartHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: 230,
      child: LineChart(LineChartData(
          minX: 0,
          maxX: 11,
          minY: 0,
          maxY: 6,
          titlesData: const FlTitlesData(show: false),
          gridData: const FlGridData(
            show: false,
            drawVerticalLine: false,
          ),
          borderData: FlBorderData(
            show: false,
          ),
          lineBarsData: [
            LineChartBarData(
              belowBarData: BarAreaData(
                show: true,
                gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 183, 155, 230),
                      Colors.white,
                    ]),
              ),
              color: Colors.deepPurple,
              spots: [
                const FlSpot(-2, 1),
                const FlSpot(1.5, 2),
                const FlSpot(3.5, 5),
                const FlSpot(6.5, 3),
                const FlSpot(9, 4),
                const FlSpot(11, 2),
                const FlSpot(14, 1)
              ],
              isCurved: true,
              dotData: const FlDotData(show: false),
              barWidth: 5,
            )
          ])),
    );
  }
}