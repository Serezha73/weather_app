import 'package:flutter/material.dart';
import 'package:weather_app/data/repositories/weather_local_data_source.dart';

import 'package:weather_app/domian/usecases/load_weather_usecase.dart';
import 'package:weather_app/domian/usecases/save_weather_usecase.dart';
import 'package:weather_app/presentation/screens/weather_screen.dart';
import 'package:weather_app/presentation/theme/colors_app.dart';

void main() {
  // Инициализация зависимостей
  final WeatherLocalDataSource localDataSource = WeatherLocalDataSource();
  final SaveWeatherUseCase saveWeatherUseCase =
      SaveWeatherUseCase(localDataSource);
  final LoadWeatherUseCase loadWeatherUseCase =
      LoadWeatherUseCase(localDataSource);

  runApp(MyApp(
    saveWeatherUseCase: saveWeatherUseCase,
    loadWeatherUseCase: loadWeatherUseCase,
  ));
}

class MyApp extends StatelessWidget {
  final SaveWeatherUseCase saveWeatherUseCase;
  final LoadWeatherUseCase loadWeatherUseCase;

  const MyApp({
    Key? key,
    required this.saveWeatherUseCase,
    required this.loadWeatherUseCase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: WeatherScreen(
        saveWeatherUseCase: saveWeatherUseCase,
        loadWeatherUseCase: loadWeatherUseCase,
      ),
    );
  }
}
