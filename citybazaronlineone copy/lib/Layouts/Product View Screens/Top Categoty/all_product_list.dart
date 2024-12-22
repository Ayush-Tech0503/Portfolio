// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously, deprecated_member_use, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Models/Product List Models/all_products.dart';
import '../../../Util/Constant APi Url/api_urls.dart';
import '../../../Util/constaint_textstyle.dart';
import '../../../Util/constant_color.dart';
import '../../../Util/constant_image.dart';
import '../../../Widgets/Login Check Widget/login_check_widget.dart';
import '../../../Widgets/Send Enquiry dialogBox/alert_dialog_box.dart';
import '../../../Widgets/collection_card.dart';
import '../../../Widgets/custome_button_.dart';
import '../../../Widgets/custome_richtext.dart';
import '../../../Widgets/custome_text.dart';
import '../../../Widgets/store_details_widget.dart';
import '../../User Profile My Account/Dashboard/Liked Products/Liked Product TableData/liked_products_datatable.dart';
import '../No product Found/no_product_found.dart';
import '../Product Price Filter/product_price_range_filter.dart';
import '../product_Item_Details.dart';
class AllProductListScreen extends StatefulWidget {
  //final usersId;
  final String? keyword;
  final String? minPrice;
  final String? maxPrice;
  final ordersBy;
  final List<String>? suitableFor;
  String id;
  String? filterKeyword;
  String longitude;
  String latitude;
  String lName;

   AllProductListScreen({super.key, this.keyword,this.filterKeyword, this.ordersBy, this.minPrice, this.maxPrice, required this.id,required this.longitude,required this.latitude,required this.lName, this.suitableFor,});
  @override
  State<AllProductListScreen> createState() => _AllProductListScreenState();
}

class _AllProductListScreenState extends State<AllProductListScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey2 = GlobalKey<ScaffoldState>();
  ScrollController filterScrollController = ScrollController();

  bool isListIcon = false;
  String transformValue(String value) {
    switch (value) {
      // widget.keyword.toString()
      case "Price High to Low":
        return "price_high_to_low";
      case "Price Low to High":
        return "price_low_to_high";
      case "What's New":
        return "date";
      case "Nearest First":
        return "distance_in_km";
      case "From Following Shop":
        return "followed_seller";
      default:
        return value.toLowerCase().replaceAll(RegExp(r'[-&]|(\s+)'), "_");
    }
  }
  final List<String> itemsData = [
    'Price High to Low',
    'Price Low to High',
    'What\'s New',
    'Nearest First',
    'From Following Shop',
  ];
  String selectedValue = "";
  String hintText = "Popularity";
  var usersId;
  var tokenAccess;
  var minPriceValue;
  var maxnPriceValue;
/*----------------------------Api data Here start----------------*/
/*---------------------------ALl Product List start----------------*/
  AllProducts? allProductData;
  List<Product> allProductList=[];
  bool isLoading = false;
  int page = 1;
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final RefreshController _refreshControllerList = RefreshController(initialRefresh: false);

  fetchAllProductList({lat,long,keyword,}) async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      tokenAccess = preference.getString("access-token");
      if (page == 1) {
        setState(() {
          isLoading = true;
        //  allProductList?.clear();
        });
      }
      final body = {
        "limit": 12,
        "keyword": widget.filterKeyword.toString().toLowerCase(),
        "pcatid": "",
        "interested_in": "buy",
        "distance": 10,
        "lat": lat,
        "long": long,
        "order_by" : selectedValue,
        "page_no": page,
        'filter_item':filterItem,
        "category": selectedCategoryString,
        "min_price":minPriceValue,
        "max_price":maxnPriceValue
      };
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.allProductsEndPoint}",
        options: Options(
          headers: {
            "Authorization": tokenAccess,
            'Content-Type': 'application/json',
          },
        ),
          data: json.encode(body),
      );
      if (response.statusCode == 200) {
        var responseData = json.decode(response.data.toString());
        if (responseData is Map<String, dynamic>) {
          allProductData = AllProducts.fromJson(responseData);
          // Clear list only on first page
          if (page == 1) {
            allProductList.clear();
          }
          // Add new data to list
          allProductList.addAll(allProductData!.productList ?? []);
          // Increment page for next request
          page += 1;

          // Notify SmartRefresher that loading is complete
          _refreshController.loadComplete();
          _refreshControllerList.loadComplete();
        } else {
          // Handle no data scenario
          _refreshController.loadNoData();
          _refreshControllerList.loadNoData();
        }
      } else {
        // Handle API error scenario
        _refreshController.loadFailed();
        _refreshControllerList.loadFailed();
      }
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
        _refreshController.loadNoData();
        _refreshControllerList.loadNoData();
      });
    }
  }
