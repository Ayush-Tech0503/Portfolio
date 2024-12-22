import 'package:citybazaronline_seller_app/Utils/Theme/constant_colors.dart';
import 'package:citybazaronline_seller_app/Widget/custome_text_widget.dart';
import 'package:flutter/material.dart';

import '../Utils/Constant Size /constant_sizes.dart';

Widget customTitleIconTextWidget({context,f1Text,f2Text, styleF1, styleF2, icon,iconColor, iconSize}){
  return  Row(
    // mainAxisAlignment: MainAxisAlignment.start,
    children: [
      customeText(text: f1Text??"", style: styleF1),
      constantWidth(context, 80.0),
      Icon(icon, color: iconColor ?? ConstantColor.primaryMainColor,size: iconSize ?? 20.0,),
      constantWidth(context, 80.0),
      Expanded(child: customeText(text: f2Text??"", style: styleF2)),
    ],
  );
}