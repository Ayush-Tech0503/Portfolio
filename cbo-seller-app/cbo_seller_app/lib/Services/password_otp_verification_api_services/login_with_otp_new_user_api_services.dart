// ignore_for_file: empty_catches, deprecated_member_use

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utils/Constant Api Routs/constant_api_routs.dart';
import '../../../Utils/Font Style/text_styles.dart';
import '../../../Utils/Theme/constant_colors.dart';
import '../../../Widget/Scaffold Message/scaffold_message_widget.dart';

fetchNewUserOtpVerifyApi({context, body}) async {
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

    final response = await Dio().post(
      "${ConstantUrls.baseUriApi}${ConstantUrls.userNewUserLoginEndPoint}",
      data: json.encode(body),
    );
    Navigator.pop(context);
    if (response.statusCode == 200) {
      final responseData = json.decode(response.data);
      if (responseData [ "status"] == "success" ) {
        preference.setBool("isLogin", true);
        preference.setString("access-token", responseData["token"]);
        preference.setString("created_date", responseData["data"]["created_date"]);
        preference.setString("userId", responseData["data"]["user_id"]);
        String? name = responseData["data"]["name"];
        if (name != null && name.isNotEmpty) {preference.setString("name", name);} else {preference.setString("name", "");}
        bool isProfileCompleted = responseData["data"]["isProfileCompleted"] ?? false;
        preference.setBool("isProfileCompleted", isProfileCompleted);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) =>
        //       MyHomePageDemo1(
        //         mobilenumber: mobile,
        //         lat: '', longitude: '', id: '',lName: '',
        //       ),
        //
        //   ),
        // );
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
  } catch (error) {
    if (error is DioError) {
      if (error.type == DioErrorType.connectionError) {
        // Handle connection error
        LoadingScaffoldMessage.showSnackbar(
          context,
          "Please check your internet connection",
          ConstantColor.primaryMainColor,
          const Duration(seconds: 3),
        );
      }
    }
  }
}
