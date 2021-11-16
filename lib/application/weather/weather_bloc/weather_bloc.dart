import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather/domain/core/failures.dart';
import 'package:weather/domain/weather/entities/weather_per_day.dart';
import 'package:weather/domain/weather/usecases/weather_usecases.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherUsecases weatherUsecases;
  WeatherBloc({required this.weatherUsecases}) : super(WeatherLoading()) {
    on<RequestedWeatherDataFromCity>((event, emit) async {
      emit(WeatherLoading());

      final failureOrWeatherPerDay = await weatherUsecases
          .getWeatherFromCityPerDay(city: "München", countryCode: "DE");

      failureOrWeatherPerDay.fold(
          (failure) => emit(WeatherLoadingFailure(failure: failure)),
          (weatherPerDays) =>
              emit(WeatherLoaded(weahterPerDays: weatherPerDays)));
    });
  }
}
