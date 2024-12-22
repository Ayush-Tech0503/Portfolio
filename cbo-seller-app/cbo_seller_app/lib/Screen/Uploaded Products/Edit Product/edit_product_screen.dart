// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:citybazaronline_seller_app/Models/Uploaded%20Products%20Model/non_edit_attribute_model.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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
import '../../../Layouts/constant_screen_layout.dart';
import '../../../Models/Complete Order Model/cat_attribute_model.dart';
import '../../../Models/Uploaded Products Model/view_and_edit_product_model.dart';
import '../../../Services/Custom Product Api Services/cat_attribute_api_service.dart';
import '../../../Services/Seller Forms Api Services/Seller Form Submit Api Services/step_1st_form_submit_api.dart';
import '../../../Services/Uploaded Products Api Services/view_product_api_services.dart';
import '../../../Services/Uploaded Video Api Services/non_edit_attribute_api.dart';
import '../../../Widget/No Data Available/no_data_found.dart';
import '../uploaded_products_dart.dart';

class EditProductScreen extends StatefulWidget {
  final productId;
  const EditProductScreen({super.key, this.productId});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productSlugController = TextEditingController();
  final TextEditingController _skuController = TextEditingController();
  final TextEditingController _productModalController = TextEditingController();
  final TextEditingController _brandNameController = TextEditingController();
  final TextEditingController _stockQuantityController = TextEditingController();
  final TextEditingController _regularPriceController = TextEditingController();
  final TextEditingController _offerPriceController = TextEditingController();
  final TextEditingController _startedDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _warrantyController = TextEditingController();
  final TextEditingController _shortDescriptionController = TextEditingController();
  String selectedOption = '';
  String selectedStatusOption = '';
  var productCatId = '';
  var productCatName = '';
  String imageUrls = '';

  HtmlEditorController controller = HtmlEditorController();
  HtmlEditorController controller2 = HtmlEditorController();

// final TextEditingController _controller = TextEditingController();
// late final FocusNode _focusNode;

  @override
  void dispose() {
    // for (var controller in textControllers) {
    //   controller.dispose();
    // }

    // Reset form state if it's available
    if (_formKey.currentState != null) {
      _formKey.currentState!.reset();
    }

    // attributeDataList.clear();
    // selectSingleOption.clear();
    // selectMultipleOption.clear();
    _productNameController.dispose();
    _productSlugController.dispose();
    _skuController.dispose();
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
    String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
    _startedDateController.text = formattedDate;
    setState(() {_startedDateController.text = formattedDate.toString();});
  }


