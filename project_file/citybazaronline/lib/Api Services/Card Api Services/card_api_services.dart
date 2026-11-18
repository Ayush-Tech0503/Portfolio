// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:convert';
import 'package:Citybazar_app/Models/Card%20Details%20Model/card_details_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Util/Const Toster/toster.dart';
import '../../Util/Constant APi Url/api_urls.dart';
import '../../Util/constant_color.dart';


class CardDetailsApiService {
  static Future<CardDetailsModel?> fetchCardDetailsData({context}) async {
    String? tokenAccess;
    var baseUrl = '${ConstantUrls.baseUriApi}${ConstantUrls.getCardDetailsEndPoint}';
    final dio = Dio();
    SharedPreferences preference = await SharedPreferences.getInstance();
    try {
      // final body = {"search":search, "page_no": page, "limit": limit};
      tokenAccess = preference.getString("access-token");
      final response = await dio.get(
        baseUrl,
        options: Options(
          headers: {
            "Authorization": tokenAccess,
            'Content-Type': 'application/json',
          },
        ),
        // data: json.encode(body),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.data);
        return CardDetailsModel.fromJson(responseData);
      } else {
        LoadingScaffoldMessage.showSnackbar(
          context,
          "Something went wrong, try again later.",
          ConstantColor.primaryMainColor,
          const Duration(seconds: 2),
        );
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



// class CardDetailsApisService {
//    Future<CardDetailsModel?> fetchCardDetailsData() async {
//     String? tokenAccess;
//     var baseUrl = '${ConstantUrls.baseUriApi}${ConstantUrls.getCardDetailsEndPoint}';
//     final dio = Dio();
//     SharedPreferences preference = await SharedPreferences.getInstance();
//     try {
//       // final body = {"search":search, "page_no": page, "limit": limit};
//       tokenAccess = preference.getString("access-token");
//       final response = await dio.get(
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
//         return CardDetailsModel.fromJson(responseData);
//       } else {
//         // LoadingScaffoldMessage.showSnackbar(
//         //   context,
//         //   "Something went wrong, try again later.",
//         //   ConstantColor.primaryMainColor,
//         //   const Duration(seconds: 2),
//         // );
//         return null;
//       }
//     } on DioError catch (e) {
//       if (e.type == DioErrorType.connectionTimeout ||
//           e.type == DioErrorType.receiveTimeout ||
//           e.type == DioErrorType.sendTimeout ||
//           e.type == DioExceptionType.connectionError) {
//         // LoadingScaffoldMessage.showSnackbar(
//         //   context,
//         //   "Please check your internet connection",
//         //   ConstantColor.primaryMainColor,
//         //   const Duration(seconds: 3),
//         // );
//       }
//       return null;
//     } catch (error) {
//       // LoadingScaffoldMessage.showSnackbar(
//       //   context,
//       //   "Something went wrong, please try again later!",
//       //   ConstantColor.primaryMainColor,
//       //   const Duration(seconds: 2),
//       // );
//       return null;
//     }
//   }
// }