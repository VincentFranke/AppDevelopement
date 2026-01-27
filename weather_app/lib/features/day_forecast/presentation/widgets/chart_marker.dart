import 'package:flutter/material.dart';
import 'package:weather_app/features/day_forecast/domain/entities/day_forecast.dart';
import 'package:weather_app/core/common/widgets/positioned_widget.dart';
import 'package:weather_app/features/day_forecast/domain/entities/line_chart_bounds.dart';
import 'package:weather_app/features/day_forecast/presentation/dirty_helper/line_chart_coordinate_calculator.dart';
import 'package:weather_app/features/day_forecast/presentation/widgets/line_painter.dart';
import 'package:weather_app/features/day_forecast/presentation/widgets/triangle_painter.dart';

class ChartMarker extends StatelessWidget {
  final String text;
  final DayForecast dayForecastEntity;
  final DateTime targetTime;
  final double chartWidth;
  final double chartHeight;
  final LineChartBounds lineChartBounds;

  late final double xInPixelFormat;
  late final double yInPixelFormatAdjusted;
  late final Offset lineStartPoint;
  late final Offset lineEndPoint;
  ChartMarker({
    super.key,
    required this.text,
    required this.dayForecastEntity,
    required this.targetTime,
    required this.chartHeight,
    required this.chartWidth,
    required this.lineChartBounds,
  }) {
    final double xInChartFormat = targetTime.hour + targetTime.minute / 60;

    xInPixelFormat = LineChartCoordinateCalculator.getLineChartXCoordinate(
      xInChartFormat: xInChartFormat,
      minX: lineChartBounds.minX,
      maxX: lineChartBounds.maxX,
      chartWidth: chartWidth,
    );

    final double yInPixelFormat =
        LineChartCoordinateCalculator.getLineChartYCoordinate(
          yInChartFormat: dayForecastEntity
              .hourlyForecastList[xInChartFormat.round()]
              .temperature,
          minY: lineChartBounds.minY,
          maxY: lineChartBounds.maxY,
          chartHeight: chartHeight,
        ) +
        200;

    yInPixelFormatAdjusted = yInPixelFormat > chartHeight * 0.9
        ? chartHeight * 0.9
        : yInPixelFormat;

    lineStartPoint = Offset(xInPixelFormat, yInPixelFormatAdjusted - 30);

    lineEndPoint = Offset(
      xInPixelFormat,
      LineChartCoordinateCalculator.getLineChartYCoordinate(
            yInChartFormat:
                (dayForecastEntity.hourlyForecastList
                        .where((e) => e.time.hour == targetTime.hour)
                        .first
                        .temperature +
                    dayForecastEntity.hourlyForecastList
                        .where((e) => e.time.hour == targetTime.hour + 1)
                        .first
                        .temperature) /
                2,
            minY: lineChartBounds.minY,
            maxY: lineChartBounds.maxY,
            chartHeight: chartHeight,
          ) +
          7,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PositionedWidget(
          x: xInPixelFormat,
          y: yInPixelFormatAdjusted,
          child: IgnorePointer(
            child: SizedBox(
              width: 50,
              child: FittedBox(fit: BoxFit.scaleDown, child: Text(text)),
            ),
          ),
        ),
        // Linie
        CustomPaint(
          size: Size.infinite,
          painter: LinePainter(
            start: lineStartPoint,
            end: lineEndPoint,
            color: Colors.white,
            strokeWidth: 2,
          ),
        ),
        // Dreieck
        CustomPaint(
          size: Size.infinite,
          painter: TrianglePainter(
            pointA: lineStartPoint,
            pointB: Offset(lineStartPoint.dx + 37, lineStartPoint.dy + 37),
            pointC: Offset(lineStartPoint.dx - 37, lineStartPoint.dy + 37),
            color: Colors.white,
            strokeWidth: 2,
          ),
        ),
      ],
    );
  }
}
