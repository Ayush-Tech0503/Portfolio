//
// // ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use
//
// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../Models/Purchase New Plan Model/Emi Detail Model/subscription_plan_detail_model.dart';
// import '../../../Utils/Constant Api Routs/constant_api_routs.dart';
// import '../../../Utils/Theme/constant_colors.dart';
// import '../../../Widget/Scaffold Message/scaffold_message_widget.dart';
//
//
// class ApiGetEMIService {
// static Future<SubscriptionPlanDetailsModel?> fetchGetEMIData({context,subscriptionIds}) async {
//     String? tokenAccess;
//     var baseUrl = '${ConstantUrls.baseUriApi}${ConstantUrls.subscriptionPlanDetailEndPoint}';
//     final dio = Dio();
//     SharedPreferences preference = await SharedPreferences.getInstance();
//     try {
//       tokenAccess = preference.getString("access-token");
//       final body = {"subscription_id": '$subscriptionIds'};
//       final response = await dio.post(
//         baseUrl,
//         options: Options(
//           headers: {
//             "Authorization": tokenAccess,
//             'Content-Type': 'application/json',
//           },
//         ),
//         data: json.encode(body),
//       );
//
//       if (response.statusCode == 200) {
//         if (response.data != null && response.data.isNotEmpty) {
//           final Map<String, dynamic> responseData = jsonDecode(response.data);
//           print('responseData----------$responseData');
//           print('status------------${response.statusCode}');
//           return SubscriptionPlanDetailsModel.fromJson(responseData);
//         } else {
//           // Handle empty or invalid response
//           return null;
//         }
//       } else {
//         // Handle non-200 status code
//         LoadingScaffoldMessage.showSnackbar(
//           context,
//           "something went wrong try after some time.",
//           ConstantColor.primaryMainColor,
//           const Duration(seconds: 2),
//         );
//         return null;
//       }
//
//     // final response = await dio.post(
//       //   baseUrl,
//       //   options: Options(
//       //     headers: {
//       //       "Authorization": tokenAccess,
//       //       'Content-Type': 'application/json',
//       //     },
//       //   ),
//       //   data: json.encode(body),
//       // );
//       // if (response.statusCode == 200) {
//       //   final Map<String, dynamic> responseData = jsonDecode(response.data);
//       //   print('responseData----------${responseData}');
//       //   return SubscriptionPlanDetailsModel.fromJson(responseData);
//       // }
//       // else {
//       //   LoadingScaffoldMessage.showSnackbar(
//       //     context, "something went wrong try after some time.",
//       //     ConstantColor.primaryMainColor,
//       //     const Duration(seconds: 2),
//       //   );
//       //   return null;
//       // }
//     }
//     on DioError catch (e) {
//       if (e.type == DioErrorType.connectionTimeout || e.type == DioErrorType.receiveTimeout || e.type == DioErrorType.sendTimeout || e.type == DioExceptionType.connectionError) {
//         // Handle connection error
//         LoadingScaffoldMessage.showSnackbar(
//           context, "Please check your internet connection",
//           ConstantColor.primaryMainColor,
//           const Duration(seconds: 3),
//         );
//       }
//       return null;
//     } catch (error) {
//       print('-------------E-----$error');
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
import '../../../Utils/Constant Api Routs/constant_api_routs.dart';
import '../../../Utils/Theme/constant_colors.dart';
import '../../../Widget/Scaffold Message/scaffold_message_widget.dart';

class ApiGetEMIService {
  static Future<Map<String, dynamic>?> fetchGetEMIData({context, subscriptionIds}) async {
    String? tokenAccess;
    var baseUrl = '${ConstantUrls.baseUriApi}${ConstantUrls.subscriptionPlanDetailEndPoint}';
    final dio = Dio();
    SharedPreferences preference = await SharedPreferences.getInstance();

    try {
      tokenAccess = preference.getString("access-token");
      final body = {"subscription_id": '$subscriptionIds'};

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
        if (response.data != null && response.data.isNotEmpty) {
          final Map<String, dynamic> responseData = jsonDecode(response.data);
          return responseData; // Return the entire JSON map
        } else {
          // Handle empty or invalid response
          return null;
        }
      } else {
        // Handle non-200 status code
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
