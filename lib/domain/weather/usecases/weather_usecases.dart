import 'package:dartz/dartz.dart';
import 'package:weather/domain/core/failures.dart';
import 'package:weather/domain/weather/entities/weather_item_entity.dart';
import 'package:weather/domain/weather/entities/weather_per_day.dart';
import 'package:weather/domain/weather/repositories/weather_repo.dart';

abstract class WeatherUsecases {
  Future<Either<Failure, List<WeatherPerDay>>> getWeatherFromCityPerDay(
      {required String city, required String countryCode});

  Future<Either<Failure, List<WeatherPerDay>>>
      getWeatherFromCurrentLocationPerDay();
}

class WeatherUsecasesImpl implements WeatherUsecases {
  final WeatherRepository weatherRepository;

  WeatherUsecasesImpl({required this.weatherRepository});
  @override
  Future<Either<Failure, List<WeatherPerDay>>> getWeatherFromCityPerDay(
      {required String city, required String countryCode}) async {
    final failureOrWeatherItems = await weatherRepository.getWeatherFromCity(
        city: city, countryCode: countryCode);

    return failureOrWeatherItems.fold((failure) {
      return Left(failure);
    }, (weatherItems) {
      return Right(splitWeatherItemsInDays(weatherItems));
    });
  }

  @override
  Future<Either<Failure, List<WeatherPerDay>>>
      getWeatherFromCurrentLocationPerDay() {
    // TODO: implement getWeatherFromCurrentLocationPerDay
    throw UnimplementedError();
  }

  /// we have all weather information for the next 5 days in 3 hour steps
  /// this function should split the list per day
  /// every day gets a list of 3 hour steps
  List<WeatherPerDay> splitWeatherItemsInDays(
      List<WeatherItemEntity> weatherItems) {
    List<WeatherPerDay> weatherPerDays = [];
    // could for sure be implemented way better ..
    for (int i = 0; i < 5; i++) {
      final WeatherPerDay singleDay = WeatherPerDay(weatherHourly: []);
      final day = DateTime.now().add(Duration(days: i));
      for (WeatherItemEntity item in weatherItems) {
        if (item.date.day == day.day) {
          singleDay.weatherHourly.add(item);
        }
      }
      weatherPerDays.add(singleDay);
    }

    return weatherPerDays;
  }
}
