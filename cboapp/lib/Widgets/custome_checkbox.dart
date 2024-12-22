import 'package:flutter/material.dart';

Widget customeCheckbox({checkColor,activeColor,value,onChanged} )
{
  return  Checkbox(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
  checkColor:checkColor,
  activeColor: activeColor,
 value: value,

onChanged: onChanged,
);
}

