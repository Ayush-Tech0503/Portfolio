import 'package:flutter/material.dart';
import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';
import '../custome_text_widget.dart';

Widget titleWithChipWidget ({text = '',chipTitle = '',style,chipTextStyle,chipBackgroundColor, context}) {
  return Text.rich(  overflow: TextOverflow.ellipsis,
    TextSpan(
      children: [
        TextSpan(text: text,style: style),
        WidgetSpan(child: Container(
          decoration: BoxDecoration(color: chipBackgroundColor ?? ConstantColor.primaryMainColor,
              borderRadius: BorderRadius.circular(5.0)),
          child: customeText(text: "  $chipTitle  ",style: chipTextStyle ?? ConstantTextStyle.chipText),)
        ),
      ],
    ),
  );
}