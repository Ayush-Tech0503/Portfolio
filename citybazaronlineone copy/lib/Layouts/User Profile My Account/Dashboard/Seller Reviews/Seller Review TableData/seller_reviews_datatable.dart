// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use, must_be_immutable, use_build_context_synchronously

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../Util/constaint_textstyle.dart';
import '../../../../../../Util/constant_color.dart';
import '../../../../../../Widgets/custome_text.dart';
import '../../../../../Models/SellerReview Model/sellerreview_model.dart';
import '../../../../../Util/Const Toster/toster.dart';
import '../../../../../Util/Constant APi Url/api_urls.dart';
import '../../../../../Util/constant_image.dart';
import '../../../../../Widgets/famous_market_card_widget.dart';
import '../../../../Famous Market/Store Details/Store Details Screen/store_details.dart';
import '../../Liked Products/Liked Product TableData/liked_products_datatable.dart';

class SellerReviewDataTable extends StatefulWidget {
  String id;
  String lName;
  String longitude;
  String latitude;
  SellerReviewDataTable({super.key,required this.id,required this.longitude,required this.latitude,required this.lName});

  @override
  State<SellerReviewDataTable> createState() => _SellerReviewDataTableState();
}

class _SellerReviewDataTableState extends State<SellerReviewDataTable> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // bool _isSelect = false;
  // bool _isSelect1 = false;

  UserReviewData? userReviewData;
  List<Data>? data = [];
  var responseData;

  bool isLoading = false;
  var userId;
  var tokenAccess;

  int page = 1;
  final RefreshController _refreshController1 = RefreshController(initialRefresh: false);
  void _onLoading() async {
    // monitor network fetch
    fetchSellerReviewApi();
  }

  fetchSellerReviewApi() async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      tokenAccess = preference.getString("access-token");


      if (page == 1) {
        setState(() {
          isLoading = true;
        });
      }
      //final prefs = await SharedPreferences.getInstance();
      // print("userId ${userId}");
      final body = {"page_no": page, "limit": "12", "search": ""};
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.getUserReviewApi}",
        options: Options(
          headers: {
            "Authorization": tokenAccess,
            'Content-Type': 'text/plain',
          },
        ),
        data: json.encode(body),
      );
      // loader false when user come back
      if (response.statusCode == 200) {
        responseData = json.decode(response.data);
        userReviewData = UserReviewData.fromJson(responseData);
        // print("userReviewData ${userReviewData!.data}");
        var reviewProduct = userReviewData!.data ?? [];
        //data!.addAll(userReviewData!.data??[]);
        if (reviewProduct.isNotEmpty) {
          data!.addAll(reviewProduct);
          if (page == 1) {
            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {});
            _refreshController1.loadComplete();
          }
          page += 1;
          // print("Data is here $data");
        } else {
          if (page == 1) {
            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {});
            _refreshController1.loadNoData();
          }
        }
      } else {
        _refreshController1.loadNoData();
      }
    } catch (error) {
      if (error is DioError) {
        if (error.response?.statusCode == 500) {
          // Handle 500 error
          LoadingScaffoldMessage.showSnackbar(
            context,
            "${error.message}",
            ConstantColor.primaryMainColor,
            const Duration(seconds: 5),
          );
          // print("Server error:----------- ${error.response?.statusCode}");
        } else {
          // print("Dio error: ${error.message}");
        }
      } else {}
      setState(() {
        isLoading = false;
        _refreshController1.loadNoData();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSellerReviewApi();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return
      // WillPopScope(
      // onWillPop: () async {
      //   Navigator.pushReplacement(
      //     context, MaterialPageRoute(
      //     builder: (context) =>
      //         MyHomePageDemo1(
      //           mobilenumber: "",
      //           lat: widget.latitude,
      //           longitude: widget.longitude,
      //           id: widget.id,
      //           lName: widget.lName,
      //           initialIndex: 4,
      //         ),
      //     //     BottomNavigationBarScreen(
      //     //   mobilenumber: "",
      //     //   lat: widget.latitude,
      //     //   longitude: widget.longitude,
      //     //   id: widget.id,
      //     //   lName: widget.lName,
      //     //   initialIndex: 4,
      //     // ),
      //   ),
      //   );
      //   return false; // Do not pop the current screen immediately
      // },
      // child:
      Container(
        color: ConstantColor.loginWithOtpButtonColor,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: ConstantColor.primaryBackgroundMainColor,
         /*--------------------------------------appbar section start-------------------------------------*/
            key: _scaffoldKey,
            appBar: AppBar(
              elevation: 1,
              // leadingWidth: 24,
              backgroundColor: ConstantColor.primaryBackgroundMainColor,
              iconTheme: const IconThemeData(color: ConstantColor.loginWithOtpButtonColor),
              title: customeText(textAlign: TextAlign.start,
                  text: "Seller Reviews", style: ConstantTextStyle.secodHearText),
            ),
        /*--------------------------------------appbar section end-------------------------------------*/
            body: SmartRefresher(
              enablePullDown: false,
              enablePullUp: true,
              footer: customFooter(),
              controller: _refreshController1,
              onLoading: _onLoading,
              child: ListView(
                children: [
                  Container(
                    width: double.maxFinite,
                    color: ConstantColor.primaryBackgroundMainColor,
                    padding: EdgeInsets.only(left:screenWidth/20,top: screenHeight/60,bottom: screenHeight/60 ),
                    child: customeText(
                      text: "Your Seller Reviews".toUpperCase(),
                      style: ConstantTextStyle.secodHearText,
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: ConstantColor.calendarBGHeadColor,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: screenWidth/30),
                    padding: EdgeInsets.symmetric(horizontal: screenWidth/30,vertical: screenHeight/60),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customeText(
                          text: "Image",
                          textAlign: TextAlign.start,
                          style: ConstantTextStyle.tabButtonTextStyle,
                        ),
                        SizedBox(width: screenWidth/9,),
                        Text("Product Details",
                          style: ConstantTextStyle.tabButtonTextStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight/50,),

                  isLoading? const SpinKitCircle(
                    color: ConstantColor.primaryMainColor,
                    size: 30.0,
                  )
                      :   Visibility(
                    visible: data != null && data!.isNotEmpty,
                    replacement:  Center(child: Text('No Data found!',style: ConstantTextStyle.secodHearText,)
                    ),
                    child: Column(
                      children: data!.map<Widget>((product) {
                        String avgRatingString = product.ratingNumber.toString()??"";
                        double avgRatingInt = double.tryParse(avgRatingString) ?? 0;
                        String formattedAvgRating = avgRatingInt.toStringAsFixed(2);
                        return  Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(horizontal: screenWidth/30),
                              // dense: true,
                              onTap: () { Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      StoreDetailScreen(sellersId: product.sellerId.toString()??'',
                                        id: widget.id,
                                        longitude: widget.longitude,
                                        latitude: widget.latitude,
                                        lName: widget.lName,
                                      ),
                                ),
                              );},
                              leading: Container(
                                width: screenWidth / 5,
                                height: screenHeight / 7,
                                decoration: BoxDecoration(
                                  color: ConstantColor.primaryBackgroundMainColor,
                                  borderRadius: BorderRadius.circular(8.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: ConstantColor.primaryGreyColor,
                                      blurRadius: 0.1,
                                    ),
                                  ],
                                ),
                                child:  CachedNetworkImage(
                                  imageUrl: product.storeImageUrl ?? "",
                                  fit:  BoxFit.contain,
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                        ConstantImage.imageIsNotAvailable,
                                        fit: BoxFit.contain,
                                      ),
                                ),
                              ),
                              title: Text(
                                product.storeName!.toUpperCase()??"",
                                style: ConstantTextStyle.ratingText2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.0),
                                          color: ConstantColor.primaryMainColor),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical:
                                              screenHeight / 300,
                                              horizontal: screenWidth / 80),
                                          child: customeText(
                                            text: formattedAvgRating.toString(),
                                            textAlign:
                                            TextAlign.start,
                                            style: ConstantTextStyle
                                                .loginButtonTextStyle,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: screenHeight / 100,
                                            left: screenWidth / 80),
                                        child: ratingsStar(
                                          width: screenWidth / 4,
                                          height: screenHeight / 30,
                                          bgColor: ConstantColor.transparent1,
                                          initialRating:
                                          avgRatingInt,
                                          itemSize: 16.0,
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
                                  iconRichText2(
                                    context: context,
                                    icon: Icons.location_on_outlined,
                                    color: ConstantColor.filedContainerColor,
                                    size: 14.0,
                                    text: product.storeLocAddress!.toString()??"",
                                    style: ConstantTextStyle
                                        .secondryLocationText,
                                  ),
                                  SizedBox(height: screenHeight / 100,),
                                  Text(
                                    product.dealsIn??"",
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: ConstantTextStyle
                                        .subtitleGreyText,
                                  ),
                                ],
                              ),
                            ),
                            Divider(height: screenHeight/30,), // Divider between ListTile widgets
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
             // ),
            ),
      );
  }
}
