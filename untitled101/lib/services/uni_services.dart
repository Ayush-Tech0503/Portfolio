// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:uni_links/uni_links.dart';
// import '../Layouts/Main Reels Screen/main_reels_screen.dart';
// import '../Layouts/Notification Screen/notification_screen.dart';
// import '../green.dart';
// import '../red.dart';
// import 'context_utility.dart';
//
// class UniServices{
//   static String _code = "";
//   static String Ids = "";
//   static String get code => _code;
//   // static String get codeId => Ids;
//   static bool get hasCustomCode => _code.isNotEmpty;
//   // static bool get hasCustomCodeId => Ids.isNotEmpty;
// // static bool get hashCode => _code.isNotEmpty;
//
//   static reset ()  {
//     _code = "";
//     // Ids = "";
//     print("_code empty------------------${_code}");
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
//       print("data-----$uri");
//       uniHandler(uri);
//     },onError: (error){
//       log("onUri Link error :--------------------------- ${error}");
//     });
//   }
//
//   static void uniHandler(Uri? uri) {
//     if (uri == null) {
//       print("Received URI is null");
//       return;
//     }
//
//     print("Full URI: $uri");
//     // print("Full Ids: $Ids");
//     print("URI Query Parameters: ${uri.queryParameters}");
//
//     Map<String, String> param = uri.queryParameters;
//     String receivedCode = param['code'] ?? "";
//
//     // Extract parameters
//     String getReelsId = param['getReelsId'] ?? '';
//     String latitude = param['latitude'] ?? '';
//     String longitude = param['longitude'] ?? '';
//     String id = param['id'] ?? '';
//     String lName = param['lName'] ?? '';
//     int myIndex = int.tryParse(param['myIndex'] ?? '0') ?? 0;
//     int myLimit = int.tryParse(param['myLimit'] ?? '12') ?? 12;
//
//     // Debug prints
//     print("Received Code: $receivedCode");
//     print("getReelsId: $getReelsId");
//     print("latitude: $latitude");
//     print("longitude: $longitude");
//     print("id: $id");
//     print("lName: $lName");
//     print("myIndex: $myIndex");
//     print("myLimit: $myLimit");
//
//     if (receivedCode == 'reel') {
//       Navigator.pushReplacement(
//         ContextUtility.context!,
//         MaterialPageRoute(
//           builder: (_) => ReelsPage(
//             getReelsId: getReelsId,
//             latitude: latitude,
//             longitude: longitude,
//             id: id,
//             lName: lName,
//             myIndex: myIndex,
//             pageHere: ((myIndex + 1) / myLimit).ceil(),
//             myLimit: myLimit,
//           ),
//         ),
//       );
//     } else {
//       Navigator.pushReplacement(
//         ContextUtility.context!,
//         MaterialPageRoute(builder: (_) => const NotificationScreen()),
//       );
//     }
//   }
//
//
// // static uniHandler(Uri? uri) {
//   //   if (uri == null || uri.queryParameters.isEmpty || ContextUtility.context == null) return;
//   //   // showLoader();
//   //   Map<String, String> param = uri.queryParameters;
//   //   print("param['code']-------------------${param['code']}");
//   //   String receivedCode = param['code'] ?? "";
//   //   print("receivedCode-------------------${receivedCode}");
//   //   if (receivedCode == 'green') {
//   //     Navigator.pushReplacement(
//   //       ContextUtility.context!,
//   //       MaterialPageRoute(builder: (_) => const GreenScreen()
//   //       ),
//   //     );
//   //   }
//   //   else if  (receivedCode == 'red') {
//   //     Navigator.pushReplacement(
//   //       ContextUtility.context!,
//   //       MaterialPageRoute(builder: (_) => const RedScreen()
//   //       ),
//   //     );
//   //   }
//   //   else if  (receivedCode == '/') {
//   //     print("receivedCode green-------------------${receivedCode}");
//   //     Navigator.pushReplacement(
//   //       ContextUtility.context!,
//   //       MaterialPageRoute(builder: (_) => const NotificationScreen()
//   //       ),
//   //       // )
//   //     );
//   //   }
//   //
//   //   else if  (receivedCode == 'reel') {
//   //     String getReelsId = param['getReelsId'] ?? '';
//   //     String latitude = param['latitude'] ?? '';
//   //     String longitude = param['longitude'] ?? '';
//   //     String id = param['id'] ?? '';
//   //     String lName = param['lName'] ?? '';
//   //     int myIndex = (param['myIndex'] ?? 0) as int;
//   //     int myLimit = (param['myLimit'] ?? 12) as int;
//   //     print("getReelsId-------------------${getReelsId}");
//   //     print("latitude-------------------${latitude}");
//   //     print("longitude-------------------${longitude}");
//   //     print("id-------------------${id}");
//   //     print("lName-------------------${lName}");
//   //     print("myIndex-------------------${myIndex}");
//   //     print("receivedCode-------------------${receivedCode}");
//   //     Navigator.pushReplacement(
//   //       ContextUtility.context!,
//   //       MaterialPageRoute(builder: (_) => ReelsPage(
//   //         getReelsId: getReelsId,
//   //         latitude: latitude,
//   //         longitude: longitude,
//   //         id: id,
//   //         lName: lName,
//   //         myIndex: 0,
//   //         pageHere: ((0 + 1) / myLimit).ceil() ?? 0,
//   //         myLimit: 12,
//   //       ),
//   //       ),
//   //       // )
//   //     );
//   //   }
//   //
//   //   else {
//   //     // Navigate to another screen if needed
//   //     Navigator.pushReplacement(
//   //       ContextUtility.context!,
//   //       MaterialPageRoute(builder: (_) => const NotificationScreen()
//   //       ),
//   //       // )
//   //     );
//   //
//   //   }
//   // }
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

// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:app_links/app_links.dart';  // Import the app_links package
import '../Api Services/Get Slug Api Services/get_slug_api.dart';
import 'context_utility.dart';

class AppLinkServices {
  static String _code = "";
  static String get code => _code;
  static bool get hasCustomCode => _code.isNotEmpty;
  static void reset() {
    _code = "";
  }

  // Create an AppLinks instance
  static final AppLinks _appLinks = AppLinks();

  static Future<void> init() async {
    try {
      // Get initial deep link
      final Uri? uri = await _appLinks.getInitialLink();
      if (uri != null) {
        appLinkHandler(uri);
      }
    } on PlatformException catch (e) {
      log("Failed to receive the code!! $e");
    } on FormatException catch (e) {
      log("Wrong format code!! $e");
    }

    // Listen for app link changes (when app is in the background and opened)
    _appLinks.uriLinkStream.listen((Uri? uri) async {
      if (uri != null) {
        appLinkHandler(uri);
      }
    }, onError: (error) {
      log("onUri Link error: $error");
    });
  }

  // Handle the app link
  static void appLinkHandler(Uri uri) {
    String desiredSegment = Uri.parse('$uri').path.split('/').last;
    // Determine the page type based on the URL path
    GetSlugApiServices.getSlugApi(
      context: ContextUtility.context,
      slug: desiredSegment ?? "",
      type: uri.pathSegments.contains('reels') ? "reels" : '',
    );
  }
}


// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:uni_links/uni_links.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../Api Services/Get Slug Api Services/get_slug_api.dart';
// import '../Layouts/Famous Market/Store Details/Store Details Screen/store_details.dart';
// import '../Layouts/Main Reels Screen/home_page_nav_reels_screen.dart';
// import '../Layouts/Product View Screens/product_Item_Details.dart';
// import '../collapsing_appbar.dart';
// import 'context_utility.dart';
// class UniServices {
//   static String _code = "";
//   static String get code => _code;
//   static bool get hasCustomCode => _code.isNotEmpty;
//   static void reset() {
//     _code = "";
//   }
//   static Future<void> init() async {
//     try {
//       final Uri? uri = await getInitialUri();
//       if (uri != null) {
//         uniHandler(uri);
//       }
//     } on PlatformException catch (e) {
//       log("Failed to receive the code!! $e");
//     } on FormatException catch (e) {
//       log("Wrong format code!! $e");
//     }
//     uriLinkStream.listen((Uri? uri) async {
//       if (uri != null) {
//         uniHandler(uri);
//       }
//     }, onError: (error) {
//       log("onUri Link error: $error");
//     });
//   }
//
//
//   static void uniHandler(Uri uri) {
//     String desiredSegment = Uri.parse('$uri').path.split('/').last;
//     // Determine the page type based on the URL path
//     GetSlugApiServices.getSlugApi(context:ContextUtility.context,slug: desiredSegment??"",type: uri.pathSegments.contains('reels') == true? "reels":'');
//   }
// }



//




