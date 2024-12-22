// import 'dart:convert';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../Layouts/Onboarding Screens/otp_screen.dart';
// import '../../Layouts/Onboarding Screens/password_screen.dart';
// import '../../Util/Constant APi Url/api_urls.dart';
// import '../../Util/constaint_textstyle.dart';
// import '../../Util/constant_color.dart';
// import '../../Util/constant_token.dart';
// import '../Otp Screen Apis/otp _screen_api.dart';
//
// class LoginApiScreen {
//   static fetchLoginScreenApi(
//       context, TextEditingController mobileController, otpController) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       /*-------------------------------loader----------------------------------*/
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             content: Row(
//               children: [
//                 const CircularProgressIndicator(
//                   color: ConstantColor.primaryMainColor,
//                 ),
//                 const SizedBox(width: 20),
//                 Text(
//                   'Logging In...',
//                   style: ConstantTextStyle.allHomeScreenAvatarText,
//                 ),
//               ],
//             ),
//           );
//         },
//       );
// /*-------------------------------loader----------------------------------*/
//       final body = {
//         "mobile": mobileController.text,
//       };
//       final response = await Dio().post(
//         "${ConstantUrls.baseUriApi}${ConstantUrls.userLoginWithMobileEndPoint}",
//         options: Options(
//           headers: {
//             "Authorization": ConstantToken.authorizationToken,
//             'Content-Type': 'application/json; charset=UTF-8',
//           },
//         ),
//         data: json.encode(body),
//       );
//       Navigator.pop(context); // loader false when user comes back
//       if (response.statusCode == 200) {
//         //print("response login page api : --- ${response.data}");
//         final responseData = json.decode(response.data);
//         print("response data status ${responseData}");
//         if (responseData["password"] == true && responseData['msg'] == "Login success!") {
//           // Save user data
//
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => PasswordScreen(
//
//                   mobilenumber: mobileController.text.toString()),
//             ),
//           );
//         } else if (responseData["password"] == false &&
//             responseData['msg'] == "Login success!") {
//        //   print("response login page api else if : --- ${mobileController.text.toString()}");
//  //***********If password is false then Api Hit******************/
//        // Call the API here
//           await OtpApiScreen.sendOtpScreenApi(
//             context: context,
//             mobile: mobileController.text.toString(),
//
//           );
//         } else {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => OtpScreen(
//                 mobilenumber: mobileController.text.toString(),
//               ),
//             ),
//           );
//         }
//       }
//     } catch (e) {
//       // print('Failed to fetch data: $e');
//     }
//   }
// }
