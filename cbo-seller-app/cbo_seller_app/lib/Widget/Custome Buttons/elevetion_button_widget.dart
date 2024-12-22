import 'package:flutter/material.dart';

Widget customButton({
  onPressed,
  toolTipMessage,
  required String text,
  Color? backgroundColor,
  BorderRadius? borderRadius,
  Size? minimumSize,
  double? elevation,
  TextStyle? textStyleButton,
  ButtonStyle? style,
}) {
  return Tooltip(
    message: toolTipMessage ?? '',
    child: ElevatedButton(
      onPressed: onPressed,
      style: style ?? ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: minimumSize,
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8.0), // Default border radius
        ),
      ),
      child: Text(
        text,
        style: textStyleButton,
      ),
    ),
  );
}