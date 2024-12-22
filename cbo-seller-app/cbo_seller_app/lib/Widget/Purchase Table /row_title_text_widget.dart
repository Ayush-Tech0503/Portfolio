import 'package:flutter/material.dart';
import '../../Utils/Font Style/text_styles.dart';

Widget tablePlanBodyWidget ({titleText}){
  // var screenHeight = MediaQuery.of(context).size.height;
  // var screenWidth = MediaQuery.of(context).size.width;
  return  Padding(
    padding: const EdgeInsets.only(top: 10.0,bottom: 10.0, ),
    child: SizedBox(
        width: 120.0,
        child: Text(titleText ?? "", textAlign: TextAlign.start, style: ConstantTextStyle.allHomeScreenAvatarText)),
  );
}