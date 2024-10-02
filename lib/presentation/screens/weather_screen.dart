import 'package:flutter/material.dart';
import 'package:weather_app/presentation/screens/widget_screen.dart';
import 'package:weather_app/resources/resources.dart';
import 'package:weather_app/presentation/theme/colors_app.dart';
import 'package:weather_app/presentation/theme/sizes_app.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
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
                      const Text(
                        'Тут город',
                        style: TextStyle(color: AppColors.whiteText),
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
                  const Text(
                    'Ветренно',
                    style: TextStyle(
                        color: AppColors.whiteText,
                        fontSize: AppSizes.fontExtraLarge),
                  ),
                  AppSizedBoxes.verticalMedium,
                  const Text(
                    '27°C',
                    style: TextStyle(
                        color: AppColors.whiteText,
                        fontSize: AppSizes.fontTitle),
                  ),
                  AppSizedBoxes.verticalLarge,
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            WeatherParameterWidget(
                              iconInfo: AppImages.humidity,
                              label: "Влажность",
                              value: '52%',
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            WeatherParameterWidget(
                              iconInfo: AppImages.wind,
                              label: "Ветер",
                              value: '18 km/h',
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            WeatherParameterWidget(
                              iconInfo: AppImages.feelsLike,
                              label: "Ощущается",
                              value: '22°',
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
            )
          ],
        ),
      ),
    );
  }
}
