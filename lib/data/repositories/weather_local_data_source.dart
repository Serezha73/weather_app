import 'package:shared_preferences/shared_preferences.dart';

class WeatherLocalDataSource {
  Future<void> saveWeatherData(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('city', data['city']);
    prefs.setDouble('temperature', data['temperature']);
    prefs.setInt('humidity', data['humidity']);
    prefs.setDouble('windSpeed', data['windSpeed']);
    prefs.setDouble('feelsLike', data['feelsLike']);
    prefs.setString('weatherCode', data['icon']);
  }

  Future<Map<String, dynamic>?> loadWeatherData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('city')) {
      return null;
    }
    return {
      'city': prefs.getString('city'),
      'temperature': prefs.getDouble('temperature'),
      'humidity': prefs.getInt('humidity'),
      'windSpeed': prefs.getDouble('windSpeed'),
      'feelsLike': prefs.getDouble('feelsLike'),
      'icon': prefs.getString('weatherCode'),
    };
  }
}
