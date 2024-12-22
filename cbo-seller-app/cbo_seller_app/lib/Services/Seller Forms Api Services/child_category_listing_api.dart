// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/Shop Info Preview Model/child_category_listing_model.dart';
import '../../Utils/Constant Api Routs/constant_api_routs.dart';
import '../../Utils/Theme/constant_colors.dart';
import '../../Widget/Scaffold Message/scaffold_message_widget.dart';
class ApiChildCatListingService {
  static Future<CatCheckBoxListModel?> fetchChildCatListingData({context, categoryId}) async {
    String? tokenAccess;
    final dio = Dio();
    var baseUrl = '${ConstantUrls.baseUriApi}${ConstantUrls.catCheckBoxApi}';
    SharedPreferences preference = await SharedPreferences.getInstance();
    try {
      final body = {"category_id": categoryId};
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
        return CatCheckBoxListModel.fromJson(responseData);
      }
      else {
        LoadingScaffoldMessage.showSnackbar(
          context, "something went wrong try after some time.",
          ConstantColor.primaryMainColor,
          const Duration(seconds: 2),
        );
        return null;
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout || e.type == DioErrorType.receiveTimeout || e.type == DioErrorType.sendTimeout || e.type == DioExceptionType.connectionError) {
        // Handle connection error
        LoadingScaffoldMessage.showSnackbar(
          context, "Please check your internet connection",
          ConstantColor.primaryMainColor,
          const Duration(seconds: 3),
        );
      }
      return null;
    } catch (error) {
      LoadingScaffoldMessage.showSnackbar(
        context,
        "Something went wrong, please try again later!",
        ConstantColor.primaryMainColor,
        const Duration(seconds: 2),
      );
      return null;
    }
  }
}
