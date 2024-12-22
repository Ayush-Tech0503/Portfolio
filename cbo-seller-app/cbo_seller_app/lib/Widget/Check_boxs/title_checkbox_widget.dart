import 'package:flutter/material.dart';

Widget customeTitleCheckbox({
  title,
  checkColor,
  activeColor,
  value,
  onChanged} )
{
  return CheckboxListTile(
    title: title,
    value: value,
    onChanged: onChanged,
    controlAffinity: ListTileControlAffinity.leading,
  );
}

