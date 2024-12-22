// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:convert';
import 'package:citybazaronline_seller_app/Utils/Theme/constant_colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Widget/Scaffold Message/scaffold_message_widget.dart';
import '../../Utils/Constant Api Routs/constant_api_routs.dart';


Future<void> fetchUploadImageData({context,
  required FormData formData,
  required Function(String) onSuccess,
}) async {
  String? tokenAccess;
  var baseUrl = '${ConstantUrls.baseUriApi}${ConstantUrls.uploadImageEndpoint}';
  try {
    SharedPreferences preference = await SharedPreferences.getInstance();
    tokenAccess = preference.getString("access-token");

    final response = await Dio().post(
      baseUrl,
      options: Options(
        headers: {
          "Authorization": tokenAccess,
          'Content-Type': 'application/json', // Adjust content type as needed
        },
      ),
      data: formData,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.data);
      String imageUrlLink = responseData["data"]["url"];
      // Call success callback with the URL
      onSuccess(imageUrlLink);
    } else {}
  } on DioError catch (e) {
    if (e.type == DioErrorType.connectionTimeout || e.type == DioErrorType.receiveTimeout || e.type == DioErrorType.sendTimeout || e.type == DioExceptionType.connectionError) {
      LoadingScaffoldMessage.showSnackbar(
        context,
        "Network error. Please check your internet connection.",
        Colors.red,
        const Duration(seconds: 3),
      );
    }
    if (e.response?.statusCode == 413) {
      LoadingScaffoldMessage.showSnackbar(
        context, "Payload too large. Please upload a smaller file.",
        ConstantColor.primaryMainColor,
        const Duration(seconds: 2),
      );
      // Handle 413 error specifically
    } else {// Handle other Dio error
       }
  }
}



