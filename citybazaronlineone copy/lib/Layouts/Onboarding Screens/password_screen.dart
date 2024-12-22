// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:Citybazar_app/Api%20Services/Otp%20Screen%20Apis/otp%20_screen_api.dart';
import 'package:flutter/material.dart';
import '../../Api Services/Password Screen Api/password_screen_api.dart';
import '../../Util/constaint_textstyle.dart';
import '../../Util/constant_color.dart';
import '../../Widgets/Custome Widget/screen_widget.dart';
import '../../Widgets/custome_button_.dart';
import '../../Widgets/custome_icon_button.dart';
import '../../Widgets/custome_richtext.dart';
import '../../Widgets/custome_text.dart';
import '../../Widgets/login_textformfiled.dart';
class PasswordScreen extends StatefulWidget {
  final String mobilenumber;
  const PasswordScreen({super.key, required this.mobilenumber, });

  @override
  State<PasswordScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<PasswordScreen> {
/*------------------------textEditorControllers ----------------------------*/
// ignore: non_constant_identifier_names
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
/*------------------------textEditorControllers ----------------------------*/
  bool _passwordVisible = false;
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  String password = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        //  Navigator.of(context).pop(true);
        bool confirmExit =await BackScreenDialog.showExitConfirmationDialog(context);
        return confirmExit;
      },
      child: Container(
        color: ConstantColor.loginWithOtpButtonColor,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: ConstantColor.secondryBackgroundMainColor,
            appBar: AppBar(
              elevation: 0.0,
              centerTitle: true,
              leading: Builder(
                builder: (BuildContext context) {
                  return customeIconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: ConstantColor.landingScreenSubHaddingColor,
                    onPressed: ()
                    async {
                      bool confirmExit = await BackScreenDialog.showExitConfirmationDialog(context);
                      if (confirmExit) {
                        Navigator.of(context).pop();
                      }
                      }
                  );
                },
              ),
              title:  customeText(
                    text: "Enter Password",
                    style: ConstantTextStyle.lableTextHeading1),

              backgroundColor: ConstantColor.secondryBackgroundMainColor,
            ),
            body: Container(
              color: ConstantColor.secondryBackgroundMainColor,
              padding: EdgeInsets.symmetric(horizontal: screenWidth/30,),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight / 30.0),
                      customRichText(
                        text1: 'Please Enter Your Password to continue\n with',
                        text2: " +91 ${widget.mobilenumber}",
                        TextAlign: TextAlign.start,
                        style1: ConstantTextStyle.lableTextSubHeading2,
                        style2: ConstantTextStyle.tabButtonTextStyle,
                      ),
                      SizedBox(height: screenHeight / 40.0),
/*------------------------Password Text Form field Start------------------------------------*/
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
                              _passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
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
/*------------------------Password Text Form field end------------------------------------*/

///////////////verify button start///////////////
                      SizedBox(height: screenHeight / 50,),
                      customeButton(
                        textStyleButton: ConstantTextStyle.loginButtonTextStyle,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            PassWordApiScreen.fetchPassWordScreenApi(
                                context: context,
                                mobile: widget.mobilenumber,
                                password: passwordController.text.toString());
                          }
                        },
                        text: "Verify",
                        backgroundColor: password.isEmpty
                            ? ConstantColor.primaryGreyColor
                            : ConstantColor.primaryMainColor,
                        borderRadius: BorderRadius.circular(10),
                        minimumSize: Size(screenWidth, screenHeight / 25.0),
                      ),

/////////////verify button end///////////////
/////////////Divider and text with circle avatar start///////////////
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight / 30.0,
                        ),
                        child: loginPasswordAvtar(
                          context: context,
                          circleText: "OR".toUpperCase(),
                          backCircleRadius: 20.0,
                          frontCircleRadius: 17.0,
                        ),
                      ),
///////////////Divider and text with circle avatar end///////////////
///////////////Login with otp button start///////////////
                      Center(
                        child: customeButton(
                          textStyleButton:
                              ConstantTextStyle.loginButtonTextStyle,
                          onPressed: () async{
                            OtpApiScreen.sendOtpScreenApi(
                              context: context,
                              mobile: widget.mobilenumber,
                            );
                          },
                          text: "Login with OTP",
                          backgroundColor:
                              ConstantColor.loginWithOtpButtonColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
///////////////Login with otp button end///////////////
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class BackScreenDialog {
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
        content: const Text('Are you sure want to go back?'),
        contentPadding: EdgeInsets.symmetric(horizontal: screenWidth/30),
        titlePadding: EdgeInsets.symmetric(horizontal: screenWidth/30,vertical: screenHeight/60),
        actions: [
          ElevatedButton(
            onPressed: (){
              Navigator.of(context).pop(true);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ConstantColor.primaryBackgroundMainColor,
            ),
            child: Text('Yes', style: ConstantTextStyle.hintTextStyle2),
          ),
          const SizedBox(width: 10.0,),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            style: ElevatedButton.styleFrom(
              backgroundColor: ConstantColor.primaryBackgroundMainColor,
            ),
            child: Text('No',style: ConstantTextStyle.hintTextStyle2,),
          ),
        ],
      ),
    ) ?? false;
  }
}