
import 'package:flutter/material.dart';

import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';

Widget dropDownForm({colorBorder,context,headText,menuMaxHeightFormField,focusNode, value,onChanged,items,hintText,icon,validator}){
  var screenWidth = MediaQuery.of(context).size.width;
  var screenHeight = MediaQuery.of(context).size.height;
  return  Container(
    // margin: margin,
    decoration: BoxDecoration(
      border: Border(
        left: BorderSide(
          color: colorBorder ?? ConstantColor.transparent1,
          width: screenWidth/100,
        ),
      ),
    ),
    child:

    DropdownButtonFormField<dynamic>(
      menuMaxHeight: menuMaxHeightFormField ?? screenHeight/2,
      isExpanded: true,
      elevation: 1,
      style: ConstantTextStyle.textFormFildStyle2,
      focusNode: focusNode,
      value: value,
      onChanged:onChanged,
      items: items,
      decoration:  InputDecoration(
        labelText: headText,
        // contentPadding: EdgeInsets.symmetric(horizontal: screenWidth/40.0),
        labelStyle: ConstantTextStyle.lableRadioText,
        isDense: true,
        filled: true,
        fillColor: ConstantColor.primaryBackgroundMainColor,
        hintText:  hintText,
        hintStyle: ConstantTextStyle.textFormFildStyle2,
        disabledBorder: const OutlineInputBorder(borderSide: BorderSide(
          color: ConstantColor.primaryGreyColor, width: 0.5,),
          borderRadius: BorderRadius.zero,
        ),
        enabledBorder:  const OutlineInputBorder(
          borderSide: BorderSide(color: ConstantColor.primaryGreyColor, width: 0.5,),
          borderRadius: BorderRadius.zero,
        ),
        focusedBorder:  const OutlineInputBorder(
          borderSide: BorderSide(
            color: ConstantColor.textFieldColor,
          ),
          borderRadius: BorderRadius.zero,
        ),
      ),
      icon: icon ?? const Icon(Icons.keyboard_arrow_down_rounded, color: ConstantColor.primaryMainColor),
      borderRadius: BorderRadius.circular(10.0),
      validator: validator,
      dropdownColor: ConstantColor.primaryBackgroundMainColor,
    ),
  );
}