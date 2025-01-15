import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Model/weather_model.dart';
import '../api_key.dart';

class WeatherServices {
  fetchWeather(String lat, String long) async {
    final response = await http.get(
      Uri.parse("https://api.weatherapi.com/v1/current.json?key=$weatherApiKey&q=$lat,$long"),
    );

    try {
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return WeatherData.fromJson(json);
      } else {
        throw Exception('Failed to load Weather data');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}