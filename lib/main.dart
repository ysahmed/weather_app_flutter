import 'package:Weather/services/location/location_service.dart';
import 'package:Weather/views/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:location/location.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Location location = LocationService.location;
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
  } on Exception catch (e) {
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
    return MaterialApp(
      title: 'Weather',
      theme: ThemeData(
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
