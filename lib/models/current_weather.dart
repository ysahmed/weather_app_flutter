import 'package:weather/models/suggestion.dart';
import 'package:weather/utils/suggestions_map.dart';
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

  final int? dateTimeUnix;

  final String sunrise;
  final String sunset;

  final int? visibility;

  final String? country;
  final String? cityName;

  final List<Suggestion> suggestions;

  CurrentWeather({
    required this.coord,
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
    required this.dateTimeUnix,
    required this.sunrise,
    required this.sunset,
    required this.visibility,
    required this.country,
    required this.cityName,
    required this.suggestions,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    int sunrise = json['sys']['sunrise'];
    int sunset = json['sys']['sunset'];
    int timezone = json['timezone'];
    List<Suggestion> suggestions = [];
    return CurrentWeather(
      coord: Coord.fromJson(json['coord']),
      sky: json['weather'][0]['main'],
      description: () {
        String desc = json['weather'][0]['description'];
        String pod = json['weather'][0]['icon'].substring(2);
        String descPod;
        descPod = pod == 'n' ? "$desc $pod" : desc;
        if (titles[descPod] != null) {
          suggestions.add(
              Suggestion(title: titles[descPod], subTitle: subTitles[descPod]));
        }
        return desc;
      }(),
      temperature: () {
        double temp = json['main']['temp']?.toDouble();
        late Suggestion suggestion;
        if (temp > 30) {
          suggestion = Suggestion(
              title: "Bring juice!",
              subTitle: "Scorching heat. ${temp.toInt()}°C");
        } else if (temp > 20) {
          suggestion = Suggestion(
              title: "Dress light",
              subTitle: "Warm outside. ${temp.toInt()}°C");
        } else if (temp > 10) {
          suggestion = Suggestion(
              title: "Sweaters on!",
              subTitle: "Pretty cold. ${temp.toInt()}°C");
        } else if (temp > 0) {
          suggestion = Suggestion(
              title: "Coffee?", subTitle: "Almost freezing. ${temp.toInt()}°C");
        } else {
          suggestion = Suggestion(
              title: "Light the fire!",
              subTitle: "Freezing cold. ${temp.toInt()}°C");
        }
        suggestions.add(suggestion);
        return temp;
      }(),
      suggestions: suggestions,
      feelsLike: json['main']['feels_like']?.toDouble(),
      minTemperature: json['main']['temp_min']?.toDouble(),
      maxTemperature: json['main']['temp_max']?.toDouble(),
      humidity: json['main']['humidity'],
      pressure: json['main']['pressure'],
      visibility: json['visibility'],
      windSpeed: json['wind']['speed']?.toDouble(),
      windAngle: json['wind']['deg'],
      windGust: json['wind']['gust']?.toDouble(),
      dateTimeUnix: json['dt'],
      sunrise: DateFormat.jm().format(
        DateTime.fromMillisecondsSinceEpoch((sunrise + timezone) * 1000,
            isUtc: true),
      ),
      sunset: DateFormat.jm().format(
        DateTime.fromMillisecondsSinceEpoch((sunset + timezone) * 1000,
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
