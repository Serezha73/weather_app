import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationRepository {
  // Получение текущей геопозиции пользователя
  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Проверка на доступность сервисов геолокации
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Сервисы геолокации отключены');
    }

    // Проверка и запрос разрешений
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Разрешение на доступ к местоположению отклонено');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Разрешение на доступ к местоположению заблокировано');
    }

    // Получение позиции
    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );
  }

  // Преобразование координат в адрес
  Future<String> getCityFromPosition(Position position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        return placemarks.first.locality ?? "Неизвестный город";
      } else {
        throw Exception('Не удалось определить город');
      }
    } catch (e) {
      throw Exception('Ошибка при получении города: $e');
    }
  }
}
