import 'package:flutter/material.dart';
import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';
import '../custome_text_widget.dart';

Widget fixBoxTextIconWidget ({context, onTap, title,style, icon, iconColor}){
  var screenHeight = MediaQuery.of(context).size.height;
  var screenWidth = MediaQuery.of(context).size.width;
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: screenHeight/60.0,horizontal: screenWidth/40.0),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: ConstantColor.primaryMainColor ?? ConstantColor.transparent1,
            width: screenWidth / 100, // Set the border width dynamically
          ),
          right: const BorderSide(color: ConstantColor.textFieldColor),
          bottom: const BorderSide(color: ConstantColor.textFieldColor),
          top: const BorderSide(color: ConstantColor.textFieldColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: customeText(text: title ?? "", style: style ?? ConstantTextStyle.dropDownPrimeText),), // Ensure text can expand if needed
          Icon(icon,color: iconColor ?? ConstantColor.primaryMainColor,),
        ],
      ),
    ),
  );
}



Widget fixBoxTextIconWidget2 ({context, onTap, title,style, icon, iconColor,capacities}){
  var screenHeight = MediaQuery.of(context).size.height;
  var screenWidth = MediaQuery.of(context).size.width;
  return Padding(
    padding:  EdgeInsets.only(top: screenHeight/60.0),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(height: screenHeight/40.0),
          customeText(text: title,style: style),
          InkWell(
            onTap: onTap,
            child:Container(
              margin:  EdgeInsets.symmetric(vertical: screenHeight/80.0),
              padding: EdgeInsets.symmetric(vertical: screenHeight/60.0,horizontal: screenWidth/40.0),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: ConstantColor.primaryMainColor ?? ConstantColor.transparent1,
                    width: screenWidth / 100, // Set the border width dynamically
                  ),
                  right: const BorderSide(color: ConstantColor.textFieldColor),
                  bottom: const BorderSide(color: ConstantColor.textFieldColor),
                  top: const BorderSide(color: ConstantColor.textFieldColor),
                ),
              ),

              child: Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //Space between text and card widgets
                          ...capacities.map((capacity) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Card(
                              elevation: 2.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: customeText(
                                  text : capacity.trim(),
                                  style: ConstantTextStyle.dropDownPrimeText,
                                ),
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                  Icon(icon ?? Icons.keyboard_arrow_down_rounded,color:iconColor ?? ConstantColor.primaryMainColor,),
                ],
              ),
            ),
          ),
        ],
      ),
  );
}

