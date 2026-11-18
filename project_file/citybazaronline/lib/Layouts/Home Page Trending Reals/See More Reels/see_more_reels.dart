// ignore_for_file: deprecated_member_use, non_constant_identifier_names, prefer_typing_uninitialized_variables, library_private_types_in_public_api, duplicate_ignore, must_be_immutable, empty_catches, avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'package:Citybazar_app/Util/constaint_textstyle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Api Services/Reels Api  Services/reels_view_api_services.dart';
import '../../../Models/Reels Category Field Model/reels_categories_field_model.dart';
import '../../../Models/Reels/reellisting_model.dart';
import '../../../Util/Const Toster/toster.dart';
import '../../../Util/Constant APi Url/api_urls.dart';
import '../../../Util/constant_color.dart';
import '../../../Util/constant_image.dart';
import '../../../Widgets/custome_button_.dart';
import '../../../Widgets/custome_text.dart';
import '../../Main Reels Screen/main_reels_screen.dart';
import '../../User Profile My Account/Dashboard/Liked Products/Liked Product TableData/liked_products_datatable.dart';
import 'see_more_reels2.dart';


String? VideoData;

class SeeMoreReelsScreen extends StatefulWidget {
  String id;
  String latitude;
  String longitude;
  String lName;
   SeeMoreReelsScreen({super.key,
     required this.id,
     required this.longitude,
    required this.latitude,
    required this.lName});

  @override
  // ignore: library_private_types_in_public_api
  _SeeMoreReelsScreenState createState() => _SeeMoreReelsScreenState();
}

class _SeeMoreReelsScreenState extends State<SeeMoreReelsScreen> {

  @override
  void dispose() {
    allReelsDataList.clear();
    childCat.clear();
    selectedCount = 0;
    _refreshController.dispose();
    super.dispose();
  }
  //------------------------------APi data start------------
  int selectedCount = 0;

  int myCount = 0;
  int myTotalPages = 0;
  int myTotalCount = 0;
  var userId;
  var tokenAccess;
  bool isLoadingGetReals = false;
  ReelList? reelsData;
  List<ReelListData> allReelsDataList = [];
  int page = 1;
  int limit = 10; // Set the limit to 20
  bool hasMoreData = true; // Track if there is more data to fetch
  String selectedPostType = "";
  String selectFollowingShop = "";
  String selectCategories = "";
  String selectedCategoryNamesString = "";
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  var baseUrl;
  fetchGetReels({postType,selectFollowingShopType,trending,newest_first}) async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      tokenAccess = preference.getString("access-token");
      if (page == 1) {
        setState(() {
          isLoadingGetReals = true;
          allReelsDataList.clear();
        });
      }

      // Update the "post_type" parameter in the request body
      final body = {
        "search":"",
        "user_id": userId,
        "page_no":page,
        "limit":limit,
        "reel_id": "",
        "seller_id":"",
        "is_save":"",
        "trending": trending ?? "",
        "newest_first": newest_first ?? "",
        "cat": selectedCategoryNamesString.toString().isEmpty ? [] : [selectedCategoryNamesString],
        "is_follow":selectFollowingShopType??"",
        "post_type": postType??"",
        "lat": (widget.id != "" && widget.lName != "") ? widget.latitude:"22.7177",
        "long": (widget.id != "" && widget.lName != "") ? widget.longitude: "75.8545",
        "city": (widget.id != "" && widget.lName != "") ? widget.lName: "Indore"
      };
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi2}${ConstantUrls.getReelsApi}",
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
        reelsData = ReelList.fromJson(responseData);
        baseUrl = reelsData!.baseUrl.toString();
        myCount = reelsData!.count! + myCount;
        dynamic totalCountString = reelsData!.totalCount;
        // int myTotalCount = 0; // Default value

        if (totalCountString != null) {
          try {
            if (totalCountString is String) {
              myTotalCount = int.parse(totalCountString);  // If it's a string, attempt to parse it to an integer
            } else if (totalCountString is int) {
              myTotalCount = totalCountString; // If it's already an integer, use it directly
            }
          } catch (e) {}
        }

        myTotalPages = reelsData!.totalPages ?? 0; // Use default value if totalPages is null

        setState(() {
          allReelsDataList.addAll(reelsData?.reelDataList ?? []);
          if (reelsData?.reelDataList?.isEmpty ?? true) {
            hasMoreData = false; // No more data to fetch
          } else {
            hasMoreData = true;
            _refreshController.loadComplete();
            page++;
          }
        });
      }
      else {
        _refreshController.loadFailed();
        // Handle error or show a message when the API call fails.
      }
      setState(() {
        isLoadingGetReals = false;
      });
    } catch (error) {
      setState(() {
        isLoadingGetReals = false;
        _refreshController.refreshCompleted();
      });
    }
  }
