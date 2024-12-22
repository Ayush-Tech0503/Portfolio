
import 'package:flutter/cupertino.dart';
import '../Utils/Font Style/text_styles.dart';
import '../Utils/Theme/constant_colors.dart';
import 'custome_text_widget.dart';

Widget radiobuttonContainer (
      {boarderColor, borderRadius, headText, headTextStyle, headTextPadding, radioButtonWidget,context}) {
  var screenW = MediaQuery.of(context).size.width;
  var screenH = MediaQuery.of(context).size.height;
    return  Container(margin: EdgeInsets.only(left: screenW/100),
      decoration: BoxDecoration(
        color: ConstantColor.primaryBackgroundMainColor,
        borderRadius: borderRadius ?? BorderRadius.zero,
        border: Border.all(color: ConstantColor.primaryGreyColor,width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:EdgeInsets.only(left:screenW / 40,top: screenH / 150),
            child: customeText(
              textAlign: TextAlign.start,
              text: headText,
              style:headTextStyle ?? ConstantTextStyle.lableRadioText,
            ),
          ),
          radioButtonWidget ?? Container(),
        ],
      ),
    );
}