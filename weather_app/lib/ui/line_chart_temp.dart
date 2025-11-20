import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/logic/entities/hourly_forecast_entity.dart';
import 'package:weather_app/ui/line_chart_temp_y_axis.dart';

class LinechartTemp extends StatelessWidget {
  final List<HourlyForecastEntity> hourlyForecastEntityList;
  late final int minY;
  late final int maxY;
  LinechartTemp({super.key, required this.hourlyForecastEntityList}) {
    minY =
        ((hourlyForecastEntityList.reduce(
                  (a, b) => a.temperature < b.temperature ? a : b,
                )).temperature -
                2)
            .round();
    maxY =
        ((hourlyForecastEntityList.reduce(
                  (a, b) => a.temperature > b.temperature ? a : b,
                )).temperature +
                2)
            .round();
  }

  @override
  Widget build(BuildContext context) {
    // Stack für Beschriftung der Y-Achse
    return Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: 1200,
            // Stack für Icons
            child: Stack(
              children: [
                LineChart(
                  LineChartData(
                    minY: minY.toDouble(),
                    maxY: maxY.toDouble(),
                    minX: -1,
                    maxX: 24,
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      //Left
                      leftTitles: AxisTitles(
                        sideTitleAlignment: SideTitleAlignment.inside,
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      // Right
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      // Top
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      // Bottom
                      bottomTitles: AxisTitles(
                        sideTitleAlignment: SideTitleAlignment.inside,
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          minIncluded: false,
                          maxIncluded: false,
                          getTitlesWidget: (value, meta) =>
                              Text('${value.toInt().toString()}:00'),
                        ),
                      ),
                    ),
                    lineBarsData: [
                      // Temperaturgraph
                      LineChartBarData(
                        isCurved: true,
                        barWidth: 10,
                        color: Colors.red,
                        spots: hourlyForecastEntityList.map((e) {
                          return FlSpot(e.time.hour.toDouble(), e.temperature);
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        IgnorePointer(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(5, 10, 0, 10),
              child: LineChartTempYAxis(minY: minY, maxY: maxY, unit: 'C°'),
            ),
          ),
        ),
      ],
    );
  }
}
