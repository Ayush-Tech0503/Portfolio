import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';

Future<Map<String, String>> getCurrentLocation() async {
  try {
    if (await Permission.location.isGranted) {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark firstPlacemark = placemarks.first;
      double latitude = position.latitude;
      double longitude = position.longitude;

      String fullAddress = "${firstPlacemark.street}, ${firstPlacemark.subLocality}, "
          "${firstPlacemark.locality}, ${firstPlacemark.administrativeArea} "
          "${firstPlacemark.postalCode}, ${firstPlacemark.country}";
      return {
        'fullAddress': fullAddress??"please try again after some time",
        'latitude': latitude.toString() ?? '0.0',
        'longitude': longitude.toString() ?? '0.0',
        'city': placemarks.first.locality ?? 'Unknown',
        'pincode': placemarks.first.postalCode ?? 'Unknown',
        'state': placemarks.first.administrativeArea ?? 'Unknown',
        'country': placemarks.first.country ?? 'Unknown',
      };
    } else {
      // If permissions are not granted, request them
      await Permission.location.request();
      // After requesting permissions, try fetching location again
      return await getCurrentLocation();
    }
  } catch (e) {
    return {
      'city': 'Unknown',
      'pincode': 'Unknown',
      'state': 'Unknown',
      'country': 'Unknown',
    };
  }
}
