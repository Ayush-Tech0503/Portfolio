// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, use_build_context_synchronously, deprecated_member_use

import 'dart:convert';
import 'package:Citybazar_app/Widgets/custome_button_.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Models/Store List Filter/store_filter.dart';
import '../Models/StoreListing Model/storelisting_model.dart';
import '../Util/Const Toster/toster.dart';
import '../Util/Constant APi Url/api_urls.dart';
import '../Util/constaint_textstyle.dart';
import '../Util/constant_color.dart';
import '../Util/constant_image.dart';
import '../Widgets/Login Check Widget/login_check_widget.dart';
import '../Widgets/collection_card.dart';
import '../Widgets/custome_richtext.dart';
import '../Widgets/custome_text.dart';
import '../Widgets/famous_market_card_widget.dart';
import '../Widgets/store_details_widget.dart';
import 'Famous Market/Store Details/Store Details Screen/store_details.dart';
import 'Search Box Screen/search_screen.dart';
import 'User Profile My Account/Dashboard/Liked Products/Liked Product TableData/liked_products_datatable.dart';

class StoresScreen extends StatefulWidget {
  String lattude;
  String longitude;
  String id;
  String lName;
  final ScrollController controller;
  StoresScreen(
      {super.key,
      required this.controller,
      required this.lattude,
      required this.longitude,
      required this.id,
      required this.lName});
  @override
  State<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey2 = GlobalKey<ScaffoldState>();
  ScrollController filterScrollController = ScrollController();
  bool isListIcon = false;
  bool checkedValue = false;
  var userId;

  String transformValue(String value) {
    switch (value) {
      case "Sort By":
        return "focused_shop";
      case "Nearest First":
        return "distance_in_km";
      case "From Following Shop":
        return "followed_seller";
      case "Rating High To Low":
        return "rating_high_to_low";
      default:
        return value.toLowerCase().replaceAll(RegExp(r'[-&]|(\s+)'), "_");
    }
  }

  final List<String> itemsData = [
    "Sort By",
    'Nearest First',
    'From Following Shop',
    'Rating High To Low',
  ];
  String selectedValue ="";
  String hintText = "Short By";
  var tokenAccess;
//-----------------------api data start ---------------------
  StoreListingData? storeListingData;
  List<SellerList>? sellerList = [];
  bool isLoading = false;
  int page = 1;
  int data=1;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final RefreshController _refreshControllerListView =
  RefreshController(initialRefresh: false);
  fetchStoreListIngApi({lat,long}) async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      tokenAccess = preference.getString("access-token");
      if (page == 1) {
        setState(() {
          isLoading = true;
          sellerList?.clear();
        });
      }
      final body = {
        "keyword": "seller",
        "interested_in": "buy",
        "distance": 10,
        "order_by" : selectedValue,
        "filter_cat": selectedCategoryNamesString,
        "rate_val": selectedValues,
        "pcatid": "",
        "lat": lat,
        "long": long,
        "page_no": page,
        "limit": "12"
      };
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.storeListingApi}",
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
        storeListingData = StoreListingData.fromJson(responseData);
        var sellerListData = storeListingData!.sellerList ?? [];
        if (sellerListData.isNotEmpty) {
          sellerList!.addAll(sellerListData);
          if (page == 1) {
            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {});
            _refreshController.loadComplete();
          }
          page += 1;
        } else {
          if (page == 1) {
            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {});
            _refreshController.loadNoData();
            isLoading = false;
          }
        }
      }
      else {
        _refreshController.loadNoData();
        // setState(() {
        //   isLoading = false;
        // });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        _refreshController.loadNoData();
      });
      error.toString();
    }
  }

  StoreFilter? allStoreFilter;
  List<CategoryFilter> filterAtCategory = [];
  bool isLoading2 = false;
  fetchAllStoreFilter({keyword, interestedIn, distance, lat, long, pageNo}) async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      tokenAccess = preference.getString("access-token");

      setState(() {
        isLoading2 = true;
      });
      final body = {
        "user_id": userId,
        "keyword": keyword,
        "interested_in": interestedIn,
        "distance": distance,
        "pcatid": "",
        "lat": lat,
        "long": long,
        "page_no": pageNo
      };
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.sellerListFilterEndPoint}",
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
        StoreFilter storeFilter = StoreFilter.fromJson(responseData);
        setState(() {
          allStoreFilter = storeFilter;
          filterAtCategory.addAll(storeFilter.categoryFilter ?? []);
        });
      } else {}

      setState(() {
        isLoading2 = false;
      });
    } catch (error) {
      setState(() {
        isLoading2 = false;
      });
      throw Exception('Failed to fetch data: $error');
    }
  }

