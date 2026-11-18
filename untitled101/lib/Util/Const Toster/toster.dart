import 'package:Citybazar_app/Util/constaint_textstyle.dart';
import 'package:flutter/material.dart';
import '../constant_color.dart';

class LoadingScaffoldMessage {
  static void showSnackbar(BuildContext context, String message,backgroundColor,duration) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width/10
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: ConstantColor.primaryBackgroundMainColor, width: .5),
          borderRadius: BorderRadius.circular(20.0),
        ),
        content: Text(message,style: ConstantTextStyle.reviewsRatingsText,),
        duration: duration,
      ),
    );
  }
}




class LoadingScaffoldMessage2 {
  static void showSnackbar(BuildContext context, String message,backgroundColor,duration) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/5,
        left: MediaQuery.of(context).size.width/10,
          right: MediaQuery.of(context).size.width/10,
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: ConstantColor.primaryBackgroundMainColor, width: 0.5),
          borderRadius: BorderRadius.circular(20.0),
        ),
        content: Text(message,style: ConstantTextStyle.reviewsRatingsText,),
        duration: duration,
      ),
    );
  }
}