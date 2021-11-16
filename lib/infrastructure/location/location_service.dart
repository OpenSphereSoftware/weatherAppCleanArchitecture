import 'package:location/location.dart';
import 'package:weather/infrastructure/core/exceptions.dart';

abstract class LocationService {
  /// 
  /// gets the current position of user
  /// 
  /// throws a LocationExcepiton if service is disabled or permissions are denied
  /// 
  Future<LocationData> getCurrentLocation();
}

class LocationServiceImpl implements LocationService {
  final Location location;
  LocationServiceImpl({required this.location});

  @override
  Future<LocationData> getCurrentLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        throw LocationException();
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        throw LocationException();
      }
    }

    _locationData = await location.getLocation();
    return _locationData;
  }
}
