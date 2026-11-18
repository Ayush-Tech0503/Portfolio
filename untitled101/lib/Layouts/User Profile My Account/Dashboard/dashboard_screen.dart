// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables, empty_catches
import 'dart:convert';

import 'package:awesome_icons/awesome_icons.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Models/DashBoard Model/dashboard_model.dart';
import '../../../Util/Constant APi Url/api_urls.dart';
import '../../../Util/constaint_textstyle.dart';
import '../../../Util/constant_color.dart';
import '../../../Widgets/custome_text.dart';
import '../../../Widgets/landing_screen_slider.dart';
import 'Booked Products/Booked Products TableData/booked_products_datatable.dart';
import 'Following Shop/following_shops.dart';
import 'Liked Products/like_products.dart';
import 'Save Reels/save_reels_datatable.dart';
import 'Seller Reviews/Seller Review TableData/seller_reviews_datatable.dart';

class DashBoardScreen extends StatefulWidget {
  String id;
  String lName;
  String longitude;
  String latitude;
   DashBoardScreen({super.key,required this.id,required this.longitude,required this.latitude,required this.lName});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
bool isLoading=false;
var tokenAccess;
var userId;
DashBoardScreenData? dashBoardScreenData;
  getSignUpApiData() async {
    try {
      setState(() {
        isLoading = true;
      });
      //  isLoading = true;
      SharedPreferences preference = await SharedPreferences.getInstance();
      tokenAccess = preference.getString("access-token");

      userId = preference.getString("userId");
      final body = {
        "user_id": userId,
      };
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.getUserDashBoardApi}",
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
        dashBoardScreenData = DashBoardScreenData.fromJson(responseData);
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {}
  }


/*--------------------------------Dashboard list start--------------------------------------*/

