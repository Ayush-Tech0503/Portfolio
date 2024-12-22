import 'package:flutter/material.dart';

import '../../../../../Util/constaint_textstyle.dart';
import '../../../../../Util/constant_color.dart';
import '../../../../../Widgets/Send Enquiry dialogBox/alert_dialog_box.dart';
import '../../../../../Widgets/landing_screen_slider.dart';
Widget userBottomNavBarScreen ({
  context, senEnquiryTitleText,
  sendEnquiryDescriptionText,sendEnqButton,buttonText = "Send Enquiry",
  navigationChatWithSellerButton,phoneNumber }) {
  var screenWidth = MediaQuery.of(context).size.width;
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenWidth/40),
    child:
    ListTile(
      contentPadding: EdgeInsets.zero,
      leading: iconTextButton(
        backgroundColor: ConstantColor.loginWithOtpButtonColor,
        icon: Icons.content_paste_search,
        iconColor: ConstantColor.primaryBackgroundMainColor,
        iconSize: 20.0,
        buttonOnPressed: sendEnqButton,
        buttontext: buttonText,
        buttontextStyle: ConstantTextStyle.newiconButtonText,
        fixedSize: const Size(180, 1),
      ),
      title:iconTextButton(
        backgroundColor: ConstantColor.filedContainerColor,
        icon: Icons.message_sharp,
        iconColor: ConstantColor.primaryBackgroundMainColor,
        iconSize: 20.0,
        buttonOnPressed: navigationChatWithSellerButton,
        buttontext: "Chat With Seller",
        buttontextStyle: ConstantTextStyle.newiconButtonText,
      //  fixedSize: const Size(190, 1),
      ),
    ),
  );
}