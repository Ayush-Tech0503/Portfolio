// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables, must_be_immutable

import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Api Services/Reels Api  Services/reels_view_api_services.dart';
import '../../Models/Reels/reellisting_model.dart';
import '../../Util/Constant APi Url/api_urls.dart';
import '../../Util/constaint_textstyle.dart';
import '../../Util/constant_color.dart';
import '../../Util/constant_image.dart';
import '../../Widgets/custome_text.dart';
import '../Home Page Trending Reals/See More Reels/see_more_reels.dart';
import '../Main Reels Screen/main_reels_screen.dart';
class TrendingReelsContainer extends StatefulWidget {
  // String NavigationIds;
  String id;
  String latitude;
  String longitude;
  String lName;
  TrendingReelsContainer({
     super.key,
     // required this.NavigationIds,
     required this.id,
     required this.longitude,
     required this.latitude,
     required this.lName});

  @override
  _TrendingReelsContainerState createState() => _TrendingReelsContainerState();
}
class _TrendingReelsContainerState extends State<TrendingReelsContainer> {
//------------------------------APi data start------------

  List<String> globalPostLinks = [];

  int myCount = 0;
  int myTotalPages = 0;
  int myTotalCount = 0;
  var count;
  var userId;
  var tokenAccess;
  bool isLoadingGetReals = false;
  // ReelsData? reelsData;
  ReelList? reelsData;
  List<ReelListData> allReelsDataList = [];
  int page = 1;
  int limit = 20; // Set the limit to 20
  bool hasMoreData = true; // Track if there is more data to fetch
  String selectedPostType = "";
  String selectFollowingShop = "";
  String selectCategories = "";
  String selectedCategoryNamesString = "";
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  var baseUrl;
  fetchGetReels() async {
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
        "limit":limit.toString(),
        "reel_id": "",
        "seller_id":"",
        "is_save":"",
        "cat": [],
        "is_follow":"",
        "post_type": "",
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
        String? totalCountString = reelsData!.totalCount;
        // int myTotalCount = 0; // Default value in case parsing fails or totalCount is null

        if (totalCountString != null) {
          try {
            myTotalCount = int.parse(totalCountString);
          } catch (e) {
            // Handle parsing error, assign default value, or show an error message
          }
        }
        myTotalPages = reelsData!.totalPages!;
        setState(() {
          allReelsDataList.addAll(reelsData?.reelDataList ?? []);
          if (reelsData?.reelDataList?.isEmpty ?? true) {
            hasMoreData = false; // No more data to fetch
          } else {
            hasMoreData = true;
            _refreshController.loadComplete();
            // page++;
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
//-------------------------------------------------

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
      padding: EdgeInsets.symmetric(
        vertical: screenHeight / 80,
        horizontal: screenWidth / 40,
      ),
      color: ConstantColor.primaryBackgroundMainColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
            title: customeText(
              text: "Trending Reels".toUpperCase(),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style:  ConstantTextStyle.topCategoryText, ),
            trailing:   GestureDetector(
              onTap: () { Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  SeeMoreReelsScreen(
                    id: widget.id,
                    longitude: widget.longitude,
                    latitude: widget.latitude,
                    lName: widget.lName,
                  ),
                ),
              );},
              child: customeText(
                text: "See More".toUpperCase(),
                textAlign: TextAlign.start,
                style: ConstantTextStyle.seeMoreButtonStyle,
              ),
            ),
          ),
          SizedBox(
              height: screenHeight /5.2,
              child:  isLoadingGetReals
                  ? const SpinKitCircle(
                  color: ConstantColor.primaryMainColor, size: 30.0)
                  : allReelsDataList.isNotEmpty
                  ? ListView.builder(
                    itemExtent: screenWidth/3.5,
                    itemCount: allReelsDataList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final storeImage = allReelsDataList[index].storeImageUrl?? '';
                      final storeName = allReelsDataList[index].storeName?? '';
                      final myReelId = allReelsDataList[index].id?? '';
                      final thumbData = baseUrl + (allReelsDataList[index].thumbnail ?? "");
                      return
                      GestureDetector(
                        onTap: () {
                          ReelsViewApi.fetchViewReelsApi(reelId: myReelId);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReelsPage(
                                    getReelsId: allReelsDataList[index].id.toString()??'',
                                    latitude: widget.latitude,
                                    longitude: widget.longitude,
                                    id: widget.id,
                                    lName: widget.lName,
                                      myIndex: index,
                                      pageHere: ((index+1)/(limit)).ceil()??0,
                                      myList: allReelsDataList,
                                      myBaseUrl: reelsData?.baseUrl.toString()??'',
                                      myLimit : limit,
                                      myTotalCount : myTotalCount
                                  ),
                              ));
                        },
                        child: Container(
                         margin: EdgeInsets.only(right: screenWidth/60),
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
                                  height: screenHeight / 4,
                                  width: screenWidth / 3.5,
                                  imageUrl: thumbData ?? '',
                                  imageBuilder: (context, imageProvider) => Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => storeImage != "" && storeImage.isNotEmpty
                                      ? Image.network(
                                    storeImage,
                                    height: screenHeight,
                                    width: screenWidth,
                                    fit: BoxFit.fill,
                                  ) : Image.asset(
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
                                child: CircleAvatar(
                                  backgroundColor: ConstantColor.primaryBackgroundMainColor,
                                  radius: 19,
                                  child: CircleAvatar(
                                    backgroundColor: ConstantColor.primaryBackgroundMainColor,
                                    radius: 18,
                                    backgroundImage: storeImage != null && storeImage is String && storeImage.isNotEmpty
                                        ? NetworkImage(storeImage) // Cast storeImage to String
                                        : AssetImage(ConstantImage.imageIsNotAvailable)as ImageProvider,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: screenHeight/60.0,
                                left: screenHeight / 100.0,
                                child:SizedBox(
                                  width: screenWidth/5,
                                  child: customeText(
                                    text: storeName??'',
                                    maxLine: 1,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    style: ConstantTextStyle.trendingReelsText,
                                  ),
                                ),

                              ),
                            ],
                          ),
                        ),
                      );
                      //: null;
                    },
                  ): const Center(child: Text("Sorry No Reel Found!"),)
          ),
        ],
      ),
    );
  }
}

