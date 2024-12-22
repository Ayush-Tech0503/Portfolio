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
import '../../collapsing_appbar.dart';
class PassWordApiScreen {
  static fetchPassWordScreenApi({context, mobile, password}) async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();

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
              children:  [
                const CircularProgressIndicator(color: ConstantColor.primaryMainColor,),
                const SizedBox(width: 20),
                Text('Logging In...',style: ConstantTextStyle.allHomeScreenAvatarText,),
              ],
            ),
          );
        },
      );
/*-------------------------------loader----------------------------------*/

      final body = {
        "mobile": mobile, "password": password,
        "type": 'password', "device_token" : 'df',
      };
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.userOtpAndPassWordEndPoint}",
        // options: Options(
        //   headers: {
        //     "Authorization": ConstantToken.authorizationToken,
        //     'Content-Type': 'text/plain',
        //   },
        // ),
        data: json.encode(body),
      );
      Navigator.pop(context);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.data);
        if (responseData [ "status"] == "success" ) {
          String userDataJson = json.encode(responseData["data"]);
          preference.setString("user_data", userDataJson);
          preference.setString("access-token", responseData["token"]);
          preference.setString("userId", responseData["data"]["user_id"]);
          preference.setString("name", responseData["data"]["name"]);
          preference.setInt("is_seller", responseData["data"]["is_seller"]);
          preference.setString("created_date", responseData["data"]["created_date"]);
          preference.setBool("isLogin", true);
          bool isProfileCompleted = responseData["data"]["isProfileCompleted"] ?? false;
          preference.setBool("isProfileCompleted", isProfileCompleted);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>
                MyHomePageDemo1(
                  mobilenumber: mobile,
                  lat: '', longitude: '', id: '',lName: '',
                ),
              //   BottomNavigationBarScreen(
              // mobilenumber: mobile,
              // lat: '', longitude: '', id: '',lName: '',)
            ),
          );
          LoadingScaffoldMessage.showSnackbar(
            context,
            responseData['msg'],
            ConstantColor.primaryMainColor,
            const Duration(seconds: 2),
          );
        }
        else{
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
