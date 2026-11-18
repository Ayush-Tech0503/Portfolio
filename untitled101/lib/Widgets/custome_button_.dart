import 'package:flutter/material.dart';

Widget customeButton( {textStyleButton,onPressed,text,backgroundColor,borderRadius,minimumSize,elevation,textStyle,style}){
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      minimumSize:minimumSize,
      elevation:elevation,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
    ),
    child: Text(text, style: textStyleButton),
  );
}


Widget customeButton2( {textStyleButton,onPressed,text,backgroundColor,borderRadius,minimumSize,elevation,textStyle,style}){
  return
    MaterialButton(
      onPressed: onPressed,
      color: backgroundColor,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      minWidth: minimumSize.width,
      height: minimumSize.height,
      child: Text(text, style: textStyleButton),
    );
}

