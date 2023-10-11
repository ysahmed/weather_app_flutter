import 'dart:convert';

import 'package:Weather/models/current_weather.dart';
import 'package:Weather/models/weather_forecast.dart';
import 'package:Weather/models/weather.dart';
import 'package:Weather/services/location/location_service.dart';
import 'package:Weather/secrets/api_key.dart';
import 'package:http/http.dart' as http;

class OpenWeather {
  static Future<Weather> getData([String? city]) async {
    String query;

    try {
      if (city != null) {
        query = "q=$city";
      } else {
        final location = LocationService.location;
        final locationData = await location.getLocation();
        final lat = locationData.latitude;
        final lon = locationData.longitude;

        query = "lat=$lat&lon=$lon";
      }

      const baseURL = "https://api.openweathermap.org/data/2.5/";
      final currentWeatherResponse = await http
          .get(Uri.parse('${baseURL}weather?$query&units=metric&appid=$apiKey'))
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw "No response or no Internet",
          );

      final weatherForecastResponse = await http
          .get(
              Uri.parse('${baseURL}forecast?$query&units=metric&appid=$apiKey'))
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw "No response or no Internet",
          );

      if (currentWeatherResponse.statusCode == 200 &&
          weatherForecastResponse.statusCode == 200) {
        final CurrentWeather currentWeather =
            CurrentWeather.fromJson(jsonDecode(currentWeatherResponse.body));

        final WeatherForecast weatherForecast =
            WeatherForecast.fromJson(jsonDecode(weatherForecastResponse.body));

        return Weather(current: currentWeather, forecast: weatherForecast);
      } else {
        throw 'Error fetching data';
      }
    } on http.ClientException {
      throw "No internet may be";
    } catch (e) {
      rethrow;
    }
  }
}
