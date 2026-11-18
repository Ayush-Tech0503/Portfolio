import 'package:centavizers/cubits/delete_account/delete_account_cubit.dart';
import 'package:centavizers/cubits/delete_account/delete_account_state.dart';
import 'package:centavizers/helpers/string_helper.dart';
import 'package:centavizers/screens/Settings/sync_device_card.dart';
import 'package:centavizers/utils/globle_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/app_buttons.dart';
import '../../cubits/Log_out/log_out_cubit.dart';
import '../../cubits/Log_out/log_out_state.dart';
import '../../helpers/color_helper.dart';
import '../../helpers/dimens_helper.dart';
import '../../helpers/font_helper.dart';
import '../../models/settings_model.dart';
import '../../routes/routes_name.dart';
import '../../utils/app_images.dart';
import '../../utils/loading_indicator.dart';
import '../auth_screen/login_screen.dart';


class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    onTapScreen(screenTitle) async {
      // if (hashNetwork) {
      switch (screenTitle) {
        case ('Logout'):
          _showLogOutBottomSheet(context);
          break;
          case ('Delete Account'):
            _showDeleteAcBottomSheet(context);
          break;
          case ('Reset Password'):
            Navigator.pushNamed(context, RouteName.changePassword);
            break;
          case ('FAQs'):
          Navigator.pushNamed(context, RouteName.faqS);
          break;
          case ('Manage Notifications'):
          Navigator.pushNamed(context, RouteName.manageNotification);
          break;
          case ('Terms and  Conditions'):
          Navigator.pushNamed(context, RouteName.staticContentView, arguments: {"title" : AppString.termsAndCondition,  "content": "terms"});
          break;
        case ('Privacy Policy'):
          Navigator.pushNamed(context, RouteName.staticContentView, arguments: {"title" : AppString.privacyPolicy,  "content": "privacy"});
          break;
          case ('Help and Supports'):
          Navigator.pushNamed(context, RouteName.helpSupport);
          break;

        default:
        // toastMessage("Oops! No route avilable.");
      }
    }


    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: DimensHelper.dimens_20),
      child:

      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
         // const  WatchCard(),
         //  const SizedBox(height: DimensHelper.dimens_20),
          ListView.builder(
              itemCount: options.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = options[index];
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
                    color: ColorHelper.whiteColor,
                    border: Border.all(color: ColorHelper.grey300),
                    boxShadow: [
                      BoxShadow(
                        color: ColorHelper.greyColor.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.only(bottom: DimensHelper.dimens_14),
                  child: ListTile(
                    // dense: true,
                    leading: Image.asset(
                         item['icon'].toString(),
                        height: DimensHelper.dimens_26,
                        color: ColorHelper.greyIcon2Color),
                    title: Text(item['title'] ?? "",
                      style: const TextStyle(
                        color: ColorHelper.greyIcon2Color,
                        fontSize: DimensHelper.dimens_16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward, color: ColorHelper.primaryColor),
                    onTap: () => onTapScreen(item['title'] ?? ""),
                  ),
                );
              }),


      //     const SizedBox(height: DimensHelper.dimens_40),
      //   ],
      // ),
    );
  }

