// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, prefer_typing_uninitialized_variables, empty_catches, library_private_types_in_public_api, deprecated_member_use, must_be_immutable

import 'dart:convert';
import 'package:Citybazar_app/Layouts/Main%20Reels%20Screen/type_image_screen.dart';
import 'package:Citybazar_app/Layouts/Main%20Reels%20Screen/type_video_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Api Services/Reels Api  Services/reels_add_like_api_services.dart';
import '../../Api Services/Reels Api  Services/reels_follow_unfollow_api_services.dart';
import '../../Api Services/Reels Api  Services/reels_view_api_services.dart';
import '../../Models/Reels/reellisting_model.dart';
import '../../Util/Const Toster/toster.dart';
import '../../Util/Constant APi Url/api_urls.dart';
import '../../Util/constaint_textstyle.dart';
import '../../Util/constant_color.dart';
import '../../Widgets/Login Check Widget/login_check_widget.dart';
import '../Famous Market/Store Details/Store Details Screen/store_details.dart';
import '../User Profile My Account/Dashboard/Liked Products/Liked Product TableData/liked_products_datatable.dart';

class HomePageNavReelScreen extends StatefulWidget {
  String id;
  String latitude;
  String longitude;
  String lName;
  String? myBannerReelId;
  HomePageNavReelScreen({
    super.key,
    required this.id,
    required this.longitude,
    required this.latitude,
    required this.lName,
    this.myBannerReelId,
  });

  @override
  _HomePageNavReelScreenState createState() => _HomePageNavReelScreenState();
}

class _HomePageNavReelScreenState extends State<HomePageNavReelScreen> {
// Starting index
  // late int _currentIndex;
  // late int pagenumberhere;
// Track swipe direction

  var userId;
  var tokenAccess;
  ReelList? reelList;
  List<ReelListData>? reelDataList = [];
//------------------------------------------
  void  _onLoading() async {}

  int page = 1;
  // late int page;
  int myCount=0;
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  bool isLoading = false;
  bool hasMoreData = true;
  bool isUserLoggedIn = true;

