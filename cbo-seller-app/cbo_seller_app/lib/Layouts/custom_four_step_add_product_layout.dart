// ignore_for_file: empty_catches, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../Models/Complete Order Model/cat_attribute_model.dart';
import '../Screen/Uploaded Products/Add New Product/Custom Product /Multi Page Screen/multi_page_step_1_screen.dart';
import '../Screen/Uploaded Products/Add New Product/Custom Product /Multi Page Screen/multi_page_step_2_screen.dart';
import '../Screen/Uploaded Products/Add New Product/Custom Product /Multi Page Screen/multi_page_step_3_screen.dart';
import '../Screen/Uploaded Products/Add New Product/Custom Product /Multi Page Screen/multi_page_step_4_screen.dart';
import '../Utils/Font Style/text_styles.dart';
import '../Utils/Theme/constant_colors.dart';


class TabBarMultiPageScreen extends StatefulWidget {
  final catName;
  final categoryId;
  final List<CatAttributesData> catAttributesDataList;
  // final List<Map<String, dynamic>> selectSingleOption;

  const TabBarMultiPageScreen({
    super.key,
    required this.catAttributesDataList,
    this.catName, this.categoryId,
  });

  @override
  State<TabBarMultiPageScreen> createState() => _TabBarMultiPageScreenState();
}

