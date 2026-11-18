// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables, must_be_immutable, use_build_context_synchronously

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
import '../../../../../Models/BookedProduct Model/bookedproduct_model.dart';
import '../../../../../Util/Const Toster/toster.dart';
import '../../../../../Util/Constant APi Url/api_urls.dart';
import '../../../../../Util/constant_image.dart';
import '../../../../../Widgets/famous_market_card_widget.dart';
import '../../../../Product View Screens/product_Item_Details.dart';
import '../../Liked Products/Liked Product TableData/liked_products_datatable.dart';

class BookedProductDataTable extends StatefulWidget {
  String id;
  String lName;
  String longitude;
  String latitude;
   BookedProductDataTable({super.key,required this.id,required this.longitude,required this.latitude,required this.lName});

  @override
  State<BookedProductDataTable> createState() => _BookedProductDataTableState();
}

class _BookedProductDataTableState extends State<BookedProductDataTable> {
  final ScrollController _scrollController = ScrollController();

  final bool _isSelect = false;
  var userId;
  BookedDataModel? bookedDataModel;
  List<BookedDataList>? data = [];
  bool isLoading = false;
  var responseData;
  int page = 1;
  final RefreshController _refreshController1 =
  RefreshController(initialRefresh: false);
  void _onLoading() async {
    // monitor network fetch
    fetchBookedDataApi();
  }
  var tokenAccess;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  fetchBookedDataApi() async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      tokenAccess = preference.getString("access-token");
      if(page==1){
        setState(() {
          isLoading = true;
        });
      }
      final body = {"user_id": userId, "page_no": page, "limit": '12'};
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.getBookedProductsApi}",
        options: Options(
          headers: {
            "Authorization": tokenAccess,
            'Content-Type': 'text/plain',
          },
        ),
        data: json.encode(body),
      );
      if (response.statusCode == 200) {
        responseData = json.decode(response.data);
        bookedDataModel = BookedDataModel.fromJson(responseData);
        var bookedProduct = bookedDataModel!.data ?? [];
        if (bookedProduct.isNotEmpty) {
          data!.addAll(bookedProduct);
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
        setState(() {
          isLoading = false;
        });
      }else{
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

  //---------------------------------------------------------
  bool isLoadingDeleteBookProduct = false;
  fetchDeleteProductAPi({prodId,wantBuy}) async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      tokenAccess = preference.getString("access-token");
      setState(() {
        isLoadingDeleteBookProduct = true;
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
        setState(() {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BookedProductDataTable(
                id: widget.id ?? "",
                lName: widget.lName ?? "",
                latitude: widget.latitude ?? "",
                longitude: widget.longitude ?? "",
              ),
            ),
          );
          isLoadingDeleteBookProduct = false;
          LoadingScaffoldMessage.showSnackbar(
            context,
            responseData['msg'],
            ConstantColor.primaryMainColor,
            const Duration(seconds: 2),
          );
        });
      } else {
        setState(() {
          isLoadingDeleteBookProduct = false;
          LoadingScaffoldMessage.showSnackbar(
            context,
            responseData['msg'],
            ConstantColor.primaryMainColor,
            const Duration(seconds: 2),
          );
        });
      }
    } catch (error) {
      setState(() {
        isLoadingDeleteBookProduct = false;
          LoadingScaffoldMessage.showSnackbar(
            context,
            responseData['msg'],
            ConstantColor.primaryMainColor,
            const Duration(seconds: 2),
          );
      });
    }
  }


  //---------------------------------------------------------

  @override
  void initState() {
    super.initState();
    fetchBookedDataApi();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.width;
    return Container(
        color: ConstantColor.loginWithOtpButtonColor,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: ConstantColor.primaryBackgroundMainColor,
                      appBar: AppBar(
                        elevation: 1,
                        backgroundColor: ConstantColor.primaryBackgroundMainColor,
                        iconTheme: const IconThemeData(color: ConstantColor.loginWithOtpButtonColor),
                        title: customeText(textAlign: TextAlign.start,
                            text: "Booked Products", style: ConstantTextStyle.secodHearText),
                      ),
                      key: _scaffoldKey,
                      body:  SmartRefresher(
                        enablePullDown: false,
                        enablePullUp: true,
                        footer: customFooter(),
                        controller: _refreshController1,
                        onLoading: _onLoading,
                        child:
                        ListView(
                          children: [
                            Container(
                              width: double.maxFinite,
                              color: ConstantColor.primaryBackgroundMainColor,
                              padding:EdgeInsets.only(left:screenWidth/20,top: screenHeight/50,bottom: screenHeight/30  ),
                              child: customeText(
                                text: "Your Booking Products".toUpperCase(),
                                style: ConstantTextStyle.secodHearText,
                              ),
                            ),

                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: ConstantColor.calendarBGHeadColor,
                              ),
                              margin: EdgeInsets.symmetric(horizontal: screenWidth/30),
                              padding: EdgeInsets.symmetric(horizontal: screenWidth/30,vertical: screenHeight/30),
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
                                  return  Column(
                                      children: [
                                        ListTile(
                                          contentPadding: EdgeInsets.symmetric(horizontal: screenWidth/30),
                                          // dense: true,
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  ProductDetailScreen(
                                              proId: product.productId ?? "", id: widget.id,latitude: widget.latitude,longitude: widget.longitude,lName: widget.lName,
                                            )));
                                          },
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
                                              imageUrl: product.productImgUrl ?? "",
                                              fit:  BoxFit.contain,
                                              errorWidget: (context, url, error) =>
                                                  Image.asset(
                                                    ConstantImage.imageIsNotAvailable,
                                                    fit: BoxFit.contain,
                                                  ),
                                            ),
                                          ),
                                          title: Text(
                                            product.productName!.toUpperCase(),
                                            style: ConstantTextStyle.ratingText2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              iconRichText2(
                                                context: context,
                                                icon: Icons.store_outlined,
                                                color: ConstantColor.filedContainerColor,
                                                size: 14.0,
                                                text: product.storeName!.toUpperCase(),
                                                style: ConstantTextStyle.skyBlueColorShopName,
                                              ),
                                              SizedBox(height: screenHeight / 100),
                                              iconRichText2(
                                                context: context,
                                                icon: Icons.currency_rupee_outlined,
                                                color: ConstantColor.filedContainerColor,
                                                size: 14.0,
                                                text:product.price,
                                                style: ConstantTextStyle.becomeSellerDiscText,),
                                              SizedBox(height: screenHeight/100,),
                                              iconRichText2(
                                                context: context,
                                                icon: Icons.calendar_month_outlined,
                                                color: ConstantColor.filedContainerColor,
                                                size: 14.0,
                                                text: product.createdDate,
                                                style: ConstantTextStyle.becomeSellerDiscText,),
                                            ],
                                          ),
                                        ),
                                        Divider(height: screenHeight/20,), // Divider between ListTile widgets
                                      ],
                                    );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
    );
  }
}
