import 'package:citybazaronline_seller_app/Screen/notification_screen.dart';
import 'package:citybazaronline_seller_app/Utils/Theme/constant_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Layouts/unknown_seller_layout.dart';
import 'Screen/ Login Screen/login_screen.dart';
import 'Layouts/seller_form_screen.dart';
import 'Screen/Approved Pending Screen/approved_pending_screen.dart';
import 'Screen/Complete Order/complete_order_screen.dart';
import 'Screen/Complete Order/complete_order_single_view_screen.dart';
import 'Screen/My Subscription Plan Screen/emi_options_screen.dart';
import 'Screen/My Subscription Plan Screen/get_start_plan_screen.dart';
import 'Screen/Password Screen/password_screen.dart';
import 'Screen/Pending Order Screen/pending_booked_product_screen.dart';
import 'Screen/Pending Order Screen/pending_order_screen.dart';
import 'Screen/Pending Products Screen/pending_products_screen.dart';
import 'Screen/Seller Dashboard Screen/dashboard_screen.dart';
import 'Screen/Shop Profile Screen/shop_profile_screen.dart';
import 'Screen/Splash Screen/splash_screen.dart';
import 'Screen/My Subscription Plan Screen/my_subscription_plan_screen.dart';
import 'Screen/My Subscription Plan Screen/purchese_new_plan_renew_screen.dart';
import 'Screen/Uploaded Products/Add New Product/Custom Product /Single Page Screen/single_page_screen.dart';
import 'Screen/Uploaded Products/Add New Product/Custom Product /custom_product_screen.dart';
import 'Screen/Uploaded Products/Add New Product/Pre Loaded Product/pre_loaded_product_screen.dart';
import 'Screen/Uploaded Products/Add New Product/add_new_product_screen.dart';
import 'Screen/Uploaded Products/View Product/view_product_screen.dart';
import 'Screen/Uploaded Products/uploaded_products_dart.dart';
import 'Screen/Your Uploaded Video/add_video_screen.dart';
import 'Screen/follower_seller_screen.dart';
import 'Screen/my_profile_screen.dart';
import 'Screen/seller_faq_screen.dart';
import 'Screen/shop_review_rating_screen.dart';
import 'Screen/terms_and_conditions_screen.dart';
import 'Screen/Your Uploaded Video/upload_video_screen.dart';
import 'Screen/your_booked_products.dart';
import 'Screen/your_like_products_screen.dart';
import 'Utils/Bottom Navigation Bars/bottom_navigation_app_bar.dart';
import 'Utils/Page Name Route/page_routes.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: ConstantColor.loginWithOtpButtonColor,
      systemNavigationBarColor: ConstantColor.loginWithOtpButtonColor,
      statusBarIconBrightness: Brightness.light,
    ));
    return MaterialApp(
      title: 'CBO Business App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.light),
        scaffoldBackgroundColor: ConstantColor.primaryBackgroundMainColor,
        dialogBackgroundColor:ConstantColor.primaryBackgroundMainColor,
       // dialogTheme: ColorScheme.fromSeed(seedColor: Colors.white),
       // colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
     // home:
     // GoogleMapSearchPlacesApi()
      initialRoute: ScreenRoutes.initialRoute,
      routes: {
        '/': (context) =>
            // MyTabScreen(),
        const SplashScreen(),
        ScreenRoutes.loginScreen: (context) => const LoginScreen(),
        ScreenRoutes.passwordScreen: (context) => const PasswordScreen(),
        ScreenRoutes.termsAndConditions: (context) => const TermConditionScreen(),
        ScreenRoutes.notificationScreen: (context) => const NotificationScreen(),
        ScreenRoutes.bottomNavigationBarScreen: (context) => const BottomNavigationBarScreen(),
        ScreenRoutes.sellerDashboardScreen: (context) => const SellerDashboardScreen(),
        ScreenRoutes.sellerFAQScreen: (context) => const SellerFAQScreen(),
        ScreenRoutes.likeProductScreen: (context) => const LikeProductScreen(),
        ScreenRoutes.shopReviewRatingScreen: (context) => const ShopReviewRatingScreen(),
        ScreenRoutes.viewProductScreen: (context) =>  ViewProductScreen(),
        ScreenRoutes.mySubscriptionPlanScreen: (context) => const MySubscriptionPlanScreen(),
        ScreenRoutes.emiOptionsScreen: (context) => const EmiOptionsScreen(),
        ScreenRoutes.getSubPlanStartScreen: (context) => const GetSubPlanStartScreen(),
        ScreenRoutes.shopProfileInfoScreen: (context) => const ShopProfileInfoScreen(),
        ScreenRoutes.sellerForm: (context) =>  const SteperItemSection(),
        ScreenRoutes.steperUnknownSellerLayout: (context) =>  const SteperUnknownSellerLayout(),
        ScreenRoutes.myProfileScreen: (context) =>  const MyProfileScreen(),
        ScreenRoutes.uploadVideoScreen: (context) =>  const UploadVideoScreen(),
        ScreenRoutes.addVideoScreen: (context) =>  const AddVideoScreen(),
        ScreenRoutes.pendingOrderScreen: (context) =>  const PendingOrderScreen(),
        ScreenRoutes.pendingBookedOrderScreen: (context) =>  const PendingBookedOrderScreen(),
        ScreenRoutes.completeOrderScreen: (context) =>  const CompleteOrderScreen(),
        ScreenRoutes.completeOrderViewScreen: (context) =>  const CompleteOrderViewScreen(),
        ScreenRoutes.bookedProductScreen: (context) =>  const BookedProductScreen(),
        ScreenRoutes.followerSellerScreen: (context) =>  const FollowerSellerScreen(),
        ScreenRoutes.approvedPendingScreen: (context) =>  const ApprovedPendingScreen(),
        ScreenRoutes.pendingProductScreen: (context) =>  const PendingProductScreen(),
        ScreenRoutes.uploadedProductScreen: (context) =>  const UploadedProductScreen(), // uploaded products == manage products (both are same)
        ScreenRoutes.addNewProductScreen: (context) =>  const AddNewProductScreen(),
        ScreenRoutes.preLoadedProductScreen: (context) =>   const PreLoadedProductScreen(),
        ScreenRoutes.singlePageFormScreen: (context) =>   const SinglePageFormScreen(),
        ScreenRoutes.customProductScreen: (context) =>   const CustomProductScreen(),
        ScreenRoutes.purchaseRenewPlanScreen: (context) => const RenewPlanScreen(),
      },
      //const LoginScreen(),
    );
  }
}