class _TabBarMultiPageScreenState extends State<TabBarMultiPageScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int defaultTabIndex = 0; // Adjusted defaultTabIndex if needed

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this); // Change length to 4
    _tabController.addListener(_handleTabSelection);
    _tabController.index = defaultTabIndex;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    // Handle tab selection if needed
  }



  //------step 1 storage ----
  List<Map<String, String>> attributeDataListData = [];
  List<Map<String, dynamic>> selectSingleOptionData = [];
  List<Map<String, dynamic>> selectMultipleOptionData = [];
  List<Map<String, dynamic>> myColorList = [];
  dynamic uuid = '';

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? attributeDataListJson = prefs.getString('attributeDataList');
    if (attributeDataListJson != null) {
      try {
        // Decode JSON string to List<Map<String, dynamic>>
        List<Map<String, dynamic>> decodedList = List<Map<String, dynamic>>.from(jsonDecode(attributeDataListJson));

        // Convert each map in the decoded list to Map<String, String>
        List<Map<String, String>> convertedList = decodedList.map((item) {
          // Create a new map with String keys and String values
          return item.map((key, value) => MapEntry(key, value.toString()));
        }).toList();

        setState(() {
          attributeDataListData = convertedList;
        });
      } catch (e) {}
    }
    String? selectSingleOptionJson = prefs.getString('selectSingleOption');
    if (selectSingleOptionJson != null) {
      try {
        List<Map<String, dynamic>> decodedList = List<Map<String, dynamic>>.from(jsonDecode(selectSingleOptionJson));
        setState(() {
          selectSingleOptionData = decodedList;
        });
      } catch (e) {}
    }
    String? selectMultipleOptionJson = prefs.getString('selectMultipleOption');
    if (selectMultipleOptionJson != null) {
      try {
        List<Map<String, dynamic>> decodedList = List<Map<String, dynamic>>.from(jsonDecode(selectMultipleOptionJson));
        List<Map<String, dynamic>> colorList = [];

        // Check if there is a "Color" object in the decodedList
        bool hasColorObject = false;

        for (var map in decodedList) {
          map.forEach((key, value) {
            // Check if the key is "Color"
            if (key == "Color") {
              hasColorObject = true;
              List<String> options = List<String>.from(value);
              for (var option in options) {
                // Generate UUID for each color option
                var uuid = const Uuid();
                // Create your desired format for color data
                Map<String, dynamic> colorData = {
                  option: {
                    "imageUrl": {"url": ""},
                    "imageOrder": "1",
                    "isPrimary": true,
                    "color": option,
                    "uuid": uuid.v1(),
                    "index": 0,
                  }
                };

                // Add to colorList
                colorList.add(colorData);
              }
            }
          });
        }

        // If "Color" object is not present, add a default color to colorList
        if (!hasColorObject) {
          var uuid = const Uuid();
          Map<String, dynamic> defaultColorData = {
            "defaultColor": {
              "imageUrl": {"url": ""},
              "imageOrder": "1",
              "isPrimary": true,
              "color": "defaultColor",
              "uuid": uuid.v1(),
              "index": 0,
            }
          };
          colorList.add(defaultColorData);
        }

        setState(() {
          selectMultipleOptionData = decodedList;
          myColorList = colorList;
        });
      } catch (e) {}
    } else {
      // Handle case where selectMultipleOptionJson is null
    }
  }


  //------step 3 storage ----

  // List productImageListData = [];

  String productName = '';
  String brandName = '';
  String statusActive = '';
  String warranty = '';
  String shortDescription = '';
  String fullDescription = '';
  String otherFeatures = '';

  Future<void> loadStep2Data() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    productName = prefs.getString('productName')??"";
    brandName = prefs.getString('brandName')??"";
    statusActive = prefs.getString('status')??"";
    warranty = prefs.getString('warranty')??"";
    shortDescription = prefs.getString('shortDescription')??"";
    fullDescription = prefs.getString('fullDescription')??"";
    otherFeatures = prefs.getString('otherFeatures')??"";
  }

  //------step 3 storage ----

  List productImageListData = [];

  Future<void> loadStep3Data() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? productImgListJson = prefs.getString('product_img');
    if (productImgListJson != null) {
      try {
        // Decode JSON string to List<Map<String, dynamic>>
        List<Map<String, dynamic>> decodedList = List<Map<String, dynamic>>.from(jsonDecode(productImgListJson));

        // Convert each map in the decoded list to Map<String, String>
        List<Map<String, String>> convertedList = decodedList.map((item) {
          // Create a new map with String keys and String values
          return item.map((key, value) => MapEntry(key, value.toString()));
        }).toList();

        setState(() {
          productImageListData = convertedList;
          // print("productImageListData---------$productImageListData");
        });
      } catch (e) {}
    }
  }

  //--------step 4 storage ------


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCustomTabBar(),
        Expanded(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              MultiPageStep1stScreen(
    catAttributesDataList: widget.catAttributesDataList,
                onNext: () {
                  setState(() {
                    loadData();
                    _selectedIndex = (_selectedIndex + 1).clamp(0, 4);
                    _tabController.animateTo(_selectedIndex);
                  });
                },
              ),
              MultiPageStep2ndScreen(
                onPreview: () {
                  setState(() {
                    _selectedIndex = (_selectedIndex - 1).clamp(0, 4);
                    _tabController.animateTo(_selectedIndex);
                  });
                },
                onNext: () {
                  setState(() {
                    loadStep2Data();
                    _selectedIndex = (_selectedIndex + 1).clamp(0, 4);
                    _tabController.animateTo(_selectedIndex);
                  });
                },
              ),
              MultiPageStep3rdScreen(
                myColorList: myColorList,
                currectPageValue: _selectedIndex + 1,
                onPreview: () {
                  setState(() {
                    _selectedIndex = (_selectedIndex - 1).clamp(0, 4);
                    _tabController.animateTo(_selectedIndex);
                  });
                },
                onNext: () {
                  setState(() {
                    loadStep3Data();
                    _selectedIndex = (_selectedIndex + 1).clamp(0, 4);
                    _tabController.animateTo(_selectedIndex);
                  });
                },
              ),
              MultiPageStep4thScreen(
                 productName: productName,
                 brandName: brandName,
                 statusActive: statusActive,
                 warranty: warranty,
                 shortDescription: shortDescription,
                 fullDescription: fullDescription,
                 otherFeatures: otherFeatures,
                 selectMultipleOptionData: selectMultipleOptionData,
                 attributeDataListData: attributeDataListData,
                 selectSingleOptionData: selectSingleOptionData,
                 productImageListData: productImageListData,
                 catName: widget.catName,
                 categoryId: widget.categoryId,
                 onPreview: () {
                   setState(() {
                     _selectedIndex = (_selectedIndex - 1).clamp(0, 4);
                     _tabController.animateTo(_selectedIndex);
                   });
                 },
                 // onSubmit: () {
                 //   setState(() {
                 //     _selectedIndex = (_selectedIndex + 1).clamp(0, 4);
                 //     _tabController.animateTo(_selectedIndex);
                 //   });
                 // },
               ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCustomTabBar() {
    var sw = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: ConstantColor.primaryGreyColor,width: 0.5),
        color: ConstantColor.textformFieldDisableColor,
      ),
      child: IgnorePointer(
        ignoring: true, // Ignore user interaction on TabBar
        child: TabBar(
          indicator:const BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 2.0, color: ConstantColor.primaryMainColor),
                left: BorderSide(width: 1.0, color: ConstantColor.primaryGreyColor),
                right: BorderSide(width: 1.0, color: ConstantColor.primaryGreyColor),
            ),
              color: ConstantColor.primaryBackgroundMainColor),
          labelPadding: EdgeInsets.symmetric(horizontal: sw/14.0),
          tabAlignment: TabAlignment.start,
          physics: const NeverScrollableScrollPhysics(),
          unselectedLabelColor: ConstantColor.subtitleGreyColor,
          dividerColor: ConstantColor.transparent1,
          labelColor: ConstantColor.primaryMainColor,
          labelStyle: ConstantTextStyle.profileGridText,
          isScrollable: true,
          // indicatorColor: ConstantColor.primaryMainColor,
          indicatorSize: TabBarIndicatorSize.tab,
          // enableFeedback: false,
          controller: _tabController,
          indicatorWeight: 2.5,
          // labelStyle: TextStyle(color: Colors.red),
          // unselectedLabelColor: Colors.grey,
          onTap: (index) {
            // Disable tapping on TabBar
          },
          tabs: const [
            Tab(text: 'Step 1'),
            Tab(text: 'Step 2'),
            Tab(text: 'Step 3'),
            Tab(text: 'Step 4'),
          ],
        ),
      ),
    );
  }
}
