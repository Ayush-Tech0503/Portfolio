import 'package:flutter/material.dart';
import '../Utils/Font Style/text_styles.dart';
import 'custome_text_widget.dart';

Widget  rowTwoTitleTextWidget ({title1, title2}){
return Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Flexible(child: customeText(text: title1??"", style: ConstantTextStyle.colorsHeadingText)),
customeText(text: title2??"",  style: ConstantTextStyle.cardbottumText),
],
);
}