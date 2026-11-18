// ignore_for_file: non_constant_identifier_names, empty_catches, deprecated_member_use
import 'dart:convert';
import 'dart:io';
import 'package:Citybazar_app/Layouts/Onboarding%20Screens/password_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import 'package:toast/toast.dart';
import 'package:upgrader/upgrader.dart';
import '../../Api Services/Otp Screen Apis/otp _screen_api.dart';
import '../../Util/Const Toster/toster.dart';
import '../../Util/Constant APi Url/api_urls.dart';
import '../../Util/constaint_textstyle.dart';
import '../../Util/constant_color.dart';
import '../../Util/constant_image.dart';
import '../../Util/string_utils.dart';
import '../../Widgets/custome_button_.dart';
import '../../Widgets/custome_checkbox.dart';
import '../../Widgets/custome_richtext.dart';
import '../../Widgets/custome_text.dart';
import '../../Widgets/landing_screen_slider.dart';
import '../../Widgets/login_textformfiled.dart';
import '../../collapsing_appbar.dart';
import '../User Profile My Account/Term Of Use/term_and_condition.dart';
import 'otp_screen.dart';

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

  // Future<void> requestPermissions() async {
  //   var status = await Permission.sms.request();
  //   if (status.isDenied) {}
  // }

  void newAppUpdate()async {
    WidgetsFlutterBinding.ensureInitialized();
    await Upgrader.clearSavedSettings();
    await Upgrader().initialize();
  }

  @override
  void initState() {
    super.initState();
    newAppUpdate();
    // requestPermissions();
    ImageExpanding = false;
    mobileController.addListener(() {
      // Handle changes here
      // if($currentValue)
    });
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  fetchLoginScreenApi(context, TextEditingController mobileController, otpController) async {
    try {
/*-------------------------------loader----------------------------------*/
      showLoggingInDialog(context);
/*-------------------------------loader----------------------------------*/
      final body = {
        "mobile": mobileController.text,
      };
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.userLoginWithMobileEndPoint}",
        data: json.encode(body),
      );
      Navigator.pop(context); // loader false when user comes back
      if (response.statusCode == 200) {
        final responseData = json.decode(response.data);
        if (responseData["password"] == true &&
            responseData['msg'] == "Login success!") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PasswordScreen(
                  mobilenumber: mobileController.text.toString()),
            ),
          );
        } else if (responseData["password"] == false && responseData['msg'] == "Login success!") {
          //***********If password is false then Api Hit******************/
          if (responseData['msg'] != "Register first") {
            await OtpApiScreen.sendOtpScreenApi(
              context: context,
              mobile: mobileController.text.toString(),
            );
          }
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                responseStatus: responseData['msg'],
                mobilenumber: mobileController.text.toString(),
              ),
            ),
          );
          LoadingScaffoldMessage.showSnackbar(
            context,
            responseData['msg'],
            ConstantColor.primaryMainColor,
            const Duration(seconds: 2),
          );
        }
      }
    } catch (error) {
      if (error is DioError) {
        if (error.response?.statusCode == 500) {
          // Handle 500 error
          LoadingScaffoldMessage.showSnackbar(
            context,
            "${error.message}",
            ConstantColor.primaryMainColor,
            const Duration(seconds: 3),
          );
        } else {
          // print("Dio error: ${error.message}");
        }
      } else {}
      setState(() {});
      Navigator.pop(context);
    }
  }

  void showLoggingInDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          content: Row(
            children: [
              const CircularProgressIndicator(
                color: ConstantColor.primaryMainColor,
              ),
              const SizedBox(width: 20),
              Text(
                'Logging In...',
                style: ConstantTextStyle.allHomeScreenAvatarText,
              ),
            ],
          ),
        );
      },
    );
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

  /*-----------------------------------------------------*/
  bool ImageExpanding = false;
  final MobileNumberInputFormatter mobileNumberFormatter = MobileNumberInputFormatter();

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        bool exit = await AppCloseDialog.showExitConfirmationDialog(context);
        return exit;
      },
      child: UpgradeAlert(
        dialogStyle: Platform.isIOS ? UpgradeDialogStyle.cupertino : UpgradeDialogStyle.material,
        showIgnore: false,
        showReleaseNotes: false,
        child: Scaffold(
          body: SafeArea(
            bottom: false,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeight / 60,
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth / 30,
                        ),
                        // height: screenHeight / 20,
                        child: customeText(
                          maxLine: 2,
                          overflow: TextOverflow.ellipsis,
                          text: sliderHeadingText[_currentIndex],
                          style: ConstantTextStyle.carouselSliderText,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
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
                            elevation: 4,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.asset(
                                banner ?? ConstantImage.imageIsNotAvailable,
                                width: ImageExpanding
                                    ? screenWidth / 6
                                    : screenWidth /2,
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    ConstantImage.imageIsNotAvailable,
                                    fit: BoxFit.fill,
                                  );
                                },
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    // SizedBox(height: screenHeight/60,),
                    Center(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: screenWidth / 30),
                        // height: screenHeight / 25,
                        child: customeText(
                          maxLine: 2,
                          overflow: TextOverflow.ellipsis,
                          text: sliderHeadingText2[_currentIndex],
                          style: ConstantTextStyle.carouselSliderText,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  imagesList.asMap().entries.map((entry){
                        final index = entry.key;
                        return dotS(
                          width: ImageExpanding
                              ? screenWidth / 70
                              : screenWidth / 60.0,
                          height:  screenHeight/30.0,
                          margin: EdgeInsets.symmetric(
                            horizontal: screenWidth/100.0
                          ),
                          shape: BoxShape.circle,
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const TermConditionScreen()));
                        },
                        child: customRichText(
                          text1: "I agree to the ",
                          TextAlign: TextAlign.start,
                          style1: ConstantTextStyle.checkboxTextStyle1,
                          text2: "Terms and conditions",
                          style2: ConstantTextStyle.checkboxTextStyle2,
                        ),
                      ),
                    ],
                  ),
                  Builder(
                    builder: (context) {
                      //bool isMobileNumberValid = mobileController.text.length == 10;
                      // final formattedMobileNumber = MobileNumberInputFormatter.formatMobileNumber(mobileController.text);
                      // bool isMobileNumberValid = RegExp(r'^[6789]\d{9}$').hasMatch(formattedMobileNumber);
                      bool isMobileNumberValid = RegExp(r'^[6789]\d{9}$').hasMatch(mobileController.text);
                      return customeButton(
                        textStyleButton: ConstantTextStyle.loginButtonTextStyle,
                        onPressed: isMobileNumberValid && valuefirst
                            ? () {
                                if (_formKey.currentState!.validate()) {
                                  // Call the API
                                  fetchLoginScreenApi(
                                      context, mobileController, otpController);
                                } else {
                                  Toast.show(
                                    'Please enter a valid mobile number',
                                    backgroundColor: ConstantColor
                                        .primaryBackgroundMainColor,
                                    textStyle:
                                        ConstantTextStyle.textFormFildStyle,
                                    duration: Toast.lengthLong,
                                    //     gravity: Toast.top,
                                  );
                                }
                              }
                            : () {
                                if (mobileController.text.isEmpty) {
                                  showShrinkingToast(context,
                                      'Please Enter Your Mobile Number');
                                } else if (!isMobileNumberValid) {
                                  showShrinkingToast(context,
                                      'Please Enter Valid Mobile Number');
                                } else if (!valuefirst) {
                                  showShrinkingToast(context,
                                      'Please accept the terms and conditions');
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyHomePageDemo1(
                              mobilenumber: '',
                              lat: '',
                              longitude: '',
                              id: '',
                              lName: '',
                            ),
                          ),
                        );
                      },
                      child: Center(
                        child: customeText(
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
    );
  }

  Function(String)? onPhoneNumberSet;
}
////////////////////////////////////////////////////

class ShrinkingToast extends StatelessWidget {
  final String message;

  const ShrinkingToast({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Material(
      // elevation: 6.0,
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          color: ConstantColor.primaryMainColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

void showShrinkingToast(
  BuildContext context,
  String message, {
  bool makeContainerInvisible = false,
}) {
  OverlayState? overlayState = Overlay.of(context);
  OverlayEntry? overlayEntry;

  var shakeAmplitude = ShakeHorizontalConstant2();
  const int shakeDurationInMilliseconds =
      3000; // Set the initial duration to 3 seconds

  overlayEntry = OverlayEntry(
    builder: (BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;
      double screenHeight = MediaQuery.of(context).size.height;
      return Positioned(
        top: screenHeight / 8,
        width: screenWidth,
        child: ShakeWidget(
          duration: const Duration(milliseconds: shakeDurationInMilliseconds),
          shakeConstant: shakeAmplitude,
          autoPlay: true,
          enableWebMouseHover: true,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: shakeDurationInMilliseconds),
            opacity: makeContainerInvisible ? 0.0 : 1.0,
            child: ShrinkingToast(message: message),
          ),
        ),
      );
    },
  );
  overlayState.insert(overlayEntry);
  Future.delayed(const Duration(seconds: 2), () {
    overlayEntry!.remove();
    overlayEntry = null; // Clear the previous entry
  });
}

class AppCloseDialog {
  static Future<bool> showExitConfirmationDialog(BuildContext context) async {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            backgroundColor: ConstantColor.primaryBackgroundMainColor,
            title: const Text('Please confirm!'),
            content: const Text('Are you sure want to close this App?'),
            contentPadding: EdgeInsets.symmetric(horizontal: screenWidth / 30),
            titlePadding: EdgeInsets.symmetric(horizontal: screenWidth/30,vertical: screenHeight/60),
            actions: [
              ElevatedButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ConstantColor.primaryBackgroundMainColor,
                ),
                child: Text('Close', style: ConstantTextStyle.hintTextStyle2),
              ),
              const SizedBox(
                width: 10.0,
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ConstantColor.primaryBackgroundMainColor,
                ),
                child: Text(
                  'No',
                  style: ConstantTextStyle.hintTextStyle2,
                ),
              ),
            ],
          ),
        ) ??
        false;
  }
}
