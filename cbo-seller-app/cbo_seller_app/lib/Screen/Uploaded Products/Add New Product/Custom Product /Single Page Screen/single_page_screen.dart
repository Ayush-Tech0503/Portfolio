// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../Services/Custom Product Api Services/add_new_product_submit_api_services.dart';
import '../../../../../Services/Custom Product Api Services/image_uploading_api_services.dart';
import '../../../../../Utils/Constant Api Routs/constant_api_routs.dart';
import '../../../../../Utils/Constant Size /constant_sizes.dart';
import '../../../../../Utils/Font Style/text_styles.dart';
import '../../../../../Utils/Theme/constant_colors.dart';
import '../../../../../Widget/Custome Buttons/elevetion_button_widget.dart';
import '../../../../../Widget/Date Pickers/pre_loaded_date_pic_widget.dart';
import '../../../../../Widget/Html Enhance Editor/html_editor_enhancement_widget.dart';
import '../../../../../Widget/Radio Button/radio_list_tile_widget.dart';
import '../../../../../Widget/Scaffold Message/scaffold_message_widget.dart';
import '../../../../../Widget/Text Form Fields/global_text_form_field.dart';
import '../../../../../Widget/custome_text_widget.dart';
import '../../../../../Widget/gender_container_widget.dart';
import '../../../../../Widget/images/cached_images_widget.dart';
import '../../../uploaded_products_dart.dart';

class SinglePageFormScreen extends StatefulWidget {
  final categoryName;
  final categoryId;
  const SinglePageFormScreen({super.key, this.categoryName, this.categoryId});

  @override
  _SinglePageFormScreenState createState() => _SinglePageFormScreenState();
}

class _SinglePageFormScreenState extends State<SinglePageFormScreen> {

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productSlugController = TextEditingController();
  final TextEditingController _productModalController = TextEditingController();
  final TextEditingController _brandNameController = TextEditingController();
  final TextEditingController _stockQuantityController = TextEditingController();
  final TextEditingController _regularPriceController = TextEditingController();
  final TextEditingController _offerPriceController = TextEditingController();
  final TextEditingController _startedDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _warrantyController = TextEditingController();
  final TextEditingController _shortDescriptionController = TextEditingController();
  String selectedOption = '1';
  String selectedStatusOption = '1';

  HtmlEditorController controller = HtmlEditorController();
  HtmlEditorController controller2 = HtmlEditorController();

// final TextEditingController _controller = TextEditingController();
// late final FocusNode _focusNode;

  @override
  void dispose() {
    _productNameController.dispose();
    _productSlugController.dispose();
    _productModalController.dispose();
    _brandNameController.dispose();
    _stockQuantityController.dispose();
    _regularPriceController.dispose();
    _offerPriceController.dispose();
    _startedDateController.dispose();
    _endDateController.dispose();
    _warrantyController.dispose();
    snoController.dispose();
    _shortDescriptionController.dispose();
    _scrollController.dispose();
    super.dispose();
    controller.clear();
    controller.clearFocus();
    controller2.clear();
    controller2.clearFocus();
  }

  void _onDateSelected(DateTime selectedDate) {
    String formattedDate = DateFormat('dd MMMM yyyy').format(selectedDate);
    _startedDateController.text = formattedDate;
    setState(() {_startedDateController.text = formattedDate.toString();});
  }

