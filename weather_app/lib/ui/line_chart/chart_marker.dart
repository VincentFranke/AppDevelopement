import 'package:flutter/material.dart';
import 'package:weather_app/logic/entities/detailed_day_forecast_entity.dart';
import 'package:weather_app/ui/line_chart/coordinate_calculator.dart';
import 'package:weather_app/ui/reusable/positioned_widget.dart';
import 'package:weather_app/ui/reusable/line_painter.dart';
import 'package:weather_app/ui/reusable/triangle_painter.dart';

class ChartMarker extends StatelessWidget {
  final String text;
  final DetailedDayForecastEntity detailedDayForecastEntity;
  final DateTime targetTime;
  final double chartWidth;
  final double chartHeight;
  final int minX;
  final int maxX;
  final int minY;
  final int maxY;

  late final double xInPixelFormat;
  late final double yInPixelFormatAdjusted;
  late final Offset lineStartPoint;
  late final Offset lineEndPoint;
  ChartMarker({
    super.key,
    required this.text,
    required this.detailedDayForecastEntity,
    required this.targetTime,
    required this.chartHeight,
    required this.chartWidth,
    required this.minX,
    required this.maxX,
    required this.minY,
    required this.maxY,
  }) {
    final double xInChartFormat = targetTime.hour + targetTime.minute / 60;

    xInPixelFormat = CoordinateCalculator.calculateXPositionInChartInPixel(
      xInChartFormat: xInChartFormat,
      minX: minX,
      maxX: maxX,
      chartWidth: chartWidth,
    );

    final double yInPixelFormat =
        CoordinateCalculator.calculateYPositionInChartInPixel(
          xInChartFormat: detailedDayForecastEntity
              .hourlyForecastEntityList[xInChartFormat.round()]
              .temperature,
          minY: minY,
          maxY: maxY,
          chartHeight: chartHeight,
        ) +
        200;

    yInPixelFormatAdjusted = yInPixelFormat > chartHeight * 0.9
        ? chartHeight * 0.9
        : yInPixelFormat;

    lineStartPoint = Offset(xInPixelFormat, yInPixelFormatAdjusted - 30);

    lineEndPoint = Offset(
      xInPixelFormat,
      CoordinateCalculator.calculateYPositionInChartInPixel(
            xInChartFormat:
                (detailedDayForecastEntity.hourlyForecastEntityList
                        .where((e) => e.time.hour == targetTime.hour)
                        .first
                        .temperature +
                    detailedDayForecastEntity.hourlyForecastEntityList
                        .where((e) => e.time.hour == targetTime.hour + 1)
                        .first
                        .temperature) /
                2,
            minY: minY,
            maxY: maxY,
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
