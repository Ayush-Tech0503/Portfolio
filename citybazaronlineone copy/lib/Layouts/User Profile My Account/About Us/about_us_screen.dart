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


class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen>
    with TickerProviderStateMixin {
  String location = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // ignore: prefer_typing_uninitialized_variables
  var responseData;

  bool isLoading = false;

  fetchAboutUsApi() async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      setState(() {
        isLoading = true;
      });

/*-------------------------------loader----------------------------------*/

/*-------------------------------loader----------------------------------*/
      //final prefs = await SharedPreferences.getInstance();
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.aboutUsApi}",
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
    fetchAboutUsApi();
    ///////
  }

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
                text: "About Us", style: ConstantTextStyle.secodHearText),
          ),
/*--------------------------------------appbar section end-------------------------------------*/
          body:  Container(
            width: double.maxFinite,
            color: ConstantColor.primaryBackgroundMainColor,
            padding: EdgeInsets.symmetric(vertical: screenHeight/50, horizontal: screenWidth/30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customeText(
                    text: "About Us".toUpperCase(),
                    style: ConstantTextStyle.secodHearText,
                  ),
                  SizedBox(
                    height: screenHeight/50,
                  ),
                  customeText(
                    text: "Our Journey".toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    style: ConstantTextStyle.homeScreenHeadingText1,
                  ),
                  SizedBox(
                    height: screenHeight/60,
                  ),
                  isLoading
                      ? const Center(
                    child: SpinKitCircle(
                      color: ConstantColor.primaryMainColor,
                      size: 40.0,
                    ),
                  )
                      : Center(
                    child: responseData["data"] != null
                        ? Html(
                      data: responseData["data"],
                    )
                        : const Text(""),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
