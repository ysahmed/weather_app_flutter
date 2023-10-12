import 'package:weather/models/current_weather.dart';
import 'package:weather/models/weather_forecast.dart';
import 'package:weather/views/widgets/additional_info_widget.dart';
import 'package:weather/views/widgets/current_main.dart';
import 'package:weather/views/widgets/forecasts_widget.dart';
import 'package:weather/views/widgets/suggestions_widget.dart';
import 'package:flutter/material.dart';

class PortraitBody extends StatelessWidget {
  final CurrentWeather? current;
  final WeatherForecast? forecast;
  const PortraitBody({
    super.key,
    required this.current,
    required this.forecast,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 90,
            ),
            // Main widget
            CurrentMain(current: current),
            const SizedBox(
              height: 90,
            ),
            // suggestions
            SuggestionsWidget(
              suggestions: current!.suggestions,
            ),
            const SizedBox(
              height: 10,
            ),
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
    );
  }
}
