// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable, deprecated_member_use, empty_catches, use_build_context_synchronously
import 'dart:async';
import 'package:citybazaronline_seller_app/Services/password_otp_verification_api_services/login_with_otp_new_user_api_services.dart';
import 'package:flutter/material.dart';
import '../../Layouts/constant_screen_layout.dart';
import '../../Services/Login_with_otp_api_services/login_with_otp_api_services.dart';
import '../../Services/password_otp_verification_api_services/password_otp_verification_api_services.dart';
import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';
import '../../Widget/Alert Dialogs/alert_dialog_widget.dart';
import '../../Widget/Custome Buttons/elevetion_button_widget.dart';
import '../../Widget/Text Form Fields/password_text_form.dart';
import '../../Widget/custome_rich_text.dart';

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
  // String? mobilenumber;
  // dynamic responseStatus;

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
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return  WillPopScope(
      onWillPop: () async {
        bool confirmExit = await YesNoPermissionDialog.showExitConfirmationDialog(
            context: context, title: "Please confirm!", content: "Are you sure want to go back?", actions: [
          customButton(
              elevation: 0,
              backgroundColor: ConstantColor.primaryBackgroundMainColor,
              onPressed: (){Navigator.of(context).pop(true);},
              text: "Yes",
              textStyleButton: ConstantTextStyle.hintTextStyle2),
          const SizedBox(width: 10.0,),
          customButton(
              elevation: 0,
              backgroundColor: ConstantColor.primaryBackgroundMainColor,
              onPressed: (){Navigator.of(context).pop(false);},
              text: "No",
              textStyleButton: ConstantTextStyle.hintTextStyle2),

        ]);
        return confirmExit;
      },
      child: AppLayout(
        title: "Enter OTP",
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            bool confirmExit =  await YesNoPermissionDialog.showExitConfirmationDialog(
                context: context, title: "Please confirm!", content: "Are you sure want to go back?", actions: [
              customButton(
                  elevation: 0,
                  backgroundColor: ConstantColor.primaryBackgroundMainColor,
                  onPressed: () => Navigator.of(context).pop(true),
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
            if (confirmExit) { Navigator.of(context).pop();}
          },
        ),
        scaffoldColor: ConstantColor.secondryBackgroundMainColor,
        appBarColor: ConstantColor.secondryBackgroundMainColor,
        body:  Container(
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
                textAlign: TextAlign.start,
                style1: ConstantTextStyle.lableTextSubHeading2,
                style2: ConstantTextStyle.tabButtonTextStyle,
              ),
              SizedBox(height: screenHeight / 40.0),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      customTextFormField(
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
                        suffixIcon:
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth / 30,
                              vertical: screenHeight / 100),
                          child:
                          customButton(
                            textStyleButton:
                            ConstantTextStyle.otpResendButtonText,
                            onPressed: _isResendButtonDisabled
                                ? null
                                : () async {
                             await sendOtpScreenApi(
                                context: context,
                                mobile: widget.mobilenumber
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
              customButton(
                textStyleButton: ConstantTextStyle.loginButtonTextStyle,
                onPressed: ()
                {
                  if (_formKey.currentState!.validate()) {
                    if (widget.responseStatus == "Register first") {
                      fetchNewUserOtpVerifyApi(
                        context: context,
                        body: {
                          "mobile": widget.mobilenumber,
                          "otp": otpController.text.toString(),
                          "device_token": 'app',
                        }
                      );
                    } else {
                      fetchPasswordAndOtpVerifyApi(
                        context: context,
                        body: {
                          "mobile": widget.mobilenumber,
                          "password": otpController.text.toString(),
                          "type": 'otp',
                          "device_token": 'app',
                        }
                      );
                    }
                  }
                  FocusScope.of(context).unfocus();
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
