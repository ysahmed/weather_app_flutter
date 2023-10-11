import 'package:Weather/models/current_weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdditionalInfoGrid extends StatelessWidget {
  const AdditionalInfoGrid({
    super.key,
    required this.current,
  });

  final CurrentWeather? current;

  @override
  Widget build(BuildContext context) {
    var titleTextStyle =
        Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white);

    const svgColorFilter = ColorFilter.mode(Colors.white, BlendMode.srcIn);

    return GridView.count(
      childAspectRatio: 1,
      crossAxisCount: 2,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 8),
      shrinkWrap: true,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
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
                const Align(
                  alignment: Alignment.center,
                  child: Image(
                      fit: BoxFit.contain,
                      image: AssetImage("assets/images/sunrise.png")),
                )
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/images/sunset.svg",
                      colorFilter: svgColorFilter,
                      height: 25,
                      width: 25,
                    ),
                    Text(
                      "  SUNSET",
                      style: titleTextStyle,
                    )
                  ],
                ),
                Text(
                  "${current?.sunset}",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Image(
                      fit: BoxFit.contain,
                      image: AssetImage("assets/images/sunrise.png")),
                )
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
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
                Text(
                  "${current?.pressure} \nhPa",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text("pressure.svg"),
                )
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Text(
                  "${current?.windSpeed} km/h",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                      ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        const Image(
                          image: AssetImage("assets/images/compass_dial.png"),
                          fit: BoxFit.cover,
                        ),
                        Transform.rotate(
                          angle: 45 * 3.14159265359 / 180,
                          alignment: Alignment.center,
                          child: const Image(
                            image: AssetImage("assets/images/compass_hand.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
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
