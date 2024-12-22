import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import '../../Utils/Theme/constant_colors.dart';

Widget htmlEnhanceWidget ({controller,hintText,buttonBorderColor,buttonColor, buttonFillColor,
  buttonSelectedColor,buttonBorderRadius,dropdownElevation,toolbarType,decoration,otherOptionsHeight}){
  return HtmlEditor(
    controller: controller, //required
    htmlEditorOptions: HtmlEditorOptions(
      hint: hintText ?? "Type your full description",
    ),

    htmlToolbarOptions:  HtmlToolbarOptions(
      dropdownBackgroundColor: Colors.white,
        buttonBorderColor: buttonBorderColor ?? ConstantColor.primaryGreyColor,
        buttonColor: buttonColor ?? ConstantColor.loginWithOtpButtonColor,
        buttonFillColor: buttonFillColor ?? ConstantColor.calendarBGHeadColor,
        buttonSelectedColor: buttonSelectedColor ?? ConstantColor.primaryMainColor,
        buttonBorderRadius: buttonBorderRadius ?? BorderRadius.circular(8.0),
        dropdownElevation: dropdownElevation ?? 1,
        toolbarType: toolbarType ?? ToolbarType.nativeScrollable

    ),
    otherOptions:  OtherOptions(
        height: otherOptionsHeight ?? 200,
        decoration: decoration ?? BoxDecoration(
          border: Border.all(color: ConstantColor.primaryGreyColor),
          borderRadius: BorderRadius.circular(5.0),
          // color: ConstantColor.starRatingColor
        )
    ),

  );
}


