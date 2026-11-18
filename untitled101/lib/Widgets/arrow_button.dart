import 'package:flutter/material.dart';
Widget arrowButons({backgroundColor,icon,radius,color,onTap, iconSize}){
  return  GestureDetector(
        onTap:onTap,
    child: CircleAvatar(
    radius: radius,
    backgroundColor: backgroundColor,
    child: Icon(
      icon,color:color,  size: iconSize,
     ),
    ),
  );
}