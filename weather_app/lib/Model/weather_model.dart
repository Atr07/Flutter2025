class WeatherData {
  final String name;
  final double temperature;
  final int humidity;
  final double wind;
  final String condition;

  WeatherData({
    required this.name,
    required this.temperature,
    required this.humidity,
    required this.wind,
    required this.condition,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      name: json['location']['name'],
      temperature: json['current']['temp_c'],
      humidity: json['current']['humidity'],
      wind: json['current']['wind_kph'],
      condition: (json['current']['condition']['text']),
    );
  }
}
