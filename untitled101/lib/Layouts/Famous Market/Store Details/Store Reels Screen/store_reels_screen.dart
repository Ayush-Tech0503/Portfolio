// ignore_for_file: deprecated_member_use, non_constant_identifier_names, prefer_typing_uninitialized_variables, library_private_types_in_public_api, duplicate_ignore, must_be_immutable, empty_catches

import 'dart:convert';
import 'package:Citybazar_app/Util/constaint_textstyle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Api Services/Reels Api  Services/reels_view_api_services.dart';
import '../../../../Models/Reels/reellisting_model.dart';
import '../../../../Util/Constant APi Url/api_urls.dart';
import '../../../../Util/constant_color.dart';
import '../../../../Util/constant_image.dart';
import '../../../../Widgets/custome_text.dart';
import '../../../Main Reels Screen/main_reels_screen.dart';
import '../../../User Profile My Account/Dashboard/Liked Products/Liked Product TableData/liked_products_datatable.dart';


String? VideoData;

class StoreReelScreen extends StatefulWidget {
  String SellerIds;
  String newSellerId;
  String id;
  String latitude;
  String longitude;
  String lName;
  StoreReelScreen({super.key,
    required this.SellerIds,
    required this.newSellerId,
    required this.id,
    required this.longitude,
    required this.latitude,
    required this.lName});

  @override
  // ignore: library_private_types_in_public_api
  _StoreReelScreenState createState() => _StoreReelScreenState();
}

class _StoreReelScreenState extends State<StoreReelScreen> {

  //------------------------------APi data start------------
  int myCount = 0;
  int myTotalPages = 0;
  int myTotalCount = 0;
  var userId;
  var tokenAccess;
  bool isLoadingGetReals = false;
  ReelList? reelsData;
  List<ReelListData> allReelsDataList = [];
  int page = 1;
  int limit = 8; // Set the limit to 20
  bool hasMoreData = true; // Track if there is more data to fetch
  String selectedPostType = "";
  String selectFollowingShop = "";
  String selectCategories = "";
  String selectedCategoryNamesString = "";
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  var baseUrl;
  fetchGetReels({postType,selectFollowingShopType}) async {
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
      "seller_id":widget.newSellerId??"",
        "limit":limit.toString(),
        "reel_id": "",
        "is_save":"",
        // "cat": [selectedCategoryNamesString],
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
        // var responseData = json.decode(response.data.toString());
        // reelsData = ReelsData.fromJson(responseData);
        baseUrl = reelsData!.baseUrl.toString();
        myCount = reelsData!.count! + myCount;
        dynamic totalCountString = reelsData!.totalCount;
        // int myTotalCount = 0; // Default value

        if (totalCountString != null) {
          try {
            if (totalCountString is String) {
              myTotalCount = int.parse(totalCountString); // If it's a string, attempt to parse it to an integer
            }
            else if (totalCountString is int) {
              myTotalCount = totalCountString;    // If it's already an integer, use it directly
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
  void _onLoading() async {
    await fetchGetReels();
    if (!hasMoreData) {
      _refreshController.loadNoData();
    } else {
      _refreshController.loadComplete();
    }
  }
//------------------------------------------

  @override
  void initState() {
    super.initState();
    fetchGetReels();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: ConstantColor.loginWithOtpButtonColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ConstantColor.primaryBackgroundMainColor,
          //------------------------------body area start ------------------------------
          body: isLoadingGetReals
              ? const SpinKitCircle(
              color: ConstantColor.primaryMainColor, size: 30.0)
              : allReelsDataList.isNotEmpty
              ? Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth / 60),
            child: SmartRefresher(
              enablePullDown: false,
              enablePullUp: true,
              footer: customFooter(),
              controller: _refreshController,
              onLoading: _onLoading,
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
                  final myReelId = allReelsDataList[index].id?? '';
                  final createdTimestamp = reelsDataHere.createdAt??'';
                  final thumbData = baseUrl + (allReelsDataList[index].thumbnail ?? "");
                  final formattedTimeDifference = calculateTimeDifference(createdTimestamp ?? "");
                  final allViews = reelsDataHere.views;
                  return InkWell(
                    onTap: (){
                      ReelsViewApi.fetchViewReelsApi(reelId:myReelId);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReelsPage(
                            getReelsId: allReelsDataList[index].id.toString()??'',
                            latitude: widget.latitude,
                            longitude: widget.longitude,
                            id: widget.id,
                            lName: widget.lName,
                              SellerIds: widget.SellerIds,
                              myIndex: index,
                              pageHere: ((index+1)/(limit)).ceil()??0,
                              myList: allReelsDataList,
                              myBaseUrl: reelsData?.baseUrl.toString()??'',
                              myLimit : limit,
                              myTotalCount : myTotalCount
                          ),
                        ),
                      );
                    },
                    child: Container(
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
                              errorWidget: (context, url, error) => storeImage != null && storeImage.isNotEmpty
                                  ? Image.network(
                                storeImage,
                                height: screenHeight,
                                width: screenWidth,
                                fit: BoxFit.fill,
                              )
                                  : Image.asset(
                                ConstantImage.imageIsNotAvailable,
                                height: screenHeight,
                                width: screenWidth,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Positioned(
                            top: screenHeight / 100,
                            left: screenHeight / 100,
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
                                SizedBox(width: screenWidth / 40),
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
                                      text: allViews ?? "",
                                      style: ConstantTextStyle.reviewsRatingsText,
                                    ),
                                  ],
                                ),
                                // SizedBox(width: screenWidth / 80),

                                // SizedBox(width: screenWidth / 15),
                                // Icon(
                                //   Icons.remove_red_eye_rounded,
                                //   color: ConstantColor
                                //       .primaryBackgroundMainColor,
                                //   size: 0.02 * screenHeight,
                                // ),
                                // SizedBox(width: screenWidth / 80),
                                // customeText(
                                //   text: allViews ?? "",
                                //   style: ConstantTextStyle
                                //       .reviewsRatingsText,
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
              : const Center(child: Text("No Data Found!")),
        ),
      ),
    );
  }
}




// dynamic? totalCountString = reelsData!.totalCount;
// // int myTotalCount = 0; // Default value in case parsing fails or totalCount is null
//
// if (totalCountString != null) {
//   try {
//     myTotalCount = totalCountString ?? 0;
//     // int.parse(totalCountString);
//   } catch (e) {
//     // Handle parsing error, assign default value, or show an error message
//   }
// }
// myTotalPages = reelsData!.totalPages!;