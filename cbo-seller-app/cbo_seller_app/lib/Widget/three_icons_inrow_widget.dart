// Function to create a TableCell with multiple IconButton widgets
import 'package:citybazaronline_seller_app/Utils/Theme/constant_colors.dart';
import 'package:flutter/material.dart';

Widget createIconButtonCell({
  required BuildContext context,
  required IconData icon1,
  required VoidCallback onPressed1,
  IconData? icon2,
  VoidCallback? onPressed2,
  IconData? icon3,
  VoidCallback? onPressed3,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center, // Adjust alignment as needed
    children: [
      if (icon1 != null)
        Expanded(
          child: boxIconWidget(
            context: context,
            onPressed: onPressed1,
            icon: icon1,
          ),
        ),
      if (icon2 != null)
      Expanded(
          child:  boxIconWidget(
            context: context,
            onPressed: onPressed2!,
            icon: icon2,
          ),
        ),
      if (icon3 != null)
        Expanded(
          child: boxIconWidget(
            context: context,
            onPressed: onPressed3!,
            icon: icon3,
          ),
        ),
    ],
  );
}



Widget boxIconWidget ({onPressed,icon,context }){
  var screenHeight = MediaQuery.of(context).size.height;
  var screenWidth = MediaQuery.of(context).size.width;
  return  GestureDetector( onTap: onPressed,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: screenHeight/100.0,horizontal: screenWidth/100.0),
      padding: EdgeInsets.symmetric(vertical: screenHeight/200.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: ConstantColor.calendarBGHeadColor,
      ),
      child: Icon(icon,size: 20.0,color: ConstantColor.primaryMainColor,),
    ),
  );
}