import 'package:flutter/material.dart';

import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';
Widget circleAvtarWithDivider ({backCircleRadius, frontCircleRadius, circleText,context}){
  var screenHeight = MediaQuery.of(context).size.height;
  return Column(
    children: [
      Stack(
        children:  [
          Padding(
            padding: EdgeInsets.only(top: screenHeight/80.0),
            child: const Divider(
              color: ConstantColor.loginWithOtpLineColor,
              thickness: 2,
            ),
          ),

          Center(
            child: CircleAvatar(
              radius: backCircleRadius,
              backgroundColor: ConstantColor.circleAvatar1,
              child: CircleAvatar(
                radius: frontCircleRadius,
                backgroundColor: ConstantColor.circleAvatar2,
                child: Text(circleText,style: ConstantTextStyle.passwordScreenLineTexStyle,),
              ),
            ),

          ),
        ],
      ),
    ],
  );
}

