// ignore_for_file: library_private_types_in_public_api

import 'package:Citybazar_app/Widgets/custome_richtext.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../../Layouts/Onboarding Screens/login_screen.dart';
import '../../Layouts/User Profile My Account/Term Of Use/term_and_condition.dart';
import '../../Util/constaint_textstyle.dart';
import '../../Util/constant_color.dart';
import '../../Util/string_utils.dart';
import '../custome_button_.dart';
import '../custome_checkbox.dart';
import '../login_textformfiled.dart';
import '../../Api Services/Check Login Api Services/login_check_mobile_number_api_services.dart';

class CheckIsLogin extends StatefulWidget {
  const CheckIsLogin({super.key}); // Corrected constructor

  @override
  _CheckIsLoginState createState() => _CheckIsLoginState();
}

class _CheckIsLoginState extends State<CheckIsLogin> {
  TextEditingController otpController = TextEditingController();
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

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    mobileController.addListener(() {});
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
    super.dispose();
  }

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
        title: const Text('Login Required!'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Please enter your 10 digit phone no. to process.",style: ConstantTextStyle.checkboxTextStyle1),
            SizedBox(height: screenHeight / 80),
            loginFlagTextField(
              onChanged: (value) {
                final formattedValue = mobileNumberFormatter.formatEditUpdate(
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
              hintStyle: ConstantTextStyle.hintTextStyle,
              cursorColor: ConstantColor.primaryMainColor,
              keyboardType: TextInputType.number,
            ),
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

                  SizedBox(width: screenWidth/80,),
                Flexible(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TermConditionScreen()));
                    },
                    child: customRichText(
                      TextAlign: TextAlign.start,
                      text1: "I agree to the ",
                      style1: ConstantTextStyle.checkboxTextStyle1,
                      text2: "Terms and conditions",
                      style2: ConstantTextStyle.checkboxTextStyle2
                    ),
                  
                  ),
                ),
              ],
            ),
          ],
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: screenWidth / 30),
        titlePadding: EdgeInsets.symmetric(horizontal: screenWidth / 30, vertical: screenHeight / 60),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            style: ElevatedButton.styleFrom(
              backgroundColor: ConstantColor.primaryBackgroundMainColor,
            ),
            child: const Text('Cancel'),
          ),
          const SizedBox(width: 10.0),
          // TextButton(
          //   onPressed: () {
          //     // You can access the entered text using mobileController.text
          //     login(mobileController.text);
          //   },
          //   child: Text('Login'),
          // ),
          Builder(
            builder: (context) {
              //bool isMobileNumberValid = mobileController.text.length == 10;
              // final formattedMobileNumber = MobileNumberInputFormatter.formatMobileNumber(mobileController.text);
              // bool isMobileNumberValid = RegExp(r'^[6789]\d{9}$').hasMatch(formattedMobileNumber);
              bool isMobileNumberValid =
                  RegExp(r'^[6789]\d{9}$').hasMatch(mobileController.text);
              return customeButton(
                textStyleButton: ConstantTextStyle.loginButtonTextStyle,
                onPressed: isMobileNumberValid && valuefirst
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          // Call the API
                          CheckLoginFetchLoginApi.fetchLoginScreenApi(
                              context: context,
                              mobileController: mobileController,
                              otpController: otpController,
                              //context, mobileController, otpController
                          );
                        } else {
                          Toast.show(
                            'Please enter a valid mobile number',
                            backgroundColor: ConstantColor.primaryBackgroundMainColor,
                            textStyle: ConstantTextStyle.textFormFildStyle,
                            duration: Toast.lengthLong,
                            //     gravity: Toast.top,
                          );
                        }
                      }
                    : () {
                        if (mobileController.text.isEmpty) {
                          showShrinkingToast(
                              context, 'Please Enter Your Mobile Number');
                        } else if (!isMobileNumberValid) {
                          showShrinkingToast(
                              context, 'Please Enter Valid Mobile Number');
                        } else if (!valuefirst) {
                          showShrinkingToast(context,
                              'Please accept the terms and conditions');
                        }
                      },
                text: 'Next',
                backgroundColor: isMobileNumberValid
                    ? ConstantColor.primaryMainColor
                    : ConstantColor.primaryGreyColor,
                borderRadius: BorderRadius.circular(8.0),
                //    minimumSize: Size(screenWidth, screenHeight / 25.0,),
              );
            },
          ),
        ],
      ),
    );
  }
}