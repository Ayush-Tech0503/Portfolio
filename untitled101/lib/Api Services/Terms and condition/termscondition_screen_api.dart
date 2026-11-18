// ignore_for_file: empty_catches

import 'dart:convert';
import 'package:dio/dio.dart';
import '../../Util/Constant APi Url/api_urls.dart';
import '../../Util/constant_token.dart';
class TermsAndConditionDataScreen {
  static fetchTermsAndConditionApi({responseData}) async {
    try {
      //final prefs = await SharedPreferences.getInstance();
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.loadTermsAndConditionApi}",
        options: Options(
          headers: {
            "Authorization": ConstantToken.authorizationToken,
            'Content-Type': 'text/plain',
          },
        ),
      );
      // loader false when user come back
      if (response.statusCode == 200) {
         responseData = json.decode(response.data);
      }
    } catch (e) {
    }
  }
}