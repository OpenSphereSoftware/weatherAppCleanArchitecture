import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weather/domain/weather/entities/weather_item_entity.dart';

class CurrentWeather extends StatelessWidget {
  final WeatherItemEntity weatherItemEntity;
  const CurrentWeather({required this.weatherItemEntity, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(
              height: 100,
              imageUrl:
                  "https://openweathermap.org/img/wn/${weatherItemEntity.iconID}@2x.png",
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Text(weatherItemEntity.temp.toString()),
            const SizedBox(height: 10,),
            Text(weatherItemEntity.description)
          ],
        ),
      ),
    );
  }
}