  final List<IconData> _icons = [
    Icons.thumb_up_alt_outlined,
    Icons.calendar_month_outlined,
    Icons.storefront_outlined,
    Icons.message_outlined,
    // Add more icons...
  ];
  @override
  void initState() {
    super.initState();
    getSignUpApiData();
  }
/*--------------------------------Dashboard list end--------------------------------------*/
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      color: ConstantColor.loginWithOtpButtonColor,
      child: SafeArea(
        child: Scaffold(
/*--------------------------------------appbar section start-------------------------------------*/
          key: _scaffoldKey,
          appBar: AppBar(
            elevation: 1,
            backgroundColor: ConstantColor.primaryBackgroundMainColor,
            iconTheme: const IconThemeData(color: ConstantColor.loginWithOtpButtonColor),
            title: customeText(textAlign: TextAlign.start,
                text: "Dashboard", style: ConstantTextStyle.secodHearText),
          ),
/*--------------------------------------appbar section end-------------------------------------*/
          backgroundColor: ConstantColor.primaryBackgroundMainColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight/50,horizontal: screenWidth/30,),
              child:isLoading?SizedBox(
                width: screenWidth,
                height: 200,
                child: const SpinKitCircle(
                  color: ConstantColor.primaryMainColor,
                  size: 40.0,
                ),
              ): Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customeText(
                    text: "Dashboard".toUpperCase(),
                    style: ConstantTextStyle.secodHearText,
                  ),
                  SizedBox(height: screenHeight / 50,),
                  customeText(
                    text: "Hello,".toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    style: ConstantTextStyle.homeScreenHeadingText1,
                  ),
                  SizedBox(height: screenHeight / 80,),
                  customeText(
                    text: "My Account Dashboard you have the ability to view a snapshot of your recent account activity.",
                    style: ConstantTextStyle.becomeSellerDiscText,),
                  SizedBox(height: screenHeight / 50,),

/*-----------------------------Grid view start----------------------------------------------*/
                  GridView(
                    physics: const PageScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 2 / 1,
                      crossAxisCount: 2, // Number of columns in the grid
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0, // Spacing between each row
                    ),
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  YourLikedProductsScreen(
                            id: widget.id??"",
                            lName: widget.lName??"",
                            latitude: widget.latitude??"",
                            longitude: widget.longitude??"",
                          )),);

                        },
                        child: profileGridView(
                          title: customeText(
                              text: dashBoardScreenData!.dashboardData!.totWishlistedProduct.toString(),
                              style: ConstantTextStyle.countingText),
                          subtitle: customeText(
                              text: "Liked Product",
                              style: ConstantTextStyle.profileGridText),
                          borderRadius: BorderRadius.circular(20.0),
                          iconBox: Icons.thumb_up_alt_outlined,
                          boxHeight: screenHeight / 20,
                          boxWidth: screenWidth / 10,
                          boxbgcolor: ConstantColor.primaryBackgroundMainColor,
                          iconsize: 25.0,
                          boxiconcolor: ConstantColor.primaryMainColor,
                          boxborderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  BookedProductDataTable(
                            id: widget.id??"",
                            lName: widget.lName??"",
                            latitude: widget.latitude??"",
                            longitude: widget.longitude??"",
                          )),);
                        },
                        child: profileGridView(
                          title: customeText(
                              text: dashBoardScreenData!.dashboardData!.totWantBuyProduct.toString(),
                              style: ConstantTextStyle.countingText),
                          subtitle: customeText(
                              text: "booked",
                              style: ConstantTextStyle.profileGridText),
                          borderRadius: BorderRadius.circular(20.0),
                          iconBox: Icons.calendar_month_outlined,
                          boxHeight: screenHeight / 20,
                          boxWidth: screenWidth / 10,
                          boxbgcolor: ConstantColor.primaryBackgroundMainColor,
                          iconsize: 25.0,
                          boxiconcolor: ConstantColor.primaryMainColor,
                          boxborderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FollowingShopScreen(
                            id: widget.id??"",
                            lName: widget.lName??"",
                            latitude: widget.latitude??"",
                            longitude: widget.longitude??"",
                          )),);

                        },
                        child: profileGridView(
                          title: customeText(
                              text: dashBoardScreenData!.dashboardData!.totFollowedSeller.toString(),
                              style: ConstantTextStyle.countingText),
                          subtitle: customeText(
                              text: "following shops",
                              style: ConstantTextStyle.profileGridText),
                          borderRadius: BorderRadius.circular(20.0),
                          iconBox:  Icons.storefront_outlined,
                          boxHeight: screenHeight / 20,
                          boxWidth: screenWidth / 10,
                          boxbgcolor: ConstantColor.primaryBackgroundMainColor,
                          iconsize: 25.0,
                          boxiconcolor: ConstantColor.primaryMainColor,
                          boxborderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  SellerReviewDataTable(
                          id: widget.id??"",
                          lName: widget.lName??"",
                          latitude: widget.latitude??"",
                          longitude: widget.longitude??"",
                        )),);

                      },
                        child: profileGridView(
                          title: customeText(
                              text: dashBoardScreenData!.dashboardData!.totSellerReviews.toString(),
                              style: ConstantTextStyle.countingText),
                          subtitle: customeText(
                              text: "My seller Reviews",
                              style: ConstantTextStyle.profileGridText),
                          borderRadius: BorderRadius.circular(20.0),
                          iconBox: Icons.message_outlined,
                          boxHeight: screenHeight / 20,
                          boxWidth: screenWidth / 10,
                          boxbgcolor: ConstantColor.primaryBackgroundMainColor,
                          iconsize: 25.0,
                          boxiconcolor: ConstantColor.primaryMainColor,
                          boxborderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  SaveReelsDashboardScreen(
                                  id: widget.id??"",
                                  lName: widget.lName??"",
                                  latitude: widget.latitude??"",
                                  longitude: widget.longitude??"",
                                )),
                          );
                      },
                        child: profileGridView(
                          title: customeText(
                              text: dashBoardScreenData!.dashboardData!.totSellerReviews.toString(),
                              style: ConstantTextStyle.countingText),
                          subtitle: customeText(
                              text: "Saved Reels",
                              style: ConstantTextStyle.profileGridText),
                          borderRadius: BorderRadius.circular(20.0),
                          iconBox: FontAwesomeIcons.bookmark,
                          boxHeight: screenHeight / 20,
                          boxWidth: screenWidth / 10,
                          boxbgcolor: ConstantColor.primaryBackgroundMainColor,
                          iconsize: 25.0,
                          boxiconcolor: ConstantColor.primaryMainColor,
                          boxborderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
