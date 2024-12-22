// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously, must_be_immutable
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Models/Send Enquiry Models/user_send_enquiry.dart';
import '../../../Models/Top Category/Category Catalog1/banner1.dart';
import '../../../Models/Top Category/Category Catalog2/top_products.dart';
import '../../../Util/Constant APi Url/api_urls.dart';
import '../../../Util/constaint_textstyle.dart';
import '../../../Util/constant_color.dart';
import '../../../Util/constant_image.dart';
import '../../../Widgets/Login Check Widget/login_check_widget.dart';
import '../../../Widgets/Send Enquiry dialogBox/alert_dialog_box.dart';
import '../../../Widgets/arrow_button.dart';
import '../../../Widgets/avatar_scrolling.dart';
import '../../../Widgets/collection_card.dart';
import '../../../Widgets/custome_button_.dart';
import '../../../Widgets/custome_richtext.dart';
import '../../../Widgets/custome_text.dart';
import '../../../Widgets/famous_market_card_widget.dart';
import '../../../Widgets/landing_screen_slider.dart';
import '../../Famous Market/Store Details/Store Details Screen/store_details.dart';
import '../../Famous Market/famous_market_list.dart';
import '../../See More Shops/get_seller.dart';
import '../product_Item_Details.dart';
import '../seen_more_products_list.dart';
import 'all_product_list.dart';
class TopCategoriesSectionScreen extends StatefulWidget {

  final topCategories;
  final String? city;
  String? filterKeyWordKey;
  String id;
  String logitude;
  String latitude;
  String lName;
   TopCategoriesSectionScreen({super.key, this.filterKeyWordKey, this.topCategories,required this.city,required this.id,required this.logitude,required this.latitude,required this.lName});

  @override
  State<TopCategoriesSectionScreen> createState() => _TopCategoriesSectionScreenState();
}

class _TopCategoriesSectionScreenState extends State<TopCategoriesSectionScreen> {
  var userId;
  bool discountZoneLeftIconBGColor = false;
  bool discountZoneRightIconBGColor = false;
  /*----------------------Arrow Controller left and right start --------------------------*/
  final ScrollController _scrollController = ScrollController();
  final double _scrollAmount = 500.0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /*------------------------------scrollList controller start-----------------------------------------*/

  void scrollListRightSide() {
    _scrollController.animateTo(
      _scrollController.offset + _scrollAmount,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,);
  }
  void scrollListLeftSide() {
    _scrollController.animateTo(
      _scrollController.offset - _scrollAmount,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

/*---------------------------------scrollList controller end-------------------------------------------*/
  /*-----------------------------Arrow Controller left and right end --------------------------*/

  /*----------------------------- Calling button redirect class code start--------------------------*/
  void _launchPhoneCall(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  /*-------------------- Calling button redirect class code end--------------------------*/
var tokenAccess;
  /*-------------Api Data start--------------------------*/
//******************************************************
  //Banner1,Banner2,TopCategory,DiscountZone Api data start
//*****************************************************
  CategoryCat1stModel? categoryCatalog1Api;
  List<Banner1> categoryBanner1 = [];
  List<Banner2> categoryBanner2 = [];
  List<SubCategories> categoryCatSubCategories = [];
  List<SpecialDiscountZone> categoryCatAllDiscount = [];
  List<FilterItem> filterItem = [];
  bool isLoading = false;
  List<String> allSuitableFor = [];

  List <String> newData  = [];

  void fetchCategoriesCatList({lat, long, String? city, String? category}) async {
    setState(() {
      isLoading = true;
    });

    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      String? userId = preference.getString("userId");
      String? tokenAccess = preference.getString("access-token");

      final body = {
        "user_id": userId,
        "category": category,
        "lat": lat,
        "long": long,
        "city": city,
      };

      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.categoryCatalog}",
        options: Options(
          headers: {
            "Authorization": tokenAccess!,
            'Content-Type': 'application/json',
          },
        ),
        data: json.encode(body),
      );
      if (response.statusCode == 200) {
        var responseData = json.decode(response.data.toString());
        setState(() {
          categoryCatalog1Api = CategoryCat1stModel.fromJson(responseData);
          categoryBanner1 = categoryCatalog1Api!.banner1 ?? [];
          categoryBanner2 = categoryCatalog1Api!.banner2 ?? [];
          categoryCatSubCategories = categoryCatalog1Api!.subCategories ?? [];
          categoryCatAllDiscount = categoryCatalog1Api!.specialDiscountZone ?? [];
          // Example: Extracting newData based on first subcategory's filter item
          if (categoryCatalog1Api!.subCategories != null) {
            for (var subCategory in categoryCatalog1Api!.subCategories!) {
              if (subCategory.filterItem != null && subCategory.filterItem!.suitableFor != null) {
                // Add all suitableFor items to newData
                newData.addAll(subCategory.filterItem!.suitableFor??[]);
              }
            }
          } else {
            // Handle case where subCategories is null or empty
            newData = [];
          }

          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
    }
  }


  CategoryCat2TopStoresProducts? category2TopStoresProducts;
  List<CategoryCat2StoreProducts> categoryCat2allProducts=[];
  topCategoriesTopStoreProducts({lat, long, String? city, String? category}) async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      tokenAccess = preference.getString("access-token");
      setState(() {
        isLoading=true;
      });
      //  isLoading = true;
      final body = {
        "user_id": userId,
        "category": category,
        "lat": lat,
        "long": long,
        "city": city,
      };
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.categoryCatalog2}",
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
        category2TopStoresProducts = CategoryCat2TopStoresProducts.fromJson(responseData);
        categoryCat2allProducts.addAll(category2TopStoresProducts!.topStoreProducts??[]);
        category2AllStores.addAll(category2TopStoresProducts!.yourCityFocusStore??[]);

        setState(() {
          isLoading=false;

        });}
    } catch (error) {
      setState(() {
        isLoading=false;

      });

    }}
