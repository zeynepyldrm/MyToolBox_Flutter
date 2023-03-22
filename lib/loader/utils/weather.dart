import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:yapilacaklar_listesi/loader/constants.dart';

import 'location.dart';

class WeatherDisplayData {
  Icon weatherIcon;
  AssetImage weatherImage;
  WeatherDisplayData({required this.weatherIcon, required this.weatherImage});
}

class WeatherData {
  WeatherData({this.locationData});

  LocationHelper? locationData;
  double? currentTemperature;
  int? currentCondition;

  Future<void> getCurrentTemperature() async {
    Response response = await get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?lat=${locationData!.latitude}&lon=${locationData!.longitude}&appid=d4e0334629486ad76dfc53766e2a015e&units=metric'));

    if (response.statusCode == 200) {
      String data = response.body;
      var currentWeather = jsonDecode(data);

      try {
        currentTemperature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
      } catch (e) {
        print(e);
      }
    } else {
      print('Could not fetch temperature!');
    }
  }

  WeatherDisplayData getWeatherDisplayData() {
    if (currentCondition! < 600) {
      return WeatherDisplayData(
          weatherIcon: kCloudIcon,
          weatherImage: AssetImage('assets/weather_bg_cloud.png'));
    } else {
      var now = new DateTime.now();

      if (now.hour >= 15) {
        return WeatherDisplayData(
            weatherImage: AssetImage('assets/weather_bg_night.png'),
            weatherIcon: kMoonIcon);
      } else {
        return WeatherDisplayData(
          weatherIcon: kSunIcon,
          weatherImage: AssetImage('assets/weather_bg_sunny.png'),
        );
      }
    }
  }
}
