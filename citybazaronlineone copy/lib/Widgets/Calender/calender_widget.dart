import 'package:flutter/material.dart';
import '../../Util/constaint_textstyle.dart';
import '../../Util/constant_color.dart';
import '../Famous Market Widget/store_details_widget.dart';
Widget calanderForm ({controller, textFormPaddingVertical, textFormPaddingHorizontal,
  enabled,
  fillColor,
  filled,
  initialValue,
  borderSideColor,
  obscuringCharacter,
  prefixIcon,
  cursorColor,
  onChanged,
  hintStyle,
  hintText,
  suffixIcon,
  suffixIconColor,
  validator,
  maxLines,
  labelStyle,
  labelText,
  icon,
  helperText,
  minLines, readOnly,
  obscureText,
  iconButton,
  onSaved,suffixIconOnTap, suffixIconBGColor,suffixIconData,suffixIconSize, suffixIconDataColor,
  keyboardType,height,
  context, suffix,focusNode}) {
  var screenWidth = MediaQuery.of(context).size.width;
  var screenHeight = MediaQuery.of(context).size.width;
  return
    Container(
      //height:height,
      decoration: BoxDecoration(
        border: Border(
            left: BorderSide(
              color: borderSideColor,
              width: MediaQuery.of(context).size.width/100,
            ),

        ),
      ),
      child:
      TextFormField(
        readOnly: readOnly,
        onSaved: onSaved,
        minLines: minLines,
        maxLines: maxLines,
        enabled: enabled,
        initialValue: initialValue,
        style: ConstantTextStyle.textFormFildStyle2,
        controller: controller,
        validator:validator ,
        onChanged: onChanged,
        focusNode:focusNode ,
        cursorColor: cursorColor,
        keyboardType: keyboardType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          //  border: InputBorder.none,
            helperText: helperText,
            contentPadding:  EdgeInsets.symmetric(
              vertical: textFormPaddingVertical,
              horizontal: textFormPaddingHorizontal,
            ),
            fillColor: fillColor,
            filled: filled,
            enabledBorder:  const OutlineInputBorder(
              borderSide: BorderSide(color: ConstantColor.textFieldColor,),
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: ConstantColor.textFieldColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
            //contentPadding: EdgeInsets.zero,
            labelText: labelText,
            //  floatingLabelBehavior: FloatingLabelBehavior.,
            labelStyle: labelStyle,
            hintStyle: hintStyle,
            hintText: hintText,
            isDense: true,
            suffixIcon: Container(
              padding: EdgeInsets.only(right: screenWidth/30, top: screenHeight/50, bottom: screenHeight/50),
              child: boxIcon(
                borderRadius: BorderRadius.circular(5.0),
                bgcolor: suffixIconBGColor,
                icon: suffixIconData,
                iconsize: suffixIconSize,
                iconcolor: suffixIconDataColor,
                onTap: suffixIconOnTap,
              ),
            ),
            prefixIcon: prefixIcon,
            suffixIconColor: suffixIconColor,
            icon:icon,

        ),
      ),
    );

}