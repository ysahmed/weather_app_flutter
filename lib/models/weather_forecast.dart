// import 'package:fl_chart/fl_chart.dart';
import 'package:fl_chart/src/chart/base/axis_chart/axis_chart_data.dart';

class WeatherForecast {
  final int? cnt;
  final List<Forecast> forecasts;
  final List<FlSpot> spots;

  WeatherForecast({
    required this.cnt,
    required this.forecasts,
    required this.spots,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    double x = 1;
    return WeatherForecast(
      cnt: json['cnt'],
      forecasts: List<Forecast>.from(
          json['list'].map((data) => Forecast.fromJson(data))),
      spots: List<FlSpot>.from(
        json['list'].map((data) {
          return FlSpot(x++, data['main']['temp']?.toDouble());
        }),
      ),
    );
  }
}

class Forecast {
  final int? dt;
  // main
  final double? temp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final int? pressure;
  final int? humidity;
  final double? tempKf;
  // weather
  final String? sky;
  final String? description;
  final int? cloudiness;
  // wind
  final double? windSpeed;
  final int? deg;
  final double? gust;

  final int? visibility;
  final double? pop;

  final String? pod;

  final String? dtTxt;

  Forecast({
    required this.dt,
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.tempKf,
    required this.sky,
    required this.description,
    required this.cloudiness,
    required this.windSpeed,
    required this.deg,
    required this.gust,
    required this.visibility,
    required this.pop,
    required this.pod,
    required this.dtTxt,
  });

  @override
  String toString() {
    return "$temp $feelsLike $humidity";
  }

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      dt: json['dt'],
      sky: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      cloudiness: json['clouds']['all'],
      temp: json['main']['temp']?.toDouble(),
      feelsLike: json['main']['feels_like']?.toDouble(),
      tempMin: json['main']['temp_min']?.toDouble(),
      tempMax: json['main']['temp_max']?.toDouble(),
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      tempKf: json['main']['temp_kf']?.toDouble(),
      windSpeed: json['wind']['speed']?.toDouble(),
      deg: json['wind']['deg'],
      gust: json['wind']['gust']?.toDouble(),
      visibility: json['visibility'],
      pop: json['pop']?.toDouble(),
      pod: json['sys']['pod'],
      dtTxt: json['dt_txt'],
    );
  }
}
