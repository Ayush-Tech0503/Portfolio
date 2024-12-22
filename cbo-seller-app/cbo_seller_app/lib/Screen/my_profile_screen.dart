// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../Utils/Constant Size /constant_sizes.dart';
import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';
import '../../Widget/custome_text_widget.dart';
import '../../Widget/refresh_footer_message.dart';
import '../Models/My Profile Model/my_profile_pre_filed_data_model.dart';
import '../Services/My Profile Api Services/delete_my_account_api_services.dart';
import '../Services/My Profile Api Services/pre_filed_profile_data_api_services.dart';
import '../Services/My Profile Api Services/update_profile_data_api_services.dart';
import '../Widget/Custome Buttons/elevetion_button_widget.dart';
import '../Widget/Radio Button/radio_list_tile_widget.dart';
import '../Widget/Scaffold Message/scaffold_message_widget.dart';
import '../Widget/Text Form Fields/global_text_form_field.dart';
import '../Widget/Validations/email_validation_widget.dart';
import '../Widget/gender_container_widget.dart';

class MyProfileScreen extends StatefulWidget {
  final bool? myappBar;
  const MyProfileScreen({super.key, this.myappBar = false});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {

  @override
  void initState() {
    super.initState();
    fetchProfileListData();
  }
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool isPullToRefreshEnabled = true;
  int currentPage = 1;
  bool isLoading = false;

  final RefreshController _refreshController = RefreshController(initialRefresh: false);


  DateFormat displayDateFormat = DateFormat('dd-MM-yyyy');
  String? storedDate;

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
          _dateTimeController.text = formattedDate;
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

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String selectedOption = '';
  bool passwordVisible = false;

  ProfilePreFiledDataModel? profilePreFiledDataModel;
  List<ProfilePreFiledData>? data = [];
  //-------pre field api--------
  Future<void> fetchProfileListData() async {
    try {
      setState(() {
        isLoading = true;
        data!.clear();
      });

      final profilePreFiledResponse = await ProfilePreFiledApiService.fetchPreFiledData(context: context);

      if (profilePreFiledResponse != null && profilePreFiledResponse.data != null) {
        final dataList = profilePreFiledResponse.data!;
        setState(() {
          _nameController.text = dataList.name??"";
          _emailController.text = dataList.email??"";
          _mobileController.text = dataList.mobile??"";
          selectedOption = dataList.gender??"";
          var dob = dataList.dateOfBirth??"";
          _dateTimeController.text = dob == '00-00-0000'? "dd-mm-yyyy": dataList.dateOfBirth??"";
          _cityController.text = dataList.address??"";
          // _passwordController.text = dataList!.password??"";
          isLoading = false;
        });
      }
      else {
        // No more data available
        setState(() {
          isLoading = false;
          _refreshController.loadNoData();
          isPullToRefreshEnabled = false; // Disable pull-to-refresh
        });
      }
    } catch (e) {
      setState(() {
        _refreshController.loadNoData();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ConstantColor.primaryBackgroundMainColor,
      appBar: widget.myappBar == false ?  AppBar(
        centerTitle: true,
        backgroundColor: ConstantColor.loginWithOtpButtonColor,
        title: customeText(text: "My Profile"),
        titleTextStyle: ConstantTextStyle.landingScreenAppbarText,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), color: ConstantColor.primaryBackgroundMainColor,
          onPressed: () => Navigator.pop(context),
        ),
      ) : null,
      body: CupertinoScrollbar(
        child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            controller: _refreshController,
            footer: customFooter(),
            onRefresh: () async {
              currentPage = 1;
              await fetchProfileListData();
              _refreshController.refreshCompleted();
            },
            child: Skeletonizer(
              enabled: isLoading,
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(horizontal: screenWidth/30,vertical: screenHeight/60),
                  children: [
                    widget.myappBar == true ? Container() :
                    customeText(text: "\tMy Profile",style: ConstantTextStyle.topCategoryText4),

                    constantHeight(context, 80.0),

                    GlobalTextFormField(
                      enabled: true,
                      margin: EdgeInsets.symmetric(vertical: screenHeight/60.0),
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      hintText: "",
                      labelText: "Name",
                      // hintStyle: ConstantTextStyle.otpHintTextStyle,
                      labelStyle: ConstantTextStyle.otpHintTextStyle,
                      onChanged: (value) {},
                      suffixIcon: const Icon(Icons.person_outline,color: ConstantColor.landingScreenSubHaddingColor,),
                    ),

                    GlobalTextFormField(enabled: true,
                      margin: EdgeInsets.symmetric(vertical: screenHeight/60.0),
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "",
                      labelText: "Email",
                      // hintStyle: ConstantTextStyle.otpHintTextStyle,
                      labelStyle: ConstantTextStyle.otpHintTextStyle,
                      onChanged: (value) {},
                      suffixIcon: const Icon(Icons.attach_email_outlined,color: ConstantColor.landingScreenSubHaddingColor,),

                    ),

                    GlobalTextFormField(
                      enabled: true,
                      margin: EdgeInsets.symmetric(vertical: screenHeight/60.0),
                      controller: _mobileController,
                      keyboardType: TextInputType.number,
                      hintText: "",
                      maxLength: 10,
                      labelText: "Mobile Number",
                      // hintStyle: ConstantTextStyle.otpHintTextStyle,
                      labelStyle: ConstantTextStyle.otpHintTextStyle,
                      onChanged: (value) {},
                    ),

                    constantHeight(context, 60.0),

                    radiobuttonContainer(
                      context: context,
                      headText: "Gender",
                      radioButtonWidget: Row(
                        children: [
                          Flexible(
                            child:
                            customRadioButtonTitle(
                              title: customeText(text: "Male",style: ConstantTextStyle.passwordScreenLineTexStyle,),
                              value: "Male",
                              groupValue: selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  selectedOption = value.toString();
                                });
                              },
                            ),
                          ),
                          Flexible(
                            child:
                            customRadioButtonTitle(
                              title: customeText(text: "Female",style: ConstantTextStyle.passwordScreenLineTexStyle,),
                              value: "Female",
                              groupValue: selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  selectedOption = value.toString();
                                });
                              },
                            ),
                          ),
                          Flexible(
                            child:
                            customRadioButtonTitle(
                              title: customeText(text: "Other",style: ConstantTextStyle.passwordScreenLineTexStyle,),
                              value: "Other",
                              groupValue: selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  selectedOption = value.toString();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    constantHeight(context, 60.0),

                    GlobalTextFormField(
                      onTap: () => _selectDate(context),
                      enabled: false,
                      readOnly: true,
                      margin: EdgeInsets.symmetric(vertical: screenHeight/60.0),
                      controller: _dateTimeController,
                      keyboardType: TextInputType.datetime,
                      hintText: "",
                      labelText: "Date of Birth",
                      labelStyle: ConstantTextStyle.otpHintTextStyle,
                      onChanged: (value) => setState(() => _selectDate(context)),
                      suffixIcon: const Icon(Icons.calendar_month_outlined,color: ConstantColor.landingScreenSubHaddingColor,),
                    ),

                    GlobalTextFormField(
                      enabled: true,
                      margin: EdgeInsets.symmetric(vertical: screenHeight/60.0),
                      controller: _cityController,
                      keyboardType: TextInputType.text,
                      hintText: "",
                      labelText: "City",
                      labelStyle: ConstantTextStyle.otpHintTextStyle,
                      onChanged: (value) {},
                      suffixIcon: const Icon(Icons.pin_drop,color: ConstantColor.landingScreenSubHaddingColor,),
                    ),


                    GlobalTextFormField(
                      enabled: true,
                      obscureText: !passwordVisible,
                      margin: EdgeInsets.symmetric(vertical: screenHeight/60.0),
                      controller: _passwordController,
                      keyboardType: TextInputType.text,
                      hintText: "",
                      labelText: "Password",
                      labelStyle: ConstantTextStyle.otpHintTextStyle,
                      onChanged: (value) {},
                      suffixIcon:  IconButton(
                          icon: Icon(
                              passwordVisible ? Icons.visibility_off : Icons.visibility,
                              color: ConstantColor.landingScreenSubHaddingColor),
                          onPressed: () => setState(() =>   passwordVisible = !passwordVisible)),
                    ),

                    constantHeight(context, 40.0),

                    Row(
                      children: [
                        Expanded(
                          child: customButton(
                            text: '\u{1F5D1} Delete account',
                            elevation: 1.0,
                            borderRadius: BorderRadius.circular(20.0),
                            backgroundColor: ConstantColor.loginWithOtpButtonColor,
                            textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                            onPressed: () async => await DeleteProfileApiService.fetchDeleteProfileData(context: context),
                          ),
                        ),
                        constantWidth(context, 40.0),
                        Expanded(
                          child: customButton(
                            text: '\u2713 Submit Now',
                            elevation: 1.0,
                            borderRadius: BorderRadius.circular(20.0),
                            backgroundColor: ConstantColor.primaryMainColor,
                            textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                            onPressed: () async {
                              bool isValidEmail = validatePreEmail(_emailController.text);
                              (isValidEmail && _emailController.text.isNotEmpty) ?
                              await UpdateProfileApiService.fetchUpdateProfileData(
                                  context: context,
                                  name: _nameController.text.toString(),
                                  email: _emailController.text.toString(),
                                  address: _cityController.text.toString(),
                                  gender: selectedOption.toString(),
                                  dob: _dateTimeController.text.toString(),
                                  password: _passwordController.text.toString()
                              ) : LoadingScaffoldMessage.showSnackbar(
                                context, "Please Enter Valid Email Address!!",
                                ConstantColor.primaryMainColor,
                                const Duration(seconds: 2),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }
}












