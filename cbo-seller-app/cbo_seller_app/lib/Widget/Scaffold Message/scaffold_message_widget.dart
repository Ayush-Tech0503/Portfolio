// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';

class LoadingScaffoldMessage {
  static void showSnackbar(BuildContext context, String message,backgroundColor,duration) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width/10,
            vertical: MediaQuery.of(context).size.height/10
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