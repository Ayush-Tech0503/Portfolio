import 'package:flutter/material.dart';
import '../../Utils/Constant Size /constant_sizes.dart';
import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';
import '../Alert Dialogs/alert_dialog_widget.dart';
import '../Custome Buttons/elevetion_button_widget.dart';
import '../custome_text_widget.dart';
import 'my_drawer_class_widget.dart';

Widget myDrawer ({icon, closeIconSize , closeIconColor, context, onPressedCloseIcon,
  sizeBoxHeight,  drawerHeaderText, drawerHeaderTextStyle, centerDrawerColor,centerDrawerBorder,child,avtarText}){
  var screenWidth = MediaQuery.of(context).size.width;
  var screenHeight = MediaQuery.of(context).size.height;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Align(
        alignment: Alignment.topRight,
        child: IconButton(
            icon: Icon(icon,
              size: closeIconSize,
              color:closeIconColor,),
            onPressed: onPressedCloseIcon),
      ),
      Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(color:centerDrawerColor),
        padding: EdgeInsets.symmetric(horizontal: screenWidth/30),
        height: sizeBoxHeight,
        child:  Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: ConstantColor.circleAvatar1,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: ConstantColor.circleAvatar2,
                child: Text(avtarText??':)', style: ConstantTextStyle.drawerHeadText,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(width: screenWidth/40,),
            customeText(
              textAlign: TextAlign.start,
              text: drawerHeaderText,
              style: drawerHeaderTextStyle,
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth/20,vertical: screenHeight/40),
        child:  customeText(
          textAlign: TextAlign.start,
          text: "Seller Options",
          style: drawerHeaderTextStyle,
        ),
      ),
      Flexible(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: screenHeight/20,
            left: screenWidth/40,
            right: screenWidth/30,
          ),
          child: Container(
            decoration: BoxDecoration(
              color:centerDrawerColor,
              borderRadius: centerDrawerBorder,
            ),
            child: child,
          ),
        ),
      ),

      InkWell(
        onTap: () {
          YesNoPermissionDialog.showExitConfirmationDialog(
            context:context, title: 'Please Confirm!', content: 'Are you sure want to Log Out?',
            actions: [
              customButton(
                textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                onPressed:() {clearToken();Navigator.pushNamedAndRemoveUntil(context, '/loginScreen', (route) => false);},
                text: "Yes",
                backgroundColor: ConstantColor.loginWithOtpButtonColor,
                borderRadius: BorderRadius.circular(20.0),
                elevation: 0.0,
              ),
              constantWidth(context, 100.0),
              customButton(
                textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                onPressed:() => Navigator.pop(context),
                text: "No",
                backgroundColor: ConstantColor.primaryMainColor,
                borderRadius: BorderRadius.circular(20.0),
                elevation: 0.0,
              ),
            ],
          );
          },
        child: Container(
          width: screenWidth,
          padding: EdgeInsets.symmetric(vertical: screenHeight/80.0),
          color: ConstantColor.drawerDividerColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.logout_outlined, color: ConstantColor.primaryBackgroundMainColor),
              SizedBox(width: screenWidth/80.0),
              customeText(text: 'Log out', style: ConstantTextStyle.newiconButtonText),
            ],
          ),
        ),
      ),
    ],
  );
}