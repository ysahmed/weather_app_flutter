class City {
  final String _city;
  final String _country;
  final String _state;
  final Coord _coord;

  String get city => _city;
  String get country => _country;
  String get state => _state;
  Coord get coord => _coord;

  City({
    required city,
    required country,
    required state,
    required lat,
    required lon,
  })  : _city = city,
        _country = country,
        _state = state,
        _coord = Coord(lat: lat, lon: lon);

  @override
  String toString() => "{city: $_city state: $_state country: $_country}";
}

class Coord {
  final double _lat;
  final double _lon;

  double get lat => _lat;
  double get lon => _lon;

  Coord({
    required lat,
    required lon,
  })  : _lat = lat,
        _lon = lon;

  @override
  String toString() => "{lat: $_lat lon: $_lon}";
}
