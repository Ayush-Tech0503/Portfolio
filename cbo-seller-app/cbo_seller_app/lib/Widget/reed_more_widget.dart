
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import '../Utils/Font Style/text_styles.dart';

Widget reedMoreText ({text}){
  return  ReadMoreText(text??"",
      style: ConstantTextStyle.cardbottumText,
      trimMode: TrimMode.Line,
      trimLines: 1,
      // colorClickableText: Colors.pink,

      trimCollapsedText: '\t\tShow more...',
      trimExpandedText: '\t\tShow less...',
      lessStyle: ConstantTextStyle.otpHintTextStyle,
      moreStyle:ConstantTextStyle.otpHintTextStyle
  );
}