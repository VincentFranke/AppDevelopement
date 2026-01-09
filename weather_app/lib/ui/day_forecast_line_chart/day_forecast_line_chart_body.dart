import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'package:weather_app/logic/entities/day_forecast_entity.dart';
import 'package:weather_app/logic/mapper.dart';
import 'package:weather_app/ui/day_forecast_line_chart/axis_label.dart';
import 'package:weather_app/ui/day_forecast_line_chart/coordinate_calculator.dart';
import 'package:weather_app/ui/day_forecast_line_chart/chart_marker.dart';
import 'package:weather_app/ui/reusable/positioned_widget.dart';

class DayForecastLineChartBody extends StatelessWidget {
  final DayForecastEntity dayEntity;
  late final int minY;
  late final int maxY;
  final int minX = -1;
  final int maxX = 24;
  DayForecastLineChartBody({super.key, required this.dayEntity}) {
    minY = CoordinateCalculator.calculateMinY(
      hourlyForecastEntityList: dayEntity.hourlyForecastEntityList,
      extraSpace: 1,
    );
    maxY = CoordinateCalculator.calculateMaxY(
      hourlyForecastEntityList: dayEntity.hourlyForecastEntityList,
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
                                spots: dayEntity.hourlyForecastEntityList.map((
                                  e,
                                ) {
                                  return FlSpot(
                                    e.time.hour.toDouble(),
                                    e.temperature,
                                  );
                                }).toList(),
                                belowBarData: BarAreaData(
                                  show: true,
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.red.withValues(alpha: 0.3),
                                      Colors.blue.withValues(alpha: 0.3),
                                    ],
                                    stops: [0, 0.5],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Sunrise
                        ChartMarker(
                          text: AppLocalizations.of(context)!.sunrise,
                          dayForecastEntity: dayEntity,
                          targetTime: dayEntity.sunrise,
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
                          dayForecastEntity: dayEntity,
                          targetTime: dayEntity.sunset,
                          chartHeight: chartHeight,
                          chartWidth: chartWidth,
                          minX: minX,
                          maxX: maxX,
                          minY: minY,
                          maxY: maxY,
                        ),

                        // Icon-Graph
                        ...dayEntity.hourlyForecastEntityList.map((entity) {
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
