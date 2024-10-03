class WeatherData {
  final double temperature;
  final int humidity;
  final double windSpeed;
  final double feelsLike;

  WeatherData({
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.feelsLike,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      temperature: json['main']['temp'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
      feelsLike: json['main']['feels_like'],
    );
  }
}