//-------logout sheet --------------------
  void _showDeleteAcBottomSheet(BuildContext context) {
    showModalBottomSheet(
      // isDismissible: true,
      context: context,
      elevation: 0,
      backgroundColor: ColorHelper.primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(DimensHelper.dimens_40)),
      ),
      builder: (BuildContext context) {return _buildDeleteAcBottomSheetWidget(context);},
    );
  }

  Widget _buildDeleteAcBottomSheetWidget(BuildContext context) {
    return SingleChildScrollView(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        width: double.maxFinite,
        decoration: const BoxDecoration(
            color: ColorHelper.primaryColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(DimensHelper.dimens_40),
              topLeft: Radius.circular(DimensHelper.dimens_40),
            )
        ),
        padding: EdgeInsets.symmetric(horizontal: context.globalSize.width / DimensHelper.dimens_10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(AppImages.settingDelete,
              color: ColorHelper.secondaryColor,
              width: context.globalSize.width / DimensHelper.dimens_4,
              height: context.globalSize.height / DimensHelper.dimens_4,
            ),
            const Text(
              AppString.delete,
              style: TextStyle(
                color: ColorHelper.whiteColor,
                fontWeight: FontHelper.bold,
                fontSize: FontHelper.size_24,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: DimensHelper.dimens_20),
            const Text(
              AppString.deleteConfirmation,
              style: TextStyle(
                color: ColorHelper.whiteColor,
                fontWeight: FontHelper.regular,
                fontSize: FontHelper.size_16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: DimensHelper.dimens_40),


            BlocProvider(
              create: (context) => DeleteAccountCubit(),
              child: BlocBuilder<DeleteAccountCubit, DeleteAccountState>(
                builder: (context, state) {
                  return CommonButton(
                    bgColor: ColorHelper.whiteColor,
                    onPress: () {
                      if(state is DeleteAccountLoading){}
                      else{context.read<DeleteAccountCubit>().deleteAccount(context);}
                    },
                    // => Navigator.pushNamed(context, RouteName.syncWatchData),
                    child:
                    state is DeleteAccountLoading ? loadingButton(color: ColorHelper.primaryColor) :
                    arrowButtonRow(
                      title: AppString.confirm,
                      titleColor: ColorHelper.primaryColor,
                      leftIconColor: Colors.transparent,
                      rightIconColor: ColorHelper.secondaryColor,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: DimensHelper.dimens_20),

            CommonButton(
              bgColor: ColorHelper.primaryColor,
              onPress: () => Navigator.pop(context),
              child:
              // state is UserLogInLoading ? loadingButton() :
              arrowButtonRow(
                  title: AppString.cancel,
                  titleColor: ColorHelper.whiteColor,
                  leftIconColor: Colors.transparent,
                  rightIconColor: Colors.transparent
              ),
            ),
            const SizedBox(height: DimensHelper.dimens_40),

          ],
        ),
      ),
    );
  }
//-------logout sheet --------------------
  void _showLogOutBottomSheet(BuildContext context) {
    showModalBottomSheet(
      // isDismissible: true,
      context: context,
      elevation: 0,
      backgroundColor: ColorHelper.primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(DimensHelper.dimens_40)),
      ),
      builder: (BuildContext context) {
        return _buildBottomSheetWidget(context); // Your bottom sheet widget
      },
    );
  }

  Widget _buildBottomSheetWidget(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: MediaQuery
          .of(context)
          .viewInsets
          .bottom,
      ),
      child: Container(
        width: double.maxFinite,
        decoration: const BoxDecoration(
            color: ColorHelper.primaryColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(DimensHelper.dimens_40),
              topLeft: Radius.circular(DimensHelper.dimens_40),
            )
        ),
        padding: EdgeInsets.symmetric(horizontal: context.globalSize.width / DimensHelper.dimens_10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(AppImages.logOutUser,
              width: context.globalSize.width / DimensHelper.dimens_4,
              height: context.globalSize.height / DimensHelper.dimens_4,
            ),
            const Text(
              AppString.logOut,
              style: TextStyle(
                color: ColorHelper.whiteColor,
                fontWeight: FontHelper.bold,
                fontSize: FontHelper.size_24,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: DimensHelper.dimens_20),
            const Text(
              AppString.logoutConfirmation,
              style: TextStyle(
                color: ColorHelper.whiteColor,
                fontWeight: FontHelper.regular,
                fontSize: FontHelper.size_16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: DimensHelper.dimens_40),


            BlocProvider(
              create: (context) => LogOutCubit(),
              child: BlocBuilder<LogOutCubit, LogOutState>(
                builder: (context, state) {
                  return CommonButton(
                    bgColor: ColorHelper.whiteColor,
                    onPress: () {
                      if(state is LogOutLoading){}
                      else{context.read<LogOutCubit>().logOut(context);}
                    },
                    // => Navigator.pushNamed(context, RouteName.syncWatchData),
                    child:
                    state is LogOutLoading ? loadingButton(color: ColorHelper.primaryColor) :
                    arrowButtonRow(
                      title: AppString.confirm,
                      titleColor: ColorHelper.primaryColor,
                      leftIconColor: Colors.transparent,
                      rightIconColor: ColorHelper.secondaryColor,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: DimensHelper.dimens_20),

            CommonButton(
              bgColor: ColorHelper.primaryColor,
              onPress: () => Navigator.pop(context),
              child:
              // state is UserLogInLoading ? loadingButton() :
              arrowButtonRow(
                  title: AppString.cancel,
                  titleColor: ColorHelper.whiteColor,
                  leftIconColor: Colors.transparent,
                  rightIconColor: Colors.transparent
              ),
            ),
            const SizedBox(height: DimensHelper.dimens_40),

          ],
        ),
      ),
    );
  }
}