//******************************************************
  //Top product store Api data end
  //Top Store Api data end
//*****************************************************
  List<CategoryCat2Stores> category2AllStores=[];
  void _launchWhatsApp(String? phoneWhatsapp, String? smsText) async {
    // Construct the URL with the phone number and SMS text
    String url = 'https://wa.me/$phoneWhatsapp?text=${Uri.encodeComponent(smsText ?? 'I found you on CItyBazaarOnline')}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch WhatsApp $url';
    }
  }

//*****************************************************
  bool isLoadingWish = false;
  fetchSendEnquiryAPi({prodId,wantBuy,index,tokenAccess}) async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      tokenAccess = preference.getString("access-token");
      setState(() {
        isLoadingWish = true;
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
        // Parse the response into a SendEnquiry object
        SendEnquiry sendEnquiry = SendEnquiry.fromJson(responseData);
        setState(() {
          categoryCat2allProducts[index].wantToBuy = "1";
          isLoadingWish = false;
         var  firstProduct =  categoryCat2allProducts[index].contactNo;
         var  firstWhatsapp =  categoryCat2allProducts[index].whatsapptext;
          showDialog(
            context: context,
            builder: (ctx) {
              return alertDialogBox(
                context: context,
                titleText: "Enquiry Send Successfully",
                titleTextAlign: TextAlign.center,
                titleStyle: ConstantTextStyle.topCategoryText,
                descriptionText: "${firstProduct??''}.\n",
                phoneNumber: firstProduct??"",
                icon: Icons.message_sharp,
                buttonText: "Chat with seller",
                buttonStyle: ConstantTextStyle.newiconButtonText,
                iconbuttononPress: () {
                  if (firstProduct!.isNotEmpty && firstProduct!= ""
                  && firstProduct!= null ) {
                    _launchWhatsApp(firstProduct??'',
                        firstWhatsapp??"");
                  }else {
                     '';
                  }
                },
              );
            },
          );
          // LoadingScaffoldMessage.showSnackbar(
          //   context,
          //   responseData['msg'],
          //   ConstantColor.primaryMainColor,
          //   const Duration(seconds: 2),
          // );
        });
      } else {
        setState(() {
          isLoadingWish = false;
        });
      }
    } catch (error) {
      setState(() {
        isLoadingWish = false;
      });
      // Handle any exceptions
      // print("Error: $error");
    }
  }

  /*-------------Api Data end--------------------------*/


  final PageController _pageController = PageController(initialPage: 0);
  int _currentCarouselPage = 0;
  int _currentCarouselPage2 = 0;
  bool isUserLoggedIn = false;

  @override
  void initState() {
    super.initState();
   if(widget.id!=""){
     fetchCategoriesCatList(lat: widget.latitude, long: widget.logitude, city: widget.lName,category: widget.topCategories);
     topCategoriesTopStoreProducts(lat: widget.latitude, long: widget.logitude, city: widget.lName,category: widget.topCategories);
   }else{
     fetchCategoriesCatList(lat: 22.71771, long: 75.8544833, city: "Indore",category: widget.topCategories);
     topCategoriesTopStoreProducts(lat: 22.71771, long: 75.8544833, city: "Indore",category: widget.topCategories);

   }

    // _getLocation().then((_){
    //   fetchCategoriesCatList(lat: _locationLatitude, long: _locationLongitude, city: widget.city,category: widget.topCategories);
    //   topCategoriesTopStoreProducts(lat: _locationLatitude, long: _locationLongitude, city: widget.city,category: widget.topCategories);
    //  // topCategoriesFocusStore(lat: _locationLatitude, long: _locationLongitude, city: widget.city,category: widget.topCategories);
    // });

    _pageController.addListener(() {
      setState(() {
      });
    });
  }
