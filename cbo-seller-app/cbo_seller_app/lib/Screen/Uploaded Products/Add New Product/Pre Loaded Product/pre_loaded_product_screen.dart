
// ignore_for_file: library_private_types_in_public_api

import 'package:citybazaronline_seller_app/Widget/custome_text_widget.dart';
import 'package:citybazaronline_seller_app/Widget/divider_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../Models/Pre Loaded Product Models/brand_list_model.dart';
import '../../../../Models/Pre Loaded Product Models/pre_listed_products_model.dart';
import '../../../../Models/Pre Loaded Product Models/product_model_list_model.dart';
import '../../../../Services/Pre Loaded Products Api Services/brand_list_api_service.dart';
import '../../../../Services/Pre Loaded Products Api Services/pre_listed_product_api_services.dart';
import '../../../../Services/Pre Loaded Products Api Services/product_and_model_list_api_service.dart';
import '../../../../Services/Seller Forms Api Services/Seller Form Submit Api Services/step_1st_form_submit_api.dart';
import '../../../../Services/Seller Upload Product Drop Down Api Services/upload_product_drop_down_api_services.dart';
import '../../../../Utils/Constant Api Routs/constant_api_routs.dart';
import '../../../../Utils/Constant Size /constant_sizes.dart';
import '../../../../Utils/Font Style/text_styles.dart';
import '../../../../Utils/Theme/constant_colors.dart';
import '../../../../Widget/Check_boxs/check_box_widget.dart';
import '../../../../Widget/Circle Avtars/circle_avtar_title_divider.dart';
import '../../../../Widget/Custome Buttons/elevetion_button_widget.dart';
import '../../../../Widget/Date Pickers/pre_loaded_date_pic_widget.dart';
import '../../../../Widget/Drop Down /drop_down_form_widget.dart';
import '../../../../Widget/Pre Loaded Product Widgets/fixBox_title_icon.widget.dart';
import '../../../../Widget/Pre Loaded Product Widgets/searchable_brands_widget.dart';
import '../../../../Widget/Radio Button/radio_list_tile_widget.dart';
import '../../../../Widget/Scaffold Message/scaffold_message_widget.dart';
import '../../../../Widget/Text Form Fields/global_text_form_field.dart';
import '../../../../Widget/gender_container_widget.dart';
import '../../../../Widget/images/cached_images_widget.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';



class PreLoadedProductScreen extends StatefulWidget {
  const PreLoadedProductScreen({super.key});

  @override
  _PreLoadedProductScreenState createState() => _PreLoadedProductScreenState();
}

class _PreLoadedProductScreenState extends State<PreLoadedProductScreen> {
  bool isLoading = false;
  String selectedPCategoryID = '';
  String? selectedItem;
  String? brandValue;
  String? brand;
  // String selectedValue = "In Stock";
  // String selectedStatusValue = "Active";
  String defaultValue = 'Select';

  // String? productValue;
  String? productNameUni;
  String? productUniId;
  String? treeName;
  List<Map<String, dynamic>> data = [];
  // List data = [];
  Map<String, dynamic> data2 = {};


  List<TextEditingController> _priceControllers = [];
  List<TextEditingController> offerPriceControllers = [];
  List<TextEditingController> _startDateControllers = [];
  List<TextEditingController> _endDateControllers = [];
  final TextEditingController startedDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  void dispose() {
    // _priceController.dispose();
    for (var controller in _priceControllers) {controller.dispose();}
    for (var controller in offerPriceControllers) {controller.dispose();}
    for (var controller in _startDateControllers) {controller.dispose();}
    for (var controller in _endDateControllers) {controller.dispose();}
    startedDateController.dispose();
    _endDateController.dispose();
    _endDateController.dispose();
    _brandController.dispose();
    _focusNode.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _typeAheadController.dispose();
    _selectedProController.dispose();
    _selectedModelController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    fetchReelDropdownListData();
  }

