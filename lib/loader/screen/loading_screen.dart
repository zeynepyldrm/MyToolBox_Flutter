import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yapilacaklar_listesi/loader/constants.dart';
import 'package:yapilacaklar_listesi/loader/screen/weather_display.dart';
import 'package:yapilacaklar_listesi/loader/utils/location.dart';
import 'package:yapilacaklar_listesi/loader/utils/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late LocationHelper locationData;

  late Widget body;

  Future<void> getLocationData() async {
    locationData = LocationHelper();
    await locationData.getCurrentLocation();

    if (locationData.latitude == null || locationData.longitude == null) {
      // todo: Handle no location
    }
  }

  void getWeatherData() async {
    // Fetch the location
    await getLocationData();

    // Fetch the current weather
    WeatherData weatherData = WeatherData(locationData: locationData);
    await weatherData.getCurrentTemperature();

    if (weatherData.currentTemperature == null ||
        weatherData.currentCondition == null) {
      // todo: Handle no weather
    }
    setState(() {
      body = WeatherDisplay(
        weatherData: weatherData,
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      body = Container(
        decoration: BoxDecoration(
          gradient: kLinearGradient,
        ),
        child: Center(
          child: SpinKitRipple(
            color: Colors.white,
            size: 150.0,
            duration: Duration(milliseconds: 1200),
          ),
        ),
      );
    });
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: body);
  }
}
