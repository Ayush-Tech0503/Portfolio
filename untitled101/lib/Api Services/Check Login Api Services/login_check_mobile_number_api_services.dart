// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../Util/Const Toster/toster.dart';
import '../../Util/Constant APi Url/api_urls.dart';
import '../../Util/constaint_textstyle.dart';
import '../../Util/constant_color.dart';
import '../../Widgets/Login Check Widget/login_check_otp_widget.dart';
import '../../Widgets/Login Check Widget/login_check_password_widget.dart';
import 'login_check_resent_otp_api_services.dart';

class CheckLoginFetchLoginApi {
  static fetchLoginScreenApi({context,mobileController, otpController}) async {
    try {
/*-------------------------------loader----------------------------------*/
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
            ),
            content: Row(
              children: [
                const CircularProgressIndicator(
                  color: ConstantColor.primaryMainColor,
                ),
                const SizedBox(width: 20),
                Text(
                  'Logging In...',
                  style: ConstantTextStyle.allHomeScreenAvatarText,
                ),
              ],
            ),
          );
        },
      );
/*-------------------------------loader----------------------------------*/
      final body = {
        "mobile": mobileController.text,
      };
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.userLoginWithMobileEndPoint}",
        data: json.encode(body),
      );
      Navigator.pop(context); // loader false when user come back
      if (response.statusCode == 200) {
        final responseData = json.decode(response.data.toString());
        Navigator.of(context).pop();
        if (responseData["password"] == true && responseData['msg'] == "Login success!") {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return CheckIsLoginPasswordScreen(mobilenumber: mobileController.text.toString());},
          );
        }
        else if (responseData["password"] == false && responseData['msg'] == "Login success!") {
          //***********If password is false then Api Hit******************/
          if (responseData['msg'] != "Register first")  {
            await CheckOtpApiScreen.sendOtpScreenApi(
              context: context,
              mobile: mobileController.text.toString(),
            );
          }
        }
        else {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return CheckIsLoginOtpScreen(
                  mobilenumber: mobileController.text.toString(),
                  responseStatus: responseData['msg']
              );
            },
          );
          LoadingScaffoldMessage.showSnackbar(
            context,
            responseData['msg'],
            ConstantColor.primaryMainColor,
            const Duration(seconds: 2),
          );
        }
      }
    } catch (error) {
      if (error is DioError) {
        if (error.response?.statusCode == 500) {
          // Handle 500 error
          LoadingScaffoldMessage.showSnackbar(
            context,
            "${error.message}",
            ConstantColor.primaryMainColor,
            const Duration(seconds: 3),
          );
        } else {
          // print("Dio error: ${error.message}");
        }
      } else {}
      Navigator.pop(context);
    }
  }
}