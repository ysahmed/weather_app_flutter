import 'package:Weather/models/current_weather.dart';
import 'package:Weather/models/weather_forecast.dart';

class Weather {
  final CurrentWeather currentWeather;
  final WeatherForecast weatherForecast;

  Weather({
    required this.currentWeather,
    required this.weatherForecast,
  });
}
