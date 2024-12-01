import 'package:flutter/material.dart';
import 'package:kumori/services/weather_service.dart';

import '../models/weather_model.dart';
class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  // api key
  final _weatherService = WeatherService('a11455e875014a24be30b493e1590789');
  Weather? _weather;
  // fetch weather
  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
  // get weather
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    catch(e){
      print(e);
    }
  }
  // animations
  // innit state
  @override
  void innitState() {
    super.initState();

    _fetchWeather();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "Loading city..."),
            Text('${_weather?.tempreture.round()}°C')
          ],
        ),
      )
    );
  }
}