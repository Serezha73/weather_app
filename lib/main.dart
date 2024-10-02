import 'dart:convert';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String apiKey =
      'a488cb08b230914ddf8d018811bd1f27'; // Вставьте свой ключ OpenWeatherMap
  String city = '';
  late Map<String, dynamic> weatherData;

  @override
  void initState() {
    super.initState();
    _getCurrentLocationAndWeather();
  }

  Future<void> _getCurrentLocationAndWeather() async {
    try {
      Position position = await _determinePosition();
      await _fetchWeatherByCoordinates(position.latitude, position.longitude);
    } catch (e) {
      print('Ошибка: $e');
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Проверяем, включен ли GPS
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Служба определения местоположения отключена.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Доступ к местоположению запрещён.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Доступ к местоположению навсегда запрещён.');
    }

    return await Geolocator.getCurrentPosition(
        // ignore: deprecated_member_use
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> _fetchWeatherByCoordinates(double lat, double lon) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=$apiKey&lang=ru';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        weatherData = jsonDecode(response.body);
        city = weatherData['name'];
      });
    } else {
      print('Ошибка загрузки данных о погоде');
    }
  }

  Future<void> _fetchWeatherByCity(String cityName) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=$apiKey&lang=ru';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        weatherData = jsonDecode(response.body);
        city = weatherData['name'];
      });
    } else {
      print('Ошибка загрузки данных о погоде');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Прогноз погоды'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (weatherData != null)
              Column(
                children: [
                  Text(
                    'Погода в городе $city',
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    '${weatherData['main']['temp']}°C',
                    style: TextStyle(fontSize: 48),
                  ),
                  Text(
                    weatherData['weather'][0]['description'],
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: 'Введите название города',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                _fetchWeatherByCity(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