  Future<void> fetchReelDropdownListData() async {
    try {
      setState(() {
        isLoading = true;
      });
      // Replace this with your actual API call
      final Map<String, dynamic>? dropdownResponse = await ProductDropDownApiService.fetchProductDropdownData(
        context: context,
        type: 'pre',
      );

      if (dropdownResponse != null) {
        final List<dynamic> dataResponseList = dropdownResponse['data']['child_cat'] ?? [];
        List<Map<String, dynamic>> dataList = dataResponseList
            .where((item) => item is Map<String, dynamic> && item['cat'].toString().endsWith('=1'))
            .map((item) => item as Map<String, dynamic>)
            .toList();

        var  catTreeData = dropdownResponse['data']['cat_tree'] ?? [];

        // final List<dynamic> dataResponseList = dropdownResponse['data']['child_cat']??[];

        // Filter out items where 'cat' is 1
        // List<dynamic> dataList = dataResponseList.where((item) {
        //   var catValue = item['cat'].toString();
        //   return catValue.endsWith('=1');
        // }).toList();

        // var catTreeData = dropdownResponse['data']['cat_tree']??[];

        parseAndPrintCategories(catTreeData);

        setState(() {
          data = dataList;
          data2 = catTreeData;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  //------brand api handler

  BrandListModel? brandListModel; // Assuming this is used elsewhere
  List<BrandListData> brandData = [];
  bool isLoading2 = false;
  List<String> brandNames = [];
  Future<void> fetchBrandListData({String? catId}) async {
    try {
      setState(() {
        isLoading2 = true;
        brandNames.clear();
        _brandController.clear();
        _selectedProController.clear();
        _selectedModelController.clear();
        collectionData.clear();
        preListedProductData?.clear();
      });

      final brandListResponse = await BrandListApiService.fetchBrandListData(
        context: context,
        catId: catId ?? '', // Pass catId if required by your API
      );

      if (brandListResponse!.status == "success") {
        // Extract brand names from data and update state
        List<String> brands = brandListResponse.data!.map((data) => data.brand!).toList();

        setState(() {
          brandNames = brands;
          isLoading2 = false;
        });
      }
      else {
        // Handle API response status other than success if needed
        setState(() {
          isLoading2 = false;
        });
      }
    } catch (e) {
      // Error handling
      setState(() {
        isLoading2 = false;
        // Handle error state if necessary
      });
    }
  }


//------- product and modal data---

  ProductAndModalListModel? productAndModalListModel;
  List<ProductAndModalData>? productAndModalData = [];
  bool isLoading3 = false;
  List<String>? productsNames = [];

  Future<void> fetchProductModalListData() async {
    try {
      setState(() {
        isLoading3 = true;
        productAndModalData?.clear();
        collectionData.clear();
        _selectedProController.clear();
        _selectedModelController.clear();
        preListedProductData?.clear();
      });

      final productModalListResponse = await fetchProductAndModelListData(catId: selectedItem, brand:brandValue);
      if (productModalListResponse != null && productModalListResponse.data != null) {
        final dataList = productModalListResponse.data!;

        setState(() {
          productAndModalData = dataList;
          isLoading3 = false;
        });
      }
      else {
        // Handle API response status other than success if needed
        setState(() {
          isLoading3 = false;
        });
      }
    } catch (e) {
      // Error handling
      setState(() {
        isLoading3 = false;
        // Handle error state if necessary
      });
    }
  }

//------- Pre listed product api ---

  PreListedProductModel? preListedProductModel;
  List<PreListedProductData>? preListedProductData = [];
  bool isLoading4 = false;
  Future<void> fetchPreListedData() async {
    try {
      setState(() {
        isLoading4 = true;
        preListedProductData?.clear();
        collectionData.clear();
      });

      final preListedDataResponse = await fetchPreListedProductsData(catId: selectedItem, brand:brandValue,productIds: productUniId);
      if (preListedDataResponse != null && preListedDataResponse.data != null) {
        final preProductsDataList = preListedDataResponse.data!;

        setState(() {
          preListedProductData = preProductsDataList;
          isLoading4 = false;
          _priceControllers = List.generate(preListedProductData!.length, (index) => TextEditingController(text: preListedProductData![index].price ?? ''),);
          offerPriceControllers = List.generate(preListedProductData!.length, (index) => TextEditingController(text: preListedProductData![index].offerPrice ?? ''),);
          // _startDateControllers = List.generate(preListedProductData!.length, (index) => TextEditingController(text: preListedProductData![index].offerStartDate ?? getCurrentDate() ?? ''),);
          _startDateControllers = List.generate(preListedProductData!.length, (index) => TextEditingController(text: preListedProductData![index].offerStartDate ??''),);
          _endDateControllers = List.generate(preListedProductData!.length, (index) => TextEditingController(text: preListedProductData![index].offerEndDate ?? ''),);
        });
      }
      else {
        // Handle API response status other than success if needed
        setState(() {
          isLoading4 = false;
        });
      }
    } catch (e) {
      // Error handling
      setState(() {
        isLoading4 = false;
        // Handle error state if necessary
      });
    }
  }


  void parseAndPrintCategories(Map<String, dynamic> categories) {
    categories.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        value.forEach((subKey, subValue) {
          if (subValue is Map<String, dynamic>) {
          } else if (subValue is List) {
          } else {}
        });
      } else if (value is List) {
      } else {}
    });
  }


  Widget buildCategoryTile(String categoryName, dynamic subCategories) {

    var sh = MediaQuery.of(context).size.height;
    var sw = MediaQuery.of(context).size.width;
    if (subCategories is Map<String, dynamic>) {
      return Container(
        decoration: BoxDecoration(border: Border.all(color: ConstantColor.primaryGreyColor),
            borderRadius: BorderRadius.circular(8.0)),
        margin: EdgeInsets.symmetric(horizontal: sw/40.0,vertical: sh/100.0),
        child: ExpansionTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
          tilePadding: EdgeInsets.symmetric(horizontal: sw/30.0),
          childrenPadding: EdgeInsets.symmetric(horizontal: sw/30.0),
          title: customeText(text: categoryName,style: ConstantTextStyle.cardbottumText,),
          children: [
            ...subCategories.entries.map<Widget>((entry) {
              var mySubKeys = entry.key.split('=');
              if (mySubKeys.length > 1) {
                return buildCategoryTile(mySubKeys[1], entry.value);
              } else {
                return GestureDetector(
                  onTap: () async {
                    setState(() {
                      selectedItem = entry.value.split('=')[0]??"";
                      treeName = '$categoryName >> ${entry.value.split('=')[1].trim()}';
                    });
                    await fetchBrandListData(catId: selectedItem);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: sw/14.0, vertical: sh/100.0),
                    alignment: Alignment.topLeft,
                    child: customeText(
                      text: '${entry.value.split('=')[1]} >> ',
                      textAlign: TextAlign.start,
                      style: ConstantTextStyle.cardbottumText,
                    ),
                  ),
                );
              }
            }),
          ],
        ),
      );
    }
    else if (subCategories is List) {
      return Container(
        decoration: BoxDecoration(border: Border.all(color: ConstantColor.primaryGreyColor),
            borderRadius: BorderRadius.circular(8.0)),
        margin: EdgeInsets.symmetric(horizontal: sw/40.0,vertical: sh/100.0),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: sw/30.0),
          childrenPadding: EdgeInsets.symmetric(horizontal: sw/30.0),
          title: Text(categoryName,style: ConstantTextStyle.cardbottumText,),
          children: [
            ...subCategories.map((item) {
              var mySub2Keys = item.split('=')[1];
              return
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      selectedItem = item.split('=')[0]??"";
                      treeName = '$categoryName >> $mySub2Keys';
                    });
                    await fetchBrandListData(catId: selectedItem);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: sw/14.0, vertical: sh/100.0),
                    alignment: Alignment.topLeft,
                    child: customeText(
                      text: '$mySub2Keys >>',
                      textAlign: TextAlign.start,
                      style: ConstantTextStyle.cardbottumText,
                    ),
                  ),
                );
            }),
          ],
        ),
      );
    }
    else {
      return ListTile(
        onTap: (){
          setState(() {
            selectedItem = subCategories.toString()??"";
            treeName = categoryName;
          });
        },
        contentPadding: EdgeInsets.zero,
        dense: true,
        title: customeText(text: categoryName,style: ConstantTextStyle.cardbottumText,),
        subtitle: customeText(text: subCategories.toString(),style: ConstantTextStyle.cardbottumText,),
      );
    }
  }



  Map<String, dynamic> parseNestedData(String dataString) {
    Map<String, dynamic> parsedData = {};
    return parsedData;
  }

  final _formKey = GlobalKey<FormState>();



  void _onDateSelected(DateTime selectedDate) {
    setState(() {startedDateController.text = selectedDate.toString();});
  }

  void _onEndDateSelected(DateTime selectedDate) {
    setState(() {_endDateController.text = selectedDate.toString();
    });
  }

  // Function to get current date in the desired format
  String getCurrentDate() {
    var now = DateTime.now();
    return DateFormat('dd MMMM yyyy').format(now);}

  List <dynamic> inStock = ["In Stock", "Out of Stock"];
  String selectedValue = "1";


  String selectedOption = '';
  List<Map<String, dynamic>> collectionData = [];


  void _handleSubmit() {
    List<Map<String, dynamic>> selectedProducts = [];
    final DateFormat dateFormat = DateFormat('dd-MM-yyyy'); // Define the date format

    for (var product in preListedProductData!) {
      if (product.selectedCheck == true) {
        var selectedValue = product.isAvailable;
        var selectedOption = product.isActive;
        var productModal = product.model ?? "";
        var productId = product.productId ?? "";
        var productImg = product.imageFile ?? "";
        var productQty = product.stockQuantity.toString() ?? '';
        // Convert offerPrice and price to numeric types (assuming they are double)
        var offerPrice = double.tryParse(product.offerPrice ?? "0") ?? 0.0;
        var price = double.tryParse(product.price ?? "0") ?? 0.0;

        // Ensure offer price is not greater than regular price
        if (offerPrice > price) {
          LoadingScaffoldMessage.showSnackbar(
            context, "Offer price cannot be greater than regular price for $productModal.",
            ConstantColor.primaryMainColor,
            const Duration(seconds: 2),
          );
          continue; // Skip this product and continue with the next one
        }

        // Format the start and end dates
        DateTime endDate = DateTime.tryParse(_endDateController.text) ?? DateTime.now();
        DateTime startDate = DateTime.tryParse(startedDateController.text) ?? DateTime.now();
        String? formattedEndDate = _endDateController.text.isNotEmpty
            ? dateFormat.format(DateTime.parse(_endDateController.text))
            : '';

        String? formattedStartDate = startedDateController.text.isNotEmpty
            ? dateFormat.format(DateTime.parse(startedDateController.text))
            : '';
        // String formattedEndDate = dateFormat.format(endDate);
        // String formattedStartDate = dateFormat.format(startDate);

        var updatedProduct = {
          "image_file": productImg,
          "inStock": selectedValue,
          "model": productModal,
          "offer_end_date": formattedEndDate ?? _endDateController.text,
          "offer_price": offerPrice.toString(),
          "offer_start_date": formattedStartDate ?? startedDateController.text,
          "pid": productId,
          "price": price.toString(),
          "pstatus": selectedOption,
          "quantity": productQty,
        };

        selectedProducts.add(updatedProduct);
      }
    }
    if (_formKey.currentState!.validate()) {
      if (selectedProducts == [] || selectedProducts.isEmpty){
        LoadingScaffoldMessage.showSnackbar(
          context, "Please select at least one product item.",
          ConstantColor.primaryMainColor,
          const Duration(seconds: 2),
        );
      }else{
        fetchSellerRegistrationBodyApi(
          context: context,
          baseUrl: '${ConstantUrls.baseUriApi}${ConstantUrls.getBulkProductUploadEndPoint}',
          body: {"product": selectedProducts},
          onSuccess: () => Navigator.pushNamed(context, '/uploadedProductScreen'),
        );
      }
    }
  }


  final TextEditingController _typeAheadController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _selectedProController = TextEditingController();
  final TextEditingController _selectedModelController = TextEditingController();
  final FocusNode _focusNode = FocusNode(); // Define a FocusNode
  final FocusNode _focusNode1 = FocusNode(); // Define a FocusNode
  final FocusNode _focusNode2 = FocusNode(); // Define a FocusNode
  final FocusNode _focusNode3 = FocusNode(); // Define a FocusNode


  //------select product ---
  Future<void> showSearchableBottomSheet({
    required BuildContext context,
    required List<ProductAndModalData> productList,
    required Function(String?) onProductSelected,
    required String title,
    required String hintText,
    required String Function(ProductAndModalData) getValue,
  }) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 0.0,
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.symmetric(vertical: screenHeight / 60.0, horizontal: screenWidth / 30.0),
          backgroundColor: Colors.white,
          title: customeText(text: title, style: ConstantTextStyle.cardbottumText),
          content: Container(
            padding: EdgeInsets.only(bottom: screenHeight / 5.0, left: screenWidth / 40.0, right: screenWidth / 40.0),
            child: TypeAheadFormField<ProductAndModalData>(
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
                  hintText: hintText,
                  labelStyle: ConstantTextStyle.lableRadioText,
                  hintStyle: ConstantTextStyle.lableRadioText,
                ),
              ),
              suggestionsCallback: (pattern) {
                return productList.where((product) {
                  final value = getValue(product);
                  return value != null && value.toLowerCase().contains(pattern.toLowerCase());
                }).toList();
              },
              itemBuilder: (context, ProductAndModalData product) {
                final value = getValue(product);
                return ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    // await fetchPreListedData();
                    onProductSelected(product.productId);
                    // productUniId = product.productId;
                    _selectedProController.text = product.productName??"";
                    _selectedModelController.text = product.model??"";
                  },
                  dense: true,
                  visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                  contentPadding: EdgeInsets.symmetric(horizontal: screenWidth / 40.0),
                  title: customeText(text: value ?? '', style: ConstantTextStyle.dropDownPrimeText),
                  subtitle: dividerWidget(),
                );
              },
              onSuggestionSelected: (ProductAndModalData product) {
                Navigator.of(context).pop();
                onProductSelected(product.productId);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select an option';
                }
                return null;
              },
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ConstantColor.primaryBackgroundMainColor,
      appBar: AppBar(
        backgroundColor: ConstantColor.loginWithOtpButtonColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), color: ConstantColor.primaryBackgroundMainColor,
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title:  customeText(
          text: "Add New Product",
          style: ConstantTextStyle.landingScreenAppbarText,
        ),
      ),
      body:Form(
        key: _formKey,
        child: Skeletonizer(
          enabled: isLoading,
          child:
          // ListView(
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth/30,vertical: screenHeight/60),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[

                    // constantHeight(context, 40.0),

                    Container(
                      // margin: margin,
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: ConstantColor.primaryMainColor ?? ConstantColor.transparent1,
                            width: screenWidth/100,
                          ),
                        ),
                      ),
                      child: TypeAheadFormField<Map<String, dynamic>>(
                        textFieldConfiguration: TextFieldConfiguration(
                          focusNode: _focusNode, // Attach the FocusNode
                          controller: _typeAheadController,
                          style: ConstantTextStyle.allHomeScreenAvatarText,
                          decoration:  InputDecoration(
                            // contentPadding: EdgeInsets.symmetric(horizontal: screenWidth/40.0),
                            filled: true,
                            fillColor: ConstantColor.primaryBackgroundMainColor,
                            suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: ConstantColor.primaryMainColor),
                            // borderRadius: BorderRadius.circular(10.0),
                            disabledBorder: const OutlineInputBorder(borderSide: BorderSide(
                              color: ConstantColor.primaryGreyColor, width: 0.5,),
                              borderRadius: BorderRadius.zero,
                            ),
                            enabledBorder:  const OutlineInputBorder(
                              borderSide: BorderSide(color: ConstantColor.primaryGreyColor, width: 0.5,),
                              borderRadius: BorderRadius.zero,
                            ),
                            focusedBorder:  const OutlineInputBorder(
                              borderSide: BorderSide(color: ConstantColor.textFieldColor),
                              borderRadius: BorderRadius.zero,
                            ),
                            // border: OutlineInputBorder(),
                            hintText: 'Select Category',
                            labelStyle: ConstantTextStyle.lableRadioText,
                            hintStyle: ConstantTextStyle.lableRadioText,
                          ),
                        ),
                        suggestionsCallback: (pattern) {
                          return data.where((item) {
                            List<String> parts = [
                              item['cat']??"",
                              (item['pcat3'] != null && item['pcat3'].toString().isNotEmpty) ? " ( ${item['pcat3']}  >> " : ' ( ',
                              (item['pcat2'] != null && item['pcat2'].toString().isNotEmpty) ? "${item['pcat2']} >> " : '',
                              (item['pcat1'] != null && item['pcat1'].toString().isNotEmpty) ? "${item['pcat1']} >> " : '',
                              (item['cat'] != null && item['cat'].toString().isNotEmpty) ? "${item['cat']} ) " : ' ) ',
                            ];
                            String displayText = parts.where((part) => part.isNotEmpty).join('');
                            displayText = displayText.replaceAll(RegExp(r'[\d=]'), '');
                            String categoryId = item['category_id'].toString() ?? '';
                            return displayText.toLowerCase().contains(pattern.toLowerCase());
                          }).toList();
                        },
                        itemBuilder: (context, item) {
                          List<String> parts = [
                            item['cat']??"",
                            (item['pcat3'] != null && item['pcat3'].toString().isNotEmpty) ? " ( ${item['pcat3']}  >> " : ' ( ',
                            (item['pcat2'] != null && item['pcat2'].toString().isNotEmpty) ? "${item['pcat2']} >> " : '',
                            (item['pcat1'] != null && item['pcat1'].toString().isNotEmpty) ? "${item['pcat1']} >> " : '',
                            (item['cat'] != null && item['cat'].toString().isNotEmpty) ? "${item['cat']} ) " : ' ) ',
                          ];

                          String displayText = parts.where((part) => part.isNotEmpty).join('');
                          displayText = displayText.replaceAll(RegExp(r'[\d=]'), '');
                          String categoryId = item['category_id'].toString() ?? '';
                          return ListTile(
                            dense: true,
                            visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                            contentPadding: EdgeInsets.symmetric(horizontal: screenWidth/40.0),
                            onTap: () async {
                              setState(() {
                                treeName = parts.where((part) => part.isNotEmpty).join('');
                                treeName = treeName.toString().replaceAll(RegExp(r'[\d=]'), '');
                                _typeAheadController.text = treeName.toString().replaceAll(RegExp(r'[\d=]'), '');
                              });
                              _focusNode.unfocus(); // Close the suggestion list by unfocusing
                              await fetchBrandListData(catId: categoryId);
                            },
                            title:customeText(text: displayText, style: ConstantTextStyle.dropDownPrimeText),
                            subtitle: dividerWidget(),
                          );
                        },

                        onSuggestionSelected: (item) {
                          setState(() {
                            _focusNode.unfocus(); // Close the suggestion list by unfocusing
                            selectedItem = item['category_id'];
                          });
                          _typeAheadController.text = item['cat'];
                        },
                      ),
                    ),

                    constantHeight(context, 40.0),


                    (treeName.toString().isEmpty || treeName == null) ? Container():
                    customeText(text: "Category : $treeName\n",style: ConstantTextStyle.checkboxTextStyle1),


                    Visibility(
                      visible: brandNames.isEmpty || brandNames.toString().isEmpty,
                      child: Skeletonizer(
                        enabled: isLoading2,
                        child: customeText(
                          text: 'Brand of this category is not available. Please select another category to continue.\n',
                          style: ConstantTextStyle.locationText,
                        ),
                      ),
                    ),



                    (treeName.toString().isEmpty || treeName == null) ?
                    Column(
                      children: data2.entries.map<Widget>((entry) {
                        List<String> parts = entry.key.split('=');
                        String resultKey = parts[1].trim();
                        return buildCategoryTile(resultKey, entry.value);
                      }).toList(),
                    ) : Container(),


                    (brandNames.isEmpty || brandNames.toString().isEmpty)?
                    const SizedBox():
                    buildTypeAheadWithLoaderForBrands(
                      context: context,
                      isLoading: isLoading2,
                      controller: _brandController,
                      focusNode: _focusNode1,
                      hintText: 'Select Brand *',
                      suggestions: brandNames,
                      onSuggestionSelected: (brand) async {
                        setState(() {
                          _brandController.text = brand;
                          brandValue = brand;
                        });
                        await fetchProductModalListData();
                      },
                    ),

                    // Skeletonizer(
                    //   enabled: isLoading2,
                    //   child: dropDownForm(
                    //     context: context,
                    //     colorBorder: ConstantColor.primaryMainColor,
                    //     headText: 'Select Brand * ',
                    //     value: brand,
                    //     items: brandNames.map((brand) {
                    //       return DropdownMenuItem<String>(
                    //         value: brand,
                    //         child: customeText(text: brand, style: ConstantTextStyle.dropDownPrimeText,),
                    //       );
                    //     }).toList(),
                    //     onChanged: (newValue) async {
                    //       setState(() {
                    //         brandValue = newValue;
                    //       });
                    //       await fetchProductModalListData();
                    //     },
                    //   ),
                    // ),




                    // Skeletonizer(
                    //   enabled: isLoading3,
                    //   child: Container(
                    //     // margin: margin,
                    //     decoration: BoxDecoration(
                    //       border: Border(
                    //         left: BorderSide(
                    //           color: ConstantColor.primaryMainColor ?? ConstantColor.transparent1,
                    //           width: screenWidth/100,
                    //         ),
                    //       ),
                    //     ),
                    //     child: TypeAheadFormField<ProductAndModalData>(
                    //       textFieldConfiguration: TextFieldConfiguration(
                    //         focusNode: _focusNode3, // Attach the FocusNode
                    //         controller: _selectedModelController,
                    //         style: ConstantTextStyle.allHomeScreenAvatarText,
                    //         decoration:  InputDecoration(
                    //           // contentPadding: EdgeInsets.symmetric(horizontal: screenWidth/40.0),
                    //           filled: true,
                    //           fillColor: ConstantColor.primaryBackgroundMainColor,
                    //           suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: ConstantColor.primaryMainColor),
                    //           // borderRadius: BorderRadius.circular(10.0),
                    //           disabledBorder: const OutlineInputBorder(borderSide: BorderSide(
                    //             color: ConstantColor.primaryGreyColor, width: 0.5,),
                    //             borderRadius: BorderRadius.zero,
                    //           ),
                    //           enabledBorder:  const OutlineInputBorder(
                    //             borderSide: BorderSide(color: ConstantColor.primaryGreyColor, width: 0.5,),
                    //             borderRadius: BorderRadius.zero,
                    //           ),
                    //           focusedBorder:  const OutlineInputBorder(
                    //             borderSide: BorderSide(color: ConstantColor.textFieldColor),
                    //             borderRadius: BorderRadius.zero,
                    //           ),
                    //           // border: OutlineInputBorder(),
                    //           hintText: 'Select Modal *',
                    //           labelStyle: ConstantTextStyle.lableRadioText,
                    //           hintStyle: ConstantTextStyle.lableRadioText,
                    //         ),
                    //       ),
                    //       suggestionsCallback: (pattern) async {
                    //         // Filter products based on the search pattern
                    //         return productAndModalData!.where((product) {
                    //           return product.productName != null &&
                    //               product.productName!.toLowerCase().contains(pattern.toLowerCase());
                    //         }).toList();
                    //       },
                    //       itemBuilder: (context, ProductAndModalData product) {
                    //         return ListTile(
                    //           dense: true,
                    //           visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                    //           contentPadding: EdgeInsets.symmetric(horizontal: screenWidth/40.0),
                    //           onTap: () async {
                    //             setState(() {
                    //               productUniId = product.productId;
                    //             });
                    //             _focusNode3.unfocus();
                    //             await fetchPreListedData();
                    //           },
                    //           title:customeText(text: product.model??"", style: ConstantTextStyle.dropDownPrimeText),
                    //           subtitle: dividerWidget(),
                    //         );
                    //       },
                    //       onSuggestionSelected: (ProductAndModalData product) async {
                    //         setState(() => productUniId = product.productId);
                    //         await fetchPreListedData();
                    //       },
                    //     ),
                    //   ),
                    // ),

                    constantHeight(context, 30.0),

                    (productAndModalData == null || productAndModalData!.isEmpty || productAndModalData!.toString().isEmpty)?
                    const SizedBox():

                    Skeletonizer(
                      enabled: isLoading3,
                      child: fixBoxTextIconWidget (
                          context: context,
                          onTap: ()async  {
                            await showSearchableBottomSheet(
                              context: context,
                              productList: productAndModalData??[], // List<ProductAndModalData>
                              onProductSelected: (productId) async {
                                setState(() {productUniId = productId;});
                                await fetchPreListedData();
                              },
                              title: 'Select Product *',
                              hintText: 'Select Product',
                              getValue: (product) => product.productName??"",
                            );
                            },
                          title: _selectedProController.text.toString().isEmpty ?"Select product * ": _selectedProController.text.toString(),
                          icon: Icons.keyboard_arrow_down_rounded),
                    ),




                    // GlobalTextFormField(
                    //   enabled: false,
                    //   margin: EdgeInsets.symmetric(vertical: screenHeight/80.0),
                    //   controller: _selectedProController,
                    //   onTap: () async  {
                    //     await showSearchableBottomSheet(
                    //       context,
                    //       productAndModalData??[],
                    //           (selectedProductId) async {
                    //         setState(() {
                    //           productUniId = selectedProductId;
                    //         });
                    //         // Fetch and update data based on selected product
                    //         await fetchPreListedData();
                    //       },
                    //     );
                    //     // showCupertinoModalPopup(
                    //     //   context: context,
                    //     //   builder: (_) => PreLoadDatePickerWidget(
                    //     //     onChanged: (selectedDate) {
                    //     //       endDateController.text = selectedDate.toString();
                    //     //       String formattedDate = DateFormat('dd MMMM yyyy').format(selectedDate);
                    //     //       endDateController.text = formattedDate;
                    //     //       _onEndDateSelected(selectedDate);
                    //     //     },
                    //     //     // onChanged: _onEndDateSelected,
                    //     //   ),
                    //     // );
                    //   },
                    //   keyboardType: TextInputType.datetime,
                    //   labelText: "Select Product * ",
                    //   suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,color: ConstantColor.primaryMainColor,),
                    //   hintText: _endDateController.text.isNotEmpty ? _endDateController.text : "",
                    //   labelStyle: ConstantTextStyle.lableRadioText,
                    //   onChanged: (value) {
                    //     // preLoadProduct.offerEndDate = value;
                    //   },
                    // ),


                    // Skeletonizer(
                    //   enabled: isLoading3,
                    //   child: dropDownForm(
                    //     context: context,
                    //     colorBorder: ConstantColor.primaryMainColor,
                    //     headText: 'Select Product * ',
                    //     value: productNameUni,
                    //     items: productAndModalData!.map((product) {
                    //       return DropdownMenuItem<String>(
                    //         value: product.productId,
                    //         child: customeText(text: product.productName??"", style: ConstantTextStyle.dropDownPrimeText,),
                    //       );
                    //     }).toList(),
                    //     onChanged: (newValue) async {
                    //       setState(() {
                    //         productUniId = newValue;
                    //       });
                    //       await fetchPreListedData();
                    //     },
                    //   ),
                    // ),

                    // Skeletonizer(
                    //   enabled: isLoading3,
                    //   child: Container(
                    //     // margin: margin,
                    //     decoration: BoxDecoration(
                    //       border: Border(
                    //         left: BorderSide(
                    //           color: ConstantColor.primaryMainColor ?? ConstantColor.transparent1,
                    //           width: screenWidth/100,
                    //         ),
                    //       ),
                    //     ),
                    //     child: TypeAheadFormField<ProductAndModalData>(
                    //       textFieldConfiguration: TextFieldConfiguration(
                    //         focusNode: _focusNode2, // Attach the FocusNode
                    //         controller: _selectedProController,
                    //         style: ConstantTextStyle.allHomeScreenAvatarText,
                    //         decoration:  InputDecoration(
                    //           // contentPadding: EdgeInsets.symmetric(horizontal: screenWidth/40.0),
                    //           filled: true,
                    //           fillColor: ConstantColor.primaryBackgroundMainColor,
                    //           suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: ConstantColor.primaryMainColor),
                    //           // borderRadius: BorderRadius.circular(10.0),
                    //           disabledBorder: const OutlineInputBorder(borderSide: BorderSide(
                    //             color: ConstantColor.primaryGreyColor, width: 0.5,),
                    //             borderRadius: BorderRadius.zero,
                    //           ),
                    //           enabledBorder:  const OutlineInputBorder(
                    //             borderSide: BorderSide(color: ConstantColor.primaryGreyColor, width: 0.5,),
                    //             borderRadius: BorderRadius.zero,
                    //           ),
                    //           focusedBorder:  const OutlineInputBorder(
                    //             borderSide: BorderSide(color: ConstantColor.textFieldColor),
                    //             borderRadius: BorderRadius.zero,
                    //           ),
                    //           // border: OutlineInputBorder(),
                    //           hintText: 'Select Product *',
                    //           labelStyle: ConstantTextStyle.lableRadioText,
                    //           hintStyle: ConstantTextStyle.lableRadioText,
                    //         ),
                    //       ),
                    //       suggestionsCallback: (pattern) async {
                    //         // Filter products based on the search pattern
                    //         return productAndModalData!.where((product) {
                    //           return product.productName != null &&
                    //               product.productName!.toLowerCase().contains(pattern.toLowerCase());
                    //         }).toList();
                    //       },
                    //       itemBuilder: (context, ProductAndModalData product) {
                    //         return ListTile(
                    //           dense: true,
                    //           visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                    //           contentPadding: EdgeInsets.symmetric(horizontal: screenWidth/40.0),
                    //           onTap: () async {
                    //             setState(() {
                    //               productUniId = product.productId;
                    //             });
                    //             _focusNode2.unfocus();
                    //             await fetchPreListedData();
                    //           },
                    //           title:customeText(text: product.productName??"", style: ConstantTextStyle.dropDownPrimeText),
                    //           subtitle: dividerWidget(),
                    //         );
                    //       },
                    //       onSuggestionSelected: (ProductAndModalData product) async {
                    //         setState(() => productUniId = product.productId);
                    //         await fetchPreListedData();
                    //       },
                    //       validator: (value) {
                    //         if (_selectedProController == null || _selectedProController.text == null || _selectedProController.text!.isEmpty) {
                    //           return 'Please select a product';
                    //         }
                    //         return null;
                    //       },
                    //     ),
                    //   ),
                    // ),

                    (productAndModalData == null || productAndModalData!.isEmpty || productAndModalData!.toString().isEmpty)?
                    const SizedBox(): Padding(padding: EdgeInsets.symmetric(vertical: screenHeight / 30.0,horizontal: screenWidth/30.0),
                      child: circleAvtarWithDivider(
                        context: context,
                        circleText: "OR".toUpperCase(),
                        backCircleRadius: 16.0,
                        frontCircleRadius: 14.0,
                      ),
                    ),
                    (productAndModalData == null || productAndModalData!.isEmpty || productAndModalData!.toString().isEmpty)?
                    const SizedBox():
                    Skeletonizer(
                      enabled: isLoading3,
                      child: fixBoxTextIconWidget (
                          context: context,
                          onTap: ()async  {
                            await showSearchableBottomSheet(
                              context: context,
                              productList: productAndModalData??[], // List<ProductAndModalData>
                              onProductSelected: (productId) async {
                                setState(() {productUniId = productId;});
                                 await fetchPreListedData();
                              },
                              title: 'Select Modal *',
                              hintText: 'Select Modal',
                              getValue: (product) => product.model??"",
                            );
                          },
                          title: _selectedModelController.text.toString().isEmpty ?"Select Modal * ": _selectedModelController.text.toString(),
                          icon: Icons.keyboard_arrow_down_rounded),

                      // dropDownForm(
                      //   context: context,
                      //   colorBorder: ConstantColor.primaryMainColor,
                      //   headText: 'Select Modal * ',
                      //   value: productNameUni,
                      //   items: productAndModalData!.map((product) {
                      //     return DropdownMenuItem<String>(
                      //       value: product.productId,
                      //       child: customeText(text: product.model??"", style: ConstantTextStyle.dropDownPrimeText,),
                      //     );
                      //   }).toList(),
                      //   onChanged: (newValue) async {
                      //     setState(() {
                      //       productUniId = newValue;
                      //     });
                      //     await fetchPreListedData();
                      //   },
                      // ),
                    ),


                    constantHeight(context, 80.0),

                     Skeletonizer(
                      enabled: isLoading4,
                      child: AnimationLimiter(
                        child:ListView.builder(
                          // controller: _scrollController,
                          physics: const ScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: preListedProductData!.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            var preLoadProduct = preListedProductData![index];
                            selectedValue = preLoadProduct.isAvailable.toString() == "1" ? "In Stock" : "Out of Stock";
                            selectedOption = preLoadProduct.isActive.toString();
                            var productImg = preLoadProduct.imageFile.toString()??"";
                            TextEditingController priceController = _priceControllers[index];
                            TextEditingController offerPriceController = offerPriceControllers[index];
                            TextEditingController startDateController = _startDateControllers[index];
                            TextEditingController endDateController = _endDateControllers[index];

                            return AnimationConfiguration.staggeredGrid(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              columnCount: 2,
                              child: ScaleAnimation(
                                child: FadeInAnimation(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: screenHeight/60.0),
                                    padding: EdgeInsets.symmetric(vertical: screenHeight/60.0,horizontal: screenWidth/40.0),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: ConstantColor.primaryGreyColor),
                                        borderRadius: BorderRadius.circular(8.0)
                                    ),

                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            customeCheckbox(
                                              checkColor: ConstantColor.primaryMainColor,
                                              activeColor: ConstantColor.calendarBGHeadColor,
                                              value: preLoadProduct.selectedCheck ?? false,
                                              onChanged: (bool? value) {setState(() {preLoadProduct.selectedCheck = value ?? false;});}),

                                            customeText(text: "Product Image :- ",style: ConstantTextStyle.topCategoryText2),

                                            cachedImageWidget(
                                              context: context,
                                              width: screenWidth/4.0,
                                              height: screenHeight /16.0,
                                              imageFile: productImg,
                                              assetImageFit: BoxFit.contain,
                                            ),
                                          ],
                                        ),

                                        constantHeight(context, 80.0),
                                        customeText(text: "\t\t\t Model :-  ${preLoadProduct.model??""}",style: ConstantTextStyle.topCategoryText2),
                                        constantHeight(context, 80.0),

                                        GlobalTextFormField(
                                          enabled: true,
                                          margin: EdgeInsets.symmetric(vertical: screenHeight/80.0),
                                          controller: priceController,
                                          keyboardType: TextInputType.number,
                                          hintText: "",
                                          labelText: "Price *",
                                          hintStyle: ConstantTextStyle.otpHintTextStyle,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {return 'Please enter price it is required';}
                                            return null;
                                          },
                                          labelStyle: ConstantTextStyle.lableRadioText,
                                            onChanged: (value) {
                                              setState(() {
                                                preLoadProduct.price = value;
                                              });
                                            }
                                        ),

                                        GlobalTextFormField(
                                          enabled: true,
                                          margin: EdgeInsets.symmetric(vertical: screenHeight/80.0),
                                          controller: offerPriceController,
                                          keyboardType: TextInputType.number,
                                          hintText: "",
                                          labelText: "Offer Price ",
                                          hintStyle: ConstantTextStyle.otpHintTextStyle,
                                          labelStyle: ConstantTextStyle.lableRadioText,
                                          onChanged: (value) {
                                            setState(() {
                                              preLoadProduct.offerPrice = value;
                                            });
                                          }
                                        ),

                                        GlobalTextFormField(
                                          enabled: false,
                                          margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
                                          controller: startDateController,
                                          onTap: () {
                                            showCupertinoModalPopup(
                                              context: context,
                                              builder: (_) => PreLoadDatePickerWidget(
                                                onChanged: (selectedDate) {
                                                  startDateController.text = selectedDate.toString();
                                                  String formattedDate = DateFormat('dd MMMM yyyy').format(selectedDate);
                                                  startDateController.text = formattedDate;
                                                  _onDateSelected(selectedDate);
                                                },
                                              ),
                                            );
                                          },
                                          keyboardType: TextInputType.datetime,
                                          labelText: "Offer Start Date",
                                          suffixIcon: const Icon(Icons.date_range_outlined, color: ConstantColor.landingScreenSubHaddingColor),
                                          hintText:startedDateController.text.isNotEmpty ? startedDateController.text : "",
                                          labelStyle: ConstantTextStyle.lableRadioText,
                                          onChanged: (value) {
                                            setState(() {
                                              preLoadProduct.offerStartDate = value;
                                            });
                                          },
                                        ),

                                        GlobalTextFormField(enabled: false,
                                          margin: EdgeInsets.symmetric(vertical: screenHeight/80.0),
                                          controller: endDateController,
                                          onTap: (){
                                            showCupertinoModalPopup(
                                              context: context,
                                              builder: (_) => PreLoadDatePickerWidget(
                                                onChanged: (selectedDate) {
                                                  endDateController.text = selectedDate.toString();
                                                  String formattedDate = DateFormat('dd MMMM yyyy').format(selectedDate);
                                                  endDateController.text = formattedDate;
                                                  _onEndDateSelected(selectedDate);
                                                },
                                                // onChanged: _onEndDateSelected,
                                              ),
                                            );
                                          },
                                          keyboardType: TextInputType.datetime,
                                          labelText: "Offer End Date  ",
                                          suffixIcon: const Icon(Icons.date_range_outlined,color: ConstantColor.landingScreenSubHaddingColor,),
                                          hintText: _endDateController.text.isNotEmpty ? _endDateController.text : "",
                                          labelStyle: ConstantTextStyle.lableRadioText,
                                          onChanged: (value) {
                                            preLoadProduct.offerEndDate = value;
                                          },
                                        ),

                                        constantHeight(context, 80.0),
                                        dropDownForm(
                                          context: context,
                                          colorBorder: ConstantColor.primaryMainColor,
                                          headText: 'In Stock *',
                                          value: selectedValue,
                                          items: inStock.map((item) {
                                            return DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(item, style: ConstantTextStyle.otpHintTextStyle,),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            setState(() {
                                            var value =  newValue == "In Stock" ? "1" : "0";
                                              preLoadProduct.isAvailable = value.toString();
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
                                                child:
                                                customRadioButtonTitle(
                                                  title: customeText(text: "Active",style: ConstantTextStyle.passwordScreenLineTexStyle,),
                                                  value: "1",
                                                  groupValue: selectedOption,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedOption = value.toString();
                                                      preLoadProduct.isActive = value.toString();
                                                    });
                                                  },
                                                ),
                                              ),
                                              Flexible(
                                                child:
                                                customRadioButtonTitle(
                                                  title: customeText(text: "Deactive",style: ConstantTextStyle.passwordScreenLineTexStyle,),
                                                  value: "0",
                                                  groupValue: selectedOption,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedOption = value.toString();
                                                      preLoadProduct.isActive = value.toString();
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),

                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    constantHeight(context, 30.0),
                  ]

              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton:
      (preListedProductData == null || preListedProductData!.isEmpty || preListedProductData!.toString().isEmpty)?
      const SizedBox():
      customButton(
        toolTipMessage: "submit.",
        text: 'Submit \u2794',
        elevation: 0.0,
        borderRadius: BorderRadius.circular(20.0),
        backgroundColor: ConstantColor.primaryMainColor,
        textStyleButton: ConstantTextStyle.landingScreenAppbarText,
        onPressed: isLoading ? null : _handleSubmit,
      ),
    );
  }
}

