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
                      appBar: AppBar(
                        elevation: 1,
                        // leadingWidth: 24,
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
                        child: ListView(
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
                            // Container(
                            //   height: MediaQuery.of(context).size.height/1.25,
                            //   decoration: BoxDecoration(
                            //     color: ConstantColor.sellerBGColor,
                            //     borderRadius:BorderRadius.circular(10.0),
                            //   ),
                            //   child:  SmartRefresher(
                            //     enablePullDown: false,
                            //     enablePullUp: true,
                            //     footer: customFooter(),
                            //     controller: _refreshController1,
                            //     onLoading: _onLoading,
                            //     child: isLoading?const SpinKitCircle(
                            //       color: ConstantColor.primaryMainColor,
                            //       size: 30.0,
                            //     ):  Visibility(
                            //       visible: data != null && data!.isNotEmpty,
                            //       replacement:  Center(child: Text('No Data found!',style: ConstantTextStyle.secodHearText,)),
                            //       child: SingleChildScrollView(
                            //         child:  DataTable(
                            //                     dataRowHeight: screenHeight/4,
                            //                     showBottomBorder: true,
                            //                     dividerThickness:0.5,
                            //                     headingRowColor: MaterialStateProperty.resolveWith(
                            //                           (states) => ConstantColor.calendarBGHeadColor,),
                            //                     headingRowHeight: screenHeight/10,
                            //                     columns: [
                            //                       DataColumn(   //
                            //                         label:customeText(text: "Images",
                            //                           textAlign: TextAlign.start, style:ConstantTextStyle.tabButtonTextStyle,),),
                            //                       DataColumn(
                            //                         label:customeText(text: "Product Details",
                            //                           textAlign: TextAlign.start, style:ConstantTextStyle.tabButtonTextStyle,),),
                            //                       // DataColumn(
                            //                       //   label:customeText(text: "Action",
                            //                       //     textAlign: TextAlign.start, style:ConstantTextStyle.tabButtonTextStyle,),),
                            //                     ],
                            //                     rows:data!=null?data!.map((product) {
                            //                       return
                            //                               /*---------------------------------1st Row start------------------------------*/
                            //                         DataRow(
                            //                             cells:[
                            //                           DataCell(
                            //                             boxImage(
                            //                       onTap: (){
                            //                           Navigator.push(context, MaterialPageRoute(builder: (context) =>  ProductDetailScreen(
                            //                             proId: product.productId ?? "", id: widget.id,latitude: widget.latitude,longitude: widget.longitude,lName: widget.lName,
                            //                           )));
                            //                       }, backGroundColor: ConstantColor.primaryBackgroundMainColor,
                            //                               backGroundborderRadius:BorderRadius.circular(8.0),
                            //                               shadowColor: ConstantColor.carColor,
                            //                               blurRadius: 20.0,
                            //                               borderColor: ConstantColor.carColor,
                            //                               image: product.productImgUrl,
                            //                               imageHeight: screenHeight /7,
                            //                               imageWidth: screenWidth /7,
                            //                               fit: BoxFit.contain,
                            //                           ),
                            //                           ),
                            //                           DataCell(
                            //                             SingleChildScrollView(
                            //                               child:
                            //                               GestureDetector(
                            //                      onTap: (){
                            //                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  ProductDetailScreen(
                            //                          proId: product.productId ?? "", id: widget.id,latitude: widget.latitude,longitude: widget.longitude,lName: widget.lName,
                            //                        )));
                            //                      }, child:
                            //                 SizedBox(
                            //                                 width: screenWidth / 2,
                            //                                   child: Column(
                            //                                     mainAxisAlignment: MainAxisAlignment.center,
                            //                                     crossAxisAlignment: CrossAxisAlignment.start,
                            //                                     children: [
                            //                                       customeText(
                            //                                         text: product.productName!.toUpperCase(),
                            //                                         textAlign: TextAlign.start,overflow: TextOverflow.ellipsis,
                            //                                         style: ConstantTextStyle.ratingText2,) ,
                            //                                       SizedBox(height: screenHeight/100,),
                            //                                       iconRichText2(
                            //                                         context: context,
                            //                                         icon: Icons.store_outlined,
                            //                                         color: ConstantColor.filedContainerColor,
                            //                                         size: 14.0,
                            //                                         text: product.storeName,
                            //                                         style: ConstantTextStyle.imageColorTextStyle,),
                            //                                       SizedBox(height: screenHeight/100,),
                            //                                       iconRichText2(
                            //                                         context: context,
                            //                                         icon: Icons.currency_rupee_outlined,
                            //                                         color: ConstantColor.filedContainerColor,
                            //                                         size: 14.0,
                            //                                         text:product.price,
                            //                                         style: ConstantTextStyle.becomeSellerDiscText,),
                            //                                       SizedBox(height: screenHeight/100,),
                            //                                       iconRichText2(
                            //                                         context: context,
                            //                                         icon: Icons.calendar_month_outlined,
                            //                                         color: ConstantColor.filedContainerColor,
                            //                                         size: 14.0,
                            //                                         text: product.createdDate,
                            //                                         style: ConstantTextStyle.becomeSellerDiscText,),
                            //                                     ],
                            //                                   ),
                            //                                 ),
                            //                               )
                            //
                            //                             ),),
                            //                           // DataCell(
                            //                           //   boxIcon(
                            //                           //     height: screenHeight/10,width: screenWidth/10,
                            //                           //     icon: Icons.delete_outline,
                            //                           //     borderRadius: BorderRadius.circular(8.0),
                            //                           //     bgcolor: ConstantColor.primaryMainColor,
                            //                           //     //_isSelect ? ConstantColor.calendarBGHeadColor : ConstantColor.primaryMainColor,
                            //                           //     iconcolor: ConstantColor.primaryBackgroundMainColor,
                            //                           //     //_isSelect ? ConstantColor.primaryMainColor : ConstantColor.primaryBackgroundMainColor ,
                            //                           //     iconsize: 25.0,
                            //                           //     onTap: () {
                            //                           //       setState(() {
                            //                           //         fetchDeleteProductAPi(
                            //                           //             prodId:product.productId ?? "",
                            //                           //             wantBuy: '0'
                            //                           //         );
                            //                           //     //  _isSelect = !_isSelect;
                            //                           //     });
                            //                           //     },
                            //                           //
                            //                           //   ),
                            //                           // ),
                            //                         ]);
                            //
                            //                               /*---------------------------------1st Row end--------------------------------*/
                            //                     }).toList():[]
                            //                   ),
                            //
                            //       ),
                            //     ),
                            //   ), ),
                          ],
                        ),
                      ),
                    ),
                  ),
                // ),
    );
  }
}
