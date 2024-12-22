// ignore_for_file: non_constant_identifier_names, empty_catches, deprecated_member_use
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upgrader/upgrader.dart';
import '../../Services/Login Api Services/login_api_services.dart';
import '../../Utils/Constant Images/constant_images.dart';
import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Mobile Number String Check/mobile_number_check.dart';
import '../../Utils/Theme/constant_colors.dart';
import '../../Widget/Alert Dialogs/alert_dialog_widget.dart';
import '../../Widget/Check_boxs/check_box_widget.dart';
import '../../Widget/Custome Buttons/elevetion_button_widget.dart';
import '../../Widget/Scaffold Message/scaffold_message_widget.dart';
import '../../Widget/Text Form Fields/login_text_form.dart';
import '../../Widget/custome_rich_text.dart';
import '../../Widget/custome_text_widget.dart';
import '../../Widget/scrolling_dots_widget.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int _currentIndex = 0;
  bool valuefirst = false;

  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  void newAppUpdate()async {
    WidgetsFlutterBinding.ensureInitialized();
    await Upgrader.clearSavedSettings();
    await Upgrader().initialize();
  }

  @override
  void initState() {
    super.initState();
    newAppUpdate();
    ImageExpanding = false;
    mobileController.addListener(() {
    });
    _focusNode.addListener(() {
      setState(() {});
    });
  }


