// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

Widget customRichText({TextAlign, text1, style1, text2, style2, text3, style3, text4, style4,overflow})
  {
  return RichText(
      textAlign: TextAlign,
        maxLines: 2,
   //   overflow: TextOverflow.ellipsis,
  text: TextSpan(
  text: text1,
    style: style1,
  children: <TextSpan>[
  TextSpan(text: text4, style: style4),
  TextSpan(text: text2, style: style2),
  TextSpan(text: text3, style: style3)
  ],
  ));
}