//------------------------------APi data End------------

  savePageNo(int pageNo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('pageNo', pageNo);

  }

//----------------Data and time data to convert 00 min/day/yy/ ago fun^ start------------
  String calculateTimeDifference(String createdAt) {
    final createdAtDateTime = DateTime.parse(createdAt);
    final now = DateTime.now();
    final difference = now.difference(createdAtDateTime);
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} days ago';
    }else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months months ago';}
    else {
      final years = (difference.inDays / 365).floor();
      if (years == 1) {
        return '1 year ago';
      }
      else {
        return '$years years ago';
      }
    // else {
    //   final formatter = DateFormat('dd-MM-yyyy');
    //   return 'on ${formatter.format(createdAtDateTime)}';
    // }
  }
  }
//----------------Data and time data to convert 00 min/day/yy/ ago fun^ end------------

//------------------------------------------

  List<Data> childCat = [];
  bool isLoadingPreview = false;
  ReelsCategoriesList? preRegistration;
  ScrollController filterScrollController2 = ScrollController();
  //--------------this preview api Start--------------------
  fetchPreview() async {
    try {
      setState(() {
        isLoadingPreview = true;
      });
      SharedPreferences preference = await SharedPreferences.getInstance();
      String? tokenAccess = preference.getString("access-token");
      final body = {"type": "new"};
      final response = await Dio().post(
        // "${ConstantUrls.baseUriApi}${ConstantUrls.categoriesReelsApi}",
        "${ConstantUrls.baseUriApi}${ConstantUrls.reelCatFilterApi}",
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
        setState(() {
          isLoadingPreview = false;
          childCat = ReelsCategoriesList.fromJson(responseData).data?? [];
        });
      } else {
        setState(() {
          isLoadingPreview = false;
        });
      }
    } catch (error) {
      setState(() {
        isLoadingPreview = false;
      });
    }
  }
//--------------this preview api End--------------------
//------------------------------------------
  void _onLoading() async {
    await fetchGetReels();
    // await fetchPreview();
    if (!hasMoreData) {
      _refreshController.loadNoData();
    } else {
      _refreshController.loadComplete();
    }
  }
  //------------------------------------------
  final List<String> filterAtCategory = [
    "Photo",
    'Image'
  ];
