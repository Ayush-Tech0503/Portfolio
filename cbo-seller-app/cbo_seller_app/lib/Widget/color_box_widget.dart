import 'package:flutter/material.dart';

import '../Utils/Font Style/text_styles.dart';
import '../Utils/Theme/constant_colors.dart';
import 'custome_text_widget.dart';

Widget colorBoxWidget ({context, color, text,style, textAlign,margin }){
  var screenHeight = MediaQuery.of(context).size.height;
  var screenWidth = MediaQuery.of(context).size.width;
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: color?? ConstantColor.primaryMainColor),
    margin: margin??EdgeInsets.zero,
    padding: EdgeInsets.symmetric(vertical: screenHeight /500, horizontal: screenWidth / 80),
    child: customeText(
      text:text ?? '',
      textAlign: textAlign ?? TextAlign.start,
      style: style?? ConstantTextStyle.loginButtonTextStyle,
    ),
  );
}