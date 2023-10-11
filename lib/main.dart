import 'package:Weather/services/location/location_service.dart';
import 'package:Weather/views/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:location/location.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var location = LocationService.location;
  bool serviceEnabled;
  PermissionStatus permissionGranted;

  try {
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        runApp(
          const MaterialApp(
            home: LocationServiceNotEnabledScreen(),
          ),
        );
        return;
      }
    }
  } catch (e) {
    runApp(
      const MaterialApp(
        home: LocationServiceNotEnabledScreen(),
      ),
    );
    return;
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      runApp(
        const MaterialApp(
          home: LocationPermissionNotGrantedScreen(),
        ),
      );
      return;
    }
  }

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const colorPrimary = Color.fromARGB(255, 75, 82, 95);
    const colorAccent = Colors.white;
    return MaterialApp(
      title: 'Weather',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        cardTheme: const CardTheme(
          color: colorPrimary,
        ),
        textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontSize: 56,
              color: colorPrimary,
              fontWeight: FontWeight.bold,
            ),
            headlineSmall: TextStyle(
              fontSize: 30,
              color: colorAccent,
              fontWeight: FontWeight.bold,
            ),
            titleLarge: TextStyle(
              fontSize: 20,
              color: colorPrimary,
              fontWeight: FontWeight.w400,
            ),
            bodyMedium: TextStyle(
              fontSize: 16,
              color: colorPrimary,
            ),
            bodySmall: TextStyle(
              color: colorAccent,
            )),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class LocationServiceNotEnabledScreen extends StatelessWidget {
  const LocationServiceNotEnabledScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Service Not Enabled'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Please enable location services to use this app.'),
            ElevatedButton(
              onPressed: () {
                main();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class LocationPermissionNotGrantedScreen extends StatelessWidget {
  const LocationPermissionNotGrantedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Permission Not Granted'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Please grant location permission to use this app.'),
            ElevatedButton(
              onPressed: () {
                // Try to request location permission again
                main();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
