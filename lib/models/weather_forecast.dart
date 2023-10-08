class WeatherForecast {
  final String? cod;
  final int? message;
  final int? cnt;
  final List<WeatherData> list;
  final City? city;

  WeatherForecast({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      cod: json['cod'],
      message: json['message'],
      cnt: json['cnt'],
      list: List<WeatherData>.from(
          json['list'].map((data) => WeatherData.fromJson(data))),
      city: City.fromJson(json['city']),
    );
  }
}

class WeatherData {
  final int? dt;
  final MainWeatherData? main;
  final List<HourlyWeather> weather;
  final Clouds? clouds;
  final Wind? wind;
  final int? visibility;
  final double? pop;
  final Sys? sys;
  final String? dtTxt;

  WeatherData({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.sys,
    required this.dtTxt,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      dt: json['dt'],
      main: MainWeatherData.fromJson(json['main']),
      weather: List<HourlyWeather>.from(
          json['weather'].map((data) => HourlyWeather.fromJson(data))),
      clouds: Clouds.fromJson(json['clouds']),
      wind: Wind.fromJson(json['wind']),
      visibility: json['visibility'],
      pop: json['pop'].toDouble(),
      sys: Sys.fromJson(json['sys']),
      dtTxt: json['dt_txt'],
    );
  }
}

class MainWeatherData {
  final double? temp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final int? pressure;
  final int? seaLevel;
  final int? grndLevel;
  final int? humidity;
  final double? tempKf;

  MainWeatherData({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });

  factory MainWeatherData.fromJson(Map<String, dynamic> json) {
    return MainWeatherData(
      temp: json['temp']?.toDouble(),
      feelsLike: json['feels_like']?.toDouble(),
      tempMin: json['temp_min']?.toDouble(),
      tempMax: json['temp_max']?.toDouble(),
      pressure: json['pressure'],
      seaLevel: json['sea_level'],
      grndLevel: json['grnd_level'],
      humidity: json['humidity'],
      tempKf: json['temp_kf']?.toDouble(),
    );
  }
}

class HourlyWeather {
  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  HourlyWeather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}

class Clouds {
  final int? all;

  Clouds({
    required this.all,
  });

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json['all'],
    );
  }
}

class Wind {
  final double? speed;
  final int? deg;
  final double? gust;

  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed']?.toDouble(),
      deg: json['deg'],
      gust: json['gust']?.toDouble(),
    );
  }
}

class Sys {
  final String pod;

  Sys({
    required this.pod,
  });

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      pod: json['pod'],
    );
  }
}

class City {
  final int? id;
  final String? name;
  final Coord? coord;
  final String? country;
  final int? population;
  final int? timezone;
  final int? sunrise;
  final int? sunset;

  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      coord: Coord.fromJson(json['coord']),
      country: json['country'],
      population: json['population'],
      timezone: json['timezone'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }
}

class Coord {
  final double? lat;
  final double? lon;

  Coord({
    required this.lat,
    required this.lon,
  });

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lat: json['lat']?.toDouble(),
      lon: json['lon']?.toDouble(),
    );
  }
}
