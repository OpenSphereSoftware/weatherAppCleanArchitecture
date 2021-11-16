import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather/domain/weather/entities/weather_item_entity.dart';
import 'package:weather/infrastructure/weather/models/weather_item_model.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final tWeatherItemModel = WeatherItemModel(
    description: "broken clouds",
    iconID: "04d",
    temp: 276.72,
    date: DateTime.fromMillisecondsSinceEpoch(1636966800 * 1000, isUtc: true),
  );

  test("model should be subclass of weather-entity", () {
    //assert
    expect(tWeatherItemModel, isA<WeatherItemEntity>());
  });

  group("fromJson factory", () {
    test("should return a valid model if the JSON advice is correct", () {
      //arrange

      final Map<String, dynamic> jsonMap =
          json.decode(fixture("weather_item.json"));

      // act

      final result = WeatherItemModel.fromJson(jsonMap);

      //assert
      expect(result, tWeatherItemModel);
    });
  });
}
