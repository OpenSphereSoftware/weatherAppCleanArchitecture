import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weather/domain/weather/entities/weather_item_entity.dart';

class ThreeHourForcast extends StatelessWidget {
  final WeatherItemEntity weatherItem;
  const ThreeHourForcast({required this.weatherItem, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CachedNetworkImage(
            height: 40,
            imageUrl:
                "https://openweathermap.org/img/wn/${weatherItem.iconID}@2x.png",
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Text(weatherItem.temp.toString(), style: TextStyle(fontSize: 14),),
          Text(weatherItem.description, style: TextStyle(fontSize: 10),)
        ],
      ),
    );
  }
}
