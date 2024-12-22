// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'dart:convert';
import 'package:citybazaronline_seller_app/Utils/Theme/constant_colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../Services/Multi Page Form Submition /multi_page_form_submition.dart';
import '../../../../../Utils/Constant Api Routs/constant_api_routs.dart';
import '../../../../../Utils/Font Style/text_styles.dart';
import '../../../../../Widget/Check_boxs/check_box_widget.dart';
import '../../../../../Widget/Custome Buttons/elevetion_button_widget.dart';
import '../../../../../Widget/Date Pickers/pre_loaded_date_pic_widget.dart';
import '../../../../../Widget/Radio Button/radio_list_tile_widget.dart';
import '../../../../../Widget/Scaffold Message/scaffold_message_widget.dart';
import '../../../../../Widget/Text Form Fields/global_text_form_field.dart';
import '../../../../../Widget/custome_text_widget.dart';

class MultiPageStep4thScreen extends StatefulWidget {
  List<Map<String, dynamic>>  selectMultipleOptionData;
  final selectSingleOptionData;
  final attributeDataListData;
  final productImageListData;
  final onPreview;
  final catName;
  final categoryId;
  String? productName;
  String? brandName;
  String? statusActive;
  String? warranty;
  String? shortDescription;
  String? fullDescription;
  String? otherFeatures;

  MultiPageStep4thScreen({super.key,
     required this.selectMultipleOptionData,
     this.onPreview,
     this.attributeDataListData,
     this.selectSingleOptionData,
     this.productImageListData,
     this.catName,
     this.categoryId,
     this.productName,
     this.brandName,
     this.statusActive,
     this.warranty,
     this.shortDescription,
     this.fullDescription,
     this.otherFeatures,
   });

  @override
  State<MultiPageStep4thScreen> createState() => _MultiPageStep4thScreenState();
}

class _MultiPageStep4thScreenState extends State<MultiPageStep4thScreen> {

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> combinations = [];
    void generateCombinations(int index, Map<String, dynamic> currentCombination) {
      if (index == widget.selectMultipleOptionData.length) {
        // If reached the end of the array, add the combination
        combinations.add({
          ...currentCombination,
          "model_name": "",
          "stock_status": "1",
          "quantity": "",
          "price": "",
          "offer_price": "",
          "offer_start_date": "",
          "offer_end_date": ""
        });
        return;
      }

      var selectedObj = widget.selectMultipleOptionData[index];
      var attributeName = selectedObj.keys.first;
      var attributeValues = selectedObj.values.first;

      // Iterate through values of the current attribute
      for (var attributeValue in attributeValues) {
        // Add the current attribute and value to the combination
        currentCombination[attributeName] = attributeValue;
        // Recursively move to the next attribute
        generateCombinations(index + 1, Map.from(currentCombination));
        // Remove the current attribute to backtrack for the next iteration
        currentCombination.remove(attributeName);
      }
    }

    // Start generating combinations from the first attribute
    generateCombinations(0, {});

    return OptionsList(
      combinations: combinations,
      selectSingleOptionData: widget.selectSingleOptionData,
      attributeDataListData: widget.attributeDataListData,
      productImageListData: widget.productImageListData,
      onPreview: widget.onPreview,
      categoryName: widget.catName,
      categoryId: widget.categoryId,
      productName: widget.productName,
      brandName: widget.brandName,
      statusActive: widget.statusActive,
      warranty: widget.warranty,
      shortDescription: widget.shortDescription,
      fullDescription: widget.fullDescription,
      otherFeatures: widget.otherFeatures,
    );
  }
}

class OptionsList extends StatefulWidget {
  final List<Map<String, dynamic>> combinations;
  final onPreview;
  final categoryName;
  final categoryId;
  final selectSingleOptionData;
  final attributeDataListData;
  final productImageListData;
  String? productName;
  String? brandName;
  String? statusActive;
  String? warranty;
  String? shortDescription;
  String? fullDescription;
  String? otherFeatures;
   OptionsList({super.key,
    required this.combinations,
    required this.selectSingleOptionData,
    required this.attributeDataListData,
    this.productImageListData,
    this.onPreview,
    this.categoryName,
    this.categoryId,
    this.productName,
    this.brandName,
    this.statusActive,
    this.warranty,
    this.shortDescription,
    this.fullDescription,
    this.otherFeatures,
  });

