// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/Uploaded Products Model/view_and_edit_product_model.dart';
import '../../Utils/Constant Api Routs/constant_api_routs.dart';
import '../../Utils/Theme/constant_colors.dart';
import '../../Widget/Scaffold Message/scaffold_message_widget.dart';


class ViewProductApiService {
  static Future<ViewProductModel?> fetchViewProductData({context, reqId}) async {
    String? tokenAccess;
    var baseUrl = '${ConstantUrls.baseUriApi}${ConstantUrls.viewAndEditProductEndpoint}';
    final dio = Dio();
    SharedPreferences preference = await SharedPreferences.getInstance();
    try {
      final body = {"req_id": reqId};
      tokenAccess = preference.getString("access-token");
      final response = await dio.post(
        baseUrl,
        options: Options(
          headers: {
            "Authorization": tokenAccess,
            'Content-Type': 'application/json',
          },
        ),
        data: json.encode(body),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.data);
        return ViewProductModel.fromJson(responseData);
      } else {
        return null;
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout ||
          e.type == DioExceptionType.connectionError) {
        LoadingScaffoldMessage.showSnackbar(
          context,
          "Please check your internet connection",
          ConstantColor.primaryMainColor,
          const Duration(seconds: 3),
        );
      }
      return null;
    } catch (error) {
      return null;
    }
  }
}
