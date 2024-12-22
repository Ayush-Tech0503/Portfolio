// ignore_for_file: deprecated_member_use, use_build_context_synchronously
import 'package:flutter/material.dart';
import '../../Layouts/constant_screen_layout.dart';
import '../../Services/Login_with_otp_api_services/login_with_otp_api_services.dart';
import '../../Services/password_otp_verification_api_services/password_otp_verification_api_services.dart';
import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';
import '../../Widget/Alert Dialogs/alert_dialog_widget.dart';
import '../../Widget/Circle Avtars/circle_avtar_title_divider.dart';
import '../../Widget/Custome Buttons/elevetion_button_widget.dart';
import '../../Widget/Text Form Fields/password_text_form.dart';
import '../../Widget/custome_rich_text.dart';
class PasswordScreen extends StatefulWidget {
  // final String mobilenumber;
  const PasswordScreen({super.key,});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
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
    final String mobileNumber = ModalRoute.of(context)!.settings.arguments as String;

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
        title: "Enter Password",
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            bool confirmExit =  await YesNoPermissionDialog.showExitConfirmationDialog(
                context: context, title: "Please confirm!", content: "Are you sure want to go back?",
                actions: [
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
                    text2: " +91 $mobileNumber",
                    textAlign: TextAlign.start,
                    style1: ConstantTextStyle.lableTextSubHeading2,
                    style2: ConstantTextStyle.tabButtonTextStyle,
                  ),
                  SizedBox(height: screenHeight / 40.0),
      /*------------------------Password Text Form field Start------------------------------------*/
                  customTextFormField(
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
      /*------------------------Password Text Form field end------------------------------------*/

      ///////////////verify button start///////////////
                  SizedBox(height: screenHeight / 50,),
                  customButton(
                    textStyleButton: ConstantTextStyle.loginButtonTextStyle,
                    onPressed: () async{
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState!.validate()) {
                        await fetchPasswordAndOtpVerifyApi(
                            context: context,
                            body: {
                              "mobile": mobileNumber,
                              "password": passwordController.text.toString(),
                              "type": 'password',
                              "device_token": 'df',
                            });
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
                              child: circleAvtarWithDivider(
                                context: context,
                                circleText: "OR".toUpperCase(),
                                backCircleRadius: 20.0,
                                frontCircleRadius: 17.0,
                              ),
                            ),
      ///////////////Divider and text with circle avatar end///////////////
      ///////////////Login with otp button start///////////////
                  Center(
                    child: customButton(
                      textStyleButton:
                      ConstantTextStyle.loginButtonTextStyle,
                      onPressed: () {
                        // OtpApiScreen.
                        FocusScope.of(context).unfocus();
                         sendOtpScreenApi(
                          context: context,
                          mobile: mobileNumber??"",
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
    );
  }
}