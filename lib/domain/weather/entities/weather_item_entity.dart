class WeatherItemEntity {
  final DateTime date;
  final String description;
  final double temp;
  final String iconID;

  WeatherItemEntity(
      {required this.date,
      required this.description,
      required this.temp,
      required this.iconID});
}
