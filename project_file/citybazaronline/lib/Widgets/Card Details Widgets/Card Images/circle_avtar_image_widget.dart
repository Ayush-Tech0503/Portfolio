import 'package:flutter/material.dart';
import '../../../Util/constant_color.dart';

Widget circleImageWidget ({circle1backgroundColor,circle2backgroundColor,circle1Radius,circle2Radius,backgroundImage}){
  return  CircleAvatar(
    backgroundColor: circle1backgroundColor ?? ConstantColor.loginWithOtpButtonColor,
    radius: circle1Radius ?? 40.0,
    child: CircleAvatar(
      backgroundColor: circle2backgroundColor ?? ConstantColor.primaryBackgroundMainColor,
      radius: circle2Radius ?? 30.0,
      backgroundImage: backgroundImage,
    ),
  );

}