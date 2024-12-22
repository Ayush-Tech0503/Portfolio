// ignore_for_file: use_build_context_synchronously
import 'package:citybazaronline_seller_app/Widget/images/asset_images_widget.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/Constant Images/constant_images.dart';
import '../../Utils/Font Style/text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  navigationLogin() async {
    await Future.delayed(const Duration(seconds: 1), () {});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool("isLogin") ?? false;
    int? isSeller = prefs.getInt("is_seller")??0;
    // var sellerID = prefs.getString("seller_id") ?? '';
    setState(() {});
    if (isLogin) {
      if (isSeller == 1) {
        Navigator.pushNamed(context, '/bottomNavigationBarScreen');
      }
      else{
        Navigator.pushNamed(context, '/steperUnknownSellerLayout');
      }
    } else {
      Navigator.pushNamed(context, '/loginScreen');
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
  }


  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body:
        Stack(
          alignment: Alignment.center,
           children: [
              Align(
                alignment: const Alignment(0.9, -0.95),
                child: assetImageWidget(
                  imageFile: ConstantImage.cityBazaarStoreLogo,
                  fit: BoxFit.contain,
                  width: screenWidth /4.5,
                ),
              ),
              Align(
                  alignment: const Alignment(0.9, -0.89),
                  child: Text("version : $appVersion",style: ConstantTextStyle.splaceVersion,)),

              ClipOval(
                child: assetImageWidget(
                  imageFile: ConstantImage.cityBazaarSplaceScreenLogo,
                  fit: BoxFit.contain,
                  width: screenWidth /3,),
              ),
            ],
        ),
      ),
    );
  }
}



