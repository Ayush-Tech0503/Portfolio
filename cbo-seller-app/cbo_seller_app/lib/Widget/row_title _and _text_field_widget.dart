// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../Utils/Font Style/text_styles.dart';
import 'custome_text_widget.dart';

Widget rowTitleAndFormWidget({title, required Widget formFieldWidget}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      customeText(text: title ?? "", style: ConstantTextStyle.colorsHeadingText),
      // constantWidth(context, 20.0),
      Flexible(child: formFieldWidget),
    ],
  );
}
