import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:weather/domain/weather/entities/weather_item_entity.dart';

import 'dart:convert';

import 'package:weather/infrastructure/core/exceptions.dart';
import 'package:weather/infrastructure/weather/models/weather_item_model.dart';

// ignore: constant_identifier_names
const String API_KEY = "cb0ebe8d6c8e01bcc32667211d56caf1";

abstract class WeatherRemoteDatasource {
  ///
  /// requests a weather from openweathermap.org by city
  ///
  /// throws a server-Exception if respond code is not 200
  ///
  Future<List<WeatherItemEntity>> getWeatherFromSpecificCity(
      {required String city, required String countryCode});

  ///
  /// requests a weather from openweathermap.org from current
  ///
  /// throws a server-Exception if respond code is not 200
  ///
  Future<List<WeatherItemEntity>> getWeatherFromCurrentLocation(
      {required LocationData locationData});
}

class WeatherRemoteDatasourceImpl implements WeatherRemoteDatasource {
  final http.Client client;

  WeatherRemoteDatasourceImpl({required this.client});

  @override
  Future<List<WeatherItemEntity>> getWeatherFromSpecificCity(
      {required String city, required String countryCode}) async {
    final response = await client.get(
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$city,$countryCode&appid=$API_KEY"),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw SeverException();
    } else {
      final responseBody = json.decode(response.body);
      List weatherItemsJson = responseBody["list"] as List;

      List<WeatherItemModel> weatherItemsModels = [];
      for (var item in weatherItemsJson) {
        weatherItemsModels.add(WeatherItemModel.fromJson(item));
      }
      return weatherItemsModels;
    }
  }

  @override
  Future<List<WeatherItemEntity>> getWeatherFromCurrentLocation(
      {required LocationData locationData}) {
    // TODO: implement getWeatherFromCurrentLocation
    throw UnimplementedError();
  }

/*
  @override
  Future<List<WeatherItemEntity>> getWeatherFromCurrentLocation(
      {required LocationData locationData}) async {
    final response = await client.get(
      Uri.parse(
          "api.openweathermap.org/data/2.5/forecast?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=$API_KEY"),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw SeverException();
    } else {
      final responseBody = json.decode(response.body);
      // return AdviceModel.fromJson(responseBody["slip"]);
  
    }
  }*/
}
