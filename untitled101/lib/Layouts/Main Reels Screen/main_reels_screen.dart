// ignore_for_file: prefer_typing_uninitialized_variables, library_private_types_in_public_api, non_constant_identifier_names, deprecated_member_use, must_be_immutable, empty_catches, use_build_context_synchronously
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
import '../../services/KPI Api Service /product_kpi_api_services.dart';
import '../Famous Market/Store Details/Store Details Screen/store_details.dart';
import '../Onboarding Screens/alert_registration_form.dart';
import '../User Profile My Account/Dashboard/Liked Products/Liked Product TableData/liked_products_datatable.dart';
class Reel {
  final String videoUrl;

  Reel({required this.videoUrl});
}

class ReelsPage extends StatefulWidget {
  String id;
  String getReelsId;
  String latitude;
  String longitude;
  // String? allViewCount;
  // String? allLikeCount;
  String lName;
  String? myBannerReelId;
  String? myBaseUrl;
  String? SellerIds;
  int? pageHere;
  int? myIndex;
  int? myTotalCount;
  int? myLimit;
  final List<ReelListData>? myList;
  // int? pagenumber;
  ReelsPage({
    super.key,
    required this.id,
    required this.getReelsId,
    required this.longitude,
    required this.latitude,
    this.myIndex,
     // this.allViewCount,
     // this.allLikeCount,
     this.myBannerReelId,
     this.pageHere,
     this.SellerIds,
     this.myLimit,
     this.myTotalCount,
     this.myBaseUrl,
    required this.lName,  this.myList});

  @override
  _ReelsPageState createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {
  // int _currentIndex = 0; // Starting index
  late int _currentIndex;
  // late int pagenumberhere;

  var userId;
  var tokenAccess;
  ReelList? reelList;
  List<ReelListData>? reelDataList = [];
//------------------------------------------
  void  _onLoading() async {}
  // int page = 1;
  late int page;
 int myCount=0;
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  bool isLoading = false;
  bool isUserLoggedIn = false;
  bool hasMoreData = true;
  var baseUrl;
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
        "search":"",
        "user_id": userId,
        "page_no":page,
        "limit":10,
        "reel_id": widget.myBannerReelId ?? '',
        "seller_id":widget.SellerIds??"",
        "is_save":"",
        "trending": "",
        "newest_first":  "",
        "cat":  [],
        "is_follow":"",
        "post_type":"",
        "lat": (widget.id != "" && widget.lName != "") ? widget.latitude:"22.7177",
        "long": (widget.id != "" && widget.lName != "") ? widget.longitude: "75.8545",
        "city": (widget.id != "" && widget.lName != "") ? widget.lName: "Indore"
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
        var myReelListData = reelList!.reelDataList ?? [];
        if (myReelListData.isNotEmpty) {
          setState(() {
            myCount = reelList!.count! + myCount;
            reelDataList!.addAll(myReelListData);
            isLoading = false;
          });
        }
      }else{
        isLoading = false;
        _refreshController.loadNoData();
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        _refreshController.refreshCompleted();
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
    // _handleMyUri();
    page = widget.pageHere ?? 1;
    _currentIndex = widget.myIndex ?? 0;
    _pageController = PageController(initialPage: _currentIndex);
    baseUrl=widget.myBaseUrl;
    if((widget.myIndex!+1)==widget.myList!.length)
      {
          page++;
          fetchReelDataList();
      }

    var myReelListData = widget.myList ?? [];
    if (myReelListData.isNotEmpty) {
      setState(() {
        reelDataList!.clear();
        myCount=myReelListData.length;
        reelDataList!.addAll(myReelListData);
        // isLoading = false;
      });
    }
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      checkAndShowRegistrationDialog();
    });
  }
  // --------------------------------------------------------------------------
  //--------------------popup form start -------------

  void checkAndShowRegistrationDialog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isProfileCompleted = prefs.getBool("isProfileCompleted") ?? false;
    String createdDateStr = prefs.getString("created_date") ?? '';
    if (!isProfileCompleted) {
      DateTime? createdDate = DateTime.tryParse(createdDateStr);
      if (createdDate != null) {
        DateTime currentDate = DateTime.now();
        int daysDifference = currentDate.difference(createdDate).inDays;
        // Check if it's the 1st, 3rd, 5th, or 7th day, or every 15th day
        if (
        daysDifference == 3 ||
            daysDifference == 6 ||
            daysDifference == 7 ||
            daysDifference % 16 == 0) {
          // Show the dialog
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return  const AlertRegistrationForm();
            },
          );
        }
      }
    }
  }

