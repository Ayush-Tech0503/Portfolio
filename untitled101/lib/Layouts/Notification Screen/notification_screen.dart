// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously, deprecated_member_use

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/NotificationList Model/notificationlist_model.dart';
import '../../Util/Const Toster/toster.dart';
import '../../Util/Constant APi Url/api_urls.dart';
import '../../Util/constaint_textstyle.dart';
import '../../Util/constant_color.dart';
import '../../Widgets/Famous Market Widget/store_details_widget.dart';
import '../../Widgets/custome_text.dart';
import '../User Profile My Account/Dashboard/Liked Products/Liked Product TableData/liked_products_datatable.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    getNotificationListData();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String location = '';
  bool isLoading=false;
  var tokenAccess;
  var userId;
  int page = 1;

  NotificationListData? notificationListData;
  List<NotificationData>? notificationData=[];
  final RefreshController _refreshController1 = RefreshController(initialRefresh: false);

  // void _onLoading() async {
  //   // monitor network fetch
  //   // getNotificationListData();
  // }




  getNotificationListData() async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      tokenAccess = preference.getString("access-token");
      // if(page==1){
        setState(() {
          isLoading = true;
        });
      // }
      final body = {"user_id": userId, "page_no": page, "limit": "20"};
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.notificationApi}",
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
        var responseData = json.decode(response.data.toString());
        notificationListData = NotificationListData.fromJson(responseData);
        var notificationList = notificationListData!.notificationData ?? [];
        if (notificationList.isNotEmpty) {
          notificationData!.addAll(notificationList);
          // if (page == 1) {
            setState(() {
              isLoading = false;
            });
          // }
          // else {
          //   setState(() {});
          //   _refreshController1.loadComplete();
          // }
          // page += 1;
        } else {
          // if (page == 1) {
            setState(() {
              isLoading = false;
            });
          // }
        // else {
        //     setState(() {});
        //     _refreshController1.loadNoData();
        //   }
        }
      }else{
        _refreshController1.loadNoData();
      }
    }catch (error) {
      if (error is DioError) {
        if (error.response?.statusCode == 500) {
          // Handle 500 error
          LoadingScaffoldMessage.showSnackbar(
            context,
            "${error.message}",
            ConstantColor.primaryMainColor,
            const Duration(seconds: 2),
          );
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


  String? dateFormatFun(originalDateStr) {
    // String originalDateStr = '2024-03-09 18:33';
    DateTime originalDate = DateTime.parse(originalDateStr);
    String formattedDate = DateFormat('dd MMMM yyyy HH:mm').format(originalDate);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          backgroundColor: ConstantColor.primaryBackgroundMainColor,
          key: _scaffoldKey,
        appBar: AppBar(
          titleSpacing: 0,
          // automaticallyImplyLeading: false,
          backgroundColor: ConstantColor.primaryBackgroundMainColor,
          centerTitle: true,
          iconTheme: const IconThemeData(
              color: ConstantColor.loginWithOtpButtonColor
          ),
          //   backgroundColor: ConstantColor.primaryBackgroundMainColor,
          elevation: 0.0,
          title: Text("Notifications".toString(),
            style: ConstantTextStyle.secodHearText,
            overflow: TextOverflow.ellipsis,
          ),
        ),
          body:
     /*-----------------------------------ListView Start------------------------------------------*/
          // First Tab Content
          isLoading? const SpinKitCircle(
          color: ConstantColor.primaryMainColor,
        size: 30.0,
        )
      :   Visibility(
        visible: notificationData != null && notificationData!.isNotEmpty,
        replacement:  Center(child: Text('No Data found!',style: ConstantTextStyle.secodHearText,)
        ),
            child:
            SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              footer: customFooter(),
              controller: _refreshController1,
              // onLoading: _onLoading,
              onRefresh: ()  {
                getNotificationListData();
                notificationData!.clear();
                _refreshController1.refreshCompleted();
              },
              child:
              CupertinoScrollbar(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric( horizontal: screenWidth/40),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: notificationData!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: Card(
                        elevation: 0,
                        margin:  EdgeInsets.symmetric(vertical: screenHeight/100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: ConstantColor.notificationListColor,
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: screenHeight/200,
                          horizontal: screenWidth/40),
                          dense: true,
                          leading:  boxIcon(
                            borderRadius: BorderRadius.circular(8.0),
                            bgcolor: ConstantColor.primaryBackgroundMainColor,
                            icon: Icons.notifications_none_outlined,
                            iconsize: 24.0,
                            iconcolor: ConstantColor.primaryMainColor,
                          ),
                          title:  customeText(
                            text: notificationData![index].title!.toUpperCase()??"",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style:ConstantTextStyle.secodHearText,
                          ),
                          subtitle:  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customeText(
                                text: notificationData![index].msg??"",
                                textAlign: TextAlign.start,
                                maxLine: 1,
                                overflow: TextOverflow.ellipsis,
                                style: ConstantTextStyle.secondorGrayText,
                              ),
                              customeText(
                                text: dateFormatFun(notificationData![index].insertDate),
                                //notificationData![index].insertDate??"",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style: ConstantTextStyle.secondorGrayText,
                              ),
                            ],
                          ),
                          // trailing:  boxIcon(
                          //   borderRadius: BorderRadius.circular(8.0),
                          //
                          //   bgcolor: ConstantColor.searchBoxColor,
                          //   icon: Icons.close_outlined,
                          //   iconsize: 20.0,
                          //   iconcolor: ConstantColor.primaryMainColor,
                          // ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          )
           // : const Center(child: Text("No Data Found!")),
    /*-----------------------------------ListView end------------------------------------------*/
    //             Container(
    //               color: ConstantColor.primaryBackgroundMainColor,
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   TabBar(
    //                     isScrollable: false,
    //                     labelPadding: EdgeInsets.symmetric( vertical: screenHeight/100),
    //                     controller: _tabController,
    //                     tabs: [
    //                       customeButton(
    //                         textStyleButton: ConstantTextStyle.loginButtonTextStyle,
    //                         onPressed: () {
    //                           _tabController.animateTo(0);
    //                         },
    //                         text: "All",
    //                         backgroundColor: ConstantColor.primaryMainColor,
    //                         borderRadius: BorderRadius.circular(8.0),),
    //                       customeButton(
    //                         textStyleButton: ConstantTextStyle.loginButtonTextStyle,
    //                         onPressed: () {
    //                           _tabController.animateTo(1);
    //                         },
    //                         text: "Offer",
    //                         backgroundColor: ConstantColor.primaryMainColor,
    //                         borderRadius: BorderRadius.circular(8.0),
    //                       ),
    //                       customeButton(
    //                         textStyleButton: ConstantTextStyle.loginButtonTextStyle,
    //                         onPressed: () {
    //                           _tabController.animateTo(2);
    //                         },
    //                         text: "Order",
    //                         backgroundColor: ConstantColor.primaryMainColor,
    //                         borderRadius: BorderRadius.circular(8.0),
    //                       ),
    //                       customeButton(
    //                         textStyleButton: ConstantTextStyle.loginButtonTextStyle,
    //                         onPressed: () {
    //                           _tabController.animateTo(3);
    //                         },
    //                         text: "Other",
    //                         backgroundColor: ConstantColor.primaryMainColor,
    //                         borderRadius: BorderRadius.circular(8.0),
    //                       ),
    //                     ],
    //                     indicator: const BoxDecoration(
    //                       border: Border(
    //                         bottom: BorderSide(color: Colors.transparent, width: 0),
    //                       ),
    //                     ),
    //                   ),
    //                   isLoading?const SpinKitCircle(
    //                       color: ConstantColor.primaryMainColor, size: 30.0): notificationData!.isNotEmpty?  Expanded(
    //                     child: TabBarView(
    //                       controller: _tabController,
    //                       children:  [
    // /*-----------------------------------First Tab Content Start------------------------------------------*/
    // /*-----------------------------------ListView Start------------------------------------------*/
    //                         // First Tab Content
    //                         SmartRefresher(
    //                           enablePullDown: false,
    //                           enablePullUp: true,
    //                           footer: customFooter(),
    //                           controller: _refreshController1,
    //                           onLoading: _onLoading,
    //                               child: ListView.builder(
    //                                 padding: EdgeInsets.symmetric( horizontal: screenWidth/40),
    //                                 physics: const ScrollPhysics(),
    //                                 scrollDirection: Axis.vertical,
    //                                 itemCount: notificationData!.length,
    //                                 itemBuilder: (BuildContext context, int index) {
    //                                   return Container(
    //                                     decoration: BoxDecoration(
    //                                       color: ConstantColor.notificationListColor,
    //                                       borderRadius: BorderRadius.circular(10.0),
    //                                     ),
    //                                     margin: EdgeInsets.only(bottom: screenHeight/50),
    //                                     child: Center(
    //                                       child: ListTile(
    //                                         leading:  boxIcon(
    //                                           borderRadius: BorderRadius.circular(8.0),
    //                                           bgcolor: ConstantColor.primaryBackgroundMainColor,
    //                                           icon: Icons.notifications_none_outlined,
    //                                           iconsize: 20.0,
    //                                           iconcolor: ConstantColor.primaryMainColor,
    //                                         ),
    //                                         title:  customeText(
    //                                           text: notificationData![index].title!.toUpperCase(),
    //                                           textAlign: TextAlign.start,
    //                                           overflow: TextOverflow.ellipsis,
    //                                           style:ConstantTextStyle.secodHearText,
    //                                         ),
    //                                         subtitle:  customeText(
    //                                           text: notificationData![index].msg!,
    //                                           textAlign: TextAlign.start,
    //                                           overflow: TextOverflow.ellipsis,
    //                                           style: ConstantTextStyle.secondorGrayText,
    //                                         ),
    //                                         trailing:  boxIcon(
    //                                           borderRadius: BorderRadius.circular(8.0),
    //
    //                                           bgcolor: ConstantColor.searchBoxColor,
    //                                           icon: Icons.close_outlined,
    //                                           iconsize: 20.0,
    //                                           iconcolor: ConstantColor.primaryMainColor,
    //                                         ),
    //                                       ),
    //                                     ),
    //
    //                                   );
    //                                 },
    //                               ),
    //                             ),
    // /*-----------------------------------ListView end------------------------------------------*/
    // /*-----------------------------------First Tab Content end------------------------------------------*/
    //
    //                         // Second Tab Content
    //                         const Center(
    //                           child: Text('Offer Tab Content'),
    //                         ),
    //
    //                         // Third Tab Content
    //                         const Center(
    //                           child: Text('Order Tab Content'),
    //                         ),
    //
    //                         // Four Tab Content
    //                         const Center(
    //                           child: Text('Other Tab Content'),
    //                         ),
    //                       ],
    //                     ),
    //                   )
    //                       :const Center(child: Text("No Data Found!")),
    //                 ],
    //               ),
    //             ),
        ),
    /*----------------------------------------Body section end--------------------------------------------*/

      );
  }
}
