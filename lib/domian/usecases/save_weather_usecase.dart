import 'package:weather_app/data/repositories/weather_local_data_source.dart';

class SaveWeatherUseCase {
  final WeatherLocalDataSource localDataSource;

  SaveWeatherUseCase(this.localDataSource);

  Future<void> saveWeather(Map<String, dynamic> data) {
    return localDataSource.saveWeatherData(data);
  }
}
