
// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:Citybazar_app/Util/constaint_textstyle.dart';
import 'package:Citybazar_app/Util/constant_color.dart';
import 'package:Citybazar_app/Util/constant_image.dart';
import 'package:Citybazar_app/Widgets/custome_button_.dart';
import 'package:Citybazar_app/Widgets/custome_richtext.dart';
import 'package:Citybazar_app/Widgets/famous_market_card_widget.dart';
import 'package:Citybazar_app/Widgets/landing_screen_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Models/Cash Back Models/cash_back_store.dart';
import '../../Util/Constant APi Url/api_urls.dart';
import '../../Util/constant_token.dart';
import '../../Widgets/collection_card.dart';
import '../../Widgets/custome_text.dart';
import '../Famous Market/Store Details/Store Details Screen/store_details.dart';
import 'cashback_coins.dart';
import 'how_cashback_works.dart';

class ProductCashbackStore extends StatefulWidget {
  String id;
  String latitude;
  String longitude;
  String lName;
   ProductCashbackStore({super.key,required this.longitude,required this.id,required this.lName,required this.latitude});

  @override
  State<ProductCashbackStore> createState() => _ProductCashbackStoreState();
}

class _ProductCashbackStoreState extends State<ProductCashbackStore> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
    fetchAllCashBackStoreList();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page! as int;
      });
    });
  }
  var usersId;
//-----------------------api data start -----------------------
  CashBacks? cashBackStoreData;
  List<Banners> allBanner=[];
  List<Store> allCashBackStore=[];
  bool isLoading = false;
  fetchAllCashBackStoreList() async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      usersId = preference.getString("userId");
      setState(() {
        isLoading = true;
      });
      final body = {"user_id":usersId,"lat":"22.6616282","long":"75.8910446","city":"Indore"};
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.cashBackStoreEndPoint}",
        options: Options(
          headers: {
            "Authorization": ConstantToken.authorizationToken,
            'Content-Type': 'application/json',
          },
        ),
        data: json.encode(body),
      );
      if (response.statusCode == 200) {
        var responseData = json.decode(response.data.toString());
        cashBackStoreData = CashBacks.fromJson(responseData);
        setState(() {
          allBanner.addAll(cashBackStoreData!.banner?? []);
          allCashBackStore.addAll(cashBackStoreData!.store?? []);
        });
      }
      else {
        // Print the productDetailsDataList after parsing
      }
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to fetch data $error');
    }
  }
//-----------------------api data End -----------------------

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: ConstantColor.loginWithOtpButtonColor,
      child: SafeArea(
        child: Scaffold(
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
            title: Text("Cashback",
              style: ConstantTextStyle.topCategoryText2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          extendBody: true,

/*----------------------------------Body area---------------------------------------------*/
          body:  isLoading
              ? const SpinKitCircle(
            color: ConstantColor.primaryMainColor,
            size: 30.0,
          ): allBanner.isNotEmpty
              ? SingleChildScrollView(
              child: Column(
                children: [
/*--------------------------------Banner start -----------------------------------------*/
                  carouselSlider(
                    bannerHeight: screenHeight/6,
                    autoPlay: true,
                    viewportFraction: 1.0,
                    enlargeCenterPage: true,
                    controller: _pageController,
                    data: List.generate(allBanner.length, (index) {
                      final bannerHere = allBanner[index];
                      return Image.network(bannerHere.addImage?? "",
                          width: screenWidth,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(ConstantImage.imageIsNotAvailable,
                                width: screenWidth,fit: BoxFit.fill); },
                          fit: BoxFit.fill);
                    }),
                  ),
/*--------------------------------Banner end -----------------------------------------*/
/*--------------------------Cashback balance point section start ---------------------*/

                  Container(
                color: ConstantColor.primaryBackgroundMainColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth / 40, vertical: screenHeight/40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            side: BorderSide(
                              color: ConstantColor.carColor,
                            ),
                          ),
                          child: ListTile(
                            onTap: (){  Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const CashbackCoins()),
                            );},
                            leading: IconButton(
                              iconSize: 30,
                              icon: const Icon(Icons.account_balance_wallet_outlined,
                                color: ConstantColor.loginWithOtpButtonColor,),
                              onPressed: () {},),
                            title:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                customeText(
                                  textAlign: TextAlign.start,
                                  text: "Cashback Balance",
                                  overflow: TextOverflow.ellipsis,
                                  style: ConstantTextStyle.homeScreenHeadingText3,
                                ),
                                customeText(
                                  textAlign: TextAlign.start,
                                  text: "${cashBackStoreData?.walletAmount.toString()} Points" ?? "",
                                  style: ConstantTextStyle.cashPointText,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            trailing:  customeButton(
                                textStyleButton: ConstantTextStyle.loginButtonTextStyle,
                                onPressed: () {  Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const CashbackCoins()),
                                );},
                                text: "View",
                                backgroundColor: ConstantColor.primaryMainColor,
                                borderRadius: BorderRadius.circular(5),
                                minimumSize: Size(screenWidth / 4.0, screenHeight / 25.0)
                            ),
                          ),
                        ),
/*--------------------------Cashback balance point section end ---------------------*/
                        SizedBox(height: screenHeight /50,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const HowCashbackWork()),
                          );
                        },
                        child: customeText(
                          textAlign: TextAlign.start,
                          text: "Know how to Cashback works ?",
                          style: ConstantTextStyle.topCategoryText2,
                        ),
                      ),
                      ],
                    ),
                  ),