//------------------filter api end////////-----------------
  String selectedCategoryNamesString = "";
  String selectedValues = '';
  String selectedCategoryRatings = "";
  bool categoryCheckedValue = false;
//--------------all clear filter data fun Start--------
  clearFilters() {
    setState(() {
      ratingCount = 0;
      selectedCount = 0;
      for (final filterCat in filterAtCategory) {
        filterCat.isSelected = false;
      }
      selectedCategoryNamesString = '';
      selectedValues = '';
      selectedValue = '';
      if(widget.id!=""){
        fetchStoreListIngApi(lat:widget.lattude, long: widget.longitude );
        page = 1;
      }
      else{
        fetchStoreListIngApi(lat:"22.7177", long: " 75.8545" );
        page = 1;
      }
      // fetchStoreListIngApi(lat: 22.7177, long: 75.8545);
      sellerList?.clear();
    });
  }
//--------------all clear filter data fun End--------

//-----------------------api data end ---------------------

  void _onLoading() async {
    if(widget.id!=""){
      fetchStoreListIngApi(lat:widget.lattude, long: widget.longitude);
      // fetchAllStoreFilter(keyword: "seller",interestedIn: "buy",distance: 10,lat:widget.lattude,
      //     long:widget.longitude, pageNo :1);
    }else{
      fetchStoreListIngApi(lat:"22.7177", long: " 75.8545",);
      // fetchAllStoreFilter(keyword: "seller",interestedIn: "buy",distance: 10,lat:"22.7177",
      //     long:" 75.8545", pageNo :1);
    }
  }

  @override
  void initState() {
    super.initState();
    selectedCount = filterAtCategory.where((filterCat) => filterCat.isSelected ?? false).length;
    ratingCount = filterAtCategory.where((filterCat) => filterCat.isSelected ?? false).length;
    if(widget.id!=""){
      fetchStoreListIngApi(lat:widget.lattude, long: widget.longitude );
      fetchAllStoreFilter(keyword: "seller",interestedIn: "buy",distance: 10,lat:widget.lattude,
          long:widget.longitude, pageNo :1);
    }
    else{
      fetchStoreListIngApi(lat:"22.7177", long: " 75.8545" );
      fetchAllStoreFilter(keyword: "seller",interestedIn: "buy",distance: 10,lat:"22.7177",
          long:" 75.8545", pageNo :1);
    }
  }
  int selectedCount = 0;
  int ratingCount = 0;


  void _showFilterBottomSheet(BuildContext context,) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return  StatefulBuilder(
          builder: (BuildContext context, StateSetter state) {
            var screenWidth = MediaQuery.of(context).size.width;
            var screenHeight = MediaQuery.of(context).size.height;
            return SingleChildScrollView(
              controller: filterScrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: screenHeight / 100),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: ConstantColor.landingScreenSubHaddingColor,
                      ),
                      width: screenWidth / 10,
                      height: screenWidth / 100,
                    ),
                  ),
                  ListTile(
                    // dense: true,
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
                            state(() {
                              clearFilters();
                            });
                            Navigator.pop(context);
                          },
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
                  isLoading2
                      ? const SpinKitCircle(
                    color: ConstantColor.primaryMainColor,
                    size: 30.0,
                  )
                      : filterAtCategory.isNotEmpty
                      ? Column(
                        children: [
   /*---------------category section Start--------------------*/

                          ExpansionTile(
                            textColor:  ConstantColor.primaryMainColor,
                            iconColor: ConstantColor.primaryMainColor,
                            title: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                customeText(
                                  text: "Category",
                                   style:const TextStyle(fontSize: 12,
                                      fontFamily: 'Montserrat',fontWeight: FontWeight.w600)),
                                selectedCount == 0 ? Container():
                                CircleAvatar(
                                  radius: 10.0,
                                  backgroundColor: ConstantColor.primaryMainColor,
                                  child: Text(selectedCount.toString()??'',style: ConstantTextStyle.chipText,),
                                ),
                              ],
                            ),
                            children: [
                              isLoading2
                                  ? const SpinKitCircle(
                                color: ConstantColor.primaryMainColor,
                                size: 30.0,
                              )
                                  : SizedBox(
                                height:screenHeight/3,
                                child: ScrollbarTheme(
                                  data: ScrollbarThemeData(
                                    thumbColor:
                                    MaterialStateProperty.all<Color>(
                                        ConstantColor.filedContainerColor),
                                    trackColor:
                                    MaterialStateProperty.all<Color>(
                                        ConstantColor.carColor),
                                  ),
                                  child: Scrollbar(
                                    trackVisibility: true,
                                    thumbVisibility: true,
                                    controller: filterScrollController,
                                    thickness: 5.0,
                                    radius: const Radius.circular(10.0),
                                    child: ListView.builder(
                                      itemCount: filterAtCategory.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final filterCat = filterAtCategory[index];
                                        return CheckboxListTile(
                                          dense: true,
                                          checkboxShape:
                                          RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                          ),
                                          activeColor: ConstantColor.primaryMainColor,
                                          checkColor: ConstantColor.primaryBackgroundMainColor,
                                          title: customeText(
                                            text: filterCat.categoryName ?? '',
                                            style: ConstantTextStyle.allHomeScreenAvatarText,
                                          ),
                                          value: filterCat.isSelected ?? false,
                                          onChanged: (bool? newValue) {
                                            state(() {
                                              filterCat.isSelected = newValue;
                                              page = 1;
                                              if (newValue == true) {
                                                selectedCount++;
                                                selectedCategoryNamesString += (selectedCategoryNamesString.isNotEmpty ? ',' : '') + (filterCat.categoryId ?? '');
                                              } else {
                                                selectedCount--;
                                                final List<dynamic> sringName;
                                                sringName = selectedCategoryNamesString.split(',');
                                                sringName.removeLast();
                                                selectedCategoryNamesString = sringName.join(',');
                                              }
                                              if (widget.id != "") {
                                                fetchStoreListIngApi(lat: widget.lattude, long: widget.longitude);
                                                sellerList?.clear();
                                              } else {
                                                fetchStoreListIngApi(lat: "22.7177", long: " 75.8545");
                                                sellerList?.clear();
                                              }
                                              // Navigator.pop(context);
                                            });
                                          },
                                          controlAffinity:
                                          ListTileControlAffinity.leading,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
           /*---------------category section end--------------------*/
                         /*---------------Start rating section start--------------------*/
                          ExpansionTile(
                            textColor: ConstantColor.primaryMainColor,
                            iconColor: ConstantColor.primaryMainColor,
                            title:Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                customeText(
                                    text: "Rating",
                                    style: const TextStyle(fontSize: 12,
                                        fontFamily: 'Montserrat',fontWeight: FontWeight.w600)),
                                ratingCount == 0 ? Container():
                                CircleAvatar(
                                  radius: 10.0,
                                  backgroundColor: ConstantColor.primaryMainColor,
                                  child: Text(ratingCount.toString()??'',style: ConstantTextStyle.chipText,),
                                ),
                              ],
                            ),
                            children: [
                              isLoading2
                                  ? const SpinKitCircle(
                                color: ConstantColor.primaryMainColor,
                                size: 30.0,
                              )
                                  : Column(
                                children: [
                                  ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: allStoreFilter?.rateFilter?.length ?? 0,
                                    itemBuilder: (BuildContext context, int valueIndex) {
                                      final ratingFile = allStoreFilter?.rateFilter;
                                      String? ratingString =
                                      ratingFile?[valueIndex]?.toString();
                                      bool checkedValue = selectedValues
                                          .contains(ratingString ?? '');
                                      return CheckboxListTile(
                                        dense: true,
                                        checkboxShape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        activeColor: ConstantColor.primaryMainColor,
                                        checkColor: ConstantColor.primaryBackgroundMainColor,
                                        title: customeText(
                                          text:
                                          "${ratingFile?[valueIndex]?.toString()} ★ & Above",
                                          style: ConstantTextStyle.allHomeScreenAvatarText,
                                        ),
                                        value: checkedValue,
                                        onChanged: (newValue) {
                                          state(() {
                                            page = 1;
                                            if (newValue == true) {
                                              ratingCount++;
                                              selectedValues +=
                                                  (selectedValues.isNotEmpty ? ',' : '') +
                                                      (ratingFile?[valueIndex]?.toString() ??
                                                          '');
                                            } else {
                                              ratingCount--;
                                              final List<String> stringRat =
                                              selectedValues.split(',');
                                              stringRat.remove(
                                                  ratingFile?[valueIndex]?.toString());
                                              selectedValues = stringRat.join(',');
                                            }
                                            if (widget.id != "") {
                                              fetchStoreListIngApi(
                                                  lat: widget.lattude,
                                                  long: widget.longitude);
                                              sellerList?.clear();
                                            } else {
                                              fetchStoreListIngApi(
                                                  lat: "22.7177", long: " 75.8545");
                                              sellerList?.clear();
                                            }
                                          });
                                          //  Navigator.pop(context);
                                        },
                                        controlAffinity:
                                        ListTileControlAffinity.leading,
                                      );
                                    },
                                  ),
                                ],),],),
                         /*---------------Start rating section End--------------------*/
                          SizedBox(height: screenHeight/40,),
                        ],
                      )
                      : customeText(text: "Data not Available yet"),
                ],
              ),
            );
          },
        );
           },
    );
  }


 //---------

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ConstantColor.primaryBackgroundMainColor,
      key: _scaffoldKey,
      appBar: AppBar(
        leadingWidth: 0,
        backgroundColor: ConstantColor.primaryBackgroundMainColor,
        elevation: 0.0,
/*--------------------------------------Search box section start-------------------------------------*/
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SearchBoxScreen(
                    id: widget.id,
                    lName: widget.lName,
                    latitude: widget.lattude,
                    longitude: widget.longitude,
                  )),
            );
          },
          child:  Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                  color: ConstantColor.primaryGreyColor
              ),
              color: ConstantColor.searchBoxColor,
            ),
            margin: EdgeInsets.symmetric(horizontal: screenWidth / 40),
            padding: EdgeInsets.symmetric(horizontal: screenWidth / 50),
            height: screenHeight / 20,
            width: screenWidth,
            child: Row(
          children: [
          const Icon(
          Icons.search_rounded,
            color: ConstantColor.primaryMainColor,
          ),
          SizedBox(width: screenWidth/40,),
          Flexible(
            child: Text(
              'Search for, Products, Shop and More',
              style: ConstantTextStyle.becomeSellerDiscText,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.start,
            ),
          ),
          ],
        ),
          ),
        ),
