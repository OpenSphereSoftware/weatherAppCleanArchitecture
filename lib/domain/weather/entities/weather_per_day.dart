

import 'package:weather/domain/weather/entities/weather_item_entity.dart';

class WeatherPerDay {
  final List<WeatherItemEntity> weatherHourly; 

  WeatherPerDay({required this.weatherHourly});
}