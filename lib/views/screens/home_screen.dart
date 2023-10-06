import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather_app_flutter/views/widgets/suggestion_card.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController controller = PageController();

  @override
  void initState() {
    controller = PageController(viewportFraction: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          // image: NetworkImage(
          //     "https://images.unsplash.com/photo-1594652010347-788d009508c3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE1fHx8ZW58MHx8fHx8&w=1000&q=80"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white70,
        // appBar: AppBar(
        //   title: const Text("Weather"),
        //   backgroundColor: Color.fromARGB(0, 0, 0, 0),
        // ),
        body: SingleChildScrollView(
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
                        "24°C",
                        style: TextStyle(
                            fontSize: 56, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "City, Country",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                      Text("25°/18° feels like 22°"),
                    ],
                  ),
                ),
                SizedBox(
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
                          effect: WormEffect(
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
                SizedBox(
                  height: 10,
                ),
                Placeholder(
                  child: SizedBox(
                    height: 280,
                    width: double.infinity,
                    child: Text("Hourly forecast and graph"),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                GridView.count(
                  childAspectRatio: 1,
                  crossAxisCount: 2,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: 8),
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
                                SvgPicture.asset("assets/images/sunrise.svg"),
                                const Text("  SUNRISE")
                              ],
                            ),
                            Text(
                              "5:59 AM",
                              style: TextStyle(
                                  fontSize: 36, fontWeight: FontWeight.bold),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Image(
                                  fit: BoxFit.contain,
                                  image:
                                      AssetImage("assets/images/sunrise.png")),
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
                                SvgPicture.asset("assets/images/sunset.svg"),
                                const Text("  SUNSET")
                              ],
                            ),
                            Text(
                              "5:59 AM",
                              style: TextStyle(
                                  fontSize: 36, fontWeight: FontWeight.bold),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Image(
                                  fit: BoxFit.contain,
                                  image:
                                      AssetImage("assets/images/sunrise.png")),
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
                                const Text("  RAINFALL")
                              ],
                            ),
                            Text(
                              "5:59 AM",
                              style: TextStyle(
                                  fontSize: 36, fontWeight: FontWeight.bold),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Image(
                                  fit: BoxFit.contain,
                                  image:
                                      AssetImage("assets/images/sunrise.png")),
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
                              "5:59 AM",
                              style: TextStyle(
                                  fontSize: 36, fontWeight: FontWeight.bold),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Image(
                                  fit: BoxFit.contain,
                                  image:
                                      AssetImage("assets/images/sunrise.png")),
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
        ),
      ),
    );
  }
}
