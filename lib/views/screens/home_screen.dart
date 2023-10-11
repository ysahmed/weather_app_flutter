import 'package:Weather/models/weather.dart';
import 'package:Weather/services/network/openweather.dart';
import 'package:Weather/views/widgets/additional_info_widget.dart';
import 'package:Weather/views/widgets/current_brief.dart';
import 'package:Weather/views/widgets/forecasts_widget.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:Weather/views/widgets/suggestion_card_widget.dart';

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
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white70,
          // appBar: AppBar(
          //   title: const Text("Weather"),
          //   backgroundColor: Color.fromARGB(0, 0, 0, 0),
          // ),
          body: FutureBuilder<Weather?>(
            future: weather,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                //error screen

                return Text("${snapshot.error}");
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                // loading screen
                return Text('Loading');
              }

              final forecast = snapshot.data?.forecast;

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
                      CurrentBrief(current: snapshot.data?.current),
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
                      // graphs and staffs
                      ForeCastsWidget(forecast: forecast),
                      const SizedBox(
                        height: 8,
                      ),
                      AdditionalInfoGrid(current: snapshot.data?.current),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
