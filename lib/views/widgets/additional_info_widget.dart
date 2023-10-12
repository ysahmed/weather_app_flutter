import 'package:weather/models/current_weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdditionalInfoGrid extends StatelessWidget {
  const AdditionalInfoGrid({
    super.key,
    required this.current,
    required this.count,
  });

  final CurrentWeather? current;
  final int count;

  @override
  Widget build(BuildContext context) {
    var titleTextStyle =
        Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white);

    const svgColorFilter = ColorFilter.mode(Colors.white, BlendMode.srcIn);

    return GridView.count(
      childAspectRatio: 1,
      crossAxisCount: count,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      shrinkWrap: true,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/images/sunrise.svg",
                      colorFilter: svgColorFilter,
                      height: 25,
                      width: 25,
                    ),
                    Text(
                      "  SUNRISE",
                      style: titleTextStyle,
                    ),
                  ],
                ),
                Text(
                  "${current?.sunrise}",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      "assets/images/sunrise.svg",
                      height: 60,
                      colorFilter: svgColorFilter,
                    )),
                Text(
                  "Sunset: ${current!.sunset.toString()}",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                )
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/images/humidity.svg",
                      colorFilter: svgColorFilter,
                      height: 25,
                      width: 25,
                    ),
                    Text(
                      "  HUMIDITY",
                      style: titleTextStyle,
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "${current!.humidity.toString()} %",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const Text("")
              ],
            ),
          ),
        ),
        // pressure
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/images/pressure.svg",
                      colorFilter: svgColorFilter,
                      height: 25,
                      width: 25,
                    ),
                    Text(
                      "  PRESSURE",
                      style: titleTextStyle,
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "${current?.pressure} hPa",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const Text(""),
              ],
            ),
          ),
        ),
        // wind
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/images/wind.svg",
                      colorFilter: svgColorFilter,
                      height: 25,
                      width: 25,
                    ),
                    Text(
                      "  WIND",
                      style: titleTextStyle,
                    )
                  ],
                ),
                Expanded(
                  child: Stack(
                    children: [
                      const Center(
                        child: Image(
                          image: AssetImage("assets/images/compass_dial.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Center(
                        child: Transform.rotate(
                          angle: current!.windAngle! * 3.14159265359 / 180,
                          alignment: Alignment.center,
                          child: const Image(
                            image: AssetImage("assets/images/compass_hand.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Center(
                        child: LayoutBuilder(builder: (context, constraints) {
                          var fontSize = constraints.maxWidth * 0.1;
                          return Text("${current?.windSpeed}\nkm/h",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    fontSize: fontSize,
                                    color: Colors.white,
                                  ));
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