//------------------------------------------
  void _showReelsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0)),
      ),
      context: context,
      builder: (BuildContext context) {
        var screenHeight = MediaQuery.of(context).size.height;
        var screenWidth = MediaQuery.of(context).size.width;
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter state) {
            return SingleChildScrollView(
              controller: filterScrollController2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: screenHeight /100),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: ConstantColor.landingScreenSubHaddingColor,
                      ),
                      width: screenWidth / 10,
                      height: screenWidth / 100,
                    ),
                  ),
                  ListTile(
                //    dense: true,
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
                              selectedCount = 0;
                              for (final filterCat in childCat) {
                                filterCat.isSelected = false;
                              }
                              selectedPostType = "";
                              selectFollowingShop = "";
                              selectedCategoryNamesString = "";
                              page = 1;
                              fetchGetReels();
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
                  // CheckboxListTile(
                  //   dense: true,
                  //   checkboxShape:
                  //   RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  //   activeColor: ConstantColor.primaryMainColor,
                  //   checkColor: ConstantColor.primaryBackgroundMainColor,
                  //   title: customeText(
                  //     text: "Follow Shop",
                  //     overflow: TextOverflow.ellipsis,
                  //     style: ConstantTextStyle.allHomeScreenAvatarText,
                  //   ),
                  //   value: selectFollowingShop == "1",
                  //   onChanged: (bool? value) {
                  //     Navigator.pop(context);
                  //     setState(() {
                  //       page = 1;
                  //       selectFollowingShop = value! ? "1" : "";
                  //       fetchGetReels(postType: selectedPostType, selectFollowingShopType: selectFollowingShop,);
                  //       allReelsDataList.clear();
                  //     });
                  //   },
                  // ),
                  /*---------------category section Start--------------------*/
                  isLoadingPreview
                      ? const Center(child: LinearProgressIndicator(color: ConstantColor.primaryMainColor,))
                      : ExpansionTile(
                        textColor: ConstantColor.primaryMainColor,
                        iconColor: ConstantColor.primaryMainColor,
                        // title: const Text("Category",style: TextStyle(fontSize: 12,
                        //   fontFamily: 'Montserrat',
                        //   fontWeight: FontWeight.w600),),
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
                          SizedBox(
                            height: screenHeight /2.5,
                            child:  ScrollbarTheme(
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
                                controller: filterScrollController2,
                                thickness: 5.0,
                                radius: const Radius.circular(10.0),
                                child: ListView.builder(
                                  itemCount: childCat.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final filterCat = childCat[index];
                                    var catKeyId = filterCat.categoryId;
                                    var catValue = filterCat.categoryName;
                                  return CheckboxListTile(
                                      dense: true,
                                      checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                      activeColor: ConstantColor.primaryMainColor,
                                      checkColor: ConstantColor.primaryBackgroundMainColor,
                                      title: Text(catValue??"",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        style: ConstantTextStyle.allHomeScreenAvatarText,
                                      ),
                                      value: filterCat.isSelected ?? false,
                                      onChanged: (bool? newValue) {
                                        state(() {
                                          filterCat.isSelected = newValue;
                                          page = 1;
                                          if (newValue == true) {
                                            selectedCount++;
                                            selectedCategoryNamesString += (selectedCategoryNamesString.isNotEmpty ? ',' : '')+catKeyId!;
                                                // (selectedCategoryNamesString.isNotEmpty ? ',' : '')+catKey.replaceAll(RegExp(r'[0-9=]'),"");
                                          } else {
                                            selectedCount--;
                                            final List<dynamic> sringName;
                                            sringName = selectedCategoryNamesString.split(',');
                                            sringName.removeLast();
                                            selectedCategoryNamesString = sringName.join(',');
                                          }
                                          fetchGetReels();
                                          allReelsDataList.clear();
                                          // Navigator.pop(context);
                                        });

                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                  /*---------------category section end--------------------*/
                  ExpansionTile(
                    textColor: ConstantColor.primaryMainColor,
                    iconColor: ConstantColor.primaryMainColor,
                    title: customeText(
                      text: "Post type",style: const TextStyle(fontSize: 12,
                    fontFamily: 'Montserrat',fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis
                    ),
                    children: [
                      CheckboxListTile(
                        dense: true,
                        checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        activeColor: ConstantColor.primaryMainColor,
                        checkColor: ConstantColor.primaryBackgroundMainColor,
                        title: customeText(
                          text: "Photos",
                          overflow: TextOverflow.ellipsis,
                          style: ConstantTextStyle.allHomeScreenAvatarText,
                        ),
                        value: selectedPostType == "image",
                        onChanged: (bool? value) {
                          // Navigator.pop(context);
                          state(() {
                            page = 1;
                            selectedPostType = value! ? "image" : ""; // Set the value based on checkbox state
                            fetchGetReels( postType: selectedPostType);
                          });
                        },
                      ),
                      CheckboxListTile(
                        dense: true,
                        checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        activeColor: ConstantColor.primaryMainColor,
                        checkColor: ConstantColor.primaryBackgroundMainColor,
                        title: customeText(
                          text: "Videos",
                          overflow: TextOverflow.ellipsis,
                          style: ConstantTextStyle.allHomeScreenAvatarText,
                        ),
                        value: selectedPostType == "video",
                        onChanged: (bool? value) {
                          // Navigator.pop(context);
                          state(() {
                            page = 1;
                            selectedPostType = value! ? "video" : ""; // Set the value based on checkbox state
                            fetchGetReels(postType: selectedPostType);
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight/40,),
                ],
              ),
            );
          }
        );
      },
    );
  }

//------------------------------------------
  @override
  void initState() {
    super.initState();
  fetchGetReels();
    fetchPreview();
  }

  TextEditingController searchController = TextEditingController();
  // String transformValue(String value) {
  //   switch (value) {
  //     case "Nearest First":
  //       return "1";
  //     case "Following Shop":
  //       return "1";
  //     case "Trending":
  //       return "1";
  //     default:
  //       return value.toLowerCase().replaceAll(RegExp(r'[-&]|(\s+)'), "_");
  //   }
  // }

  final List<String> itemsData = [
    'Newest First',
    'Following Shop',
    'Trending',
  ];

  String selectedValue ="";
  String trending ="";
  String newest_first ="";
  String hintText = "Short By";

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            widget.lName != "Indore" ? LoadingScaffoldMessage.showSnackbar(
            context,
            "Search location area should be Indore !!!",
            ConstantColor.primaryMainColor,
            const Duration(seconds: 2),
          ):
          _showReelsBottomSheet(context);
          },
          icon: Row(
            children: [
              const Flexible(
                child: Icon(
                  Icons.filter_list_outlined,
                  color: ConstantColor.loginWithOtpButtonColor,
                  size: 24.0,
                ),
              ),
              (selectedCount == 0)? Container():
              CircleAvatar(
                radius: 10.0,
                backgroundColor: ConstantColor.primaryMainColor,
                child: Text('${(selectedCount != 0 ? 1 : 0)}',style: ConstantTextStyle.chipText,),
              ),
            ],
          ),
        ),
        iconTheme: const IconThemeData(
          color: ConstantColor.loginWithOtpButtonColor,
        ),
        backgroundColor: ConstantColor.carColor,
        elevation: 0.0,
        centerTitle: true,
        title:
        InkWell(
          onTap: (){
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => SeeMoreReelsScreen2(id: widget.id, longitude: widget.longitude, latitude: widget.latitude, lName: widget.lName,focusKeyboard: 'true')),
          );},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(
                color: ConstantColor.primaryGreyColor
            ),
            color: ConstantColor.searchBoxColor,
          ),
          margin: EdgeInsets.symmetric(horizontal: screenWidth /80),
          padding: EdgeInsets.symmetric(horizontal: screenWidth / 40),
          height: screenHeight / 20,
          width: screenWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'Reel search...',
                  style: ConstantTextStyle.becomeSellerDiscText,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(width: screenWidth/40,),
              const Icon(
                Icons.search_rounded,
                color: ConstantColor.primaryMainColor,
              ),
            ],
          ),
        ),
      ),
        actions: [
    PopupMenuButton<String>(
            onSelected: (String value) {
              setState(() {
                page = 1;
                if (value == hintText) {
                  // If the selected value is the same as the current one, reset the value
                  selectedValue = "";
                  trending = "";
                  newest_first = "";
                  hintText = "";
                  fetchGetReels(postType: selectedPostType, selectFollowingShopType: selectedValue,trending: trending, newest_first: newest_first);
                  allReelsDataList.clear();
                }
                else {
                  // If the selected value is different, update the selectedValue and hintText
                  if (value == 'Following Shop') {
                    selectedValue = '1';
                    setState(() {
                      page = 1;
                      // selectFollowingShop = value! ? "1" : "";
                      fetchGetReels(postType: selectedPostType, selectFollowingShopType: selectedValue,newest_first: '',trending: '');
                      allReelsDataList.clear();
                    });
                  } else if (value == 'Newest First') {
                    newest_first = '1';
                    setState(() {
                      page = 1;
                      // selectFollowingShop = value! ? "1" : "";
                      fetchGetReels(postType: selectedPostType,newest_first: newest_first,selectFollowingShopType: '',trending: '');
                      allReelsDataList.clear();
                    });
                  } else if (value == 'Trending') {
                    trending = '1';
                    setState(() {
                      page = 1;
                      // selectFollowingShop = value! ? "1" : "";
                      fetchGetReels(postType: selectedPostType,trending: trending,selectFollowingShopType: '',newest_first: '');
                      allReelsDataList.clear();
                    });
                  }
                  hintText = value;

                }
                // if (value.isNotEmpty) {
                //   selectedValue = transformValue(value);
                //   hintText = value;
                // }
              });
            },
            offset: Offset(screenWidth/-40.0, screenHeight/16.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            itemBuilder: (context) {
              return itemsData.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: screenHeight/80.0,horizontal: screenWidth/30.0),
                    decoration: BoxDecoration(
                        color: ConstantColor.carColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item,
                          style: ConstantTextStyle.allHomeScreenAvatarText,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (item == hintText)
                          const Icon(
                            Icons.check_circle_outline_rounded,
                            size: 20,
                            color: ConstantColor.primaryMainColor,
                          ),
                      ],
                    ),
                  ),
                );
              }).toList();
            },
          ),

          // PopupMenuButton(
          //   offset: Offset(-screenWidth/30, screenHeight/14),
          //   icon: const Icon(Icons.more_vert_rounded, color: ConstantColor.loginWithOtpButtonColor),
          //   onSelected: (newValue) {
          //     if (newValue == 0) {
          //       // Handle "Newest First"
          //     } else if (newValue == 1) {
          //       // Handle "Following Store"
          //       // Navigator.pop(context);
          //       print("newValue-------${newValue}");
          //       setState(() {
          //         page = 1;
          //         selectFollowingShop = newValue == 1 ? "1" : "";
          //         fetchGetReels( postType: selectedPostType, selectFollowingShopType: selectFollowingShop,);
          //         allReelsDataList.clear();
          //       });
          //     } else if (newValue == 2) {
          //       // Handle "Trending"
          //     }
          //   },
          //   itemBuilder: (context) => [
          //     PopupMenuItem(
          //       value: 0,
          //       child: Container(
          //         padding: EdgeInsets.symmetric(vertical: screenHeight/80.0,horizontal: screenWidth/30.0),
          //         decoration: BoxDecoration(
          //             color: ConstantColor.primaryMainColor,
          //             borderRadius: BorderRadius.circular(10.0)),
          //         child: Row(
          //           children: [
          //             const Icon(Icons.new_releases, color: ConstantColor.primaryBackgroundMainColor, size: 18.0), // Icon for "Newest First"
          //             SizedBox(width: screenWidth/80.0),
          //             customeText(
          //               text: 'Newest First',
          //               style: ConstantTextStyle.appBarTitleText,
          //               textAlign: TextAlign.center,
          //             ),
          //
          //           ],
          //         ),
          //       ),
          //     ),
          //     PopupMenuItem(
          //       value: 1,
          //       child: Container(
          //         padding: EdgeInsets.symmetric(vertical: screenHeight/80.0,horizontal: screenWidth/30.0),
          //         decoration: BoxDecoration(
          //             color: ConstantColor.loginWithOtpButtonColor,
          //             borderRadius: BorderRadius.circular(10.0)),
          //         child: Row(
          //           children: [
          //             const Icon(Icons.storefront, color: ConstantColor.primaryBackgroundMainColor, size: 18.0), // Icon for "Following Store"
          //             SizedBox(width: screenWidth/80.0),
          //             customeText(
          //               text: 'Following Store',
          //               style: ConstantTextStyle.appBarTitleText,
          //               textAlign: TextAlign.center,
          //             ),
          //             // if (itemsData.toString() == hintText)
          //             const Icon(
          //               Icons.check_circle_outline_rounded,
          //               size: 20,
          //               color: ConstantColor.primaryMainColor,
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //     PopupMenuItem(
          //       value: 2,
          //       child: Container(
          //         padding: EdgeInsets.symmetric(vertical: screenHeight/80.0,horizontal: screenWidth/30.0),
          //         decoration: BoxDecoration(
          //             color: ConstantColor.starRatingColor,
          //             borderRadius: BorderRadius.circular(10.0)),
          //         child: Row(
          //           children: [
          //             const Icon(Icons.trending_up, color: ConstantColor.primaryBackgroundMainColor, size: 18.0), // Icon for "Trending"
          //             SizedBox(width: screenWidth/80.0),
          //             customeText(
          //               text: 'Trending',
          //               style: ConstantTextStyle.appBarTitleText,
          //               textAlign: TextAlign.center,
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ],
          // )
        ],

        //   customImg(
        //     height: screenHeight / 30,
        //     fit: BoxFit.fill,
        //     image: ConstantImage.cityBazaarStoreLogo,
        //   ),
        // ),
        // TextFormField(
        //           style: ConstantTextStyle.textFormFildStyle2,
        //           controller: searchController,
        //           onChanged: (value) {
        //             setState(() {
        //               // productName = value;
        //             });
        //           },
        //           autofocus: false,
        //           decoration: InputDecoration(
        //             labelText: 'Product Name *',
        //             labelStyle: ConstantTextStyle.topCategoryText,
        //             border: OutlineInputBorder(
        //               borderRadius: BorderRadius.circular(10.0),
        //               borderSide: const BorderSide(color: ConstantColor.secondtryGrayColor),),
        //             focusedBorder: OutlineInputBorder(
        //               borderRadius: BorderRadius.circular(10.0),
        //               borderSide: const BorderSide(color: ConstantColor.primaryMainColor),
        //             ),
        //             filled: true,
        //             fillColor:ConstantColor.primaryBackgroundMainColor,
        //             contentPadding: EdgeInsets.symmetric(horizontal:screenWidth/40),
        //           ),
        //           cursorColor: ConstantColor.primaryMainColor,
        //         ),
        titleSpacing: 0.0,
      ),
      body: isLoadingGetReals
          ? const SpinKitCircle(
          color: ConstantColor.primaryMainColor, size: 30.0)
          : allReelsDataList.isNotEmpty &&  widget.lName == "Indore"
          ? Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth / 60),
        child: SmartRefresher(
          // enablePullDown: false,
          enablePullDown: true,
          enablePullUp: true,
          footer: customFooter(),
          controller: _refreshController,
          onLoading: _onLoading,
          onRefresh: ()  {
            page = 1;
            fetchGetReels();
            fetchPreview();
            setState(() {
              for (final filterCat in childCat) {
                filterCat.isSelected = false;
              }
              selectedPostType = "";
              selectFollowingShop = "";
              selectedCategoryNamesString = "";
            });
            childCat.clear();
            allReelsDataList.clear();
            _refreshController.refreshCompleted();
          },
          child: GridView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemCount: allReelsDataList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final reelsDataHere = allReelsDataList[index];
              final storeImage = allReelsDataList[index].storeImageUrl?? '';
              final storeName = allReelsDataList[index].storeName?? '';
              final createdTimestamp = reelsDataHere.createdAt??'';
              final thumbData = baseUrl + (allReelsDataList[index].thumbnail ?? "");
              final formattedTimeDifference = calculateTimeDifference(createdTimestamp);
              final formatter = NumberFormat.compact(locale: "en_US", explicitSign: false);
              final viewsString = reelsDataHere.views?.toString() ?? '0';
              final allViews = formatter.format(int.parse(viewsString));
              // final allViews = formatter.format(int.parse(reelsDataHere.views.toString()));
              // final allLikes = formatter.format(int.parse(allReelsDataList![index].likeCount.toString()??""));
              return InkWell(
                  onTap: (){
                    ReelsViewApi.fetchViewReelsApi(reelId: allReelsDataList[index].id??"");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReelsPage(
                            getReelsId:allReelsDataList[index].id.toString(),
                            // allViewCount: allViews,
                            // allLikeCount:allLikes,
                            latitude: widget.latitude,
                            longitude: widget.longitude,
                            id: widget.id,
                            lName: widget.lName,
                            myIndex: index,
                            pageHere: ((index+1)/(limit)).ceil(),
                            myList: allReelsDataList,
                            myBaseUrl: reelsData?.baseUrl.toString()??'',
                            myLimit : limit,
                            myTotalCount : myTotalCount
                        ),
                      ),
                    );
                  },
                  child:Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ConstantColor.secondoryCardeBoarder,
                        width: 1.0,
                      ),
                      color: ConstantColor.secondoryWhiteColors,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: CachedNetworkImage(
                            height: screenHeight,
                            width: screenWidth,
                            imageUrl: thumbData ?? '',
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => storeImage != "null" && storeImage.isNotEmpty
                                ? Image.network(storeImage,
                              height: screenHeight,
                              width: screenWidth,
                              fit: BoxFit.fill,
                            )
                                : Image.asset(
                              ConstantImage.imageIsNotAvailable,
                              height: screenHeight,
                              width: screenWidth,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: screenHeight / 120,
                          left: screenHeight / 120,
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 19.0,
                                child: CircleAvatar(
                                  backgroundColor: ConstantColor.carColor,
                                  radius: 18.0,
                                  backgroundImage: storeImage != null && storeImage is String && storeImage.isNotEmpty
                                      ? NetworkImage(storeImage) // Cast storeImage to String
                                      : AssetImage(ConstantImage.imageIsNotAvailable)as ImageProvider,
                                ),
                              ),

                              SizedBox(width: screenWidth /60),
                              SizedBox(
                                width: screenWidth * 0.3,
                                child: customeText(
                                  text: storeName??'',
                                  maxLine: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: ConstantTextStyle.reviewsRatingsText,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: screenHeight /100.0,
                          left: screenWidth /60.0,
                          right: screenWidth/60.0,
                          child:
                          Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customeText(
                                text: formattedTimeDifference ?? "",
                                overflow: TextOverflow.ellipsis,
                                style: ConstantTextStyle
                                    .reviewsRatingsText,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.remove_red_eye_rounded,
                                    color: ConstantColor
                                        .primaryBackgroundMainColor,
                                    size: 0.02 * screenHeight,
                                  ),
                                  SizedBox(width: screenWidth / 80),
                                  customeText(
                                    text: allViews?? "",
                                    style: ConstantTextStyle.reviewsRatingsText,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: screenHeight/10),
                      ],
                    ),
                  ),
                );
            },
          ),
        ),
      )
          : const Center(child: Text("No Data Found!")),
    );
  }
}
