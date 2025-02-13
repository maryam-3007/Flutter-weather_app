import 'package:get/get.dart';
import 'package:weather_app/controller/weather_services.dart';
import 'package:weather_app/model/weathermodel.dart';
import 'package:weather_app/model/dailyforecastmodel.dart';
import 'package:weather_app/model/hourlyforecastmodel.dart';


class WeatherController extends GetxController {
  final WeatherService _weatherService = WeatherService();

  var currentWeather = Rx<CurrentWeatherModel?>(null);
  var hourlyForecast = Rx<List<Hourlyforecastmodel>>([]);
  var dailyForecast = Rx<List<Dailyforecastmodel>>([]);
  var isLoading = RxBool(false);

  // Method to fetch weather data (current weather, hourly, and daily forecast)
  Future<void> fetchWeatherData(String cityName) async {
    try {
      isLoading.value = true;
      var weather =await _weatherService.fetchWeather(cityName);
      currentWeather.value =weather;
      hourlyForecast.value = await _weatherService.fetchHourlyforecastmodel(cityName);
      dailyForecast.value = await _weatherService.fetchDailyforecastmodel(cityName);
      print("Daily Forecast Data:${dailyForecast.value}");
    } catch (e) {
      print("Error fetching weather data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}