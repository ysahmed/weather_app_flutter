// import 'package:Weather/services/location/location_service.dart';
import 'package:weather/views/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:location/location.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ThemeData themeData = ThemeData(
    cardTheme: const CardTheme(
      color: Color.fromARGB(255, 75, 82, 95),
    ),
    textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 56,
          color: Color.fromARGB(255, 75, 82, 95),
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(
          fontSize: 30,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          color: Color.fromARGB(255, 75, 82, 95),
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          color: Color.fromARGB(255, 75, 82, 95),
        ),
        bodySmall: TextStyle(
          color: Colors.white,
        )),
    useMaterial3: true,
  );
  // var location = LocationService.location;
  bool serviceEnabled;
  // PermissionStatus permissionGranted;
  LocationPermission permissionGranted;

  try {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      runApp(
        MaterialApp(
          theme: themeData,
          home: const LocationServiceNotEnabledScreen(),
        ),
      );
      return;
    }
  } catch (e) {
    runApp(
      MaterialApp(
        theme: themeData,
        home: const LocationServiceNotEnabledScreen(),
      ),
    );
    return;
  }

  permissionGranted = await Geolocator.checkPermission();
  if (permissionGranted == LocationPermission.denied) {
    permissionGranted = await Geolocator.requestPermission();
    if (permissionGranted == LocationPermission.denied) {
      runApp(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeData,
          home: const LocationPermissionNotGrantedScreen(),
        ),
      );
      return;
    }
  }

  if (permissionGranted == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: const LocationPermissionNotGrantedScreen(),
      ),
    );
    return;
  }

  // try {
  //   serviceEnabled = await location.serviceEnabled();
  //   if (!serviceEnabled) {
  //     serviceEnabled = await location.requestService();
  //     if (!serviceEnabled) {
  //       runApp(
  //         const MaterialApp(
  //           home: LocationServiceNotEnabledScreen(),
  //         ),
  //       );
  //       return;
  //     }
  //   }
  // } catch (e) {
  //   runApp(
  //     const MaterialApp(
  //       home: LocationServiceNotEnabledScreen(),
  //     ),
  //   );
  //   return;
  // }

  // permissionGranted = await location.hasPermission();
  // if (permissionGranted == PermissionStatus.denied) {
  //   permissionGranted = await location.requestPermission();
  //   if (permissionGranted != PermissionStatus.granted) {
  //     runApp(
  //       const MaterialApp(
  //         home: LocationPermissionNotGrantedScreen(),
  //       ),
  //     );
  //     return;
  //   }
  // }

  runApp(MaterialApp(
    title: 'Weather',
    debugShowCheckedModeBanner: false,
    theme: themeData,
    home: const HomeScreen(),
  ));
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