/*-------------------------------- -----------------------------------------*/
                  SizedBox(height: screenHeight / 50,),
/*--------------------------------Top Store start -----------------------------------------*/
                  Container(
                    decoration: BoxDecoration(
                      color: ConstantColor.secondryBackgroundMainColor,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight / 80, horizontal: screenWidth / 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customRichText(
                          TextAlign: TextAlign.start,
                          text1: "Cashback stores".toUpperCase(),
                          style1: ConstantTextStyle.topCategoryText2,
                        ),
                        SizedBox(height: screenHeight /80,),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: allCashBackStore!.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            childAspectRatio: (1 /1.1),
                          ),
                          itemBuilder: (BuildContext context, index) {
                            final storesHere = allCashBackStore![index];
                            return Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: screenWidth / 50),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: screenHeight/200),
                                      child:Stack(
                                        children: [
                                          GestureDetector(
                                            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) =>  StoreDetailScreen(
                                              id:widget.id,
                                              latitude:widget.latitude,
                                              longitude:widget.longitude,
                                              lName: widget.lName,

                                            )));},
                                            child: Image.network(
                                              storesHere.shopImage??"",
                                              width: screenWidth,
                                              height: screenHeight/7,
                                              fit: BoxFit.fill,
                                              errorBuilder: (context, error, stackTrace) {
                                                return Image.asset(ConstantImage.imageIsNotAvailable,
                                                  width: screenWidth,
                                                  height: screenHeight/7,
                                                  fit: BoxFit.fill,
                                                  errorBuilder: (context, error, stackTrace) {
                                                    return Image.asset(ConstantImage.imageIsNotAvailable,
                                                      width: screenWidth,
                                                      height: screenHeight/8,);
                                                  },);
                                              },
                                            ),
                                          ),
                                          Positioned(
                                            right: 0, bottom: 0,
                                            child: startRating(
                                              width: screenWidth/4,
                                              height: screenHeight/40,
                                              context: context,
                                              color: ConstantColor.secondoryBlackColors,
                                              text2:"${double.parse(storesHere.rating ?? "0").toStringAsFixed(1)}/5.0",
                                              style2: ConstantTextStyle.ratingText,
                                              initialRating: double.parse(storesHere.rating ?? "0"),
                                              itemSize: 10.0,
                                              minRating: 1.0,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              onRatingUpdate: (rating) {},
                                              itemBuilder: (context, _) => const Icon(
                                                Icons.star, color: ConstantColor.starRatingColor,),
                                            ),
                                          ),
/*--------------------------------Cash back chip start -----------------------------------------*/
                                          allCashBackStore![index].cashbackTag == false
                                              ? Container()
                                              :  cashBackChip(
                                            padding: EdgeInsets.symmetric(vertical: screenHeight/200),
                                            color: ConstantColor.filedContainerColor,
                                            context: context,
                                            textAlign: TextAlign.start,
                                            text: storesHere.cashbackText.toString(),
                                            style: ConstantTextStyle.chashBackchipText,),

/*--------------------------------Cash back chip end -----------------------------------------*/
                                          allCashBackStore![index].cashbackTag == false
                                              ? Container()
                                              :ShineEffect(
                                            padding: EdgeInsets.only(top: screenHeight / 120,),
                                            height: screenHeight / 50,
                                            width: screenWidth / 4.5,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      child: customeText(
                                        text: storesHere.name??"",
                                        overflow: TextOverflow.ellipsis,
                                        style: ConstantTextStyle.allHomeScreenAvatarText,
                                      ),
                                    ),
                                    SizedBox(height: screenHeight/200,),
                                    Flexible(
                                      child: iconRichText(
                                        icon: Icons.location_on_outlined,
                                        color: ConstantColor.filedContainerColor,
                                        size: 15.0,
                                        text2: storesHere.storeAddress!.toString(),
                                        style2: ConstantTextStyle.secondryLocationText,
                                      ),
                                    ),
                                    SizedBox(height: screenHeight/200,),
                                    Flexible(
                                      child: ElevatedButton.icon(
                                        onPressed: () async {
                                          String url = 'tel:${allCashBackStore![index].contactNo}';
                                          // ignore: deprecated_member_use
                                          if (await canLaunch(url)) {
                                            // ignore: deprecated_member_use
                                            await launch(url);
                                          } else {
                                            throw 'Could not launch $url';
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.call_outlined,
                                          size: 17.0,
                                        ),
                                        label: Text(
                                          'Contact Us',
                                          style: ConstantTextStyle.newiconButtonText,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: Size.fromHeight(screenHeight / 25),
                                          backgroundColor: ConstantColor.primaryMainColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),

/*--------------------------------Top Store end -----------------------------------------*/

                ],
              ),

          ):Center(child: customeText(
              textAlign: TextAlign.center,
              text:'No Data Available')),
        ),
      ),
    );
}
}
