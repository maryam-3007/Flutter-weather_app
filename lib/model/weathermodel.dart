// models/weather_model.dart
class CurrentWeatherModel {
  final String cityName;
  final double temperature;
  final String description;
  final double longitude;
  final double latitude;

  CurrentWeatherModel({
    required this.cityName, 
    required this.temperature,
     required this.description,
     required this.latitude,
     required this.longitude});

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherModel(
      cityName: json['name'],
      temperature: json['main']['temp'], // Convert from Kelvin to Celsius
      description: json['weather'][0]['description'],
      latitude: json['coord']['lat'],
      longitude: json['coord']['lon']
    );
  }
}