// ignore_for_file: prefer_typing_uninitialized_variables, library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import '../../Api Services/Check Login Api Services/login_check_resent_otp_api_services.dart';
import '../../Util/constaint_textstyle.dart';
import '../../Util/constant_color.dart';
import '../../Util/string_utils.dart';
import '../custome_button_.dart';
import '../custome_richtext.dart';
import '../login_textformfiled.dart';
import '../../Api Services/Check Login Api Services/login_check_otp_verification_api_services.dart';

class CheckIsLoginOtpScreen extends StatefulWidget {
  final String mobilenumber;
  final responseStatus;
  final VoidCallback? onCloseDialog;

  const CheckIsLoginOtpScreen(
      {super.key,
      required this.mobilenumber,
      this.responseStatus, this.onCloseDialog}); // Corrected constructor

  @override
  _CheckIsLoginOtpScreenState createState() => _CheckIsLoginOtpScreenState();
}

class _CheckIsLoginOtpScreenState extends State<CheckIsLoginOtpScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  final MobileNumberInputFormatter mobileNumberFormatter =
      MobileNumberInputFormatter();
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
  String? otp = "";

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Form(
      key: _formKey,
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(18.0)),
        ),
        backgroundColor: ConstantColor.primaryBackgroundMainColor,
        title: const Text('Enter Your OTP!'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            customRichText(
              text1: 'Please Enter The OTP Send to Mobile\nNumber',
              text2: " +91 ${widget.mobilenumber}",
              TextAlign: TextAlign.start,
              style1: ConstantTextStyle.lableTextSubHeading2,
              style2: ConstantTextStyle.tabButtonTextStyle,
            ),
            SizedBox(height: screenHeight / 40),
            Column(
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
                    fillColor: ConstantColor.primaryBackgroundMainColor,
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
                        textStyleButton: ConstantTextStyle.otpResendButtonText,
                        onPressed: _isResendButtonDisabled
                            ? null
                            : () {
                                CheckOtpApiScreen.sendOtpScreenApi(
                                  context: context,
                                  mobile: widget.mobilenumber,
                                );
                                Navigator.pop(context);
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
              ],
            ),
            // SizedBox(height: screenHeight/40),
          ],
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: screenWidth / 30),
        titlePadding: EdgeInsets.symmetric(
            horizontal: screenWidth / 30, vertical: screenHeight / 60),
        actions: [
          // const SizedBox(width: 10.0),
          customeButton(
            textStyleButton: ConstantTextStyle.loginButtonTextStyle,
            onPressed: otpController.text.isEmpty ? null : () {
              if (_formKey.currentState!.validate()) {
                if (widget.responseStatus == "Register first") {
                  VerifyNewCheckLoginOTPApi.fetchNewUserLoginScreenApi(
                    context: context,
                    mobile: widget.mobilenumber,
                    otp: otpController.text,
                  );
                } else {
                  VerifyOldCheckLoginOTPApi.fetchOtpPassWordScreenApi(
                    context: context,
                    mobile: widget.mobilenumber,
                    otp: otpController.text,
                  );
                }
              }
            },
            text: "Verify",
            backgroundColor: ConstantColor.primaryMainColor,
            borderRadius: BorderRadius.circular(10),
            minimumSize: Size(screenWidth, screenHeight / 25.0),
          ),
        ],
      ),
    );
  }
}


