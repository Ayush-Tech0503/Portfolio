// ignore_for_file: prefer_typing_uninitialized_variables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';

class GlobalTextFormField extends StatefulWidget {
  final enabled;
  final keyboardType;
  final maxLines;
  final maxLength;
  final fillColor;
  final filled;
  final hintText;
  final labelText;
  final labelStyle;
  final hintStyle;
  final controller;
  final validator;
  final obscureText;
  final onChanged;
  final focusNode;
  final suffixIcon;
  final readOnly;
  final margin;
  final onTap;

  const GlobalTextFormField({super.key,
    required this.enabled,
    required this.keyboardType,
    this.maxLines,
    this.maxLength,
    this.obscureText,
    this.readOnly,
    this.fillColor,
    this.filled,
    this.hintText = 'Enter text',
    this.labelText,
    this.labelStyle,
    this.hintStyle,
    this.controller,
    this.validator,
    this.onChanged,
    this.suffixIcon,
    this.margin,
    this.focusNode, this.onTap,
  });

  @override
  _GlobalTextFormFieldState createState() => _GlobalTextFormFieldState();
}

class _GlobalTextFormFieldState extends State<GlobalTextFormField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return FocusScope(
      onFocusChange: (hasFocus) {
        setState(() {
          _isFocused = hasFocus;
        });
      },
      child: Container(
        margin: widget.margin,
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: _isFocused ? ConstantColor.primaryMainColor : ConstantColor.transparent1,
              width: MediaQuery.of(context).size.width/100,
            ),
          ),
        ),
        child: GestureDetector(
          onTap: widget.onTap,
          child: TextFormField(
            readOnly: widget.readOnly??false,
            maxLength: widget.maxLength,
            obscureText : widget.obscureText ?? false,
            controller: widget.controller,
            validator:widget.validator,
            onChanged: widget.onChanged,
            focusNode:widget.focusNode ,
            maxLines: widget.maxLines ?? 1,
            enabled: widget.enabled ?? true,
            keyboardType: widget.keyboardType,
            style: ConstantTextStyle.textFormFildStyle2,
            cursorColor: ConstantColor.primaryMainColor,
            // onEditingComplete: widget.onEditingComplete,
            decoration: InputDecoration(
              counterText: '',
              suffixIcon: widget.suffixIcon,
              //Icon(Icons.date_range_outlined,color: ConstantColor.landingScreenSubHaddingColor,),
              fillColor: widget.fillColor ?? ConstantColor.primaryBackgroundMainColor,
              filled: widget.filled,
              contentPadding: EdgeInsets.symmetric(horizontal: screenWidth/40.0),
              border: InputBorder.none,
              hintText: widget.hintText ??"Enter text",
              labelText: widget.labelText??"",
              hintStyle: widget.hintStyle,
              labelStyle: widget.labelStyle,
              disabledBorder: const OutlineInputBorder(borderSide: BorderSide(
                color: ConstantColor.primaryGreyColor, width: 0.5,),
                borderRadius: BorderRadius.zero,
              ),
              enabledBorder:  const OutlineInputBorder(
                  borderSide: BorderSide(color: ConstantColor.primaryGreyColor,width: 0.5),
                  borderRadius: BorderRadius.zero
              ),
              focusedBorder: const  OutlineInputBorder(
                borderSide: BorderSide(color: ConstantColor.primaryGreyColor,width: 0.5),
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
        ),
      ),
    );
  }
}