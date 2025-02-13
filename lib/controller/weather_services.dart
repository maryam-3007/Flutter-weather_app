import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weathermodel.dart';
import 'package:weather_app/model/dailyforecastmodel.dart';
import 'package:weather_app/model/hourlyforecastmodel.dart';

class WeatherService {
  static const String apiKey = "c274bd53a79175cf1bd19cd9befc957f"; 
  static const String baseUrl = "https://api.openweathermap.org/data/2.5";

  // Fetch current weather data for the city
  Future<CurrentWeatherModel> fetchWeather(String cityName) async {
    final response = await http.get(Uri.parse('$baseUrl/weather?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return CurrentWeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }

  // Fetch hourly forecast data for the city
  Future<List<Hourlyforecastmodel>> fetchHourlyforecastmodel(String cityName) async {
    final response = await http.get(Uri.parse('$baseUrl/forecast?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
    var list = json.decode(response.body)['list'] as List;
    return list.map((json) => Hourlyforecastmodel.fromJson(json)).toList();
    } else {
    throw Exception('Failed to load hourly forecast');
    }
  }

  // Fetch 5-day forecast data for the city
  Future<List<Dailyforecastmodel>> fetchDailyforecastmodel(String cityName) async {
    final response = await http.get(Uri.parse('$baseUrl/forecast?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
    var data = json.decode(response.body);
    var list = data['list'] as List;

 // Group the 3-hour intervals by day
      Map<String, List<dynamic>> dailyData = {};

      for (var item in list) {
      var date = DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000).toString().substring(0, 10); // Extract date part only
      if (!dailyData.containsKey(date)) {
        dailyData[date] = [];
        }
        dailyData[date]?.add(item);
      }

  // Convert each group of 3-hour intervals to a daily forecast
      List<Dailyforecastmodel> dailyForecasts = [];
      dailyData.forEach((date, intervals) {
  // Calculate the day's average temperature and description
      double avgTemp = 0;
      String description = "";
      for (var interval in intervals) {
        avgTemp += interval['main']['temp'];
        if (description.isEmpty) {
           description = interval['weather'][0]['description'];
          }
        }
     avgTemp /= intervals.length;
    dailyForecasts.add(Dailyforecastmodel(
      date: DateTime.parse(date),
      dayTemp: avgTemp,
      description: description,
      maxTemp: avgTemp,
      minTemp: avgTemp
    ));
  });

  return dailyForecasts;
  } else {
   throw Exception('Failed to load 5-day forecast');
}
}
}
  
  
