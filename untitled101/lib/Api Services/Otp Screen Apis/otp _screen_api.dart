//ignore_for_file: use_build_context_synchronously, empty_catches

import 'dart:convert';
import 'package:Citybazar_app/Layouts/Onboarding%20Screens/otp_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../Util/Constant APi Url/api_urls.dart';
import '../../Util/constaint_textstyle.dart';
import '../../Util/constant_color.dart';
class OtpApiScreen {
  static sendOtpScreenApi({context,mobile}) async {
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
      final body = {"mobile": mobile};
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.userOtpEndPoint}",
        data: json.encode(body),
      );
      Navigator.pop(context); // loader false when user come back
      if (response.statusCode == 200) {
        final responseData = json.decode(response.data);
        if (responseData ["status"] == "success" &&  responseData ["msg"] == "OTP sent successfully") {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  OtpScreen(
              mobilenumber: mobile,
              responseStatus:responseData["status"]
          ),),);
        } else{

        }
      }
    } catch (e) {
    }
  }
}


