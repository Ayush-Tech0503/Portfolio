import 'package:centavizers/helpers/string_helper.dart';
import 'package:centavizers/utils/app_images.dart';
import 'package:centavizers/utils/globle_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/app_buttons.dart';
import '../../components/back_button.dart';
import '../../components/text_fiels.dart';
import '../../cubits/change_user_password/change_user_password_cubit.dart';
import '../../cubits/change_user_password/change_user_password_state.dart';
import '../../cubits/reset_password/reset_password_cubit.dart';
import '../../helpers/color_helper.dart';
import '../../helpers/dimens_helper.dart';
import '../../helpers/font_helper.dart';
import '../../routes/routes_name.dart';
import '../../utils/loading_indicator.dart';
import '../../utils/toast_message.dart';
import '../auth_screen/login_screen.dart';

class ChangePassword extends StatefulWidget {
  // final Map args;
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  final TextEditingController oldPasswordController = TextEditingController();
  final FocusNode oldPasswordFocusNode = FocusNode();
  final TextEditingController newPasswordController = TextEditingController();
  final FocusNode newPasswordFocusNode = FocusNode();
  final TextEditingController confirmNewPasswordController = TextEditingController();
  final FocusNode confirmNewPasswordFocusNode = FocusNode();

  String userEmail = "";
  final _formKey = GlobalKey<FormState>();

  bool isBottomSheet = false;


  @override
  void initState() {
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmNewPasswordController.clear();

    // passwordFocusNode.dispose();
    // confirmPasswordFocusNode.dispose();
    // newPasswordFocusNode.dispose();
    // printValue(widget.args);
    // if(widget.args.containsKey('userEmail')){
    //   userEmail = widget.args['userEmail'];
    // }
    // passwordFocusNode.addListener(_onFocusChange);
    // confirmPasswordFocusNode.addListener(_onFocusChange);
    super.initState();
  }



  @override
  void dispose() {
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmNewPasswordController.clear();

    oldPasswordFocusNode.dispose();
    newPasswordFocusNode.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }


  // void _onFocusChange() {
  //   if (mounted) {
  //     setState(() {});
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    // final stringHelper = StringHelper.of(context)!;

    return Scaffold(
      appBar: AppBar(
          leading: const BackButtonWidget()
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: DimensHelper.dimens_20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(AppString.resentPassword, style: TextStyle(color: ColorHelper.primaryColor, fontSize: FontHelper.size_22, fontWeight: FontHelper
                  .bold),),

              const SizedBox(height: DimensHelper.dimens_10,),
              const Text(AppString.resentPasswordDes, style: TextStyle(color: ColorHelper.greyColor, fontSize:
              FontHelper.size_16, fontWeight: FontHelper.regular),),

              const SizedBox(height: DimensHelper.dimens_30,),

              PasswordTextField(controller: oldPasswordController,
                currentFocus: oldPasswordFocusNode,
                hintText: AppString.enterOldPassword,
                nextFocus: newPasswordFocusNode,),

              const SizedBox(height: DimensHelper.dimens_20,),

              PasswordTextField(controller: newPasswordController,
                  currentFocus: newPasswordFocusNode,
                  nextFocus: confirmNewPasswordFocusNode,
                  hintText: AppString.enterNewPassword
                // nextFocus: null,
              ),
              const SizedBox(height: DimensHelper.dimens_20,),

              PasswordTextField(controller: confirmNewPasswordController,
                  currentFocus: confirmNewPasswordFocusNode,
                  hintText: AppString.enterConfirmPassword
                // nextFocus: null,
              ),



            ],
          ),
        ),
      ),
      bottomNavigationBar: createNewPasswordButton(),
      // bottomSheet: _buildBottomSheetWidget(),
      // bottomSheet: isBottomSheet ? _buildBottomSheetWidget() : null,
    );
  }


  Widget createNewPasswordButton () {
    // final stringHelper = StringHelper.of(context)!;

    return BlocProvider(
      create: (_) => ChangePasswordCubit(),
      child: BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
          builder: (context, state) {
            return  Padding(
              padding: const EdgeInsets.only(
                  left: DimensHelper.dimens_40,
                  right: DimensHelper.dimens_40,
                  bottom: DimensHelper.dimens_60
              ),
              child: CommonButton(
                  onPress: (){
                    setState(() =>isBottomSheet = true);
                    if(state is ChangePasswordIsLoading){
                    }else{
                      if(_formKey.currentState!.validate()){
                        if(newPasswordController.text.toString() != confirmNewPasswordController.text.toString()){
                          toastMessage(AppString.passwordsMismatch);
                        }else{
                          context.read<ChangePasswordCubit>().changePassword(
                              context,
                              oldPasswordController.text.toString(),
                              newPasswordController.text.toString());
                        }
                      }
                    }

                  },
                  child: state is ChangePasswordIsLoading? loadingButton():
                   arrowButtonRow(
                      title: AppString.update,
                      leftIconColor: Colors.transparent,
                      rightIconColor: ColorHelper.secondaryColor
                  )),
            );
            // state is ChangePasswordLoading? loadingButton():
            // Text(stringHelper.createNewPassword, style: const TextStyle(color: ColorHelper.whiteColor, fontSize: FontHelper.size_18, fontWeight: FontHelper.bold),),);
          }
      ),
    );
  }



}






