// ignore_for_file: non_constant_identifier_names, empty_catches, deprecated_member_use

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Util/Const Toster/toster.dart';
import '../../Util/Constant APi Url/api_urls.dart';
import '../../Util/constant_color.dart';

class FollowUnFollow {
  static fetchFollowUnFollow({context, sIds, follow_val,tokenAccess}) async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      tokenAccess = preference.getString("access-token");
      final body = {
        "seller_id":sIds,"follow_val":follow_val
      };
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi2}${ConstantUrls.sellerFollowUnFollow}",
        options: Options(
          headers: {
            "Authorization": tokenAccess,
            'Content-Type': 'application/json',
          },
        ),
        data: json.encode(body),
      );
      if (response.statusCode == 200) {
        var responseData = json.decode(response.data.toString());
          LoadingScaffoldMessage.showSnackbar(
            context,
            responseData['msg'],
            ConstantColor.primaryMainColor,
            const Duration(seconds: 1),
          );
      } else {}
    } catch (e) {
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
    }
  }
}