import 'package:weather_app/data/repositories/weather_repository.dart';

class GetWeatherUseCase {
  final WeatherRepository _weatherRepository;

  GetWeatherUseCase(this._weatherRepository);

  Future<Map<String, dynamic>> getWeather(String city) async {
    final weatherData = await _weatherRepository.fetchWeatherData(city);
    final forecastData = await _weatherRepository.fetchFiveDayWeatherData(city);

    return {
      'weatherData': weatherData,
      'forecastData': forecastData,
    };
  }
}
