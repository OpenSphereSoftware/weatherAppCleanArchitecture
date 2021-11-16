part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final List<WeatherPerDay> weahterPerDays;
  WeatherLoaded({required this.weahterPerDays});
}

class WeatherLoadingFailure extends WeatherState {
  final Failure failure;

  WeatherLoadingFailure({required this.failure});
}
