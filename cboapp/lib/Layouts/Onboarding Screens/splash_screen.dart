// ignore_for_file: use_build_context_synchronously

import 'package:Citybazar_app/Util/constaint_textstyle.dart';
import 'package:Citybazar_app/Util/constant_image.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Widgets/Mobile Device Id Widget/mobile_device_id.dart';
import '../../collapsing_appbar.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  navigationLogin() async {
    await Future.delayed(const Duration(seconds: 1), () {});
    await saveDeviceIdToSharedPreferences(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool("isLogin") ?? false;
    setState(() {});
    if (isLogin) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              MyHomePageDemo1(mobilenumber: '', lat: '', longitude: '', id: '', lName: ''),
        ),
      );
    } else {
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }


  Future<void> getAppVersionAndCheck() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    setState(() {});
  }
  String appVersion = '';



  @override
  void initState() {
    super.initState();
    getAppVersionAndCheck();
    navigationLogin();
    // checkAppVersion();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ConstantColor.primaryBackgroundMainColor,
      body: splashScreenImage(
          appVersion: appVersion,
          image: ConstantImage.cityBazaarSplaceScreenLogo,
          image2: ConstantImage.cityBazaarStoreLogo,
          context: context),
    );
  }
}

Widget splashScreenImage({image,image2, context,appVersion}) {
  return Stack(
    alignment: Alignment.center,
  // mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Align(
          alignment: const Alignment(0.9, -0.8),
          child: Text("version : $appVersion",style: ConstantTextStyle.splaceVersion,)),

      Center(
        child: ClipOval(
          child: Image.asset(
            image,
            fit: BoxFit.contain,
            width: MediaQuery.of(context).size.width /3,
          ),
        ),
      ),
      Positioned(
        top: MediaQuery.of(context).size.height/15.0,right: MediaQuery.of(context).size.width/30,
        child: Image.asset(
          image2,
          fit: BoxFit.contain,
          width: MediaQuery.of(context).size.width /4.5,
        ),
      ),
      // const SizedBox(height: 10),
    ],
  );
}



