import 'dart:io';

import 'package:dealshaq/components/back_button.dart';
import 'package:dealshaq/cubits/user_signup/user_signup_cubit.dart';
import 'package:dealshaq/utils/loading_indicator.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app_language/string_helper.dart';
import '../../components/app_buttons.dart';
import '../../components/masked_text_controller.dart';
import '../../components/text_fiels.dart';
import '../../helpers/assets_helper.dart';
import '../../helpers/color_helper.dart';
import '../../helpers/dimens_helper.dart';
import '../../helpers/font_helper.dart';
import '../../routes/routes_name.dart';
import '../../utils/toast_message.dart';
import '../sicial_login/apple_login_button.dart';
import '../sicial_login/google_login_button.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController fullNameController = TextEditingController();
  final FocusNode fullNameFocusNode = FocusNode();
  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();
  final TextEditingController phoneController = MaskedTextController(mask: "000-000-0000");
  final FocusNode phoneFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();



  final FlCountryCodePicker flCountryCodePicker = const FlCountryCodePicker();

  @override
  Widget build(BuildContext context) {
    final stringHelper = StringHelper.of(context)!;

    return Scaffold(
        appBar: AppBar(
          leading: const BackButtonWidget()
        ),
        body:Form(
          key: _formKey,
          child: ListView(
           // crossAxisAlignment: CrossAxisAlignment.start,
             padding: const EdgeInsets.symmetric(horizontal: DimensHelper.dimens_20),
            children: [
              Text(stringHelper.signUp, style: const TextStyle(color: ColorHelper.primaryColor, fontSize: FontHelper.size_22, fontWeight: FontHelper.bold),),

              const SizedBox(height: DimensHelper.dimens_20,),

              CommonTextField(
                controller: fullNameController,
                currentFocus: fullNameFocusNode,
                nextFocus: emailFocusNode,
                hintText: stringHelper.enterFullName,
                errorMessage: stringHelper.pleaseEnterFullName,
                icon: const Icon(Icons.person_outline)),
              
              
              const SizedBox(height: DimensHelper.dimens_20,),

              EmailTextField(controller: emailController, currentFocus: emailFocusNode, nextFocus: passwordFocusNode,),

              const SizedBox(height: DimensHelper.dimens_20,),

              PasswordTextField(controller: passwordController, currentFocus: passwordFocusNode,nextFocus: phoneFocusNode,),

              const SizedBox(height: DimensHelper.dimens_20,),

              // IntlPhoneField(
              //   style: const TextStyle(color: ColorHelper.black, fontWeight: FontHelper.medium, fontSize: FontHelper.size_20),
              //   controller: phoneController,
              //   flagsButtonPadding: const EdgeInsets.all(8),
              //   dropdownIconPosition: IconPosition.trailing,
              //   inputFormatters: [
              //     LengthLimitingTextInputFormatter(16),
              //     FilteringTextInputFormatter.digitsOnly
              //   ],
              //   autovalidateMode: AutovalidateMode.disabled,
              //   showCountryFlag: false,
              //   onCountryChanged: (code){
              //     setState(() {
              //       countryCode = code.fullCountryCode;
              //     });
              //   },
              //   decoration: InputDecoration(
              //     hintText: StringHelper.enterPhoneNumber,
              //     counter: const Offstage(),
              //     hintStyle: const TextStyle(color: ColorHelper.greyColor, fontWeight: FontHelper.medium, fontSize: FontHelper.size_18),
              //    // prefixIcon: Icon(Icons.phone),
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
              //       borderSide: const BorderSide(color: ColorHelper.grey300),
              //     ),
              //     disabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
              //       borderSide: const BorderSide(color: ColorHelper.grey300),
              //     ),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
              //       borderSide: const BorderSide(color: ColorHelper.grey300),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
              //       borderSide: const BorderSide(color: ColorHelper.primaryColor),
              //     ),
              //     errorBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
              //       borderSide: const BorderSide(color: ColorHelper.redColor),
              //     ),
              //   ),
              //   initialCountryCode: 'IN',
              // ),

              // PhoneTextField(controller: phoneController, currentFocus: phoneFocusNode,),


              PhoneNumberTextField(
                controller: phoneController,
              focusNode: phoneFocusNode),


              const SizedBox(height: DimensHelper.dimens_10,),

              RichText(
                text:  TextSpan(
                  text: stringHelper.byContinuingYouAgreeToOur,
                  style: const TextStyle(color: ColorHelper.black, fontSize: FontHelper.size_14, fontWeight: FontHelper.regular),
                  children: <TextSpan>[
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = () => print('Tap Here onTap'),
                        text: stringHelper.termsOfConditions,
                      style: const TextStyle(color: ColorHelper.primaryColor, fontSize: FontHelper.size_14, fontWeight: FontHelper.medium, decoration: TextDecoration.underline, decorationColor: ColorHelper.primaryColor),),

                     TextSpan(
                      text: stringHelper.andInSort,
                      style: const TextStyle(color: ColorHelper.black, fontSize: FontHelper.size_14, fontWeight: FontHelper.regular,),),

                     TextSpan(
                      text: stringHelper.privacyPolicy,
                      style: const TextStyle(color: ColorHelper.primaryColor, fontSize: FontHelper.size_14, fontWeight: FontHelper.medium, decoration: TextDecoration.underline, decorationColor: ColorHelper.primaryColor),),
                  ],
                ),
              ),

              const SizedBox(height: DimensHelper.dimens_30,),

              signUpButton(),


              const SizedBox(height: DimensHelper.dimens_20,),

              Row(
                children: [
                  Expanded(child: Container(height: 2,color: ColorHelper.grey300,margin: const EdgeInsets.only(right: DimensHelper.dimens_8),)),
                  Text(stringHelper.or, style: const TextStyle(color: ColorHelper.primaryColor, fontSize: FontHelper.size_14, fontWeight: FontHelper.regular),),
                  Expanded(child: Container(height: 2,color: ColorHelper.grey300,margin: const EdgeInsets.only(left: DimensHelper.dimens_8),)),

                ],
              ),

              const SizedBox(height: DimensHelper.dimens_20,),

              const GoogleLogInButton (),

              const SizedBox(height: DimensHelper.dimens_20,),

              const AppleLogInButton(),

              const SizedBox(height: DimensHelper.dimens_20),

              Row(
                children: [
                  Text(stringHelper.alreadyHaveAnAccount, style: const TextStyle(color: ColorHelper.black, fontWeight: FontHelper.medium, fontSize: FontHelper.size_16),),
                  GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, RouteName.logIn);
                      },
                      child: Text(stringHelper.logIn, style: const TextStyle(color: ColorHelper.primaryColor, fontWeight: FontHelper.medium, fontSize: FontHelper.size_16,decoration: TextDecoration.underline,decorationColor: ColorHelper.primaryColor),)),
                ],
              ),
              const SizedBox(height: DimensHelper.dimens_20,),
            ],
          ),
        )
    );
  }

  Widget signUpButton () {
    final stringHelper = StringHelper.of(context)!;

    return BlocProvider(
      create: (_) => UserSignupCubit(),
      child: BlocBuilder<UserSignupCubit, UserSignupState>(
        builder: (context, state) {
          return CommonButton(
            onPress: (){

              if(state is UserSignupLoading){

              }else{
                if(_formKey.currentState!.validate()){
                  context.read<UserSignupCubit>().userSignUp(context,
                      fullNameController.text,emailController.text.toString(),
                      passwordController.text.toString(),
                      phoneController.text.toString());
                }
              }
              },
            child: state is UserSignupLoading? loadingButton(): Text(stringHelper.signUp, style: const TextStyle(color: ColorHelper.whiteColor, fontSize: FontHelper.size_18, fontWeight: FontHelper.bold),),);
        }
      ),
    );
  }
}
