class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final String weatherIcon;
  final String mainCondition;

  Weather({
    required this.cityName,
    required this.temperature,
    this.description = '',
    this.weatherIcon = '',
    required this.mainCondition,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      weatherIcon: json['weather'][0]['icon'],
      mainCondition: json['weather'][0]['main'],
    );
  }
}
