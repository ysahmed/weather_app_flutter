import 'package:weather/models/current_weather.dart';
import 'package:weather/models/weather_forecast.dart';
import 'package:weather/views/widgets/additional_info_widget.dart';
import 'package:weather/views/widgets/current_main.dart';
import 'package:weather/views/widgets/forecasts_widget.dart';
import 'package:weather/views/widgets/suggestions_widget.dart';
import 'package:flutter/material.dart';

class TabletBody extends StatelessWidget {
  final CurrentWeather? current;
  final WeatherForecast? forecast;

  const TabletBody({
    super.key,
    required this.current,
    required this.forecast,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              // Main widget
              CurrentMain(current: current),
              const SizedBox(
                height: 100,
              ),
              // suggestions
              SuggestionsWidget(
                suggestions: current!.suggestions,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // graphs and staffs
                    ForeCastsWidget(forecast: forecast),
                    const SizedBox(
                      height: 8,
                    ),
                    AdditionalInfoGrid(
                      current: current,
                      count: 2,
                    ),
                  ],
                ),
              ),
            ))
      ],
    );
  }
}
