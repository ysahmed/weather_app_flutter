import 'package:flutter/material.dart';
import 'package:weather/models/current_weather.dart';
import 'package:weather/utils/countries.dart';

class CurrentMain extends StatelessWidget {
  const CurrentMain({
    super.key,
    required this.current,
  });

  final CurrentWeather? current;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          // temp
          Text(
            "${current?.temperature?.toInt()}°C",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          // city country
          if (current?.cityName != null)
            Text(
              "${current?.cityName}, ${countries[current?.country]}",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          // min max feels like
          Text(
            "${current?.maxTemperature?.toInt()}°/${current?.minTemperature?.toInt()}° | feels like ${current?.feelsLike?.toInt()}°",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
