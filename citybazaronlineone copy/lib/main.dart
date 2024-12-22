// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'Layouts/No Internet Connection Screen/no_internet_screen.dart';
import 'Layouts/Onboarding Screens/splash_screen.dart';
import 'Util/constant_color.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Upgrader.clearSavedSettings();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool hasInternet = true;
  // Future<ConnectivityResult> checkNetworkType() async {
  //   var connectivityResult = await Connectivity().checkConnectivity();
  //   return connectivityResult;
  //
  // }


   // StreamSubscription<InternetConnectionStatus> _subscription;

  //  asyncMethod() async {
  //   await  UniServices.init();
  // }

  @override
  void initState()  {
    super.initState();
    // UniServices.init();
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
      child: MaterialApp(
        // navigatorKey: ContextUtility.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'City Bazaar Online',
        theme: ThemeData(
          useMaterial3: false,
          primarySwatch: Colors.blue,
        ),
        // routes: {
        //   '/': (_) => hasInternet ? const SplashScreen() : const NoInternetPage(),
        //   '/green': (_) =>  const GreenScreen(),
        //   '/red': (_) =>  const RedScreen(),
        //   // '/reels/': (_) =>  ReelsPage(
        //   //   getReelsId: '',
        //   //   latitude: '',
        //   //   longitude: '',
        //   //   id: '',
        //   //   lName: '',
        //   //   myIndex: 0,
        //   //   pageHere:  0,
        //   //   myLimit: 0
        //   // ),
        // },

     home: hasInternet ? const SplashScreen() : const NoInternetPage(),

      ),
    );
  }
}

// @override
// void initState() {
//   super.initState();
//  InternetConnectionChecker().onStatusChange.listen((event) {
//     final connected = event == InternetConnectionStatus.connected;
//     setState(() {
//       hasInternet = connected;
//     });
//     if (connected) {
//       // Check the type of network connection (Wi-Fi or mobile data)
//       checkNetworkType().then((networkType) {
//         String connectionType = networkType == ConnectivityResult.wifi
//             ? "Internet connected with Wi-Fi"
//             : "Internet connected with Mobile Data";
//         showSimpleNotification(
//           position: NotificationPosition.bottom,
//           // contentPadding: EdgeInsets.only(left: 20),
//           Text(connectionType),
//           background: ConstantColor.drawerDividerColor,
//         );
//       });
//     } else {
//       showSimpleNotification(
//         // autoDismiss: false,
//         // contentPadding: EdgeInsets.zero,
//         position: NotificationPosition.bottom,
//         subtitle: const Text("Please check your internet connection"),
//         const Text("No Internet!!!"),
//         background: ConstantColor.drawerDividerColor,
//       );
//     }
//   });
// }

// @override
// void dispose() {
//   _subscription.cancel(); // Cancel the listener when the widget is disposed
//   super.dispose();
// }

//-----------------------------------------
// showDialogBox(BuildContext context) async {
//   showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       title: Text("No Internet!!!"),
//       content: Text("Please check your internet connection"),
//       actions: [
//         TextButton(
//           child: Text("Retry"),
//           onPressed: () {
//             Navigator.of(context).pop();
//             // Call the function or perform action on retry
//             // InternetConnectivity().connected;
//           },
//         ),
//       ],
//     ),
//   );
// }



