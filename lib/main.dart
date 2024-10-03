import 'package:flutter/material.dart';
import 'package:weather_app/presentation/screens/weather_screen.dart';
import 'package:weather_app/presentation/theme/colors_app.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: const WeatherScreen(),
    );
  }
}
