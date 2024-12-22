// ignore_for_file: empty_catches

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../Util/Constant APi Url/api_urls.dart';
import '../../Util/constaint_textstyle.dart';
import '../../Util/constant_color.dart';
import '../../Widgets/Login Check Widget/login_check_otp_widget.dart';

class CheckOtpApiScreen {
  static sendOtpScreenApi({context, mobile}) async {
    try {
/*-------------------------------loader----------------------------------*/
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
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
      final body = {"mobile": mobile};
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.userOtpEndPoint}",
        data: json.encode(body),
      );
      // loader false when user come back
      Navigator.pop(context);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.data);
        if (responseData["status"] == "success" && responseData["msg"] == "OTP sent successfully") {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return CheckIsLoginOtpScreen(
                    mobilenumber: mobile,
                    responseStatus: responseData["status"]
                );
              }
          );
        } else {
        }
      }
    } catch (e) {}
  }
}