/*--------------------Mobile number validation---------------------------------*/
  TextEditingController mobileController = TextEditingController();
  /*-----------------------------------------------------*/
  String? validateCheckbox(bool? value) {
    if (value == null || value == false) {
      return 'Please accept the terms and conditions';
    }
    return null;
  }

  /*-----------------------------------------------------*/
  final TextEditingController otpController = TextEditingController();
  final MobileNumberInputFormatter mobileNumberFormatter = MobileNumberInputFormatter();

  /*-----------------------------------------------------*/
  bool ImageExpanding = false;
  @override
  Widget build(BuildContext context) {
    // ToastContext().init(context);
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        bool exit = await YesNoPermissionDialog.showExitConfirmationDialog(
            context: context, title: "Please confirm!", content: "Are you sure want to close this App?", actions: [
          customButton(
              elevation: 0,
              backgroundColor: ConstantColor.primaryBackgroundMainColor,
              onPressed: () => SystemNavigator.pop(),
              text: "Yes",
              textStyleButton: ConstantTextStyle.hintTextStyle2),
          const SizedBox(width: 10.0,),
          customButton(
              elevation: 0,
              backgroundColor: ConstantColor.primaryBackgroundMainColor,
              onPressed: () => Navigator.of(context).pop(false),
              text: "No",
              textStyleButton: ConstantTextStyle.hintTextStyle2),

        ]);
        return exit;
      },
      child: UpgradeAlert(
        dialogStyle: Platform.isIOS ? UpgradeDialogStyle.cupertino : UpgradeDialogStyle.material,
        showIgnore: false,
        showReleaseNotes: false,
        child: SafeArea(
          child: Scaffold(
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeight / 60,
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth / 30),
                        child: customeText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          text: sliderHeadingText[_currentIndex],
                          style: ConstantTextStyle.carouselSliderText,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: screenHeight / 100,
                    // ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: screenHeight/100),
                      child:  CarouselSlider(
                        options: CarouselOptions(
                          height:
                          ImageExpanding
                              ? screenHeight /6.5
                              : screenHeight / 2.1,
                          autoPlay: true,
                          viewportFraction: 1.0,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              // isImageActive = !isImageActive;
                              _currentIndex = index;
                            });
                          },
                        ),
                        items: imagesList.map((banner) {
                          return Card(
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                color: Colors.cyan,
                                width: ImageExpanding
                                  ? screenWidth / 6
                                  : screenWidth /2,),
                              // Image.asset(
                              //   banner ?? ConstantImage.imageIsNotAvailable,
                              //   width: ImageExpanding
                              //       ? screenWidth / 6
                              //       : screenWidth /2,
                              //   fit: BoxFit.fill,
                              //   errorBuilder: (context, error, stackTrace) {
                              //     return Image.asset(
                              //       ConstantImage.imageIsNotAvailable,
                              //       fit: BoxFit.fill,
                              //     );
                              //   },
                              // ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    // SizedBox(
                    //   height: screenHeight / 100,
                    // ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth / 30),
                        child: customeText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          text: sliderHeadingText2[_currentIndex],
                          style: ConstantTextStyle.carouselSliderText,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    // SizedBox(height: screenHeight / 100,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  imagesList.asMap().entries.map((entry){
                        final index = entry.key;
                        return  dotS(
                          // width: _currentCarouselPage3 == index ? screenWidth / 30.0:screenWidth / 50.0,
                          height:  ImageExpanding == index ? screenHeight / 200.0 : screenHeight/150.0,
                          width: ImageExpanding
                              ? screenWidth / 70
                              : screenWidth / 60.0,
                          // height:  screenHeight/30.0,
                          margin: EdgeInsets.symmetric(
                              horizontal: screenWidth/100.0
                          ),
                          // shape: BoxShape.rectangle,
                          color: _currentIndex == index
                              ? ConstantColor.primaryMainColor
                              : ConstantColor.primaryGreyColor,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
                
            floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked,
            floatingActionButton: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  color: ConstantColor.primaryBackgroundMainColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  border: Border(
                    top: BorderSide(
                      color: ConstantColor.GrayLineColor,
                      width: 1.0, // Set the border width
                    ),
                  ),
                ),
                padding: EdgeInsets.only(
                    left: screenWidth / 30,
                    right: screenWidth / 30,
                    top: screenHeight / 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customeText(
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.start,
                      text: "LOGIN OR SIGNUP ",
                      style: ConstantTextStyle.topCategoryText,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 100.0),
                    customeText(
                        textAlign: TextAlign.start,
                        text: "Please enter your 10 digit phone no. to proceed",
                        overflow: TextOverflow.ellipsis,
                        style: ConstantTextStyle.checkboxTextStyle1),
                    SizedBox(height: MediaQuery.of(context).size.height / 80.0),
                    /*----------------------------------Text form field start------------------------------------------*/
                    // const PhoneFieldHint(),
                    loginFlagTextField(
                      onFocusChange: (hasFocus) {
                        setState(() {
                          ImageExpanding = hasFocus;
                        });
                      },
                      // inputFormatters: [MobileNumberInputFormatter()],
                      onChanged: (value) {
                        final formattedValue =
                        mobileNumberFormatter.formatEditUpdate(
                          TextEditingValue.empty,
                          TextEditingValue(text: value),
                        );
                        mobileController.value = mobileController.value.copyWith(
                          text: formattedValue.text,
                          selection: formattedValue.selection,
                        );
                      },
                      maxLength: 10,
                      autofocus: false,
                      controller: mobileController,
                      borderSideColor: ConstantColor.transparent1,
                      focusNode: _focusNode,
                      context: context,
                      hintText: "Mobile Number",
                      //   labelStyle: ConstantTextStyle.lableTextStyle2,
                      hintStyle: ConstantTextStyle.hintTextStyle,
                      cursorColor: ConstantColor.primaryMainColor,
                      keyboardType: TextInputType.number,
                    ),
                    /*----------------------------------Text form field end------------------------------------------*/
                    /*----------------------------------checkBox start------------------------------------------*/
                    Row(
                      children: [
                        customeCheckbox(
                          checkColor: ConstantColor.primaryBackgroundMainColor,
                          activeColor: ConstantColor.primaryMainColor,
                          value: valuefirst,
                          onChanged: (bool? value) {
                            setState(() {
                              valuefirst = value!;
                            });
                            String? error = validateCheckbox(value);
                            if (error != null) {}
                          },
                        ),
                        /*----------------------------------checkBox end------------------------------------------*/
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/termsAndConditions');
                            FocusScope.of(context).unfocus();
                          },
                          child: customRichText(
                            text1: "I agree to the ",
                            textAlign: TextAlign.start,
                            style1: ConstantTextStyle.checkboxTextStyle1,
                            text2: "Terms and conditions",
                            style2: ConstantTextStyle.checkboxTextStyle2,
                          ),
                        ),
                      ],
                    ),
                    Builder(
                      builder: (context) {
                        bool isMobileNumberValid = RegExp(r'^[6789]\d{9}$').hasMatch(mobileController.text);
                        return customButton(
                          textStyleButton: ConstantTextStyle.loginButtonTextStyle,
                          onPressed:
                          isMobileNumberValid && valuefirst
                              ? () {
                            if (_formKey.currentState!.validate()) {
                              // Call the API
                              fetchLoginScreenApi(context:context, mobileController:mobileController);
                            } else {
                              LoadingScaffoldMessage.showSnackbar(
                                context,
                                '\t\tPlease enter a valid mobile number\t\t',
                                ConstantColor.primaryMainColor,
                                const Duration(seconds: 3),
                              );
                            }
                          }
                              : () {
                            if (mobileController.text.isEmpty) {
                              LoadingScaffoldMessage.showSnackbar(
                                context,
                                '\t\tPlease Enter Your Mobile Number\t\t',
                                ConstantColor.primaryMainColor,
                                const Duration(seconds: 3),
                              );
                            }
                            else if (!isMobileNumberValid) {
                              LoadingScaffoldMessage.showSnackbar(
                                context,
                                '\t\tPlease Enter Your Mobile Number\t\t',
                                ConstantColor.primaryMainColor,
                                const Duration(seconds: 3),
                              );
                            }
                            else if (!valuefirst) {
                              LoadingScaffoldMessage.showSnackbar(
                                context,
                                '\t\tPlease accept the terms and conditions\t\t',
                                ConstantColor.primaryMainColor,
                                const Duration(seconds: 3),
                              );
                            }
                          },
                          text: 'Next',
                          backgroundColor: isMobileNumberValid
                              ? ConstantColor.primaryMainColor
                              : ConstantColor.primaryGreyColor,
                          borderRadius: BorderRadius.circular(5.0),
                          minimumSize: Size(
                            screenWidth,
                            screenHeight / 25.0,
                          ),
                        );
                      },
                    ),
                    Platform.isIOS ? SizedBox(height: screenHeight/80,):Container(),
                    // if (Platform.isIOS) {
                    // Widget to hide for iOS devices
                    Platform.isIOS ? GestureDetector(
                      onTap:() {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => MyHomePageDemo1(
                        //       mobilenumber: '',
                        //       lat: '',
                        //       longitude: '',
                        //       id: '',
                        //       lName: '',
                        //     ),
                        //   ),
                        // );
                      },
                      child: Center(
                        child: customeText(
                          overflow: TextOverflow.clip,

                          text:'Continue without login',
                          style: ConstantTextStyle.withoutLoginText,
                        ),
                      ),
                    ):Container(),
                    // },
                    SizedBox(height: screenHeight/80,),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Function(String)? onPhoneNumberSet;
}
