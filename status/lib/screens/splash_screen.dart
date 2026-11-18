import 'package:centavizers/main.dart';
import 'package:flutter/material.dart';
import '../helpers/color_helper.dart';
import '../helpers/storage_helper.dart';
import '../network_manager/auth_device_data.dart';
import '../repositories/heath_permission.dart';
import '../routes/routes_name.dart';
import '../utils/app_images.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String accessToken = "";
  bool appInternet = false;


  _buildNavigator (){
    bool isLogin = StorageHelper().getIsFirstLaunch();
    if (isLogin){
      Navigator.pushNamedAndRemoveUntil(context, RouteName.bottomBarTabs, (route) => false);
    }else {
      Navigator.pushNamedAndRemoveUntil(context, RouteName.onboardingRoute, (route) => false);
    }
  }

  deviceData () async {
    await UserAuthenticationApis().getId();
    await health.configure();
    bool updateDone =  await requestInitialPermissions();
    if(StorageHelper().getDeviceType() == "Android"){
      if(updateDone == true){
        Future.delayed(const Duration(seconds: 2),() => {
          _buildNavigator(),
        },);
      }
    }
    else{
      Future.delayed(const Duration(seconds: 2),() => {
        _buildNavigator(),
      },);
    }

  }



  @override
  void initState() {
    deviceData();
    super.initState();
  }



  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     Future.delayed(const Duration(seconds: 2), () async {
  //       bool? isLogin = StorageHelper().getIsFirstLaunch();
  //       if (isLogin == true){
  //         Navigator.pushNamedAndRemoveUntil(context, RouteName.bottomBarTabs, (route) => false);
  //       }else {
  //         Navigator.pushNamedAndRemoveUntil(context, RouteName.onboardingRoute, (route) => false);
  //       }
  //
  //     });
  //   });
  //
  //   super.initState();
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.whiteColor,
      body: Center(
        child: Image.asset(
          AppImages.splashImage,
          width: double.infinity,
        ),
      ),
    );
  }
}