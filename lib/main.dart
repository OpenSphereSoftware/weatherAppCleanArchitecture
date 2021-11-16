import 'package:flutter/material.dart';
import 'package:weather/presentation/weather_homepage/weather_homepage.dart';
import 'package:weather/theme.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'weather app',
      theme: AppTheme.lightTheme,
      darkTheme:  AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: const WeatherHomepage(),
    );
  }
}


