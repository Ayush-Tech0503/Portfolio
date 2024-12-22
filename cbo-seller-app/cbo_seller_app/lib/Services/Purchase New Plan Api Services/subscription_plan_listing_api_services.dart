
// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/Purchase New Plan Model/subscription_plan_listing_model.dart';
import '../../Utils/Constant Api Routs/constant_api_routs.dart';
import '../../Utils/Theme/constant_colors.dart';
import '../../Widget/Scaffold Message/scaffold_message_widget.dart';


class ApiSubPlanListService {
  static Future<SubscriptionPlanListModels?> fetchSubPlanListData({context}) async {
    String? tokenAccess;
    String? sellerId;
    var baseUrl = '${ConstantUrls.baseUriApi}${ConstantUrls.subscriptionPlanListingEndPoint}';
    final dio = Dio();
    SharedPreferences preference = await SharedPreferences.getInstance();
    try {
      tokenAccess = preference.getString("access-token");
      sellerId = preference.getString("seller_id");
      final body = {"seller_id":sellerId};
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
      print("body-------${body}");
      print("tokenAccess-------${tokenAccess}");
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.data);
        return SubscriptionPlanListModels.fromJson(responseData);
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

  //------new api purchase plan
  static Future<dynamic?> fetchSubPlanListData2({context}) async {
    String? tokenAccess;
    String? sellerId;
    var baseUrl = '${ConstantUrls.baseUriApi}${ConstantUrls.getSellerSubscriptions}';
    final dio = Dio();
    SharedPreferences preference = await SharedPreferences.getInstance();
    try {
      tokenAccess = preference.getString("access-token");
      sellerId = preference.getString("seller_id");
      // final body = {"seller_id":sellerId};
      final response = await dio.post(
        baseUrl,
        options: Options(
          headers: {
            "Authorization": tokenAccess,
            'Content-Type': 'application/json',
          },
        ),
        // data: json.encode(body),
      );
      print("response-------${response.statusCode} && ${response.data}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.data);
        return responseData;
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
      print("error-------${e}");

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
      print("error-------${error}");
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