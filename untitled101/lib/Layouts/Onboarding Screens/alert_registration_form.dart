// ignore_for_file: prefer_typing_uninitialized_variables, empty_catches, use_build_context_synchronously

import 'dart:convert';
import 'package:Citybazar_app/Util/Validation/validation_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Util/constaint_textstyle.dart';
import '../../../Widgets/custome_text.dart';
import '../../Models/Profile Model/getprofile_data.dart';
import '../../Util/Constant APi Url/api_urls.dart';
import '../../Util/constant_color.dart';
import '../../Widgets/custome_button_.dart';
import '../../Widgets/login_textformfiled.dart';

class AlertRegistrationForm extends StatefulWidget {
  const AlertRegistrationForm({super.key});

  @override
  State<AlertRegistrationForm> createState() => _AlertRegistrationFormState();
}

class _AlertRegistrationFormState extends State<AlertRegistrationForm> {
/*-------------------------form field nodes and string start --------------------------*/
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rfCodeController = TextEditingController();

  String selectedOption = '';
  bool passwordVisible = false;

  String name = '';
  String email = '';
  String mobile = '';
  String gender = '';
  String dob = '';
  String city = '';
  String password = '';
  String rfCode = '';

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();
  final FocusNode _focusNode6 = FocusNode();
  final FocusNode _focusNode7 = FocusNode();

  bool _isFocused1 = false;
  bool _isFocused2 = false;
  bool _isFocused3 = false;
  bool _isFocused4 = false;
  bool _isFocused5 = false;
  bool _isFocused6 = false;
  bool _isFocused7 = false;

  @override
  void initState() {
    super.initState();
    getSignUpApiData();
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
    focusNode5.addListener(() {
      setState(() {
        isFocused5 = focusNode5.hasFocus;
      });
    });
    _focusNode4.addListener(() {
      setState(() {
        _isFocused4 = _focusNode4.hasFocus;
      });
    });
    _focusNode5.addListener(() {
      setState(() {
        _isFocused5 = _focusNode5.hasFocus;
      });
    });

    _focusNode6.addListener(() {
      setState(() {
        _isFocused6 = _focusNode6.hasFocus;
      });
    });
    _focusNode7.addListener(() {
      setState(() {
        _isFocused7 = _focusNode7.hasFocus;
      });
    });
  }

  var tokenAccess;
  var userId;

  GetProfileData? getProfileData;
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;

  String? offerStartDate;

  bool isLoading = false;
  bool isFocused5 = false;
  final FocusNode focusNode5 = FocusNode();
  getSignUpApiData() async {
    try {
      setState(() {
        isLoading = true;
      });
      //  isLoading = true;
      SharedPreferences preference = await SharedPreferences.getInstance();
      tokenAccess = preference.getString("access-token");

      userId = preference.getString("userId");
      final body = {
        "user_id": userId,
      };
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.getUserProfileApi}",
        options: Options(
          headers: {
            "Authorization": tokenAccess,
            'Content-Type': 'application/json',
          },
        ),
        data: json.encode(body),
      );
      if (response.statusCode == 200) {
        // final responseData = response.data;
        var responseData = json.decode(response.data.toString());
        getProfileData = GetProfileData.fromJson(responseData);
        nameController.text = getProfileData?.data?.name.toString() ?? "";
        emailController.text = getProfileData?.data?.email.toString() ?? "";
        mobileController.text = getProfileData?.data?.mobile.toString() ?? "";
        selectedOption = getProfileData?.data?.gender.toString() ?? "";
        dobController.text = getProfileData?.data?.dateOfBirth.toString() ?? "";
        cityController.text = getProfileData?.data?.address.toString() ?? "";
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {}
  }

