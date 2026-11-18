import 'package:Citybazar_app/Widgets/custome_richtext.dart';
import 'package:flutter/material.dart';
import '../../../Util/constaint_textstyle.dart';
import '../../../Widgets/custome_text.dart';
import '../../Util/constant_color.dart';
import '../../Widgets/custome_button_.dart';
import '../../Widgets/custome_checkbox.dart';
import '../../Widgets/login_textformfiled.dart';

class AlertMobileNoForm extends StatefulWidget {
  const AlertMobileNoForm({super.key});

  @override
  State<AlertMobileNoForm> createState() => _AlertMobileNoFormState();
}

class _AlertMobileNoFormState extends State<AlertMobileNoForm> {
/*-------------------------form field nodes and string start --------------------------*/
  final FocusNode _focusNode1 = FocusNode();
  bool _isFocused1 = false;
  bool valuefirst = false;
  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(() {
      setState(() {
        _isFocused1 = _focusNode1.hasFocus;
      });
    });}

  /*-------------------------form field nodes and string end --------------------------*/

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      contentPadding: EdgeInsets.symmetric(vertical: screenHeight/40, horizontal: screenWidth/30),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          customeText(
              text: "Login or Signup".toUpperCase(),
              style: ConstantTextStyle.topCategoryText2,
              textAlign: TextAlign.center),
          SizedBox(height: screenHeight/80,),
          customeText(
              text: "If you ave an account with us, please log in.",
              style: ConstantTextStyle.checkboxTextStyle1,
              textAlign: TextAlign.center),],),
      content: SingleChildScrollView(
          child: SizedBox(
            width: screenWidth,
            child:   Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
 /*-------------------------------otp Field start------------------------------------*/
                loginTextFormField1(
                  filled: true,
                  fillColor: ConstantColor.primaryBackgroundMainColor,
                  borderSideColor: _isFocused1
                      ? ConstantColor.primaryMainColor
                      : ConstantColor.transparent1,
                  focusNode: _focusNode1,
                  context: context,
                  iconButton: IconButton,
                  hintText: "+91 1231 23123",
                  hintStyle: ConstantTextStyle.otpHintTextStyle,
                  labelText: " Mobile Number",
                  labelStyle: ConstantTextStyle.lableTextStyle,
                  cursorColor: ConstantColor.primaryMainColor,
                  keyboardType: TextInputType.number,
                  suffixIcon: Padding(
                    padding:  EdgeInsets.only(right: screenWidth/30, top: screenHeight/80,bottom: screenHeight/80),
                    child: customeButton(
                      textStyleButton: ConstantTextStyle.otpResendButtonText,
                      onPressed: () {},
                      text: "Resend OTP",
                      backgroundColor: ConstantColor.secondryBackgroundMainColor,
                      borderRadius: BorderRadius.circular(8.0),
                      elevation: 0.0,
                    ),
                  ),
                ),
/*-------------------------------otp Field end------------------------------------*/

                Row(children: [
                    customeCheckbox(
                      checkColor:
                      ConstantColor.primaryBackgroundMainColor,
                      activeColor: ConstantColor.primaryMainColor,
                      value: valuefirst,
                      onChanged: (bool? value) {
                        setState(() {
                          valuefirst = value!;
                        });
                      },
                    ),
                    customRichText(
                      text1: "I agree to the",
                      TextAlign: TextAlign.start,
                      style1: ConstantTextStyle.checkboxTextStyle1,
                      text2: " Terms and conditions",
                      style2: ConstantTextStyle.checkboxTextStyle2,
                    ),
                  ],
                ),
                customeButton(
                  textStyleButton: ConstantTextStyle.reviewsRatingsText,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: "Next",
                  backgroundColor: ConstantColor.primaryMainColor,
                  borderRadius: BorderRadius.circular(8.0),),
              ],

            ),
          )
      ),
    );

/*---------------------------------Dialog Box end----------------------------------------*/

  }
}
