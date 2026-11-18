import 'package:dummy/Helper/color_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Helper/storage_helper.dart';
import 'Routes/routes.dart';
import 'Routes/routes_name.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await mainCommon();
}

Future<void> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize storage
  await StorageHelper().init();

  // Set status bar color
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: ColorHelper.tpColor,
      statusBarBrightness: Brightness.dark,
    ),
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child:
      // MultiBlocProvider(
        // providers: [
          // Uncomment and implement your BlocProvider if needed
          // BlocProvider(create: (BuildContext context) => GetDefaultAddressCubit()),
        // ],
        // child:
      MaterialApp(
          title: "dummyapp",
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              background: ColorHelper.whiteColor,
              surface: ColorHelper.whiteColor,
              surfaceTint: ColorHelper.whiteColor,
              seedColor: ColorHelper.primaryColor,
            ),
            useMaterial3: true,
          ),
          home: MyHomePage(),
          // initialRoute: RouteName.splash,
          // onGenerateRoute: Routes.onGenerateRoute,
        ),
      );
    // );
  }
}


class MyHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: ColorHelper.appColor,
      body: Container(
        color: ColorHelper.primaryColor
      ),
    );
  }
}

