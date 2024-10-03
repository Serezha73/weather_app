class FiveDayForecast {
  final String date;
  final double temperature;
  final String icon;
  final double windSpeed;

  FiveDayForecast({
    required this.date,
    required this.temperature,
    required this.icon,
    required this.windSpeed,
  });

  factory FiveDayForecast.fromJson(Map<String, dynamic> json) {
    return FiveDayForecast(
      date: json['dt_txt'],
      temperature: json['main']['temp'],
      icon: json['weather'][0]['icon'],
      windSpeed: json['wind']['speed'],
    );
  }
}