/*----------------------------All Product List End-------------------*/

/*----------------------------product Filter start-------------------*/
  ProductListFilter? allProductListFilter;
  List<Attributes> filterAttributes = [];
  List<Categories> filterCategories = [];
  bool isLoading2 = false;
  var PriceValue = 0.0;
  var userId;
  int pageNo = 1;
  final RefreshController _refreshController2 = RefreshController(initialRefresh: false);
  fetchAllProductListFilter({lat, long, keyword}) async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      if (pageNo == 1) {
        setState(() {
          isLoading2 = true;
          // filterAttributes.clear();
          // filterCategories.clear();
        });
      }
      final body = {
        "user_id": userId,
        "sub_category_id": 7,
        "sub_category_keyword": "",
        "keyword":keyword,
            //== "Medical Equipment" ? "medical-equipment":keyword,
        "pcatid": "",
        "interested_in": "buy",
        "distance": 10,
        "lat": lat,
        "long": long,
        "order_by": "Default",
        "page_no": pageNo,
        "filter_item": {
          "Color": [],
          "Fabric": [],
          "Sleeve Type": [],
          "Neck Type": [],
          "Brand": [],
          "Size": [],
          "Length": [],
         // "Suitable for": widget.suitableFor ?? filterItem["Suitable_for"]??[],
        },
        "category": "",
        "min_price": minPriceValue,
        "max_price": maxnPriceValue
      };
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.allProductsListFilterEndPoint}",
        options: Options(
          headers: {
            "Authorization": tokenAccess,
            'Content-Type': 'application/json',
          },
        ),
        data: json.encode(body),
      );
      if (response.statusCode == 200) {
        var responseData = json.decode(response.data.toString());
        if (responseData is List) {
        } else if (responseData is Map<String, dynamic>) {
          allProductListFilter = ProductListFilter.fromJson(responseData);
          var newFilterCategories = allProductListFilter!.categories ?? [];
          var newFilterAttributes = allProductListFilter!.attributes ?? [];
          if (newFilterAttributes.isNotEmpty && newFilterCategories.isNotEmpty) {
            filterAttributes.addAll(newFilterAttributes); // Add new attributes
            filterCategories.addAll(newFilterCategories); // Add new categories
            if (pageNo == 1) {
              setState(() {
                isLoading2 = false;
              });
            } else {
              setState(() {});
              _refreshController2.loadComplete();
            }
            pageNo += 1; // Increment pageNo
          } else {
            if (pageNo == 1) {
              setState(() {
                isLoading2 = false;
              });
            }else {
              setState(() {});
              _refreshController2.loadNoData();
              isLoading2 = false;
            }
          }
          }
          }
        } catch (error) {
      setState(() {
        isLoading2 = false;
        _refreshController2.loadNoData();
      });
    }
  }
/*----------------------------product Filter End-------------------*/
   // Map<String, List<String>>? filterItem = {};
  late Map<String, List<String>> filterItem;

  void _launchWhatsApp(String? phoneWhatsapp, String? smsText) async {
    if (!phoneWhatsapp!.startsWith("+91")) {
      phoneWhatsapp = "+91$phoneWhatsapp";}
    String url = 'https://wa.me/$phoneWhatsapp?text=${Uri.encodeComponent(smsText ?? 'I found you on CItyBazaarOnline')}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch WhatsApp $url';
    }
  }

  bool isLoadingWish = false;
  fetchSendEnquiryAPi({prodId,wantBuy,index,tokenAccess}) async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      tokenAccess = preference.getString("access-token");
      setState(() {
        isLoadingWish = true;
      });

      final body = {
        "user_id": userId,
        "wb_val": wantBuy,
        "product_id": prodId
      };
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.sendEnquiryApi}",
        options: Options(
          headers: {
            "Authorization": tokenAccess,
            'Content-Type': 'application/json',
          },
        ),
        data: json.encode(body),
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.data.toString());
        // Parse the response into a SendEnquiry object
        setState(() {
          allProductList[index].wantToBuy = '1';
          isLoadingWish = false;
          var  sellerNumber = allProductList[index].contactNo;
          var  sellerWhatsapp = allProductList[index].whatsapptext;
          showDialog(
            context: context,
            builder: (ctx) {
              return alertDialogBox(
                context: context,
                titleText: "Enquiry Send Successfully",
                titleTextAlign: TextAlign.center,
                titleStyle: ConstantTextStyle.topCategoryText,
                descriptionText: "+91 ${sellerNumber??''}.\n",
                phoneNumber: sellerNumber??'',
                descriptionTextStyle: ConstantTextStyle.secondorGrayText,
                icon: Icons.message_sharp,
                buttonText: "Chat with seller",
                buttonStyle: ConstantTextStyle.newiconButtonText,
                iconbuttononPress: () {
                  if (sellerNumber!.isNotEmpty && sellerNumber!= ""
                      && sellerNumber!= null ) {
                    _launchWhatsApp(sellerNumber??'', sellerWhatsapp??"");
                  }else {
                    '';
                  }
                },
              );
            },
          );
        });
      } else {
        setState(() {
          isLoadingWish = false;
        });
      }
    } catch (error) {
      setState(() {
        isLoadingWish = false;
      });
      // Handle any exceptions
      // print("Error: $error");
    }
  }
