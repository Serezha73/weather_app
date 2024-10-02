import 'package:flutter/material.dart';
import 'package:weather_app/data/location_repository.dart';
import 'package:weather_app/data/weather_repository.dart';
import 'package:weather_app/resources/resources.dart';
import 'package:weather_app/presentation/theme/colors_app.dart';
import 'package:weather_app/presentation/theme/sizes_app.dart';

import 'widget_screen.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final LocationRepository _locationRepository = LocationRepository();
  final WeatherRepository _weatherRepository = WeatherRepository();

  String _city = "Загрузка...";
  double _temperature = 0.0;
  int _humidity = 0;
  double _windSpeed = 0.0;
  double _feelsLike = 0.0;

  @override
  void initState() {
    super.initState();
    _loadLocationAndWeather();
  }

  Future<void> _loadLocationAndWeather() async {
    try {
      // Получение позиции
      final position = await _locationRepository.getCurrentPosition();

      // Получение названия города
      final city = await _locationRepository.getCityFromPosition(position);

      // Получение данных о погоде для этого города
      final weatherData = await _weatherRepository.fetchWeatherData(city);

      // Обновление состояния
      setState(() {
        _city = city;
        _temperature = weatherData['temperature'];
        _humidity = weatherData['humidity'];
        _windSpeed = weatherData['windSpeed'];
        _feelsLike = weatherData['feelsLike'];
      });
    } catch (e) {
      print(e); // Логирование ошибок
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        AppImages.geolocation,
                        color: AppColors.iconColor,
                        width: AppIconSizes.large,
                        height: AppIconSizes.large,
                      ),
                      AppSizedBoxes.horizontalSmall,
                      Text(
                        _city,
                        style: const TextStyle(color: AppColors.whiteText),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      AppImages.search,
                      width: AppIconSizes.large,
                      height: AppIconSizes.large,
                    ),
                  ),
                ],
              ),
            ),
            AppSizedBoxes.verticalSmall,
            Expanded(
              child: Column(
                children: [
                  const Text(
                    'Сегодня, 2 октября',
                    style: TextStyle(
                        color: AppColors.whiteText,
                        fontSize: AppSizes.fontExtraLarge),
                  ),
                  AppSizedBoxes.verticalSmall,
                  const Text(
                    'Время последнего обновления',
                    style: TextStyle(
                        color: AppColors.whiteText,
                        fontSize: AppSizes.fontSmall),
                  ),
                  AppSizedBoxes.verticalLarge,
                  Image.asset(
                    AppImages.moonCloud,
                    width: AppIconSizes.moonIconWidth,
                    height: AppIconSizes.moonIconHeight,
                  ),
                  AppSizedBoxes.verticalMedium,
                  Text(
                    '$_temperature°C', // Вывод температуры
                    style: const TextStyle(
                        color: AppColors.whiteText,
                        fontSize: AppSizes.fontTitle),
                  ),
                  AppSizedBoxes.verticalLarge,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            WeatherParameterWidget(
                              iconInfo: AppImages.humidity,
                              label: "Влажность",
                              value: '$_humidity%',
                            ),
                            // Вывод влажности
                          ],
                        ),
                        Column(
                          children: [
                            WeatherParameterWidget(
                              iconInfo: AppImages.wind,
                              label: "Ветер",
                              value: '$_windSpeed km/h',
                            ),
                            // Вывод скорости ветра
                          ],
                        ),
                        Column(
                          children: [
                            WeatherParameterWidget(
                              iconInfo: AppImages.feelsLike,
                              label: "Ощущается",
                              value: '$_feelsLike°C',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                  color: AppColors.greyText,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    WeatherDayWidget(
                      day: 'Дата',
                      temperature: '22°',
                      iconPath: AppImages.iconCloud,
                      windSpeed: '1-5 km/h',
                    ),
                    WeatherDayWidget(
                      day: 'Дата',
                      temperature: '22°',
                      iconPath: AppImages.iconCloud,
                      windSpeed: '1-5 km/h',
                    ),
                    WeatherDayWidget(
                      day: 'Дата',
                      temperature: '22°',
                      iconPath: AppImages.iconCloud,
                      windSpeed: '1-5 km/h',
                    ),
                    WeatherDayWidget(
                      day: 'Дата',
                      temperature: '22°',
                      iconPath: AppImages.iconCloud,
                      windSpeed: '1-5 km/h',
                    ),
                    WeatherDayWidget(
                      day: 'Дата',
                      temperature: '22°',
                      iconPath: AppImages.iconCloud,
                      windSpeed: '1-5 km/h',
                    ),
                    WeatherDayWidget(
                      day: 'Дата',
                      temperature: '22°',
                      iconPath: AppImages.iconCloud,
                      windSpeed: '1-5 km/h',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
