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
class TermConditionScreen extends StatefulWidget {
  const TermConditionScreen({super.key});

  @override
  State<TermConditionScreen> createState() => _TermConditionScreenState();
}

class _TermConditionScreenState extends State<TermConditionScreen>
    with TickerProviderStateMixin {
  String location = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var responseData;

  bool isLoading = false;

  fetchTermsAndConditionApi() async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      setState(() {
        isLoading = true;
      });

/*-------------------------------loader----------------------------------*/

/*-------------------------------loader----------------------------------*/
      //final prefs = await SharedPreferences.getInstance();

      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.loadTermsAndConditionApi}",
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
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTermsAndConditionApi();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
          color: ConstantColor.loginWithOtpButtonColor,
      child: SafeArea(
        child: Scaffold(
          // backgroundColor: ConstantColor.primaryBackgroundMainColor,
          key: _scaffoldKey,
      /*--------------------------------------AppBar Section start-------------------------------------------*/
          appBar: AppBar(
            backgroundColor: ConstantColor.loginWithOtpButtonColor,
            elevation: 0.0,
         centerTitle: true,
      /*-------------------------------------------------------------------------------------------------*/
            title: Text(
              'Terms and conditions',
              style: ConstantTextStyle.landingScreenAppbarText,
              overflow: TextOverflow.ellipsis,),
            titleSpacing: 0.0,
          ),
      /*----------------------------------------AppBar section end--------------------------------------------*/
      /*--------------------------------------Drawer section start-------------------------------------*/
          // drawer: const CustomUserDrawerMenu(),
      /*--------------------------------------Drawer section end -------------------------------------*/
      /*----------------------------------------Body section start--------------------------------------------*/
          extendBody: true,
          body:ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight/100,horizontal: screenWidth/40),
                child: customeText(
                  text: "Term Of Use".toUpperCase(),
                  style: ConstantTextStyle.secodHearText,
                ),
              ),
              // SizedBox(height: screenHeight / 60,),
              isLoading
                  ? const Center(
                child: SpinKitCircle(
                  color: ConstantColor.primaryMainColor,
                  size: 30.0,
                ),
              )
                  : Center(
                child: responseData["data"] != null
                    ? Card(
                  color: ConstantColor.primaryBackgroundMainColor,
                  // color: Const
                  child: Html(
                    data: '<pre>${responseData["data"]}</pre>',
                    // data: responseData["data"],
                  ),
                    )
                    : const Text(""),
              ),
            ],
          ),
      /*----------------------------------------Body section end--------------------------------------------*/
        ),
      ),
    );
  }
}
