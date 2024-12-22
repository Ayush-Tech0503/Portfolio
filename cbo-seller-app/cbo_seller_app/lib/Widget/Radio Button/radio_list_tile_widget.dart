import 'package:flutter/material.dart';

import '../../Utils/Theme/constant_colors.dart';

Widget customRadioButtonTitle ({groupValue,onChanged,title,value }){
  return RadioListTile(
    contentPadding: EdgeInsets.zero,
      visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
      activeColor: ConstantColor.primaryMainColor,
      dense: true,
    value: value ?? true,
    groupValue: groupValue,
    onChanged: onChanged,
    title: title
  );
}
