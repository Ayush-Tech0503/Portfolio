import 'package:flutter/material.dart';

import '../Theme/constant_colors.dart';

class ConstantTextStyle {

  static TextStyle lableTextStyle = const TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 13,
    color: ConstantColor.primaryGreyColor,);

  static TextStyle withoutLoginText = const TextStyle(
      fontWeight: FontWeight.w600,
      fontFamily: 'Montserrat',
      color: ConstantColor.transparent1,
      shadows: [
        Shadow(
            color: ConstantColor.loginWithOtpButtonColor,
            offset: Offset(0, -5))
      ],
      decoration:
      TextDecoration.underline,
      decorationColor:ConstantColor.primaryMainColor,
      decorationThickness: 1,
      fontSize: 14
  );

  static TextStyle lableRadioText = const TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: ConstantColor.primaryGreyColor,);

  static TextStyle lableTextHeadStyle = const TextStyle(
    height: 4,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    fontSize: 13,
    color: ConstantColor.primaryGreyColor,);

  static TextStyle lableTextStyle2 = const TextStyle(

    //height: 3.5,
    fontFamily: 'Montserrat',
    // fontWeight: FontWeight.w500,
    fontSize: 12,
    color: ConstantColor.secondtryGrayColor,
  );

  static TextStyle loginButtonTextStyle =  const TextStyle(
    color: ConstantColor.primaryBackgroundMainColor,
    fontFamily: 'Montserrat',
    fontSize: 13,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
  );
  static TextStyle toastTextStyle =  const TextStyle(
      color: ConstantColor.primaryBackgroundMainColor,
      fontFamily: 'Montserrat',
      fontSize: 13,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      decoration: TextDecoration.none
  );
  static TextStyle tabButtonTextStyle =  const TextStyle(
    color: ConstantColor.primaryMainColor,
    fontFamily: 'Montserrat',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
  );
  static TextStyle locationText =  const TextStyle(
    color: ConstantColor.primaryMainColor,
    fontFamily: 'Montserrat',
    fontSize: 10,
    fontWeight: FontWeight.w500,
  );

  static TextStyle tabButtonTextStyle2 =  const TextStyle(
    color: ConstantColor.tabButtonBlackColors,
    fontFamily: 'Montserrat',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
  );

  static TextStyle reviewsRatingsText =  const TextStyle(
    color: ConstantColor.primaryBackgroundMainColor,
    fontFamily: 'Montserrat',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
  );
  static TextStyle trendingReelsText =  const TextStyle(
    color: ConstantColor.primaryBackgroundMainColor,
    fontFamily: 'Montserrat',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
  );

  static TextStyle redeemButtonTextStyle =  const TextStyle(
    color: ConstantColor.filedContainerColor,
    fontFamily: 'Montserrat',
    fontSize: 14,
    fontStyle: FontStyle.normal,
  );
  static TextStyle  hintTextStyle =  const TextStyle(
    color: ConstantColor.primaryMainColor,
    fontFamily: 'Montserrat',
    fontSize: 12,
    fontStyle: FontStyle.normal,
  );

  static  TextStyle checkboxTextStyle1 = const TextStyle(
    color: ConstantColor.landingScreenSubHaddingColor,
    fontFamily: 'Montserrat',
    fontSize: 13,
  );
  static  TextStyle checkboxTextStyle2 = const TextStyle(
    fontFamily: 'Montserrat',
    decoration: TextDecoration.underline,
    color: ConstantColor.primaryMainColor,
    fontSize: 13,
  );

  static TextStyle carouselSliderText = const TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: ConstantColor.primaryMainColor
  );

  static TextStyle lableTextSubHeading2 = const TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: 'Montserrat',
      fontSize: 14,
      color: ConstantColor.landingScreenSubHaddingColor);


  static TextStyle lableTextHeading1 = const TextStyle(
      fontWeight: FontWeight.w700,
      fontFamily: 'Montserrat',
      color: ConstantColor.loginWithOtpButtonColor,
      fontSize: 14
  );

  static TextStyle drawerHeadText = const TextStyle(
      fontWeight: FontWeight.w700,
      fontFamily: 'Montserrat',
      color: ConstantColor.drawerDividerColor,
      fontSize: 16
  );

  static TextStyle feedBackHeadText = const TextStyle(
      fontWeight: FontWeight.w700,
      fontFamily: 'Montserrat',
      color: ConstantColor.loginWithOtpButtonColor,
      fontSize: 18
  );

  static TextStyle requirementText = const TextStyle(
      fontWeight: FontWeight.w700,
      fontFamily: 'Montserrat',
      color: ConstantColor.loginWithOtpButtonColor,
      fontSize: 16
  );

  static TextStyle cashbackCoinsText = const TextStyle(
      fontWeight: FontWeight.w700,
      height: 2,
      fontFamily: 'Montserrat',
      color: ConstantColor.loginWithOtpButtonColor,
      fontSize: 30
  );

  static TextStyle secodHearText = const TextStyle(
      fontWeight: FontWeight.w700,
      fontFamily: 'Montserrat',
      color: ConstantColor.loginWithOtpButtonColor,
      fontSize: 14
  );

  static TextStyle secodHearText1 = const TextStyle(
      fontWeight: FontWeight.w700,
      fontFamily: 'Montserrat',
      height: 1.5,
      color: ConstantColor.loginWithOtpButtonColor,
      fontSize: 16
  );

  static TextStyle secodHearText2 = const TextStyle(
      fontWeight: FontWeight.w700,
      fontFamily: 'Montserrat',
      color: ConstantColor.transparent1,
      shadows: [
        Shadow(
            color: ConstantColor.loginWithOtpButtonColor,
            offset: Offset(0, -5))
      ],
      decoration:
      TextDecoration.underline,
      decorationColor:ConstantColor.primaryMainColor,
      decorationThickness: 2,
      fontSize: 16
  );

  static TextStyle otpResendButtonText = const TextStyle(
      fontWeight: FontWeight.w500,
      fontFamily: 'Montserrat',
      color: ConstantColor.primaryMainColor,
      fontSize: 14
  );

  static TextStyle  otpHintTextStyle =  const TextStyle(
    color: ConstantColor.primaryMainColor,
    fontFamily: 'Montserrat',
    fontSize: 14,
    height: 2.0,
    fontWeight: FontWeight.w700,
  );
  static TextStyle  sellerHintTextStyle =  const TextStyle(
    color: ConstantColor.primaryMainColor,
    fontFamily: 'Montserrat',
    fontSize: 12,
    //height: 2.0,
    fontWeight: FontWeight.w600,
  );

  static TextStyle registrationDialogBox = const TextStyle(
      fontWeight: FontWeight.w600,
      fontFamily: 'Montserrat',
      fontSize: 16,
      color: ConstantColor
          .landingScreenSubHaddingColor);

  static TextStyle  passwordScreenLineTexStyle =  const TextStyle(
    color: ConstantColor.primaryMainColor,
    fontFamily: 'Montserrat',
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
  static TextStyle  homeScreenHeadingText1 =  const TextStyle(
    color: ConstantColor.loginWithOtpButtonColor,
    fontFamily: 'Montserrat',
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  static TextStyle  homeScreenHeadingText2 =  const TextStyle(
    color: ConstantColor.loginWithOtpButtonColor,
    fontFamily: 'Montserrat',
    fontSize: 20,
    fontWeight: FontWeight.w900,
  );

  static TextStyle  countingText =  const TextStyle(
    color: ConstantColor.primaryMainColor,
    fontFamily: 'Montserrat',
    fontSize: 18,
    fontWeight: FontWeight.w800,
  );

  static TextStyle  homeScreenHeadingText3 =  const TextStyle(
    color: ConstantColor.loginWithOtpButtonColor,
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static TextStyle  cashPointText =  const TextStyle(
    color: ConstantColor.filedContainerColor,
    fontFamily: 'Montserrat',
    fontSize: 25,
    fontWeight: FontWeight.w800,
  );

  static TextStyle  landingScreenAppbarText =  const TextStyle(
    color: ConstantColor.secondryBackgroundMainColor,
    fontFamily: 'Montserrat',
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static TextStyle  allHomeScreenAvatarText = const TextStyle(
    color: ConstantColor.loginWithOtpButtonColor,
    fontFamily: 'Montserrat',
    fontSize: 11,
    fontWeight: FontWeight.w600,
  );

  static TextStyle  greenText = const TextStyle(
    color: ConstantColor.chipCompleteStatus,
    fontFamily: 'Montserrat',
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  static TextStyle  splaceVersion = const TextStyle(
    color: ConstantColor.loginWithOtpButtonColor,
    fontFamily: 'Montserrat',
    fontSize: 10,
    fontWeight: FontWeight.w600,
  );

  static TextStyle  dropDownPrimeText = const TextStyle(
    color: ConstantColor.primaryMainColor,
    fontFamily: 'Montserrat',
    fontSize: 11,
    fontWeight: FontWeight.w600,
  );

  static TextStyle  becomeSellerDiscText  = const TextStyle(
    color: ConstantColor.loginWithOtpButtonColor,
    fontFamily: 'Montserrat',
    fontSize: 12,
    // fontWeight: FontWeight.w500,
  );
  static TextStyle  topCategoryText =
  const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    fontFamily: 'Montserrat',
    color: ConstantColor.loginWithOtpButtonColor,
  );

  static TextStyle  topCategoryText2 =
  const TextStyle(
    fontSize: 12,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    color: ConstantColor.loginWithOtpButtonColor,
  );
  static TextStyle  storeSecondoryText =
  const TextStyle(
    fontSize: 12,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    color: ConstantColor.primaryBlackColor,
  );

  static TextStyle  storeDetailsText2 =
  const TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 12,
    //  fontWeight: FontWeight.w500,
    color: ConstantColor.loginWithOtpButtonColor,
  );
  static TextStyle  storeDetailsText3 = const TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: ConstantColor.primaryBlackColor,
  );
  static TextStyle  storeDetailsText4 = const TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: ConstantColor.primaryBlackColor,
  );

  static TextStyle  imageColorGrayText = const TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: ConstantColor.subtitleGreyColor
  );


  static TextStyle  topCategoryText3 =
  const TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: ConstantColor.bottonNavIcons,
  );

  static TextStyle  topCategoryText4 =
  const TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: ConstantColor.loginWithOtpButtonColor,
  );

  static TextStyle  seeMoreButtonStyle =
  const TextStyle(
    fontSize: 14,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w500,
    shadows: [
      Shadow(
          color: ConstantColor.primaryMainColor,
          offset: Offset(0, -5))
    ],
    color: Colors.transparent,
    decoration:
    TextDecoration.underline,
    decorationColor:ConstantColor.primaryMainColor,
    decorationThickness: 2,
  );

  static TextStyle  seeMoreButtonStyle2 =
  const TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    shadows: [
      Shadow(
          color: ConstantColor.primaryMainColor,
          offset: Offset(0, -5))
    ],
    color: Colors.transparent,
    decoration:
    TextDecoration.underline,
    decorationColor:ConstantColor.primaryMainColor,
    decorationThickness: 2,
  );

  static TextStyle  seeMoreButtonStyle3 =
  const TextStyle(
    fontSize: 14,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w800,
    shadows: [
      Shadow(
          color: ConstantColor.bottonNavIcons,
          offset: Offset(0, -5))
    ],
    color: Colors.transparent,
    decoration:
    TextDecoration.underline,
    decorationColor:ConstantColor.bottonNavIcons,
    decorationThickness: 4,
  );

  static TextStyle  secondorGrayText =  const TextStyle(
    color: ConstantColor.secondtryGrayColor,
    fontSize: 12,
    fontFamily: 'Montserrat',
    // fontWeight: FontWeight.w500,
  );

  static TextStyle  richtext1 =  const TextStyle(
    color: ConstantColor.primaryMainColor,
    fontFamily: 'Montserrat',
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static TextStyle  richtext2 =  const TextStyle(
    decoration: TextDecoration.lineThrough,
    fontFamily: 'Montserrat',
    color: ConstantColor.secondtryGrayColor,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
  static TextStyle  secondryLocationText =  const TextStyle(
    color: ConstantColor.secondtryGrayColor,
    fontFamily: 'Montserrat',
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );
  static TextStyle  newiconButtonText =  const TextStyle(
    color: ConstantColor.bottonNavIcons,
    fontSize: 11,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
  );
  static TextStyle  chipText =  const TextStyle(
    color: ConstantColor.primaryBackgroundMainColor,
    fontFamily: 'Montserrat',
    fontSize: 13,
    // fontWeight: FontWeight.w500,
  );

  static TextStyle  cardbottumText =  const TextStyle(
    color: ConstantColor.loginWithOtpButtonColor,
    fontFamily: 'Montserrat',
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );


  static TextStyle  chashBackchipText =  const TextStyle(
    color: ConstantColor.bottonNavIcons,
    fontFamily: 'Montserrat',
    fontSize: 10,
    fontWeight: FontWeight.w500,
  );

  static TextStyle  dateChipText =  const TextStyle(
    color: ConstantColor.bottonNavIcons,
    fontFamily: 'Montserrat',
    fontSize: 10,
    fontWeight: FontWeight.w600,
  );

  static TextStyle  ratingText =  const TextStyle(
    color: ConstantColor.bottonNavIcons,
    fontFamily: 'Montserrat',
    fontSize: 10,
    fontWeight: FontWeight.w500,
  );
  static TextStyle  homePageRatingText =  const TextStyle(
    color: ConstantColor.bottonNavIcons,
    fontFamily: 'Montserrat',
    fontSize: 8,
    fontWeight: FontWeight.w500,
  );
  static TextStyle  productScreenAppbar =  const TextStyle(
    color: ConstantColor.secondryBackgroundMainColor,
    fontFamily: 'Montserrat',
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  static TextStyle  storeLocationText =  const TextStyle(
    color: ConstantColor.loginWithOtpButtonColor,
    fontFamily: 'Montserrat',
    fontSize: 10,
    fontWeight: FontWeight.w500,
  );
  static TextStyle  profileGridText =  const TextStyle(
    color: ConstantColor.loginWithOtpButtonColor,
    fontFamily: 'Montserrat',
    fontSize: 11,
    fontWeight: FontWeight.w700,
  );
  static TextStyle proDetailBlueText =  const TextStyle(
    color: ConstantColor.transparent1,
    fontFamily: 'Montserrat',
    fontSize: 12,
    fontWeight: FontWeight.w500,
    shadows: [
      Shadow(
          color: ConstantColor.detailUnderLineTextColor,
          offset: Offset(0, -4))
    ],
    decoration:
    TextDecoration.underline,
    decorationColor:ConstantColor.detailUnderLineTextColor,
    decorationThickness: 1,
  );


  static TextStyle  colorsHeadingText =  const TextStyle(
    color: ConstantColor.loginWithOtpButtonColor,
    fontFamily: 'Montserrat',
    fontSize: 13,
    // fontWeight: FontWeight.w600,
  );
  static TextStyle  ratingText2 =  const TextStyle(
    color: ConstantColor.loginWithOtpButtonColor,
    fontFamily: 'Montserrat',
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );
  static TextStyle  bottomNavActiveText =  const TextStyle(
    color: ConstantColor.loginWithOtpButtonColor,
    fontFamily: 'Montserrat',
    fontSize: 11,
    fontWeight: FontWeight.w600,
  );
  static TextStyle  bottomNavInActiveText =  const TextStyle(
    color: Colors.black26,
    fontFamily: 'Montserrat',
    fontSize: 11,
    fontWeight: FontWeight.w600,
  );
  static TextStyle  skyBlueColorShopName =  const TextStyle(
    color: ConstantColor.skyBlueColor,
    fontFamily: 'Montserrat',
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );
  static TextStyle  skyBlueColorText =  const TextStyle(
    color: ConstantColor.skyBlueColor,
    fontFamily: 'Montserrat',
    fontSize: 12,
  );
  static TextStyle  subtitleGreyText =  const TextStyle(
    color: ConstantColor.subtitleGreyColor,
    fontFamily: 'Montserrat',
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
  static TextStyle  subRatingText =
  const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    fontFamily: 'Montserrat',
    color: ConstantColor.loginWithOtpButtonColor,
  );

  static TextStyle  ratingBigTextSize =
  const TextStyle(
    fontSize: 30,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    color: ConstantColor.loginWithOtpButtonColor,
  );

  static TextStyle  hintTextStyle2 =  const TextStyle(
    color: ConstantColor.primaryMainColor,
    fontFamily: 'Montserrat',
    fontSize: 13,
    fontStyle: FontStyle.normal,
  );

  static TextStyle textFormFildStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      fontFamily: 'Montserrat',
      color: ConstantColor.filedContainerColor,
      fontSize: 12
  );

  static TextStyle textFormFildStyle2 = const TextStyle(
      fontWeight: FontWeight.w500,
      //  height: 2,
      fontFamily: 'Montserrat',
      color: ConstantColor.filedContainerColor,
      fontSize: 14
  );
  static TextStyle  productSubTextStyle =  const TextStyle(
    color: ConstantColor.productSubTextColor,
    fontFamily: 'Montserrat',
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static TextStyle  imageColorTextStyle = const TextStyle(
    color: ConstantColor.primaryBlackColor,
    fontFamily: 'Montserrat',
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  static TextStyle  realsIconsTextStyle =  const TextStyle(
    color: ConstantColor.primaryBackgroundMainColor,
    fontFamily: 'Montserrat',
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
  static TextStyle  greyCancelText = const TextStyle(
    decoration: TextDecoration.lineThrough,
    color: Colors.grey,
    fontSize: 11,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
  );

  static TextStyle resendOtpTextStyle =  const TextStyle(
    color: ConstantColor.transparent1,
  );
}

