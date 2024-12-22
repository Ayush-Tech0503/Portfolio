import 'package:flutter/material.dart';

Widget customRichText({
  text1 = '',
  text2 = '',
  text3 = '',
  text4 = '',
  style1,
  style2,
  style3,
  style4,
  overflow = TextOverflow.clip,
  textAlign} )
{
  return RichText(
      textAlign: textAlign,
      maxLines: 2,
        overflow: overflow,
      text: TextSpan(
        text: text1,
        style: style1,
        children: [
          TextSpan(text: text2, style: style2),
          TextSpan(text: text3, style: style3),
          TextSpan(text: text4, style: style4)
        ],
      ));
}