import 'package:Citybazar_app/Widgets/custome_richtext.dart';
import 'package:flutter/material.dart';
import '../../../Util/constaint_textstyle.dart';
import '../../../Widgets/custome_text.dart';
import '../../Util/constant_color.dart';
import '../../Widgets/custome_button_.dart';
import '../../Widgets/login_textformfiled.dart';

class AlertOTPForm extends StatefulWidget {
  const AlertOTPForm({super.key});

  @override
  State<AlertOTPForm> createState() => _AlertOTPFormState();
}

class _AlertOTPFormState extends State<AlertOTPForm> {
/*-------------------------form field nodes and string start --------------------------*/
  String selectedOption  = '';
  String otp = '';
  final FocusNode _focusNode1 = FocusNode();
  bool _isFocused1 = false;

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
          customRichText(
            text1: 'Please Enter The OTP Send to Mobile Number ',
            text2: "+91 123 123 123",
            TextAlign: TextAlign.center,
            style1: ConstantTextStyle.checkboxTextStyle1,
            style2: ConstantTextStyle.tabButtonTextStyle,),],),
      content: SingleChildScrollView(
          child: SizedBox(
            width: screenWidth,
            child: Column(
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
                    hintText: " -  -  -  -  -  - ",
                    hintStyle: ConstantTextStyle.otpHintTextStyle,
                    onChanged: (value){
                      setState(() {
                        otp = value;
                      });
                    },
                    labelText: "OTP",
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
                  SizedBox(height: screenHeight/80,),
                  customeButton(
                    textStyleButton: ConstantTextStyle.reviewsRatingsText,
                    onPressed: ()  {
                      Navigator.pop(context);},
                    text: "Verify",
                    backgroundColor: ConstantColor.primaryMainColor,
                    borderRadius: BorderRadius.circular(8.0),),]),
          )
      ),
    );

/*---------------------------------Dialog Box end----------------------------------------*/

  }
}
