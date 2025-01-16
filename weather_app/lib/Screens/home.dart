import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

import '../Model/weather_model.dart';
import '../Services/service_calls.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<HomePage> {

  final permissionLocation = Permission.location;
  WeatherData? weatherInfo;
  bool? isLoading;

  void locationPermissionStatus() async {
    // Request location permission
    final status = await permissionLocation.request();
    if (status == PermissionStatus.granted) {
      isLoading = true;
      // Get the current location
      final position = await Geolocator.getCurrentPosition();
      print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
      WeatherServices().fetchWeather('${position.latitude}', '${position.longitude}').then((value) {
        setState(() {
          weatherInfo = value;
          isLoading = false;
        });
      });
    } else {
      // Permission denied
      print('Location permission denied.');
    }
  }

  @override
  Widget build(BuildContext context) {

    bool? mLoading = isLoading;
    WeatherData? mWeatherInfo = weatherInfo;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Home Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Weather App',
            ),
            ElevatedButton(
              onPressed: locationPermissionStatus,
              child: Text('Get Location'),
            ),
            Center(
              child: (mLoading != null && !mLoading && mWeatherInfo !=null)
                  ? WeatherDetail(weather: mWeatherInfo)
                  : const CircularProgressIndicator(color: Colors.white),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}

class WeatherDetail extends StatelessWidget {
  final WeatherData weather;

  const WeatherDetail({
    super.key,
    required this.weather
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // for current address name
        Text(
          weather.name,
          style: const TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        // for current temperature of my location
        Text(
          "${weather.temperature}°C",
          style: const TextStyle(
            fontSize: 40,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
        // for more weather detail
        Container(
          height: 250,
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.wind_power,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 5),
                        weatherInfoCard(
                            title: "Wind", value: "${weather.wind}km/h"),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.water_drop,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 5),
                        weatherInfoCard(
                            title: "Humidity", value: "${weather.humidity}%"),
                      ],
                    ),
                  ],
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column weatherInfoCard({required String title, required String value}) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        )
      ],
    );
  }
}
