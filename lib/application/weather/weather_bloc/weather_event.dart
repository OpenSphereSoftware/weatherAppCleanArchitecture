part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class RequestedWeatherDataFromCity extends WeatherEvent {}

class RequestedWeatherDataFromCurrentLocation extends WeatherEvent {}
