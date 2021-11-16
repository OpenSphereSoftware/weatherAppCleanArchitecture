import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:weather/domain/weather/repositories/weather_repo.dart';
import 'package:weather/domain/weather/usecases/weather_usecases.dart';
import 'package:weather/infrastructure/weather/datasources/weather_remote_datasource.dart';
import 'package:weather/infrastructure/weather/repositories/weather_repo_impl.dart';

import 'application/weather/weather_bloc/weather_bloc.dart';

final sl = GetIt.I; // sl == service locator

Future<void> init() async {
  //! datasources
  sl.registerLazySingleton<WeatherRemoteDatasource>(
      () => WeatherRemoteDatasourceImpl(client: sl()));

  //! repos
  sl.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(weatherRemoteDatasource: sl()));

  //! usecases
  sl.registerLazySingleton<WeatherUsecases>(() => WeatherUsecasesImpl(weatherRepository: sl()));

  //! applicaiton layer blocs
  sl.registerFactory(() => WeatherBloc(weatherUsecases: sl()));

  //! external
  sl.registerLazySingleton(() => http.Client());
}
