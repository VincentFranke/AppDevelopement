import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'package:weather_app/logic/entities/detailed_day_forecast_entity.dart';
import 'package:weather_app/logic/mapper.dart';
import 'package:weather_app/ui/line_chart/axis_label.dart';
import 'package:weather_app/ui/line_chart/coordinate_calculator.dart';
import 'package:weather_app/ui/line_chart/chart_marker.dart';
import 'package:weather_app/ui/reusable/positioned_widget.dart';

class Linechart extends StatelessWidget {
  final DetailedDayForecastEntity detailedDayForecastEntity;
  late final int minY;
  late final int maxY;
  final int minX = -1;
  final int maxX = 24;
  Linechart({super.key, required this.detailedDayForecastEntity}) {
    minY = CoordinateCalculator.calculateMinY(
      hourlyForecastEntityList:
          detailedDayForecastEntity.hourlyForecastEntityList,
      extraSpace: 1,
    );
    maxY = CoordinateCalculator.calculateMaxY(
      hourlyForecastEntityList:
          detailedDayForecastEntity.hourlyForecastEntityList,
      extraSpace: 4,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double chartHeight = constraints.maxHeight;
        // Stack über dem Scrollview
        return Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 1000,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double chartWidth = constraints.maxWidth;
                    // Stack im Scrollview
                    return Stack(
                      children: [
                        LineChart(
                          LineChartData(
                            minY: minY.toDouble(),
                            maxY: maxY.toDouble(),
                            minX: minX.toDouble(),
                            maxX: maxX.toDouble(),
                            borderData: FlBorderData(show: false),
                            gridData: FlGridData(show: true),
                            titlesData: FlTitlesData(
                              show: true,
                              //Left
                              leftTitles: AxisTitles(
                                sideTitleAlignment: SideTitleAlignment.inside,
                                sideTitles: SideTitles(
                                  showTitles: false,
                                  maxIncluded: false,
                                  minIncluded: false,
                                  interval: 1,
                                  reservedSize: 50,
                                  getTitlesWidget: (value, meta) {
                                    return Text('${value}C°');
                                  },
                                ),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),
                            lineBarsData: [
                              // Temperaturgraph
                              LineChartBarData(
                                isCurved: true,
                                barWidth: 10,
                                color: Colors.red,
                                spots: detailedDayForecastEntity
                                    .hourlyForecastEntityList
                                    .map((e) {
                                      return FlSpot(
                                        e.time.hour.toDouble(),
                                        e.temperature,
                                      );
                                    })
                                    .toList(),
                                belowBarData: BarAreaData(
                                  show: true,
                                  color: Colors.red.withValues(alpha: 0.3),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Sunrise
                        ChartMarker(
                          text: AppLocalizations.of(context)!.sunrise,
                          detailedDayForecastEntity: detailedDayForecastEntity,
                          targetTime: detailedDayForecastEntity.sunrise,
                          chartHeight: chartHeight,
                          chartWidth: chartWidth,
                          minX: minX,
                          maxX: maxX,
                          minY: minY,
                          maxY: maxY,
                        ),

                        // Sunset
                        ChartMarker(
                          text: AppLocalizations.of(context)!.sunset,
                          detailedDayForecastEntity: detailedDayForecastEntity,
                          targetTime: detailedDayForecastEntity.sunset,
                          chartHeight: chartHeight,
                          chartWidth: chartWidth,
                          minX: minX,
                          maxX: maxX,
                          minY: minY,
                          maxY: maxY,
                        ),

                        // Icon-Graph
                        ...detailedDayForecastEntity.hourlyForecastEntityList.map((
                          entity,
                        ) {
                          return PositionedWidget(
                            x: CoordinateCalculator.calculateXPositionInChartInPixel(
                              xInChartFormat: entity.time.hour.toDouble(),
                              minX: minX,
                              maxX: maxX,
                              chartWidth: chartWidth,
                            ),
                            y:
                                CoordinateCalculator.calculateYPositionInChartInPixel(
                                  xInChartFormat: entity.temperature,
                                  minY: minY,
                                  maxY: maxY,
                                  chartHeight: chartHeight,
                                ) +
                                30,
                            child: IgnorePointer(
                              child: Icon(
                                Mapper.getIcon(weatherCode: entity.weatherCode),
                              ),
                            ),
                          );
                        }),

                        // X-Achse
                        ...List.generate(
                          (maxX - minX).abs() - 1,
                          (index) => AxisLabel(
                            xInPixelFormat:
                                CoordinateCalculator.calculateXPositionInChartInPixel(
                                  xInChartFormat: (index.toDouble() + minX) + 1,
                                  minX: minX,
                                  maxX: maxX,
                                  chartWidth: chartWidth,
                                ),
                            yInPixelFormat: 10,
                            text: '${index + minX + 1}:',
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            // Y-Achse
            ...List.generate(
              (maxY - minY).abs() - 1,
              (index) => AxisLabel(
                xInPixelFormat: 20,
                yInPixelFormat:
                    CoordinateCalculator.calculateYPositionInChartInPixel(
                      xInChartFormat: index.toDouble() + minY + 1,
                      minY: minY,
                      maxY: maxY,
                      chartHeight: chartHeight,
                    ),
                text: '${index + minY + 1}C°',
              ),
            ),
          ],
        );
      },
    );
  }
}
