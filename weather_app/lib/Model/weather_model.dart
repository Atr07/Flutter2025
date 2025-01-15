class WeatherData {
  final String name;
  final Temperature temperature;

  final int humidity;
  final Wind wind;
  final double maxTemperature;
  final double minTemperature;
  final int pressure;
  final int seaLevel;
  final List<WeatherInfo> weather;

  WeatherData({
    required this.name,
    required this.temperature,
    required this.humidity,
    required this.wind,
    required this.maxTemperature,
    required this.minTemperature,
    required this.pressure,
    required this.seaLevel,
    required this.weather,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      name: json['name'],
      temperature: Temperature.fromJson(json['main']['temp']),
      humidity: json['main']['humidity'],
      wind: Wind.fromJson(json['wind']),
      maxTemperature: (json['main']['temp_max'] - 273.15), // Kelvin to Celsius
      minTemperature: (json['main']['temp_min'] - 273.15), // Kelvin to Celsius
      pressure: json['main']['pressure'],
      seaLevel: json['main']['sea_level'] ?? 0,
      weather: List<WeatherInfo>.from(
        json['weather'].map(
              (weather) => WeatherInfo.fromJson(weather),
        ),
      ),
    );
  }
}

class WeatherInfo {
  final String main;

  WeatherInfo({
    required this.main,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      main: json['main'],
    );
  }
}

class Temperature {
  final double current;

  Temperature({required this.current});

  factory Temperature.fromJson(dynamic json) {
    return Temperature(
      current: (json - 273.15), // Kelvin to Celsius
    );
  }
}

class Wind {
  final double speed;

  Wind({required this.speed});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(speed: json['speed']);
  }
}

//Sample Response

/*
{
"location": {
"name": "Kismet",
"region": "New York",
"country": "United States of America",
"lat": 40.6342,
"lon": -73.2039,
"tz_id": "America/New_York",
"localtime_epoch": 1736965249,
"localtime": "2025-01-15 13:20"
},
"current": {
"last_updated_epoch": 1736964900,
"last_updated": "2025-01-15 13:15",
"temp_c": 0.4,
"temp_f": 32.7,
"is_day": 1,
"condition": {
"text": "Partly cloudy",
"icon": "//cdn.weatherapi.com/weather/64x64/day/116.png",
"code": 1003
},
"wind_mph": 17.4,
"wind_kph": 28.1,
"wind_degree": 309,
"wind_dir": "NW",
"pressure_mb": 1019.0,
"pressure_in": 30.1,
"precip_mm": 0.0,
"precip_in": 0.0,
"humidity": 36,
"cloud": 25,
"feelslike_c": -5.8,
"feelslike_f": 21.7,
"windchill_c": -5.7,
"windchill_f": 21.7,
"heatindex_c": 0.3,
"heatindex_f": 32.6,
"dewpoint_c": -7.6,
"dewpoint_f": 18.3,
"vis_km": 16.0,
"vis_miles": 9.0,
"uv": 1.4,
"gust_mph": 20.1,
"gust_kph": 32.3
}
}*/