/*----------------------------Api data Here End-------------------*/
  Timer? _debounceTimer;
   onDataFromChild(min,max){
     setState(() {
       minPriceValue = min??'';
       maxnPriceValue = max??'';
       _debounceTimer?.cancel();
       _debounceTimer = Timer(const Duration(seconds: 2), () {
         page = 1;
         if (widget.id != "") {
           fetchAllProductList(keyword: widget.keyword.toString(), lat: widget.latitude, long: widget.longitude);
           allProductList.clear();
         } else {
           fetchAllProductList(keyword: widget.keyword.toString(), lat: "22.7177", long: "75.8545");
           allProductList.clear();
         }
       });
     });
   }
/*--------------------------------------------*/

  void clearAllCheckboxes() {
    setState(() {
      for (var filterCat in filterCategories) {
        filterCat.isSelected = false;
      }
      for (var filterAttribute in filterAttributes) {
        for (var attrValue in filterAttribute.attrValues ?? []) {
          filterItem![filterAttribute.attrName ?? '']?.remove(attrValue);
          filterAttribute.isSelectedValues = List<bool?>.generate(filterAttribute.attrValues?.length ?? 0, (_) => false);
        }
      }
      page = 1;
      selectedCategoryString ="";
      if (widget.id != "") {
        fetchAllProductList(keyword: widget.keyword, lat: widget.latitude, long: widget.longitude);
      } else {
        fetchAllProductList(keyword: widget.keyword, lat: "22.7177", long: "75.8545");
      }
      allProductList.clear();
    });
  }

/*--------------------------------------------*/
   _onLoading() async {
    if(widget.id!=""){
      fetchAllProductList(keyword: widget.keyword, lat: widget.latitude, long: widget.longitude);
    }else{
      fetchAllProductList(keyword: widget.keyword, lat: "22.7177", long: "75.8545");
    }
  //  _refreshControllerList.loadComplete();
  }

  bool isUserLoggedIn = false;

  @override
   initState() {
    super.initState();
    widget.suitableFor!.isEmpty ? filterItem = {}: filterItem = {"Suitable for": widget.suitableFor!};
    if(widget.id!=""){
      fetchAllProductList( keyword: widget.keyword, lat: widget.latitude, long: widget.longitude);
      fetchAllProductListFilter(keyword: widget.filterKeyword, lat:widget.latitude,long:widget.longitude );
      // rangeFunction();
    }
    else{
      fetchAllProductList(keyword: widget.keyword, lat: "22.7177", long: "75.8545");
      fetchAllProductListFilter(keyword: widget.filterKeyword, lat: 22.71771,long: 75.8544833 );
      // rangeFunction();
    }
  }
/*--------------------------------------------*/
  String selectedCategoryString ="";
   // bool showAllValues = false;
