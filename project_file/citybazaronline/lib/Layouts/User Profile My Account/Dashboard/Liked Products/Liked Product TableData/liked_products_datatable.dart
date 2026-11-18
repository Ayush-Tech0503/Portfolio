// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../Util/constaint_textstyle.dart';
import '../../../../../../Util/constant_color.dart';
import '../../../../../../Widgets/custome_imagies.dart';
import '../../../../../../Widgets/custome_text.dart';
import '../../../../../Models/Liked Product Model/likedproduct_model.dart';
import '../../../../../Util/Constant APi Url/api_urls.dart';
import '../../../../../Util/constant_token.dart';
import '../../../../../Widgets/famous_market_card_widget.dart';

class LikedProductsDataTable extends StatefulWidget {
  const LikedProductsDataTable({super.key});

  @override
  State<LikedProductsDataTable> createState() => _LikedProductsDataTableState();
}

class _LikedProductsDataTableState extends State<LikedProductsDataTable> {
  final ScrollController _scrollController = ScrollController();
  LikedProductData? likedProductData;
  List<LikedProductList>? data = [];
  var responseData;

  bool isLoading = false;
  var userId;
  int page = 1;
  final RefreshController _refreshController1 = RefreshController(initialRefresh: false);
  void _onLoading() async {
    // monitor network fetch
    fetchLikedDataApi();
  }

  fetchLikedDataApi() async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");

