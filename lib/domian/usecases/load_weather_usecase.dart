import 'package:weather_app/data/repositories/weather_local_data_source.dart';

class LoadWeatherUseCase {
  final WeatherLocalDataSource localDataSource;

  LoadWeatherUseCase(this.localDataSource);

  Future<Map<String, dynamic>?> loadWeather() {
    return localDataSource.loadWeatherData();
  }
}
