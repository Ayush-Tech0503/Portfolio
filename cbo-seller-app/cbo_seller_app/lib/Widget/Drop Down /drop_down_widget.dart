// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:citybazaronline_seller_app/Utils/Theme/constant_colors.dart';
import 'package:flutter/material.dart';

import '../../Utils/Font Style/text_styles.dart';

class AppDropdownInput extends StatefulWidget {
  final String hintText;
  final List<String> options;
  final margin;
  final validator;
  // final errorText;
  final String value;
  final void Function(String?) onChanged;
  final String Function(String) getLabel;

  const AppDropdownInput({
    Key? key,
    this.hintText = 'Please select an Option',
    this.options = const [],
    required this.getLabel,
    required this.value,
    required this.onChanged,
    this.margin,
    // this.errorText,
    this.validator,
  }) : super(key: key);

  @override
  State<AppDropdownInput> createState() => _AppDropdownInputState();
}

class _AppDropdownInputState extends State<AppDropdownInput> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return  FocusScope(
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
        child: FormField<String>(
            validator: widget.validator,
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
// errorText: widget.errorText??"",
                  // filled: false,
                contentPadding: EdgeInsets.symmetric(horizontal: screenWidth/40.0),
                labelText: widget.hintText,
                labelStyle: ConstantTextStyle.otpHintTextStyle,
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: ConstantColor.primaryGreyColor,width: 0.5),
                    borderRadius: BorderRadius.zero,),
                enabledBorder:  const OutlineInputBorder(
                    borderSide: BorderSide(color: ConstantColor.primaryGreyColor,width: 0.5),
                    borderRadius: BorderRadius.zero
                ),
                focusedBorder: const  OutlineInputBorder(
                  borderSide: BorderSide(color: ConstantColor.primaryGreyColor,width: 0.5),
                  borderRadius: BorderRadius.zero,
                ),
              ),
              isEmpty: widget.value == '',
              child:  DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    style: ConstantTextStyle.textFormFildStyle2,
                    value: widget.value,
                    isDense: true,
                    elevation: 1,
                    onChanged: widget.onChanged,
                    items: widget.options.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(widget.getLabel(value)),

                      );
                    }).toList(),
                    borderRadius: BorderRadius.circular(8.0),
                    dropdownColor: ConstantColor.primaryBackgroundMainColor,
                  ),
                ),
            );
          },
        ),
      ),
    );
  }
}

