// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously, deprecated_member_use
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../Layouts/constant_screen_layout.dart';
import '../Utils/Constant Api Routs/constant_api_routs.dart';
import '../Utils/Font Style/text_styles.dart';
import '../Utils/Theme/constant_colors.dart';
import '../Widget/No Data Available/no_data_found.dart';
import '../Widget/Scaffold Message/scaffold_message_widget.dart';
import '../Widget/custome_text_widget.dart';

class TermConditionScreen extends StatefulWidget {
  const TermConditionScreen({super.key});

  @override
  State<TermConditionScreen> createState() => _TermConditionScreenState();
}

class _TermConditionScreenState extends State<TermConditionScreen> {
 bool isLoading = false;
  Map<String, dynamic> responseData = {};
  fetchTermsAndConditionApi() async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.loadTermsAndConditionApi}",
      );
      if (response.statusCode == 200) {
        responseData = json.decode(response.data);
        setState(() {
          isLoading = false;
        });
      }
    }
    on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout ||
          e.type == DioExceptionType.connectionError) {
        LoadingScaffoldMessage.showSnackbar(
          context,
          "Please check your internet connection",
          ConstantColor.primaryMainColor,
          const Duration(seconds: 3),
        );
      }
      return null;
    }
    catch (error) {
      LoadingScaffoldMessage.showSnackbar(
        context,
        "Something went wrong, please try again later!",
        ConstantColor.primaryMainColor,
        const Duration(seconds: 2),
      );
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchTermsAndConditionApi().then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
   var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return  AppLayout(
        title: "Terms and conditions",
        titleStyle: ConstantTextStyle.landingScreenAppbarText,
        leading: IconButton(
        icon: const Icon(Icons.arrow_back), color: ConstantColor.primaryBackgroundMainColor,
    onPressed: () => Navigator.pop(context),
    ),
    scaffoldColor: ConstantColor.secondryBackgroundMainColor,
    appBarColor: ConstantColor.loginWithOtpButtonColor,
    body: isLoading
        ? const Center(child: CircularProgressIndicator())
        : responseData["data"].toString().isNotEmpty
        ? Skeletonizer(
      enabled: isLoading,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth/40,vertical: screenHeight/80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customeText(
                overflow: TextOverflow.clip,
                textAlign: TextAlign.start,
                text: "TERMS OF USE",
                style: ConstantTextStyle.topCategoryText4,
              ),

              Html(
                shrinkWrap: true,
                data: responseData['data']??'',
                style: {
                  "p": Style(color: ConstantColor.landingScreenSubHaddingColor,
                    fontFamily: 'Montserrat',
                    fontSize: FontSize.medium,),
                },
              ),
            ],
          ),
        ),
      ),
    )
        : noDataFound(context),
    );
  }
}






