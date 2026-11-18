import 'package:flutter/material.dart';
import '../../../Util/constaint_textstyle.dart';
import '../../../Widgets/custome_text.dart';
import '../../Util/constant_color.dart';
import '../../Widgets/Custome Widget/screen_widget.dart';
import '../../Widgets/custome_button_.dart';
import '../../Widgets/login_textformfiled.dart';

class AlertPasswordForm extends StatefulWidget {
  const AlertPasswordForm({super.key});

  @override
  State<AlertPasswordForm> createState() => _AlertPasswordFormState();
}

class _AlertPasswordFormState extends State<AlertPasswordForm> {
/*-------------------------form field nodes and string start --------------------------*/
  final FocusNode _focusNode1 = FocusNode();
  bool _isFocused1 = false;
  bool valuefirst = false;
  String password = "";
  final _formKey = GlobalKey<FormState>();
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
 /*-------------------------------Password Field start------------------------------------*/
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight/80),
                child: loginTextFormField1(
                fillColor: ConstantColor.primaryBackgroundMainColor,
                filled: true,
                borderSideColor: _isFocused1
                    ? ConstantColor.primaryMainColor
                    : ConstantColor.transparent1,
                focusNode: _focusNode1,
                context: context,
                iconButton: IconButton,
                hintText: " *  *  *  *  *  * ",
                hintStyle: ConstantTextStyle.otpHintTextStyle,
                labelText: "Password",
                labelStyle: ConstantTextStyle.lableTextStyle2,
                cursorColor: ConstantColor.primaryMainColor,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your Password';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    password = value;});},
            ),
              ),
/*-------------------------------Password Field end------------------------------------*/
/*-------------------------------next Button start------------------------------------*/
                customeButton(
                  textStyleButton: ConstantTextStyle.loginButtonTextStyle,
                  onPressed: () { if (_formKey.currentState!.validate()) {}},
                  text: "Next",
                  backgroundColor: ConstantColor.primaryMainColor,
                  borderRadius: BorderRadius.circular(10),),
/*-------------------------------next Button end------------------------------------*/
/*-------------------------------------------------------------------*/
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight/80),
                  child: loginPasswordAvtar(
                    context:context,
                    circleText: "OR".toUpperCase(),
                    backCircleRadius: 17.0,
                    frontCircleRadius: 15.0,),),
/*-------------------------------------------------------------------*/
                Center(
                  child: customeButton(
                    textStyleButton: ConstantTextStyle.loginButtonTextStyle,
                    onPressed: () {Navigator.pop(context);},
                    text: "Login with OTP",
                    backgroundColor: ConstantColor.loginWithOtpButtonColor,
                    borderRadius: BorderRadius.circular(10),),
                ),

              ]),
          )
      ),
    );

/*---------------------------------Dialog Box end----------------------------------------*/

  }
}
