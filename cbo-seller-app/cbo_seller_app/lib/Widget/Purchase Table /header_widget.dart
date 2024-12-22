import 'package:flutter/material.dart';

import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';
import '../Custome Buttons/elevetion_button_widget.dart';
import '../custome_text_widget.dart';

Widget tablePlanHeaderDataWidget ({
  context,
  planName,
  planAmount,
  onPressed,
  buttonTitle,
  minimumSize,
  buttonStyle,
  buttonBackground
}){
  var screenHeight = MediaQuery.of(context).size.height;
  var screenWidth = MediaQuery.of(context).size.width;
  return  SingleChildScrollView(
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(planName??"", textAlign: TextAlign.start, style: ConstantTextStyle.carouselSliderText),
          customeText(text: "₹${planAmount ??''}", textAlign: TextAlign.center, style: ConstantTextStyle.allHomeScreenAvatarText),
          customButton(
            textStyleButton: buttonStyle ?? ConstantTextStyle.landingScreenAppbarText,
            onPressed: onPressed,
            text: buttonTitle??'',
            backgroundColor:  buttonBackground ?? ConstantColor.primaryMainColor,
            borderRadius: BorderRadius.circular(8.0),
            minimumSize: minimumSize ?? Size(screenWidth/30, screenHeight/40),
            elevation: 1.0,
          ),
        ]
    ),
  );
}