/*--------------------------------------Search box section end-------------------------------------*/
        titleSpacing: 0.0,
      ),
      // extendBody: true,
      body: Scaffold(
/*--------------------send app bar start--------------------*/
        appBar: AppBar(
          elevation: 1,
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          backgroundColor: ConstantColor.primaryBackgroundMainColor,
          centerTitle: true,
          title: IntrinsicHeight(
            child: Row(
              children: [
                iconAndText(
                  onPressed: () {
                    widget.lName != "Indore" ? LoadingScaffoldMessage.showSnackbar(
                      context,
                      "Search location area should be Indore !!!",
                      ConstantColor.primaryMainColor,
                      const Duration(seconds: 2),
                    ):
                    _showFilterBottomSheet(context);
                    // _scaffoldKey2.currentState!.openDrawer();
                  },
                  icons: Icons.filter_alt_outlined,
                  iconsSize: 20.0,
                  iconsColor: ConstantColor.loginWithOtpButtonColor,
                  iconText: "Filter",
                  iconTextStyle: ConstantTextStyle.allHomeScreenAvatarText,
                ),
                (ratingCount == 0 && selectedCount == 0)? Container():
                CircleAvatar(
                  radius: 10.0,
                  backgroundColor: ConstantColor.primaryMainColor,
                  child: Text('${(ratingCount != 0 ? 1 : 0) + (selectedCount != 0 ? 1 : 0)}',style: ConstantTextStyle.chipText,),
                ),
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
                    visualDensity:
                    const VisualDensity(horizontal: 0, vertical: -4),
                    leading: const Icon(Icons.sort,color: ConstantColor.loginWithOtpButtonColor,size: 20.0,),
                    // iconAndText(
                    //   onPressed: () {},
                    //   icons: Icons.sort,
                    //   iconsSize: 20.0,
                    //   iconsColor: ConstantColor.loginWithOtpButtonColor,
                    //   iconText: "Sort By",
                    //   iconTextStyle:
                    //   ConstantTextStyle.allHomeScreenAvatarText,
                    // ),
                    title: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        hint: customeText(
                          text: hintText,
                          overflow: TextOverflow.ellipsis,
                          style: ConstantTextStyle.allHomeScreenAvatarText,
                        ),
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
                              fetchStoreListIngApi(lat:widget.lattude, long: widget.longitude );
                              sellerList?.clear();}
                            else{
                              fetchStoreListIngApi(lat:"22.7177", long: " 75.8545" );
                              sellerList?.clear();}
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          height: screenHeight / 30,
                          width: screenWidth / 4,
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth / 40),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: ConstantColor.primaryGreyColor),
                              borderRadius: BorderRadius.circular(5.0),
                              color:
                              ConstantColor.primaryBackgroundMainColor),
                          // elevation: 1,
                        ),
                        iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.expand_circle_down,
                              size: 20.0,
                              color: ConstantColor.loginWithOtpButtonColor,
                            )
                          // icon: Visibility (visible:false, child: Icon(Icons.arrow_downward)),
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          width: 190,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: ConstantColor.primaryBackgroundMainColor,
                          ),
                          offset: const Offset(-8, -5),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thumbColor: MaterialStateProperty.all(
                                ConstantColor.primaryMainColor),
                            thickness: MaterialStateProperty.all(5),
                            thumbVisibility: MaterialStateProperty.all(true),
                          ),
                        ),
                        menuItemStyleData: MenuItemStyleData(
                          height: screenHeight / 25,
                          padding: EdgeInsets.symmetric(horizontal: screenWidth / 40.0),
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
                  padding: EdgeInsets.zero,
                  visualDensity:
                  const VisualDensity(horizontal: 0, vertical: -4),
                  icon: isListIcon
                      ? const Icon(
                    Icons.list,
                    color: ConstantColor.loginWithOtpButtonColor,
                  )
                      : const Icon(
                    Icons.border_all,
                    color: ConstantColor.loginWithOtpButtonColor,
                  ),
                  onPressed: () {
                    setState(() {
                      isListIcon = !isListIcon;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
/*--------------------send app bar end--------------------*/
/*---------------------Filter Drawer Start------------------------------*/
        key: _scaffoldKey2,
//           drawer: Drawer(
//               backgroundColor: ConstantColor.primaryBackgroundMainColor,
//               child: DrawerHeader(
//                 padding: EdgeInsets.zero,
//                 child: SingleChildScrollView(
//                   controller: filterScrollController,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ListTile(
//                         dense: true,
//                       title: customeText(
//                           text: "Filter",
//                           overflow: TextOverflow.ellipsis,
//                           style: ConstantTextStyle.cardbottumText,
//                         ),
//                         trailing: customeButton(
//                           text: "Clear All",
//                           style: ConstantTextStyle.loginButtonTextStyle,
//                           borderRadius: BorderRadius.circular(8.0),
//                           backgroundColor: ConstantColor.primaryMainColor,
//                           onPressed: () {
//                             setState(() {
//                               clearFilters();
//                             });
//                           },
//                         ),
//                       ),
//                       const Divider(
//                         color: ConstantColor.primaryGreyColor,
//                         thickness: 1.0,
//                         height: 0.0,
//                       ),
//                       isLoading2
//                           ? const SpinKitCircle(
//                               color: ConstantColor.primaryMainColor,
//                               size: 30.0,
//                             )
//                           : filterAtCategory.isNotEmpty
//                               ? ScrollbarTheme(
//                                   data: ScrollbarThemeData(
//                                     thumbColor:
//                                         MaterialStateProperty.all<Color>(
//                                             ConstantColor.filedContainerColor),
//                                     trackColor:
//                                         MaterialStateProperty.all<Color>(
//                                             ConstantColor.carColor),
//                                   ),
//                                   child: Scrollbar(
//                                     trackVisibility: true,
//                                     thumbVisibility: true,
//                                     controller: filterScrollController,
//                                     thickness: 5.0,
//                                     radius: const Radius.circular(10.0),
//                                     child: Column(
//                                       children: [
// /*---------------category section start--------------------*/
//                               ExpansionTile(
//                                 textColor:  ConstantColor.primaryMainColor,
//                                  iconColor: ConstantColor.primaryMainColor,
//                                 title:  Text("Category",
//                                   style: ConstantTextStyle.allHomeScreenAvatarText,),
//                                 children: [
//                                   isLoading2 ? const SpinKitCircle(
//                                         color: ConstantColor.primaryMainColor,
//                                         size: 30.0,)
//                                      : SizedBox(
//                                     height: screenHeight/3,
//                                     child:
//                                     ListView.builder(
//                                       itemCount: filterAtCategory.length,
//                                       itemBuilder: (BuildContext context, int index) {
//                                         final filterCat = filterAtCategory[index];
//                                         return CheckboxListTile(
//                                           checkboxShape: RoundedRectangleBorder(
//                                               borderRadius: BorderRadius.circular(5)),
//                                           activeColor: ConstantColor.primaryMainColor,
//                                           checkColor: ConstantColor.primaryBackgroundMainColor,
//                                           title:  customeText(
//                                           text: filterCat.categoryName??'',
//                                              style: ConstantTextStyle.allHomeScreenAvatarText,),
//                                           value: filterCat.isSelected ?? false,
//                                           onChanged: (bool? newValue) {
//                                             setState(() {
//                                               filterCat.isSelected = newValue;
//                                               page=1;
//                                               if (newValue == true) {
//                                                 selectedCategoryNamesString += (selectedCategoryNamesString.isNotEmpty ? ',' : '') + (filterCat.categoryId ?? '');
//                                               }
//                                               else {
//                                                 final List<dynamic> sringName;
//                                                 sringName = selectedCategoryNamesString.split(',');
//                                                 sringName.removeLast();
//                                                 selectedCategoryNamesString = sringName.join(',');
//                                               }
//                                               if(widget.id!=""){
//                                                 fetchStoreListIngApi(lat:widget.lattude, long: widget.longitude );
//                                                 sellerList?.clear();}
//                                               else{
//                                                 fetchStoreListIngApi(lat:"22.7177", long: " 75.8545" );
//                                                 sellerList?.clear();}
//                                             });
//
//                                           },
//                                           controlAffinity: ListTileControlAffinity.leading,
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
// /*---------------category section end--------------------*/
// /*---------------Start rating section start--------------------*/
//                               ExpansionTile(
//                                 textColor: ConstantColor.primaryMainColor,
//                                 iconColor: ConstantColor.primaryMainColor,
//                                 title:  Text("Rating", style: ConstantTextStyle.allHomeScreenAvatarText,),
//                                 children: [
//                                   isLoading2
//                                       ? const SpinKitCircle(
//                                     color: ConstantColor.primaryMainColor,
//                                     size: 30.0,
//                                   )
//                                       : ListView.builder(
//                                     physics: const NeverScrollableScrollPhysics(),
//                                     shrinkWrap: true,
//                                     itemCount: allStoreFilter?.rateFilter?.length ?? 0,
//                                     itemBuilder: (BuildContext context, int valueIndex) {
//                                       final ratingFile = allStoreFilter?.rateFilter;
//                                       String? ratingString = ratingFile?[valueIndex]?.toString(); // Extract the string with null safety
//                                       bool checkedValue = selectedValues.contains(ratingString ?? ''); // Provide a default value when using it
//                                       return CheckboxListTile(
//                                         checkboxShape: RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.circular(5)),
//                                         activeColor: ConstantColor.primaryMainColor,
//                                         checkColor: ConstantColor.primaryBackgroundMainColor,
//                                         title: customeText(
//                                           text: "${ratingFile?[valueIndex]?.toString()} ★ & Above" ?? '',
//                                           style: ConstantTextStyle.allHomeScreenAvatarText,
//                                         ),
//                                         value: checkedValue,
//                                         onChanged: (newValue) {
//                                           setState(() {
//                                             page =1;
//                                             if (newValue == true) {
//                                               selectedValues += (selectedValues.isNotEmpty ? ',' : '') + (ratingFile?[valueIndex]?.toString() ?? '');
//                                             } else {
//                                               final List<String> stringRat = selectedValues.split(',');
//                                               stringRat.remove(ratingFile?[valueIndex]?.toString());
//                                               selectedValues = stringRat.join(',');
//                                             }
//                                             if(widget.id!=""){
//                                               fetchStoreListIngApi(lat:widget.lattude, long: widget.longitude );
//                                               sellerList?.clear();}
//                                             else{
//                                               fetchStoreListIngApi(lat:"22.7177", long: " 75.8545" );
//                                               sellerList?.clear();}
//                                           });
//                                         },
//                                         controlAffinity: ListTileControlAffinity.leading,
//                                       );
//                                     },
//                                   ),
//                                 ],
//                               ),
// /*---------------Start rating section End--------------------*/
//                                       ],
//                                     ),
//                                   ),
//                                 )
//                               : customeText(text: "Data not Available yet"),
//                     ],
//                   ),
//                 ),
//               )),

/*---------------------Filter Drawer end------------------------------*/
        backgroundColor: ConstantColor.primaryBackgroundMainColor,
        body: isLoading
            ? const SpinKitCircle(
          color: ConstantColor.primaryMainColor,
          size: 30.0,
        )
            : sellerList!.isNotEmpty
            ? isListIcon
/*---------------------this is List view builder  start--------*/
            ? Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth/60,),
          color: ConstantColor.primaryBackgroundMainColor,
          height: screenHeight,
          child: SmartRefresher(
            enablePullDown: false,
            enablePullUp: true,
            footer: customFooter(),
            controller: _refreshControllerListView,
            onLoading: _onLoading,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: sellerList!.length,
              itemBuilder: (BuildContext context, int index) {
                var distanceKM = sellerList![index].distanceInKm;
                var inString = double.parse(distanceKM!);
                String dataInKM = inString.toStringAsFixed(2);
                return Column(
                  key: ValueKey<String>('list_item_$index'),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
/*--------------------------------Cash back chip start -----------------------------------------*/
                    sellerList![index].cashbackTag == false
                        ? Container()
                        : cashBackChip(
                      padding: EdgeInsets.symmetric(
                          vertical: screenHeight / 200),
                      color: ConstantColor
                          .filedContainerColor,
                      context: context,
                      textAlign: TextAlign.start,
                      width: screenWidth / 4,
                      text: sellerList![index]
                          .cashbackText
                          .toString(),
                      style: ConstantTextStyle
                          .chashBackchipText,
                    ),
/*--------------------------------Cash back chip end -----------------------------------------*/
                    ListTile(onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  StoreDetailScreen(
                                    sellersId:
                                    sellerList![index]
                                        .sellerId
                                        .toString(),
                                    id: widget.id,
                                    longitude:
                                    widget.longitude,
                                    latitude:
                                    widget.lattude,
                                    lName: widget.lName,
                                  )));
                    },
                      // minVerticalPadding: screenHeight/100,
                      visualDensity:
                      const VisualDensity(vertical: 4),
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      leading: CachedNetworkImage(
                        imageUrl: sellerList![index].storeImageUrl ??
                            "",
                        height: screenHeight,
                        width: screenWidth / 5,
                        fit: BoxFit.fill,
                        errorWidget: (context, url, error) =>
                            Image.asset(
                              ConstantImage.imageIsNotAvailable,
                              height: screenHeight,
                              width: screenWidth / 5,
                              fit: BoxFit.contain,
                            ),
                      ),
                      title: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          customeText(
                            text: sellerList![index]
                                .storeName!
                                .toUpperCase(),
                            textAlign: TextAlign.start,
                            //overflow1: TextOverflow.ellipsis,
                            style: ConstantTextStyle
                                .allHomeScreenAvatarText,
                          ),
                          SizedBox(
                            height: screenHeight / 200,
                          ),
                          iconRichText(
                            icon: Icons.location_on_outlined,
                            color: ConstantColor
                                .filedContainerColor,
                            size: 15.0,
                            text2: sellerList![index]
                                .storeAddress!
                                .toString(),
                            style2: ConstantTextStyle
                                .secondryLocationText,
                          ),
                          SizedBox(
                            height: screenHeight / 200,
                          ),
                          customRichText(
                            text1: dataInKM.toString(),
                            style1: ConstantTextStyle.richtext1,
                            text2: "From here",
                            TextAlign: TextAlign.start,
                            style2: ConstantTextStyle
                                .secondryLocationText,
                          ),
                          SizedBox(
                            height: screenHeight / 200,
                          ),
                          startRating(
                            width: screenWidth / 4,
                            height: screenHeight / 40,
                            context: context,
                            color: ConstantColor
                                .secondoryBlackColors,
                            text2:
                            "${double.parse(sellerList![index].avgRating ?? "0").toStringAsFixed(1)}/5.0",
                            style2:
                            ConstantTextStyle.ratingText,
                            initialRating: double.parse(
                                sellerList![index].avgRating ??
                                    "0"),
                            itemSize: 10.0,
                            minRating: 1.0,
                            allowHalfRating: true,
                            itemCount: 5,
                            onRatingUpdate: (rating) {},
                            itemBuilder: (context, _) =>
                            const Icon(
                              Icons.star,
                              color:
                              ConstantColor.starRatingColor,
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          String url = 'tel:${sellerList![index].contactNo}';
                          SharedPreferences preferences = await SharedPreferences.getInstance();
                          bool isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                          if (isUserLoggedIn) {
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          } else {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return isUserLoggedIn ? Container() : const CheckIsLogin();
                              },
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.call_outlined,
                          color: ConstantColor.primaryMainColor,
                        ),
                      ),
                    ),
                    Divider(
                      color: ConstantColor.locationIconColor,
                      height: screenHeight / 40,
                      thickness: 2,
                    ),
                  ],
                );
              },
            ),
          ),
        )
