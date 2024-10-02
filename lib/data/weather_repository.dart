import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherRepository {
  final String apiKey =
      'a488cb08b230914ddf8d018811bd1f27'; // Замените на ваш API-ключ OpenWeatherMap

  Future<Map<String, dynamic>> fetchWeatherData(String city) async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {
        'temperature': data['main']['temp'],
        'humidity': data['main']['humidity'],
        'windSpeed': data['wind']['speed'],
        'feelsLike': data['main']['feels_like'],
      };
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
