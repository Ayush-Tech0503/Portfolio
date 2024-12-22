// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:citybazaronline_seller_app/Utils/Theme/constant_colors.dart';
import 'package:citybazaronline_seller_app/Widget/custome_text_widget.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../Models/Complete Order Model/cat_attribute_model.dart';
import '../../../../../Utils/Constant Size /constant_sizes.dart';
import '../../../../../Utils/Font Style/text_styles.dart';
import 'package:flutter/material.dart';
import '../../../../../Widget/Custome Buttons/elevetion_button_widget.dart';
import '../../../../../Widget/Pre Loaded Product Widgets/fixBox_title_icon.widget.dart';
import '../../../../../Widget/Scaffold Message/scaffold_message_widget.dart';
import '../../../../../Widget/Text Form Fields/global_text_form_field.dart';
import '../../../../../Widget/divider_widget.dart';

class MultiPageStep1stScreen extends StatefulWidget {
  final Function onNext;
  final List<CatAttributesData> catAttributesDataList;
 // final List<Map<String, dynamic>> selectSingleOption;
  const  MultiPageStep1stScreen({super.key, required this.catAttributesDataList, required this.onNext});

  @override
  State<MultiPageStep1stScreen> createState() => _MultiPageStep1stScreenState();
}

class _MultiPageStep1stScreenState extends State<MultiPageStep1stScreen> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  List<Map<String, String>> attributeDataList = [];
  List<Map<String, dynamic>> selectSingleOption = [];
  List<Map<String, dynamic>> selectMultipleOption = [];
  List<Map<String, dynamic>> selectColorsList = [];
  List<TextEditingController> textControllers = [];

  @override
  void initState() {
    super.initState();
    textControllers = List.generate(widget.catAttributesDataList!.length, (index) => TextEditingController(),);

    // Initialize text editing controllers for TextBox fields
  }

  @override
  void dispose() {
    // Clean up text editing controllers
    for (var controller in textControllers) {
      controller.dispose();
    }

    // Reset form state if it's available
    if (_formKey.currentState != null) {
      _formKey.currentState!.reset();
    }
    selectedValues = {};
    attributeDataList.clear();
    selectSingleOption.clear();
    selectMultipleOption.clear();
    super.dispose();
  }

  // @override
  // void dispose() {
  //   // Clean up text editing controllers
  //   for (var controller in textControllers) {controller.dispose();}
  //   _formKey.currentState!.reset();
  //   attributeDataList.clear();
  //   selectSingleOption.clear();
  //   selectMultipleOption.clear();
  //   // catAttributesDataList.clear();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Skeletonizer(
        enabled: isLoading,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...widget.catAttributesDataList.asMap().entries.map<Widget>((entry) {
                int index = entry.key;
                CatAttributesData attribute = entry.value;
                return buildFormField(attribute, index);
              }),
              constantHeight(context, 80.0),
              Align(
                alignment: Alignment.centerRight,
                child: customButton(
                  toolTipMessage: "next step 2.",
                  text: 'NEXT',
                  elevation: 1.0,
                  borderRadius: BorderRadius.circular(20.0),
                  backgroundColor: ConstantColor.primaryMainColor,
                  textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                  onPressed: () {
                    // Handle form submission
                    // handleFormSubmission(widget.catAttributesDataList[0]);
                    // validateErrorMessage();
                    handleFormSubmission();


                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Map<String, TextEditingController> controllers = {};
  Map<String, String?> selectedValues = {};
  bool lengthVar = false;

  Widget buildFormField(CatAttributesData attribute, int index) {
    Future<void> showMyDialog(BuildContext context, CatAttributesData attribute) async {
      final formKey = GlobalKey<FormState>();
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          var screenHeight = MediaQuery.of(context).size.height;
          var screenWidth = MediaQuery.of(context).size.width;
          return AlertDialog(
            elevation: 0.0,
            contentPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.symmetric(vertical: screenHeight / 60.0, horizontal: screenWidth / 30.0),
            backgroundColor: Colors.white,
            title: customeText(text: 'Select ${attribute.attributeName??""} *', style: ConstantTextStyle.cardbottumText),
            content: Container(
              padding: EdgeInsets.only(bottom: screenHeight / 5.0, left: screenWidth / 40.0, right: screenWidth / 40.0),
              child: Form(
                key: formKey,
                child: TypeAheadFormField<String>(
                  textFieldConfiguration: TextFieldConfiguration(
                    autofocus: true,
                    style: ConstantTextStyle.carouselSliderText,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: screenWidth / 40.0),
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
                      hintText: '${attribute.attributeName??"Select *"} * ',
                      labelStyle: ConstantTextStyle.lableRadioText,
                      hintStyle: ConstantTextStyle.lableRadioText,
                    ),
                  ),
                  suggestionsCallback: (pattern) async {
                    final suggestions = (attribute.attributeData ?? []).where((item) =>
                    item.text?.toLowerCase().contains(pattern.toLowerCase()) ?? false
                    ).map((item) => item.text ?? '').toList();

                    return suggestions;
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      dense: true,
                      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                      contentPadding: EdgeInsets.symmetric(horizontal: screenWidth / 40.0),
                      title: customeText(text: suggestion ?? '', style: ConstantTextStyle.dropDownPrimeText),
                      subtitle: dividerWidget(),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    setState(() {
                      // Find the selected item based on suggestion text
                      var selectedItem = (attribute.attributeData ?? []).firstWhere(
                              (item) => item.text == suggestion,
                          orElse: () => AttributeData(text: suggestion, optionId: -1)
                      );
                      // Create a map with attribute name and selected text
                      Map<String, dynamic> optionData = {
                        attribute.attributeName.toString(): selectedItem.text,
                      };
                      // Check if an option with the same attributeName already exists
                      bool optionExists = selectSingleOption.any((option) => option.containsKey(attribute.attributeName.toString()));
                      // If exists, update it; otherwise, add the new option
                      if (optionExists) {
                        selectSingleOption.removeWhere((option) => option.containsKey(attribute.attributeName.toString()));
                      }

                      selectSingleOption.add(optionData);

                      // Update the selected value for the attribute
                      selectedValues[attribute.attributeName.toString()] = selectedItem.text;
                      // _textEditingController.text = selectedValues[attribute.attributeName.toString()] ?? '';
                      //
                      // print('selectSingleOption-------${_textEditingController.text }');
                      // print('_selectedValue test-------${_selectedValue}');
                    });
                    Navigator.of(context).pop();
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter ${attribute.attributeName}';
                    }
                    return null;
                  },
                ),
              ),
            ),
          );

        },
      );
    }

    // Future<void> showMyDialog2(BuildContext context, CatAttributesData attribute) async {
    //   final formKey = GlobalKey<FormState>();
    //
    //   // Initialize selectedItems with the current state
    //   List<String> selectedItems = (selectMultipleOption
    //       .firstWhere(
    //         (element) => element.containsKey(attribute.attributeName),
    //     orElse: () => {attribute.attributeName.toString(): []},
    //   )[attribute.attributeName.toString()] ?? [])
    //       .cast<String>();
    //
    //   return showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       var screenHeight = MediaQuery.of(context).size.height;
    //       var screenWidth = MediaQuery.of(context).size.width;
    //
    //       return StatefulBuilder(
    //         builder: (context, setState) {
    //           return AlertDialog(
    //             elevation: 0.0,
    //             contentPadding: EdgeInsets.zero,
    //             titlePadding: EdgeInsets.symmetric(vertical: screenHeight / 60.0, horizontal: screenWidth / 30.0),
    //             backgroundColor: Colors.white,
    //             title: customeText(
    //               text: 'Select ${attribute.attributeName ?? ""} *',
    //               style: ConstantTextStyle.cardbottumText,
    //             ),
    //             content: Container(
    //               padding: EdgeInsets.only(bottom: screenHeight / 5.0, left: screenWidth / 40.0, right: screenWidth / 40.0),
    //               child: Form(
    //                 key: formKey,
    //                 child: TypeAheadFormField<String>(
    //                   textFieldConfiguration: TextFieldConfiguration(
    //                     autofocus: true,
    //                     style: ConstantTextStyle.carouselSliderText,
    //                     decoration: InputDecoration(
    //                       contentPadding: EdgeInsets.symmetric(horizontal: screenWidth / 40.0),
    //                       filled: true,
    //                       fillColor: ConstantColor.primaryBackgroundMainColor,
    //                       suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: ConstantColor.primaryMainColor),
    //                       disabledBorder: const OutlineInputBorder(
    //                         borderSide: BorderSide(color: ConstantColor.primaryGreyColor, width: 0.5),
    //                         borderRadius: BorderRadius.zero,
    //                       ),
    //                       enabledBorder: const OutlineInputBorder(
    //                         borderSide: BorderSide(color: ConstantColor.primaryGreyColor, width: 0.5),
    //                         borderRadius: BorderRadius.zero,
    //                       ),
    //                       focusedBorder: const OutlineInputBorder(
    //                         borderSide: BorderSide(color: ConstantColor.textFieldColor),
    //                         borderRadius: BorderRadius.zero,
    //                       ),
    //                       hintText: '${attribute.attributeName ?? "Select *"} *',
    //                       labelStyle: ConstantTextStyle.lableRadioText,
    //                       hintStyle: ConstantTextStyle.lableRadioText,
    //                     ),
    //                   ),
    //                   suggestionsCallback: (pattern) async {
    //                     final suggestions = (attribute.attributeData ?? []).where((item) =>
    //                     item.text?.toLowerCase().contains(pattern.toLowerCase()) ?? false
    //                     ).map((item) => item.text ?? '').toList();
    //                     return suggestions;
    //                   },
    //                   itemBuilder: (context, suggestion) {
    //                     final isSelected = selectedItems.contains(suggestion);
    //                     return ListTile(
    //                       dense: true,
    //                       // visualDensity: const VisualDensity(horizontal: 0, vertical: 0),
    //                       contentPadding: EdgeInsets.symmetric(horizontal: screenWidth / 40.0),
    //                       tileColor: isSelected ? ConstantColor.secondoryCardeColors : null, // Set background color
    //                       title: customeText(text: suggestion ?? '', style: ConstantTextStyle.dropDownPrimeText),
    //                       // subtitle: dividerWidget(),
    //                     );
    //                   },
    //                   onSuggestionSelected: (suggestion) {
    //                     setState(() {
    //                       final isSelected = selectedItems.contains(suggestion);
    //                       if (isSelected) {
    //                         selectedItems.remove(suggestion);
    //                       } else {
    //                         selectedItems.add(suggestion);
    //                       }
    //
    //                       // Update selectMultipleOption list
    //                       final existingEntryIndex = selectMultipleOption.indexWhere(
    //                             (element) => element.containsKey(attribute.attributeName),
    //                       );
    //
    //                       if (existingEntryIndex != -1) {
    //                         selectMultipleOption[existingEntryIndex] = {
    //                           attribute.attributeName.toString(): selectedItems,
    //                         };
    //                       } else {
    //                         selectMultipleOption.add({
    //                           attribute.attributeName.toString(): selectedItems,
    //                         });
    //                       }
    //
    //                       // Update selectedValues as needed
    //                       selectedValues[attribute.attributeName.toString()] = selectedItems.join(', ');
    //                     });
    //                   },
    //                   validator: (value) {
    //                     if (value == null || value.isEmpty) {
    //                       return 'Please enter ${attribute.attributeName}';
    //                     }
    //                     return null;
    //                   },
    //                 ),
    //               ),
    //             ),
    //           );
    //         },
    //       );
    //     },
    //   );
    // }
    Future<void> showMyDialog2(BuildContext context, CatAttributesData attribute) async {
      final formKey = GlobalKey<FormState>();

      // Initialize selectedItems with the current state
      List<String> selectedItems = (selectMultipleOption
          .firstWhere(
            (element) => element.containsKey(attribute.attributeName),
        orElse: () => {attribute.attributeName.toString(): []},
      )[attribute.attributeName.toString()] ?? [])
          .cast<String>();

      return showModalBottomSheet(
        context: context,
        elevation: 0.0,
        isScrollControlled: true, // Allows for dynamic height based on content
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              final mediaQuery = MediaQuery.of(context);
              final keyboardHeight = mediaQuery.viewInsets.bottom;

              return Padding(
                padding: EdgeInsets.only(
                  left: mediaQuery.size.width / 30.0,
                  right: mediaQuery.size.width / 30.0,
                  bottom: keyboardHeight/0.8, // Adjust bottom padding for keyboard
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Makes the column take only the needed space
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: mediaQuery.size.height / 60.0),
                        child: Text(
                          'Select ${attribute.attributeName ?? ""} *',
                          style: ConstantTextStyle.cardbottumText,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: mediaQuery.size.height / 5.0),
                        child: Form(
                          key: formKey,
                          child: TypeAheadFormField<String>(
                            textFieldConfiguration: TextFieldConfiguration(
                              autofocus: true,
                              style: ConstantTextStyle.carouselSliderText,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width / 40.0),
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
                                hintText: '${attribute.attributeName ?? "Select *"} *',
                                labelStyle: ConstantTextStyle.lableRadioText,
                                hintStyle: ConstantTextStyle.lableRadioText,
                              ),
                            ),
                            suggestionsCallback: (pattern) async {
                              final suggestions = (attribute.attributeData ?? []).where((item) =>
                              item.text?.toLowerCase().contains(pattern.toLowerCase()) ?? false
                              ).map((item) => item.text ?? '').toList();
                              return suggestions;
                            },
                            itemBuilder: (context, suggestion) {
                              final isSelected = selectedItems.contains(suggestion);
                              return ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width / 40.0),
                                tileColor: isSelected ? ConstantColor.secondoryCardeColors : null, // Set background color
                                title: customeText(text: suggestion ?? '', style: ConstantTextStyle.dropDownPrimeText),
                              );
                            },
                            onSuggestionSelected: (suggestion) {
                              setState(() {
                                final isSelected = selectedItems.contains(suggestion);
                                if (isSelected) {
                                  selectedItems.remove(suggestion);
                                } else {
                                  selectedItems.add(suggestion);
                                }

                                // Update selectMultipleOption list
                                final existingEntryIndex = selectMultipleOption.indexWhere(
                                      (element) => element.containsKey(attribute.attributeName),
                                );

                                if (existingEntryIndex != -1) {
                                  selectMultipleOption[existingEntryIndex] = {
                                    attribute.attributeName.toString(): selectedItems,
                                  };
                                } else {
                                  selectMultipleOption.add({
                                    attribute.attributeName.toString(): selectedItems,
                                  });
                                }

                                // Update selectedValues as needed
                                selectedValues[attribute.attributeName.toString()] = selectedItems.join(', ');
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter ${attribute.attributeName}';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    }


    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

//     if (attribute.isVariant == "1" && attribute.controlType == "Dropdown") {
//       String attributeName = '';
//       List<String> selectedValues = [];
// // Find the correct attributeName and selectedValues based on the current attribute
//       for (var entry in selectMultipleOption) {
//         String key = entry.keys.first;
//         if (key == attribute.attributeName) {
//           attributeName = key;
//           selectedValues = entry[key]?.whereType<String>().toList() ?? [];
//           break;
//         }
//       }
//
//       return Container(
//         decoration: BoxDecoration(
//           border: Border.all(color: ConstantColor.primaryGreyColor, width: 0.5),
//         ),
//         margin: EdgeInsets.symmetric(vertical: screenHeight/80.0),
//         child:
//
//         ExpansionTile(
//           tilePadding: EdgeInsets.symmetric(horizontal: screenWidth/30.0),
//           backgroundColor: ConstantColor.circleAvatar2,
//           collapsedBackgroundColor: ConstantColor.primaryBackgroundMainColor,
//           textColor: ConstantColor.primaryMainColor,
//           iconColor: ConstantColor.primaryMainColor,
//           title: customeText(text: '${attribute.attributeName ?? ""} * ', style: ConstantTextStyle.lableRadioText,),
//           subtitle: Container(
//             decoration: BoxDecoration(
//               color: ConstantColor.sellerBGColor,
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             padding: const EdgeInsets.all(5.0),
//             child: customeText(
//               text: selectedValues.join(", "),
//               style: ConstantTextStyle.topCategoryText2,
//             ),
//           ),
//           children: [
//             Container(
//               color: ConstantColor.primaryBackgroundMainColor,
//               height: screenHeight /3,
//               child: ListView.builder(
//                 itemCount: attribute.attributeData!.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   final filterCat = attribute.attributeData![index];
//                   var catValue = filterCat.value;
//
//                   return CheckboxListTile(
//                     dense: true,
//                     checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
//                     activeColor: ConstantColor.primaryMainColor,
//                     checkColor: ConstantColor.primaryBackgroundMainColor,
//                     title: customeText(
//                       text: catValue ?? "",
//                       style: ConstantTextStyle.textFormFildStyle2,
//                     ),
//                     value: selectedValues.contains(catValue),
//                     onChanged: (bool? newValue) {
//                       setState(() {
//                         filterCat.isSelected = newValue;
//                         // Update selectMultipleOption list based on checkbox state
//                         if (newValue == true) {
//                           // Add the selected value to the list for the current attribute
//                           var existingIndex = selectMultipleOption.indexWhere(
//                                 (element) => element.containsKey(attribute.attributeName),
//                           );
//                           if (existingIndex != -1) {
//                             // Attribute already exists in the list, update its values
//                             selectMultipleOption[existingIndex][attribute.attributeName]!
//                                 .add(catValue);
//                           } else {
//                             // Attribute does not exist in the list, add a new entry
//                             selectMultipleOption.add({
//                               attribute.attributeName.toString(): [catValue]
//                             });
//                           }
//                         } else {
//                           // Remove the unselected value from the list for the current attribute
//                           var existingIndex = selectMultipleOption.indexWhere(
//                                 (element) => element.containsKey(attribute.attributeName),
//                           );
//                           if (existingIndex != -1) {
//                             selectMultipleOption[existingIndex][attribute.attributeName]!
//                                 .remove(catValue);
//                             // If the attribute list becomes empty, remove the map
//                             if (selectMultipleOption[existingIndex][attribute.attributeName]!
//                                 .isEmpty) {
//                               selectMultipleOption.removeAt(existingIndex);
//                             }
//                           }
//                         }
//                       });
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       );
//     }

    if (attribute.isVariant == "1" && attribute.controlType == "Dropdown") {
      final capacities = selectedValues[attribute.attributeName]?.split(',') ?? [];
      return fixBoxTextIconWidget2(
          context: context,
          onTap: () => showMyDialog2(context,attribute),
          title: '${attribute.attributeName??""} *',
          style: ConstantTextStyle.cardbottumText,
          capacities : capacities
    );

    // fixBoxTextIconWidget (
        //     context: context,
        //     onTap: () =>
        //     //     showDialog(
        //     //   context: context,
        //     //   builder: (BuildContext context) {
        //     //     return AttributeSelectionDialog(attribute: attribute);
        //     //   },
        //     // ),
        //         showMyDialog2(context,attribute),
        //     // title: (selectedValues[attribute.attributeName] as List<String>? ?? []).join(', '),
        //     title: selectedValues[attribute.attributeName] ?? "${attribute.attributeName} *",
        //     icon: Icons.keyboard_arrow_down_rounded
        // ),
      // );
    }

    else if (attribute.isVariant == "0" && attribute.controlType == "Dropdown") {
      return Padding(
        padding:  EdgeInsets.symmetric(vertical: screenHeight/80.0),
        child: fixBoxTextIconWidget (
              context: context,
              onTap: () => showMyDialog(context,attribute),
              title: selectedValues[attribute.attributeName] ?? "${attribute.attributeName} *",
              icon: Icons.keyboard_arrow_down_rounded
          ),
      );


          // if(_showErrorMessage == true)
          //   Align(
          //       alignment: Alignment.centerRight,
          //       child: validateErrorMessage(attribute.attributeName),
          //       // customeText(text: "no data", style: ConstantTextStyle.dropDownPrimeText)
          //   ),
      //   ],
      // );

      //   GestureDetector(
      //   onTap: (){
      //     showMyDialog(context,attribute);
      //   },
      //   child: Container(
      //     margin: EdgeInsets.symmetric(vertical: 30.0),
      //     color: ConstantColor.primaryMainColor,
      //     height: 20,width: 200,
      //   ),
      // );



        // Padding(
        //   padding: EdgeInsets.symmetric(vertical: 8.0),
        //   child: TypeAheadFormField<String>(
        //     textFieldConfiguration: TextFieldConfiguration(
        //       decoration: InputDecoration(
        //         border: OutlineInputBorder(),
        //         labelText: '${attribute.attributeName ?? ""} *',
        //       ),
        //     ),
        //     suggestionsCallback: (pattern) async {
        //       final suggestions = (attribute.attributeData ?? []).where((item) =>
        //       item.text?.toLowerCase().contains(pattern.toLowerCase()) ?? false
        //       ).map((item) => item.text ?? '').toList();
        //
        //       return suggestions;
        //     },
        //     itemBuilder: (context, suggestion) {
        //       return ListTile(
        //         title: Text(suggestion),
        //       );
        //     },
        //     onSuggestionSelected: (suggestion) {
        //       setState(() {
        //         // Find the selected item based on suggestion text
        //         var selectedItem = (attribute.attributeData ?? []).firstWhere(
        //                 (item) => item.text == suggestion,
        //             orElse: () => AttributeData(text: suggestion, optionId: -1) // Handle if no match is found
        //         );
        //         // Create a map with attribute name and selected text
        //         Map<String, dynamic> optionData = {
        //           attribute.attributeName.toString(): selectedItem.text,
        //         };
        //         // Check if an option with the same attributeName already exists
        //         bool optionExists = selectSingleOption.any((option) => option.containsKey(attribute.attributeName.toString()));
        //         // If exists, update it; otherwise, add the new option
        //         if (optionExists) {
        //           selectSingleOption.removeWhere((option) => option.containsKey(attribute.attributeName.toString()));
        //         }
        //
        //         // Add the new option to the list
        //         selectSingleOption.add(optionData);
        //       });
        //     },
        //     validator: (value) {
        //       if (value == null || value.isEmpty) {
        //         return 'Please enter ${attribute.attributeName}';
        //       }
        //       return null;
        //     },
        //   ),
        // );

      //   Padding(
      //   padding: EdgeInsets.symmetric(vertical: screenHeight/80.0),
      //   child:dropDownForm(
      //     // icon: const Icon(Icons.arrow_drop_down),
      //     menuMaxHeightFormField: 300.0,
      //     context: context,
      //     colorBorder: ConstantColor.primaryMainColor,
      //     headText: '${attribute.attributeName??""} * ',
      //     value: null,
      //     items: (attribute.attributeData ?? []).map<DropdownMenuItem<String>>((item) =>
      //         DropdownMenuItem<String>(
      //           value: item.optionId.toString(),
      //           child: Text(item.text ?? ''),
      //         ),
      //     ).toList(),
      //     onChanged: (newValue) {
      //       setState(() {
      //         // Find the selected item by newValue
      //         var selectedItem = (attribute.attributeData ?? []).firstWhere((item) => item.optionId.toString() == newValue,);
      //         // Check if selectedItem is not null before accessing its properties
      //         if (selectedItem != null) {
      //           // Create a map with attribute name and selected text
      //           Map<String, dynamic> optionData = {
      //             attribute.attributeName.toString(): selectedItem.text,
      //           };
      //           // Check if an option with the same attributeName already exists
      //           bool optionExists = selectSingleOption.any((option) => option.containsKey(attribute.attributeName.toString()));
      //           // If exists, update it; otherwise, add the new option
      //           if (optionExists) {
      //             selectSingleOption.removeWhere((option) => option.containsKey(attribute.attributeName.toString()));
      //           }
      //
      //           // Add the new option to the list
      //           selectSingleOption.add(optionData);
      //         } else {
      //           // Optionally handle the case where no item matches newValue
      //         }
      //       });
      //     },
      //     validator: (value) {
      //       if (value == null || value.isEmpty) {
      //         return 'Please enter ${attribute.attributeName}';
      //       }
      //       return null;
      //     },
      //   ),
      // );
    }

    else if (attribute.isVariant == "0" && attribute.controlType == "Textbox") {
      // TextFormField for text input
      return GlobalTextFormField(
        margin: EdgeInsets.symmetric(vertical: screenHeight/80.0),
        enabled: true,
        keyboardType: TextInputType.text,
        controller: textControllers[index], // Use the controller for this field
        hintText: "",
        labelText: "${attribute.attributeName ?? ""} * ",
        hintStyle: ConstantTextStyle.otpHintTextStyle,
        labelStyle: ConstantTextStyle.lableRadioText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter ${attribute.attributeName}';
          }
          return null;
        },
      );
    }
    else {
      // Default case or unsupported control type
      return Container(
        margin: EdgeInsets.symmetric(vertical: screenHeight/80.0),
        color: Colors.red,
        alignment: Alignment.center,
        child: const Text('Unsupported control type'),
      );
    }
  }

   validateErrorMessage(att) {
    LoadingScaffoldMessage.showSnackbar(
      context,
      "Please fill all required fields : $att",
      ConstantColor.primaryMainColor,
      const Duration(seconds: 2),
    );
  }

  Future<void> handleFormSubmission() async {
    if (!_formKey.currentState!.validate()) {
      return; // Return if form is not valid
    }

    bool allFieldsFilled = true;

    // Loop through each attribute and its corresponding text controller
    for (int i = 0; i < widget.catAttributesDataList.length; i++) {
      String attributeName = widget.catAttributesDataList[i].attributeName ?? '';
      String attributeValue = textControllers[i].text.trim();

      if (attributeValue.isEmpty) {
        // Skip empty attribute values
        continue;
      }

      // Check if attributeName already exists in attributeDataList
      bool found = false;
      for (int j = 0; j < attributeDataList.length; j++) {
        var entry = attributeDataList[j];
        if (entry.containsKey(attributeName)) {
          // Update the existing entry with the new value
          attributeDataList[j] = {attributeName: attributeValue};
          found = true;
          break;
        }
      }

      if (!found) {
        // Add the new pair to attributeDataList if attributeName doesn't already exist
        attributeDataList.add({attributeName: attributeValue});
      }
    }

    // Check for missing dropdown selections
    for (var attribute in widget.catAttributesDataList) {
      String attributeName = attribute.attributeName ?? '';
      String? selectedValue = selectedValues[attributeName];

      if (attribute.isVariant == "0" && attribute.controlType == "Dropdown") {
        if (selectedValue == null || selectedValue.isEmpty) {
          allFieldsFilled = false;
          validateErrorMessage(attribute.attributeName);
          // Optionally, you can set an error message or handle the case where dropdown is not selected
        }
      } else if (attribute.isVariant == "1" && attribute.controlType == "Dropdown") {
        if (selectedValue == null || selectedValue.isEmpty) {
          allFieldsFilled = false;
          validateErrorMessage(attribute.attributeName);
          // Optionally, you can set an error message or handle the case where dropdown is not selected
        }
      }
    }

    // attribute.isVariant == "1" && attribute.controlType == "Dropdown"


    if (!allFieldsFilled) {
      return;
    }

    // Save data to SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('attributeDataList', jsonEncode(attributeDataList));
    await prefs.setString('selectSingleOption', jsonEncode(selectSingleOption));
    await prefs.setString('selectMultipleOption', jsonEncode(selectMultipleOption));

    // Debug prints
    // debugPrint("attributeDataList:------ $attributeDataList");
    // debugPrint("selectSingleOption:------- $selectSingleOption");
    // debugPrint("selectMultipleOption:------- $selectMultipleOption");

    widget.onNext();
  }
}



