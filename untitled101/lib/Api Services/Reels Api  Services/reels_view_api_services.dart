// ignore_for_file: prefer_typing_uninitialized_variables, empty_catches

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Util/Constant APi Url/api_urls.dart';

class ReelsViewApi {
  static fetchViewReelsApi({reelId}) async {
    var tokenAccess;
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      tokenAccess = preference.getString("access-token");
      final body =  {"reel_id":reelId};
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi2}${ConstantUrls.addViewReelsApi}",
        options: Options(
          headers: {
            "Authorization": tokenAccess,
            'Content-Type': 'application/json',
          },
        ),
        data: json.encode(body),
      );
      if (response.statusCode == 200) {} else {}
    } catch (error) {}
  }
}