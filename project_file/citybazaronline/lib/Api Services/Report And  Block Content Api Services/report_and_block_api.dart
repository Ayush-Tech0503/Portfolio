// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Util/Const Toster/toster.dart';
import '../../Util/Constant APi Url/api_urls.dart';
import '../../Util/constaint_textstyle.dart';
import '../../Util/constant_color.dart';


class ReportApi {
  static fetchReportBlockContentApi({context, type, typeId, reportData}) async {
    var tokenAccess;
    try {
      final preference = await SharedPreferences.getInstance();
      tokenAccess = preference.getString("access-token");

      /*-------------------------------loader----------------------------------*/
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
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
        "type": type,
        "type_id": typeId,
        "report_data": reportData
      };
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.reportContentApi}",
        options: Options(
          headers: {
            "Authorization": tokenAccess,
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
        data: json.encode(body),
      );
      Navigator.pop(context); // loader false when user comes back
      if (response.statusCode == 200) {
        //print("response login page api : --- ${response.data}");
        final responseData = json.decode(response.data);
        if (responseData['status']!='success'){
          LoadingScaffoldMessage.showSnackbar(
            context,
            'Failed to report issue. Please try again later.',
            ConstantColor.primaryMainColor,
            const Duration(seconds: 5),
          );
          Navigator.pop(context);
        }else{
          LoadingScaffoldMessage.showSnackbar(
            context,
            'Thank you for reporting\n\n issue\n $reportData\n\n if we find content to be in violation we will take action and remove it.',
            ConstantColor.primaryMainColor,
            const Duration(seconds: 10),
          );
          Navigator.pop(context);
        }
      }
      else {}
    }catch (e) {
      String errorMessage = "Oops! We couldn't report the issue. Please give it another shot later.";
      if (e is DioError && e.response != null) {
        errorMessage += " status code: ${e.response!.statusCode}";
      }
      LoadingScaffoldMessage.showSnackbar(
        context,
        errorMessage,
        ConstantColor.primaryMainColor,
        const Duration(seconds: 5),
      );
      Navigator.pop(context);
    }
  }
}
