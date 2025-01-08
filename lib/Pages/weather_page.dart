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
  final _weatherService = WeatherServices();
  Weather? _Weather;
  String? _errorMessage;

  // fetch the weather
  _fetchWeather() async {
    final cityName = await _weatherService.getCurrentCity();

    // get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _Weather = weather;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load weather data';
      });
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
            ? _errorMessage != null
                ? Text(_errorMessage!, style: TextStyle(color: Colors.red, fontSize: 20))
                : const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome to the Weather App",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.grey,
                    ),
                  ),
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
