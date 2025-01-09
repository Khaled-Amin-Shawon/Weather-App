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
      cityName: json['name'] ?? 'Unknown', // Default to 'Unknown' if city name is missing
      temperature: (json['main']['temp'] as num).toDouble(),
      description: json['weather']?.isNotEmpty == true
          ? json['weather'][0]['description'] ?? ''
          : '', // Handle missing or empty descriptions
      weatherIcon: json['weather']?.isNotEmpty == true
          ? json['weather'][0]['icon'] ?? ''
          : '', // Handle missing icon
      mainCondition: json['weather']?.isNotEmpty == true
          ? json['weather'][0]['main'] ?? 'Unknown'
          : 'Unknown', // Default to 'Unknown' if main condition is missing
    );
  }
}
