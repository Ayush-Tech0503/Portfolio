import 'package:flutter/material.dart';

import '../Utils/Font Style/text_styles.dart';
import '../Utils/Theme/constant_colors.dart';
import 'custome_text_widget.dart';

Widget bottomButtons ({context, icon1, onTap1, icon2, onTap2, lable1, lable2}){
  var screenWidth = MediaQuery.of(context).size.width;
  return ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: screenWidth/30.0),
    leading: InkWell(
      onTap: onTap1,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: ConstantColor.primaryMainColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Ensures the Row does not take up more space than needed
          children: [
             Icon(
              icon1,
              color: ConstantColor.primaryBackgroundMainColor,
              size: 16.0,
            ),
            SizedBox(width: screenWidth/80.0),
            customeText(
              text: lable1 ?? '',
              style: ConstantTextStyle.chipText,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
    title: InkWell(
      onTap: onTap2,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        // margin: EdgeInsets.symmetric(horizontal: screenWidth / 30.0, vertical: screenHeight / 80.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: ConstantColor.loginWithOtpButtonColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
             Icon(
              icon2,
              color: ConstantColor.primaryBackgroundMainColor,
              size: 16.0,
            ),
            SizedBox(width: screenWidth/80.0),
            customeText(
              text: lable2 ?? '',
              style: ConstantTextStyle.chipText,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}