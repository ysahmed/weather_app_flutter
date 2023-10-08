import 'dart:convert';

import 'package:Weather/models/current_weather.dart';
import 'package:Weather/models/weather_forecast.dart';
import 'package:Weather/models/weather.dart';
import 'package:Weather/services/location/location_service.dart';
import 'package:Weather/secrets/api_key.dart';
import 'package:http/http.dart' as http;

class OpenWeather {
  static Future getData() async {
    try {
      final location = LocationService.location;
      final locationData = await location.getLocation();
      final lat = locationData.latitude;
      final lon = locationData.longitude;

      const baseURL = "https://api.openweathermap.org/data/2.5/";
      final currentWeatherResponse = await http.get(Uri.parse(
          '${baseURL}weather?lat=$lat&lon=$lon&units=metric&appid=$apiKey'));

      final weatherForecastResponse = await http.get(Uri.parse(
          '${baseURL}forecast?lat=$lat&lon=$lon&units=metric&appid=$apiKey'));

      if (currentWeatherResponse.statusCode == 200 &&
          weatherForecastResponse.statusCode == 200) {
        final CurrentWeather currentWeather =
            CurrentWeather.fromJson(jsonDecode(currentWeatherResponse.body));

        final WeatherForecast weatherForecast =
            WeatherForecast.fromJson(jsonDecode(weatherForecastResponse.body));

        return Weather(
            currentWeather: currentWeather, weatherForecast: weatherForecast);
      } else {
        throw 'Error fetching data';
      }
    } catch (e) {
      rethrow;
    }
  }
}