/*---------------------this is List view builder  End--------*/
/*---------------------this is grid view builder  start--------*/
            : Container(
            padding: EdgeInsets.symmetric(
                // vertical: screenHeight / 80,
                horizontal: screenWidth / 50),
            decoration: BoxDecoration(
              color: ConstantColor.secondryBackgroundMainColor,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: SmartRefresher(
              enablePullDown: false,
              enablePullUp: true,
              footer: customFooter(),
              controller: _refreshController,
              onLoading: _onLoading,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: sellerList!.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: (1 / 1.24),
                ),
                itemBuilder: (BuildContext context, index) {
                  var distanceKM =
                      sellerList![index].distanceInKm;
                  var inString = double.parse(distanceKM!);
                  String dataInKM = inString.toStringAsFixed(2);
                  return Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth / 50),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: screenHeight / 200),
                            child: Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                StoreDetailScreen(
                                                  // sluge: sellerList![index].storeSlug,
                                                  sellersId: sellerList![index].sellerId,
                                                  id: widget.id,
                                                  longitude: widget
                                                      .longitude,
                                                  latitude: widget
                                                      .lattude,
                                                  lName: widget
                                                      .lName,
                                                )));
                                  },
                                  child: CachedNetworkImage(
                                    imageUrl: sellerList![index]
                                        .storeImageUrl ??
                                        "",
                                    width: screenWidth,
                                    height: screenHeight / 7,
                                    fit: BoxFit.fill,
                                    errorWidget:
                                        (context, url, error) =>
                                        Image.asset(
                                          ConstantImage
                                              .imageIsNotAvailable,
                                          width: screenWidth,
                                          height: screenHeight / 7,
                                          fit: BoxFit.fill,
                                        ),
                                  ),
                                ),

              /*--------------------------------Cash back chip start -----------------------------------------*/
                                sellerList![index].cashbackTag ==
                                    false
                                    ? Container()
                                    : cashBackChip(
                                  padding:
                                  EdgeInsets.symmetric(
                                      vertical:
                                      screenHeight /
                                          200),
                                  color: ConstantColor
                                      .filedContainerColor,
                                  context: context,
                                  textAlign:
                                  TextAlign.start,
                                  text: sellerList![index]
                                      .cashbackText
                                      .toString(),
                                  style: ConstantTextStyle
                                      .chashBackchipText,
                                ),

              /*--------------------------------Cash back chip end -----------------------------------------*/
                                sellerList![index].cashbackTag ==
                                    false
                                    ? Container()
                                    : ShineEffect(
                                  padding: EdgeInsets.only(
                                    top: screenHeight / 120,
                                  ),
                                  height: screenHeight / 50,
                                  width: screenWidth / 4.5,
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: startRating(
                                    width: screenWidth / 4,
                                    height: screenHeight / 40,
                                    context: context,
                                    color: ConstantColor
                                        .secondoryBlackColors,
                                    text2:
                                    "${double.parse(sellerList![index].avgRating ?? "0").toStringAsFixed(1)}/5.0",
                                    style2: ConstantTextStyle
                                        .ratingText,
                                    initialRating: double.parse(
                                        sellerList![index]
                                            .avgRating ??
                                            "0"),
                                    itemSize: 10.0,
                                    minRating: 1.0,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    onRatingUpdate: (rating) {},
                                    itemBuilder: (context, _) =>
                                    const Icon(
                                      Icons.star,
                                      color: ConstantColor
                                          .starRatingColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: customeText(
                              text: sellerList![index]
                                  .storeName!
                                  .toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                              style: ConstantTextStyle
                                  .allHomeScreenAvatarText,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight / 200,
                          ),
                          Flexible(
                            child: iconRichText(
                              icon: Icons.location_on_outlined,
                              color: ConstantColor
                                  .filedContainerColor,
                              size: 15.0,
                              text2: sellerList![index]
                                  .storeAddress!
                                  .toString(),
                              style2: ConstantTextStyle
                                  .secondryLocationText,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight / 200,
                          ),
                          Flexible(
                            child: customRichText(
                              text1: dataInKM,
                              style1: ConstantTextStyle.richtext1,
                              text2: "From here",
                              TextAlign: TextAlign.start,
                              style2: ConstantTextStyle
                                  .secondryLocationText,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight / 100,
                          ),
                          Flexible(
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                String url = 'tel:${sellerList![index].contactNo}';
                                SharedPreferences preferences = await SharedPreferences.getInstance();
                                bool isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                                if (isUserLoggedIn) {
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                } else {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return isUserLoggedIn ? Container() : const CheckIsLogin();
                                    },
                                  );
                                }
                              },
                              icon: const Icon(
                                Icons.call_outlined,
                                color: ConstantColor.primaryBackgroundMainColor,
                                size: 17.0,
                              ),
                              label: Text(
                                'Contact Us',
                                style: ConstantTextStyle
                                    .newiconButtonText,
                              ),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size.fromHeight(screenHeight / 25),
                                backgroundColor: ConstantColor
                                    .primaryMainColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(8.0),
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
            ))
            : Center(
            child: customeText(
                textAlign: TextAlign.center,
                text: 'No Data Found!')),
/*---------------------this is grid view builder  start--------*/
      ),
    );
  }
}
