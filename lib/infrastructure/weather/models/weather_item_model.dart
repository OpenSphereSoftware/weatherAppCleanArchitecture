import 'package:equatable/equatable.dart';
import 'package:weather/domain/weather/entities/weather_item_entity.dart';

class WeatherItemModel extends WeatherItemEntity with EquatableMixin{
  WeatherItemModel(
      {required DateTime date,
      required String description,
      required String iconID,
      required double temp})
      : super(date: date, description: description, iconID: iconID, temp: temp);

  factory WeatherItemModel.fromJson(Map<String, dynamic> json) {

   
    return WeatherItemModel(
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: true),
      description: json['weather'][0]['description'] as String,
      iconID: json['weather'][0]['icon'] as String,
      temp: json['main']["temp"] as double,
    );
  }

  @override

  List<Object?> get props => [date, description, iconID, temp];


}
