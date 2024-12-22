
// ignore_for_file: library_private_types_in_public_api

import 'package:citybazaronline_seller_app/Widget/custome_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../Layouts/custom_four_step_add_product_layout.dart';
import '../../../../Models/Complete Order Model/cat_attribute_model.dart';
import '../../../../Services/Custom Product Api Services/cat_attribute_api_service.dart';
import '../../../../Services/Seller Upload Product Drop Down Api Services/upload_product_drop_down_api_services.dart';
import '../../../../Utils/Constant Size /constant_sizes.dart';
import '../../../../Utils/Font Style/text_styles.dart';
import '../../../../Utils/Theme/constant_colors.dart';
import '../../../../Widget/Loaders/Loader_title_widget.dart';
import '../../../../Widget/divider_widget.dart';
import 'Single Page Screen/single_page_screen.dart';

class CustomProductScreen extends StatefulWidget {
  const CustomProductScreen({super.key});

  @override
  _CustomProductScreenState createState() => _CustomProductScreenState();
}

class _CustomProductScreenState extends State<CustomProductScreen> {
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




  @override
  void dispose() {
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
        // catAttributesData.clear();
      });
      // Replace this with your actual API call
      final Map<String, dynamic>? dropdownResponse = await ProductDropDownApiService.fetchProductDropdownData(
        context: context,
        type: 'new',
      );

      if (dropdownResponse != null) {
        final List<dynamic> dataResponseList = dropdownResponse['data']['child_cat']??[];
        // Filter out items where 'cat' is 1
        List<Map<String, dynamic>> dataList = dataResponseList
            .where((item) => item is Map<String, dynamic> && item['cat'].toString().endsWith('=0'))
            .map((item) => item as Map<String, dynamic>)
            .toList();
        // List<dynamic> dataList = dataResponseList.where((item) {
        //   var catValue = item['cat'].toString();
        //   return !catValue.endsWith('=1');
        // }).toList();
        var catTreeData = dropdownResponse['data']['cat_tree']??[];

        parseAndPrintCategories(catTreeData);

        setState(() {
          data = dataList;
          data2 = catTreeData;
          isLoading = false;
        });
      }
      else {
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

  var pageValue = '';

  CatAttributesModel? catAttributesModel; 
  List<CatAttributesData> catAttributesData = [];
  // final List<Map<String, dynamic>> selectSingleOption = [];

  //----step---2
  // final TextEditingController _productNameController = TextEditingController();
  // final TextEditingController _brandNameController = TextEditingController();
  // final TextEditingController _warrantyController = TextEditingController();
  // final TextEditingController _shortDescriptionController = TextEditingController();
  // HtmlEditorController fullDescriptionController = HtmlEditorController();
  // HtmlEditorController otherFeatureController = HtmlEditorController();

  //----step---2

//----page 2
//   List<Map<String, String>> attributeDataList = [];
//   List<TextEditingController> textControllers = [];
//   List<Map<String, dynamic>> selectSingleOption = [];
//   List<Map<String, dynamic>> selectMultipleOption = [];
  //----page 2
  // List<AttributeData> attributeData = [];
  bool isLoading2 = false;
  List<String> controlType = [];
  Future<void> fetchCatAttData({String? catId}) async {
    try {
      showLoggingInDialog(context: context, title: 'Loading Please Wait!!');

      setState(() {
        isLoading2 = true;
        controlType.clear();
        collectionData.clear();
        catAttributesData.clear();
        // attributeDataList.clear();
        // selectSingleOption.clear();
        // for (var controller in textControllers) {controller.clear();}
        // textControllers.clear();
        //-----step 2---
        // _productNameController.clear();
        // _brandNameController.clear();
        // _warrantyController.clear();
        // _shortDescriptionController.clear();
        // fullDescriptionController.clear();
        // fullDescriptionController.clearFocus();
        // otherFeatureController.clear();
        // otherFeatureController.clearFocus();
        //-----step 2---
        // attributeData.clear();
      });

      final brandListResponse = await CatAttributeApiService.fetchCatAttributeData(
        context: context,
        catId: catId ?? '', // Pass catId if required by your API
      );

      if (brandListResponse!.status == "success") {

        pageValue = brandListResponse!.page??"";
        List<String> controlTypeMapData = brandListResponse.data!.map((data) => data.controlType!).toList();
        List<CatAttributesData> attributeListing = brandListResponse.data!;

        setState(() {
          catAttributesData = attributeListing;
          controlType = controlTypeMapData;
          isLoading2 = false;
          Navigator.pop(context);
          // attributeDataList = [];
          // selectSingleOption = [];
          // textControllers = List.generate(catAttributesData.length, (index) => TextEditingController());
        });

          // if(brandListResponse!.page == 'multiple') {
          //   setState(() {
          //     Navigator.push(
          //       context, MaterialPageRoute(builder: (context) =>
          //         TabBarMultiPageScreen(
          //           catName : treeName??"",
          //           catAttributesDataList: catAttributesData ?? [],
          //           // attributeDataList: attributeDataList,
          //           // selectSingleOption: selectSingleOption,
          //           // textControllers: textControllers,
          //           // productNameController: _productNameController,
          //           // brandNameController: _brandNameController,
          //           // warrantyController: _warrantyController,
          //           // shortDescriptionController: _shortDescriptionController,
          //           // fullDescriptionController: fullDescriptionController,
          //           // otherFeatureController: otherFeatureController,
          //         )
          //     ),
          //     );
          //   });
          // }


      }
      else {
        // Handle API response status other than success if needed
        setState(() {
          isLoading2 = false;
          Navigator.pop(context);
        });
      }
    } catch (e) {
      // Error handling
      setState(() {
        isLoading2 = false;
        Navigator.pop(context);
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
                    await fetchCatAttData(catId: selectedItem);
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
                    await fetchCatAttData(catId: selectedItem);
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

  List<Map<String, dynamic>> collectionData = [];

  final TextEditingController _typeAheadController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

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
      body: Form(
        key: _formKey,
        child: Skeletonizer(
          enabled: isLoading,
          child: CupertinoScrollbar(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth/30,vertical: screenHeight/60),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
            
                      constantHeight(context, 40.0),

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
                                  selectedItem = categoryId;
                                });
                                print("selectedItem-------${selectedItem}");
                                _focusNode.unfocus(); // Close the suggestion list by unfocusing
                                await fetchCatAttData(catId: categoryId);
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
            
                      // dropDownForm(
                      //   context: context,
                      //   colorBorder: ConstantColor.primaryMainColor,
                      //   headText: 'Select Category',
                      //   value: selectedItem,
                      //   items: data.map((item) {
                      //     List<String> parts = [
                      //       item['cat']??"",
                      //       (item['pcat3'] != null && item['pcat3'].toString().isNotEmpty) ? " ( ${item['pcat3']}  >> " : ' ( ',
                      //       (item['pcat2'] != null && item['pcat2'].toString().isNotEmpty) ? "${item['pcat2']} >> " : '',
                      //       (item['pcat1'] != null && item['pcat1'].toString().isNotEmpty) ? "${item['pcat1']} >> " : '',
                      //       (item['cat'] != null && item['cat'].toString().isNotEmpty) ? "${item['cat']} ) " : ' ) ',
                      //       // item['pcat1'].toString().isNotEmpty ? " ( ${item['pcat1']}" : '',
                      //       // if (item['pcat2'] != null && item['pcat2'].toString().isNotEmpty) " >> ${item['pcat2']}",
                      //       // if (item['pcat3'] != null && item['pcat3'].toString().isNotEmpty) " >> ${item['pcat3']}", ')',
                      //     ];
                      //
                      //     String displayText = parts.where((part) => part.isNotEmpty).join('');
                      //    displayText = displayText.replaceAll(RegExp(r'[\d=]'), '');
                      //     String categoryId = item['category_id'].toString() ?? '';
                      //     return DropdownMenuItem<String>(
                      //       value: categoryId, // Ensure each value is unique
                      //       child: Text(
                      //         displayText,
                      //         style: ConstantTextStyle.dropDownPrimeText,
                      //       ),
                      //     );
                      //   }).toList(),
                      //   onChanged: (newValue) async {
                      //     setState(() {
                      //       selectedItem = newValue;
                      //       var selectedItemData = data.firstWhere((item) => item['category_id'].toString() == newValue);
                      //       // Construct the displayText for the selected item
                      //       List<String> parts = [
                      //         selectedItemData['cat']??"",
                      //         (selectedItemData['pcat3'] != null && selectedItemData['pcat3'].toString().isNotEmpty) ? " ( ${selectedItemData['pcat3']}  >> " : ' ( ',
                      //         (selectedItemData['pcat2'] != null && selectedItemData['pcat2'].toString().isNotEmpty) ? "${selectedItemData['pcat2']} >> " : '',
                      //         (selectedItemData['pcat1'] != null && selectedItemData['pcat1'].toString().isNotEmpty) ? "${selectedItemData['pcat1']} >> " : '',
                      //         (selectedItemData['cat'] != null && selectedItemData['cat'].toString().isNotEmpty) ? "${selectedItemData['cat']} ) " : ' )',
                      //       ];
                      //       treeName = parts.where((part) => part.isNotEmpty).join('');
                      //       treeName = treeName.toString().replaceAll(RegExp(r'[\d=]'), '');
                      //     });
                      //     await fetchCatAttData(catId: selectedItem);
                      //
                      //   },
                      // ),
            
            
                      constantHeight(context, 80.0),
            
            
                      (treeName.toString().isEmpty || treeName == null) ? Container():
                      customeText(text: "Category : $treeName\n",style: ConstantTextStyle.checkboxTextStyle1),
            

                      (treeName.toString().isEmpty || treeName == null) ?
                      Column(
                        children: data2.entries.map<Widget>((entry) {
                          List<String> parts = entry.key.split('=');
                          String resultKey = parts[1].trim();
                          return buildCategoryTile(resultKey, entry.value);
                        }).toList(),
                      ) : Container(),


                      // isLoading2 ? CircularProgressIndicator():
                      (pageValue == "singal") ?
                    SinglePageFormScreen(categoryName: treeName??'',categoryId: selectedItem??""):
                    //   // customeText(text: 'single page data'):
                      (pageValue == 'multiple') ?
                      SizedBox(
                        height: screenHeight * 0.7,
                           child: TabBarMultiPageScreen(
                            catName : treeName??"",
                             categoryId: selectedItem??"",
                            catAttributesDataList: catAttributesData ?? [],),
                         ):Container(),
                      // (pageValue == 'multiple') ?
                    //
                    //   SingleChildScrollView(
                    //     child: SizedBox(
                    //         height: screenHeight,
                    //         child:
                    //       TabBarMultiPageScreen(catAttributesDataList : catAttributesData??[],
                    //             attributeDataList: attributeDataList,
                    //           selectSingleOption: selectSingleOption,
                    //           textControllers: textControllers,
                    //         productNameController: _productNameController,
                    //         brandNameController: _brandNameController,
                    //         warrantyController: _warrantyController,
                    //         shortDescriptionController: _shortDescriptionController,
                    //         fullDescriptionController: fullDescriptionController,
                    //         otherFeatureController: otherFeatureController,
                    //
                    //         )
                    //     ),
                    //   ):
                // Container(),

                    ]
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}