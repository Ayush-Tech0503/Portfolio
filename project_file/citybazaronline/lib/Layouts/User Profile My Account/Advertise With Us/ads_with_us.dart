// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Util/Constant APi Url/api_urls.dart';
import '../../../Util/constaint_textstyle.dart';
import '../../../Util/constant_color.dart';
import '../../../Widgets/custome_button_.dart';
import '../../../Widgets/custome_text.dart';
import '../../../Widgets/login_textformfiled.dart';

class AdvertiseWithUsScreen extends StatefulWidget {
  const AdvertiseWithUsScreen({super.key});

  @override
  State<AdvertiseWithUsScreen> createState() => _AdvertiseWithUsScreenState();
}

class _AdvertiseWithUsScreenState extends State<AdvertiseWithUsScreen>{
/*-------------------------form field nodes and string start --------------------------*/
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();

  bool _isFocused = false;
  bool _isFocused1 = false;
  bool _isFocused2 = false;
  bool _isFocused3 = false;
  bool _isFocused4 = false;

  final _formKey = GlobalKey<FormState>();

  String name = '';
  String businessName = '';
  String mobileNumber = '';
  String email = '';
  String aboutBusinessValue = '';

  get valuefirst => null;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
    _focusNode1.addListener(() {
      setState(() {
        _isFocused1 = _focusNode1.hasFocus;
      });
    });

    _focusNode2.addListener(() {
      setState(() {
        _isFocused2 = _focusNode2.hasFocus;
      });
    });

    _focusNode3.addListener(() {
      setState(() {
        _isFocused3 = _focusNode3.hasFocus;
      });
    });

