// import 'package:fl_chart/fl_chart.dart';
import 'package:fl_chart/src/chart/base/axis_chart/axis_chart_data.dart';
import 'package:intl/intl.dart';

class WeatherForecast {
  final int? cnt;
  final List<Forecast> forecasts;
  final List<FlSpot> spots;
  final double flMin;
  final double flMax;

  WeatherForecast({
    required this.cnt,
    required this.forecasts,
    required this.spots,
    required this.flMin,
    required this.flMax,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    double x = 1;
    List<FlSpot> flSpots = [];
    double min = 500;
    double max = -500;
    return WeatherForecast(
      cnt: json['cnt'],
      forecasts: List<Forecast>.from(
        json['list'].map(
          (data) {
            double current = data['main']['temp']?.toDouble();
            min = current < min ? current : min;
            max = current > max ? current : max;
            flSpots.add(FlSpot(x++, current));
            return Forecast.fromJson(data, json['city']['timezone']);
          },
        ),
      ),
      spots: flSpots,
      flMin: min,
      flMax: max,
    );
  }
}

class Forecast {
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

  final int? dt;
  final String? day;
  final String? hr;
  final String? icon;

  Forecast({
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
    required this.dt,
    required this.day,
    required this.hr,
    required this.icon,
  });

  @override
  String toString() {
    return "$temp $feelsLike $humidity";
  }

  factory Forecast.fromJson(Map<String, dynamic> json, int timezone) {
    //int timezone = json['city']['timezone'];
    String pod = "";
    String sky = "";
    String day = "";
    String hr = "";
    int h = 0;
    return Forecast(
        sky: () {
          sky = json['weather'][0]['main'];
          return sky;
        }(),
        dt: () {
          int _dt = json['dt'];
          DateTime _pdt = DateTime.fromMillisecondsSinceEpoch((_dt) * 1000);
          // .add(Duration(seconds: timezone));
          day = DateFormat('E').format(_pdt);
          hr = DateFormat.j().format(_pdt);
          h = int.parse(DateFormat.H().format(_pdt));
          return _dt;
        }(),
        day: day,
        hr: hr,
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
        // pod: () {
        //   pod = json['sys']['pod'];
        //   return pod;
        // }(),
        pod: () {
          if ((h > 17 && h < 23) || (h >= 0 && h < 5)) {
            pod = "n";
          } else {
            pod = "d";
          }
          return pod;
        }(),
        icon: () {
          String icon;
          if (sky == "Clear" || sky == "Haze" || sky == "Squall") {
            icon = "${sky.toLowerCase()}_$pod";
          } else {
            icon = sky.toLowerCase();
          }

          return "assets/images/$icon.svg";
        }());
  }
}
