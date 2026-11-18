// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable, deprecated_member_use, empty_catches
import 'dart:async';
import 'package:Citybazar_app/Layouts/Onboarding%20Screens/password_screen.dart';
import 'package:flutter/material.dart';
import '../../Api Services/Login With Otp Screen Api/login_with_otp_screen_api.dart';
import '../../Api Services/Otp Screen Apis/otp _screen_api.dart';
import '../../Util/constaint_textstyle.dart';
import '../../Util/constant_color.dart';
import '../../Widgets/custome_button_.dart';
import '../../Widgets/custome_icon_button.dart';
import '../../Widgets/custome_richtext.dart';
import '../../Widgets/custome_text.dart';
import '../../Widgets/login_textformfiled.dart';

class OtpScreen extends StatefulWidget {
  final String mobilenumber;
  final responseStatus;

  const OtpScreen({
    super.key,
    required this.mobilenumber,
    this.responseStatus,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _isResendButtonDisabled = false;

  AnimationController? _animationController;
  int levelClock = 2 * 60;

  @override
  void initState() {
    super.initState();
    // _initializeApp();
    startCountdownTimer();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });

    //------------------------------
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  String? otp = "";

  // Future<void> _initializeApp() async {
  //   // await requestPermissions();
  //   await listenForSms();
  // }

  // Future<void> requestPermissions() async {
  //   var status = await Permission.sms.request();
  //   if (status.isDenied) {}
  // }

  // Future<void> listenForSms() async {
  //   try {
  //    // await requestPermissions();
  //     await Future.delayed(const Duration(seconds: 1));
  //     await SmsAutoFill().listenForCode();
  //     // var appSignatureID = await SmsAutoFill().getAppSignature;
  //     // print("appSignatureID------------------$appSignatureID");
  //      SmsAutoFill().code.listen((String code) {
  //       setState(() {
  //         otpController.text = code;
  //       });
  //     });
  //   } catch (e) {}
  // }

  final _formKey = GlobalKey<FormState>();

  ///////////////////////////////
  int _remainingSeconds = 30;
  Timer? _countdownTimer;

  void startCountdownTimer() {
    const oneSec = Duration(seconds: 1);
    _countdownTimer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
          _isResendButtonDisabled = true;
        } else {
          _countdownTimer?.cancel();
          _isResendButtonDisabled = false;
        }
      });
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    // SmsAutoFill().unregisterListener();
    _animationController!.dispose();
    super.dispose();
  }

  ///////////////////////////////
/*------------------------textEditorControllers ----------------------------*/
  final TextEditingController otpController = TextEditingController();

