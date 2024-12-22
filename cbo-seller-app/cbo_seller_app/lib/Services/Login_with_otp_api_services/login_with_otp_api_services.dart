//ignore_for_file: use_build_context_synchronously, empty_catches, deprecated_member_use

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../Screen/OTP Screen/otp_screen.dart';
import '../../Utils/Constant Api Routs/constant_api_routs.dart';
import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';
import '../../Widget/Scaffold Message/scaffold_message_widget.dart';


sendOtpScreenApi({context,mobile}) async {
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
    Navigator.pop(context);
    if (response.statusCode == 200) {
      final responseData = json.decode(response.data);
      if (responseData ["status"] == "success" &&  responseData ["msg"] == "OTP sent successfully") {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  OtpScreen(
            mobilenumber: mobile,
            responseStatus:responseData["status"]
        ),),);

        LoadingScaffoldMessage.showSnackbar(
          context,
          responseData['msg'],
          ConstantColor.primaryMainColor,
          const Duration(seconds: 2),
        );
      } else{
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
    // Navigator.pop(context);
  }
}



