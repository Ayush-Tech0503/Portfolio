import 'package:flutter/material.dart';
Widget headingWithIcon ({maxLine,textWidth,text,overflow,textStyle,icon,iconColor,iconSize,onTap}){
  return  Row(
    children: [
      SizedBox(
        width : textWidth,
        child: Text(text,
          maxLines: maxLine,
      textAlign: TextAlign.start,
          overflow: overflow,
          style: textStyle),
      ),
       GestureDetector(
         onTap: onTap,
         child: Icon( icon,
          color: iconColor,
          size: iconSize,
      ),
       ),
    ],
  );
}
///////

Widget headingTextWithIcon ({maxLine,text,overflow,textStyle,icon,iconColor,iconSize}){
  return  Row(
    children: [
      Icon( icon,
        color: iconColor,
        size: iconSize,
      ),
      Text(text,
          maxLines: maxLine,
          textAlign: TextAlign.start,
          overflow: overflow,
          style: textStyle),
    ],
  );
}


////////////////////////////

Widget iconAndText({onPressed,icons, iconsSize,iconsColor, iconText,iconTextStyle,overFlow  }){
  return ElevatedButton.icon(
    onPressed: onPressed,
    icon: Icon(
     icons,size: iconsSize, color: iconsColor,
    ),
    label: Text(
      iconText,
      overflow: overFlow,
      style: iconTextStyle,
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );
}