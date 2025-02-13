import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controller/weather.dart';

class HomeScreen extends StatelessWidget {
  final WeatherController weatherController = Get.put(WeatherController());
  final TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child:GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/backgroundimage.png'),
                  fit: BoxFit.cover
                )
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),                  
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 5,
                            color: Colors.purple.shade900.withOpacity(0.9)
                          ),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Image.asset(
                          'assets/images/weatherlogo.png',
                          height: 80,
                          color: Colors.purple.shade900.withOpacity(0.3),
                          colorBlendMode: BlendMode.srcATop,                       
                        ),
                      ),
                      SizedBox(height: 30),
  
                      // City Input Field
                      TextField(
                        controller: cityController,
                        style: TextStyle(fontSize: 20),                       
                        decoration: 
                        InputDecoration(
                          hintText: 'Enter city name',
                          hintStyle: TextStyle(fontSize: 20),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.search, color: Colors.black),
                          suffixIcon: IconButton( icon: Icon(Icons.clear,),onPressed: (){
                            cityController.clear();
                          },
                          )
                        ), 
                      ),
                      SizedBox(height: 20),
              
                      // Get Weather Button
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            weatherController.fetchWeatherData(cityController.text);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                            backgroundColor: Colors.yellow,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            'Get Weather',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
              
                      // Weather Information
                      Expanded(
                        child: Obx(() {
                          if (weatherController.isLoading.value) {
                            return Center(child: CircularProgressIndicator(color: Colors.white,));
                          } else if (weatherController.currentWeather.value != null) {
                            return DefaultTabController(
                              length: 3,
                              child: Column(                                
                                children: [
                                  // Tab Bar for Current and Hourly forecast
                                  TabBar(
                                    labelColor: Colors.blue.shade900,
                                    unselectedLabelColor: Colors.black,
                                    indicatorColor: Colors.blue.shade900,
                                    tabs: const[
                                      Tab(
                                        child: Align(
                                          alignment: Alignment.center,
                                      child: Text(
                                        "Current Weather",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),),
                                      ),),
                                      Tab(child: Align(
                                        alignment:Alignment.center,
                                        child: Text(
                                        "Hourly Forecast",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                          ),
                                          ),
                                          ),
                                      Tab(child:Align(alignment: Alignment.center,
                                      child: Text(
                                        "Five Day Forecast",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),),
                                      ),)
                                    ],
                                  ),
                                  SizedBox(height: 30,),
                                  Expanded(
                                    child: TabBarView(
                                      children: [
                                        // Current Weather View
                                        _buildCurrentWeatherView(),
              
                                        // Hourly Forecast View
                                        _buildHourlyForecastView(),
                                        
                                        //Daily forecast View
                                        _buildDailyForecastView()
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Center(
                              child: Text(
                                'Enter a city to get the weather',
                                style: TextStyle(fontSize: 20, color: Colors.black),
                              ),
                              
                            );
                          }
                        }),
                      ),
                    ],
                  ),
                ),
              
              ),
            ],
          ),
        ),
        
      ),  
    );
  }
  // Widget for Current Weather forecast
  Widget _buildCurrentWeatherView() {
    var weather = weatherController.currentWeather.value!;
    return SingleChildScrollView(
      child: Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          
          child: Container(
            width: 250,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade100, Colors.blue.shade50],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  weather.cityName,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '${weather.temperature.toStringAsFixed(1)}°C',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  weather.description,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget for Hourly Forecast View
  Widget _buildHourlyForecastView() {
    return Obx(() {
      var hourlyList=weatherController.hourlyForecast.value;
      if (hourlyList.isEmpty) {
        return Center(
          child: Text(
            "Hourly forecast:$hourlyList",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        );
      }
      return ListView.builder(
        itemCount: hourlyList.length,
        itemBuilder: (context, index) {
          var forecast = hourlyList[index];
          return ListTile(
            leading: Icon(Icons.access_time, color: Colors.yellow),
            title: Text(
              '${forecast.dateTime.hour}:00',
              style: TextStyle(fontSize: 18,color: Colors.black),
            ),
            subtitle: Text(forecast.description,style: TextStyle(color: Colors.black),),
            trailing: Text(
              '${forecast.temperature.toStringAsFixed(1)}°C',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.yellow),
            ),
          );
        },
      );
    });
  }

//Widget for daily weather forecast of 5 days
  Widget _buildDailyForecastView() {
    return Obx(() {
      var dailyList=weatherController.dailyForecast.value;
      if (dailyList.isEmpty) {
        return Center(
          child: Text(
            "daily forecast $dailyList",
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        );
      }
      return ListView.builder(
        itemCount: dailyList.length,
        itemBuilder: (context, index) {
          var forecast = dailyList[index];
          return ListTile(
            leading: Icon(Icons.calendar_today, color: Colors.yellow),
            title: Text(
              '${forecast.date.day}/${forecast.date.month}/${forecast.date.year}',
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Text(forecast.description,style: TextStyle(color: Colors.black),),
            trailing: Text(
              '${forecast.dayTemp.toStringAsFixed(1)}°C',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.yellow),
            ),
          );
        },
      );
    });
  }
}