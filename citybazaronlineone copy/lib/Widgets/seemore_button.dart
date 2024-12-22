import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget seeMoreButton ({text,color,widget,seeMoreButtonStyle,context, style}) {
 return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        padding: EdgeInsets.only(
         left: MediaQuery.of(context).size.width/20,
      ),
         child: Text (text,style:style,),
      ),

      widget,
    ],
  );
}

