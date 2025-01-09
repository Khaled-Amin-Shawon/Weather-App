import 'package:flutter/material.dart';
import 'package:weather_app/Models/weather_models.dart';
import 'package:weather_app/utils/weather_engine.dart';

class SearchWeatherPage extends StatefulWidget {
  const SearchWeatherPage({super.key});

  @override
  _SearchWeatherPageState createState() => _SearchWeatherPageState();
}

class _SearchWeatherPageState extends State<SearchWeatherPage> {
  final WeatherEngine _weatherEngine = WeatherEngine();
  final TextEditingController _controller = TextEditingController();
  Weather? _searchedWeather;
  bool _isLoading = false;
  String? _errorMessage;

  // Perform search when the user submits the search text
  Future<void> _searchWeather(String cityName) async {
    if (cityName.isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _searchedWeather = null;
    });

    try {
      // Fetch weather data
      Weather? weather = await _weatherEngine.getWeatherByCity(cityName);
      setState(() {
        _searchedWeather = weather;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'City not found or failed to load weather data';
        _isLoading = false;
      });
    }

    // Clear the text field after search
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 46, 6, 114),
        title: const Text(
          'Search Weather',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    labelText: 'Enter city name',
                    labelStyle: const TextStyle(
                      color: Colors.white, // Change this to your desired color
                    ),
                    hintText: 'e.g., New York, London, Tokyo',
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                    ),
                    border: const OutlineInputBorder(),
                    fillColor: Colors.white,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  onSubmitted: (value) {
                    // Start the search process when the user submits text
                    _searchWeather(value);
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _searchWeather(_controller.text),
                  child: const Text('Search'),
                ),
                const SizedBox(height: 20),
                // Display loading indicator, error, or weather data
                _isLoading
                    ? const CircularProgressIndicator()
                    : _errorMessage != null
                        ? Center(
                            child: Text(
                              _errorMessage!,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 18),
                            ),
                          )
                        : _searchedWeather != null
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 20),
                                    const Icon(Icons.location_on, color: Colors.white,),
                                    const SizedBox(height: 20),
                                    Text(
                                      _searchedWeather!.cityName,
                                      style: const TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                      ),
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
                                    const SizedBox(height: 30),
                                    Text(
                                      'Temperature:',
                                      style: const TextStyle(fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),),
                                    const SizedBox(height: 10,),
                                    Text(
                                      '${_searchedWeather!.temperature.round()}°C',
                                      style: const TextStyle(
                                        fontSize: 50,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Condition:',
                                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      _searchedWeather!.mainCondition,
                                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                    const SizedBox(height: 20),
                                    if (_searchedWeather!.weatherIcon.isNotEmpty)
                                      Image.network(
                                        'https://openweathermap.org/img/wn/${_searchedWeather!.weatherIcon}@2x.png',
                                        height: 100,
                                        width: 100,
                                      ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
