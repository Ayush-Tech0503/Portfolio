
import 'package:flutter/material.dart';
import '../Util/constant_color.dart';
import 'custome_text.dart';

Widget cards ({radius,icon,text,context,style,textAlign}) {
  var screeHeight = MediaQuery.of(context).size.height;
  var screeWidth = MediaQuery.of(context).size.width;
return Padding(
  padding: EdgeInsets.symmetric(horizontal: screeWidth/40, vertical: screeHeight/40),
  child:   Container(
    height: screeHeight/7, width: screeWidth/2.3,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFFE57149), Color(0x0ff19761)], // Replace these colors with your desired gradient
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: ConstantColor.carColor,
      ),
    ), child:  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        Container(
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topCenter, end: Alignment.bottomCenter,
                  colors: [Color(0xfffc8b44), Color(0xfff05d1d),],)),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: radius,
            child: Icon(icon,color: ConstantColor.primaryBackgroundMainColor,
            size: 30,),),),
        SizedBox(
          height: MediaQuery.of(context).size.height/80,),
        customeText(text: text, style: style, textAlign:textAlign,),             //text: text,
      ],
    ),
  ),
);
}

Widget gradientColors ({containerWidth,containerHeight,widget}){
  return Container(
    height: containerHeight,
    width: containerWidth,
    decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffee5816),
            Color(0xf6fc8b58),
          ],
        )
    ),
      child: widget,
  );

}


