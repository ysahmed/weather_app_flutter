import 'package:Weather/models/weather.dart';
import 'package:Weather/services/network/openweather.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:Weather/views/widgets/suggestion_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Weather/utils/maps.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController controller = PageController();
  late Future<Weather?> weather;
  @override
  void initState() {
    super.initState();
    controller = PageController(viewportFraction: 1);
    weather = OpenWeather.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white70,
        // appBar: AppBar(
        //   title: const Text("Weather"),
        //   backgroundColor: Color.fromARGB(0, 0, 0, 0),
        // ),
        body: FutureBuilder<Weather?>(
          future: weather,
          builder: (context, snapshot) {
            // if (snapshot.hasError) {
            //   //error screen

            //   return Text("error");
            // } else
            if (snapshot.connectionState == ConnectionState.waiting) {
              // loading screen
              return Text('Loading');
            }
            final current = snapshot.data?.currentWeather;
            // final forecasts = snapshot.data?.weatherForecast;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 120,
                    ),
                    // Main widget
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Text(
                            "${current?.temperature?.toInt()}°C",
                            style: const TextStyle(
                                fontSize: 56, fontWeight: FontWeight.bold),
                          ),
                          if (current?.cityName != null)
                            Text(
                              "${current?.cityName}, ${country[current?.country]}",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            ),
                          Text(
                              "${current?.maxTemperature?.toInt()}°/${current?.minTemperature?.toInt()}° feels like ${current?.feelsLike?.toInt()}°"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    // suggestions
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 72,
                              width: double.infinity,
                              child: PageView(
                                controller: controller,
                                children: [
                                  SuggestionCard(
                                      title: "Enjoy the day outdoors",
                                      subtitle: "The sky is clear"),
                                  SuggestionCard(
                                    title: "Text 2",
                                    subtitle: "text 2",
                                  ),
                                  SuggestionCard(
                                    title: "Text 3",
                                    subtitle: "text 3",
                                  ),
                                ],
                              ),
                            ),
                            SmoothPageIndicator(
                              controller: controller,
                              count: 3,
                              effect: const WormEffect(
                                dotHeight: 6,
                                dotWidth: 6,
                                dotColor: Colors.white60,
                                activeDotColor: Colors.white70,
                                paintStyle: PaintingStyle.stroke,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Placeholder(
                      child: SizedBox(
                        height: 280,
                        width: double.infinity,
                        child: Text("Hourly forecast and graph"),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GridView.count(
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
                                        "assets/images/sunrise.svg"),
                                    const Text("  SUNRISE")
                                  ],
                                ),
                                Text(
                                  "${current?.sunrise}",
                                  style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Align(
                                  alignment: Alignment.center,
                                  child: Image(
                                      fit: BoxFit.contain,
                                      image: AssetImage(
                                          "assets/images/sunrise.png")),
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
                                        "assets/images/sunset.svg"),
                                    const Text("  SUNSET")
                                  ],
                                ),
                                Text(
                                  "${current?.sunset}",
                                  style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Align(
                                  alignment: Alignment.center,
                                  child: Image(
                                      fit: BoxFit.contain,
                                      image: AssetImage(
                                          "assets/images/sunrise.png")),
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
                                    SvgPicture.asset("assets/images/rain.svg"),
                                    const Text("  PRESSURE")
                                  ],
                                ),
                                Text(
                                  "${current?.pressure} hPa",
                                  style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
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
                                    SvgPicture.asset("assets/images/wind.svg"),
                                    const Text("  WIND")
                                  ],
                                ),
                                Text(
                                  "${current?.windSpeed} km/h",
                                  style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Align(
                                  alignment: Alignment.center,
                                  child: Text("wind.svg"),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
