import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/infrastructure/core/exceptions.dart';
import 'package:weather/infrastructure/weather/datasources/weather_remote_datasource.dart';
import 'package:weather/infrastructure/weather/models/weather_item_model.dart';

import '../../fixtures/fixture_reader.dart';
import 'weather_remote_datsource_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late WeatherRemoteDatasource weatherRemoteDatasource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    weatherRemoteDatasource = WeatherRemoteDatasourceImpl(client: mockClient);
  });

  void setUpMockClientSuccess200() {
    //arrange
    when(mockClient.get(any, headers: anyNamed("headers"))).thenAnswer(
        (_) async => http.Response(fixture("weather_http_respond.json"), 200));
  }

  void setUpMockClientFailure404() {
    //arrange
    when(mockClient.get(any, headers: anyNamed("headers")))
        .thenAnswer((_) async => http.Response("something went wrong", 404));
  }

  group("getWeatherInfoFromCity", () {
    final tListOfWeatherModels = [
      WeatherItemModel(
        description: "broken clouds",
        iconID: "04d",
        temp: 276.72,
        date:
            DateTime.fromMillisecondsSinceEpoch(1636966800 * 1000, isUtc: true),
      ),
      WeatherItemModel(
        description: "scattered clouds",
        iconID: "03d",
        temp: 278.19,
        date:
            DateTime.fromMillisecondsSinceEpoch(1636977600 * 1000, isUtc: true),
      )
    ];

    test(
        "should perform a get request on a URL with weather being the endpoint and header appliction/json",
        () {
      //arrange
      setUpMockClientSuccess200();

      // act
      weatherRemoteDatasource.getWeatherFromSpecificCity(city: "München", countryCode: "DE");

      //assert
      verify(mockClient.get(
        Uri.parse("https://api.openweathermap.org/data/2.5/forecast?q=München,DE&appid=cb0ebe8d6c8e01bcc32667211d56caf1"),
        headers: {
          'Content-Type': 'application/json',
        },
      ));
    });


    test("should return a valid weather info when the response is a succsess 200",
        () async {
      //arrange
      setUpMockClientSuccess200();

      // act
      final result = await weatherRemoteDatasource.getWeatherFromSpecificCity(city: "München", countryCode: "DE");

      //assert
      expect(result, tListOfWeatherModels);
    });

    

    test("should thrwo ServerException if the response code is not 200", () {
      //arrange
      setUpMockClientFailure404();

      // act
      final call = weatherRemoteDatasource.getWeatherFromSpecificCity;

      //assert
      expect(() => call(city: "München", countryCode: "DE"), throwsA(const TypeMatcher<SeverException>()));
    });
    
  });
}
