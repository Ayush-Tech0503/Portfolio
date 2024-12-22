import 'package:flutter/material.dart';

import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';

Widget loginFlagTextField(
    {controller,maxLength,
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
      hintText,onTap,
      suffixIcon,
      suffixIconColor,
      validator,
      maxLines,autofocus,
      labelStyle,
      labelText,
      icon,inputFormatters,
      minLines,
      obscureText,
      textInputAction,
      iconButton,prefix,
      keyboardType,
      context, suffix,focusNode,
      onFocusChange,
    }) {
  return
    Container(
      decoration: BoxDecoration(
        color: ConstantColor.primaryBackgroundMainColor,
        borderRadius: BorderRadius.circular(0.0),
        // border: Border.all(color: ConstantColor.primaryGreyColor),
        border: Border(
          left: BorderSide(
            color:  ConstantColor.primaryMainColor,
            width: MediaQuery.of(context).size.width/100,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 0.5,
            blurRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      // elevation: 2,

      child: Focus(
        onFocusChange: onFocusChange,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 8),
            const Text(  '🇮🇳 ',
              style: TextStyle(fontSize: 18,),),
            // SizedBox(width: 8),
            const Text('+91',
              style: TextStyle(
                fontWeight:FontWeight.w600,
                fontSize: 14,
                fontFamily: 'Montserrat',
                color: ConstantColor.loginWithOtpButtonColor,),),
            Flexible(
              child: TextFormField(
                textInputAction:textInputAction,
                //TextField
                onTap: onTap,
                inputFormatters: inputFormatters,
                maxLength:maxLength,
                autofocus: autofocus,
                enabled: enabled,
                // obscureText: obscureText,
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
                  counterText: "",
                  fillColor: fillColor,
                  filled: filled,
                  enabledBorder:  const OutlineInputBorder(
                    borderSide: BorderSide(color: ConstantColor.transparent1),
                    borderRadius: BorderRadius.all(Radius.circular(0.0)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: ConstantColor.transparent1, ),
                    borderRadius: BorderRadius.all(Radius.circular(0.0)),
                  ),
                  //   contentPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/40),
                  labelText: labelText,
                  labelStyle: labelStyle,
                  hintStyle: hintStyle,
                  hintText: hintText,
                  prefix: prefix,
                  isDense: true,
                  suffixIcon: suffixIcon,
                  prefixIcon: prefixIcon,
                  suffixIconColor: suffixIconColor,
                  icon:icon,

                ),
              ),
            ),
          ],
        ),
      ),
    );

}