    _focusNode4.addListener(() {
      setState(() {
        _isFocused4 = _focusNode4.hasFocus;
      });
    });
  }
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController aboutBusinessController = TextEditingController();
  bool isLoading = false;
  var responseData;
  var userId;
  var tokenAccess;
  fetchAddWithUsApi({name, email, mobile, bussinessName, aboutBussness}) async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      tokenAccess = preference.getString("access-token");
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Row(
              children: [
                const CircularProgressIndicator(
                  color: ConstantColor.primaryMainColor,
                ),
                const SizedBox(width: 20),
                Text(
                  'Submitting...',
                  style: ConstantTextStyle.allHomeScreenAvatarText,
                ),
              ],
            ),
          );
        },
      );

      FormData formData = FormData.fromMap({
        "name": name,
        "bussiness_name": bussinessName,
        "mobile": mobile,
        "email": email,
        "about_bussness": aboutBussness,
      });
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.addWithUsApi}",
        options: Options(
          headers: {
            "Authorization": tokenAccess,
            'Content-Type': 'text/plain',
          },
        ),
        data: formData,
      );
      Navigator.pop(context);
      if (response.statusCode == 200) {
        responseData = json.decode(response.data);
        if (responseData["status"] == "success") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Submitted Successfully"),
            backgroundColor: Colors.green,
          ));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const AdvertiseWithUsScreen(),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(responseData["msg"]),
            backgroundColor: Colors.red,
          ));
        }
      }
    } catch (e) {
      // Handle errors appropriately
    }
  }

  /*-------------------------form field nodes and string end --------------------------*/
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: ConstantColor.loginWithOtpButtonColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ConstantColor.secondryBackgroundMainColor,
          key: _scaffoldKey,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: ConstantColor.primaryBackgroundMainColor,
        iconTheme: const IconThemeData(color: ConstantColor.loginWithOtpButtonColor),
        title: customeText(textAlign: TextAlign.start,
        text: "Advertise With Us", style: ConstantTextStyle.secodHearText),
      ),
      
          body: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth/20,
            vertical: screenHeight/60),
            children: [
              customeText(
                text: "Advertise With us",
                textAlign: TextAlign.start,
                style: ConstantTextStyle.secodHearText1,
              ),
              SizedBox(height: screenHeight /60,),
              customeText(
                text:
                "Are easy to find, so a visitor can quickly get in touch with you.",
                style: ConstantTextStyle.becomeSellerDiscText,
              ),
      
      /*-------------------------------Contact form start-------------------------------------------*/
              SizedBox(height: screenHeight /40,),
              Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: ConstantColor.primaryBackgroundMainColor,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: ConstantColor.progressBGolor)
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
      /*------------------------------Name filed start----------------------------------*/
                    // customeText(
                    //   text: "Name *",
                    //   style: ConstantTextStyle.topCategoryText2,
                    //   textAlign: TextAlign.start
                    // ),
                      SizedBox(height: screenHeight / 100),
                      loginTextFormField2(
                        controller: nameController,
                        textFormPaddingHorizontal: screenWidth /40,
                        textFormPaddingVertical: screenHeight / 50,
                        minLines: 1,
                        maxLines: 1,
                        borderSideColor: _isFocused
                            ? ConstantColor.primaryMainColor
                            : ConstantColor.transparent1,
                        focusNode: _focusNode,
                        context: context,
                        fillColor: ConstantColor.primaryBackgroundMainColor,
                        filled: true,
                        iconButton: IconButton,
                        labelText: "Name *",
                        labelStyle: ConstantTextStyle.lableTextStyle2,
                        cursorColor: ConstantColor.primaryMainColor,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter name';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            name = value;
                          });
                        },
                      ),

      /*------------------------------Name filed end----------------------------------*/
                      SizedBox(height: screenHeight /80),
      /*------------------------------Email filed start----------------------------------*/
                      // customeText(
                      //     text: "Email *",
                      //     style: ConstantTextStyle.topCategoryText2,
                      //     textAlign: TextAlign.start
                      // ),
                      SizedBox(height: screenHeight / 100),
                      loginTextFormField2(
                        controller: emailController,
                        textFormPaddingHorizontal: screenWidth / 40,
                        textFormPaddingVertical: screenHeight / 50,
                        minLines: 1,
                        maxLines: 1,
                        borderSideColor: _isFocused1
                            ? ConstantColor.primaryMainColor
                            : ConstantColor.transparent1,
                        focusNode: _focusNode1,
                        context: context,
                        fillColor: ConstantColor.primaryBackgroundMainColor,
                        filled: true,
                        iconButton: IconButton,
                        // hintText: "Email",
                        // hintStyle: ConstantTextStyle.sellerHintTextStyle,
                        labelText: "Email *",
                        labelStyle: ConstantTextStyle.lableTextStyle2,
                        cursorColor: ConstantColor.primaryMainColor,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter email';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),

      /*------------------------------Email filed end----------------------------------*/

                      SizedBox(height: screenHeight /80),

      /*------------------------------Mo.no. filed start----------------------------------*/
                      // customeText(
                      //     text: "Mobile Number *",
                      //     style: ConstantTextStyle.topCategoryText2,
                      //     textAlign: TextAlign.start
                      // ),
                      SizedBox(height: screenHeight / 100),
                      loginTextFormField2(
                        controller: mobileController,
                        textFormPaddingHorizontal: screenWidth / 40,
                        textFormPaddingVertical: screenHeight / 50,
                        minLines: 1,
                        maxLines: 1,
                        borderSideColor: _isFocused2
                            ? ConstantColor.primaryMainColor
                            : ConstantColor.transparent1,
                        focusNode: _focusNode2,
                        context: context,
                        fillColor: ConstantColor.primaryBackgroundMainColor,
                        filled: true,
                        iconButton: IconButton,
                        // hintText: "Mobile Number",
                        // hintStyle: ConstantTextStyle.sellerHintTextStyle,
                        labelText: "Mobile Number *",
                        labelStyle: ConstantTextStyle.lableTextStyle2,
                        cursorColor: ConstantColor.primaryMainColor,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter mobile number';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            mobileNumber = value;
                          });
                        },
                      ),

      /*------------------------------Mo.no. filed end----------------------------------*/

                      SizedBox(height: screenHeight / 80),

      /*------------------------------Business name filed start----------------------------------*/
                      // customeText(
                      //     text: "Business Name *",
                      //     style: ConstantTextStyle.topCategoryText2,
                      //     textAlign: TextAlign.start
                      // ),
                      SizedBox(height: screenHeight / 100),
                      loginTextFormField2(
                        controller: businessNameController,
                        textFormPaddingHorizontal: screenWidth / 40,
                        textFormPaddingVertical: screenHeight / 50,
                        minLines: 1,
                        maxLines: 1,
                        borderSideColor: _isFocused3
                            ? ConstantColor.primaryMainColor
                            : ConstantColor.transparent1,
                        focusNode: _focusNode3,
                        context: context,
                        fillColor: ConstantColor.primaryBackgroundMainColor,
                        filled: true,
                        iconButton: IconButton,
                        // hintText: "Business Name",
                        // hintStyle: ConstantTextStyle.sellerHintTextStyle,
                        labelText: "Business Name *",
                        labelStyle: ConstantTextStyle.lableTextStyle2,
                        cursorColor: ConstantColor.primaryMainColor,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter business name';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            businessName = value;
                          });
                        },
                      ),

      /*------------------------------Business name filed end----------------------------------*/

                      SizedBox(height: screenHeight /80),

      /*------------------------------About Business filed start----------------------------------*/
                      // customeText(
                      //     text: "About Business *",
                      //     style: ConstantTextStyle.topCategoryText2,
                      //     textAlign: TextAlign.start
                      // ),
                      SizedBox(height: screenHeight / 100),
                      loginTextFormField2(
                        controller: aboutBusinessController,
                        textFormPaddingHorizontal: screenWidth / 40,
                        textFormPaddingVertical: screenHeight / 80,
                        minLines: 3,
                        maxLines: 3,
                        borderSideColor: _isFocused4
                            ? ConstantColor.primaryMainColor
                            : ConstantColor.transparent1,
                        focusNode: _focusNode4,
                        context: context,
                        fillColor: ConstantColor.primaryBackgroundMainColor,
                        filled: true,
                        iconButton: IconButton,
                        // hintText: "About Business ",
                        // hintStyle: ConstantTextStyle.sellerHintTextStyle,
                        labelText: "About Business *",
                        labelStyle: ConstantTextStyle.lableTextStyle2,
                        cursorColor: ConstantColor.primaryMainColor,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter about of business';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            aboutBusinessValue = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
      
      /*-------------------------------Submit Button start---------------------------------------*/
              SizedBox(height: screenHeight / 80),
              customeButton(
                minimumSize: Size(screenWidth, screenHeight/25),
                elevation: 0.5,
                textStyleButton: ConstantTextStyle.loginButtonTextStyle,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    fetchAddWithUsApi(
                        name: nameController.text.toString() ?? "",
                        email: emailController.text.toString() ?? "",
                        mobile: mobileController.text.toString() ?? "",
                        bussinessName: businessNameController.text.toString()??"",
                        aboutBussness: aboutBusinessController.text.toString()??'');
                  }
                },
                text: "Submit",
                backgroundColor: ConstantColor.filedContainerColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
      /*-------------------------------Submit Button end---------------------------------------*/
            ],
          ),
        ),
      ),
    );
  }
}