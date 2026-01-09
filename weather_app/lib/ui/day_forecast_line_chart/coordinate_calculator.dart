import 'package:weather_app/logic/entities/hourly_forecast_entity.dart';

class CoordinateCalculator {
  static int calculateMinY({
    required List<HourlyForecastEntity> hourlyForecastEntityList,
    required int extraSpace,
  }) {
    return ((hourlyForecastEntityList.reduce(
              (a, b) => a.temperature < b.temperature ? a : b,
            )).temperature -
            extraSpace)
        .round();
  }

  static int calculateMaxY({
    required List<HourlyForecastEntity> hourlyForecastEntityList,
    required extraSpace,
  }) {
    return ((hourlyForecastEntityList.reduce(
              (a, b) => a.temperature > b.temperature ? a : b,
            )).temperature +
            extraSpace)
        .round();
  }

  static double calculateXPositionInChartInPixel({
    required double xInChartFormat,
    required int minX,
    required int maxX,
    required double chartWidth,
  }) {
    return ((xInChartFormat - minX).toDouble()) /
        ((maxX - minX).toDouble()) *
        chartWidth;
  }

  static double calculateYPositionInChartInPixel({
    required double xInChartFormat,
    required int minY,
    required int maxY,
    required double chartHeight,
  }) {
    return ((xInChartFormat - minY).toDouble()) /
        ((maxY - minY).toDouble()) *
        chartHeight;
  }
}