  void _onEndDateSelected(DateTime selectedDate) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
    _endDateController.text = formattedDate;
    setState(() {_endDateController.text = formattedDate.toString();});
  }

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    fetchViewProductListData();
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


  //----------------------------------------------
  void _addFormHandleSubmit() async {
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


    double parsedPrice = double.tryParse(_regularPriceController.text ?? "0") ?? 0.0;
    double parsedOfferPrice = double.tryParse(_offerPriceController.text ?? "0") ?? 0.0;
    // String offerStartDateISO = convertDate(_startedDateController.text);
    // String offerEndDateISO = convertDate(_endDateController.text);

    bool priceErrorShown = false;

    // Check if offerPrice is greater than price
    if (parsedOfferPrice > parsedPrice && !priceErrorShown) {
      LoadingScaffoldMessage.showSnackbar(
        context,
        "Offer price cannot be greater than regular price.",
        ConstantColor.primaryMainColor,
        const Duration(seconds: 2),
      );
      priceErrorShown = true; // Set flag to true after showing the error message
      return;// Skip this product and continue with the next one
    }


    var fullDescription = await controller.getText();
    var otherFeature = await controller2.getText();
    if (_formKey.currentState!.validate()) {
      // Create FormData object
      FormData formData = FormData();
      formData.fields.addAll([
        MapEntry("prod_category", productCatName),
        MapEntry("prod_cat_id", productCatId),
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
        // Adding entries from attributeDataListData
        // ...attributeDataList.map((item) {
        //   String key = item.keys.first;
        //   dynamic value = item.values.first;
        //   return MapEntry(key, value.toString());
        // }),
        // Adding entries from attributeDataListData
        // ...selectSingleOption.map((item) {
        //   String key = item.keys.first;
        //   dynamic value = item.values.first;
        //   return MapEntry(key, value.toString());
        // }),
         MapEntry("pid", widget.productId??"0"),
         const MapEntry("act", 'update')
      ]);

      fetchAddProductSubmitFormData(
          context: context,
          formData: formData,
          baseUrl: "${ConstantUrls.baseUriApi}${ConstantUrls.addNewProductEndpoint}",
          onSuccess: () => Navigator.pushNamed(context, '/uploadedProductScreen')
      );
    }
  }
  //----------------------------------------------

  // String convertDate(String displayDate) {
  //   try {
  //       String formattedDate = '${DateTime(int.parse(displayDate.split('/')[2]), int.parse(displayDate.split('/')[0]), int.parse(displayDate.split('/')[1])).toIso8601String().split('T')[0]} 00:00:00.000';
  //   return formattedDate;
  //   } catch (e) {
  //     return ""; // Return an empty string or handle the error as needed
  //   }
  // }


  //----------------------------------------------

  void _restrictedHandleSubmit() {
    double parsedPrice = double.tryParse(_regularPriceController.text ?? "0") ?? 0.0;
    double parsedOfferPrice = double.tryParse(_offerPriceController.text ?? "0") ?? 0.0;
    // String offerStartDateISO = convertDate(_startedDateController.text);
    // String offerEndDateISO = convertDate(_endDateController.text);
    bool priceErrorShown = false;

    // Check if offerPrice is greater than price
    if (parsedOfferPrice > parsedPrice && !priceErrorShown) {
      LoadingScaffoldMessage.showSnackbar(
        context,
        "Offer price cannot be greater than regular price.",
        ConstantColor.primaryMainColor,
        const Duration(seconds: 2),
      );
      priceErrorShown = true; // Set flag to true after showing the error message
      return;// Skip this product and continue with the next one
    }

    if (_formKey.currentState!.validate()) {
      fetchSellerRegistrationBodyApi(
        context: context,
        baseUrl: '${ConstantUrls.baseUriApi}${ConstantUrls.restrictedEditProductEndpoint}',
        body: {
          "pro_id": widget.productId??"0",
          "price": _regularPriceController.text,
          "offer_price":  _offerPriceController.text,
          "stock": selectedOption,
          "status": selectedStatusOption,
          "stock_quantity": _stockQuantityController.text,
          "offer_start_date": _startedDateController.text,
          "offer_end_date": _endDateController.text
        },
        onSuccess: () => Navigator.pushNamed(context, '/uploadedProductScreen')
      );
    }
  }

  //----------------------------------------------
  // '406356'
  // '406263'
  // Helper function to format date
  String formatDate(String dateStr) {
    if (dateStr == "0000-00-00 00:00:00") {
      return "";
    }
    try {
      final dateTime = DateTime.parse(dateStr);
      return DateFormat('dd-MM-yyyy').format(dateTime);
    } catch (e) {
      return dateStr; // Return the original string if parsing fails
    }
  }

  bool isPullToRefreshEnabled = true;
  // bool isLoading = false;

  var isRestriction = '';
  ViewProductModel? viewProductModel;
  List<ProductDetails>? data = [];
  Future<void> fetchViewProductListData() async {
    try {
        setState(() {
          isLoading = true;
          data!.clear();
        });

      final viewProductResponse = await ViewProductApiService.fetchViewProductData(context: context,reqId: widget.productId??"");

      if (viewProductResponse != null && viewProductResponse.productDetails != null) {
        final dataList = viewProductResponse.productDetails!;

        setState(() {
          // data = dataList;
          // if (currentPage == 1) {
          //
          // } else {
            data!.addAll(dataList);
          // }

          isLoading = false;
          // currentPage++;
        });

        setState(() {
          isRestriction = data!.first.isRestricted??"";
          productCatId = data!.first.productCategory??"";
          productCatName = data!.first.categoryName??"";
          _productNameController.text = data!.first.productName??"";
          _productSlugController.text = data!.first.productSlug??"";
          _skuController.text = data!.first.sku??"";
          _productModalController.text = data!.first.model??"";
          _brandNameController.text = data!.first.brand??"";
          selectedOption = data!.first.isAvailable??"";
          _stockQuantityController.text = data!.first.stockQuantity??"";
          _regularPriceController.text = data!.first.price??"";
          _offerPriceController.text = data!.first.offerPrice??"";
          _startedDateController.text = formatDate(data!.first.offerStartDate ?? "");
          _endDateController.text = formatDate(data!.first.offerEndDate ?? "");
          _warrantyController.text = data!.first.warranty??"";
          _shortDescriptionController.text = data!.first.shortDescription??"";
          imageUrls = data!.first.imageFile??"";
          selectedStatusOption = data!.first.productStatus??"";
          if (productCatId.isNotEmpty) {
            fetchCatAttData(productCatId: productCatId);
            fetchNonCatAttData(productCatId: productCatId);
          }
        });
        controller.setText(data!.first.description ?? "");
        controller2.setText(data!.first.otherFeature ?? "");
      } else {
        // No more data available
        setState(() {
          isLoading = false;
          isPullToRefreshEnabled = false; // Disable pull-to-refresh
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }
  //----------------------------------------------
  CatAttributesModel? catAttributesModel;
  List<CatAttributesData> catAttributesData = [];
  List<Map<String, dynamic>> collectionData = [];

  // bool isLoading2 = false;
  List<String> controlType = [];
  Future<void> fetchCatAttData({productCatId}) async {
    try {
      // showLoggingInDialog(context: context, title: 'Loading Please Wait!!');

      setState(() {
        isLoading = true;
        controlType.clear();
        collectionData.clear();
        catAttributesData.clear();
      });

      final brandListResponse = await CatAttributeApiService.fetchCatAttributeData(
        context: context,
        catId: productCatId ?? '',
      );

      if (brandListResponse!.status == "success") {
        List<String> controlTypeMapData = brandListResponse.data!.map((data) => data.controlType!).toList();
        List<CatAttributesData> attributeListing = brandListResponse.data??[];

        setState(() {
          catAttributesData = attributeListing;
          controlType = controlTypeMapData;
          isLoading = false;
        });
        // textControllers = List.generate(catAttributesData!.length, (index) => TextEditingController(),);
      }
      else {
        // Handle API response status other than success if needed
        setState(() {
          isLoading = false;
          // Navigator.pop(context);
        });
      }
    } catch (e) {
      // Error handling
      setState(() {
        isLoading = false;
        // Navigator.pop(context);
        // Handle error state if necessary
      });
    }
  }
  //----------------------------------------------
  // ----------------------------------------------
  NonEditAttributeModel? nonEditAttributeModel;
  List<AttData> attData = [];

  Future<void> fetchNonCatAttData({productCatId}) async {
    try {
      // showLoggingInDialog(context: context, title: 'Loading Please Wait!!');
      setState(() {
        isLoading = true;
        controlType.clear();
        collectionData.clear();
        catAttributesData.clear();
      });

      final editAttributeApiResponse = await nonEditAttributeApi(
        context: context,
        proId: widget.productId ?? '',
        catId: productCatId ?? '',
      );
      if (editAttributeApiResponse != null && editAttributeApiResponse.data != null) {
        final editAttributeList = editAttributeApiResponse.data ?? [];

        setState(() {
          attData!.addAll(editAttributeList);
          isLoading = false;
        });
        print("editAttributeDataList------${attData.first.attributeName}");
      }
      else {
        // Handle API response status other than success if needed
        setState(() {
          isLoading = false;
          // Navigator.pop(context);
        });
      }
    } catch (e) {
      // Error handling
      setState(() {
        isLoading = false;
        // Navigator.pop(context);
        // Handle error state if necessary
      });
    }
  }
  //----------------------------------------------


  @override
  Widget build(BuildContext context) {
    // print('widget.productId------${widget.productId}');
    // print('productCatId------${productCatId}');
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return AppLayout(
        title: "Edit Product Details",
        titleStyle: ConstantTextStyle.landingScreenAppbarText,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), color: ConstantColor.primaryBackgroundMainColor,
          onPressed: () => Navigator.pop(context),
        ),
        scaffoldColor: ConstantColor.primaryBackgroundMainColor,
        appBarColor: ConstantColor.loginWithOtpButtonColor,
          body: Form(
          key: _formKey,
          child: isLoading ? const Center(child: CircularProgressIndicator()) :
          SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth/30.0,vertical: screenHeight/80.0),
              child: (data != null && data!.isNotEmpty) ?
              isRestriction == "1" ?
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customeText(text: 'Category Name : ${productCatName??""}'),
                  SizedBox(height: screenHeight/80.0),
                  GlobalTextFormField(
                    margin: EdgeInsets.symmetric(vertical: screenHeight/80.0),
                    enabled: false,
                    controller: _productNameController,
                    keyboardType: TextInputType.text,
                    hintText: "",
                    filled: true,
                    fillColor: ConstantColor.notificationListColor,
                    labelText: "Selected Product * ",
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
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {return 'Please enter offer Price.';}
                    //   return null;
                    // },
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


                  constantHeight(context, 60.0),


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
                      onPressed: () => _restrictedHandleSubmit(),
                      toolTipMessage: "submit.",
                      text: "Submit",
                      backgroundColor: ConstantColor.primaryMainColor,
                      borderRadius: BorderRadius.circular(20.0),
                      elevation: 0.0,
                      minimumSize: Size(screenWidth / 2, screenHeight / 24.0),
                    ),
                  ),
                ],
              ) :
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customeText(text: 'Category Name : ${productCatName??""}'),
                  SizedBox(height: screenHeight/80.0),
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
                    controller: _skuController,
                    keyboardType: TextInputType.text,
                    hintText: "",
                    labelText: "SKU * ",
                    validator: (value) {
                      if (value == null) {return 'Please enter product SKU';}
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      cachedImageWidget(
                        context:context,
                        imageFile: imageUrls??"",
                        width: screenWidth/2.0,
                        height: screenHeight/5.0,
                        fit: BoxFit.cover,
                      ),
                      customButton(
                        textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                        onPressed: () => setState(() {imageUrls = '';}),
                        toolTipMessage: "remove image.",
                        text: "Remove",
                        backgroundColor: ConstantColor.primaryMainColor,
                        borderRadius: BorderRadius.circular(8.0),
                        elevation: 0.0,
                        // minimumSize: Size(screenWidth/3, screenHeight/24.0)
                      ),
                    ],
                  ),

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
                                            // if (hasImageError)
                                            //   customeText(text: 'This field is required.', style: ConstantTextStyle.locationText),
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

                  constantHeight(context, 80.0),


                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: attData?.length ?? 0,
                    itemBuilder: (context, index) {
                      var data = attData![index];
                      if (data.isVariant == "1" && data.controlType == "Dropdown") {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customeText(text: '${data.attributeName??""} *',style: ConstantTextStyle.topCategoryText),
                            GlobalTextFormField(
                              margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
                              enabled: false,
                              keyboardType: TextInputType.text,
                              hintText: "",
                              filled: true,
                              fillColor: ConstantColor.carColor,
                              labelText: "${data.attributeValue ?? ""} ",
                              hintStyle: ConstantTextStyle.otpHintTextStyle,
                              labelStyle: ConstantTextStyle.otpHintTextStyle,
                              suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined,color: ConstantColor.primaryMainColor,),
                            ),
                          ],
                        );
                      }
                      else if (data.isVariant == "0" && data.controlType == "Dropdown") {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customeText(text: '${data.attributeName??""} *',style: ConstantTextStyle.topCategoryText),
                            GlobalTextFormField(
                              margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
                              enabled: false,
                              keyboardType: TextInputType.text,
                              hintText: "",
                              filled: true,
                              fillColor: ConstantColor.carColor,
                              labelText: "${data.attributeValue ?? ""} ",
                              hintStyle: ConstantTextStyle.otpHintTextStyle,
                              labelStyle: ConstantTextStyle.otpHintTextStyle,
                              suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined,color: ConstantColor.primaryMainColor,),
                            ),
                          ],
                        );
                      }
                      else if (data.isVariant == "0" && data.controlType == "Textbox") {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customeText(text: '${data.attributeName??""} *',style: ConstantTextStyle.topCategoryText),
                            GlobalTextFormField(
                              margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
                              enabled: false,
                              keyboardType: TextInputType.text,
                              hintText: "",
                              filled: true,
                              fillColor: ConstantColor.carColor,
                              labelText: "${data.attributeValue ?? ""} ",
                              hintStyle: ConstantTextStyle.otpHintTextStyle,
                              labelStyle: ConstantTextStyle.otpHintTextStyle,
                            ),
                          ],
                        );
                      }
                      else {
                        return Container(); // Return an empty container if conditions are not met
                      }
                    },
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
                      onPressed: () =>  _addFormHandleSubmit(),
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
              ) :
              Column(
                children: [
                  constantHeight(context, 10.0),
                  noDataFound(context),
                ],
              ),
            ),
          ),
              ),
        );
  }
