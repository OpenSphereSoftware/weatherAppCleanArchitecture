import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/application/weather/weather_bloc/weather_bloc.dart';
import 'package:weather/presentation/weather_homepage/widgets/five_day_forcast.dart';

class WeatherHomepageBody extends StatelessWidget {
  const WeatherHomepageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WeatherLoaded) {
          return FiveDayForcast(weatherPerDays: state.weahterPerDays);
        } else if (state is WeatherLoadingFailure) {
          return const Center(
            child: Text("Failure"),
          );
        } else {
          return const Center(
            child: Text("404"),
          );
        }
      },
    );
  }
}
