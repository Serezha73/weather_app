import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather_app/data/repositories/location_repository.dart';
import 'package:weather_app/data/models/five_day_forecast.dart';
import 'package:weather_app/data/repositories/weather_repository.dart';
import 'package:weather_app/domian/usecases/load_weather_usecase.dart';
import 'package:weather_app/domian/usecases/save_weather_usecase.dart';
import 'package:weather_app/presentation/widgets/widget_screen.dart';
import 'package:weather_app/resources/resources.dart';
import 'package:weather_app/presentation/theme/colors_app.dart';
import 'package:weather_app/presentation/theme/sizes_app.dart';

class WeatherScreen extends StatefulWidget {
  final SaveWeatherUseCase saveWeatherUseCase;
  final LoadWeatherUseCase loadWeatherUseCase;

  const WeatherScreen({
    super.key,
    required this.saveWeatherUseCase,
    required this.loadWeatherUseCase,
  });

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
  String _weatherCode = "";
  List<FiveDayForecast> _fiveDayForecast = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    _initializeDateFormattingAndLoadWeather();
  }

  Future<void> _initializeDateFormattingAndLoadWeather() async {
    await initializeDateFormatting('ru', null);
    await _loadLocationAndWeather();
  }

  // загрузка данных через UseCase
  Future<void> _loadPreferences() async {
    final data = await widget.loadWeatherUseCase.loadWeather();
    if (data != null) {
      setState(() {
        _city = data['city'] ?? "Загрузка...";
        _temperature = data['temperature'] ?? 0.0;
        _humidity = data['humidity'] ?? 0;
        _windSpeed = data['windSpeed'] ?? 0.0;
        _feelsLike = data['feelsLike'] ?? 0.0;
        _weatherCode = data['icon'] ?? "";
      });
    }
  }

  Future<void> _savePreferences() async {
    final data = {
      'city': _city,
      'temperature': _temperature,
      'humidity': _humidity,
      'windSpeed': _windSpeed,
      'feelsLike': _feelsLike,
      'icon': _weatherCode,
    };
    await widget.saveWeatherUseCase.saveWeather(data);
  }

  Future<void> _loadLocationAndWeather() async {
    try {
      final position = await _locationRepository.getCurrentPosition();
      final city = await _locationRepository.getCityFromPosition(position);
      final weatherData = await _weatherRepository.fetchWeatherData(city);
      final forecastData =
          await _weatherRepository.fetchFiveDayWeatherData(city);

      setState(() {
        _city = city;
        _temperature = weatherData.temperature;
        _humidity = weatherData.humidity;
        _windSpeed = weatherData.windSpeed;
        _feelsLike = weatherData.feelsLike;
        _weatherCode = weatherData.icon;
        _fiveDayForecast = forecastData;
        _isLoading = false;
      });

      // Сохранение данных после получения
      await _savePreferences();
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.colorIndicator,
                ),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 20),
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
                              style:
                                  const TextStyle(color: AppColors.colorCity),
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
                        Text(
                          'Сегодня, ${DateFormat('d MMMM', 'ru').format(DateTime.now())}',
                          style: const TextStyle(
                              color: AppColors.whiteText,
                              fontSize: AppSizes.fontExtraLarge),
                        ),
                        AppSizedBoxes.verticalLarge,
                        Image.asset(
                          getLocalWeatherIcon(_weatherCode),
                          width: AppIconSizes.moonIconWidth,
                          height: AppIconSizes.moonIconHeight,
                        ),
                        AppSizedBoxes.verticalMedium,
                        Text(
                          '${_temperature.toInt()}°C',
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
                                ],
                              ),
                              Column(
                                children: [
                                  WeatherParameterWidget(
                                    iconInfo: AppImages.wind,
                                    label: "Ветер",
                                    value: '${_windSpeed.toInt()} km/h',
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  WeatherParameterWidget(
                                    iconInfo: AppImages.feelsLike,
                                    label: "Ощущается",
                                    value: '${_feelsLike.toInt()}°C',
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
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      height: 180,
                      decoration: BoxDecoration(
                        color: AppColors.greyText,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: _buildFiveDayForecast(),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildFiveDayForecast() {
    if (_fiveDayForecast.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _fiveDayForecast.length,
      itemBuilder: (context, index) {
        final forecast = _fiveDayForecast[index];
        return WeatherDayWidget(
          day: forecast.date.split(' ')[0],
          temperature: '${forecast.temperature.toInt()}°C',
          weatherCode: forecast.icon,
          windSpeed: '${forecast.windSpeed.toInt()} km/h',
        );
      },
    );
  }
}