//-----------------------------------
  launchWhatsApp(String? phoneNumber, String message) async {
    if ( phoneNumber != null && message == "null" && message !="I found you on CItyBazaarOnline" ) {
      final url = 'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch WhatsApp $url';
      }
    } else {
    }
  }
  //-----------------------------------
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight =  MediaQuery.of(context).size.height;
    return  Container(
      color: ConstantColor.loginWithOtpButtonColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor:ConstantColor.carColor ,
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
            title: Text(widget.topCategories.toString(),
              style: ConstantTextStyle.secodHearText,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          extendBody: true,

/*----------------------------------Body area---------------------------------------------*/
          body: CupertinoScrollbar(
            child: SingleChildScrollView(
              child: Container(
                color: ConstantColor.carColor,
                child:isLoading?const Center(
                  child: SpinKitCircle(
                    color: ConstantColor.primaryMainColor,
                    size: 30.0,
                  ),
                ):  Column(
                  children: [
                /*---------------------------Top Banner Slider start -----------------------------------------*/
                        Stack(
                         children: [
                           carouselSlider(
                             bannerHeight: screenHeight / 7,
                             autoPlay: categoryBanner1.length == 1 ? false :true,
                             viewportFraction: 1.0,
                             enlargeCenterPage: true,
                             onPageChanged:  (index, reason) {
                               setState(() {
                                 _currentCarouselPage = index;
                               });
                             },
                             controller: _pageController,
                             data: List.generate(categoryBanner1.length, (index) {
                               final banner = categoryBanner1[index];
                               return GestureDetector(
                                 onTap: () {
                                   switch (banner.type) {
                                     case "shop_detail":
                                       Navigator.push(
                                         context,
                                         MaterialPageRoute(
                                           builder: (context) => StoreDetailScreen(
                                             sellersId: banner.keyword,
                                             id: widget.id,
                                             longitude: widget.latitude,
                                             latitude: widget.latitude,
                                             lName: widget.lName,
                                           ),
                                         ),
                                       );
                                       break;
                                     case "product_details":
                                       Navigator.push(
                                         context,
                                         MaterialPageRoute(
                                             builder: (context) => ProductDetailScreen(
                                               proId:banner.keyword,
                                               id: widget.id,
                                               longitude: widget.latitude,
                                               latitude: widget.latitude,
                                               lName: widget.lName,)),
                                       );
                                       break;
                                     case "product_List":
                                       Navigator.push(
                                         context,
                                         MaterialPageRoute(
                                           builder: (context) => SeeMoreProductsScreen(
                                             keyword: banner.bannerTitle,
                                             id: widget.id,
                                             longitude: widget.latitude,
                                             latitude: widget.latitude,
                                             lName: widget.lName,
                                           ),
                                         ),
                                       );
                                       break;
                                     case "shop_List":
                                       Navigator.push(
                                         context,
                                         MaterialPageRoute(
                                           builder: (context) => FamousMarketListScreen(
                                             id: widget.id,
                                             latitude: widget.latitude,
                                             longitude: widget.latitude,
                                             lName: widget.lName,
                                             fmId: banner.bannerTitle,
                                           ),
                                         ),
                                       );
                                       break;
                                     case "contest_details":
                                       launchWhatsApp(banner.keyword.toString(), banner.whatsapptext.toString());
                                       break;
                                     default:
                                       launchWhatsApp(banner.keyword.toString(), banner.whatsapptext.toString());
                                   }
                                 },
                                 child: Container(
                                   color: ConstantColor.transparent1,
                                   child:CachedNetworkImage(
                                     imageUrl: banner.bannerImage ?? "",
                                     width:screenWidth,
                                     fit: BoxFit.fill,
                                     errorWidget: (context, url, error) =>
                                         Image.asset(
                                           ConstantImage.imageIsNotAvailable,
                                           height:screenHeight,
                                           width:screenWidth,
                                           fit: BoxFit.fill,
                                         ),
                                   ),
                                 ),
                               );
                             }),
                           ),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: categoryBanner1.map((banner) {
                               int index = categoryBanner1.indexOf(banner);
                               return dotS(
                                 width: screenWidth /25.0,
                                 height:  screenHeight/160,
                                 margin: EdgeInsets.only(top: screenHeight/8.0,),
                                 shape: BoxShape.circle,
                                 color: _currentCarouselPage == index
                                     ? ConstantColor.primaryMainColor
                                     : ConstantColor.carColor2,
                               );
                             }).toList(),
                           ),
                         ],
                       ),
                /*-------------------------------Top Banner Slider end -----------------------------------------*/
                       SizedBox(height: screenHeight / 80,),
                /*--------------------------All Categories start-----------------------------------------*/
                       Container(
                         color: ConstantColor.bottonNavIcons,
                         padding: EdgeInsets.symmetric(vertical: screenHeight/50, horizontal: screenWidth/ 40,),
                         child: GridView.builder(
                           physics: const ScrollPhysics(),
                           shrinkWrap: true,
                           itemCount: categoryCatSubCategories.length,
                           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                             crossAxisCount: 4,
                             childAspectRatio: (1/1.2),
                             crossAxisSpacing: 10.0,
                             mainAxisSpacing: 10.0,
                           ),
                           itemBuilder: (BuildContext context, int index) {
                             final allCategories = categoryCatSubCategories[index];
                             var suitableFor = categoryCatSubCategories[index].filterItem?.suitableFor?.map((item) =>
                                 item.toLowerCase().replaceAll(' ', '-').replaceAll('&', 'and')).toList() ?? [];
                             return allHomeScreenAvatar(
                               onTap: ()  {
                                 Navigator.push(
                                   context,
                                   MaterialPageRoute(builder: (context) =>  AllProductListScreen(
                                     keyword: categoryCatSubCategories[index].name.toString()?? "",
                                     filterKeyword:  categoryCatSubCategories[index].keyword,
                                     suitableFor :suitableFor,
                                     id:widget.id,
                                     latitude:widget.latitude,
                                     longitude:widget.logitude,
                                     lName:widget.lName
                
                                   )),
                                 );
                               },
                               width:screenWidth/6,
                               height: double.minPositive,
                               borderRadius: BorderRadius.circular(100),
                               image:CachedNetworkImage(
                                 imageUrl:  allCategories.img?? "",
                                 fit: BoxFit.fill,
                                 errorWidget: (context, url, error) =>
                                     Image.asset(
                                       ConstantImage.imageIsNotAvailable,
                                       fit: BoxFit.fill,
                                     ),
                               ),
                               text: allCategories.name?? "",
                               textAlign: TextAlign.center,
                               color: ConstantColor.carColor,
                               boxShadow: const [
                                 BoxShadow(
                                   color: ConstantColor.circleAvatar2,
                                   spreadRadius: 1,
                                   blurRadius: 1,
                                   offset: Offset(-3, -3),
                                 ),
                               ],
                             );
                           },
                         ),
                       ),
                
                /*-------------------------------All Categories end-----------------------------------------*/
                //                   SizedBox(height: screenHeight / 50,),
                // /*---------------------------------Scrolling discount zone start --------------------------------------------*/
                    Container(
                      padding: EdgeInsets.symmetric(vertical: screenHeight/50, horizontal: screenWidth/40),
                      color: ConstantColor.primaryBackgroundMainColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customeText(
                            text: "DISCOUNT ZONE".toUpperCase(),
                            textAlign: TextAlign.start,
                            style: ConstantTextStyle.topCategoryText,),
                          SizedBox(height: screenHeight/80,),
                          Stack(
                            children: [
                              SizedBox(height: screenHeight/8,
                                child:
                                categoryCatAllDiscount.isEmpty
                                    ? customeText(text: "No data found!")
                                // SpinKitCircle(
                                //   color: ConstantColor.primaryMainColor,
                                //   size: 30.0,
                                // )
                                    :
                                ListView.builder(
                                    controller: _scrollController,
                                    itemCount: categoryCatAllDiscount.isNotEmpty ? categoryCatAllDiscount.length : null,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final allDiscounts = categoryCatAllDiscount[index];
                                      var suitableFor = categoryCatAllDiscount[index].suitableFor?.map((item) =>
                                          item.toLowerCase().replaceAll(' ', '-').replaceAll('&', 'and')).toList() ?? [];
                                      return Container(
                                        margin: EdgeInsets.only(
                                            right: screenWidth / 50
                                        ),
                                        width: screenWidth / 2.3,
                                        height: screenHeight / 8,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: ConstantColor.secondoryCardeBoarder,
                                            width: 1.0,
                                          ),
                                          color: ConstantColor.secondoryWhiteColors,
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        child:ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) =>  AllProductListScreen(
                                                    keyword: categoryCatAllDiscount[index].name.toString()?? "",
                                                    filterKeyword:  categoryCatAllDiscount[index].name.toString()?? "",
                                                    suitableFor :suitableFor,
                                                    id:widget.id,
                                                    latitude:widget.latitude,
                                                    longitude:widget.logitude,
                                                    lName:widget.lName
                
                                                )),
                                              );
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //       builder: (context) =>
                                              //           SeeMoreProductsScreen(
                                              //               keyword: allDiscounts.name??"",
                                              //               id:widget.id,
                                              //               latitude:widget.latitude,
                                              //               longitude:widget.logitude,
                                              //               lName:widget.lName
                                              //           )),
                                              // );
                                            },
                                            child: CachedNetworkImage(
                                              imageUrl: allDiscounts.image ?? "",
                                              fit: BoxFit.fill,
                                              imageBuilder: (context,
                                                  imageProvider) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                  Image.asset(
                                                    ConstantImage.imageIsNotAvailable,
                                                    fit: BoxFit.fill,
                                                  ),
                                            ),
                                          ),
                                          // Image.network(
                                          //   allDiscounts.image ?? "",
                                          //   errorBuilder: (context, error, stackTrace) {
                                          //     return Image.asset(ConstantImage.imageIsNotAvailable, fit: BoxFit.fill);},
                                          //   fit: BoxFit.fill,
                                          // ),
                                        ),
                                      );
                                    }),
                              ),
                              Positioned(
                                left: screenWidth/40, top: 0, bottom: 0,
                                child: arrowButons(
                                  onTap: () {
                                    setState(() {
                                      discountZoneLeftIconBGColor= !discountZoneLeftIconBGColor;
                                    });
                                    Future.delayed(const Duration(milliseconds: 500), () {
                                      setState(() {
                                        discountZoneLeftIconBGColor= !discountZoneLeftIconBGColor;
                                      });
                                    });
                                    scrollListLeftSide();
                                  },
                                  iconSize: 20.0,
                                  radius: 15.0,
                                  backgroundColor:discountZoneLeftIconBGColor? ConstantColor.primaryMainColor : ConstantColor.iconBackTPColor,
                                  icon: Icons.arrow_back_ios_new_rounded,
                                  color:discountZoneLeftIconBGColor ? ConstantColor.searchBoxColor : ConstantColor.primaryMainColor,
                                ),),
                              Positioned(
                                right: screenWidth/40, top: 0, bottom: 0,
                                child:
                                arrowButons(
                                  onTap: () {
                                    setState(() {
                                      discountZoneRightIconBGColor= !discountZoneRightIconBGColor;
                                    });
                                    Future.delayed(const Duration(milliseconds: 500), () {
                                      setState(() {
                                        discountZoneRightIconBGColor= !discountZoneRightIconBGColor;
                                      });
                                    });
                                    scrollListRightSide();
                                  },
                                  radius: 15.0,
                                  iconSize: 20.0,
                                  backgroundColor: discountZoneRightIconBGColor ? ConstantColor.primaryMainColor : ConstantColor.iconBackTPColor,
                                  icon: Icons.arrow_forward_ios_rounded,
                                  color: discountZoneRightIconBGColor ? ConstantColor.searchBoxColor : ConstantColor.primaryMainColor,
                                ),),
                            ],
                          ),
                        ],
                      ),
                    ),
                /*---------------------------------Scrolling discount zone end --------------------------------------------*/
                  //  SizedBox(height: screenHeight / 50,),
                /*--------------------------------Top products start-----------------------------------------*/
                     Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth/40),
                          color: ConstantColor.bottonNavIcons,
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading:  customeText(
                              textAlign: TextAlign.center,
                              text: "Top Product".toUpperCase(),
                              style: ConstantTextStyle.topCategoryText2,),
                            trailing: customeButton(
                              textStyleButton:
                              ConstantTextStyle.seeMoreButtonStyle2,
                              onPressed: () {
                                Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => SeeMoreProductsScreen(
                                  keyword:"top-product",
                                    id:widget.id,
                                    latitude:widget.latitude,
                                    longitude:widget.logitude,
                
                                    lName:widget.lName
                                ),),);
                              },
                              text: "See More",
                              backgroundColor: ConstantColor.transparent1,
                              borderRadius: BorderRadius.circular(0.0),
                              elevation: 0.0,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: screenHeight/80,horizontal: screenWidth/50),
                          decoration: BoxDecoration(
                            color: ConstantColor.secondryBackgroundMainColor,
                            borderRadius: BorderRadius.circular(5.0),),
                          child: collectionCards(
                            onTap: () {},
                            context: context,
                            itemCount: categoryCat2allProducts.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              childAspectRatio: 1/1.2,
                            ),
                            itemBuilder: (BuildContext context, index) {
                //*****************************************************************************
                              final topStoreProducts = categoryCat2allProducts[index];
                              final productIds = categoryCat2allProducts[index].productId;
                              double getPercantageOff(double price, double offerPrice) {
                                double result = ((price - offerPrice) / price) * 100;
                                return result.floor().toDouble();}
                              final offerPrice = double.tryParse(topStoreProducts.offerPrice ?? '0') ?? 0.0;
                              final price = double.tryParse(topStoreProducts.price ?? '0') ?? 0.0;
                              final percentageOff = offerPrice != 0.0 ? getPercantageOff(price, offerPrice) : 0.0;
                              final roundedPercentageOff = percentageOff.toStringAsFixed(0);
                //*****************************************************************************
                              return Card(
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth/50),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      cashBackChip(
                                        context: context,
                                        borderRadius: BorderRadius.circular(5.0),
                                        text: percentageOff > 0 ? '$roundedPercentageOff% OFF' : "",
                                        style: ConstantTextStyle.newiconButtonText,
                                        textAlign: TextAlign.center,
                                        width: screenWidth / 5.0,
                                        // height: screenHeight / 60,
                                        color: percentageOff > 0 ? ConstantColor.chipColor : null,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(
                                            proId: categoryCat2allProducts[index].productId??"",
                                              id:widget.id,
                                              latitude:widget.latitude,
                                              longitude:widget.logitude,
                                              lName:widget.lName
                                          )));
                                        },
                                        child: Center(
                                          child:CachedNetworkImage(
                                            imageUrl: topStoreProducts.productImage?? "",
                                            width: screenWidth,
                                            height: screenHeight / 8,
                                            fit: BoxFit.contain,
                                            errorWidget: (context, url, error) =>
                                                Image.asset(
                                                  ConstantImage.imageIsNotAvailable,
                                                  width: screenWidth / 2.7,
                                                  height: screenHeight / 8,
                                                  fit: BoxFit.fill,
                                                ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: screenHeight/100,),
                                      customeText(
                                        text: topStoreProducts.productTitle?? "",
                                        overflow: TextOverflow.ellipsis,
                                        style: ConstantTextStyle.allHomeScreenAvatarText,),
                                      SizedBox(height: screenHeight/200,),
                                      Flexible(
                                        child: customRichText(
                                          text1: "\u{20B9}${topStoreProducts.offerPrice ?? topStoreProducts.price} "?? "N/A",
                                          style1: ConstantTextStyle.richtext1,
                                          TextAlign: TextAlign.start,
                                          style2: ConstantTextStyle.richtext2,
                                          text2:percentageOff> 0 ? NumberFormat.simpleCurrency(
                                              locale: "hi-NI", decimalDigits: 2)
                                              .format(double.parse(topStoreProducts.price ?? '')) : " ",
                                        ),
                                      ),
                                      SizedBox(height: screenHeight/200,),
                                      Flexible(
                                        child: ElevatedButton.icon(
                                          onPressed: categoryCat2allProducts[index].wantToBuy == "1" ? null : () async {
                                            SharedPreferences preferences = await SharedPreferences.getInstance();
                                            setState(() {
                                              isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                                              tokenAccess = preferences.getString("access-token");
                                            });
                                            if (isUserLoggedIn) {
                                              await fetchSendEnquiryAPi(
                                                prodId: categoryCat2allProducts[index].productId ?? '',
                                                tokenAccess: tokenAccess,
                                                wantBuy: "1",
                                                index: index,
                                              );
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
                                          icon: const Icon(
                                            Icons.content_paste_search,
                                            color: ConstantColor.primaryBackgroundMainColor,
                                            size: 18.0,
                                          ),
                                          label: Text(
                                            'Send Enquiry',
                                            style: ConstantTextStyle.newiconButtonText,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: Size.fromHeight(screenHeight / 25),
                                            backgroundColor: categoryCat2allProducts[index].wantToBuy == "1"
                                                ? ConstantColor.primaryGreyColor
                                                : ConstantColor.primaryMainColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                /*--------------------------------Top products end-----------------------------------------*/
                    SizedBox(height: screenHeight / 50,),
                /*------------------------Bottom Banner Slider start -----------------------------------------*/
                   Stack(
                      children: [
                        carouselSlider(
                          bannerHeight: screenHeight / 7,
                          autoPlay: categoryBanner2.length == 1 ? false :true,
                          viewportFraction: 1.0,
                          enlargeCenterPage: true,
                          onPageChanged:  (index, reason) {
                            setState(() {
                              _currentCarouselPage2 = index;
                            });
                          },
                          controller: _pageController,
                          data: List.generate(categoryBanner2.length, (index) {
                            final banner = categoryBanner2[index];
                            return GestureDetector(
                              onTap: () {
                                switch (banner.type) {
                                  case "shop_detail":
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => StoreDetailScreen(
                                          sellersId: banner.keyword,
                                          id: widget.id,
                                          longitude: widget.latitude,
                                          latitude: widget.latitude,
                                          lName: widget.lName,
                                        ),
                                      ),
                                    );
                                    break;
                                  case "product_details":
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductDetailScreen(proId:banner.keyword,
                                            id: widget.id,
                                            longitude: widget.latitude,
                                            latitude: widget.latitude,
                                            lName: widget.lName,)),
                                    );
                                    break;
                                  case "product_List":
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SeeMoreProductsScreen(
                                          keyword: banner.bannerTitle,
                                          id: widget.id,
                                          longitude: widget.latitude,
                                          latitude: widget.latitude,
                                          lName: widget.lName,
                                        ),
                                      ),
                                    );
                                    break;
                                  case "shop_List":
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FamousMarketListScreen(
                                          id: widget.id,
                                          latitude: widget.latitude,
                                          longitude: widget.latitude,
                                          lName: widget.lName,
                                          fmId: banner.bannerTitle,
                                        ),
                                      ),
                                    );
                                    break;
                                  case "contest_details":
                                    launchWhatsApp(banner.keyword.toString(), banner.whatsapptext.toString());
                                    break;
                                  default:
                                    launchWhatsApp(banner.keyword.toString(), banner.whatsapptext.toString());
                                }
                              },
                              child: Container(
                                color: ConstantColor.transparent1,
                                child: CachedNetworkImage(
                                  imageUrl: banner.bannerImage ?? "",
                                  width: screenWidth,
                                  fit: BoxFit.fill,
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                        ConstantImage.imageIsNotAvailable,
                                        width: screenWidth,
                                        fit: BoxFit.fill,
                                      ),
                                ),
                              ),
                            );
                          }),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: categoryBanner2.map((banner) {
                            int index = categoryBanner2.indexOf(banner);
                            return dotS(
                              width: screenWidth /25.0,
                              height:  screenHeight/160,
                              margin: EdgeInsets.only(top: screenHeight/8.0,),
                              shape: BoxShape.circle,
                              color: _currentCarouselPage2 == index
                                  ? ConstantColor.primaryMainColor
                                  : ConstantColor.carColor2,
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                /*-------------------------Bottom Banner Slider end -----------------------------------------*/
                    SizedBox(height: screenHeight / 80,),
                /*--------------------------------Top Store start -----------------------------------------*/
                    Container(
                      color: ConstantColor.primaryBackgroundMainColor,
                      padding: EdgeInsets.symmetric(horizontal: screenWidth/40, vertical: screenWidth/80,),
                      child: Column(
                        children: [
                          ListTile(
                            dense: true,
                            visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                            contentPadding: EdgeInsets.zero,
                            leading:  customeText(
                              textAlign: TextAlign.center,
                              text: "Top Stores".toUpperCase(),
                              style: ConstantTextStyle.topCategoryText2,),
                            trailing: customeButton(
                              textStyleButton:
                              ConstantTextStyle.seeMoreButtonStyle2,
                              onPressed: () {
                                Navigator.push( context,
                                  MaterialPageRoute(
                                    builder: (context) => GetSellerScreen(
                                      keyword: "focused_shop",
                                      id: widget.id, lattude: widget.latitude, longitude: widget.logitude, lName: widget.lName,),),
                                );
                              },
                              text: "See More",
                              backgroundColor: ConstantColor.transparent1,
                              borderRadius: BorderRadius.circular(0.0),
                              elevation: 0.0,
                            ),
                          ),
                          collectionCards(
                            onTap: () {},
                            context: context,
                            itemCount: category2AllStores.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              childAspectRatio: (1 /1.12),
                              // childAspectRatio: 1/1.37,
                            ),
                            itemBuilder: (BuildContext context, index) {
                              final topStoresHere = category2AllStores[index];
                              return Card(
                                color: ConstantColor.secondryBackgroundMainColor,
                                elevation: 1,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: screenWidth/50),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: screenHeight/200),
                                        child: Stack(
                                          children: [
                                            GestureDetector(
                                              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) =>  StoreDetailScreen(
                                                sellersId: topStoresHere.sellerId.toString(),
                                                  id:widget.id,
                                                  latitude:widget.latitude,
                                                  longitude:widget.logitude,
                                                lName: widget.lName,
                                              )));},
                                              child: CachedNetworkImage(
                                                imageUrl:  topStoresHere.shopImage?? "",
                                                width: screenWidth,
                                                height: screenHeight/9,
                                                fit: BoxFit.fill,
                                                errorWidget: (context, url, error) =>
                                                    Image.asset(
                                                      ConstantImage.imageIsNotAvailable,
                                                      width: screenWidth,
                                                      height: screenHeight/9,
                                                      fit: BoxFit.fill,
                                                    ),
                                              ),
                                            ),
                
                /*--------------------------------Cash back chip start -----------------------------------------*/
                                            if (topStoresHere.cashbackText != null && topStoresHere.cashbackText!.isNotEmpty)
                                              cashBackChip(
                                                padding: EdgeInsets.symmetric(vertical: screenHeight/200),
                                                color: ConstantColor.filedContainerColor,
                                                context: context,
                                                textAlign: TextAlign.start,
                                                text: topStoresHere.cashbackText,
                                                style: ConstantTextStyle.chashBackchipText,),
                
                /*--------------------------------Cash back chip end -----------------------------------------*/
                                             if (topStoresHere.cashbackText != null && topStoresHere.cashbackText!.isNotEmpty)
                                              ShineEffect(
                                                padding: EdgeInsets.only(top: screenHeight / 120,),
                                                height: screenHeight / 50,
                                                width: screenWidth / 4.5,
                                              ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        child: customeText(
                                          text: topStoresHere.name!.toUpperCase()?? "",
                                          overflow: TextOverflow.ellipsis,
                                          style: ConstantTextStyle.allHomeScreenAvatarText,),
                                      ),
                                      SizedBox(height: screenHeight/200,),
                                      Flexible(
                                        child: iconRichText(icon: Icons.location_on_outlined,
                                          color: ConstantColor.filedContainerColor,
                                          size: 15.0,
                                          text2: topStoresHere.storeAddress?? "",
                                          style2: ConstantTextStyle.secondryLocationText,),
                                      ),
                                      SizedBox(height: screenHeight/200,),
                
                                      startRating(
                                        width: screenWidth/4,
                                        height: screenHeight/40,
                                        context: context,
                                        color: ConstantColor.secondoryBlackColors,
                                        text2:"${double.parse(topStoresHere.rating ?? "0").toStringAsFixed(1)}/5.0",
                                        style2: ConstantTextStyle.ratingText,
                                        initialRating: double.parse(topStoresHere.rating ?? "0"),
                                        itemSize: 10.0,
                                        minRating: 1.0,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        onRatingUpdate: (rating) {},
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star, color: ConstantColor.starRatingColor,),
                                      ),
                                      SizedBox(height: screenHeight/100,),
                                      Flexible(
                                        child: ElevatedButton.icon(
                                          onPressed: () async {
                                            String phoneNumber = category2AllStores[index].contactNo ?? "";
                                            SharedPreferences preferences = await SharedPreferences.getInstance();
                                            bool isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                                            if (isUserLoggedIn && phoneNumber.isNotEmpty) {
                                              _launchPhoneCall(phoneNumber);
                                            } else {
                                              showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return isUserLoggedIn ? Container() : const CheckIsLogin();
                                                },
                                              );
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.call_outlined,
                                            color: ConstantColor.primaryBackgroundMainColor,
                                            size: 17.0,
                                          ),
                                          label: Text('Contact Us',
                                            style: ConstantTextStyle.newiconButtonText,),
                                          style: ElevatedButton.styleFrom(
                                            // padding: EdgeInsets.symmetric(vertical:screenHeight/10),
                                            minimumSize: Size.fromHeight(screenHeight/25),
                                            backgroundColor: ConstantColor.primaryMainColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                /*--------------------------------Top Store end -----------------------------------------*/
                
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
