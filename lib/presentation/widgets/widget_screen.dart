import 'package:flutter/material.dart';
import 'package:weather_app/presentation/theme/colors_app.dart';
import 'package:weather_app/presentation/theme/sizes_app.dart';
import 'package:weather_app/resources/resources.dart';

String getLocalWeatherIcon(String weatherCode) {
  switch (weatherCode) {
    case '01d': // Ясное небо
      return AppImages.clearDay;
    case '01n': // Ясное небо ночь
      return AppImages.clearNight;
    case '02d': // Немного облаков
      return AppImages.littleCloudDay;
    case '02n':
      return AppImages.littleCloudNight;
    case '03d': // Рассеянные облака день
      return AppImages.cloudsDayNight;
    case '03n': // Рассеянные облака ночь
      return AppImages.cloudsDayNight;
    case '04d': // Облачность день
      return AppImages.cloudsDayNight;
    case '04n': // Облачность ночь
      return AppImages.cloudsDayNight;
    case '09d': // Мелкий дождь день
      return AppImages.rain;
    case '09n': // Мелкий дождь ночью
      return AppImages.rainNight;
    case '10d': // Дождь днем
      return AppImages.rain;
    case '10n': // Дождь ночью
      return AppImages.rainNight;
    case '11d': // Гроза
      return AppImages.thunderstorm;
    case '11n': // Гроза ночью
      return AppImages.thunderstorm;
    case '13d': // Снег
      return AppImages.snow;
    case '13n': // Снег ночь
      return AppImages.snowNight;
    default:
      return AppImages.moonCloud; // Если нет соответствия, то дефолтная иконка
  }
}

class WeatherParameterWidget extends StatelessWidget {
  final String iconInfo;
  final String label;
  final String value;

  const WeatherParameterWidget({
    super.key,
    required this.iconInfo,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          iconInfo,
          width: AppIconSizes.large,
          height: AppIconSizes.large,
        ),
        AppSizedBoxes.verticalMini,
        Text(
          label,
          style: const TextStyle(
            color: AppColors.whiteText,
            fontSize: AppSizes.fontSmall,
          ),
        ),
        AppSizedBoxes.verticalMini,
        Text(
          value,
          style: const TextStyle(
            color: AppColors.whiteText,
            fontSize: AppSizes.fontSmall,
          ),
        ),
      ],
    );
  }
}

class WeatherDayWidget extends StatelessWidget {
  final String day;
  final String temperature;
  final String weatherCode;
  final String windSpeed;

  const WeatherDayWidget({
    Key? key,
    required this.day,
    required this.temperature,
    required this.weatherCode,
    required this.windSpeed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: const TextStyle(
              color: AppColors.whiteText,
              fontSize: AppSizes.fontMedium,
              fontWeight: FontWeight.bold,
            ),
          ),
          AppSizedBoxes.verticalMini,
          Image.asset(
            getLocalWeatherIcon(weatherCode),
            width: 40,
            height: 40,
          ),
          AppSizedBoxes.verticalMini,
          Text(
            temperature,
            style: const TextStyle(
              color: AppColors.whiteText,
              fontSize: AppSizes.fontExtraLarge,
              fontWeight: FontWeight.w500,
            ),
          ),
          AppSizedBoxes.verticalMini,
          Text(
            windSpeed,
            style: const TextStyle(
              color: AppColors.whiteText,
              fontSize: AppSizes.fontMedium,
            ),
          ),
        ],
      ),
    );
  }
}
