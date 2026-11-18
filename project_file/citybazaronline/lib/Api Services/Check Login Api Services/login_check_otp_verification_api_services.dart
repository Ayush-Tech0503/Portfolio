// ignore_for_file: empty_catches
import 'dart:convert';
import 'package:Citybazar_app/Util/constant_token.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Util/Const Toster/toster.dart';
import '../../Util/Constant APi Url/api_urls.dart';
import '../../Util/constaint_textstyle.dart';
import '../../Util/constant_color.dart';

class VerifyOldCheckLoginOTPApi {
  static fetchOtpPassWordScreenApi({context, mobile, otp}) async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
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
      final body = {
        "mobile": mobile,
        "password": otp,
        "type": 'otp',
        "device_token": 'df'
      };
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.userOtpAndPassWordEndPoint}",
        options: Options(
          headers: {
            "Authorization": ConstantToken.authorizationToken,
            'Content-Type': 'application/json',
          },
        ),
        data: json.encode(body),
      );
      Navigator.pop(context);
      if (response.statusCode == 200) {
        var responseData = json.decode(response.data);
        if (responseData["status"] == "success") {
          preference.setString("access-token", responseData["token"]);
          preference.setString(
              "created_date", responseData["data"]["created_date"]);
          preference.setString("userId", responseData["data"]["user_id"]) ?? "";
          String? name = responseData["data"]["name"];
          if (name != null && name.isNotEmpty) {
            preference.setString("name", name);
          } else {
            preference.setString("name", "");
          }
          // preference.setString("name", responseData["data"]["name"]);
          preference.setInt("is_seller", responseData["data"]["is_seller"]);
          preference.setBool("isLogin", true);
          bool isProfileCompleted =
              responseData["data"]["isProfileCompleted"] ?? false;
          preference.setBool("isProfileCompleted", isProfileCompleted);
          Navigator.pop(context);
          LoadingScaffoldMessage.showSnackbar(
            context,
            responseData['msg'],
            ConstantColor.primaryMainColor,
            const Duration(seconds: 2),
          );
        } else {
          LoadingScaffoldMessage.showSnackbar(
            context,
            responseData['msg'],
            ConstantColor.primaryMainColor,
            const Duration(seconds: 2),
          );
        }
      }
    } catch (e) {
      LoadingScaffoldMessage.showSnackbar(
        context,
        'An error occurred. Please try again later.',
        ConstantColor.primaryMainColor,
        const Duration(seconds: 2),
      );
    }
  }
}

//----------------------------------------------------

class VerifyNewCheckLoginOTPApi {
  static fetchNewUserLoginScreenApi({context, mobile, otp}) async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
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
      final body = {"mobile": mobile, "otp": otp, "device_token": "sdf"};
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.userNewUserLoginEndPoint}",
        options: Options(
          headers: {
            "Authorization": ConstantToken.authorizationToken,
            'Content-Type': 'application/json',
          },
        ),
        data: json.encode(body),
      );
      Navigator.pop(context);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.data);
        if (responseData["status"] == "success") {
          preference.setBool("isLogin", true);
          preference.setString("access-token", responseData["token"]);
          preference.setString(
              "created_date", responseData["data"]["created_date"]);
          preference.setString("userId", responseData["data"]["user_id"]);
          String? name = responseData["data"]["name"];
          if (name != null && name.isNotEmpty) {
            preference.setString("name", name);
          } else {
            preference.setString("name", "");
          }
          //  // preference.setString("name", responseData["data"]["name"]);
          //  preference.setInt("is_seller", responseData["data"]["is_seller"]);
          //  preference.setString("sellerID", responseData["data"]["sid"]);
          bool isProfileCompleted =
              responseData["data"]["isProfileCompleted"] ?? false;
          preference.setBool("isProfileCompleted", isProfileCompleted);
          Navigator.pop(context);
          LoadingScaffoldMessage.showSnackbar(
            context,
            responseData['msg'],
            ConstantColor.primaryMainColor,
            const Duration(seconds: 2),
          );
        } else {
          LoadingScaffoldMessage.showSnackbar(
            context,
            responseData['msg'],
            ConstantColor.primaryMainColor,
            const Duration(seconds: 2),
          );
        }
      }
    } catch (e) {}
  }
}
