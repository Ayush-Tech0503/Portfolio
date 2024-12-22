import 'package:flutter/material.dart';
import '../../Util/constaint_textstyle.dart';
import '../../Util/constant_color.dart';
Widget loginPasswordAvtar ({backCircleRadius, frontCircleRadius, circleText,context}){
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

