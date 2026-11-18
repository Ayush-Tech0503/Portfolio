// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../../Api Services/Check Login Api Services/login_check_resent_otp_api_services.dart';
import '../../Util/constaint_textstyle.dart';
import '../../Util/constant_color.dart';
import '../../Util/string_utils.dart';
import '../Custome Widget/screen_widget.dart';
import '../custome_button_.dart';
import '../custome_richtext.dart';
import '../login_textformfiled.dart';
import '../../Api Services/Check Login Api Services/login_check_password_verification_api_services.dart';

class CheckIsLoginPasswordScreen extends StatefulWidget {
  final String mobilenumber;

  const CheckIsLoginPasswordScreen(
      {super.key, required this.mobilenumber}); // Corrected constructor

  @override
  _CheckIsLoginPasswordScreenState createState() => _CheckIsLoginPasswordScreenState();
}

class _CheckIsLoginPasswordScreenState
    extends State<CheckIsLoginPasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  final MobileNumberInputFormatter mobileNumberFormatter =
      MobileNumberInputFormatter();
  bool valuefirst = false;

  String? validateCheckbox(bool? value) {
    if (value == null || value == false) {
      return 'Please accept the terms and conditions';
    }
    return null;
  }

  final _formKey = GlobalKey<FormState>();

  String password = '';
  bool _passwordVisible = false;
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return  Form(
      key: _formKey,
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(18.0)),
        ),
        backgroundColor: ConstantColor.primaryBackgroundMainColor,
        title: const Text('Enter Your Password!'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            customRichText(
              text1: 'Please Enter Your Password to continue\n with',
              text2: " +91 ${widget.mobilenumber}",
              TextAlign: TextAlign.start,
              style1: ConstantTextStyle.lableTextSubHeading2,
              style2: ConstantTextStyle.tabButtonTextStyle,
            ),
            SizedBox(height: screenHeight / 40),
            Card(
              elevation: 3,
              child: passwordTextFormField(
                // maxLength: 10,
                fillColor: ConstantColor.primaryBackgroundMainColor,
                controller: passwordController,
                filled: true,
                obscureText: !_passwordVisible,
                borderSideColor: _isFocused
                    ? ConstantColor.primaryMainColor
                    : ConstantColor.transparent1,
                focusNode: _focusNode,
                context: context,
                iconButton: IconButton,
                hintText: " *  *  *  *  *  *  *  * ",
                hintStyle: ConstantTextStyle.otpHintTextStyle,
                labelText: "Password",
                labelStyle: ConstantTextStyle.lableTextStyle2,
                cursorColor: ConstantColor.primaryMainColor,
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return 'Please enter your Password';
                //   }
                //   return null;
                // },
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility_off : Icons.visibility,
                    color: ConstantColor.primaryGreyColor,
                    size: 25.0,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight / 80),
              child: customeButton(
                textStyleButton: ConstantTextStyle.loginButtonTextStyle,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    CheckLoginPassWordVerifyApi.fetchPassWordScreenApi(
                        context: context,
                        mobile: widget.mobilenumber,
                        password: passwordController.text.toString(),
                      onCompleted: () {
                     Navigator.of(context).pop();
                      },
                    );
                  }
                },
                text: "Verify",
                backgroundColor: password.isEmpty
                    ? ConstantColor.primaryGreyColor
                    : ConstantColor.primaryMainColor,
                borderRadius: BorderRadius.circular(10),
                minimumSize: Size(screenWidth, screenHeight / 25.0),
              ),
            ),
            // SizedBox(height: screenHeight/40),
            loginPasswordAvtar(
              context: context,
              circleText: "OR".toUpperCase(),
              backCircleRadius: 20.0,
              frontCircleRadius: 17.0,
            ),
          ],
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: screenWidth / 30),
        titlePadding: EdgeInsets.symmetric(
            horizontal: screenWidth / 30, vertical: screenHeight / 60),
        actions: [
          const SizedBox(width: 10.0),
          Center(
            child: customeButton(
              textStyleButton: ConstantTextStyle.loginButtonTextStyle,
              onPressed: () {
                CheckOtpApiScreen.sendOtpScreenApi(
                  context: context,
                  mobile: widget.mobilenumber,
                );
                Navigator.of(context).pop();
              },
              text: "Login with OTP",
              backgroundColor: ConstantColor.loginWithOtpButtonColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}
