import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/Models/weather_models.dart';
import 'package:weather_app/Services/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // Api key for openweathermap
  final apiKey = "283ba4214baed55e8483c62db1439887";
  final _weatherService = WeatherServices("283ba4214baed55e8483c62db1439887");
  Weather? _Weather;

  // fetch the weather
  _fetchWeather() async {
    final cityName = await _weatherService.getCurrentCity();

    // get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _Weather = weather;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // Weather Animation

  // fetch the weather on page load
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  // build the UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Application'),
      ),
      body: Center(
        child: _Weather == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _Weather!.cityName,
                    style: const TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${_Weather!.temperature.round()}°C',
                    style: const TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _Weather!.mainCondition,
                    style: const TextStyle(fontSize: 30),
                  ),
                  //   const SizedBox(height: 20),
                  //   Image.network(
                  //       'https://openweathermap.org/img/w/${_Weather!.weatherIcon}.png'),
                  //
                ],
              ),
      ),
    );
  }
}
