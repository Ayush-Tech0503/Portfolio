// // ignore_for_file: use_build_context_synchronously
// ignore_for_file: use_build_context_synchronously, empty_catches

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';

Future<String> saveDeviceIdToSharedPreferences(BuildContext context) async {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String deviceId = "unknown"; // Provide an initial or default value

  try {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      final iosDeviceInfo = await deviceInfo.iosInfo;
      deviceId = iosDeviceInfo.identifierForVendor ?? "unknown";
    } else if (Theme.of(context).platform == TargetPlatform.android) {
      final androidDeviceInfo = await deviceInfo.androidInfo;
      deviceId = androidDeviceInfo.id ?? "unknown";
    }

    await prefs.setString('deviceId', deviceId);
    // print('Device ID fetched and stored: $deviceId');
  } catch (e) {}

  return deviceId;
}
