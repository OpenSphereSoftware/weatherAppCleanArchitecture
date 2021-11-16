

import 'package:dartz/dartz.dart';
import 'package:weather/domain/core/failures.dart';
import 'package:weather/domain/weather/entities/weather_item_entity.dart';

abstract class WeatherRepository {

  Future<Either<Failure, List<WeatherItemEntity>>> getWeatherFromCity({required String city, required String countryCode});

  Future<Either<Failure, List<WeatherItemEntity>>> getWeatherFromCurrentLocation();

}