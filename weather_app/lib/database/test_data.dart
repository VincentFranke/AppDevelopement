import 'package:weather_app/logic/day_label.dart';
import 'package:weather_app/logic/entities/day_forecast_entity.dart';
import 'package:weather_app/logic/entities/seven_day_forecast_entity.dart';

class TestData {
  static final DayForecastEntity _monday = DayForecastEntity(
    dayLabel: DayLabel.monday,
    temperature: 12,
    weatherCode: 15,
  );
  static final DayForecastEntity _tuesday = DayForecastEntity(
    dayLabel: DayLabel.tuesday,
    temperature: -1,
    weatherCode: 10,
  );
  static final DayForecastEntity _wednesday = DayForecastEntity(
    dayLabel: DayLabel.wednesday,
    temperature: 13,
    weatherCode: 1,
  );
  static final DayForecastEntity _thursday = DayForecastEntity(
    dayLabel: DayLabel.thursday,
    temperature: 15,
    weatherCode: 2,
  );
  static final DayForecastEntity _friday = DayForecastEntity(
    dayLabel: DayLabel.friday,
    temperature: 14,
    weatherCode: 3,
  );
  static final DayForecastEntity _saturday = DayForecastEntity(
    dayLabel: DayLabel.saturday,
    temperature: 18,
    weatherCode: 85,
  );
  static final DayForecastEntity _sunday = DayForecastEntity(
    dayLabel: DayLabel.sunday,
    temperature: 25,
    weatherCode: 86,
  );

  static final List<SevenDayForecastEntity> sevenDayForecastEntityList = [
    SevenDayForecastEntity(
      header: 'Oberursel',
      dayForecastEntityList: [
        _monday,
        _tuesday,
        _wednesday,
        _thursday,
        _friday,
        _saturday,
        _sunday,
      ],
    ),
    SevenDayForecastEntity(
      header: 'Bad Homburg',
      dayForecastEntityList: [
        _monday,
        _tuesday,
        _wednesday,
        _thursday,
        _friday,
        _saturday,
        _sunday,
      ],
    ),
    SevenDayForecastEntity(
      header: 'Schmitten',
      dayForecastEntityList: [
        _monday,
        _tuesday,
        _wednesday,
        _thursday,
        _friday,
        _saturday,
        _sunday,
      ],
    ),
    SevenDayForecastEntity(
      header: 'Assenheim',
      dayForecastEntityList: [
        _monday,
        _tuesday,
        _wednesday,
        _thursday,
        _friday,
        _saturday,
        _sunday,
      ],
    ),
  ];
}
