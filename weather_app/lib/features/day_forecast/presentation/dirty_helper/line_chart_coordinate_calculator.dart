import 'package:weather_app/features/day_forecast/domain/entities/hourly_forecast.dart';
import 'package:weather_app/features/day_forecast/domain/entities/line_chart_bounds.dart';

class LineChartCoordinateCalculator {
  // Ist eine dirty Helper Klasse
  // Ist nicht Teil der BusinessLogik sondern berechnet nur die Bounds und Koordinaten für die Darstellung des LineCharts
  // Deshalb steht sie in der Presentation-Layer
  static LineChartBounds getLineChartBounds({
    required List<HourlyForecast> hourlyForecastDataList,
    required int extraSpaceBottom,
    required int extraSpaceTop,
  }) {
    return LineChartBounds(
      minY:
          ((hourlyForecastDataList.reduce(
                    (a, b) => a.temperature < b.temperature ? a : b,
                  )).temperature -
                  extraSpaceBottom)
              .round(),
      maxY:
          ((hourlyForecastDataList.reduce(
                    (a, b) => a.temperature > b.temperature ? a : b,
                  )).temperature +
                  extraSpaceTop)
              .round(),
    );
  }

  static double getLineChartXCoordinate({
    required double xInChartFormat,
    required int minX,
    required int maxX,
    required double chartWidth,
  }) {
    return (xInChartFormat - minX).toDouble() /
        ((maxX - minX).toDouble()) *
        chartWidth;
  }

  static double getLineChartYCoordinate({
    required double yInChartFormat,
    required int minY,
    required int maxY,
    required double chartHeight,
  }) {
    return ((yInChartFormat - minY).toDouble()) /
        ((maxY - minY).toDouble()) *
        chartHeight;
  }
}
