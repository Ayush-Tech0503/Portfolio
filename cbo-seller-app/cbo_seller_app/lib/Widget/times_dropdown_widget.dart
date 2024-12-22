
import 'package:flutter/material.dart';
import '../Utils/Theme/constant_colors.dart';

Widget timeDropDownFormField({
  formFieldStyle,
  String? value,
  String? hint,
  Function(String?)? onChanged,
  List<String>? items,
  FocusNode? focusNode,
  required BuildContext context,
  Color? enabledBorderColor,
  Color? focusedBorderColor,
}) {
  List<DropdownMenuItem<String>> dropdownItems = [];

  if (items != null) {
    dropdownItems = items.map((String item) {
      return DropdownMenuItem<String>(
        value: item,
        child: Text(item),
      );
    }).toList();
  }

  return DropdownButtonFormField<String>(
    hint: hint != null ? Text(hint) : null,
    menuMaxHeight: 200,
    style: formFieldStyle,
    value: value,
    onChanged: onChanged,
    items: dropdownItems.isNotEmpty ? dropdownItems : null, // Handle null items
    focusNode: focusNode,
    decoration: InputDecoration(
      filled: true,
      fillColor: ConstantColor.primaryBackgroundMainColor,
      contentPadding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width / 40,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: enabledBorderColor ?? Colors.black,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: focusedBorderColor ?? Colors.blue,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    iconEnabledColor: ConstantColor.primaryMainColor,
    icon: const Icon(
      Icons.arrow_drop_down,
      color: ConstantColor.primaryMainColor,
    ),
    borderRadius: BorderRadius.circular(10.0),
    dropdownColor: ConstantColor.primaryBackgroundMainColor,
  );
}