//   List<Map<String, String>> attributeDataList = [];
//   List<Map<String, dynamic>> selectSingleOption = [];
//   List<Map<String, dynamic>> selectMultipleOption = [];
//   List<Map<String, dynamic>> selectColorsList = [];
//   List<TextEditingController> textControllers = [];
//
//   Widget buildFormField(CatAttributesData attribute, int index) {
//     var screenHeight = MediaQuery.of(context).size.height;
//     var screenWidth = MediaQuery.of(context).size.width;
//
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
//
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
//     else if (attribute.isVariant == "0" && attribute.controlType == "Dropdown") {
//       return Padding(
//         padding: EdgeInsets.symmetric(vertical: screenHeight/80.0),
//         child:dropDownForm(
//           // icon: const Icon(Icons.arrow_drop_down),
//           menuMaxHeightFormField: 300.0,
//           context: context,
//           colorBorder: ConstantColor.primaryMainColor,
//           headText: '${attribute.attributeName??""} * ',
//           value: null,
//           items: (attribute.attributeData ?? []).map<DropdownMenuItem<String>>((item) =>
//               DropdownMenuItem<String>(
//                 value: item.optionId.toString(),
//                 child: Text(item.text ?? ''),
//               ),
//           ).toList(),
//           onChanged: (newValue) {
//             setState(() {
//               // Find the selected item by newValue
//               var selectedItem = (attribute.attributeData ?? []).firstWhere((item) => item.optionId.toString() == newValue,);
//
//               // Check if selectedItem is not null before accessing its properties
//               if (selectedItem != null) {
//                 // Create a map with attribute name and selected text
//                 Map<String, dynamic> optionData = {
//                   attribute.attributeName.toString(): selectedItem.text,
//                 };
//
//                 // Check if an option with the same attributeName already exists
//                 bool optionExists = selectSingleOption.any((option) => option.containsKey(attribute.attributeName.toString()));
//
//                 // If exists, update it; otherwise, add the new option
//                 if (optionExists) {
//                   selectSingleOption.removeWhere((option) => option.containsKey(attribute.attributeName.toString()));
//                 }
//
//                 // Add the new option to the list
//                 selectSingleOption.add(optionData);
//               } else {
//                 // Optionally handle the case where no item matches newValue
//               }
//             });
//           },
//           // validator: (value) {
//           //   if (value == null || value.isEmpty) {
//           //     return 'Please enter ${attribute.attributeName}';
//           //   }
//           //   return null;
//           // },
//         ),
//       );
//     }
//     else if (attribute.isVariant == "0" && attribute.controlType == "Textbox") {
//       // TextFormField for text input
//       return GlobalTextFormField(
//         margin: EdgeInsets.symmetric(vertical: screenHeight/80.0),
//         enabled: true,
//         keyboardType: TextInputType.text,
//         controller: textControllers[index], // Use the controller for this field
//         hintText: "",
//         labelText: "${attribute.attributeName ?? ""} * ",
//         hintStyle: ConstantTextStyle.otpHintTextStyle,
//         labelStyle: ConstantTextStyle.lableRadioText,
//         // validator: (value) {
//         //   if (value == null || value.isEmpty) {
//         //     return 'Please enter ${attribute.attributeName}';
//         //   }
//         //   return null;
//         // },
//       );
//     } else {
//       // Default case or unsupported control type
//       return Container(
//         margin: EdgeInsets.symmetric(vertical: screenHeight/80.0),
//         color: Colors.red,
//         alignment: Alignment.center,
//         child: const Text('Unsupported control type'),
//       );
//     }
//   }
}