      if(page==1){
        setState(() {
          isLoading = true;
        });
      }

/*-------------------------------loader----------------------------------*/

/*-------------------------------loader----------------------------------*/
      //final prefs = await SharedPreferences.getInstance();
      final body = {"user_id": userId, "page_no": page, "limit": "20"};
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.getLikedProductApi}",
        options: Options(
          headers: {
            "Authorization": ConstantToken.authorizationToken,
            'Content-Type': 'text/plain',
          },
        ),
        data: json.encode(body),
      );
      // loader false when user come back
      if (response.statusCode == 200) {
        responseData = json.decode(response.data);
        likedProductData = LikedProductData.fromJson(responseData);
     //   data!.addAll(likedProductData!.data ?? []);

        var likedProduct = likedProductData!.data ?? [];
        if (likedProduct.isNotEmpty) {
          data!.addAll(likedProduct);
          if (page == 1) {
            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {});
            _refreshController1.loadComplete();
          }
          page += 1;
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
      }else{
        _refreshController1.loadNoData();
      }
    } catch (e) {
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
    fetchLikedDataApi();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.width;
    return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SmartRefresher(
                enablePullDown: false,
                enablePullUp: true,
                footer: customFooter(),
                controller: _refreshController1,
                onLoading: _onLoading,
                // ... other properties
                child:

                SingleChildScrollView(
                  child: Column(
                    children: [
                       DataTable(
                              dataRowHeight: screenHeight / 5,
                              showBottomBorder: true,
                              dividerThickness: 0.5,
                              headingRowColor:
                              MaterialStateProperty.resolveWith(
                                    (states) => ConstantColor.calendarBGHeadColor,
                              ),
                              headingRowHeight: screenHeight / 10,
                              columns: [
                                DataColumn(
                                  //
                                  label: customeText(
                                    text: "Product ",
                                    textAlign: TextAlign.start,
                                    style: ConstantTextStyle.tabButtonTextStyle,
                                  ),
                                ),
                                DataColumn(
                                  label: customeText(
                                    text: "Product Details",
                                    textAlign: TextAlign.start,
                                    style: ConstantTextStyle.tabButtonTextStyle,
                                  ),
                                ),
                                // DataColumn(
                                //   label:customeText(text: "Action",
                                //     textAlign: TextAlign.start, style:ConstantTextStyle.tabButtonTextStyle,),),
                              ],
                              rows:data!=null? data!.map((product) {
                                return DataRow(cells: [
                                  DataCell(
                                    boxImage(
                                        backGroundColor: ConstantColor
                                            .primaryBackgroundMainColor,
                                        backGroundborderRadius:
                                        BorderRadius.circular(8.0),
                                        shadowColor: ConstantColor.carColor,
                                        blurRadius: 20.0,
                                        borderColor: ConstantColor.carColor,
                                        image: product.productImgUrl,
                                        imageHeight: screenHeight / 10,
                                        imageWidth: screenWidth / 10),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      width: screenWidth / 2,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          iconRichText2(
                                            context: context,
                                            icon: Icons.store_outlined,
                                            color: ConstantColor
                                                .filedContainerColor,
                                            size: 14.0,
                                            text: product.productName!
                                                .toUpperCase(),
                                            style: ConstantTextStyle
                                                .skyBlueColorShopName,
                                          ),
                                          SizedBox(
                                            height: screenHeight / 100,
                                          ),
                                          customeText(
                                            text: product.storeName!
                                                .toUpperCase(),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style:
                                            ConstantTextStyle.ratingText2,
                                          ),
                                          SizedBox(
                                            height: screenHeight / 100,
                                          ),
                                          iconRichText2(
                                            context: context,
                                            icon: Icons.currency_rupee_outlined,
                                            color: ConstantColor
                                                .filedContainerColor,
                                            size: 14.0,
                                            text: product.price.toString(),
                                            style: ConstantTextStyle
                                                .becomeSellerDiscText,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // DataCell(
                                  //   iconTextButton(
                                  //     backgroundColor: ConstantColor.secondoryMarketColors,
                                  //     icon: Icons.thumb_up_alt_outlined,
                                  //     iconColor: ConstantColor.primaryMainColor,
                                  //     iconSize: 20.0,
                                  //     // elevation: 5.0,
                                  //     buttonOnPressed: () {},
                                  //     buttontext: "Name",
                                  //     buttontextStyle: ConstantTextStyle.otpResendButtonText,
                                  //     //    fixedSize: const Size(190, 1),
                                  //   ),
                                  // ),
                                ]);
                              }).toList():[],
                            ),


                    ],
                  ),
                ),
                ),




    );

      SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: screenHeight / 30, horizontal: screenWidth / 30),
        child: Column(children: [
/*------------------------Add More Button end -------------------------------------------*/

          Container(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth / 40, vertical: screenHeight / 20),
            decoration: BoxDecoration(
              color: ConstantColor.sellerBGColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ScrollbarTheme(
              data: ScrollbarThemeData(
                crossAxisMargin: 2.5,
                radius: const Radius.circular(10.0),
                thickness: MaterialStateProperty.all(5.0),
                trackBorderColor:
                    MaterialStateProperty.all(ConstantColor.trackBGolor),
                thumbColor:
                    MaterialStateProperty.all(ConstantColor.primaryMainColor),
                trackColor:
                    MaterialStateProperty.all(ConstantColor.trackBGolor),
              ),
              child: Scrollbar(
                controller: _scrollController,
                trackVisibility: true,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: isLoading
                      ? const SpinKitCircle(
                          color: ConstantColor.primaryMainColor,
                          size: 40.0,
                        )
                      :  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DataTable(
                                  dataRowHeight: screenHeight / 5,
                                  showBottomBorder: true,
                                  dividerThickness: 0.5,
                                  headingRowColor:
                                      MaterialStateProperty.resolveWith(
                                    (states) => ConstantColor.calendarBGHeadColor,
                                  ),
                                  headingRowHeight: screenHeight / 10,
                                  columns: [
                                    DataColumn(
                                      //
                                      label: customeText(
                                        text: "Product Image",
                                        textAlign: TextAlign.start,
                                        style: ConstantTextStyle.tabButtonTextStyle,
                                      ),
                                    ),
                                    DataColumn(
                                      label: customeText(
                                        text: "Product Details",
                                        textAlign: TextAlign.start,
                                        style: ConstantTextStyle.tabButtonTextStyle,
                                      ),
                                    ),
                                    // DataColumn(
                                    //   label:customeText(text: "Action",
                                    //     textAlign: TextAlign.start, style:ConstantTextStyle.tabButtonTextStyle,),),
                                  ],
                                  rows: data!.map((product) {
                                    return DataRow(cells: [
                                      DataCell(
                                        boxImage(
                                            backGroundColor: ConstantColor
                                                .primaryBackgroundMainColor,
                                            backGroundborderRadius:
                                                BorderRadius.circular(8.0),
                                            shadowColor: ConstantColor.carColor,
                                            blurRadius: 20.0,
                                            borderColor: ConstantColor.carColor,
                                            image: product.productImgUrl,
                                            imageHeight: screenHeight / 10,
                                            imageWidth: screenWidth / 10),
                                      ),
                                      DataCell(
                                        SizedBox(
                                          width: screenWidth / 2,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              customeText(
                                                text: product.storeName!
                                                    .toUpperCase(),
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                style:
                                                    ConstantTextStyle.ratingText2,
                                              ),
                                              SizedBox(
                                                height: screenHeight / 100,
                                              ),
                                              iconRichText2(
                                                context: context,
                                                icon: Icons.store_outlined,
                                                color: ConstantColor
                                                    .filedContainerColor,
                                                size: 14.0,
                                                text: product.productName!
                                                    .toUpperCase(),
                                                style: ConstantTextStyle
                                                    .skyBlueColorShopName,
                                              ),
                                              SizedBox(
                                                height: screenHeight / 100,
                                              ),
                                              iconRichText2(
                                                context: context,
                                                icon: Icons.currency_rupee_outlined,
                                                color: ConstantColor
                                                    .filedContainerColor,
                                                size: 14.0,
                                                text: product.price.toString(),
                                                style: ConstantTextStyle
                                                    .becomeSellerDiscText,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // DataCell(
                                      //   iconTextButton(
                                      //     backgroundColor: ConstantColor.secondoryMarketColors,
                                      //     icon: Icons.thumb_up_alt_outlined,
                                      //     iconColor: ConstantColor.primaryMainColor,
                                      //     iconSize: 20.0,
                                      //     // elevation: 5.0,
                                      //     buttonOnPressed: () {},
                                      //     buttontext: "Name",
                                      //     buttontextStyle: ConstantTextStyle.otpResendButtonText,
                                      //     //    fixedSize: const Size(190, 1),
                                      //   ),
                                      // ),
                                    ]);
                                  }).toList(),
                                ),
                                SizedBox(
                                  height: screenHeight / 20,
                                ),
                              ],
                            ),
                        ),
                      ),
                ),
              ),


        ]),
      ),
    );
  }
}
Widget customFooter() {
  return CustomFooter(
    builder: (BuildContext context, status) {
      Widget body;
      if (status == LoadStatus.idle) {
        body = const Text("");
      } else if (status == LoadStatus.loading) {
        body = const CupertinoActivityIndicator();
      } else if (status == LoadStatus.failed) {
        body = const Text("Load Failed!Click retry!");
      } else if (status == LoadStatus.canLoading) {
        body = const Text("release to load more");
      } else {
        body = const Text(
          "No More Data",
          style: TextStyle(
              color: ConstantColor.filedContainerColor, fontWeight: FontWeight.w500),
        );
      }
      return SizedBox(
        height: 55.0,
        child: Center(child: body),
      );
    },
  );
}

