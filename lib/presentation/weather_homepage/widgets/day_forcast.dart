import 'package:flutter/material.dart';
import 'package:weather/domain/weather/entities/weather_per_day.dart';
import 'package:weather/presentation/weather_homepage/widgets/three_hour_forcast.dart';

const Map<int, String> weekdays = {
  1: "Montag",
  2: "Dienstag",
  3: "Mittwoch",
  4: "Donnerstag",
  5: "Freitag",
  6: "Samstag",
  7: "Sonntag"
};

class DayForcast extends StatelessWidget {
  final WeatherPerDay weatherPerDay;
  const DayForcast({required this.weatherPerDay, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              Text(weekdays[weatherPerDay.weatherHourly[0].date.weekday].toString()),
            ],
          ),
          
          SizedBox(
            height: 85,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: weatherPerDay.weatherHourly.length,
                itemBuilder: (context, index) {
                  return ThreeHourForcast(
                    weatherItem: weatherPerDay.weatherHourly[index],
                  );
                }),
          ),
         const  Divider(),
        ],
      ),
    );
  }
}