  @override
  State<OptionsList> createState() => _OptionsListState();
}

class _OptionsListState extends State<OptionsList> {
  // Controllers for form fields
  late List<TextEditingController> modalNameControllers;
  late List<TextEditingController> quantityControllers;
  late List<TextEditingController> priceControllers;
  late List<TextEditingController> offerPriceControllers;
  late List<TextEditingController> startDateControllers;
  late List<TextEditingController> endDateControllers;
  late List<String> selectedOption;
  dynamic formattedString;


  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Initialize controllers for each combination
    initializeControllers();
  }

  @override
  void dispose() {
    // Dispose all controllers when the widget is disposed
    for (var controller in modalNameControllers) {controller.dispose();}
    for (var controller in quantityControllers) {controller.dispose();}
    for (var controller in priceControllers) {controller.dispose();}
    for (var controller in offerPriceControllers) {controller.dispose();}
    for (var controller in startDateControllers) {controller.dispose();}
    for (var controller in endDateControllers) {controller.dispose();}

    _scrollController.dispose();
    variantData.clear();
    super.dispose();
  }

  List<Map<String, dynamic>> variantData = [];

  void handleSubmit() {
    bool isValid = _formKey.currentState!.validate();

    if (isValid) {
      bool hasEmptyField = false;
      bool priceErrorShown = false;
      List<String> emptyFields = [];
      List<Map<String, dynamic>> updatedVariantData = []; // Use a new list to store updated data

      for (int i = 0; i < widget.combinations.length; i++) {
        var combination = widget.combinations[i];

        // Fetch current values from form widgets
        String modelName = modalNameControllers[i].text.trim();
        String selectedStatus = selectedOption[i].trim();
        String quantity = quantityControllers[i].text.trim();
        String price = priceControllers[i].text.trim();
        String offerPrice = offerPriceControllers[i].text.trim();
        String startDate = startDateControllers[i].text.trim();
        String endDate = endDateControllers[i].text.trim();

        // Check if any field is empty
        if (modelName.isEmpty || selectedStatus.isEmpty || quantity.isEmpty || price.isEmpty) {
          String formattedString = combination.entries.map((entry) => '${entry.key}: ${entry.value}').join(', ');
          emptyFields.add('$formattedString : One or more fields are empty');
          hasEmptyField = true;
        }

        // Convert price and offerPrice to numerical types (double)
        double parsedPrice = double.tryParse(price ?? "0") ?? 0.0;
        double parsedOfferPrice = double.tryParse(offerPrice ?? "0") ?? 0.0;

        // Check if offerPrice is greater than price
        if (parsedOfferPrice > parsedPrice && !priceErrorShown) {
          LoadingScaffoldMessage.showSnackbar(
            context,
            "Offer price cannot be greater than regular price.",
            ConstantColor.primaryMainColor,
            const Duration(seconds: 2),
          );
          priceErrorShown = true; // Set flag to true after showing the error message
          continue; // Skip this product and continue with the next one
        }

        // Add valid data to updatedVariantData
        var formattedString = combination.entries.where((entry) => ![
          "model_name", "offer_end_date", "offer_price", "offer_start_date", "price", "quantity", "stock_status"
        ].contains(entry.key)).map((entry) => '${entry.key}: ${entry.value}').join(', ');
        var formattedStringMap = parseFormattedString(formattedString);
        var variant = {
          ...formattedStringMap,
          "model_name": modelName,
          "stock_status": selectedStatus,
          "quantity": quantity,
          "price": price,
          "offer_price": offerPrice,
          "offer_start_date": startDate,
          "offer_end_date": endDate,
        };

        updatedVariantData.add(variant);
      }

      if (!hasEmptyField && !priceErrorShown) {
        // Proceed with submission or further processing
        setState(() {
          variantData = updatedVariantData; // Update the state variable with updated data
        });

        String variantDataJson = jsonEncode(variantData);
        FormData formData = FormData();
        formData.fields.addAll([
          MapEntry("prod_category", widget.categoryName),
          MapEntry("prod_cat_id", widget.categoryId),
          MapEntry("product_name", widget.productName??""),
          MapEntry("brand_name", widget.brandName??""),
          MapEntry("product_status", widget.statusActive??""),
          MapEntry("warranty", widget.warranty??""),
          MapEntry("short_description", widget.shortDescription??""),
          MapEntry("full_description", widget.fullDescription??""),
          MapEntry("other_feature", widget.otherFeatures??""),
          MapEntry("product_img", widget.productImageListData.join(",")),
          MapEntry("variant_data", variantDataJson),
          // Adding entries from attributeDataListData
          ...widget.attributeDataListData.map((item) {
            String key = item.keys.first;
            dynamic value = item.values.first;
            return MapEntry(key, value.toString());
          }),
          // Adding entries from attributeDataListData
          ...widget.selectSingleOptionData.map((item) {
            String key = item.keys.first;
            dynamic value = item.values.first;
            return MapEntry(key, value.toString());
          }),
          const MapEntry("pid", '0'),
          const MapEntry("act", 'add')
        ]);
        fetchMultiPageFormSubmitFormData(
            context: context,
            formData: formData,
            baseUrl: "${ConstantUrls.baseUriApi}${ConstantUrls.addCustomMultiPageProductsEndpoint}",
            onSuccess: () => Navigator.pushNamed(context, '/uploadedProductScreen')
        );
      } else {
        // Show error message with empty fields
        String errorMessage = 'Fields are required :\n ${emptyFields.join(",\n ")}';
        LoadingScaffoldMessage.showSnackbar(
          context,
          errorMessage,
          ConstantColor.primaryMainColor,
          const Duration(seconds: 3),
        );
      }
    }
  }


  Map<String, dynamic> parseFormattedString(String formattedString) {
    Map<String, dynamic> resultMap = {};

    List<String> pairs = formattedString.split(', ');

    for (String pair in pairs) {
      List<String> keyValue = pair.split(': ');
      String key = keyValue[0].trim();
      String value = keyValue[1].trim();
      resultMap[key] = value;
    }

    return resultMap;
  }

  bool isChecked = false;



  // Initialize controllers and selectedOption based on widget.combinations length
  void initializeControllers() {
    modalNameControllers = List.generate(widget.combinations.length, (index) => TextEditingController());
    quantityControllers = List.generate(widget.combinations.length, (index) => TextEditingController());
    priceControllers = List.generate(widget.combinations.length, (index) => TextEditingController());
    offerPriceControllers = List.generate(widget.combinations.length, (index) => TextEditingController());
    startDateControllers = List.generate(widget.combinations.length, (index) => TextEditingController());
    endDateControllers = List.generate(widget.combinations.length, (index) => TextEditingController());
    selectedOption = List.generate(widget.combinations.length, (index) => "1"); // Assuming "In Stock" as default
  }

  // Method to populate form fields with data from a specific combination
  void populateFormFields() {
    for (int i = 0; i < widget.combinations.length; i++) {
      modalNameControllers[i].text = modalNameControllers[0].text.trim();
      selectedOption[i] = selectedOption[0];
      quantityControllers[i].text = quantityControllers[0].text.trim();
      priceControllers[i].text = priceControllers[0].text.trim();
      offerPriceControllers[i].text = offerPriceControllers[0].text.trim();
      startDateControllers[i].text = startDateControllers[0].text.trim();
      endDateControllers[i].text = endDateControllers[0].text.trim();
    }
  }


  void clearFormFields() {
    for (int i = 1; i < widget.combinations.length; i++) {
      modalNameControllers[i].clear();
      quantityControllers[i].clear();
      priceControllers[i].clear();
      offerPriceControllers[i].clear();
      startDateControllers[i].clear();
      endDateControllers[i].clear();
      // Reset selected option to default "1"
      selectedOption[i] = "1";
    }
    setState(() {
      // Update the state if needed
    });
  }



  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            ListView.builder(
              controller: _scrollController,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.combinations.length,
              itemBuilder: (BuildContext context, int index) {
                var combination = widget.combinations[index];
                dynamic attributeName = combination;
                attributeName.removeWhere((key, value) => ["model_name", "offer_end_date", "offer_price", "offer_start_date", "price", "quantity", "stock_status"].contains(key));
                formattedString = attributeName.entries.map((entry) => ('${entry.key}: ${entry.value}')).join(', ');
                // Prepare lists for keys and values
                // List<String> keys = [];
                // List<String> values = [];
                // attributeName.entries.forEach((entry) {
                //   keys.add(entry.key);
                //   values.add(entry.value.toString());
                // });

                return Container(
                  decoration: BoxDecoration(
                    color: ConstantColor.primaryBackgroundMainColor,
                    boxShadow:const [
                      BoxShadow(
                        color: ConstantColor.primaryGreyColor,
                        spreadRadius: 1,
                        blurRadius: 0.5,
                        offset:  Offset(2, 2),
                      )
                    ],
                    border: Border.all(color: ConstantColor.textFieldColor),
                  ),
                  margin: EdgeInsets.symmetric(vertical: screenHeight / 100.0),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth / 30.0),

                  child:
                  ExpansionTile(
                      childrenPadding: EdgeInsets.zero,
                      tilePadding: EdgeInsets.zero,
                      title: Row(
                        children: [
                          customeText(text: formattedString,
                            textAlign: TextAlign.start,
                            style: ConstantTextStyle.cardbottumText,
                          ),
                         index != 0 ? Container():
                         customeCheckbox(
                              checkColor: ConstantColor.primaryBackgroundMainColor,
                              activeColor: ConstantColor.primaryMainColor,
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value ?? false; // Update isChecked based on checkbox value
                                  if (isChecked) {
                                    // Populate form fields with data from the first combination
                                    populateFormFields();
                                  } else {
                                    // Clear form fields
                                    setState(() {
                                      variantData.clear();
                                    });
                                    clearFormFields();
                                  }
                                });
                              }),
                          index != 0 ? Container():
                          Flexible(
                            child: customeText(text: "Fill same data in below fields.",
                              textAlign: TextAlign.start,
                              style: ConstantTextStyle.subtitleGreyText,
                            ),
                          ),
                        ],
                      ),
                      children: [
                        SizedBox(height: screenHeight / 80.0),
                        // TextFormFields and widgets for capturing data
                        GlobalTextFormField(
                          margin: EdgeInsets.only(bottom: screenHeight / 60.0),
                          enabled: true,
                          controller: modalNameControllers[index],
                          keyboardType: TextInputType.text,
                          hintText: "",
                          labelText: "Modal Name * ",
                          labelStyle: ConstantTextStyle.lableRadioText,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter modal name';
                            }
                            return null;
                          },
                          hintStyle: ConstantTextStyle.otpHintTextStyle,
                          onChanged: (value) { },
                        ),
                        // Radio buttons for stock status
                        Row(
                          children: [
                            Flexible(
                              child: customRadioButtonTitle(
                                title: customeText(text: "In Stock", style: ConstantTextStyle.passwordScreenLineTexStyle),
                                value: "1",
                                groupValue: selectedOption[index],
                                onChanged: (value) {
                                  setState(() {
                                    selectedOption[index] = value.toString();
                                  });
                                },
                              ),
                            ),
                            Flexible(
                              child: customRadioButtonTitle(
                                title: customeText(text: "Out of stock", style: ConstantTextStyle.passwordScreenLineTexStyle),
                                value: "2",
                                groupValue: selectedOption[index],
                                onChanged: (value) {
                                  setState(() {
                                    selectedOption[index] = value.toString();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight / 60.0),
                        GlobalTextFormField(
                          margin: EdgeInsets.only(bottom: screenHeight / 60.0),
                          enabled: true,
                          controller: quantityControllers[index],
                          keyboardType: TextInputType.number,
                          hintText: "",
                          labelText: "Quantity * ",
                          labelStyle: ConstantTextStyle.lableRadioText,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter quantity';
                            }
                            return null;
                          },
                          hintStyle: ConstantTextStyle.otpHintTextStyle,
                          onChanged: (value) {},
                        ),
                        GlobalTextFormField(
                          margin: EdgeInsets.only(bottom: screenHeight / 60.0),
                          enabled: true,
                          controller: priceControllers[index],
                          keyboardType: TextInputType.number,
                          hintText: "",
                          labelText: "Price * ",
                          labelStyle: ConstantTextStyle.lableRadioText,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter price';
                            }
                            return null;
                          },
                          hintStyle: ConstantTextStyle.otpHintTextStyle,
                          onChanged: (value) {},
                        ),
                        GlobalTextFormField(
                          margin: EdgeInsets.only(bottom: screenHeight / 60.0),
                          enabled: true,
                          controller: offerPriceControllers[index],
                          keyboardType: TextInputType.number,
                          hintText: "",
                          labelText: "Offer Price ",
                          labelStyle: ConstantTextStyle.lableRadioText,
                          hintStyle: ConstantTextStyle.otpHintTextStyle,
                          onChanged: (value) {},
                        ),
                        // TextFields for Start Date and End Date with date pickers
                        GlobalTextFormField(
                          enabled: false,
                          margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
                          controller: startDateControllers[index],
                          onTap: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (_) => PreLoadDatePickerWidget(
                                onChanged: (selectedDate) {
                                  if (selectedDate != null) {
                                    String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
                                    startDateControllers[index].text = formattedDate;
                                    // You may also update any internal state variables if needed
                                    setState(() {});
                                  }
                                  // _startedDateController.text = selectedDate.toString();
                                  // _onDateSelected(selectedDate);
                                },
                              ),
                            );
                          },
                          keyboardType: TextInputType.datetime,
                          labelText: "Offer Start Date",
                          suffixIcon: const Icon(Icons.date_range_outlined, color: ConstantColor.landingScreenSubHaddingColor),
                          labelStyle: ConstantTextStyle.lableRadioText,
                          onChanged: (value) {},
                        ),
                        GlobalTextFormField(
                          enabled: false,
                          margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
                          controller: endDateControllers[index],
                          onTap: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (_) => PreLoadDatePickerWidget(
                                onChanged: (selectedDate) {
                                  if (selectedDate != null) {
                                    String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
                                    // String formattedDate = DateFormat('dd MMMM yyyy').format(selectedDate);
                                    endDateControllers[index].text = formattedDate;
                                    // You may also update any internal state variables if needed
                                    setState(() {});
                                  }
                                  // _startedDateController.text = selectedDate.toString();
                                  // _onDateSelected(selectedDate);
                                },
                              ),
                            );
                          },
                          keyboardType: TextInputType.datetime,
                          labelText: "Offer End Date",
                          suffixIcon: const Icon(Icons.date_range_outlined, color: ConstantColor.landingScreenSubHaddingColor),
                          labelStyle: ConstantTextStyle.lableRadioText,
                          onChanged: (value) {},
                        ),
                        // SizedBox(height: screenWidth / 80.0),
                      ]
                  ),
                );
              },
            ),
            SizedBox(height: screenHeight / 80.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customButton(
                  toolTipMessage: "previous step 3.",
                  textStyleButton: ConstantTextStyle.topCategoryText4,
                  onPressed: () {
                    setState(() {
                       widget.onPreview();
                    });
                  },
                  text: 'Previous',
                  backgroundColor: ConstantColor.sellerBGColor,
                  borderRadius: BorderRadius.circular(20.0),
                  elevation: 1.0,
                ),
                customButton(
                  toolTipMessage: "submit.",
                  textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                  onPressed: handleSubmit,
                  text: "Submit",
                  backgroundColor: ConstantColor.primaryMainColor,
                  borderRadius: BorderRadius.circular(20.0),
                  elevation: 1.0,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}




