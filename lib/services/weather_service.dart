import 'package:kumori/models/weather_model.dart';
import 'package:http/http.dart'as http;
class WeatherService {
  static const BASE_URL = 'https://openweathermap.org/';
  final String apikey;
  WeatherService(this.apikey);
  Future<Weather> getWeather(String cityName) async{
    final response = await http.get
  }
}