  fetchReelDataList() async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      tokenAccess = preference.getString("access-token");
      if (page == 1) {
        setState(() {
          isLoading = true;
          reelDataList!.clear();
        });
      }
      final body = {
        "search": "",
        "page_no": page,
        "limit": "6",
        "reel_id": widget.myBannerReelId ?? '',
        "seller_id": "",
        "is_save": "",
        "post_type": "",
        "lat": "",
        "long": "",
        "city": ""
      };
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi2}${ConstantUrls.reelsVideoApi}",
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
        reelList = ReelList.fromJson(responseData);
        myBaseUrl =  reelList!.baseUrl??"";
        var myReelListData = reelList!.reelDataList ?? [];
        if (myReelListData.isNotEmpty) {
          setState(() {
            reelDataList!.addAll(myReelListData);
            isLoading = false;
          });
          page += 1;
        }
      }else{
        isLoading = false;
        _refreshController.loadNoData();
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        _refreshController.refreshCompleted();
        // _refreshController.loadNoData();
      });
    }
  }
  //------------------------------------------------------
  bool isLoadingSave = false;
  fetchSaveReelsApi({reelId,tokenAccess}) async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      tokenAccess = preference.getString("access-token");
      setState(() {
        isLoadingSave = true;
      });
      final body =  {"reel_id": reelId};
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi2}${ConstantUrls.addSaveReelsApi}",
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
          isLoadingSave = false;
          LoadingScaffoldMessage.showSnackbar(
            context,
            responseData['msg'],
            ConstantColor.primaryMainColor,
            const Duration(seconds: 1),
          );
        });
      } else {
        isLoadingSave = false;
        // Handle the error case
      }
      setState(() {});
    } catch (error) {
      setState(() {
        isLoadingSave = false;
      });
    }
  }
  //------------------------------------------------------
  void _launchWhatsApp(String? phoneWhatsapp,String? smsText) async {
    String url = 'https://wa.me/+91$phoneWhatsapp?text=${Uri.encodeComponent(smsText ?? 'I found you on CItyBazaarOnline')}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch WhatsApp $url';
    }
  }
  //------------------------------------------------------
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    fetchReelDataList();
  }
  // --------------------------------------------------------------------------
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  // --------------------------------------------------------------------------
  bool _isLoading = false;
  void _callYourAPI(reelIds,tokenAccess) {
    setState(() {
      _isLoading = true;
    });
    AddLikeApi.fetchAddLikedReels(context: context, reel_id: reelIds,tokenAccess:tokenAccess).then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }
  // ---------------------------------Share Video start-----------------------------------

  String myBaseUrl = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body:  SmartRefresher(
        enablePullDown: false,
        enablePullUp: true,
        footer: customFooter(),
        controller: _refreshController,
        onLoading: _onLoading,
        child:
        Visibility(
          visible: reelDataList != null && reelDataList!.isNotEmpty,
          replacement: Center(
            child: Text(
              'No Data found!',
              style: ConstantTextStyle.secodHearText,
            ),
          ),
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (int index) {
              setState(() {
                if(index==reelDataList!.length-1)
                {
                  fetchReelDataList();
                }
              });
              ReelsViewApi.fetchViewReelsApi(reelId: reelDataList![index].id??"");
            },
            scrollDirection: Axis.vertical,
            itemCount: reelDataList != null ? reelDataList!.length : 0,
            itemBuilder: (context, index) {
              if (reelDataList == null || reelDataList!.isEmpty) {
                return Container();
              }
              var videoDataLink = myBaseUrl + (reelDataList![index].postLink ?? '');
              var checkPostType = reelDataList![index].postType ?? ''; // Null check for postType
              var sellerNameHere = reelDataList![index].storeName ?? "";
              var storeImage = reelDataList![index].storeImageUrl ?? "";
              var sellerNumber = reelDataList![index].storeNumber ?? "";
              var sellerId = reelDataList![index].storeId ?? "";
              //------view count---
              final formatter = NumberFormat.compact(locale: "en_US", explicitSign: false);
              final allViews = formatter.format(int.parse(reelDataList![index].views.toString()??""));
              //-----like count------
              final allLikes = formatter.format(int.parse(reelDataList![index].likeCount.toString()??""));
              switch (checkPostType) {
                case "video":
                  return GestureDetector(
                    onDoubleTap: () async {
                      SharedPreferences preferences = await SharedPreferences.getInstance();
                      setState(() {
                        isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                        tokenAccess = preferences.getString("access-token");
                      });
                      if (isUserLoggedIn) {
                        setState(() {
                          reelDataList![index].isLike = "1";
                        });
                        _callYourAPI(reelDataList![index].id ?? "",tokenAccess);
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
                    child:  VideoPlayerWidget(
                      nameOnTap:(){
                        reelDataList!.clear();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StoreDetailScreen(
                              sellersId: sellerId,
                              id: widget.id,
                              longitude: widget.longitude,
                              latitude: widget.latitude,
                              lName: widget.lName,
                            ),
                          ),
                        );
                      },
                      sellerLogo: storeImage,
                      sellerName: sellerNameHere,
                      videoUrl: videoDataLink,
                      view: allViews,
                      likeCount: allLikes,
                      chatWithSellerOnPressed: () async {
                        SharedPreferences preferences = await SharedPreferences.getInstance();
                        setState(() {
                          isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                          tokenAccess = preferences.getString("access-token");
                        });
                        if (isUserLoggedIn) {
                          if (sellerNumber.isNotEmpty) {
                            _launchWhatsApp(sellerNumber, "I found you on CItyBazaarOnline");
                          }
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
                      visitStoreOnPressed: () {
                        reelDataList!.clear();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StoreDetailScreen(
                              sellersId: sellerId,
                              id: widget.id,
                              longitude: widget.longitude,
                              latitude: widget.latitude,
                              lName: widget.lName,
                            ),
                          ),
                        );
                      },
                      iconLiked:_isLoading ? Icons.refresh:reelDataList![index].isLike == "1"
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      iconLikedColor: reelDataList![index].isLike == "1"
                          ? ConstantColor.primaryMainColor
                          : ConstantColor.primaryBackgroundMainColor,
                      onTap: () async {
                        SharedPreferences preferences = await SharedPreferences.getInstance();
                        setState(() {
                          isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                          tokenAccess = preferences.getString("access-token");
                        });
                        if (isUserLoggedIn) {
                          setState(() {
                            reelDataList![index].isLike = "1";
                          });
                          _callYourAPI(reelDataList![index].id ?? "",tokenAccess);
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
                      iconSaveReel: reelDataList![index].isSave == "1"
                          ? Icons.bookmark
                          : Icons.bookmark_border_rounded,
                      iconSaveReelColor: reelDataList![index].isSave == "1"
                          ? ConstantColor.primaryMainColor
                          : ConstantColor.primaryBackgroundMainColor,
                      onTapSaveReel: () async {
                        SharedPreferences preferences = await SharedPreferences.getInstance();
                        setState(() {
                          isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                          tokenAccess = preferences.getString("access-token");
                        });
                        if (isUserLoggedIn) {
                          setState(() {
                            reelDataList![index].isSave = (reelDataList![index].isSave == "1") ? "0" : "1";
                          });
                          fetchSaveReelsApi(reelId: reelDataList![index].id ?? "",tokenAccess:tokenAccess);
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
                      iconFollow: reelDataList![index].isFollow == "1"
                          ? Icons.check_circle_outline
                          : Icons.add_circle_outline,
                      followText: reelDataList![index].isFollow == "1" ? "Following" : "Follow",
                      onTapFollowReel: () async {
                        SharedPreferences preferences = await SharedPreferences.getInstance();
                        setState(() {
                          isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                          tokenAccess = preferences.getString("access-token");
                        });
                        if (isUserLoggedIn) {
                          setState(() {
                            reelDataList![index].isFollow = (reelDataList![index].isFollow == "1") ? "0" : "1";
                          });
                          FollowUnFollow.fetchFollowUnFollow(
                              context: context,
                              sIds: reelDataList![index].storeId ?? "",
                              tokenAccess:tokenAccess,
                              follow_val: reelDataList![index].isFollow ?? "");
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
                        sellerId:reelDataList![index].storeId ?? "", reelId:reelDataList![index].id ?? "",

                    ),
                  );
                case "photo":
                case "image":
                  return GestureDetector(
                    onDoubleTap: () {
                      setState(() {
                        reelDataList![index].isLike = "1";
                      });
                      _callYourAPI(reelDataList![index].id ?? "",tokenAccess);
                    },
                    child: ImageReelWidget(
                      nameOnTap:(){
                        reelDataList!.clear();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StoreDetailScreen(
                              sellersId: sellerId,
                              id: widget.id,
                              longitude: widget.longitude,
                              latitude: widget.latitude,
                              lName: widget.lName,
                            ),
                          ),
                        );
                      },
                      sellerLogo: storeImage,
                      sellerName: sellerNameHere,
                      imageUrl: videoDataLink,
                      view: allViews,
                      likeCount: allLikes,
                      chatWithSellerOnPressed: () async {
                        SharedPreferences preferences = await SharedPreferences.getInstance();
                        setState(() {
                          isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                          tokenAccess = preferences.getString("access-token");
                        });
                        if (isUserLoggedIn) {
                          if (sellerNumber.isNotEmpty) {
                            _launchWhatsApp(sellerNumber, "I found you on CItyBazaarOnline");
                          }
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
                      visitStoreOnPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StoreDetailScreen(
                              sellersId: sellerId,
                              id: widget.id,
                              longitude: widget.longitude,
                              latitude: widget.latitude,
                              lName: widget.lName,
                            ),
                          ),
                        );
                      },
                      iconLiked: reelDataList![index].isLike == "1" ? Icons.favorite : Icons.favorite_border,
                      iconLikedColor: reelDataList![index].isLike == "1"
                          ? ConstantColor.primaryMainColor
                          : ConstantColor.primaryBackgroundMainColor,
                      onTap: () async {
                        SharedPreferences preferences = await SharedPreferences.getInstance();
                        setState(() {
                          isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                          tokenAccess = preferences.getString("access-token");
                        });
                        if (isUserLoggedIn) {
                          setState(() {
                            reelDataList![index].isLike = "1";
                          });
                          _callYourAPI(reelDataList![index].id ?? "",tokenAccess);
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
                      iconSaveReel: reelDataList![index].isSave == "1"
                          ? Icons.bookmark
                          : Icons.bookmark_border_rounded,
                      iconSaveReelColor: reelDataList![index].isSave == "1"
                          ? ConstantColor.primaryMainColor
                          : ConstantColor.primaryBackgroundMainColor,
                      onTapSaveReel: () async {
                        SharedPreferences preferences = await SharedPreferences.getInstance();
                        setState(() {
                          isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                          tokenAccess = preferences.getString("access-token");
                        });
                        if (isUserLoggedIn) {
                          setState(() {
                            reelDataList![index].isSave = (reelDataList![index].isSave == "1") ? "0" : "1";
                          });
                          fetchSaveReelsApi(reelId: reelDataList![index].id ?? "",tokenAccess:tokenAccess);
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
                      iconFollow: reelDataList![index].isFollow == "1"
                          ? Icons.check_circle_outline
                          : Icons.add_circle_outline,
                      followText: reelDataList![index].isFollow == "1" ? "Following" : "Follow",
                      onTapFollowReel: () async {
                        SharedPreferences preferences = await SharedPreferences.getInstance();
                        setState(() {
                          isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                          tokenAccess = preferences.getString("access-token");
                        });
                        if (isUserLoggedIn) {
                          setState(() {
                            reelDataList![index].isFollow = (reelDataList![index].isFollow == "1") ? "0" : "1";
                          });
                          FollowUnFollow.fetchFollowUnFollow(
                              context: context,
                              sIds: reelDataList![index].storeId ?? "",
                              tokenAccess:tokenAccess,
                              follow_val: reelDataList![index].isFollow ?? "");
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
                    ),
                  );
                default:
                  return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
/*-----------------------------------------------------------------------------------*/


