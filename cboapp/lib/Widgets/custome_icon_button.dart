import 'package:flutter/material.dart';
import '../Util/constant_color.dart';
Widget customeIconButton({icon, color, onPressed}) {
  return IconButton(
    hoverColor: ConstantColor.calendarBGHeadColor,
    icon: icon,
    color: color,
    onPressed: onPressed,
  );
}
