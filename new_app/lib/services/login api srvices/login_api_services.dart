// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../Screen/OTP Screen/otp_screen.dart';
import '../../Utils/Constant Api Routs/constant_api_routs.dart';
import '../../Utils/Page Name Route/page_routes.dart';
import '../../Utils/Theme/constant_colors.dart';
import '../../Widget/Loaders/Loader_title_widget.dart';
import '../../Widget/Scaffold Message/scaffold_message_widget.dart';
import '../Login_with_otp_api_services/login_with_otp_api_services.dart';

fetchLoginScreenApi({context, required TextEditingController mobileController}) async {
    try {
/*-------------------------------loader----------------------------------*/
      showLoggingInDialog(context:context);
/*-------------------------------loader----------------------------------*/
      final body = {"mobile": mobileController.text.toString(),};
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.userLoginWithMobileEndPoint}",
        data: json.encode(body),
      );
      Navigator.pop(context); // loader false when user comes back
      if (response.statusCode == 200) {
        final responseData = json.decode(response.data);
        if (responseData["password"] == true &&
            responseData['msg'] == "Login success!") {

          Navigator.pushNamed(context, ScreenRoutes.passwordScreen, arguments: mobileController.text.toString(), );

        } else if (responseData["password"] == false && responseData['msg'] == "Login success!") {
          //***********If password is false then Api Hit******************/
          if (responseData['msg'] != "Register first") {
            await sendOtpScreenApi(
              context: context,
              mobile: mobileController.text.toString(),
            );
          }
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  OtpScreen(
              mobilenumber: mobileController.text.toString(),
              responseStatus:responseData["msg"]
          ),),);
          // Navigator.pushNamed(
          //   context,
          //   ScreenRoutes.otpScreen,
          //   arguments: {
          //     "mobilenumber": mobileController.text.toString(),
          //     "responseStatus": responseData["msg"]
          //   },
          // );
          LoadingScaffoldMessage.showSnackbar(
            context,
            responseData['msg'],
            ConstantColor.primaryMainColor,
            const Duration(seconds: 2),
          );
        }
      }
    }

    catch (error) {
      if (error is DioError) {
        if (error.type == DioErrorType.connectionError || error.type == DioErrorType.connectionTimeout ||
            error.type == DioErrorType.receiveTimeout || error.type == DioErrorType.sendTimeout) {
          // Handle connection error
          LoadingScaffoldMessage.showSnackbar(
            context,
            "Please check your internet connection",
            ConstantColor.primaryMainColor,
            const Duration(seconds: 3),
          );
        } else if (error.response?.statusCode == 500) {
          // Handle 500 error
          LoadingScaffoldMessage.showSnackbar(
            context,
            "${error.message}",
            ConstantColor.primaryMainColor,
            const Duration(seconds: 3),
          );
        } else {
          // Handle other Dio errors
          // print("Dio error: ${error.message}");
        }
      } else {
        // Handle other types of errors
      }
      // setState(() {});
      Navigator.pop(context);
    }
}
