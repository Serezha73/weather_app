import 'package:flutter/material.dart';
import 'package:weather_app/presentation/theme/colors_app.dart';
import 'package:weather_app/presentation/theme/sizes_app.dart';

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
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.whiteText,
            fontSize: AppSizes.fontSmall,
          ),
        ),
        const SizedBox(height: 4),
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
  final String iconPath;
  final String windSpeed;

  const WeatherDayWidget({
    Key? key,
    required this.day,
    required this.temperature,
    required this.iconPath,
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
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Image.asset(
            iconPath,
            width: 40,
            height: 40,
          ),
          const SizedBox(height: 5),
          Text(
            temperature,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            windSpeed,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