/*--------------------------------------------*/
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        SharedPreferences preference = await SharedPreferences.getInstance();
        preference.remove("minMyPrice");
        preference.remove("maxMyPrice");
        return true;
      },
      child:  Container(
        color: ConstantColor.loginWithOtpButtonColor,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: ConstantColor.primaryBackgroundMainColor,
        /*--------------------------------------------------------------*/
            key: scaffoldKey2,
            drawer: Drawer(
                backgroundColor:ConstantColor.primaryBackgroundMainColor,
                child:DrawerHeader(
                  padding: EdgeInsets.zero,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: filterScrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          dense: true,
                          title: customeText(
                            text: "Filter",
                            overflow: TextOverflow.ellipsis,
                            style: ConstantTextStyle.secodHearText1,
                          ),
                          trailing: Wrap(
                            spacing: screenWidth/50,
                            children: [
                              customeButton(
                                text: "Clear All",
                                style: ConstantTextStyle.loginButtonTextStyle,
                                borderRadius: BorderRadius.circular(8.0),
                                backgroundColor: ConstantColor.loginWithOtpButtonColor,
                                onPressed: () {
                                  setState(() {
                                    clearAllCheckboxes();
                                  });
                                  Navigator.pop(context);},
                              ),
                              customeButton(
                                text: "Apply",
                                style: ConstantTextStyle.loginButtonTextStyle,
                                borderRadius: BorderRadius.circular(8.0),
                                backgroundColor: ConstantColor.primaryMainColor,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: ConstantColor.primaryGreyColor,
                          thickness: 1.0,
                          height: 0.0,
                        ),
                        isLoading2 ? const SpinKitCircle(
                          color: ConstantColor.primaryMainColor,
                          size: 30.0,
                        ): filterAttributes.isNotEmpty
                            ? Column(
                          children: [
        /*---------------category section start--------------------*/
                            ExpansionTile(
                              textColor:  ConstantColor.primaryMainColor,
                              iconColor: ConstantColor.primaryMainColor,
                              title: customeText(
                                text: "Category"),
                              children: filterCategories.map((filterCat) {
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return CheckboxListTile(
                                      dense: true,
                                      checkboxShape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5)),
                                      activeColor: ConstantColor.primaryMainColor,
                                      checkColor: ConstantColor.primaryBackgroundMainColor,
                                      title: customeText(
                                        text: filterCat.categoryName?? "",
                                        style: ConstantTextStyle.allHomeScreenAvatarText,
                                      ),
                                      value:  filterCat.isSelected ?? false,
                                      onChanged: (bool? newValue) {
                                        setState(() {
                                          filterCat.isSelected = newValue;
                                          page=1;
                                          if (newValue == true) {
                                            selectedCategoryString += (selectedCategoryString.isNotEmpty ? ',' : '') + (filterCat.categoryId ?? '');
                                          }
                                          else {
                                            final List<dynamic> sringName;
                                            sringName = selectedCategoryString.split(',');
                                            sringName.removeLast();
                                            selectedCategoryString = sringName.join(',');
                                          }
                                          if(widget.id!=""){
                                            fetchAllProductList( keyword: widget.keyword, lat: widget.latitude, long: widget.longitude);
                                            allProductList.clear();
                                          }
                                          else{
                                            fetchAllProductList(keyword: widget.keyword, lat: "22.7177", long: "75.8545");
                                            allProductList.clear();
                                          }
                                        });

                                      },
                                      controlAffinity: ListTileControlAffinity.leading,
                                    );
                                  },
                                );
                              }).toList(),
                            ),
        /*---------------category section end--------------------*/
        /*---------------Price section end--------------------*/
                            ExpansionTile(
                              iconColor: ConstantColor.primaryMainColor,
                              textColor:  ConstantColor.primaryMainColor,
                              title: customeText(
                                text: "Price",
                                // style: ConstantTextStyle.allHomeScreenAvatarText,
                              ),
                              children: [
                                ListTile(
                                  visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
                                  dense: true,
                                  leading: Container(
                                    padding:EdgeInsets.symmetric(horizontal: screenHeight/80, vertical: screenHeight/80),
                                    color: ConstantColor.calendarBGHeadColor,
                                    child: customeText(text: minPriceValue == null
                                        ? allProductListFilter!.minPrice.toString()
                                        : minPriceValue.toString(),
                                        textAlign: TextAlign.center,
                                        style: ConstantTextStyle.becomeSellerDiscText),
                                  ),
                                  title: customeText(
                                    textAlign: TextAlign.center,
                                    text: "TO",
                                    style: ConstantTextStyle.allHomeScreenAvatarText,
                                  ),
                                  trailing:  Container(
                                    padding:EdgeInsets.symmetric(horizontal: screenHeight/80, vertical: screenHeight/80),
                                    color: ConstantColor.calendarBGHeadColor,
                                    child: customeText(text: maxnPriceValue == null
                                        ? allProductListFilter!.maxPrice.toString()
                                        :maxnPriceValue.toString()??'',
                                        textAlign: TextAlign.center,
                                        style: ConstantTextStyle.becomeSellerDiscText),
                                  ),
                                ),
                                ProductPriceSliderClass(
                                    callback: onDataFromChild,
                                    minV1: allProductListFilter!.minPrice?.toDouble() ?? 0.0,
                                    maxV1: allProductListFilter!.maxPrice?.toDouble() ?? 0.0)
                              ],
                            ),
        /*---------------Price section end--------------------*/
        /*---------------Attribute section Start--------------------*/
                            SizedBox(
                              height: screenHeight / 1.5,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: filterAttributes.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final filterAttribute = filterAttributes[index];
                                  return ExpansionTile(
                                    iconColor: ConstantColor.primaryMainColor,
                                    textColor: ConstantColor.primaryMainColor,
                                    title: customeText(
                                      text: filterAttribute.attrName ?? "",),
                                    children: [
                                      SizedBox(
                                        height: screenHeight / 5,
                                        child: ScrollbarTheme(
                                          data: ScrollbarThemeData(
                                            thumbColor: MaterialStateProperty.all<Color>(ConstantColor.filedContainerColor),
                                            trackColor: MaterialStateProperty.all<Color>(ConstantColor.carColor),
                                          ),
                                          child: Scrollbar(
                                            trackVisibility: true,
                                            thumbVisibility: true,
                                            controller: filterScrollController,
                                            thickness: 5.0,
                                            radius: const Radius.circular(10.0),
                                            child: ListView.builder(
                                              physics: const BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: filterAttribute.attrValues?.length ?? 0,
                                              itemBuilder: (BuildContext context, int valueIndex) {
                                                final attributeValue = filterAttribute.attrValues?[valueIndex] ?? "";
                                                return StatefulBuilder(
                                                  builder: (context, setState) {
                                                    return CheckboxListTile(
                                                      key: ValueKey<String>(attributeValue),
                                                      dense: true,
                                                      checkboxShape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(5)),
                                                      activeColor: ConstantColor.primaryMainColor,
                                                      checkColor: ConstantColor.primaryBackgroundMainColor,
                                                      title: Text(
                                                        attributeValue,
                                                        style: ConstantTextStyle.allHomeScreenAvatarText,
                                                      ),
                                                      value: filterAttribute.isSelectedValues?[valueIndex] ?? false,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          filterAttribute.isSelectedValues?[valueIndex] = newValue;
                                                          page = 1;
                                                          // Update filterItem dynamically based on attribute name
                                                          if (newValue == true) {
                                                            filterItem!.update(
                                                              filterAttribute.attrName ?? '',
                                                                  (existingValues) => [
                                                                ...(existingValues ?? []),
                                                                attributeValue ?? '',
                                                              ],
                                                              ifAbsent: () => [attributeValue ?? ''],
                                                            );
                                                          } else {
                                                            filterItem!.update(
                                                              filterAttribute.attrName ?? '',
                                                                  (existingValues) => [
                                                                ...(existingValues ?? []),
                                                              ]..remove(attributeValue ?? ''),
                                                              ifAbsent: () => [],
                                                            );
                                                          }
                                                        });

                                                        // Call API with updated filterItem
                                                        if (widget.id != "") {
                                                          fetchAllProductList(
                                                            keyword: widget.keyword.toString(),
                                                            lat: widget.latitude,
                                                            long: widget.longitude,
                                                          );
                                                        } else {
                                                          fetchAllProductList(
                                                            keyword: widget.keyword.toString(),
                                                            lat: "22.7177",
                                                            long: "75.8545",
                                                          );
                                                        }
                                                        allProductList.clear();
                                                      },
                                                      controlAffinity: ListTileControlAffinity.leading,
                                                    );
                                                  },
                                                );
                                              },
                                            ),

                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
        /*---------------Attribute section end--------------------*/
                          ],): customeText(text: "No Data Found!"),
                      ],
                    ),
                  ),
                )
            ),
        /*---------------------Filter Drawer end------------------------------*/
            // backgroundColor: ConstantColor.primaryBackgroundMainColor,
            body: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    floating: true,
                    pinned: false,
                    backgroundColor: ConstantColor.primaryBackgroundMainColor,
                    elevation: 0.0,
                    leading:IconButton(
                      icon: const Icon(Icons.arrow_back,color: ConstantColor.loginWithOtpButtonColor,),
                      onPressed: ()  async {
                        SharedPreferences preference = await SharedPreferences.getInstance();
                        preference.remove("minMyPrice");
                        preference.remove("maxMyPrice");
                        Navigator.of(context).pop();
                        // await clearSharedPreferences();
                      },
                    ),
                    centerTitle: true,
                    title:Text( widget.keyword.toString(),
                      style: ConstantTextStyle.topCategoryText2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    titleSpacing: 0.0,
                  ),
                  SliverAppBar(
                    leadingWidth: double.minPositive,
                    floating: false,
                    pinned: true,
                    backgroundColor: ConstantColor.primaryBackgroundMainColor,
                    elevation: 5.0,
                    title:  IntrinsicHeight(
                      child: Row(
                        children: [
                          iconAndText(
                            onPressed: (){
                              scaffoldKey2.currentState!.openDrawer();
                            },
                            icons: Icons.filter_alt_outlined,
                            iconsSize: 20.0,
                            iconsColor: ConstantColor.loginWithOtpButtonColor,
                            iconText: "Filter",
                            iconTextStyle: ConstantTextStyle.allHomeScreenAvatarText,),
                          const VerticalDivider(
                            color: ConstantColor.GrayLineColor,
                            thickness: 1,
                          ),
                          Flexible(
                            child: ListTile(
                              minVerticalPadding: 0,
                              minLeadingWidth: 0,
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                              leading:  iconAndText(
                                onPressed: (){},
                                icons: Icons.sort,
                                iconsSize: 20.0,
                                iconsColor: ConstantColor.loginWithOtpButtonColor,
                                iconText: "Sort By",
                                iconTextStyle: ConstantTextStyle.allHomeScreenAvatarText,),
                              title:DropdownButtonHideUnderline(
                                child:
                                DropdownButton2(
                                  isExpanded: true,
                                  hint: customeText(
                                    text: hintText,
                                    overflow: TextOverflow.ellipsis,
                                    style: ConstantTextStyle.allHomeScreenAvatarText,),
                                  items: itemsData.map((String itemsData)  {
                                    return
                                      DropdownMenuItem<String>(
                                        value: itemsData.toString(),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              textAlign: TextAlign.start,
                                              itemsData,
                                              style: ConstantTextStyle.allHomeScreenAvatarText,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            if (itemsData.toString() == hintText)
                                              const Icon(
                                                Icons.check_circle_outline_rounded,
                                                size: 20,
                                                color: ConstantColor.primaryMainColor,
                                              ),
                                          ],
                                        ),
                                      );
                                  }).toList(),
                                  onChanged: (String? value) async {
                                    setState(() {
                                      page=1;
                                      if (value != null && value.isNotEmpty) {
                                        selectedValue = transformValue(value);
                                        hintText = value;
                                      }
                                      if(widget.id!=""){
                                        fetchAllProductList( keyword: widget.keyword, lat: widget.latitude, long: widget.longitude);
                                        allProductList.clear();
                                      }
                                      else{
                                        fetchAllProductList(keyword: widget.keyword, lat: "22.7177", long: "75.8545");
                                        allProductList.clear();
                                      }
                                    });
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    height: screenHeight/30,
                                    width: screenWidth/4,
                                    padding:  EdgeInsets.symmetric( horizontal: screenWidth/40),
                                    decoration:  BoxDecoration(
                                        border: Border.all(color: ConstantColor.primaryGreyColor),
                                        borderRadius: BorderRadius.circular(5.0),
                                        color:ConstantColor.primaryBackgroundMainColor
                                    ),
                                    // elevation: 1,
                                  ),
                                  iconStyleData: const IconStyleData(
                                      icon: Icon(Icons.expand_circle_down,size: 20.0,
                                        color: ConstantColor.loginWithOtpButtonColor,)
                                    // icon: Visibility (visible:false, child: Icon(Icons.arrow_downward)),
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: 200,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: ConstantColor.primaryBackgroundMainColor,
                                    ),
                                    offset: const Offset(-20, 0),
                                    scrollbarTheme: ScrollbarThemeData(
                                      radius: const Radius.circular(40),
                                      thumbColor: MaterialStateProperty.all(ConstantColor.primaryMainColor),
                                      thickness: MaterialStateProperty.all(5),
                                      thumbVisibility: MaterialStateProperty.all(true),
                                    ),
                                  ),
                                  menuItemStyleData:  MenuItemStyleData(
                                    height: screenHeight/25,
                                    padding: EdgeInsets.symmetric(horizontal: screenWidth/40),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const VerticalDivider(
                            color: ConstantColor.GrayLineColor,
                            thickness: 1,
                          ),
                          IconButton(
                            padding:EdgeInsets.zero,
                            visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                            icon:  isListIcon ? const Icon(Icons.border_all, color: ConstantColor.loginWithOtpButtonColor,)
                                : const Icon(Icons.list, color: ConstantColor.loginWithOtpButtonColor,),
                            onPressed: () {
                              setState(() {
                                isListIcon = !isListIcon;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    titleSpacing: 0.0,
                  ),
                ];
              },
              body: IndexedStack(
                // index: index,
                children: [
              isLoading ? const SpinKitCircle(
              color: ConstantColor.primaryMainColor,
                size: 30.0,
              ) : allProductList.isNotEmpty
            ? isListIcon
        /*----------------------listview builder start -------------------------------*/
            ? Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth/60,),
              color: ConstantColor.secondryBackgroundMainColor,
              height: screenHeight,
              child:SmartRefresher(
                enablePullDown: false,
                enablePullUp: true,
                footer: customFooter(),
                controller: _refreshControllerList,
                onLoading: _onLoading,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: allProductList.length,
                  itemBuilder: (BuildContext context, int index) {
                        //*****************************************************************************
                    final productListView = allProductList[index];
                    double getPercantageOff(double price, double showPrice) {
                      double result = ((price - showPrice) / price) * 100;
                      return result.floor().toDouble();}
                    final
                    double showPrice = double.tryParse(productListView.showPrice.toString() ?? '0') ?? 0.0;
                    final num price = productListView.price ?? 0; // No need to parse if it's already an int
                    final double percentageOff = showPrice != 0.0 ? getPercantageOff(price.toDouble(), showPrice) : 0.0;
                        //*****************************************************************************
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: percentageOff > 0,
                          child: cashBackChip(
                            context: context,
                            borderRadius: BorderRadius.circular(5.0),
                            text: percentageOff > 0 ? '$percentageOff% OFF' : "",
                            style: ConstantTextStyle.newiconButtonText,
                            textAlign: TextAlign.center,
                            width: screenWidth / 4.0,
                            // height: screenHeight / 60,
                            color: percentageOff > 0 ? ConstantColor.chipColor : null,
                          ),
                        ),
                        ListTile (
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(
                              proId:allProductList[index].productId.toString()??"", id: widget.id, longitude: widget.longitude, latitude: widget.latitude,lName: widget.lName,
                            )));
                          },
                          // minVerticalPadding: screenHeight/100,
                          visualDensity: const VisualDensity(vertical: 4),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          leading:
                          CachedNetworkImage(
                            imageUrl: productListView.productImgUrl?? "",
                            height: screenHeight/8,
                            width: screenWidth/5,
                            fit: BoxFit.contain,
                            errorWidget: (context, url, error) =>
                                Image.asset(
                                  ConstantImage.imageIsNotAvailable,
                                  height: screenHeight/8,
                                  width: screenWidth/5,
                                  fit: BoxFit.contain,
                                ),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customeText(
                                text: productListView.productName?? "",
                                maxLine: 2,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                //overflow1: TextOverflow.ellipsis,
                                style: ConstantTextStyle.allHomeScreenAvatarText,
                              ),
                              SizedBox(height: screenHeight/300,),
                              customRichText(
                                text1:"\u{20B9}${productListView.showPrice ?? productListView.price} "?? "N/A",
                                style1: ConstantTextStyle.richtext1,
                                TextAlign: TextAlign.start,
                                text2:percentageOff> 0 ? NumberFormat.simpleCurrency(
                                    locale: "hi-NI", decimalDigits: 2)
                                    .format((productListView.price ?? '')) : " ",
                                style2: ConstantTextStyle.richtext2, ),
                              SizedBox(height: screenHeight/300,),
                              // isLoadingWish ?
                              // const SpinKitCircle(
                              //   color: ConstantColor.primaryMainColor,
                              //   size: 30.0,
                              // ) :
                              ElevatedButton.icon(
                                onPressed: allProductList[index].wantToBuy == "1" ? null : () async {
                                  SharedPreferences preferences = await SharedPreferences.getInstance();
                                  setState(() {
                                    isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                                    tokenAccess = preferences.getString("access-token");
                                  });
                                  if (isUserLoggedIn) {
                                    await fetchSendEnquiryAPi(
                                      prodId: allProductList[index].productId ?? '',
                                      tokenAccess: tokenAccess,
                                      wantBuy: "1",
                                      index: index,
                                    );
                                  }
                                  else {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const CheckIsLogin();
                                      },
                                    );
                                  }
                                },
                                icon: const Icon(
                                  Icons.content_paste_search,
                                  color: ConstantColor.primaryBackgroundMainColor,
                                  size: 18.0,
                                ),
                                label: Text(
                                  'Send Enquiry',
                                  style: ConstantTextStyle.newiconButtonText,
                                ),
                                style: ElevatedButton.styleFrom(
                                  // minimumSize: Size.fromHeight(screenHeight /30),
                                  backgroundColor: allProductList[index].wantToBuy == "1"
                                      ? ConstantColor.primaryGreyColor
                                      : ConstantColor.primaryMainColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          trailing: Icon(Icons.store_outlined,size: screenHeight/35,
                            color: ConstantColor.loginWithOtpButtonColor,),
                        ),
                        Divider(
                          color: ConstantColor.locationIconColor,
                          height: screenHeight/40,
                          thickness: 2,
                        ),
                      ],
                    );
                  },
                ),)
          )
        /*----------------------listview builder end -------------------------------*/
        /*----------------------GridView builder start -------------------------------*/
                : Container(
        padding: EdgeInsets.symmetric(vertical: screenHeight/80,horizontal: screenWidth/50),
        decoration: BoxDecoration(
          color: ConstantColor.secondryBackgroundMainColor,
          borderRadius: BorderRadius.circular(5.0),),
        child:  SmartRefresher(
          enablePullDown: false,
          enablePullUp: true,
          footer: customFooter(),
          controller: _refreshController,
          onLoading: _onLoading,
          child: GridView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: allProductList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 1/1.25,
            ),
            itemBuilder: (BuildContext context, index) {
        //*****************************************************************************

              final productListHere = allProductList[index];
              double getPercantageOff(double price, double showPrice) {
                double result = ((price - showPrice) / price) * 100;
                return result.floor().toDouble();}
              final double showPrice = double.tryParse(productListHere.showPrice.toString() ?? '') ?? 0.0;
              final num price = productListHere.price ?? 0; // No need to parse if it's already an int
              final double percentageOff = showPrice != 0.0 ? getPercantageOff(price.toDouble(), showPrice) : 0.0;
              final roundedPercentageOff = percentageOff.toStringAsFixed(0);
        //*****************************************************************************
              return Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth/50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      cashBackChip(
                        context: context,
                        borderRadius: BorderRadius.circular(5.0),
                        text:percentageOff> 0 ? '$roundedPercentageOff% OFF' : "",
                        style: ConstantTextStyle.newiconButtonText,
                        textAlign: TextAlign.center,
                        color: percentageOff> 0 ? ConstantColor.chipColor : null,),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(
                            proId:allProductList[index].productId.toString()??"", id: widget.id, longitude: widget.longitude, latitude: widget.latitude,lName: widget.lName
                            ,
                          )));
                        },
                        child:CachedNetworkImage(
                          imageUrl:productListHere.productImgUrl?? "",
                          width: screenWidth,
                          height: screenHeight / 7,
                          fit: BoxFit.contain,
                          errorWidget: (context, url, error) =>
                              Image.asset(
                                ConstantImage.imageIsNotAvailable,
                                width: screenWidth,
                                height: screenHeight / 7,
                                fit: BoxFit.fill,
                              ),
                        ),
                      ),
                      SizedBox(height: screenHeight/100,),
                      customeText(
                        text: productListHere.productName?? "",
                        overflow: TextOverflow.ellipsis,
                        style: ConstantTextStyle.allHomeScreenAvatarText,),
                      SizedBox(height: screenHeight/200,),
                      Flexible(
                        child: customRichText(
                          text1: "\u{20B9}${productListHere.showPrice ?? productListHere.price} "?? "N/A",
                          style1: ConstantTextStyle.richtext1,
                          TextAlign: TextAlign.start,
                          text2:percentageOff> 0 ? NumberFormat.simpleCurrency(
                              locale: "hi-NI", decimalDigits: 2)
                              .format((productListHere.price ?? '')) : " ",
                          style2: ConstantTextStyle.richtext2, ),
                      ),
                      SizedBox(height: screenHeight/200,),
                      Flexible(
                        child: ElevatedButton.icon(
                          onPressed: allProductList[index].wantToBuy == "1" ? null : () async {
                            SharedPreferences preferences = await SharedPreferences.getInstance();
                            setState(() {
                              isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                              tokenAccess = preferences.getString("access-token");
                            });
                            if (isUserLoggedIn) {
                              await fetchSendEnquiryAPi(
                                prodId: allProductList[index].productId ?? '',
                                wantBuy: "1",
                                tokenAccess:tokenAccess,
                                index: index,
                              );
                            } else {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return const CheckIsLogin();
                                },
                              );
                            }
                          },
                          icon: const Icon(
                            Icons.content_paste_search,
                            color: ConstantColor.primaryBackgroundMainColor,
                            size: 18.0,
                          ),
                          label: Text(
                            'Send Enquiry',
                            style: ConstantTextStyle.newiconButtonText,
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(screenHeight / 25),
                            backgroundColor: allProductList[index].wantToBuy == "1"
                                ? ConstantColor.primaryGreyColor
                                : ConstantColor.primaryMainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
            ): Center(child: NoProductDataFound(messageText: messageData)),

        /*----------------------GridView builder start -------------------------------*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
/*-----------------------------------Product cards end------------------------------------*/
  }
  String messageData = '''Oops!!!
No Data Found!

Don't Worry. Please provide us with your requirements by clicking the 'Post Requirements' button below. We will do our utmost to deliver the best possible results for you.''';

}


