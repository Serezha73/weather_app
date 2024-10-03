import 'package:weather_app/data/repositories/location_repository.dart';
import 'package:weather_app/data/repositories/weather_local_data_source.dart';
import 'package:weather_app/data/repositories/weather_repository.dart';
import 'package:weather_app/domian/usecases/get_location_usecase.dart';
import 'package:weather_app/domian/usecases/get_weather_usecase.dart';
import 'package:weather_app/domian/usecases/load_weather_usecase.dart';
import 'package:weather_app/domian/usecases/save_weather_usecase.dart';

class DependencyInjection {
  static final WeatherLocalDataSource localDataSource =
      WeatherLocalDataSource();
  static final WeatherRepository weatherRepository = WeatherRepository();
  static final LocationRepository locationRepository = LocationRepository();

  static final SaveWeatherUseCase saveWeatherUseCase =
      SaveWeatherUseCase(localDataSource);
  static final LoadWeatherUseCase loadWeatherUseCase =
      LoadWeatherUseCase(localDataSource);
  static final GetLocationUseCase getLocationUseCase =
      GetLocationUseCase(locationRepository);
  static final GetWeatherUseCase getWeatherUseCase =
      GetWeatherUseCase(weatherRepository);
}
