import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/data/models/five_day_forecast.dart';
import 'package:weather_app/data/models/weather_data.dart';

class WeatherRepository {
  final String apiKey = 'a488cb08b230914ddf8d018811bd1f27';

  // Метод для получения текущих данных о погоде
  Future<WeatherData> fetchWeatherData(String city) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 429) {
      throw Exception('Превышен лимит запросов на OpenWeather API');
    }

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return WeatherData.fromJson(data); // Возвращаем объект WeatherData
    } else {
      throw Exception('Ошибка загрузки данных: ${response.statusCode}');
    }
  }

  // Метод для получения прогноза погоды на 5 дней
  Future<List<FiveDayForecast>> fetchFiveDayWeatherData(String city) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/forecast?q=$city&units=metric&appid=$apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 429) {
      throw Exception('Превышен лимит запросов на OpenWeather API');
    }

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List forecasts = data['list'];
      List<FiveDayForecast> weatherData = [];

      // Берем прогноз каждые 24 часа (8 временных меток по 3 часа на день)
      for (int i = 0; i < forecasts.length; i += 8) {
        final forecast = forecasts[i];
        weatherData
            .add(FiveDayForecast.fromJson(forecast)); // Используем модель
      }
      return weatherData;
    } else {
      throw Exception(
          'Ошибка загрузки данных на 5 дней: ${response.statusCode}');
    }
  }
}
