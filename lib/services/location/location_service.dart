import 'package:location/location.dart';

class LocationService {
  LocationService._();
  static final Location _location = Location();

  static Location get location {
    _location.changeSettings(accuracy: LocationAccuracy.high);
    return _location;
  }
}
