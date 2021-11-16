import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/application/weather/weather_bloc/weather_bloc.dart';

import 'package:weather/injection.dart';
import 'package:weather/presentation/weather_homepage/widgets/weather_homepage_body.dart';

class WeatherHomepage extends StatelessWidget {
  const WeatherHomepage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final weatherbloc = sl<WeatherBloc>()..add(RequestedWeatherDataFromCity());
    return BlocProvider(
      create: (context) =>
          weatherbloc,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("weather"),
        ),
        body: const WeatherHomepageBody(),
      ),
    );
  }
}
