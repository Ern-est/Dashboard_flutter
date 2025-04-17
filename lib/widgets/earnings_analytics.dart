import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class EarningsAnalytics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Earnings Over Time',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 1.5,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: true),
                  minX: 0,
                  maxX: 5,
                  minY: 0,
                  maxY: 3000,
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 2000),
                        FlSpot(1, 1500),
                        FlSpot(2, 2200),
                        FlSpot(3, 1700),
                        FlSpot(4, 2500),
                        FlSpot(5, 2300),
                      ],
                      isCurved: true,
                      color: Colors.tealAccent,
                      dotData: FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
