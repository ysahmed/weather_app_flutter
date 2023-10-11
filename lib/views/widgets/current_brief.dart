import 'package:flutter/material.dart';
import 'package:Weather/models/current_weather.dart';
import 'package:Weather/utils/country.dart';

class CurrentBrief extends StatelessWidget {
  const CurrentBrief({
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
              "${current?.cityName}, ${country[current?.country]}",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          // min max feels like
          Text(
            "${current?.maxTemperature?.toInt()}°/${current?.minTemperature?.toInt()}° | feels like ${current?.feelsLike?.toInt()}°",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          // humidity
          Text(
            "Humidity: ${current?.humidity.toInt()}%",
            style:
                Theme.of(context).textTheme.bodyMedium?.copyWith(height: 0.8),
          ),
        ],
      ),
    );
  }
}