  getSignUpUpdateApiData({name,email, address, gender, dob, password}) async {
    try {
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
                  'Loading...',
                  style: ConstantTextStyle.allHomeScreenAvatarText,
                ),
              ],
            ),
          );
        },
      );
      //  isLoading = true;
      SharedPreferences preference = await SharedPreferences.getInstance();
      tokenAccess = preference.getString("access-token");
      userId = preference.getString("userId");
      final body = {
        "name": name,
        "email": email,
        "address": address,
        // "mobile": mobile,
        "gender": gender,
        "dob": dob,
        "password": password,
      };
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.getUserProfileUpdateApi}",
        options: Options(
          headers: {
            "Authorization": tokenAccess,
            'Content-Type': 'application/json',
          },
        ),
        data: json.encode(body),
      );
      Navigator.pop(context);
      if (response.statusCode == 200) {
        // final responseData = response.data;
        var responseData = json.decode(response.data.toString());
        Navigator.pop(context);
        // rfCodeController.text=getProfileData!.data!.roleId.toString();
      } else {}
    } catch (error) {
    }
  }

  String? storedDate;

  DateFormat displayDateFormat = DateFormat('dd-MM-yyyy');

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: ConstantColor.primaryMainColor,
            ),
            dialogBackgroundColor: Colors.white, // Background color
            textButtonTheme: TextButtonThemeData(
              style:
              TextButton.styleFrom(
                foregroundColor: ConstantColor.primaryMainColor,
              ),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), // Customize border radius
            ),
            child: child,
          ),
        );
      },
    );
    if (picked != null) {
      if (!picked.isAfter(DateTime.now())) {
        String formattedDate = displayDateFormat.format(picked);
        storedDate = displayDateFormat.format(picked);
        setState(() {
          dobController.text = formattedDate;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Cannot select future dates"),
          ),
        );
      }
    }
  }


  /*-------------------------form field nodes and string end --------------------------*/

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return  AlertDialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      contentPadding: EdgeInsets.symmetric(
          vertical: screenHeight / 40, horizontal: screenWidth / 30),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          customeText(
              text: "Signup".toUpperCase(),
              style: ConstantTextStyle.topCategoryText2,
              textAlign: TextAlign.center),
          SizedBox(
            height: screenHeight / 80,
          ),
          customeText(
              text: "Please Enter Following Details",
              style: ConstantTextStyle.checkboxTextStyle1,
              textAlign: TextAlign.center),
        ],
      ),
      content: SingleChildScrollView(
          child: SizedBox(
        width: screenWidth,
        child: isLoading
            ? SizedBox(
                width: screenWidth,
                height: 200,
                child: const SpinKitCircle(
                  color: ConstantColor.primaryMainColor,
                  size: 40.0,
                ),
              )
            : Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
    /*-------------------------------Name Field start------------------------------------*/
                      loginTextFormField2(
                        textFormPaddingHorizontal: screenWidth / 40,
                        textFormPaddingVertical: screenHeight / 60,
                        minLines: 1,
                        maxLines: 1,
                        validator: validateAccountHolder,
                        borderSideColor: _isFocused1
                            ? ConstantColor.primaryMainColor
                            : ConstantColor.transparent1,
                        focusNode: _focusNode1,
                        context: context,
                        fillColor: ConstantColor.primaryBackgroundMainColor,
                        filled: true,
                        enabled: true,
                        controller:  nameController,
                        hintStyle: ConstantTextStyle.sellerHintTextStyle,
                        labelText: "Name",
                        labelStyle: ConstantTextStyle.lableTextStyle,
                        cursorColor: ConstantColor.primaryMainColor,
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          setState(() {
                            name = value;
                          });
                        },
                      ),
    /*-------------------------------Name Field end------------------------------------*/
                      SizedBox(
                        height: screenHeight / 80,
                      ),
    /*-------------------------------Email Field start------------------------------------*/
                      loginTextFormField2(
                        textFormPaddingHorizontal: screenWidth / 40,
                        textFormPaddingVertical: screenHeight / 60,
                        minLines: 1,
                        maxLines: 1,
                        validator: validatePreEmail,
                        controller: emailController,
                        borderSideColor: _isFocused2
                            ? ConstantColor.primaryMainColor
                            : ConstantColor.transparent1,
                        focusNode: _focusNode2,
                        context: context,
                        fillColor: ConstantColor.primaryBackgroundMainColor,
                        filled: true,
                        enabled: true,
                        hintStyle: ConstantTextStyle.sellerHintTextStyle,
                        labelText: "Email Address",
                        labelStyle: ConstantTextStyle.lableTextStyle,
                        cursorColor: ConstantColor.primaryMainColor,
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
/*-------------------------------Email Field end------------------------------------*/
                      SizedBox(
                        height: screenHeight / 80,
                      ),
    /*-------------------------------Mobile Field start------------------------------------*/
                      loginTextFormField2(
                        textFormPaddingHorizontal: screenWidth / 40,
                        textFormPaddingVertical: screenHeight / 60,
                        minLines: 1,
                        maxLines: 1,
                        validator: validateMobile,
                        borderSideColor: _isFocused3
                            ? ConstantColor.primaryMainColor
                            : ConstantColor.transparent1,
                        focusNode: _focusNode3,
                        context: context,
                        controller:  mobileController,
                        fillColor: ConstantColor.primaryBackgroundMainColor,
                        filled: true,
                        enabled: true,
                        hintStyle: ConstantTextStyle.sellerHintTextStyle,
                        labelText: "Mobile",
                        labelStyle: ConstantTextStyle.lableTextStyle,
                        cursorColor: ConstantColor.primaryMainColor,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            mobile = value;
                          });
                        },
                      ),
    /*-------------------------------Mobile Field end------------------------------------*/
                      SizedBox(
                        height: screenHeight / 80,
                      ),
    /*-------------------------------Gender Field start------------------------------------*/

                      radiobuttonContainer(
                        boarderColor: ConstantColor.textFieldColor,
                        borderRadius: BorderRadius.zero,
                        headTextPadding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 40,
                          top: MediaQuery.of(context).size.height / 200,
                        ),
                        headText: "Gender",
                        headTextStyle: ConstantTextStyle.lableRadioText,
                        radioButtonWidget: Row(
                          children: [
                            radioButton(
                              text: "Male",
                              style: ConstantTextStyle.tabButtonTextStyle,
                              value: 'Male',
                              groupValue: selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  selectedOption = value.toString();
                                });
                              },
                            ),
                            radioButton(
                              text: "Female",
                              style: ConstantTextStyle.tabButtonTextStyle,
                              value: 'Female',
                              groupValue: selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  selectedOption = value.toString();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
    /*-------------------------------Gender Field end------------------------------------*/
                      SizedBox(
                        height: screenHeight / 80,
                      ),
    /*-------------------------------Date of Birth Field start------------------------------------*/

                      calanderForm(
                        controller:dobController,
                        // dobController.text == "null"
                        //     ? TextEditingController(text: "")
                        //     : dobController,
                        textFormPaddingHorizontal: screenWidth / 40,
                        textFormPaddingVertical: screenHeight / 60,
                        minLines: 1,
                        maxLines: 1,
                        borderSideColor: isFocused5
                            ? ConstantColor.primaryMainColor
                            : ConstantColor.transparent1,
                        focusNode: focusNode5,
                        context: context,
                        fillColor: ConstantColor.primaryBackgroundMainColor,
                        filled: true,
                        readOnly: true,
                        iconButton: IconButton,
                        hintStyle: ConstantTextStyle.sellerHintTextStyle,
                        labelText: "Date of Birth",
                        labelStyle: ConstantTextStyle.lableTextStyle,
                        cursorColor: ConstantColor.primaryMainColor,
                        keyboardType: TextInputType.datetime,
                        onChanged: (String? value) {
                          _selectDate(context);
                        },
                        suffixIconBGColor: ConstantColor.searchBoxColor,
                        suffixIconData: Icons.calendar_month_outlined,
                        suffixIconSize: 20.0,
                        suffixIconDataColor: ConstantColor.primaryMainColor,
                        suffixIconOnTap: () {
                          _selectDate(context);
                        },
                      ),

    /*-------------------------------Date of Birth Field end------------------------------------*/
                      SizedBox(
                        height: screenHeight / 80,
                      ),
    /*-------------------------------City Field start------------------------------------*/
                      loginTextFormField2(
                        textFormPaddingHorizontal: screenWidth / 40,
                        textFormPaddingVertical: screenHeight / 60,
                        minLines: 1,
                        maxLines: 1,
                        borderSideColor: _isFocused5
                            ? ConstantColor.primaryMainColor
                            : ConstantColor.transparent1,
                        focusNode: _focusNode5,
                        context: context,
                        fillColor: ConstantColor.primaryBackgroundMainColor,
                        filled: true,
                        enabled: true,
                        controller:cityController,
                        // cityController.text == "null"
                        //     ? TextEditingController(text: "")
                        //     : cityController,
                        hintStyle: ConstantTextStyle.sellerHintTextStyle,
                        labelText: "City",
                        labelStyle: ConstantTextStyle.lableTextStyle,
                        cursorColor: ConstantColor.primaryMainColor,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          setState(() {
                            city = value;
                          });
                        },
                      ),
    /*-------------------------------City Field end------------------------------------*/
                      SizedBox(
                        height: screenHeight / 80,
                      ),
    /*-------------------------------Password Field start------------------------------------*/
                      loginTextFormField2(
                        obscureText: !passwordVisible,
                        obscuringCharacter: "*",
                        suffixIcon: IconButton(
                          icon: Icon(
                            passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: ConstantColor.primaryGreyColor,
                            size: 25.0,
                          ),
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                        textFormPaddingHorizontal: screenWidth / 40,
                        textFormPaddingVertical: screenHeight / 60,
                        minLines: 1,
                        maxLines: 1,
                        borderSideColor: _isFocused6
                            ? ConstantColor.primaryMainColor
                            : ConstantColor.transparent1,
                        focusNode: _focusNode6,
                        context: context,
                        fillColor: ConstantColor.primaryBackgroundMainColor,
                        filled: true,
                        enabled: true,
                        controller: passwordController,
                        hintStyle: ConstantTextStyle.sellerHintTextStyle,
                        labelText: "Password",
                        labelStyle: ConstantTextStyle.lableTextStyle,
                        cursorColor: ConstantColor.primaryMainColor,
                        keyboardType: TextInputType.visiblePassword,
                        validator: validatePassword,
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                      ),
    /*-------------------------------Password Field end------------------------------------*/
                      SizedBox(
                        height: screenHeight / 80,
                      ),
    /*-------------------------------Refer code Field start------------------------------------*/
                      loginTextFormField2(
                        textFormPaddingHorizontal: screenWidth / 40,
                        textFormPaddingVertical: screenHeight / 60,
                        minLines: 1,
                        maxLines: 1,
                        borderSideColor: _isFocused7
                            ? ConstantColor.primaryMainColor
                            : ConstantColor.transparent1,
                        focusNode: _focusNode7,
                        context: context,
                        fillColor: ConstantColor.primaryBackgroundMainColor,
                        filled: true,
                        enabled: true,
                        controller:rfCodeController.text == "null"
                            ? TextEditingController(text: "")
                            : rfCodeController,
                        hintStyle: ConstantTextStyle.sellerHintTextStyle,
                        labelText: "Refer Code",
                        labelStyle: ConstantTextStyle.lableTextStyle,
                        cursorColor: ConstantColor.primaryMainColor,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (value) {
                          setState(() {
                            rfCode = value;
                          });
                        },
                      ),
    /*-------------------------------Refer code Field end------------------------------------*/
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: customeButton(
                          textStyleButton: ConstantTextStyle.reviewsRatingsText,
                          onPressed: () {
                            // if (_formKey.currentState!.validate()) {
                              // Call the API
                              getSignUpUpdateApiData(
                                  name: nameController.text.toString(),
                                   email: emailController.text.toString(),
                                  address: cityController.text.toString(),
                                  // mobile: mobileController.text.toString(),
                                  gender: selectedOption.toString(),
                                  dob: dobController.text.toString(),
                                  password: passwordController.text.toString());
                       //     }
                          },
                          text: "Update Details",
                          backgroundColor: ConstantColor.primaryMainColor,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        trailing: InkWell(
                          onTap: () async {
                            increaseDateByOne();
                            Navigator.pop(context);
                          },
                          child: customeText(
                              text: "Complete this letter",
                              style: ConstantTextStyle.seeMoreButtonStyle,
                              textAlign: TextAlign.start),
                        ),
                      ),
                    ]),
              ),
      )),
    );

/*---------------------------------Dialog Box end----------------------------------------*/
  }
  Future<void> increaseDateByOne() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String createdDateStr = prefs.getString("created_date") ?? '';
    DateTime storedDate = DateTime.parse(createdDateStr);
    DateTime increasedDate = storedDate.add(const Duration(days: 1));
    String increasedDateStr = DateFormat('yyyy-MM-dd HH:mm:ss').format(increasedDate);
    prefs.setString("created_date", increasedDateStr);
  }
}
