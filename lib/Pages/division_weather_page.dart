import 'package:flutter/material.dart';
import 'package:weather_app/Models/weather_models.dart';
import 'package:weather_app/utils/weather_engine.dart';

class DivisionWeatherPage extends StatefulWidget {
  const DivisionWeatherPage({super.key});

  @override
  _DivisionWeatherPageState createState() => _DivisionWeatherPageState();
}

class _DivisionWeatherPageState extends State<DivisionWeatherPage> {
  final WeatherEngine _weatherEngine = WeatherEngine();
  final List<String> divisions = [
    'Dhaka',
    'Chittagong',
    'Rajshahi',
    'Khulna',
    'Barisal Division, BD',
    'Sylhet',
    'Rangpur',
    'Mymensingh',
  ];

  Map<String, Weather?> _divisionWeather = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDivisionWeather();
  }

  Future<void> _fetchDivisionWeather() async {
    setState(() => _isLoading = true);
    Map<String, Weather?> weatherData =
        await _weatherEngine.getDivisionWeather(divisions);
    setState(() {
      _divisionWeather = weatherData;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 46, 6, 114),
        title: const Text(
          'Bangladesh Division Weather',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
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
            onPressed: _fetchDivisionWeather,
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
          : Container(
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
            child: ListView.builder(
              itemCount: divisions.length,
              itemBuilder: (context, index) {
                final division = divisions[index];
                final weather = _divisionWeather[division];
                return Card(
                  margin: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 30, right: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30)),
                      border: Border.all(color: Colors.grey),
                      gradient: LinearGradient(
                        colors: [Colors.white54, Colors.white],
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        division,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                      subtitle: weather != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Temperature: ${weather.temperature.round()}°C',
                                  style: const TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'Condition: ${weather.mainCondition}',
                                  style: const TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            )
                          : const Text(
                              'Weather data unavailable.',
                              style: TextStyle(color: Colors.red),
                            ),
                      trailing:
                          weather != null && weather.weatherIcon.isNotEmpty
                              ? Image.network(
                                  'https://openweathermap.org/img/wn/${weather.weatherIcon}@2x.png',
                                  height: 50,
                                  width: 50,
                                )
                              : null,
                    ),
                  ),
                );
              },
            ),
          ),
    );
  }
}
