import 'package:flutter/material.dart';

import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';

Widget iconTextWidget ({context,iconData,titleText,backgroundColor,width, height}){
  var screenWidth = MediaQuery.of(context).size.width;
  var screenHeight = MediaQuery.of(context).size.height;
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: backgroundColor ??  ConstantColor.carColor,
    ),
    width: width ?? screenWidth/7,
    height: height ?? screenHeight/10,
    child: Center(
      child: Text.rich(
        TextSpan(
          children: [
            WidgetSpan(child: iconData),
            TextSpan(text: titleText ?? '', style: ConstantTextStyle.becomeSellerDiscText),
          ],
        ),
      ),
    ),
  );
}