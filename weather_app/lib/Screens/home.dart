import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

import '../Services/service_calls.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<HomePage> {

  final permissionLocation = Permission.location;

  void locationPermissionStatus() async {
    // Request location permission
    final status = await permissionLocation.request();
    if (status == PermissionStatus.granted) {
      // Get the current location
      final position = await Geolocator.getCurrentPosition();
      print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
      WeatherServices().fetchWeather('${position.latitude}', '${position.longitude}');
    } else {
      // Permission denied
      print('Location permission denied.');
    }
  }

  @override
  Widget build(BuildContext context) {

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
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}