//-----------------comment----------------------

//    push name navigation-------------
//    Navigator.pushNamed(context, '/bottomNavigationBarScreen');
//
//    pushNamedAndRemoveUntil navigation-------------
//    Navigator.pushNamedAndRemoveUntil(context, '/loginScreen', ModalRoute.withName('loginScreen')); // remove all page and replace this

//        Navigator.pushNamedAndRemoveUntil(context, '/loginScreen', (Route<dynamic> route) => false,); // remove all page and replace this

//       Navigator.pushReplacementNamed(context, '/uploadVideoScreen');  // Destination route // current page replace by new page

//    close key_board------------------
//    FocusScope.of(context).unfocus();

//-----arguments -----
//    final arguments = ModalRoute.of(context)?.settings.arguments ??"";






//<?xml version="1.0" encoding="UTF-8"?>
// <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
// <plist version="1.0">
// <dict>
// 	<key>CFBundleDevelopmentRegion</key>
// 	<string>$(DEVELOPMENT_LANGUAGE)</string>
// 	<key>CFBundleDisplayName</key>
// 	<string>Citybazaronline Seller App</string>
// 	<key>CFBundleExecutable</key>
// 	<string>$(EXECUTABLE_NAME)</string>
// 	<key>CFBundleIdentifier</key>
// 	<string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
// 	<key>CFBundleInfoDictionaryVersion</key>
// 	<string>6.0</string>
// 	<key>CFBundleName</key>
// 	<string>citybazaronline_seller_app</string>
// 	<key>CFBundlePackageType</key>
// 	<string>APPL</string>
// 	<key>CFBundleShortVersionString</key>
// 	<string>$(FLUTTER_BUILD_NAME)</string>
// 	<key>CFBundleSignature</key>
// 	<string>????</string>
// 	<key>CFBundleVersion</key>
// 	<string>$(FLUTTER_BUILD_NUMBER)</string>
// 	<key>LSRequiresIPhoneOS</key>
// 	<true/>
//
// 	<key>UILaunchStoryboardName</key>
// 	<string>LaunchScreen</string>
// 	<key>UIMainStoryboardFile</key>
// 	<string>Main</string>
// 	<key>UISupportedInterfaceOrientations</key>
// 	<array>
// 		<string>UIInterfaceOrientationPortrait</string>
// 		<string>UIInterfaceOrientationLandscapeLeft</string>
// 		<string>UIInterfaceOrientationLandscapeRight</string>
// 	</array>
// 	<key>UISupportedInterfaceOrientations~ipad</key>
// 	<array>
// 		<string>UIInterfaceOrientationPortrait</string>
// 		<string>UIInterfaceOrientationPortraitUpsideDown</string>
// 		<string>UIInterfaceOrientationLandscapeLeft</string>
// 		<string>UIInterfaceOrientationLandscapeRight</string>
// 	</array>
// 	<key>CADisableMinimumFrameDurationOnPhone</key>
// 	<true/>
// 	<key>UIApplicationSupportsIndirectInputEvents</key>
//     	<true/>
//     	<key>NSAppTransportSecurity</key>
//     	<dict>
//     		<key>NSAllowsArbitraryLoads</key>
//     		<true/>
//     	</dict>
// </dict>
// </plist>
