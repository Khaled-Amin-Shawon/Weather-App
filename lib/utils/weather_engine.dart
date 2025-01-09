import 'package:weather_app/Models/weather_models.dart';
import 'package:weather_app/Services/weather_services.dart';

class WeatherEngine {
  final WeatherServices _weatherServices = WeatherServices();

  Future<Weather?> getCurrentWeather() async {
    try {
      String cityName = await _weatherServices.getCurrentCity();
      return await _weatherServices.getWeather(cityName);
    } catch (e) {
      print("Error fetching current weather: $e");
      return null;
    }
  }

  Future<Weather?> getWeatherByCity(String cityName) async {
    try {
      return await _weatherServices.getWeather(cityName);
    } catch (e) {
      print("Error fetching weather for $cityName: $e");
      return null;
    }
  }

  Future<Map<String, Weather?>> getDivisionWeather(List<String> divisions) async {
    Map<String, Weather?> divisionWeather = {};
    for (String division in divisions) {
      try {
        divisionWeather[division] = await _weatherServices.getWeather(division);
      } catch (e) {
        divisionWeather[division] = null;
        print("Error fetching weather for $division: $e");
      }
    }
    return divisionWeather;
  }
}
