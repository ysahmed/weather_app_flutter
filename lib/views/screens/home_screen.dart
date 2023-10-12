import 'package:weather/models/weather.dart';
import 'package:weather/services/network/openweather.dart';
import 'package:weather/views/screens/search_city_screen.dart';
import 'package:weather/views/widgets/portrait_body.dart';
import 'package:weather/views/widgets/tab_landscape.dart';
import 'package:flutter/material.dart';

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
        child: FutureBuilder(
          future: weather,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              //error screen
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${snapshot.error}"),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              weather = OpenWeather.getData();
                            });
                          },
                          icon: const Icon(Icons.refresh))
                    ],
                  ),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              // loading screen
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            }

            return Scaffold(
                extendBodyBehindAppBar: true,
                backgroundColor: Colors.white70,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  scrolledUnderElevation: 0,
                  elevation: 0,
                  leadingWidth: double.maxFinite,
                  leading: Row(
                    children: [
                      IconButton(
                          onPressed: () async {
                            final String city = await showSearch(
                              context: context,
                              delegate: SearchCityScreen(),
                            );
                            if (city.isNotEmpty) {
                              setState(() {
                                weather = OpenWeather.getData(city);
                              });
                            }
                          },
                          icon: const Icon(Icons.search)),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              weather = OpenWeather.getData();
                            });
                          },
                          icon: const Icon(Icons.refresh)),
                    ],
                  ),
                  // actions: [
                  //   IconButton(
                  //       onPressed: () async {
                  //         String city = await showSearch(
                  //           context: context,
                  //           delegate: SearchCityScreen(),
                  //         );
                  //         if (city.isNotEmpty) {
                  //           setState(() {
                  //             weather = OpenWeather.getData(city);
                  //           });
                  //         }
                  //       },
                  //       icon: const Icon(Icons.search)),
                  //   IconButton(
                  //       onPressed: () {
                  //         setState(() {
                  //           weather = OpenWeather.getData();
                  //         });
                  //       },
                  //       icon: const Icon(Icons.refresh)),
                  // ],
                ),
                body: LayoutBuilder(
                  builder: (context, constraints) {
                    return OrientationBuilder(
                      builder: (context, orientation) {
                        if (orientation == Orientation.landscape) {
                          if (constraints.maxWidth < 960) {
                            return PortraitBody(
                                current: snapshot.data?.current,
                                forecast: snapshot.data?.forecast);
                          }

                          return TabLandscapeBody(
                            current: snapshot.data?.current,
                            forecast: snapshot.data?.forecast,
                          );
                        } else {
                          return PortraitBody(
                              current: snapshot.data?.current,
                              forecast: snapshot.data?.forecast);
                        }
                      },
                    );
                  },
                ));
          },
        ),
      ),
    );
  }
}
