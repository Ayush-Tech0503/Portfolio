import 'package:flutter/material.dart';
Widget curouselSliderDot ({shape,color,context,width = 8.0 ,}){
     return Container(
        width:  width,
        height: MediaQuery.of(context).size.height/30.0,
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(shape),
          shape:shape,
         color: color,
        ),
      );
}