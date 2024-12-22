import 'package:flutter/material.dart';

import '../Utils/Theme/constant_colors.dart';

Widget dividerWidget ({height, color}){
  return  Divider(height: height??10.0,color: color ?? ConstantColor.calendarBGHeadColor);
}