//--------------------popup form end -------------
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
  // var allViews = 0;
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        key: _scaffoldKey,
        body: SmartRefresher(
          enablePullDown: false,
          enablePullUp: true,
          footer: customFooter(),
          controller: _refreshController,
          onLoading: _onLoading,
          child:
          Visibility(
            visible: reelDataList != null && reelDataList!.isNotEmpty,
            replacement: Center(
              child: Text('No Data found!',
                style: ConstantTextStyle.secodHearText,
              ),
            ),
            child: PageView.builder(
        controller: _pageController,
            onPageChanged: (int index) {
        setState(() {
          _currentIndex = index;
          if(index==reelDataList!.length-1)
            {
              page=page+1;
              fetchReelDataList();
            }
        });
           ReelsViewApi.fetchViewReelsApi(reelId: reelDataList![index].id);
            },
              scrollDirection: Axis.vertical,
              itemCount: reelDataList != null ? reelDataList!.length : 0,
                  itemBuilder: (context, index) {
                if (reelDataList == null || reelDataList!.isEmpty) {
                  return Container();
                }
                var videoDataLink =  baseUrl + (reelDataList![index].postLink ?? '');
                var checkPostType = reelDataList![index].postType ?? '';
                var sellerNameHere = reelDataList![index].storeName ?? "";
                var reelId = reelDataList![index].id ?? "";
                var storeImage = reelDataList![index].storeImageUrl ??"";
                var sellerNumber = reelDataList![index].storeNumber ?? "";
                var sellerId = reelDataList![index].storeId ?? "";
                var whatsapptext = reelDataList![index].whatsapptext ?? "";
                var shareLink = "https://citybazaronline.com" ??"";
                // var shareLink = "https://97s191qv-3000.inc1.devtunnels.ms" ??"";
                // var shareLink = "https://fir-tutorial-17116.web.app" ??"";
                // var shareLink = "https://r4xj0ng5-3000.inc1.devtunnels.ms" ??"";
                // var shareLink = reelDataList![index].share_link ?? "";
                //------view count---
                final formatter = NumberFormat.compact(locale: "en_US", explicitSign: false);
                final allViews = reelDataList![index].views != null
                    ? formatter.format(int.parse(reelDataList![index].views!))
                    : "0";
                //-----like count------
                // Handle like count
                final allLikes = reelDataList![index].likeCount != null
                    ? formatter.format(int.parse(reelDataList![index].likeCount!))
                    : "0";
             //   final allLikes = formatter.format(int.parse(reelDataList![index].likeCount.toString()??""));
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
                      child:VideoPlayerWidget(
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
                        sellerLogo: storeImage.toString(),
                        sellerName: sellerNameHere,
                        videoUrl: videoDataLink,
                        view: allViews.toString(),
                        //allViews.toString(),
                          likeCount:allLikes,
                        chatWithSellerOnPressed: () async {
                          SharedPreferences preferences = await SharedPreferences.getInstance();
                          setState(() {
                            isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                            tokenAccess = preferences.getString("access-token");
                          });
                          if (isUserLoggedIn) {
                            if (sellerNumber.isNotEmpty) {
                               _launchWhatsApp(sellerNumber, whatsapptext ?? "I found you on CItyBazaarOnline");
                            }
                           await productPageKpiApiServices(type: 'chat_with_seller_reel',productId: reelId??"");
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
                        iconLiked:_isLoading ? Icons.refresh: reelDataList![index].isLike == "1"
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
                          // storeImage:storeImage,
                          shareLink:shareLink??"",
                          cityName: widget.lName??"indore",
                          sellerId:sellerId,
                          reelId:reelId
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
                        sellerLogo: storeImage.toString(),
                        sellerName: sellerNameHere,
                        sellerId: sellerId,
                        reelId:reelId,
                        imageUrl: videoDataLink,
                        shareLink: shareLink,
                        cityName: widget.lName??"Indore",
                        view: allViews.toString(),
                        likeCount: allLikes,
                        chatWithSellerOnPressed: () async {
                          SharedPreferences preferences = await SharedPreferences.getInstance();
                          setState(() {
                            isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                            tokenAccess = preferences.getString("access-token");
                          });
                          if (isUserLoggedIn) {
                            if (sellerNumber.isNotEmpty) {
                              _launchWhatsApp(sellerNumber, whatsapptext ?? "I found you on CItyBazaarOnline");
                            }
                            await productPageKpiApiServices(type: 'chat_with_seller_reel',productId: reelId??"");
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
                        onTapFollowReel: ()  async {
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
              // autoplay: false,
              // autoplayDelay: _autoplayDelay,
            ),
          ),
        ),
            );
  }
}
/*-----------------------------------------------------------------------------------*/


class MyDataObject {
  final String url;
  final String id;

  MyDataObject({required this.url, required this.id});

  factory MyDataObject.fromJson(Map<String, dynamic> json) {
    return MyDataObject(
      url: json['url'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'id': id,
    };
  }
}

