
import 'package:centavizers/helpers/string_helper.dart';
import 'package:centavizers/utils/globle_context.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/app_buttons.dart';
import '../../components/back_button.dart';
import '../../components/text_fiels.dart';
import '../../cubits/user_signup/user_signup_cubit.dart';
import '../../cubits/user_signup/user_signup_state.dart';
import '../../helpers/color_helper.dart';
import '../../helpers/dimens_helper.dart';
import '../../helpers/font_helper.dart';
import '../../network_manager/auth_device_data.dart';
import '../../routes/routes_name.dart';
import '../../utils/app_images.dart';
import '../../utils/loading_indicator.dart';
import '../social_login/apple_login_button.dart';
import '../social_login/google_login_button.dart';
import 'login_screen.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
@override
  void initState() {
   UserAuthenticationApis().getId();
    super.initState();
  }
  final TextEditingController fullNameController = TextEditingController();
  final FocusNode fullNameFocusNode = FocusNode();
  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();
  final TextEditingController phoneController =  TextEditingController();
  // MaskedTextController(mask: "000-000-0000");
  final FocusNode phoneFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

@override
  void dispose() {
  fullNameFocusNode.dispose();
    super.dispose();
  }
  // final FlCountryCodePicker flCountryCodePicker = const FlCountryCodePicker();

  @override
  Widget build(BuildContext context) {
    fullNameFocusNode.addListener(() {
      setState(() {});
    });
    // final stringHelper = StringHelper.of(context)!;

    return Scaffold(
        appBar: AppBar(
          leading: const BackButtonWidget()

        ),
        body:Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: DimensHelper.dimens_20),
            child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(AppString.signUp, style: TextStyle(color: ColorHelper.primaryColor, fontSize: FontHelper.size_22, fontWeight: FontHelper.bold),),

                const SizedBox(height: DimensHelper.dimens_20,),

                CommonTextField(
                  controller: fullNameController,
                  currentFocus: fullNameFocusNode,
                  nextFocus: emailFocusNode,
                  hintText: AppString.enterName,
                  errorMessage: AppString.pleasEnterName,
                  icon: Padding(
                    padding: const EdgeInsets.all(DimensHelper.dimens_10),
                    child: Image.asset(AppImages.userIcon,
                        color: fullNameFocusNode.hasFocus
                            ? ColorHelper.primaryColor
                            : ColorHelper.greyColor,
                        width: DimensHelper.dimens_1,height: DimensHelper.dimens_1,fit: BoxFit.contain
                    ),
                  )
                ),


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

                // RichText(
                //   text:  TextSpan(
                //     text: AppString.byContinuingYouAgreeToOur,
                //     style: const TextStyle(color: ColorHelper.black, fontSize: FontHelper.size_14, fontWeight: FontHelper.regular),
                //     children: <TextSpan>[
                //       TextSpan(
                //         recognizer: TapGestureRecognizer()..onTap = () => print('Tap Here onTap'),
                //           text: stringHelper.termsOfConditions,
                //         style: const TextStyle(color: ColorHelper.primaryColor, fontSize: FontHelper.size_14, fontWeight: FontHelper.medium, decoration: TextDecoration.underline, decorationColor: ColorHelper.primaryColor),),
                //
                //        TextSpan(
                //         text: stringHelper.andInSort,
                //         style: const TextStyle(color: ColorHelper.black, fontSize: FontHelper.size_14, fontWeight: FontHelper.regular,),),
                //
                //        TextSpan(
                //         text: stringHelper.privacyPolicy,
                //         style: const TextStyle(color: ColorHelper.primaryColor, fontSize: FontHelper.size_14, fontWeight: FontHelper.medium, decoration: TextDecoration.underline, decorationColor: ColorHelper.primaryColor),),
                //     ],
                //   ),
                // ),



                Padding(
                  padding:  EdgeInsets.symmetric(
                      horizontal: context.globalSize.width/DimensHelper.dimens_20,
                      vertical: context.globalSize.height/DimensHelper.dimens_40
                  ),
                  child: Column(
                    children: [

                      signUpButton(),

                      SizedBox(height: context.globalSize.height/DimensHelper.dimens_40),

                      Row(
                        children: [
                          Expanded(child: Container(height: 2,
                            color: ColorHelper.grey300,
                            margin: const EdgeInsets.only(
                                right: DimensHelper.dimens_8),)),
                          const Text(AppString.or, style: TextStyle(
                              color: ColorHelper.primaryColor,
                              fontSize: FontHelper.size_14,
                              fontWeight: FontHelper.regular),),
                          Expanded(child: Container(height: 2,
                            color: ColorHelper.grey300,
                            margin: const EdgeInsets.only(left: DimensHelper.dimens_8),)),
                        ],
                      ),

                      SizedBox(height: context.globalSize.height/DimensHelper.dimens_40),


                      const GoogleLogInButton (title: AppString.upWithGoogle),

                      SizedBox(height: context.globalSize.height/DimensHelper.dimens_40),


                      const AppleLogInButton(title: AppString.upWithApple),

                      SizedBox(height: context.globalSize.height/DimensHelper.dimens_40),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(AppString.haveAnAccount, style: TextStyle(
                              color: ColorHelper.black,
                              fontWeight: FontHelper.regular,
                              fontSize: FontHelper.size_16)),
                          GestureDetector(
                              onTap: () => Navigator.pop(context),
                                // Navigator.pushNamed(context, RouteName.logIn);

                              child: const Text(AppString.signIn, style: TextStyle(
                                  color: ColorHelper.primaryColor,
                                  fontWeight: FontHelper.bold,
                                  fontSize: FontHelper.size_16,
                                  // decoration: TextDecoration.underline,
                                  decorationColor: ColorHelper.primaryColor),)),
                        ],
                      ),
                    ],
                  ),
                ),



                // const SizedBox(height: DimensHelper.dimens_20,),
                //
                // Row(
                //   children: [
                //     Expanded(child: Container(height: 2,color: ColorHelper.grey300,margin: const EdgeInsets.only(right: DimensHelper.dimens_8),)),
                //     Text(stringHelper.or, style: const TextStyle(color: ColorHelper.primaryColor, fontSize: FontHelper.size_14, fontWeight: FontHelper.regular),),
                //     Expanded(child: Container(height: 2,color: ColorHelper.grey300,margin: const EdgeInsets.only(left: DimensHelper.dimens_8),)),
                //
                //   ],
                // ),


                // const SizedBox(height: DimensHelper.dimens_20),
                //
                // Row(
                //   children: [
                //     Text(stringHelper.alreadyHaveAnAccount, style: const TextStyle(color: ColorHelper.black, fontWeight: FontHelper.medium, fontSize: FontHelper.size_16),),
                //     GestureDetector(
                //         onTap: (){
                //           Navigator.pushNamed(context, RouteName.logIn);
                //         },
                //         child: Text(stringHelper.logIn, style: const TextStyle(color: ColorHelper.primaryColor, fontWeight: FontHelper.medium, fontSize: FontHelper.size_16,decoration: TextDecoration.underline,decorationColor: ColorHelper.primaryColor),)),
                //   ],
                // ),

              ],
            ),
          ),
        )
    );
  }

  Widget signUpButton () {
    // final stringHelper = StringHelper.of(context)!;

    return BlocProvider(
      create: (_) => UserSignupCubit(),
      child: BlocBuilder<UserSignupCubit, UserSignupState>(
        builder: (context, state) {
          return CommonButton(
            onPress: (){

              if(state is UserSignupLoading){

              }else{
                if(_formKey.currentState!.validate()){
                  context.read<UserSignupCubit>().userSignUp(
                      context,
                      fullNameController.text,
                      emailController.text.toString(),
                      passwordController.text.toString(),
                      phoneController.text.toString());
                }
              }
              },
              child: state is UserSignupLoading? loadingButton():
              arrowButtonRow(
                  title: AppString.signUp,
                  leftIconColor: Colors.transparent,
                  rightIconColor: ColorHelper.secondaryColor
              ));

        }
      ),
    );
  }
}



showCustomCupertinoDialog(BuildContext context, String? title) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 1.0,
        titlePadding: const EdgeInsets.all(DimensHelper.dimens_12),
        contentPadding: const EdgeInsets.all(DimensHelper.dimens_12),
        alignment: Alignment.topCenter,
        title:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                title ?? "This is your OTP $title",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: DimensHelper.dimens_8),
            CircleAvatar(
              radius: DimensHelper.dimens_24,
              backgroundColor: ColorHelper.primaryColor,
              child: IconButton(onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close,color: ColorHelper.secondaryColor)),
            ),
          ],
        ),
      );
    },
  );




}
