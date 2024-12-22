import 'package:flutter/cupertino.dart';

Widget customeText({text, style,textAlign,overflow,maxLine}){
  return  Text(
      text, overflow:overflow, style: style, textAlign:textAlign,maxLines: maxLine,);
}