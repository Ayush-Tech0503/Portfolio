// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

Future<String> getCurrentLocation(BuildContext context) async {
  try {
    // Check and request location permission
//     var status = await Permission.location.request();
// print('statusstatusstatus----$status');
//     if (status.isDenied || status.isPermanentlyDenied) {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      Platform.isIOS ?
      showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: const Text("Location Permission Denied"),
          content: const Text("Please enable location access in settings to use this feature."),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ): showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Location Permission Denied"),
          content: const Text("Please enable location access in settings to use this feature."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
      return "Location permission denied";
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    final latitude = position.latitude;
    final longitude = position.longitude;

    // Perform reverse geocoding to get the location address
    final placemarks = await placemarkFromCoordinates(latitude, longitude);

    if (placemarks.isNotEmpty) {
      final placemark = placemarks[0];
      final address = "${placemark.street}, ${placemark.subLocality}, ${placemark.postalCode}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country ?? ''}";
      return address;
    } else {
      return "Location not found";
    }
  } catch (e) {
    return "Error getting location: $e";
  }
}
