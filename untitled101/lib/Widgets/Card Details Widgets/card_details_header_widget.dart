import 'package:flutter/material.dart';
import '../../Util/constant_color.dart';

Widget buildListItem({
  required IconData icon,
  required String title,
  String? subtitle,
  TextStyle? textStyle,
  TextStyle? subtitleStyle,
}) {
  // var screenH = MediaQuery.of(context).size.height;
  // var screenW = MediaQuery.of(context).size.width;
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(icon, color: ConstantColor.primaryMainColor),
      const SizedBox(width: 16.0),
      Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textStyle ?? const TextStyle(), // Use default style if not provided
            ),
            if (subtitle != null)
              Text(
                subtitle,
                style: subtitleStyle ?? const TextStyle(), // Use default style if not provided
              ),
          ],
        ),
      ),
    ],
  );
}