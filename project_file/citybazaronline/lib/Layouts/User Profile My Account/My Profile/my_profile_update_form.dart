// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';
import 'package:Citybazar_app/Layouts/Onboarding%20Screens/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Models/Profile Model/getprofile_data.dart';
import '../../../Util/Const Toster/toster.dart';
import '../../../Util/Constant APi Url/api_urls.dart';
import '../../../Util/Validation/validation_data.dart';
import '../../../Util/constaint_textstyle.dart';
import '../../../Util/constant_color.dart';
import '../../../Widgets/Login Check Widget/login_check_widget.dart';
import '../../../Widgets/custome_button_.dart';
import '../../../Widgets/custome_text.dart';
import '../../../Widgets/login_textformfiled.dart';

class MyProfileUpdate extends StatefulWidget {
  const MyProfileUpdate({super.key});

  @override
  State<MyProfileUpdate> createState() => _MyProfileUpdateState();
}

class _MyProfileUpdateState extends State<MyProfileUpdate> {
  String location = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String selectedOption = '';
  bool passwordVisible = false;

  String name = '';
  String email = '';
  String mobile = '';
  String gender = '';
  String dob = '';
  String city = '';
  String password = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rfCodeController = TextEditingController();
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();

  final FocusNode _focusNode6 = FocusNode();
  // final FocusNode _focusNode7 = FocusNode();

  bool _isFocused1 = false;
  bool _isFocused2 = false;
  bool _isFocused3 = false;
  bool _isFocused4 = false;
  bool _isFocused5 = false;
  bool _isFocused6 = false;
  // bool _isFocused7 = false;
  GetProfileData? getProfileData;
  bool isLoading = false;
  bool isUserLoggedIn = false;
  bool isLoadingDelete = false;
  var tokenAccess;
  var userId;
  
  getSignUpUpdateApiData({name, email, address, gender, dob, password}) async {
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
        // "mobile": mobile,
        "address": address,
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
        Navigator.pop(context);
        LoadingScaffoldMessage.showSnackbar(
          context,
          "Successfully submitted!",
          ConstantColor.primaryMainColor,
          const Duration(seconds: 1),
        );
      } else {}
    } catch (error) {
      throw Exception('Failed to fetch data');
    }
  }


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
    } catch (error) {
      setState(() {
        isLoading = false;
      });
    }
  }

  deleteMyAccountApi({tokenAccess}) async {
    try {
      setState(() {
        isLoadingDelete = true;
      });
      SharedPreferences preference = await SharedPreferences.getInstance();
      tokenAccess = preference.getString("access-token");
      final response = await Dio().get(
        "${ConstantUrls.baseUriApi}${ConstantUrls.deleteMyAccountApi}",
        options: Options(
          headers: {
            "Authorization": tokenAccess,
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const LoginScreen()),);
        setState(() {
          isLoadingDelete = false;
        });
      } else {
        setState(() {
          isLoadingDelete = false;
        });
      }
    } catch (error) {
      setState(() {
        isLoadingDelete = false;
      });
    }
  }



  @override
  void initState() {
    super.initState();
    getSignUpApiData();
    passwordVisible = true;
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
  }
