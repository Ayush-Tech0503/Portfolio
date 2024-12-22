import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';

Widget buildTypeAheadWithLoaderForBrands({
  required BuildContext context,
  required bool isLoading,
  required TextEditingController controller,
  required FocusNode focusNode,
  required String hintText,
  required List<String> suggestions,
  required void Function(String) onSuggestionSelected,
  // Removing onTap here as it should not be used for updating brandValue
}) {
  return Skeletonizer(
    enabled: isLoading,
    child: Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: ConstantColor.primaryMainColor,
            width: MediaQuery.of(context).size.width / 100,
          ),
        ),
      ),
      child: TypeAheadFormField<String>(
        textFieldConfiguration: TextFieldConfiguration(
          focusNode: focusNode,
          controller: controller,
          style: ConstantTextStyle.dropDownPrimeText,
          decoration: InputDecoration(
            filled: true,
            fillColor: ConstantColor.primaryBackgroundMainColor,
            suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: ConstantColor.primaryMainColor),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: ConstantColor.primaryGreyColor, width: 0.5),
              borderRadius: BorderRadius.zero,
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: ConstantColor.primaryGreyColor, width: 0.5),
              borderRadius: BorderRadius.zero,
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: ConstantColor.textFieldColor),
              borderRadius: BorderRadius.zero,
            ),
            hintText: hintText,
            hintStyle: ConstantTextStyle.lableRadioText,
          ),
        ),
        suggestionsCallback: (pattern) async {
          return suggestions.where((brand) {
            return brand.toLowerCase().contains(pattern.toLowerCase());
          }).toList();
        },
        itemBuilder: (context, String brand) {
          return ListTile(
            title: Text(brand, style: ConstantTextStyle.dropDownPrimeText),
            dense: true,
            visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          );
        },
        onSuggestionSelected: onSuggestionSelected,
      ),
    ),
  );
}
