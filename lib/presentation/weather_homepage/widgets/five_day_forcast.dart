import 'package:flutter/material.dart';
import 'package:weather/domain/weather/entities/weather_per_day.dart';
import 'package:weather/presentation/weather_homepage/widgets/current_weather.dart';
import 'package:weather/presentation/weather_homepage/widgets/day_forcast.dart';

class FiveDayForcast extends StatelessWidget {
  final List<WeatherPerDay> weatherPerDays;
  const FiveDayForcast({required this.weatherPerDays, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CurrentWeather(weatherItemEntity: weatherPerDays[0].weatherHourly[0]),
          ...weatherPerDays.map((item){
                return DayForcast(weatherPerDay: item);
          }).toList(),

        ],
      ),
    );
  }
}
