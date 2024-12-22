// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widget/Loaders/Loader_title_widget.dart';
import '../../Widget/Scaffold Message/scaffold_message_widget.dart';

Future<void> fetchSubmitReelVideoData({
  required BuildContext context,
  required String baseUrl,
  required FormData formData,
  required Function onSuccess,
}) async {
  String? tokenAccess;
  try {
    showLoggingInDialog(context: context, title: 'Loading Please Wait!!');

    SharedPreferences preference = await SharedPreferences.getInstance();
    tokenAccess = preference.getString("access-token");

    final response = await Dio().post(
      baseUrl,
      options: Options(
        headers: {
          "Authorization": tokenAccess,
          'content-type': 'multipart/form-data'
          // You should set the content-type header to 'multipart/form-data' automatically by Dio when using FormData
        },
      ),
      data: formData,
    );
    Navigator.pop(context);
    if (response.statusCode == 200) {
      final responseData = json.decode(response.data.toString());
      if (responseData["status"] == "success") {
        await onSuccess();
        LoadingScaffoldMessage.showSnackbar(
          context,
          responseData['msg'],
          Colors.green,
          const Duration(seconds: 2),
        );
      } else {
        LoadingScaffoldMessage.showSnackbar(
          context,
          "Something went wrong. Please try again later.",
          Colors.red,
          const Duration(seconds: 2),
        );
      }
    } else {
      LoadingScaffoldMessage.showSnackbar(
        context,
        "Response StatusCode ${response.statusCode} - Something went wrong. Please try again later.",
        Colors.red,
        const Duration(seconds: 2),
      );
    }
  } on DioError catch (e) {
    if (e.type == DioErrorType.connectionTimeout ||
        e.type == DioErrorType.receiveTimeout ||
        e.type == DioErrorType.sendTimeout ||
        e.type == DioExceptionType.connectionError) {
      // Handle Dio errors
      LoadingScaffoldMessage.showSnackbar(
        context,
        "Network error. Please check your internet connection.",
        Colors.red,
        const Duration(seconds: 3),
      );
    }
  } catch (error) {
    LoadingScaffoldMessage.showSnackbar(
      context,
      "Server error. Something went wrong, please try again later!",
      Colors.red,
      const Duration(seconds: 2),
    );
  }
}
