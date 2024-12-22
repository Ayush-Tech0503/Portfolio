
// ignore_for_file: non_constant_identifier_names

import 'package:citybazaronline_seller_app/Utils/Theme/constant_colors.dart';
import 'package:citybazaronline_seller_app/Widget/custome_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Utils/Font Style/text_styles.dart';
import '../Screen/Become A Seller/seller_form_step_1st_screen.dart';
import '../Screen/Become A Seller/seller_form_step_2nd_screen.dart';
import '../Screen/Become A Seller/seller_form_step_3rd_screen.dart';
import '../Screen/Become A Seller/seller_form_step_4th_screen.dart';
import '../Widget/Custome Buttons/elevetion_button_widget.dart';

class CustomContentWidget extends StatelessWidget {
  final String content;

  const CustomContentWidget({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        content,
        style: const TextStyle(fontSize: 24.0),
      ),
    );
  }
}


class SteperUnknownSellerLayout extends StatefulWidget {
  // final SellerFormData? formData;
  const SteperUnknownSellerLayout({super.key});

  @override
  State<SteperUnknownSellerLayout> createState() => _SteperUnknownSellerLayoutState();
}

class _SteperUnknownSellerLayoutState extends State<SteperUnknownSellerLayout> {
  int currentStep = 0;

  List<Map<String, String>> steplist = [
    {'task': '1', 'content': "Personal"},
    {'task': '2', 'content': "Store"},
    {'task': '3', 'content': "Image"},
    {'task': '4', 'content': "Finish"},
  ];



  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
      showDialog(
        context: context,
        builder: (context) {
          return   AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            backgroundColor: ConstantColor.primaryBackgroundMainColor,
            title: customeText(text: 'Please confirm!'),
            content: customeText(text: "Are you sure you want to exit?"),
            contentPadding: EdgeInsets.symmetric(horizontal: screenWidth / 30),
            titlePadding: EdgeInsets.symmetric(horizontal: screenWidth / 30, vertical: screenHeight / 60),
            actionsPadding: EdgeInsets.symmetric(horizontal: screenWidth / 30, vertical: screenHeight / 60),
            actions:[
              customButton(
                  elevation: 0,
                  backgroundColor: ConstantColor.primaryBackgroundMainColor,
                  onPressed: (){
                    Navigator.of(context).pop();
                    SystemNavigator.pop();},
                  text: "Yes",
                  textStyleButton: ConstantTextStyle.hintTextStyle2),
              const SizedBox(width: 10.0,),
              customButton(
                  elevation: 0,
                  backgroundColor: ConstantColor.primaryBackgroundMainColor,
                  onPressed: () =>Navigator.of(context).pop(),
                  text: "No",
                  textStyleButton: ConstantTextStyle.hintTextStyle2),
            ],
          );

        },
      );
      return false;
      },
      child: Scaffold(
        // key: _scaffoldKey,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: ConstantColor.loginWithOtpButtonColor,
            title: customeText(text: "Become A Seller"),
            titleTextStyle: ConstantTextStyle.landingScreenAppbarText,
            // leading: isCheck ? IconButton(
            //     icon: const Icon(Icons.arrow_back), color: ConstantColor.primaryBackgroundMainColor,
            //     onPressed: () => Navigator.pop(context)): Container()
        ),
        backgroundColor: ConstantColor.primaryBackgroundMainColor,

        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double stepperHeight = constraints.maxHeight;
            double stepperWidth = constraints.maxWidth;
            return ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: stepperHeight * 1.0, // Adjust as needed
                  width: stepperWidth,
                  child:
                  Theme(
                    data: ThemeData(
                      // canvasColor: Colors.transparent,
                      colorScheme: Theme.of(context).colorScheme.copyWith(
                        primary: ConstantColor.primaryMainColor,
                        background: ConstantColor.transparent1,
                        secondary: Colors.green,
                      ),
                    ),
                    child:Stepper(
                      // physics: const NeverScrollableScrollPhysics(),
                      connectorThickness: 1,
                      elevation: 0,
                      type: StepperType.horizontal,
                      currentStep:  currentStep,
                      controlsBuilder: (BuildContext context, ControlsDetails controls) {
                        return const Row(
                          children: [SizedBox.shrink()],
                        );
                      },
                      steps: getSteps(),
                    ),
                  ),

                ),
              ],
            );
          },
        ),
      ),
    );
  }

  final double fontSize = 8;
  List<Step> getSteps() {
    var itemList = steplist.asMap().entries.map<Step>((e) {
      var i = e.key;
      var item = e.value;
      return Step(
        state: currentStep > i ? StepState.complete : StepState.indexed,
        isActive: currentStep >= i,
        title: const SizedBox.shrink(),
        label: Text(
          StepState.indexed == StepState.indexed ? item['content'] ?? "" : "",
          style: TextStyle(
            fontSize: fontSize,
            color: currentStep >= i ? ConstantColor.loginWithOtpButtonColor: null,
          ),
        ),
        content: getPageContent(i),
      );
    });
    return itemList.toList();
  }

  Widget getPageContent(int index) {
    switch (index) {
      case 0:  return  Step1stSellerFormScreen(
        onNext: () {
          setState(() {
            currentStep++;
          });
        },
        //   onNext: (formData) {
        //   setState(() {
        //     this.formData = formData;
        //   });
        // },
      );
      case 1:  return  Step2ndSellerFormScreen(
        currectPageValue: currentStep+1,
        onPreview: () {
          setState(() {
            currentStep--;
          });
        },
        onNext: () {
          setState(() {
            currentStep++;
          });
        },
      );
      case 2:  return  Step3rdSellerFormScreen(
        currectPageValue: currentStep+1,
        onPreview: () {
          setState(() {
            currentStep--;
          });
        },
        onNext: () {
          setState(() {
            currentStep++;
          });
        },
      );
      case 3:  return Step4thSellerFormScreen(
        currectPageValue: currentStep+1,
        onPreview: () {
          setState(() {
            currentStep--;
          });
        },
        onNext: () {
          setState(() {
            currentStep++;
          });
        },
      );
      default:return const CustomContentWidget(content: "Unknown Page");
    }
  }
}
