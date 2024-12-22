// // ignore_for_file: empty_catches
//
// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../Utils/Constant Api Routs/constant_api_routs.dart';
// import '../../Utils/Font Style/text_styles.dart';
// import '../../Utils/Theme/constant_colors.dart';
// import '../../Widget/Scaffold Message/scaffold_message_widget.dart';
//
//  fetchPasswordAndOtpVerifyApi({context, body}) async {
//   try {
//     SharedPreferences preference = await SharedPreferences.getInstance();
//
// /*-------------------------------loader----------------------------------*/
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(30.0)),
//           ),
//           content: Row(
//             children:  [
//               const CircularProgressIndicator(color: ConstantColor.primaryMainColor,),
//               const SizedBox(width: 20),
//               Text('Logging In...',style: ConstantTextStyle.allHomeScreenAvatarText,),
//             ],
//           ),
//         );
//       },
//     );
// /*-------------------------------loader----------------------------------*/
//
//     final response = await Dio().post(
//       "${ConstantUrls.baseUriApi}${ConstantUrls.userOtpAndPassWordEndPoint}",
//       // options: Options(
//       //   headers: {
//       //     "Authorization": ConstantToken.authorizationToken,
//       //     'Content-Type': 'text/plain',
//       //   },
//       // ),
//       data: json.encode(body),
//     );
//     Navigator.pop(context);
//     print('password response.statusCode------------${response.statusCode}');
//     print('password response.statusCode------------${response.data}');
//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.data);
//       if (responseData [ "status"] == "success" ) {
//         String userDataJson = json.encode(responseData["data"]);
//         preference.setString("user_data", userDataJson);
//         preference.setString("access-token", responseData["token"]);
//         preference.setString("userId", responseData["data"]["user_id"]);
//         preference.setString("name", responseData["data"]["name"]);
//         preference.setInt("is_seller", responseData["data"]["is_seller"]);
//         preference.setString("created_date", responseData["data"]["created_date"]);
//         preference.setBool("isLogin", true);
//         bool isProfileCompleted = responseData["data"]["isProfileCompleted"] ?? false;
//         preference.setBool("isProfileCompleted", isProfileCompleted);
//         // Navigator.push(
//         //   context,
//         //   MaterialPageRoute(builder: (context) =>
//         //       MyHomePageDemo1(
//         //         mobilenumber: mobile,
//         //         lat: '', longitude: '', id: '',lName: '',
//         //       ),
//         //
//         //   ),
//         // );
//         LoadingScaffoldMessage.showSnackbar(
//           context,
//           responseData['msg'],
//           ConstantColor.primaryMainColor,
//           const Duration(seconds: 2),
//         );
//       }
//       else{
//         LoadingScaffoldMessage.showSnackbar(
//           context,
//           responseData['msg'],
//           ConstantColor.primaryMainColor,
//           const Duration(seconds: 2),
//         );
//       }
//     }
//   } catch (e) {}
// }
