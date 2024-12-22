import 'package:flutter/material.dart';

import '../Utils/Theme/constant_colors.dart';

Widget dotS ({width,height,margin,shape,color}){
  return Flexible(
    child: Container(
      width:width,
      height:height,
      margin:margin,
      decoration: BoxDecoration(
        //  borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: ConstantColor.primaryMainColor, width: 0.5),
        // shape:shape,
        color:color,
      ),
    ),
  );
}