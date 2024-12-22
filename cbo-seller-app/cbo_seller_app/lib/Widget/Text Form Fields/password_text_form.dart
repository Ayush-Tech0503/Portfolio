// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';

Widget passwordTextFormField(
    {controller,
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
      minLines,
      obscureText,maxLength,
      iconButton,
      keyboardType,
      context, suffix,focusNode}) {
  return
    Container(
      height:MediaQuery.of(context).size.height/18,
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
        maxLength: maxLength,
        autofocus: true,
        enabled: enabled,
        obscureText: obscureText,
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
            borderSide: BorderSide(color: ConstantColor.textFieldColor),
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ConstantColor.textFieldColor, ),
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
          ),
          //   contentPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/40),
          labelText: labelText,
          labelStyle: labelStyle,
          hintStyle: hintStyle,
          hintText: hintText,

          isDense: true,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          suffixIconColor: suffixIconColor,
          icon:icon,

        ),
      ),
    );

}


Widget customTextFormField(
    {controller,
      maxLength,
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
      onFieldSubmitted,
      onTap,
      suffixIcon,
      suffixIconColor,
      validator,
      maxLines,
      autofocus,
      labelStyle,
      labelText,
      icon,
      inputFormatters,
      minLines,
      iconButton,
      keyboardType,
      autofillHints,
      context,
      suffix,
      focusNode,
      formBorderRadius,
      obscureText = false}) {
  return Container(
   height: MediaQuery.of(context).size.height / 18,
    decoration: BoxDecoration(
      border: Border(
        left: BorderSide(
          color: borderSideColor,
          width: MediaQuery.of(context).size.width / 100,
        ),
      ),
    ),
    child: TextFormField(
      onTap: onTap,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      autofocus: autofocus ?? false,
      enabled: enabled,
      obscureText: obscureText,
      initialValue: initialValue,
      style: ConstantTextStyle.textFormFildStyle2,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      focusNode: focusNode,
      cursorColor: cursorColor,
      keyboardType: keyboardType,
      autofillHints: autofillHints,
  onFieldSubmitted: onFieldSubmitted,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        counterText: "",
        fillColor: fillColor,
        filled: filled,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ConstantColor.textFieldColor),
          borderRadius: formBorderRadius ?? const BorderRadius.all(Radius.circular(0.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:  const BorderSide(color: ConstantColor.textFieldColor),
          borderRadius: formBorderRadius ??  const BorderRadius.all(Radius.circular(0.0)),
        ),
        // contentPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/40),
        labelText: labelText,
        labelStyle: labelStyle,
        hintStyle: hintStyle,
        hintText: hintText,
        prefix: prefixIcon,
        isDense: true,
        suffixIcon: suffixIcon,
        suffixIconColor: suffixIconColor,
        icon: icon,
      ),
    ),
  );
}




Widget loginTextFormField1(
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
      iconButton,prefix,
      keyboardType,
      autofillHints,
      context, suffix,focusNode}) {
  return
    Container(
      height:MediaQuery.of(context).size.height/18,
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
        onTap: onTap,
        inputFormatters: inputFormatters,
        maxLength:maxLength,
        autofocus: autofocus,
        enabled: enabled,
        style: ConstantTextStyle.textFormFildStyle2,
        controller: controller,
        validator:validator ,
        onChanged: onChanged,
        focusNode:focusNode ,
        cursorColor: cursorColor,
        keyboardType: keyboardType,
        autofillHints: autofillHints,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          counterText: "",
          fillColor: fillColor,
          filled: filled,
          enabledBorder:  const OutlineInputBorder(
            borderSide: BorderSide(color: ConstantColor.textFieldColor),
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ConstantColor.textFieldColor, ),
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
    );
}



