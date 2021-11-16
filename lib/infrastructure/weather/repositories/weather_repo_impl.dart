import 'package:weather/domain/weather/entities/weather_item_entity.dart';
import 'package:weather/domain/core/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:weather/domain/weather/repositories/weather_repo.dart';
import 'package:weather/infrastructure/core/exceptions.dart';
import 'package:weather/infrastructure/weather/datasources/weather_remote_datasource.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDatasource weatherRemoteDatasource;
  WeatherRepositoryImpl({required this.weatherRemoteDatasource});
  @override
  Future<Either<Failure, List<WeatherItemEntity>>> getWeatherFromCity(
      {required String city, required String countryCode}) async {
    try {
      final List<WeatherItemEntity> remoteWeatherData =
          await weatherRemoteDatasource.getWeatherFromSpecificCity(
              city: city, countryCode: countryCode);

      return Right(remoteWeatherData);
    } catch (e) {
      if (e is SeverException) {
        return Left(ServerFailure());
      } else {
        return Left(GeneralFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<WeatherItemEntity>>>
      getWeatherFromCurrentLocation() {
    // TODO: implement getWeatherFromCurrentLocation
    throw UnimplementedError();
  }
}
