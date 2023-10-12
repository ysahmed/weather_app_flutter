import 'package:weather/models/current_weather.dart';
import 'package:weather/models/weather_forecast.dart';

class Weather {
  final CurrentWeather _currentWeather;
  final WeatherForecast _weatherForecast;

  CurrentWeather get current => _currentWeather;
  WeatherForecast get forecast => _weatherForecast;

  Weather({
    required CurrentWeather current,
    required WeatherForecast forecast,
  })  : _weatherForecast = forecast,
        _currentWeather = current;
}
