import 'package:flutter/material.dart';

import '../../../../../Util/constaint_textstyle.dart';
import '../../../../../Util/constant_color.dart';
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



Widget addToCardButtonsWidget ({context, addToCardButtonOnPressed,buttonText = "Add To Cart", navigationBuyWithSellerButton }) {
  var screenWidth = MediaQuery.of(context).size.width;
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenWidth/40),
    child: ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      leading: iconTextButton(
        backgroundColor: ConstantColor.loginWithOtpButtonColor,
        icon: Icons.shopping_cart_outlined,
        iconColor: ConstantColor.primaryBackgroundMainColor,
        iconSize: 20.0,
        buttonOnPressed: addToCardButtonOnPressed,
        buttontext: buttonText,
        buttontextStyle: ConstantTextStyle.newiconButtonText,
        fixedSize: const Size(180, 1),
      ),
      title: iconTextButton(
        backgroundColor: ConstantColor.loginWithOtpButtonColor,
        icon: Icons.shopping_bag_outlined,
        iconColor: ConstantColor.primaryBackgroundMainColor,
        iconSize: 20.0,
        buttonOnPressed: navigationBuyWithSellerButton,
        buttontext: "Buy Now",
        buttontextStyle: ConstantTextStyle.newiconButtonText,
        //  fixedSize: const Size(190, 1),
      ),
    ),
  );
}