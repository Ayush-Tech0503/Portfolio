import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../Utils/Theme/constant_colors.dart';

Widget faqExpansionTile ({collapsedShapeBoarder, collapsedBackgroundColor, backgroundColor, onExpansionChanged, subTextContainerColor, subTextContainerBoarder,
  headText, headStyle,subText, subTextStyle}){
  return ExpansionTile(
    childrenPadding: const EdgeInsets.all(1.0),
    // tilePadding: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    collapsedShape: RoundedRectangleBorder(
      borderRadius: collapsedShapeBoarder,
    ),
    collapsedBackgroundColor: collapsedBackgroundColor,
    backgroundColor: backgroundColor,
    title: Text(headText, style: headStyle, textAlign: TextAlign.start),
    textColor: ConstantColor.primaryMainColor,
    iconColor: ConstantColor.primaryMainColor,
    onExpansionChanged: onExpansionChanged,
    children: [
      Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: subTextContainerColor,
          borderRadius: subTextContainerBoarder,
        ),
        child: Html(
          data: subText,
          style: {
            "body": Style(
                fontSize: FontSize(12.0),
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal
            ),
            "h1": Style(
                fontSize: FontSize(14.0),
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal
            ),
            "p": Style(
                fontSize: FontSize(14.0),
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal
            ),
            // Add more styles as needed
          },
        ),
      ),
    ],
  );
}