import 'package:flutter/material.dart';
import '../../Util/constant_color.dart';

Widget reviewRatingWidget({text,style,starRatingWidget,context,backgroundImage, radius, left,top}){
  return ListTile(
      dense:false,
      contentPadding: EdgeInsets.only(left: left, right: 0.0,top: top,),
      shape: RoundedRectangleBorder( //<-- SEE HERE
        //  side: BorderSide(width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      leading: CircleAvatar(
        radius: radius,
        backgroundColor: const Color(0xff6ae792),
        backgroundImage: backgroundImage,
      ),
      title: Text(text, style:style,),
      trailing: starRatingWidget);
}
Widget boxIcon ({height ,width, bgcolor, iconsize,iconcolor, icon , onTap,borderRadius, }){
  return InkWell(
    onTap: onTap,
    child: Container(
        width:width,
      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: bgcolor,
      ),
      child: Icon(icon,
        size: iconsize,
        color: iconcolor,
      ),
    ),
  );
}

Widget progressIndicator ({width, height, borderRadius ,value,backgroundColor, valueColor}) {
  return ClipRRect(
        borderRadius: borderRadius,
        child: SizedBox(
          height: height,
          width: width,
          child: LinearProgressIndicator(
            value: value, // percent filled
            valueColor: valueColor,
            backgroundColor:ConstantColor.primaryBackgroundMainColor,
          ),
        ),
      );

}
