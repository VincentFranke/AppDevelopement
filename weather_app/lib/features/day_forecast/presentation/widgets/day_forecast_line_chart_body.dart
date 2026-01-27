import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/features/day_forecast/data/datasources/international_date_remote_datasource.dart';
import 'package:weather_app/core/l10n/app_localizations.dart';
import 'package:weather_app/features/day_forecast/domain/entities/day_forecast.dart';
import 'package:weather_app/core/utils/mapper.dart';
import 'package:weather_app/features/day_forecast/domain/entities/line_chart_bounds.dart';
import 'package:weather_app/features/day_forecast/presentation/dirty_helper/line_chart_coordinate_calculator.dart';
import 'package:weather_app/features/day_forecast/presentation/widgets/axis_label.dart';
import 'package:weather_app/features/day_forecast/presentation/widgets/chart_marker.dart';
import 'package:weather_app/core/common/widgets/positioned_widget.dart';

class DayForecastLineChartBody extends StatelessWidget {
  final DayForecast dayEntity;
  late final LineChartBounds lineChartBounds;
  DayForecastLineChartBody({super.key, required this.dayEntity}) {
    lineChartBounds = LineChartCoordinateCalculator.getLineChartBounds(
      hourlyForecastDataList: dayEntity.hourlyForecastList,
      extraSpaceBottom: 1,
      extraSpaceTop: 4,
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
                    DateTime localDateTime =
                        InternationalDateTimeRemoteDatasource()
                            .getInternationalDateTimeNow(
                              timeZone: dayEntity.timeZone,
                            );
                    // Stack im Scrollview
                    return Stack(
                      children: [
                        LineChart(
                          LineChartData(
                            minY: lineChartBounds.minY.toDouble(),
                            maxY: lineChartBounds.maxY.toDouble(),
                            minX: lineChartBounds.minX.toDouble(),
                            maxX: lineChartBounds.maxX.toDouble(),
                            borderData: FlBorderData(show: false),
                            gridData: FlGridData(show: true),
                            titlesData: FlTitlesData(show: false),
                            // Current Time
                            extraLinesData: ExtraLinesData(
                              extraLinesOnTop: false,
                              verticalLines: [
                                VerticalLine(
                                  x:
                                      localDateTime.hour +
                                      localDateTime.minute / 60,
                                  color: Colors.red,
                                  dashArray: [20, 7],
                                ),
                              ],
                            ),
                            lineBarsData: [
                              // Temperaturgraph
                              LineChartBarData(
                                isCurved: true,
                                barWidth: 10,
                                color: Colors.red,
                                spots: dayEntity.hourlyForecastList.map((e) {
                                  return FlSpot(
                                    e.time.hour.toDouble(),
                                    e.temperature,
                                  );
                                }).toList(),
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
                          dayForecastEntity: dayEntity,
                          targetTime: dayEntity.sunrise,
                          chartHeight: chartHeight,
                          chartWidth: chartWidth,
                          lineChartBounds: lineChartBounds,
                        ),

                        // Sunset
                        ChartMarker(
                          text: AppLocalizations.of(context)!.sunset,
                          dayForecastEntity: dayEntity,
                          targetTime: dayEntity.sunset,
                          chartHeight: chartHeight,
                          chartWidth: chartWidth,
                          lineChartBounds: lineChartBounds,
                        ),

                        // Icon-Graph
                        ...dayEntity.hourlyForecastList.map((entity) {
                          return PositionedWidget(
                            x: LineChartCoordinateCalculator.getLineChartXCoordinate(
                              xInChartFormat: entity.time.hour.toDouble(),
                              minX: lineChartBounds.minX,
                              maxX: lineChartBounds.maxX,
                              chartWidth: chartWidth,
                            ),
                            y:
                                LineChartCoordinateCalculator.getLineChartYCoordinate(
                                  yInChartFormat: entity.temperature,
                                  minY: lineChartBounds.minY,
                                  maxY: lineChartBounds.maxY,
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
                          (lineChartBounds.maxX - lineChartBounds.minX).abs() -
                              1,
                          (index) => AxisLabel(
                            xInPixelFormat:
                                LineChartCoordinateCalculator.getLineChartXCoordinate(
                                  xInChartFormat:
                                      (index.toDouble() +
                                          lineChartBounds.minX) +
                                      1,
                                  minX: lineChartBounds.minX,
                                  maxX: lineChartBounds.maxX,
                                  chartWidth: chartWidth,
                                ),
                            yInPixelFormat: 10,
                            text: '${index + lineChartBounds.minX + 1}:',
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
              (lineChartBounds.maxY - lineChartBounds.minY).abs() - 1,
              (index) => AxisLabel(
                xInPixelFormat: 20,
                yInPixelFormat:
                    LineChartCoordinateCalculator.getLineChartYCoordinate(
                      yInChartFormat:
                          index.toDouble() + lineChartBounds.minY + 1,
                      minY: lineChartBounds.minY,
                      maxY: lineChartBounds.maxY,
                      chartHeight: chartHeight,
                    ),
                text: '${index + lineChartBounds.minY + 1}C°',
              ),
            ),
          ],
        );
      },
    );
  }
}
