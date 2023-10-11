import 'package:Weather/models/weather_forecast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:fl_chart/fl_chart.dart';

class ForeCastsWidget extends StatelessWidget {
  const ForeCastsWidget({
    super.key,
    required this.forecast,
  });

  final WeatherForecast? forecast;
  final double chartWidth = 2500;
  final double chartHeight = 250;
  final double rowItemHeight = 110;

  @override
  Widget build(BuildContext context) {
    const svgColorFilter = ColorFilter.mode(Colors.white, BlendMode.srcIn);
    return Stack(
      children: [
        Card(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Stack(
              children: [
                Container(
                  // for the chart
                  padding: const EdgeInsets.only(bottom: 8),
                  width: chartWidth,
                  height: chartHeight,
                  child: LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: false),
                      titlesData: const FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      minX: 1,
                      maxX: forecast!.forecasts.length.toDouble() + 1,
                      minY: forecast!.flMin - 30,
                      maxY: forecast!.flMax + 16,
                      lineBarsData: [
                        LineChartBarData(
                          color: Colors.white,
                          isCurved: false,
                          spots: <FlSpot>[
                            ...forecast!.spots,
                            FlSpot(
                              forecast!.forecasts.length.toDouble() + 1,
                              forecast!.spots.last.y,
                            )
                          ],
                          dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) {
                              return FlDotCirclePainter(
                                radius: 2,
                                color: Colors.black,
                                strokeWidth: 0,
                              );
                            },
                          ),
                          belowBarData: BarAreaData(
                            show: false,
                            gradient: const LinearGradient(
                              colors: [
                                Colors.white54,
                                Colors.white24,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: chartHeight - rowItemHeight - 8,
                  child: SizedBox(
                    width: chartWidth,
                    height: rowItemHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (int i = 0;
                            i < forecast!.forecasts.length;
                            i++) ...[
                          Column(
                            children: [
                              // temp
                              Text(
                                "${forecast!.forecasts[i].temp?.toInt()}°",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              // icon
                              SvgPicture.asset(
                                forecast!.forecasts[i].icon!,
                                colorFilter: svgColorFilter,
                                height: 25,
                                width: 25,
                              ),
                              // pop
                              Text(
                                () {
                                  if (forecast!.forecasts[i].pop! >= 30) {
                                    return "${forecast!.forecasts[i].pop!.toInt()}%";
                                  } else {
                                    return "";
                                  }
                                }(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      height: 0.5,
                                      color: const Color.fromARGB(
                                          255, 0, 238, 255),
                                    ),
                              ),
                              // spacer
                              const SizedBox(
                                height: 5,
                              ),
                              // day
                              Text(
                                "${forecast!.forecasts[i].day}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              // hour
                              Text(
                                "${forecast!.forecasts[i].hr}",
                                maxLines: 1,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              // max/min
                              Text(
                                "${forecast!.forecasts[i].tempMax?.toInt()}°/${forecast!.forecasts[i].tempMin?.toInt()}°",
                                style: Theme.of(context).textTheme.bodySmall,
                              )
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 12,
          left: 12,
          child: Text(
            "Temperature",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontSize: 22,
                ),
          ),
        ),
      ],
    );
  }
}
