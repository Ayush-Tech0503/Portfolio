// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utils/Theme/constant_colors.dart';
import '../../../Widget/Loaders/Loader_title_widget.dart';
import '../../../Widget/Scaffold Message/scaffold_message_widget.dart';

Future<void> fetchSellerRegistrationBodyApi({
  required BuildContext context,
  required String baseUrl,
  required Map<String, dynamic> body,
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
          'Content-Type': 'application/json',
        },
      ),
      data: json.encode(body),
    );
    print("body-----${body}");
    Navigator.pop(context);
    if (response.statusCode == 200) {
      final responseData = json.decode(response.data.toString());
      if (responseData["status"] == "success") {
        await onSuccess();
        LoadingScaffoldMessage.showSnackbar(
          context,
          //"Update Successful",
          responseData['msg'],
          Colors.green,
          const Duration(seconds: 2),
        );
      } else {
        LoadingScaffoldMessage.showSnackbar(
          context, "Something went wrong. Please try again later.",
          ConstantColor.primaryMainColor,
          const Duration(seconds: 2),
        );
      }
    }
    else {
      LoadingScaffoldMessage.showSnackbar(
        context,
        "Response StatusCode ${response.statusCode} - Something went wrong. Please try again later.",
        ConstantColor.primaryMainColor,
        const Duration(seconds: 2),
      );
    }
  } on DioError catch (e) {
    if (e.type == DioErrorType.connectionTimeout || e.type == DioErrorType.receiveTimeout || e.type == DioErrorType.sendTimeout || e.type == DioExceptionType.connectionError) {
      // Handle Dio errors
      Navigator.pop(context);
      LoadingScaffoldMessage.showSnackbar(
        context, "Network error. Please check your internet connection.",
        ConstantColor.primaryMainColor,
        const Duration(seconds: 3),
      );
    }
  } catch (error) {
    LoadingScaffoldMessage.showSnackbar(
      context, "Server error. Something went wrong, please try again later!",
      ConstantColor.primaryMainColor,
      const Duration(seconds: 2),
    );
  }
}