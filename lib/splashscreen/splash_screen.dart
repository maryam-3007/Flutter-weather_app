import 'package:flutter/material.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:weather_app/View/home_screen.dart';


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using a Timer to simulate a delay before transitioning to the home screen
    Future.delayed(Duration(seconds: 3), () {
      Get.off(() => HomeScreen());  // Navigate to the HomeScreen after 3 seconds
    });

    return Scaffold(
      body:Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.purple,Colors.blue],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
          ),
        ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.purple.shade900.withOpacity(0.9),
                  width: 5, 
                ),
                borderRadius: BorderRadius.circular(10), 
              ),
              child: Image.asset(
                'assets/images/weatherlogo.png', //splash screen logo
                height: 80,
                fit: BoxFit.cover,
                color: Colors.purple.shade900.withOpacity(0.3),
                colorBlendMode: BlendMode.srcATop,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Weather App',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    )
    );
  }
}