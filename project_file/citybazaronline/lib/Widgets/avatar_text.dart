import 'package:flutter/cupertino.dart';
Widget homeScreenAvatarText({text, style,textAlign,overFlow}){
  return   Text(text, style: style, textAlign:textAlign, overflow: TextOverflow.ellipsis, maxLines: 2,);
}