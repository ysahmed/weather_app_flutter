import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:weather/utils/countries.dart';
import 'package:weather/models/city.dart';
import 'package:weather/models/current_weather.dart';
import 'package:weather/models/weather_forecast.dart';
import 'package:weather/models/weather.dart';
// import 'package:weather/services/location/location_service.dart';
import 'package:weather/secrets/api_key.dart';
import 'package:http/http.dart' as http;

class OpenWeather {
  static Future<Weather> getData([String? city]) async {
    String query;

    try {
      if (city != null) {
        query = "q=$city";
      } else {
        final location = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        final lat = location.latitude;
        final lon = location.longitude;
        // final location = LocationService.location;
        // final locationData = await location.getLocation();
        // final lat = locationData.latitude;
        // final lon = locationData.longitude;

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

  static Future<List<City>> searchCities({required String query}) async {
    const limit = 5;
    final url =
        'https://api.openweathermap.org/geo/1.0/direct?q=$query&limit=$limit&appid=$apiKey';

    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);

    try {
      if (response.statusCode == 200) {
        return body.map<City>(
          (json) {
            final city = json['name'];
            final state = json['state'];
            final country = countries[json['country']];
            final lat = json['lat']?.toDouble();
            final lon = json['lon']?.toDouble();

            return City(
              city: city,
              state: state,
              country: country,
              lat: lat,
              lon: lon,
            );
          },
        ).toList();
      } else {
        throw "Something went wrong.";
      }
    } catch (e) {
      rethrow;
    }
  }
}