// static void uniHandler(Uri uri) {
//   print("Full URI:----------------------- $uri");
//   print("URI Query Parameters: ${uri.queryParameters}");
//   Map<String, String> param = uri.queryParameters;
//   String receivedCode = param['code'] ?? "";
//   // Extract parameters----------
//   String getReelsId = param['getReelsId'] ?? '';
//   String latitude = param['latitude'] ?? '';
//   String longitude = param['longitude'] ?? '';
//   String id = param['id'] ?? '';
//   String lName = param['lName'] ?? '';
//   // int myIndex = int.tryParse(param['myIndex'] ?? '0') ?? 0;
//   // int myLimit = int.tryParse(param['myLimit'] ?? '12') ?? 12;
//   // Debug prints
//   print("Received Code: $receivedCode");
//   print("getReelsId: $getReelsId");
//   print("latitude: $latitude");
//   print("longitude: $longitude");
//   print("id: $id");
//   print("lName: $lName");
//   // print("myIndex: $myIndex");
//   // print("myLimit: $myLimit");
//   if (ContextUtility.context == null) {
//     log("Context is null, cannot navigate");
//     return;
//   }
//   if (receivedCode == 'reel') {
//     Navigator.pushReplacement(
//       ContextUtility.context!,
//       MaterialPageRoute(
//         builder: (_) => HomePageNavReelScreen(
//           myBannerReelId: getReelsId,
//           latitude: latitude,
//           longitude: longitude,
//           id: id,
//           lName: lName,
//           // myIndex: myIndex,
//           // pageHere: ((myIndex + 1) / myLimit).ceil(),
//           // myLimit: myLimit,
//         ),
//       ),
//     );
//   }
//   else {
//     Navigator.pushReplacement(
//       ContextUtility.context!,
//       MaterialPageRoute(builder: (_) => MyHomePageDemo1(mobilenumber: '', lat: '', longitude: '', id: '', lName: '')),
//     );
//   }
// }





//  static void uniHandler(Uri uri) async {
//     print("Full URI:----------------------- $uri");
//     print("URI Path Segments: ${uri.pathSegments}");
//     print("URI Query Parameters: ${uri.queryParameters}");
//
//     // Extract parameters
//     List<String> pathSegments = uri.pathSegments;
//     String receivedCode = uri.queryParameters['code'] ?? "";
//
//     // Extract values based on the path segments
//     String locationName = pathSegments.isNotEmpty ? pathSegments[0] : '';
//     String reelNameWithId = pathSegments.length > 1 ? pathSegments[1] : '';
//
//     // Extract getReelsId and Reel Name from the format `reelname-29`
//     String reelName = '';
//     String getReelsId = '';
//
//     // Check if `reelNameWithId` contains `-` and split it
//     if (reelNameWithId.contains('-')) {
//       List<String> parts = reelNameWithId.split('-');
//       reelName = parts.first;
//       getReelsId = parts.length > 1 ? parts.last : '';
//     } else {
//       reelName = reelNameWithId;
//     }
//
//     // Since we are not receiving query parameters, default values are used
//     String latitude = uri.queryParameters['latitude'] ?? '';
//     String longitude = uri.queryParameters['longitude'] ?? '';
//     String id = uri.queryParameters['id'] ?? '';
//     String lName = uri.queryParameters['lName'] ?? locationName; // Default to locationName if lName is not provided
//
//     // Debug prints
//     print("Received Code: $receivedCode");
//     print("Location Name: $locationName");
//     print("Reel Name: $reelName");
//     print("getReelsId: $getReelsId");
//     print("latitude: $latitude");
//     print("longitude: $longitude");
//     print("id: $id");
//     print("lName: $lName");
//
//     if (ContextUtility.context == null) {
//       log("Context is null, cannot navigate");
//       return;
//     }
//
//     if (receivedCode == 'reel') {
//       Navigator.pushReplacement(
//         ContextUtility.context!,
//         MaterialPageRoute(
//           builder: (_) => HomePageNavReelScreen(
//             myBannerReelId: getReelsId,
//             latitude: latitude,
//             longitude: longitude,
//             id: id,
//             lName: locationName,
//           ),
//         ),
//       );
//     } else {
//       Navigator.pushReplacement(
//         ContextUtility.context!,
//         MaterialPageRoute(
//           builder: (_) => MyHomePageDemo1(
//             mobilenumber: '',
//             lat: '',
//             longitude: '',
//             id: '',
//             lName: '',
//           ),
//         ),
//       );
//     }
//
//
//     final playStoreUrl = 'https://play.google.com/store/apps/details?id=com.citybazaronline';
//
//     try {
//       if (await canLaunch(playStoreUrl)) {
//         await launch(playStoreUrl);
//       } else {
//         log("Could not launch Play Store");
//       }
//     } catch (e) {
//       log("Error launching Play Store: $e");
//     }
//   }