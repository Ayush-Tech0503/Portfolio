import 'package:flutter/material.dart';

import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';
import '../custome_text_widget.dart';

Widget checkBoxTileWidget ({titleText ,value, onChanged}) {
  return CheckboxListTile(
    contentPadding: EdgeInsets.zero,
    dense: true,
    checkboxShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5)),
    activeColor: ConstantColor.filedContainerColor,
    checkColor: ConstantColor.primaryBackgroundMainColor,
    title: customeText(
      text:titleText,
      overflow: TextOverflow.ellipsis,
      style: ConstantTextStyle.allHomeScreenAvatarText,
    ),
    value: value,
    onChanged: onChanged,
    controlAffinity: ListTileControlAffinity.leading,
  );
}