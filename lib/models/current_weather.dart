class CurrentWeather {
  final Coord coord;
  final String? sky;
  final String? description;

  final double? temperature;
  final double? feelsLike;
  final double? minTemperature;
  final double? maxTemperature;
  final int humidity;

  final double? windSpeed;
  final int? windAngle;
  final double? windGust;

  final int? cloudiness;

  final int? dateTimeUTC;

  final int? sunriseUTC;
  final int? sunsetUTC;

  final int? timezone;

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
      required this.windSpeed,
      required this.windAngle,
      required this.windGust,
      required this.cloudiness,
      required this.dateTimeUTC,
      required this.sunriseUTC,
      required this.sunsetUTC,
      required this.timezone,
      required this.visibility,
      required this.country,
      required this.cityName});

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      coord: Coord.fromJson(json['coord']),
      sky: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'],
      feelsLike: json['main']['feels_like'],
      minTemperature: json['main']['temp_min'],
      maxTemperature: json['main']['temp_max'],
      humidity: json['main']['humidity'],
      visibility: json['visibility'],
      windSpeed: json['wind']['speed'],
      windAngle: json['wind']['deg'],
      windGust: json['wind']['gust'],
      dateTimeUTC: json['dt'],
      sunriseUTC: json['sys']['sunrise'],
      sunsetUTC: json['sys']['sunset'],
      country: json['sys']['country'],
      timezone: json['timezone'],
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
      lon: json['lon'].toDouble(),
      lat: json['lat'].toDouble(),
    );
  }
}
