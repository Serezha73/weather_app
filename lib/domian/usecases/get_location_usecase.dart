import 'package:weather_app/data/repositories/location_repository.dart';

class GetLocationUseCase {
  final LocationRepository _locationRepository;

  GetLocationUseCase(this._locationRepository);

  Future<String> getLocation() async {
    final position = await _locationRepository.getCurrentPosition();
    final city = await _locationRepository.getCityFromPosition(position);
    return city;
  }
}
