import 'package:intl/intl.dart';

class CurrentWeather {
  final Coord coord;
  final String? sky;
  final String? description;

  final double? temperature;
  final double? feelsLike;
  final double? minTemperature;
  final double? maxTemperature;
  final int humidity;
  final int pressure;

  final double? windSpeed;
  final int? windAngle;
  final double? windGust;

  final int? cloudiness;

  final int? dateTimeUTC;

  final String sunrise;
  final String sunset;

  final int? visibility;

  final String? country;
  final String? cityName;

  CurrentWeather(
      {required this.coord,
      required this.sky,
      required this.description,
      required this.temperature,
      required this.feelsLike,
      required this.minTemperature,
      required this.maxTemperature,
      required this.humidity,
      required this.pressure,
      required this.windSpeed,
      required this.windAngle,
      required this.windGust,
      required this.cloudiness,
      required this.dateTimeUTC,
      required this.sunrise,
      required this.sunset,
      required this.visibility,
      required this.country,
      required this.cityName});

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    int _sunrise = json['sys']['sunrise'];
    int _sunset = json['sys']['sunset'];
    int _timezone = json['timezone'];
    return CurrentWeather(
      coord: Coord.fromJson(json['coord']),
      sky: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      temperature: json['main']['temp']?.toDouble(),
      feelsLike: json['main']['feels_like']?.toDouble(),
      minTemperature: json['main']['temp_min']?.toDouble(),
      maxTemperature: json['main']['temp_max']?.toDouble(),
      humidity: json['main']['humidity'],
      pressure: json['main']['pressure'],
      visibility: json['visibility'],
      windSpeed: json['wind']['speed']?.toDouble(),
      windAngle: json['wind']['deg'],
      windGust: json['wind']['gust']?.toDouble(),
      dateTimeUTC: json['dt'],
      sunrise: DateFormat.jm().format(
        DateTime.fromMillisecondsSinceEpoch((_sunrise + _timezone) * 1000,
            isUtc: true),
      ),
      sunset: DateFormat.jm().format(
        DateTime.fromMillisecondsSinceEpoch((_sunset + _timezone) * 1000,
            isUtc: true),
      ),
      country: json['sys']['country'],
      cityName: json['name'],
      cloudiness: json['clouds']['all'],
    );
  }
}

class Coord {
  final double lon;
  final double lat;

  Coord({
    required this.lon,
    required this.lat,
  });

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lon: json['lon']?.toDouble(),
      lat: json['lat']?.toDouble(),
    );
  }
}