//------------------------------------------------------------
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: ConstantColor.loginWithOtpButtonColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ConstantColor.secondryBackgroundMainColor,
            appBar: AppBar(
              centerTitle: false,
              leadingWidth: 24,
              elevation: 1,
              iconTheme: const IconThemeData(color: ConstantColor.loginWithOtpButtonColor),
              backgroundColor: ConstantColor.primaryBackgroundMainColor,
              title: customeText(text: "My Account",style: ConstantTextStyle.secodHearText,),
            ),
            key: _scaffoldKey,
            body: SingleChildScrollView(
              child: isLoading
                  ? const SpinKitCircle(
                    color: ConstantColor.primaryMainColor,
                    size: 30.0,
                  )
                  :
/*----------------------------------------------------------------------------*/
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight / 40,
                              horizontal: screenWidth / 40),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                customeText(
                                  text: "Profile Details", textAlign: TextAlign.start,
                                  style: ConstantTextStyle.secodHearText
                                ), SizedBox(height: screenHeight/30,),
                            /*-------------------------------Name Field start------------------------------------*/
                                loginTextFormField2(
                                  prefixIcon: const Icon(Icons.person_pin,color: ConstantColor.primaryMainColor,),
                                  textFormPaddingHorizontal: screenWidth / 40,
                                  textFormPaddingVertical: screenHeight / 60,
                                  controller: nameController,
                                  minLines: 1,
                                  maxLines: 1,
                                  borderSideColor: _isFocused1
                                      ? ConstantColor.primaryMainColor
                                      : ConstantColor.transparent1,
                                  focusNode: _focusNode1,
                                  context: context,
                                  fillColor:
                                      ConstantColor.primaryBackgroundMainColor,
                                  filled: true,
                                  enabled: true,
                                  iconButton: IconButton,
                                  hintText: "Name",
                                  hintStyle:
                                      ConstantTextStyle.sellerHintTextStyle,
                                  labelText: "Name",
                                  labelStyle: ConstantTextStyle.lableTextStyle,
                                  cursorColor: ConstantColor.primaryMainColor,
                                  keyboardType: TextInputType.name,
                                  onChanged: (value) {
                                    setState(() {
                                      name = value;
                                    });
                                  },
                            /*------------------------------Update button start----------------------------------*/
                                  // suffixIcon: Padding(
                                  //   padding: EdgeInsets.only(
                                  //     right: screenWidth / 40,
                                  //     top: screenWidth / 60,
                                  //     bottom: screenWidth / 60,
                                  //   ),
                                  //   child: customeButton(
                                  //     textStyleButton: ConstantTextStyle
                                  //         .loginButtonTextStyle,
                                  //     onPressed: () {
                                  //       getSignUpUpdateApiData(
                                  //           name:
                                  //               nameController.text.toString(),
                                  //           email:
                                  //               emailController.text.toString(),
                                  //           address:
                                  //               cityController.text.toString(),
                                  //           gender: selectedOption.toString(),
                                  //           dob: dobController.text.toString(),
                                  //           password: passwordController.text
                                  //               .toString());
                                  //     },
                                  //     text: "Update",
                                  //     backgroundColor:
                                  //         ConstantColor.primaryMainColor,
                                  //     borderRadius: BorderRadius.circular(8.0),
                                  //     elevation: 3.0,
                                  //   ),
                                  // ),
                                ),
                            /*-------------------------------Name Field end------------------------------------*/
                                SizedBox(height: screenHeight / 30,),
                            /*-------------------------------Email Field start------------------------------------*/
                                loginTextFormField2(
                                  prefixIcon: const Icon(Icons.email_outlined,color: ConstantColor.primaryMainColor,),
                                  textFormPaddingHorizontal: screenWidth / 40,
                                  textFormPaddingVertical: screenHeight / 60,
                                  minLines: 1,
                                  maxLines: 1,
                                  // validator: validatePreEmail,
                                  controller: emailController,
                                  borderSideColor: _isFocused2
                                      ? ConstantColor.primaryMainColor
                                      : ConstantColor.transparent1,
                                  focusNode: _focusNode2,
                                  context: context,
                                  fillColor: ConstantColor.primaryBackgroundMainColor,
                                  filled: true,
                                  enabled: true,
                                  iconButton: IconButton,
                                  hintText: "John@gmail.com",
                                  hintStyle:
                                      ConstantTextStyle.sellerHintTextStyle,
                                  labelText: "Email Address",
                                  labelStyle: ConstantTextStyle.lableTextStyle,
                                  cursorColor: ConstantColor.primaryMainColor,
                                  keyboardType: TextInputType.name,
                                  onChanged: (value) {
                                    setState(() {
                                      email = value;
                                    });
                                  },
                            /*------------------------------ Update button start----------------------------------*/
                                  // suffixIcon: Padding(
                                  //   padding: EdgeInsets.only(
                                  //     right: screenWidth / 40,
                                  //     top: screenWidth / 60,
                                  //     bottom: screenWidth / 60,
                                  //   ),
                                  //   child: customeButton(
                                  //     textStyleButton: ConstantTextStyle
                                  //         .loginButtonTextStyle,
                                  //     onPressed: () {
                                  //       getSignUpUpdateApiData(
                                  //           name:
                                  //               nameController.text.toString(),
                                  //           email:
                                  //               emailController.text.toString(),
                                  //           address:
                                  //               cityController.text.toString(),
                                  //           gender: selectedOption.toString(),
                                  //           dob: dobController.text.toString(),
                                  //           password: passwordController.text
                                  //               .toString());
                                  //     },
                                  //     text: "Update",
                                  //     backgroundColor:
                                  //         ConstantColor.primaryMainColor,
                                  //     borderRadius: BorderRadius.circular(8.0),
                                  //     elevation: 3.0,
                                  //   ),
                                  // ),
                                ),
                            /*-------------------------------Email Field end------------------------------------*/
                                SizedBox(height: screenHeight / 30,),
                            /*-------------------------------Mobile Field start------------------------------------*/
                                loginTextFormField2(
                                  prefixIcon: const Icon(Icons.call_outlined,color: ConstantColor.primaryMainColor,),
                                  textFormPaddingHorizontal: screenWidth / 40,
                                  textFormPaddingVertical: screenHeight / 60,
                                  minLines: 1,
                                  maxLines: 1,
                                  borderSideColor: _isFocused3
                                      ? ConstantColor.primaryMainColor
                                      : ConstantColor.transparent1,
                                  focusNode: _focusNode3,
                                  context: context,
                                  fillColor:
                                      ConstantColor.primaryBackgroundMainColor,
                                  filled: true,
                                  enabled: true,
                                  controller: mobileController,
                                  iconButton: IconButton,
                                  hintText: "123-123-123",
                                  hintStyle:
                                      ConstantTextStyle.sellerHintTextStyle,
                                  labelText: "Mobile",
                                  labelStyle: ConstantTextStyle.lableTextStyle,
                                  cursorColor: ConstantColor.primaryMainColor,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    setState(() {
                                      mobile = value;
                                    });
                                  },
                            /*------------------------------Update button start----------------------------------*/
                                  // suffixIcon: Padding(
                                  //   padding: EdgeInsets.only(
                                  //     right: screenWidth / 40,
                                  //     top: screenWidth / 60,
                                  //     bottom: screenWidth / 60,
                                  //   ),
                                  //   child: customeButton(
                                  //     textStyleButton: ConstantTextStyle
                                  //         .loginButtonTextStyle,
                                  //     onPressed: () {
                                  //       getSignUpUpdateApiData(
                                  //           name:
                                  //          nameController.text.toString(),
                                  //           email:
                                  //               emailController.text.toString(),
                                  //           address:
                                  //               cityController.text.toString(),
                                  //           gender: selectedOption.toString(),
                                  //           dob: dobController.text.toString(),
                                  //           password: passwordController.text
                                  //               .toString());
                                  //     },
                                  //     text: "Update",
                                  //     backgroundColor:
                                  //         ConstantColor.primaryMainColor,
                                  //     borderRadius: BorderRadius.circular(8.0),
                                  //     elevation: 3.0,
                                  //   ),
                                  // ),
                                ),
                            /*-------------------------------Mobile Field end------------------------------------*/
                                SizedBox(height: screenHeight / 30,),
                            /*-------------------------------Gender Field start------------------------------------*/

                                radiobuttonContainer(
                                  boarderColor: ConstantColor.textFieldColor,
                                  borderRadius: BorderRadius.zero,
                                  headTextPadding: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width / 40,
                                    top: MediaQuery.of(context).size.height /
                                        150,
                                  ),
                                  headText: "Gender",
                                  headTextStyle: ConstantTextStyle.lableRadioText,
                                  radioButtonWidget: Row(
                                    children: [
                                      radioButton(
                                        text: "Male",
                                        style: ConstantTextStyle.passwordScreenLineTexStyle,
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
                                        style: ConstantTextStyle
                                            .passwordScreenLineTexStyle,
                                        value: 'Female',
                                        groupValue: selectedOption,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedOption = value.toString();
                                          });
                                        },
                                      ),
                                      radioButton(
                                        text: "Other",
                                        style: ConstantTextStyle
                                            .passwordScreenLineTexStyle,
                                        value: 'Other',
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
                                SizedBox(height: screenHeight / 30,),
                            /*-------------------------------Date of Birth Field start------------------------------------*/
                                GestureDetector(
                                  onTap: (){
                                    _selectDate(context);
                                  },
                                  child: calanderForm(
                                    prefixIcon: const Icon(Icons.date_range_outlined,color: ConstantColor.primaryMainColor,),
                                    controller: dobController,
                                    textFormPaddingHorizontal: screenWidth / 40,
                                    textFormPaddingVertical: screenHeight / 60,
                                    minLines: 1,
                                    maxLines: 1,
                                    borderSideColor: _isFocused4
                                        ? ConstantColor.primaryMainColor
                                        : ConstantColor.transparent1,
                                    focusNode: _focusNode4,
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
                                      setState(() {
                                        _selectDate(context);
                                      });
                                    },
                                    suffixIconBGColor: ConstantColor.searchBoxColor,
                                    suffixIconData: Icons.calendar_month_outlined,
                                    suffixIconSize: 20.0,
                                    suffixIconDataColor: ConstantColor.primaryMainColor,
                                    suffixIconOnTap: () {
                                      _selectDate(context);
                                    },

                                  ),
                                ),
                            /*------------------------------Update button start----------------------------------*/
                                  // suffixIcon: Padding(
                                  //   padding: EdgeInsets.only(
                                  //     right: screenWidth / 40,
                                  //     top: screenWidth / 60,
                                  //     bottom: screenWidth / 60,
                                  //   ),
                                  //   child: customeButton(
                                  //     textStyleButton: ConstantTextStyle
                                  //         .loginButtonTextStyle,
                                  //     onPressed: () {
                                  //       getSignUpUpdateApiData(
                                  //           name:
                                  //               nameController.text.toString(),
                                  //           email:
                                  //               emailController.text.toString(),
                                  //           address:
                                  //               cityController.text.toString(),
                                  //           gender: selectedOption.toString(),
                                  //           dob: dobController.text.toString(),
                                  //           password: passwordController.text
                                  //               .toString());
                                  //     },
                                  //     text: "Update",
                                  //     backgroundColor:
                                  //         ConstantColor.primaryMainColor,
                                  //     borderRadius: BorderRadius.circular(8.0),
                                  //     elevation: 3.0,
                                  //   ),
                                  // ),
                              //  ),
                            /*-------------------------------Date of Birth Field end------------------------------------*/
                                SizedBox(height: screenHeight / 30,),
                            /*-------------------------------City Field start------------------------------------*/
                                loginTextFormField2(
                                  prefixIcon: const Icon(Icons.pin_drop_outlined,color: ConstantColor.primaryMainColor,),
                                  controller: cityController,
                                  textFormPaddingHorizontal: screenWidth / 40,
                                  textFormPaddingVertical: screenHeight / 60,
                                  minLines: 1,
                                  maxLines: 1,
                                  borderSideColor: _isFocused5
                                      ? ConstantColor.primaryMainColor
                                      : ConstantColor.transparent1,
                                  focusNode: _focusNode5,
                                  context: context,
                                  fillColor:
                                      ConstantColor.primaryBackgroundMainColor,
                                  filled: true,
                                  enabled: true,
                                  iconButton: IconButton,
                                  hintText: "city",
                                  hintStyle:
                                      ConstantTextStyle.sellerHintTextStyle,
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
                                SizedBox(height: screenHeight / 30,),
                            /*-------------------------------Password Field start------------------------------------*/
                                loginTextFormField2(
                                  prefixIcon: const Icon(Icons.password_outlined,color: ConstantColor.primaryMainColor,),
                                  controller: passwordController,
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
                                  iconButton: IconButton,
                                  hintText: "* * * * * *",
                                  hintStyle: ConstantTextStyle.sellerHintTextStyle,
                                  labelText: "Password",
                                  labelStyle: ConstantTextStyle.lableTextStyle,
                                  cursorColor: ConstantColor.primaryMainColor,
                                  keyboardType: TextInputType.visiblePassword,
                                  //  textInputAction: TextInputAction.done,
                                  onChanged: (value) {
                                    setState(() {
                                      password = value;
                                    });
                                  },
                            /*------------------------------ Update button start----------------------------------*/
                                ),
                            /*-------------------------------Password Field end------------------------------------*/
                                SizedBox(height: screenHeight / 40,),

                                OutlinedButton.icon(
                                  icon:  const Icon(Icons.delete_forever_outlined,color: ConstantColor.primaryMainColor,),
                                  label: Text("Delete My Account",style:ConstantTextStyle.sellerHintTextStyle,),
                                  onPressed: () async{
                                    SharedPreferences preferences = await SharedPreferences.getInstance();
                                    setState(() {
                                      isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                                      tokenAccess = preferences.getString("access-token");
                                    });
                                    if (isUserLoggedIn){
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              contentPadding: EdgeInsets.symmetric(horizontal: screenWidth/30),
                                              titlePadding: EdgeInsets.symmetric(horizontal: screenWidth/30,vertical: screenHeight/60),
                                              shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                              ),
                                              title: const Text('Please confirm!'),
                                              content: const Text('Are you sure want to delete account ?'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      deleteMyAccountApi(
                                                          tokenAccess:tokenAccess
                                                      );
                                                    },
                                                    child: Text('Yes',style: ConstantTextStyle.hintTextStyle2,)),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context); //close Dialog
                                                  },
                                                  child: const Text('No'),
                                                )
                                              ],
                                            );
                                          });
                                    }
                                    else{
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const CheckIsLogin();
                                        },
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size.fromHeight(MediaQuery.of(context).size.height /20),
                                    side: const BorderSide(width: 1.0,color: ConstantColor.primaryMainColor),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                ),
                                SizedBox(height: screenHeight / 60,),
                                customeButton(
                                  textStyleButton: ConstantTextStyle.loginButtonTextStyle,
                                  onPressed: () {
                                    bool isValidEmail = validatePreEmail1(emailController.text);
                                    if (isValidEmail) {
                                      // If email is valid, proceed with API call
                                      getSignUpUpdateApiData(
                                        name: nameController.text.toString(),
                                        email: emailController.text.toString(),
                                        address: cityController.text.toString(),
                                        // mobile: mobileController.text.toString(),
                                        gender: selectedOption.toString(),
                                        dob: dobController.text.toString(),
                                        password: passwordController.text.toString(),
                                      );
                                    } else {
                                      // If email is not valid, show a message
                                      LoadingScaffoldMessage2.showSnackbar(
                                        context,
                                        "Please enter a valid email address.",
                                        ConstantColor.primaryMainColor,
                                        const Duration(seconds: 1),
                                      );
                                    }
                                  },

                                  text: "Update Details",
                                  backgroundColor:
                                  ConstantColor.chipCompleteStatus,
                                  borderRadius: BorderRadius.circular(30.0),
                                  elevation: 3.0,
                                  minimumSize: Size.fromHeight(
                                      MediaQuery.of(context).size.height /20),
                                ),
                              ],
                            ),
                          ),
                        ),
            ),
          ),
      ),
    );
  }
}


