// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';

void showLoggingInDialog({required BuildContext context,title,backgroundColor}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: backgroundColor??ConstantColor.primaryBackgroundMainColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        content: Row(
          children: [
            const CircularProgressIndicator(
              color: ConstantColor.primaryMainColor,
            ),
            const SizedBox(width: 20),
            Text( title ??
              'Logging In...',
              style: ConstantTextStyle.allHomeScreenAvatarText,
            ),
          ],
        ),
      );
    },
  );
}