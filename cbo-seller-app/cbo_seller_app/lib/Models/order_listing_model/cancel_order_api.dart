// dialogType: orderStatus == "0" ? DialogType.info : orderStatus == "1" ?  DialogType.success : orderStatus == "2" ? DialogType.error : DialogType.question,


import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/Constant Api Routs/constant_api_routs.dart';
import '../../Utils/Theme/constant_colors.dart';
import '../../Widget/Scaffold Message/scaffold_message_widget.dart';
class OrderStatusApi {
 static Future cancelOrder({orderId, status,context}) async {
    String? tokenAccess;
    final Dio dio = Dio();
    var baseUrl = '${ConstantUrls.baseUriApi}${ConstantUrls.getOrderStatus}';
    SharedPreferences preference = await SharedPreferences.getInstance();
    tokenAccess = preference.getString("access-token");
    try {
      final response = await dio.post(
        baseUrl,
        data: jsonEncode({
          'order_id': orderId,
          'status': status ?? '2',
        }),
        options: Options(
          headers: {
            'Authorization': tokenAccess,
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.data);
        Navigator.pushReplacementNamed(context, '/pendingOrderScreen');
        LoadingScaffoldMessage.showSnackbar(
          context,
          responseData["msg"],
          ConstantColor.primaryMainColor,
          const Duration(seconds: 2),
        );
        // return OderListingModel.fromJson(responseData);
        return true;
      } else {
        Navigator.pop(context);
        LoadingScaffoldMessage.showSnackbar(
          context,"something want's wrong!",
          ConstantColor.primaryMainColor,
          const Duration(seconds: 2),
        );
        return false;
      }
    } on DioError catch (e) {
      // Handle DioError (network errors, timeouts, etc.)
      print('DioError----------------- ${e.message}');
      return false;
    } catch (error) {
      // Handle other types of errors
      print('Error:--------------- ${error.toString()}');
      return false;
    }
  }
}
