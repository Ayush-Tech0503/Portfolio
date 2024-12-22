
// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Models/Purchase New Plan Model/Coupon Model/coupon_model.dart';
import '../../../Utils/Constant Api Routs/constant_api_routs.dart';
import '../../../Utils/Theme/constant_colors.dart';
import '../../../Widget/Scaffold Message/scaffold_message_widget.dart';

class CouponsPaiService {
  static Future<CouponsModel?> fetchCouponsData({context,planCode,pid,plan}) async {
    String? tokenAccess;
    var baseUrl = '${ConstantUrls.baseUriApi}${ConstantUrls.planCouponApi}';
    final dio = Dio();
    SharedPreferences preference = await SharedPreferences.getInstance();
    try {
      tokenAccess = preference.getString("access-token");
      final body = {"ccode": planCode, "pid": pid, "plan": plan};
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
        if (responseData['status'] == 'success'){
          LoadingScaffoldMessage.showSnackbar(
            context, responseData['msg'] ?? 'your coupon code applied.',
            ConstantColor.chipColor,
            const Duration(seconds: 2),
          );
          return CouponsModel.fromJson(responseData);
        } else {
          LoadingScaffoldMessage.showSnackbar(
            context, responseData['msg'],
            ConstantColor.primaryMainColor,
            const Duration(seconds: 2),
          );
        }
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
      return null;
    }
  }
}