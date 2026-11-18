// // ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use
//
// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../Models/Order Listing Model/order_listing_model.dart';
// import '../../Util/Const Toster/toster.dart';
// import '../../Util/Constant APi Url/api_urls.dart';
// import '../../Util/constant_color.dart';
//
//
// class OrderListingApiService {
//   static Future<OrderListModel?> fetchOrderListingData({context}) async {
//     String? tokenAccess;
//     var baseUrl = '${ConstantUrls.baseUriApi}${ConstantUrls.getOrdersEndPoint}';
//     final dio = Dio();
//     SharedPreferences preference = await SharedPreferences.getInstance();
//     try {
//       // final body = {"seller_id":sellerId};
//       tokenAccess = preference.getString("access-token");
//       final response = await dio.post(
//         baseUrl,
//         options: Options(
//           headers: {
//             "Authorization": tokenAccess,
//             'Content-Type': 'application/json',
//           },
//         ),
//         // data: json.encode(body),
//       );
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData = jsonDecode(response.data);
//         return OrderListModel.fromJson(responseData);
//       } else {
//         LoadingScaffoldMessage.showSnackbar(
//           context,
//           "Something went wrong, try again later.",
//           ConstantColor.primaryMainColor,
//           const Duration(seconds: 2),
//         );
//         return null;
//       }
//     } on DioError catch (e) {
//       if (e.type == DioErrorType.connectionTimeout ||
//           e.type == DioErrorType.receiveTimeout ||
//           e.type == DioErrorType.sendTimeout ||
//           e.type == DioExceptionType.connectionError) {
//         LoadingScaffoldMessage.showSnackbar(
//           context,
//           "Please check your internet connection",
//           ConstantColor.primaryMainColor,
//           const Duration(seconds: 3),
//         );
//       }
//       return null;
//     } catch (error) {
//       LoadingScaffoldMessage.showSnackbar(
//         context,
//         "Something went wrong, please try again later!",
//         ConstantColor.primaryMainColor,
//         const Duration(seconds: 2),
//       );
//       return null;
//     }
//   }
// }


// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/Order Listing Model/order_listing_model.dart';
import '../../Util/Constant APi Url/api_urls.dart';

class OrderListingApiService {
  final Dio _dio = Dio();

  Future<OrderListModel?> fetchOrderListingData() async {
    String? tokenAccess;
    var baseUrl = '${ConstantUrls.baseUriApi}${ConstantUrls.getOrdersEndPoint}';
    SharedPreferences preference = await SharedPreferences.getInstance();
    tokenAccess = preference.getString("access-token");

    try {
      final response = await _dio.post(
        baseUrl,
        options: Options(
          headers: {
            "Authorization": tokenAccess,
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.data);
        return OrderListModel.fromJson(responseData);
      }
      else {
        // LoadingScaffoldMessage.showSnackbar(
        //   context,
        //   "Something went wrong, try again later.",
        //   ConstantColor.primaryMainColor,
        //   const Duration(seconds: 2),
        // );
        return null;
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout ||
          e.type == DioExceptionType.connectionError) {
        // LoadingScaffoldMessage.showSnackbar(
        //   context,
        //   "Please check your internet connection",
        //   ConstantColor.primaryMainColor,
        //   const Duration(seconds: 3),
        // );
      }
      return null;
    } catch (error) {
      // LoadingScaffoldMessage.showSnackbar(
      //   context,
      //   "Something went wrong, please try again later!",
      //   ConstantColor.primaryMainColor,
      //   const Duration(seconds: 2),
      // );
      return null;
    }
  }
  //-----------cancel order api -----

  Future<bool> cancelOrder({orderId, status}) async {
    String? tokenAccess;
    var baseUrl = '${ConstantUrls.baseUriApi}${ConstantUrls.getCancelOrderEndPoint}';
    SharedPreferences preference = await SharedPreferences.getInstance();
    tokenAccess = preference.getString("access-token");
    try {
      final response = await _dio.post(
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
        return true;
      } else {
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