  void _onEndDateSelected(DateTime selectedDate) {
    String formattedDate = DateFormat('dd MMMM yyyy').format(selectedDate);
    _endDateController.text = formattedDate;
    setState(() {_endDateController.text = formattedDate.toString();});
  }

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // _controller.addListener(() => setState(() {})); // Update the text when typing
    // _focusNode = FocusNode();
    super.initState();
  }


  File? imageFile;

  Future<void> _pickImage(int index) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      String fileName = imageFile!.path.split('/').last;
      var stream = http.ByteStream(imageFile!.openRead());
      var length = await imageFile!.length();
      var multipartFile = http.MultipartFile(
        'file', stream, length,
        filename: fileName,
      );

      setState(() {
        // tableData[index]['pickedImagePath'] = pickedFile.path;
        // tableData[index]['multipartFile'] = multipartFile;
        _handleUploadImageSubmit(index, pickedFile.path);
      });
    } else {
      // Handle no image picked scenario
    }
  }


  void _handleUploadImageSubmit(int index, imageUrl) async {
    FormData formData = FormData();
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      try {
        // Extract file name from the path
        String fileName = imageUrl!.split('/').last;
        formData.files.add(MapEntry("image", await MultipartFile.fromFile(imageUrl!, filename: fileName)));
      } catch (e) {
        formData.fields.add(MapEntry("image", imageUrl!));
      }
    } else {
      LoadingScaffoldMessage.showSnackbar(
        context, "Please upload imageUrl file as it is required.",
        Colors.red,
        const Duration(seconds: 2),
      );
      return;
    }

    fetchUploadImageData(
      context: context,
      formData: formData,
      onSuccess: (imageUrl) {
        setState(() {
          tableData[index]['imageUrl'] = imageUrl;
        });
        // Handle successful upload
      },
    );
  }




  int rowCount = 2;

  List<Map<String, dynamic>> tableData = [{
    'imageUrl': '',
    'imageOrder': '1',
    'isPrimary': true
  }
  ];




  void _addRow() {
    if (rowCount < 7) {
      setState(() {
        tableData.add({
          'imageUrl': '',
          'imageOrder': rowCount.toString(),
          'isPrimary': false
        });
        rowCount++;
      });
    }else{
      LoadingScaffoldMessage.showSnackbar(
        context, "Sorry!! your Row limit is over.",
        Colors.red, // Change color as per your theme
        const Duration(seconds: 2),
      );
    }
  }


  void _removeRow(int index) {
    setState(() {
      tableData.removeAt(index);
      rowCount--;
    });
  }

  void _updateSno(int index, String newSno) {
    if (newSno.isNotEmpty && int.tryParse(newSno) != null) {
      setState(() {
        tableData[index]['imageOrder'] = newSno;
      });
    } else {}
  }




  bool areImagesValid() {
    return tableData.any((rowData) => rowData['imageUrl'].isNotEmpty);
  }

  TextEditingController snoController = TextEditingController();
  void _selectPrimaryImage(int rowIndex) {
    setState(() {
      for (int i = 0; i < tableData.length; i++) {
        if (i == rowIndex) {
          tableData[i]['isPrimary'] = true;
        } else {
          tableData[i]['isPrimary'] = false;
        }
      }
    });
  }


  bool hasImageError = false;


  void _handleSubmit() async {
    List<Map<String, dynamic>> updatedList = [];

    for (int i = 0; i < tableData.length; i++) {
      Map<String, dynamic> rowData = tableData[i];
      Map<String, dynamic> updatedRow = {
        'imageUrl': {'url': rowData['imageUrl'].toString()},
        'imageOrder': rowData['imageOrder'].toString(),
        'isPrimary': rowData['isPrimary']
      };

      updatedList.add(updatedRow);
    }
    var fullDescription = await controller.getText();
    var otherFeature = await controller2.getText();
    if (_formKey.currentState!.validate()) {
      // Create FormData object
      FormData formData = FormData();
      formData.fields.addAll([
        MapEntry("prod_category", widget.categoryName),
        MapEntry("prod_cat_id", widget.categoryId),
        MapEntry("product_name", _productNameController.text),
        MapEntry("product_slug", _productSlugController.text),
        MapEntry("model_name", _productModalController.text),
        MapEntry("brand_name", _brandNameController.text),
        MapEntry("stock_status", selectedOption),
        MapEntry("stock_quantity", _stockQuantityController.text),
        MapEntry("price", _regularPriceController.text),
        MapEntry("offer_price", _offerPriceController.text),
        MapEntry("offer_start_date", _startedDateController.text),
        MapEntry("offer_end_date", _endDateController.text),
        MapEntry("warranty", _warrantyController.text),
        MapEntry("full_description", fullDescription??""),
        MapEntry("short_description", _shortDescriptionController.text??""),
        MapEntry("other_feature", otherFeature??""),
        MapEntry("product_status", selectedStatusOption),
        MapEntry("product_img", updatedList.toString()),
        const MapEntry("pid", '0'),
        const MapEntry("act", 'add')
      ]);

      fetchAddProductSubmitFormData(
          context: context,
          formData: formData,
          baseUrl: "${ConstantUrls.baseUriApi}${ConstantUrls.addNewProductEndpoint}",
        onSuccess: () => Navigator.pushNamed(context, '/uploadedProductScreen')
      );
    }
  }





  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: Skeletonizer(
        enabled: isLoading,
        child:  SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // customeText(text: 'single page data'),

              GlobalTextFormField(
                margin: EdgeInsets.symmetric(vertical: screenHeight/80.0),
                enabled: true,
                controller: _productNameController,
                keyboardType: TextInputType.text,
                hintText: "",
                labelText: "Product Name * ",
                validator: (value) {
                  if (value == null || value.isEmpty) {return 'Please enter product name';}
                  return null;
                },
                hintStyle: ConstantTextStyle.otpHintTextStyle,
                labelStyle: ConstantTextStyle.lableRadioText,
                onChanged: (value) {
                  setState(() {_productSlugController.text = value.toLowerCase().replaceAll(' ', '-');});
                },
              ),

              GlobalTextFormField(
                margin: EdgeInsets.symmetric(vertical: screenHeight/80.0),
                enabled: false,
                controller: _productSlugController,
                keyboardType: TextInputType.text,
                hintText: "",
                labelText: "Product Slug * ",
                validator: (value) {
                  if (value == null || value.isEmpty) {return 'Please enter product Slug';}
                  return null;
                },
                hintStyle: ConstantTextStyle.otpHintTextStyle,
                labelStyle: ConstantTextStyle.lableRadioText,
                onChanged: (value) {},
              ),

              GlobalTextFormField(
                margin: EdgeInsets.symmetric(vertical: screenHeight/80.0),
                enabled: true,
                controller: _productModalController,
                keyboardType: TextInputType.text,
                hintText: "",
                labelText: "Product Modal Name * ",
                validator: (value) {
                  if (value == null || value.isEmpty) {return 'Please enter product modal Name.';}
                  return null;
                },
                hintStyle: ConstantTextStyle.otpHintTextStyle,
                labelStyle: ConstantTextStyle.lableRadioText,
                onChanged: (value) {},
              ),


              GlobalTextFormField(
                margin: EdgeInsets.symmetric(vertical: screenHeight/80.0),
                enabled: true,
                controller: _brandNameController,
                keyboardType: TextInputType.text,
                hintText: "",
                labelText: "Brand Name * ",
                validator: (value) {
                  if (value == null || value.isEmpty) {return 'Please enter brand name.';}
                  return null;
                },
                hintStyle: ConstantTextStyle.otpHintTextStyle,
                labelStyle: ConstantTextStyle.lableRadioText,
                onChanged: (value) {},
              ),

              constantHeight(context, 100.0),

              radiobuttonContainer(
                context: context,
                headText: "In stock Status *",
                radioButtonWidget:
                Row(
                  children: [
                    Flexible(
                      child: customRadioButtonTitle(
                        title: customeText(text: "In Stock",style: ConstantTextStyle.passwordScreenLineTexStyle,),
                        value: "1",
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value.toString();
                            // preLoadProduct.isActive = value.toString();
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: customRadioButtonTitle(
                        title: customeText(text: "Out Of Stock",style: ConstantTextStyle.passwordScreenLineTexStyle,),
                        value: "0",
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value.toString();
                            // preLoadProduct.isActive = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              constantHeight(context, 100.0),

              GlobalTextFormField(
                margin: EdgeInsets.symmetric(vertical: screenHeight/80.0),
                enabled: true,
                controller: _stockQuantityController,
                keyboardType: TextInputType.number,
                hintText: "",
                labelText: "Stock Quantity *",
                validator: (value) {
                  if (value == null || value.isEmpty) {return 'Please enter stock quantity.';}
                  return null;
                },
                hintStyle: ConstantTextStyle.otpHintTextStyle,
                labelStyle: ConstantTextStyle.lableRadioText,
                onChanged: (value) {},
              ),

              GlobalTextFormField(
                margin: EdgeInsets.symmetric(vertical: screenHeight/80.0),
                enabled: true,
                controller: _regularPriceController,
                keyboardType: TextInputType.number,
                hintText: "",
                labelText: "Regular Price *",
                validator: (value) {
                  if (value == null || value.isEmpty) {return 'Please enter Price.';}
                  return null;
                },
                hintStyle: ConstantTextStyle.otpHintTextStyle,
                labelStyle: ConstantTextStyle.lableRadioText,
                onChanged: (value) {},
              ),

              GlobalTextFormField(
                margin: EdgeInsets.symmetric(vertical: screenHeight/80.0),
                enabled: true,
                controller: _offerPriceController,
                keyboardType: TextInputType.number,
                hintText: "",
                labelText: "offer Price ",
                hintStyle: ConstantTextStyle.otpHintTextStyle,
                labelStyle: ConstantTextStyle.lableRadioText,
                onChanged: (value) {},
              ),



              GlobalTextFormField(
                enabled: false,
                margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
                controller: _startedDateController,
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (_) => PreLoadDatePickerWidget(
                      onChanged: (selectedDate) {
                        // _startedDateController.text = selectedDate.toString();
                        _onDateSelected(selectedDate);
                      },
                    ),
                  );
                },
                keyboardType: TextInputType.datetime,
                labelText: "Offer Start Date",
                suffixIcon: const Icon(Icons.date_range_outlined, color: ConstantColor.landingScreenSubHaddingColor),
                hintText:_startedDateController.text.isNotEmpty ? _startedDateController.text : "",
                labelStyle: ConstantTextStyle.lableRadioText,
                onChanged: (value) {
                  setState(() {
                    // preLoadProduct.offerStartDate = value;
                  });
                },
              ),


              GlobalTextFormField(
                enabled: false,
                margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
                controller: _endDateController,
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (_) => PreLoadDatePickerWidget(
                      onChanged: (selectedDate) {
                        // _startedDateController.text = selectedDate.toString();
                        _onEndDateSelected(selectedDate);
                      },
                    ),
                  );
                },
                keyboardType: TextInputType.datetime,
                labelText: "Offer End Date",
                suffixIcon: const Icon(Icons.date_range_outlined, color: ConstantColor.landingScreenSubHaddingColor),
                hintText:_endDateController.text.isNotEmpty ? _endDateController.text : "",
                labelStyle: ConstantTextStyle.lableRadioText,
                onChanged: (value) {
                  setState(() {
                    // preLoadProduct.offerStartDate = value;
                  });
                },
              ),


              GlobalTextFormField(
                margin: EdgeInsets.symmetric(vertical: screenHeight/80.0),
                enabled: true,
                controller: _warrantyController,
                keyboardType: TextInputType.text,
                hintText: "",
                labelText: "Warranty ",
                maxLines: 6,
                hintStyle: ConstantTextStyle.otpHintTextStyle,
                labelStyle: ConstantTextStyle.lableRadioText,
                onChanged: (value) {},
              ),

              GlobalTextFormField(
                margin: EdgeInsets.symmetric(vertical: screenHeight/80.0),
                enabled: true,
                controller: _shortDescriptionController,
                keyboardType: TextInputType.text,
                hintText: "",
                labelText: "Short Description * ",
                maxLines: 6,
                hintStyle: ConstantTextStyle.otpHintTextStyle,
                labelStyle: ConstantTextStyle.lableRadioText,
                validator: (value) {
                  if (value == null || value.isEmpty) {return 'Please enter Short Description.';}
                  return null;
                },
                onChanged: (value) {},
              ),


              constantHeight(context, 60.0),

              customeText(text: "Full Description",style: ConstantTextStyle.lableRadioText),
              constantHeight(context, 80.0),

              htmlEnhanceWidget(controller: controller),


              constantHeight(context, 30.0),
              customeText(text: "Other Features",style: ConstantTextStyle.lableRadioText),
              constantHeight(context, 80.0),
              htmlEnhanceWidget(controller: controller2, hintText: "Type your other features"),

              constantHeight(context, 30.0),


              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Table(
                    columnWidths: {
                      0: FixedColumnWidth(screenWidth * 0.2),
                      1: FixedColumnWidth(screenWidth * 0.25),
                      2: FixedColumnWidth(screenWidth * 0.3),
                      3: FixedColumnWidth(screenWidth * 0.3),
                      4: FixedColumnWidth(screenWidth * 0.3),
                    },
                    children: [
                      // Table header row
                      TableRow(
                        decoration:BoxDecoration(
                          color: ConstantColor.calendarBGHeadColor,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        children:  [
                          TableCell(child: paddingText(context: context, title:"\t\t\t\t\tS.No.",)),
                          TableCell(child: paddingText(context: context, title:"Primary",)),
                          TableCell(child: paddingText(context: context, title:"Choose Image",)),
                          TableCell(child: paddingText(context: context, title:"Image Order",)),
                          TableCell(child: paddingText(context: context, title:"Action",)),
                        ],
                      ),
                      // Data rows
                      ...tableData.asMap().entries.map((entry) {
                        int index = entry.key;
                        Map<String, dynamic> rowData = entry.value;
                        TextEditingController snoController = TextEditingController(text: rowData['imageOrder'].toString());
                        return TableRow(
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey)),
                          ),
                          children: [
                            TableCell(
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
                                child: customeText(
                                  text: '\t\t\t\t\t${(index+1).toString()} .',
                                  textAlign: TextAlign.start,
                                  style: ConstantTextStyle.topCategoryText2,
                                ),
                              ),
                            ),

                            TableCell(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: GestureDetector(
                                  onTap: () {
                                    _selectPrimaryImage(index);
                                  },
                                  child: Radio(
                                    activeColor: ConstantColor.primaryMainColor,
                                    value: true,
                                    groupValue: rowData['isPrimary'],
                                    onChanged: (value) {
                                      _selectPrimaryImage(index);
                                    },
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  // Conditionally show the uploaded image or the upload container
                                  rowData['imageUrl'].isNotEmpty
                                      ? GestureDetector(
                                    onTap: () {
                                      // Handle image removal here
                                      setState(() {
                                        tableData[index]['imageUrl'] = '';
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
                                        child:cachedImageWidget(
                                          context:context,
                                          imageFile: rowData['imageUrl']?? "",
                                          width: 80.0,
                                          height: 80.0,
                                          fit: BoxFit.cover,
                                        )
                                    ),
                                  )
                                      : GestureDetector(
                                    onTap: () {
                                      _pickImage(index);
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(top: screenHeight / 80.0, bottom: screenHeight / 80.0,right: screenWidth/20.0),
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8.0),
                                            border: Border.all(color: ConstantColor.chipCompleteStatus),
                                            color: ConstantColor.primaryBackgroundMainColor,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(Icons.upload, color: ConstantColor.chipCompleteStatus),
                                              const SizedBox(width: 8.0),
                                              customeText(
                                                text: 'Upload',
                                                style: ConstantTextStyle.greenText,
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (hasImageError)
                                          customeText(text: 'This field is required.', style: ConstantTextStyle.locationText),
                                      ],
                                    ),
                                  ),

                                  // Cross icon to remove the image
                                  if (rowData['imageUrl'].isNotEmpty)
                                    Positioned(
                                      top: screenHeight/60.0,
                                      right: screenWidth/10.0,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            tableData[index]['imageUrl'] = '';
                                          });
                                        },
                                        child: const CircleAvatar(
                                          radius: 12.0,
                                          backgroundColor: ConstantColor.primaryBackgroundMainColor,
                                          child: Icon(Icons.close, color: ConstantColor.primaryMainColor),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),

                            TableCell(
                              child:  GlobalTextFormField(
                                margin: EdgeInsets.symmetric(vertical: screenHeight/80.0,horizontal: screenWidth/30.0),
                                enabled: true,
                                controller: snoController,
                                keyboardType: TextInputType.number,
                                hintText: "",
                                labelText: "",
                                maxLines: 1,
                                onChanged: (value) {_updateSno(index, value);},
                              ),

                            ),

                            TableCell(
                              child: index == 0
                                  ? Container(
                                margin: const EdgeInsets.all(30.0),
                                color: ConstantColor.loginWithOtpButtonColor,
                                height: screenHeight/300.0)
                                  : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: customButton(
                                    textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                                    onPressed:() {_removeRow(index);},
                                    text: "Delete",
                                    backgroundColor: ConstantColor.loginWithOtpButtonColor,
                                    borderRadius: BorderRadius.circular(8.0),
                                    elevation: 0.0,
                                    minimumSize: Size(screenWidth, screenHeight/24.0)
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),

              constantHeight(context, 80.0),

              Align(
                alignment: Alignment.centerRight,
                child: customButton(
                    textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                    onPressed:_addRow,
                  toolTipMessage: "add more product image.",
                    text: "Add More",
                    backgroundColor: ConstantColor.chipCompleteStatus,
                    borderRadius: BorderRadius.circular(8.0),
                    elevation: 0.0,
                    // minimumSize: Size(screenWidth/3, screenHeight/24.0)
                ),
              ),

              constantHeight(context, 40.0),

              radiobuttonContainer(
                context: context,
                headText: "Status *",
                radioButtonWidget:
                Row(
                  children: [
                    Flexible(
                      child: customRadioButtonTitle(
                        title: customeText(text: "Active",style: ConstantTextStyle.passwordScreenLineTexStyle,),
                        value: "1",
                        groupValue: selectedStatusOption,
                        onChanged: (value) {
                          setState(() {
                            selectedStatusOption = value.toString();
                            // preLoadProduct.isActive = value.toString();
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: customRadioButtonTitle(
                        title: customeText(text: "Deactive",style: ConstantTextStyle.passwordScreenLineTexStyle,),
                        value: "0",
                        groupValue: selectedStatusOption,
                        onChanged: (value) {
                          setState(() {
                            selectedStatusOption = value.toString();
                            // preLoadProduct.isActive = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),



              constantHeight(context, 40.0),

              Align(
                alignment: Alignment.centerRight,
                child: customButton(
                  textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                  onPressed: () async {
                    // Reset error state
                    setState(() {
                      hasImageError = false;
                    });

                    // Check each row in tableData for empty imageUrl
                    for (var rowData in tableData) {
                      if (rowData['imageUrl'].isEmpty) {
                        setState(() {
                          hasImageError = true;
                        });
                        // Exit the loop if any image is missing
                        break;
                      }
                    }

                    // If no image error found, proceed with submit logic
                    if (!hasImageError) {
                      _handleSubmit();
                    }
                  },
                  toolTipMessage: "submit.",
                  text: "Submit",
                  backgroundColor: ConstantColor.primaryMainColor,
                  borderRadius: BorderRadius.circular(20.0),
                  elevation: 0.0,
                  minimumSize: Size(screenWidth / 2, screenHeight / 24.0),
                ),
              ),

              // constantHeight(context, 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
