import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'Layouts/Main Reels Screen/home_page_nav_reels_screen.dart';
import 'Layouts/No Internet Connection Screen/no_internet_screen.dart';
import 'Layouts/Onboarding Screens/splash_screen.dart';
import 'Util/constant_color.dart';
import 'services/context_utility.dart';
import 'services/uni_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool hasInternet = true;

  @override
  void initState()  {
    super.initState();
    AppLinkServices.init();
    InternetConnectionChecker().onStatusChange.listen((event) {
      if (event == InternetConnectionStatus.disconnected) {
        setState(() {
          hasInternet = false;
        });
        showSimpleNotification(
          // autoDismiss: false,
          // contentPadding: EdgeInsets.zero,
          position: NotificationPosition.bottom,
          const Text("No Internet!!!"),
          subtitle: const Text("Please check your internet connection"),
          background: ConstantColor.drawerDividerColor,
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: ConstantColor.drawerDividerColor,
      systemNavigationBarColor: ConstantColor.drawerDividerColor,
      statusBarIconBrightness: Brightness.light,
    ));
    return OverlaySupport.global(
      child: GetMaterialApp(
        navigatorKey: ContextUtility.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'City Bazar Online',
        theme: ThemeData(
          useMaterial3: false,
          primarySwatch: Colors.blue,
        ),
        routes: {
          // '/': (_) => hasInternet ?  VideoTest() : const NoInternetPage(),
          '/': (_) => hasInternet ? const SplashScreen() : const NoInternetPage(),
          '/reel': (_) =>  HomePageNavReelScreen(
              myBannerReelId: '',
              latitude: '',
              longitude: '',
              id: '',
              lName: 'Indore',
          ),
        },

     // home: hasInternet ? const SplashScreen() : const NoInternetPage(),
     // home: hasInternet ? const ExampleParallax() : const NoInternetPage(),

      ),
    );
  }
}

//-------ios deeplinking important data

// https://citybazaronline.com/.well-known/apple-app-site-association   //path
//{
//   "applinks": {
//     "details": [
//       {
//         "appID": "AB12345XYZ.com.citybazaronline", //
// "appID": "TEAM_ID.com.citybazaronline",  // Replace TEAM_ID with your actual Apple Developer team ID
//         "paths": [ "*" ]
//       }
//     ]
//   }
// }


