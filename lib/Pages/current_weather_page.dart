import 'package:flutter/material.dart';
import 'package:weather_app/Models/weather_models.dart';
import 'package:weather_app/utils/weather_engine.dart';

class CurrentWeatherPage extends StatefulWidget {
  const CurrentWeatherPage({super.key});

  @override
  _CurrentWeatherPageState createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  final WeatherEngine _weatherEngine = WeatherEngine();
  Weather? _currentWeather;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCurrentWeather();
  }

  Future<void> _fetchCurrentWeather() async {
    setState(() => _isLoading = true);
    Weather? weather = await _weatherEngine.getCurrentWeather();
    setState(() {
      _currentWeather = weather;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 46, 6, 114),
        title: const Text(
          'Current weather',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
              size: 20,
              color: Colors.white,
            ),
            onPressed: _fetchCurrentWeather,
          )
        ],
      ),
      body: _isLoading
          ? Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    const Color.fromARGB(255, 46, 6, 114),
                    const Color.fromARGB(255, 55, 19, 116),
                    Colors.deepPurple,
                    const Color.fromARGB(255, 131, 78, 224),
                    Colors.purpleAccent,
                  ])),
              child: const Center(child: CircularProgressIndicator()))
          : _currentWeather != null
              ? SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          const Color.fromARGB(255, 46, 6, 114),
                          const Color.fromARGB(255, 55, 19, 116),
                          Colors.deepPurple,
                          const Color.fromARGB(255, 131, 78, 224),
                          Colors.purpleAccent,
                        ])),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/current_Weather_page.png",
                            height: size.height*0.4,
                            width: size.width*0.4,
                          ),
                          Text(
                            _currentWeather!.cityName,
                            style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Weather Details',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '${_currentWeather!.temperature.round()}°C',
                            style: const TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _currentWeather!.mainCondition,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(height: 20),
                          if (_currentWeather!.weatherIcon.isNotEmpty)
                            Image.network(
                              'https://openweathermap.org/img/wn/${_currentWeather!.weatherIcon}@2x.png',
                              height: 100,
                              width: 100,
                            ),
                        ],
                      ),
                    ),
                  ),
                )
              : const Center(
                  child: Text('Failed to fetch weather.'),
                ),
    );
  }
}
