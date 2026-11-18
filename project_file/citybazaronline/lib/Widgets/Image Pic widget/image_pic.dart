

import 'package:flutter/material.dart';
import '../../Util/constant_color.dart';
import '../custome_button_.dart';

Widget filePickerWidget ({ context,widthBorderSide,heightContain,imageChild, textStyleButton,onPressedButton,buttonText ,boarderColor, }){
  var screenWidth = MediaQuery.of(context).size.width;
  return  Container(
    padding: EdgeInsets.symmetric(horizontal: screenWidth/100),
    decoration: const BoxDecoration(
      color: ConstantColor.primaryBackgroundMainColor,
      border: Border(
        left: BorderSide(
          color: ConstantColor.primaryMainColor,
          width: 0.5,
        ),
        right: BorderSide(
          color: ConstantColor.primaryMainColor,
          width: 0.5,
        ),
        top: BorderSide(
          color: ConstantColor.primaryMainColor,
          width: 0.5,
        ),    bottom: BorderSide(
          color: ConstantColor.primaryMainColor,
        width: 0.5,
        ),

      ),
    ),
    alignment: Alignment.center,
    width: double.infinity,
    height:heightContain,

    child: Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
     //   SizedBox(width: screenWidth/80,),
        Flexible(
          child: Card(
            elevation: 5,
            child: imageChild,
          ),
        ),
        SizedBox(width: screenWidth/100,),
        customeButton(
          textStyleButton: textStyleButton,
          onPressed: onPressedButton,
          text: buttonText,
          backgroundColor: ConstantColor.primaryMainColor,
          borderRadius: BorderRadius.circular(8.0),
          elevation: 3.0,
        ),

      ],
    ),
  );
}

//----------------------------------

