import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kumori/models/weather_model.dart';
import 'package:http/http.dart'as http;
class WeatherService {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apikey;
  WeatherService(this.apikey);
  Future<Weather> getWeather(String cityName) async{
    final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apikey&units=metric'));

    if (response.statusCode==200) {
      return Weather.fromJson(jsonDecode(response.body));
    }
    else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentCity() async{
    // Get permission from user
    LocationPermission  permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
    }
    // Fetch permission part
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
    // Convert location into a list of placemark objects
    List<Placemark> placemarks = 
    await placemarkFromCoordinates(position.latitude, position.longitude);
    // Extract the city name from placemark
    String? city = placemarks[0].locality;

    return city ?? "";
  }
}