/*------------------------textEditorControllers ----------------------------*/
  @override
  Widget build(BuildContext context) {
    String? mobilenumber;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        bool confirmExit =
            await BackScreenDialog.showExitConfirmationDialog(context);
        return confirmExit;
      },
      child: Container(
        color: ConstantColor.loginWithOtpButtonColor,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: ConstantColor.secondryBackgroundMainColor,
            appBar: AppBar(
                centerTitle: true,
                elevation: 0.0,
                leading: Builder(
                  builder: (BuildContext context) {
                    return customeIconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: ConstantColor.landingScreenSubHaddingColor,
                      onPressed: () async {
                        bool confirmExit =
                            await BackScreenDialog.showExitConfirmationDialog(
                                context);
                        if (confirmExit) {
                          Navigator.of(context).pop();
                        }
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const LoginScreen(),
                        //   ),
                        // );
                      },
                    );
                  },
                ),
                title: Center(
                    child: customeText(
                        text: "Enter OTP",
                        style: ConstantTextStyle.lableTextHeading1)),
                backgroundColor: ConstantColor.secondryBackgroundMainColor),
            body: Container(
              color: ConstantColor.secondryBackgroundMainColor,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth / 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight / 30.0),
                  customRichText(
                    text1: 'Please Enter The OTP Send to Mobile\nNumber',
                    text2: " +91 ${widget.mobilenumber}",
                    TextAlign: TextAlign.start,
                    style1: ConstantTextStyle.lableTextSubHeading2,
                    style2: ConstantTextStyle.tabButtonTextStyle,
                  ),
                  SizedBox(height: screenHeight / 40.0),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Card(
                            elevation: 2,
                            child: loginTextFormField1(
                              filled: true,
                              autofocus: true,
                              onChanged: (value) {
                                setState(() {
                                  otp = value;
                                });
                              },
                              controller: otpController,
                              autofillHints: [AutofillHints.oneTimeCode],
                              //  validator: (value) => validateOTP(value!),
                              fillColor:
                                  ConstantColor.primaryBackgroundMainColor,
                              borderSideColor: _isFocused
                                  ? ConstantColor.primaryMainColor
                                  : ConstantColor.transparent1,
                              focusNode: _focusNode,
                              context: context,
                              iconButton: IconButton,
                              hintText: " -  -  -  -  -  - ",
                              hintStyle: ConstantTextStyle.otpHintTextStyle,
                              labelText: "OTP",
                              labelStyle: ConstantTextStyle.lableTextStyle,
                              cursorColor: ConstantColor.primaryMainColor,
                              keyboardType: TextInputType.number,
                              suffixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth / 30,
                                    vertical: screenHeight / 100),
                                child: customeButton(
                                  textStyleButton:
                                      ConstantTextStyle.otpResendButtonText,
                                  onPressed: _isResendButtonDisabled
                                      ? null
                                      : () {
                                          OtpApiScreen.sendOtpScreenApi(
                                            context: context,
                                            mobile: widget.mobilenumber,
                                          );
                                        },
                                  text: "Resend OTP",
                                  backgroundColor:
                                      ConstantColor.secondryBackgroundMainColor,
                                  borderRadius: BorderRadius.circular(8.0),
                                  elevation: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),

/*------------------------ Timer start------------------------*/
                  Center(
                    child: Card(
                      elevation: _remainingSeconds > 0 ? 1 : 0,
                      color: _remainingSeconds > 0
                          ? ConstantColor.primaryBackgroundMainColor
                          : ConstantColor.secondryBackgroundMainColor,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth / 50,
                            vertical: screenHeight / 200),
                        child: Text(
                          _remainingSeconds > 0
                              ? 'Resend OTP $_remainingSeconds'
                              : '',
                          style: _remainingSeconds > 0
                              ? ConstantTextStyle.tabButtonTextStyle
                              : ConstantTextStyle.resendOtpTextStyle,
                        ),
                      ),
                    ),
                  ),
/*------------------------ Timer End------------------------*/
                  SizedBox(
                    height: screenHeight / 60,
                  ),
/*------------------------ verify Button start------------------------*/
                  customeButton(
                    textStyleButton: ConstantTextStyle.loginButtonTextStyle,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (widget.responseStatus == "Register first") {
                          NewUserLoginApi.fetchNewUserLoginScreenApi(
                            context: context,
                            mobile: widget.mobilenumber,
                            otp: otpController.text,
                          );
                        } else {
                          PassOTPWordApiScreen.fetchOtpPassWordScreenApi(
                            context: context,
                            mobile: widget.mobilenumber,
                            otp: otpController.text,
                          );
                        }
                      }
                    },
                    text: "Verify",
                    backgroundColor: otpController.text.isEmpty
                        ? ConstantColor.primaryGreyColor
                        : ConstantColor.primaryMainColor,
                    borderRadius: BorderRadius.circular(10),
                    minimumSize: Size(screenWidth, screenHeight / 25.0),
                  ),
/*------------------------ verify Button end------------------------*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Countdown extends AnimatedWidget {
  Countdown({super.key, required this.animation})
      : super(listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    return Text(
      timerText,
      style: TextStyle(
        fontSize: 18,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
