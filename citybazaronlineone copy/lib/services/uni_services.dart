// import 'dart:developer';
// import 'package:Citybazar_app/Layouts/Notification%20Screen/notification_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:uni_links/uni_links.dart';
// import '../green.dart';
// import '../red.dart';
// import 'context_utility.dart';
//
// class UniServices{
//   static String _code = "";
//   static String get code => _code;
//   static bool get hasCustomCode => _code.isNotEmpty;
// // static bool get hashCode => _code.isNotEmpty;
//
//   static reset ()  {
//     _code = "";
//     // print("_code empty------------------${_code}");
//   }
//
//   static init()async{
//     try {
//       final Uri? uri = await getInitialUri();
//       uniHandler(uri);
//     }
//     on PlatformException catch (e){
//       log("failed to recive the code!!--------------------------------");
//     } on FormatException catch (e){
//       log("Wrong format code!!--------------------------------");
//     }
//     uriLinkStream.listen((Uri?uri) async{
//       uniHandler(uri);
//     },onError: (error){
//       log("onUri Link error :--------------------------- ${error}");
//     });
//   }
//
//
//   static uniHandler(Uri? uri) {
//     if (uri == null || uri.queryParameters.isEmpty || ContextUtility.context == null) return;
//     // showLoader();
//     Map<String, String> param = uri.queryParameters;
//     // print("param['code']-------------------${param['code']}");
//     String receivedCode = param['code'] ?? "";
//     // print("receivedCode-------------------${receivedCode}");
//     if (receivedCode == 'green') {
//       Navigator.pushReplacement(
//         ContextUtility.context!,
//         MaterialPageRoute(builder: (_) => const GreenScreen()
//         ),
//       );
//     }
//     else if  (receivedCode == 'red') {
//       Navigator.pushReplacement(
//         ContextUtility.context!,
//         MaterialPageRoute(builder: (_) => const RedScreen()
//         ),
//       );
//     }
//     else if  (receivedCode == '/') {
//       // print("receivedCode green-------------------${receivedCode}");
//       Navigator.pushReplacement(
//         ContextUtility.context!,
//         MaterialPageRoute(builder: (_) => const NotificationScreen()
//         ),
//         // )
//       );
//     }
//
//     // else if  (receivedCode == 'reels/') {
//     //   String getReelsId = param['getReelsId'] ?? '';
//     //   String latitude = param['latitude'] ?? '';
//     //   String longitude = param['longitude'] ?? '';
//     //   String id = param['id'] ?? '';
//     //   String lName = param['lName'] ?? '';
//     //   int myIndex = (param['myIndex'] ?? 0) as int;
//     //   int myLimit = (param['myLimit'] ?? 12) as int;
//     //   print("getReelsId-------------------${getReelsId}");
//     //   print("latitude-------------------${latitude}");
//     //   print("longitude-------------------${longitude}");
//     //   print("id-------------------${id}");
//     //   print("lName-------------------${lName}");
//     //   print("myIndex-------------------${myIndex}");
//     //   print("receivedCode green-------------------${receivedCode}");
//     //   Navigator.pushReplacement(
//     //     ContextUtility.context!,
//     //     MaterialPageRoute(builder: (_) => ReelsPage(
//     //       getReelsId: getReelsId,
//     //       latitude: latitude,
//     //       longitude: longitude,
//     //       id: id,
//     //       lName: lName,
//     //       myIndex: myIndex,
//     //       pageHere: ((myIndex + 1) / myLimit).ceil() ?? 0,
//     //       myLimit: myLimit,
//     //     ),
//     //     ),
//     //     // )
//     //   );
//     // }
//
//     else {
//       // Navigate to another screen if needed
//       Navigator.pushReplacement(
//         ContextUtility.context!,
//         MaterialPageRoute(builder: (_) => const NotificationScreen()
//         ),
//         // )
//       );
//
//     }
//   }
//
//
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// //
// //
// // import 'dart:developer';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:uni_links/uni_links.dart';
// // import '../green.dart';
// // import '../red.dart';
// // import 'context_utility.dart';
// //
// // class UniServices {
// //   static String _code = "";
// //   static String get code => _code;
// //   static bool get hasCustomCode => _code.isNotEmpty;
// //
// //   static reset() => _code = "";
// //
// //   static init() async {
// //     try {
// //       final Uri? uri = await getInitialUri();
// //       uniHandler(uri);
// //     } on PlatformException catch (e) {
// //       log("failed to receive the code!!");
// //     } on FormatException catch (e) {
// //       log("Wrong format code!!");
// //     }
// //     uriLinkStream.listen((Uri? uri) async {
// //       uniHandler(uri);
// //     }, onError: (error) {
// //       log("onUri Link error : ${error}");
// //     });
// //   }
// //
// //   static uniHandler(Uri? uri) {
// //     if (uri == null || uri.queryParameters.isEmpty) return;
// //
// //     Map<String, String> param = uri.queryParameters;
// //     String receivedCode = param['code'] ?? "";
// //     print("getReelsId-------------------${receivedCode}");
// //     if (receivedCode == 'green') {
// //       Navigator.push(
// //         ContextUtility.context!,
// //         MaterialPageRoute(builder: (_) => const GreenScreen()),
// //       );
// //     }
// // //     else if (receivedCode == 'reels') {
// // //       // Extract parameters from the URI query parameters
// //       String getReelsId = param['getReelsId'] ?? '';
// //       String latitude = param['latitude'] ?? '';
// //       String longitude = param['longitude'] ?? '';
// //       String id = param['id'] ?? '';
// //       String lName = param['lName'] ?? '';
// //       int myIndex = (param['myIndex'] ?? 0) as int;
// // print("getReelsId-------------------${getReelsId}");
// // print("latitude-------------------${latitude}");
// // print("longitude-------------------${longitude}");
// // print("id-------------------${id}");
// // print("lName-------------------${lName}");
// // print("myIndex-------------------${myIndex}");
// // //       // Navigate to the ReelsPage with the extracted parameters
// // //       Navigator.push(
// // //         ContextUtility.context!,
// // //         MaterialPageRoute(
// //           builder: (_) => ReelsPage(
// //             getReelsId: getReelsId,
// //             latitude: latitude,
// //             longitude: longitude,
// //             id: id,
// //             lName: lName,
// //             myIndex: myIndex,
// //             pageHere: ((myIndex + 1) / 12).ceil() ?? 0,
// //             myLimit: 12,
// //           ),
// // //         ),
// // //       );
// // //     }
// //     else {
// //       Navigator.push(
// //         ContextUtility.context!,
// //         MaterialPageRoute(builder: (_) => const RedScreen()),
// //       );
// //     }
// //   }
// // }
