
// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Util/Constant APi Url/api_urls.dart';
import '../../../Util/constaint_textstyle.dart';
import '../../../Util/constant_color.dart';
import '../../../Util/constant_token.dart';
import '../../../Widgets/custome_text.dart';
import '../../Main Reels Screen/main_reels_screen.dart';
import '../../home_screen.dart';
import '../../profile_screen.dart';
import '../../store_screen.dart';


class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen>
    with TickerProviderStateMixin {
  String location = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoading=false;
  var responseData;

  fetchPrivacyAndPolicyApi() async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      setState(() {
        isLoading=true;
      });

/*-------------------------------loader----------------------------------*/

/*-------------------------------loader----------------------------------*/
      //final prefs = await SharedPreferences.getInstance();

      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.privacyPolicyApi}",
        options: Options(
          headers: {
            "Authorization": ConstantToken.authorizationToken,
            'Content-Type': 'text/plain',
          },
        ),
        //data: json.encode(body),
      );
      // loader false when user come back
      if (response.statusCode == 200) {
        responseData = json.decode(response.data);
        setState(() {
          isLoading=false;
        });

      }
    } catch (e) {
      setState(() {
        isLoading=false;
      });

    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPrivacyAndPolicyApi();
  }
  int _selectedIndex = 0; // Keep track of the selected bottom navigation item

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int index = 0;
  final ScrollController scrollController = ScrollController();
  final ScrollController _storesScreenController = ScrollController();
  final ScrollController couponController = ScrollController();
  final ScrollController personAccountController = ScrollController();
  final ScrollController floatingButtonController = ScrollController();


  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: ConstantColor.loginWithOtpButtonColor,
      child: SafeArea(
        child:Scaffold(
/*--------------------------------------appbar section start-------------------------------------*/
          key: _scaffoldKey,
          appBar: AppBar(
            elevation: 1,
            backgroundColor: ConstantColor.primaryBackgroundMainColor,
            iconTheme: const IconThemeData(color: ConstantColor.loginWithOtpButtonColor),
            title: customeText(textAlign: TextAlign.start,
                text: "Our Privacy & Policy", style: ConstantTextStyle.secodHearText),
          ),
/*--------------------------------------appbar section end-------------------------------------*/
          body: Container(
            width: double.maxFinite,
            color: ConstantColor.primaryBackgroundMainColor,
            padding: EdgeInsets.symmetric(vertical: screenHeight/50, horizontal: screenWidth/40),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customeText(
                    text: "Privacy Policy".toUpperCase(),
                    style: ConstantTextStyle.secodHearText,
                  ),
                //  SizedBox(height: screenHeight/60,),
                  Center(
                    child: isLoading? const Center(
                      child: SpinKitCircle(
                        color: ConstantColor.primaryMainColor,
                        size: 30.0,
                      ),
                    ): Center(
                      child:responseData["data"]!=null? Html(

                        data: responseData["data"],

                      ):const Text(""),
                    ),
                  ),
                ],
              ),
            ),

          ) ,
          // bottomNavigationBar:   BottomAppBar(
          //   notchMargin: 15,
          //   padding: EdgeInsets.only(
          //     left: MediaQuery.of(context).size.width / 60,
          //     right: MediaQuery.of(context).size.width / 60,
          //   ),
          //   shape: const CircularNotchedRectangle(),
          //   child: SizedBox(
          //     height: 60,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         IconButton(
          //           onPressed: () {
          //             setState(() {
          //               _selectedIndex = 0;
          //             });
          //           },
          //           icon: Icon(
          //             Icons.home_outlined,
          //             size: 28,
          //           ),
          //           color: _selectedIndex == 0
          //               ? ConstantColor.loginWithOtpButtonColor
          //               : Colors.black26,
          //         ),
          //         IconButton(
          //           onPressed: () {
          //             setState(() {
          //               _selectedIndex = 1;
          //             });
          //           },
          //           icon: Icon(
          //             Icons.storefront_outlined,
          //             size: 28,
          //           ),
          //           color: _selectedIndex == 1
          //               ? ConstantColor.loginWithOtpButtonColor
          //               : Colors.black26,
          //         ),
          //         Container(
          //           color: Colors.transparent,
          //           width: 50,
          //         ),
          //         IconButton(
          //           onPressed: () {
          //             setState(() {
          //               _selectedIndex = 2;
          //             });
          //           },
          //           icon: Icon(
          //             Icons.sell_outlined,
          //             size: 28,
          //           ),
          //           color: _selectedIndex == 2
          //               ? ConstantColor.loginWithOtpButtonColor
          //               : Colors.black26,
          //         ),
          //         IconButton(
          //           onPressed: () {
          //             setState(() {
          //               _selectedIndex = 3;
          //             });
          //           },
          //           icon: Icon(
          //             Icons.person_pin,
          //             size: 28,
          //           ),
          //           color: _selectedIndex == 3
          //               ? ConstantColor.loginWithOtpButtonColor
          //               : Colors.black26,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

        ),
      ),
    );
  }

  Widget _buildBody() {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    if (_selectedIndex == 0) {
      // Show a different initial screen when _selectedIndex is 0.
      return  Container(
        width: double.maxFinite,
        color: ConstantColor.primaryBackgroundMainColor,
        padding: EdgeInsets.symmetric(vertical: screenHeight/50, horizontal: screenWidth/30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customeText(
                text: "Privacy Policy".toUpperCase(),
                style: ConstantTextStyle.secodHearText,
              ),
              SizedBox(height: screenHeight/60,),
              Center(
                child:   isLoading? const Center(
                  child: SpinKitCircle(
                    color: ConstantColor.primaryMainColor,
                    size: 30.0,
                  ),
                ): Center(
                  child:responseData["data"]!=null? Html(

                    data: responseData["data"],

                  ):const Text(""),
                ),
              ),



            ],
          ),
        ),

      );
    } else {
      return IndexedStack(
        index: _selectedIndex,
        children: [
          HomeScreen(
            controller: scrollController, lattude:'', longitude: '', id: '', lName: '',
          ),
          StoresScreen(
            controller: _storesScreenController, lattude: '', longitude: '', id: '', lName: '',
          ),
          const Text(
            'Index 1: Coupon',
          ),
          ProfileScreen(controller: personAccountController, id: '', longitude: '', latitude: '', lName: '',),
           ReelsPage( getReelsId: '',id: '', longitude: '', latitude: '', lName: '', myIndex: 0,),
        ],
      );
    }
  }

  // Update the _selectedIndex based on bottom navigation item clicks.
  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
