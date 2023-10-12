import 'package:weather/models/current_weather.dart';
import 'package:weather/models/weather_forecast.dart';
import 'package:weather/views/widgets/additional_info_widget.dart';
import 'package:weather/views/widgets/current_main.dart';
import 'package:weather/views/widgets/forecasts_widget.dart';
import 'package:weather/views/widgets/suggestions_widget.dart';
import 'package:flutter/material.dart';

class TabLandscapeBody extends StatelessWidget {
  final CurrentWeather? current;
  final WeatherForecast? forecast;
  const TabLandscapeBody({
    super.key,
    required this.current,
    required this.forecast,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CurrentMain(current: current),
                      const SizedBox(
                        height: 5,
                      ),
                      SuggestionsWidget(
                        suggestions: current!.suggestions,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ForeCastsWidget(forecast: forecast),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: AdditionalInfoGrid(current: current, count: 4),
          )
        ],
      ),
    );
  }
}
