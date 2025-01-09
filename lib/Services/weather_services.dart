import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:weather_app/Models/weather_models.dart';
import 'package:http/http.dart' as http;

class WeatherServices {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey = "843291aa1ab749645d9dd0f0b5c4b6d1";

  WeatherServices();

  Future<Weather> getWeather(String cityName) async {
  try {
    final response = await http
        .get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'))
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception('Error ${response.statusCode}: ${errorData["message"]}');
    }
  } catch (e) {
    print('Error fetching weather: $e');
    throw Exception('Failed to load weather data. Please try again later.');
  }
}


  Future<String> getCurrentCity() async {
  try {
    // Check internet connectivity
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      throw Exception('No internet connection.');
    }

    // Ensure location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled. Please enable them.');
    }

    // Check and request permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied. Please enable them in settings.');
    }

    // Get current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');

    // Convert coordinates to placemarks
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    // Try fetching the locality or fallback to other fields
    String? city = placemarks[0].locality ??
        placemarks[0].subAdministrativeArea ??
        placemarks[0].administrativeArea;

    if (city == null || city.isEmpty) {
      throw Exception('City name could not be determined.');
    }
    return city;
  } catch (e) {
    print('Failed to fetch city name: $e');
    return 'Dinajpur'; // Default city
  }
}

}
