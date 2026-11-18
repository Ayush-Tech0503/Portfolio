// ignore_for_file: non_constant_identifier_names, deprecated_member_use, must_be_immutable, prefer_typing_uninitialized_variables, use_build_context_synchronously
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:Citybazar_app/Widgets/custome_imagies.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Models/Home page Models/Home Page No1/home_page_model_no1.dart';
import '../Models/Home page Models/Home Page No2/home_page_model_no2.dart';
import '../Models/Home page Models/Home Page No3/home _page_model_no3.dart';
import '../Util/Const Toster/toster.dart';
import '../Util/Constant APi Url/api_urls.dart';
import '../Util/constaint_textstyle.dart';
import '../Util/constant_color.dart';
import '../Util/constant_image.dart';
import '../Widgets/Home Screen Widgets/promoted_stores.dart';
import '../Widgets/Home Screen Widgets/top_seller_card.dart';
import '../Widgets/Send Enquiry dialogBox/alert_dialog_box.dart';
import '../Widgets/arrow_button.dart';
import '../Widgets/avatar_scrolling.dart';
import '../Widgets/collection_card.dart';
import '../Widgets/custome_richtext.dart';
import '../Widgets/custome_text.dart';
import '../Widgets/famous_market_card_widget.dart';
import '../Widgets/landing_screen_slider.dart';
import 'Famous Market/Store Details/Store Details Screen/store_details.dart';
import 'Famous Market/famous_market_list.dart';
import 'Home Page Trending Reals/home_page_reals.dart';
import 'Main Reels Screen/home_page_nav_reels_screen.dart';
import 'Product View Screens/Top Categoty/all_product_list.dart';
import 'Product View Screens/Top Categoty/top_categoty_screen.dart';
import 'Product View Screens/product_Item_Details.dart';
import 'Product View Screens/seen_more_products_list.dart';
import 'Search Box Screen/search_screen.dart';
import 'See More Shops/get_seller.dart';
class HomeScreen extends StatefulWidget {
  final ScrollController controller;
  String lattude;
  String longitude;
  String id;
  String lName;

  HomeScreen(
      {super.key,
      required this.controller,
      required this.lattude,
      required this.longitude,
      required this.id,
      required this.lName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /*--------------scrolling arrow icon button color start---------------------------*/
  bool famousMarketLeftIconBGColor = false;
  bool famousMarketRightIconBGColor = false;
  bool discountZoneLeftIconBGColor = false;
  bool discountZoneRightIconBGColor = false;
  bool topMobileElectronicsLeftIconBGColor = false;
  bool topKitchenLeftIconBGColor = false;
  bool topKitchenRightIconBGColor = false;
  bool topMobileElectronicsRightIconBGColor = false;
  bool famousStoreLeftIconBGColor = false;
  bool famousStoreRightIconBGColor = false;
  bool fAcs = false;
  bool topRatingStoresLeftIconBGColor = false;
  bool topRatingStoresRightIconBGColor = false;
  bool topSellerIconBGColor = false;
  bool iconBGColor = false;
  /*--------------scrolling arrow icon button color end----------------------------*/

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
/*-------------------------------------------------*/

  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  final ScrollController _scrollController3 = ScrollController();
  final ScrollController _scrollController4 = ScrollController();
  final ScrollController _scrollControllerfac = ScrollController();
  final ScrollController _scrollController5 = ScrollController();
  final ScrollController _scrollController6 = ScrollController();
  final ScrollController scrollControllerTopSeller = ScrollController();
  final double _scrollAmount = 500.0;
  var tokenAccess;
  var userId;
  getAccessToken() async {
    SharedPreferences preference = await SharedPreferences.getInstance();

    setState(() {
      tokenAccess = preference.getString("access-token");
      userId = preference.getString("userId");
    });
  }
  @override
  void dispose() {
    _scrollController.dispose();
    _scrollController2.dispose();
    _scrollController3.dispose();
    _scrollController4.dispose();
    _scrollControllerfac.dispose();
    _scrollController5.dispose();
    _scrollController6.dispose();
    super.dispose();
  }

  /*------------------------------scrollList controller 1st start-----------------------------------------*/
  void scrollListRightSide() {
    _scrollController.animateTo(
      _scrollController.offset + _scrollAmount,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void scrollListLeftSide() {
    _scrollController.animateTo(
      _scrollController.offset - _scrollAmount,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
/*---------------------------------scrollList controller 1st end-------------------------------------------*/

/*-------------------------------scrollList controller 2st start---------------------------------------*/
  void scrollListRightSide2() {
    _scrollController2.animateTo(
      _scrollController2.offset + _scrollAmount,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void scrollListLeftSide2() {
    _scrollController2.animateTo(
      _scrollController2.offset - _scrollAmount,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
/*------------------------------scrollList controller 2nd end-----------------------------------------*/

  /*-------------------------------scrollList controller 3rt start---------------------------------------*/
  void scrollListRightSide3() {
    _scrollController3.animateTo(
      _scrollController3.offset + _scrollAmount,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void scrollListLeftSide3() {
    _scrollController3.animateTo(
      _scrollController3.offset - _scrollAmount,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
/*------------------------------scrollList controller 3rd end-----------------------------------------*/

/*-------------------------------scrollList controller 4th start---------------------------------------*/
  void scrollListRightSide4() {
    _scrollController4.animateTo(
      _scrollController4.offset + _scrollAmount,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void scrollListRightSideFcs() {
    _scrollControllerfac.animateTo(
      _scrollControllerfac.offset + _scrollAmount,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void scrollListLeftSide4() {
    _scrollController4.animateTo(
      _scrollController4.offset - _scrollAmount,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
/*------------------------------scrollList controller 4th end-----------------------------------------*/

/*-------------------------------scrollList controller 5th start---------------------------------------*/
  void scrollListRightSide5() {
    _scrollController5.animateTo(
      _scrollController5.offset + _scrollAmount,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void scrollListLeftSide5() {
    _scrollController5.animateTo(
      _scrollController5.offset - _scrollAmount,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

/*------------------------------scrollList controller 5th end-----------------------------------------*/
  /*-------------------------------scrollList controller 3rt start---------------------------------------*/
  void scrollListRightSide6() {
    _scrollController6.animateTo(
      _scrollController6.offset + _scrollAmount,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void scrollListLeftSide6() {
    _scrollController6.animateTo(
      _scrollController6.offset - _scrollAmount,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

/*------------------------------scrollList controller 3rd end-----------------------------------------*/
/*----------------scrollList controllerTop Seller start-------------------*/
  void scrollTopSeller() {
    scrollControllerTopSeller.animateTo(
      scrollControllerTopSeller.offset + _scrollAmount,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
/*----------------scrollList controllerTop Seller end-------------------*/
/*-------------------------Api Related Data Here---------------------------------------------*/
//********************************************************
  // Top homePageNo1EndPointKey Api data start
//********************************************************
  Homepage1Data? homePageBanners;
  List<TopBanners> topBanners = [];
  List<AdsBannerMiddle>adsBannerMiddles = [];
  List<TopOffers> topOffers = [];
  List<IconsData> topCategoryIcons = [];
  List<DiscountZone> discountZones = [];
  List<FamousMarket> famousMarkets = [];
  List<TopProductsFashionAccessoriesProducts> topFashionAcs = [];
  bool isLoadingScreen = false;
  fetchHomePageBanner({city, lat, long}) async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      tokenAccess = preference.getString("access-token");
      setState(() {
        isLoadingScreen = true;
      });
      //  isLoading = true;
      final body = {
        "lat": lat,
        "long": long,
        "city": city
      };
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.homePageNo1EndPointKey}",
        options: Options(
          headers: {
            "Authorization": tokenAccess,
            'Content-Type': 'application/json',
          },
        ),
        data: json.encode(body),
      );
      if (response.statusCode == 200) {
        // final responseData = response.data;
        var responseData = json.decode(response.data.toString());
        homePageBanners = Homepage1Data.fromJson(responseData);
        topBanners.addAll(homePageBanners!.data!.topBanners ?? []);
        adsBannerMiddles.addAll(homePageBanners!.data!.adsBannerMiddle ?? []);
        topOffers.addAll(homePageBanners!.data!.topOffers ?? []);
        topCategoryIcons.addAll(homePageBanners!.data!.icons ?? []);
        discountZones.addAll(homePageBanners!.data!.discountZone ?? []);
        famousMarkets.addAll(homePageBanners!.data!.famousMarket ?? []);
        topFashionAcs.addAll(homePageBanners!.data!.topProductsFashionAccessoriesProducts ?? []);
        setState(() {
          isLoadingScreen = false;
        });
      }
    } catch (error) {
      setState(() {
        isLoadingScreen = false;
        // print("error $error");
      });
    }
  }

  ////////////////////////////////////GetProfileApi//////////////////////////////////
  fetchGetProfileApi() async{
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      tokenAccess = preference.getString("access-token");
      setState(() {
        isLoadingScreen = true;
      });
      final body = {
        "user_id": userId,
      };
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.getUserProfileApi}",
        options: Options(
          headers: {
            "Authorization": tokenAccess,
            'Content-Type': 'application/json',
          },
        ),
        data: json.encode(body),
      );
      if (response.statusCode == 200) {
        setState(() {
          isLoadingScreen = false;
        });
      }
    } catch (error) {
      setState(() {
        isLoadingScreen = false;
      });
    }
  }
//********************************************************
  // Top homePageNo1EndPointKey Api data End
  // Top Seller Api data start
//********************************************************
  bool isLoading1 = true;
  HomePageTopSeller? homePageTopSeller;
  List<TopSeller> topSellers = [];
  List<PromotedStores> promotionStores = [];
  fetchTopSeller({ city, lat, long}) async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      tokenAccess = preference.getString("access-token");
      setState(() {
        isLoading1 = true;
      });

      final body = {
        "user_id": userId,
        "lat": lat,
        "long": long,
        "city": city
      };
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.homePageNo3EndPointKey}",
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
        homePageTopSeller = HomePageTopSeller.fromJson(responseData);
        topSellers.addAll(homePageTopSeller!.data!.topSeller ?? []);
        promotionStores.addAll(homePageTopSeller!.data!.promotedStores??[]);
        setState(() {
          isLoading1 = false;
        });
      }
    }catch (error) {
      setState(() {
        isLoading1 = false;
      });
    }
  }


//********************************************************
  // Top Seller Api data end
  // homePageNo2EndPointKey Api data start
//********************************************************
  bool isLoading2 = false;
  Homepage2Data? homePage2;
  // HomePage2TopMobileElectronics? homePage2TopMobileElectronics;
  List<BestProductMobileElectonicProducts> bestProductMobileElectonicProducts = [];
  List<FamousStore> famousStore = [];
  List<TopRatingStore> topRatingStores = [];
  List<AdsBannerBottom> adsBannerBottom = [];
  List<AdsBannerMiddle2> adsBannerMiddle2 = [];
  List<RecentSearches> recentSearch = [];
  List<TopHomeKitchenProducts> topHomeKitchenProducts = [];
  List<Rentals> rentalItems = [];

  fetchTopMobileAndElectronic({city, lat, long}) async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      tokenAccess = preference.getString("access-token");

      setState(() {
        isLoading2 = true;
      });
      final body = {
        "user_id": userId,
        "lat": lat,
        "long": long,
        "city": city
      };
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.homePageNo2EndPointKey}",
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
          // homePage2 = Homepage2Data.fromJson(responseData);
          homePage2 = Homepage2Data.fromJson(responseData);
          bestProductMobileElectonicProducts.addAll(homePage2!.data!.bestProductMobileElectonicProducts ?? []);
          famousStore.addAll(homePage2!.data!.famousStore ?? []);
          topRatingStores.addAll(homePage2!.data!.topRatingStore ?? []);
          adsBannerBottom.addAll(homePage2!.data!.adsBannerBottom ?? []);
          adsBannerMiddle2.addAll(homePage2!.data!.adsBannerMiddle2 ?? []);
          recentSearch.addAll(homePage2!.data!.recentSearches ?? []);
          topHomeKitchenProducts.addAll(homePage2!.data!.topHomeKitchenProducts ?? []);
          rentalItems.addAll(homePage2!.data!.rentals ?? []);
          isLoading2 = false;
        });
      } else {
        // Handle server error
        setState(() {
          isLoading2 = false;
        });
      }
    } catch (error) {
      setState(() {
        isLoading2 = false;
      });
    }
  }

//********************************************************
  // homePageNo2EndPointKey Api data end
  // send enquiry api data start
//********************************************************
  void _launchWhatsApp(String? phoneWhatsapp, String? smsText) async {
    if (!phoneWhatsapp!.startsWith("+91")) {
      phoneWhatsapp = "+91$phoneWhatsapp";}
    String url = 'https://wa.me/$phoneWhatsapp?text=${Uri.encodeComponent(smsText ?? 'I found you on CItyBazaarOnline')}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch WhatsApp $url';
    }
  }

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
        setState(() {
          bestProductMobileElectonicProducts[index].wantToBuy = '1';
          topHomeKitchenProducts[index].wantToBuy = '1';
          isLoadingWish = false;
          var  sellerNumber = bestProductMobileElectonicProducts[index].contactNo??"";
          var  sellerWhatsapp =  bestProductMobileElectonicProducts[index].whatsapptext??'';
          showDialog(
            context: context,
            builder: (ctx) {
              return alertDialogBox(
                context: context,
                titleText: "Enquiry Send Successfully",
                titleTextAlign: TextAlign.center,
                titleStyle: ConstantTextStyle.feedBackHeadText,
                descriptionText: "+91 ${sellerNumber??''}.\n",
                phoneNumber: sellerNumber??"",
                icon: Icons.message_sharp,
                buttonText: "Chat with seller",
                buttonStyle: ConstantTextStyle.newiconButtonText,
                iconbuttononPress: () {
                  if (sellerNumber.isNotEmpty && sellerNumber!= "" ) {
                    _launchWhatsApp(sellerNumber??'', sellerWhatsapp??"");
                  }else {
                    '';
                  }
                },
              );
            },
          );
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


  bool isUserLoggedIn = false;

// ********************************************************
  // send enquiry api data end
//********************************************************
  //-----------------------------------------------------------
  bool isLoading101 = true;
  fetchRecentNavigation({slug}) async {
    try {
      final preference = await SharedPreferences.getInstance();
      final tokenAccess = preference.getString("access-token");

      setState(() => isLoading101 = true);

      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.recentNavigationApi}",
        options: Options(headers: {"Authorization": tokenAccess, 'Content-Type': 'application/json'}),
        data: json.encode({"slug": slug}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.data.toString());
        if (responseData['status'] == 'success') {
          final data = responseData['data'];
          if (data.isNotEmpty && data.length !=0) {
            final page = data['page'];
            switch (page) {
              case 'product':
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailScreen(
                      proId: data['id'].toString(),
                      id: widget.id,
                      longitude: widget.longitude,
                      latitude: widget.lattude,
                      lName: widget.lName,
                    ),
                  ),
                );
                break;
              case 'category':
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AllProductListScreen(
                      keyword: slug.toString() ?? "",
                      suitableFor: const [],
                      filterKeyword: slug,
                      id: widget.id,
                      latitude: widget.lattude,
                      longitude: widget.longitude,
                      lName: widget.lName,
                    ),
                  ),
                );
                break;
              case 'seller':
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => StoreDetailScreen(
                      sellersId: data['id'].toString(),
                      id: widget.id,
                      longitude: widget.longitude,
                      latitude: widget.lattude,
                      lName: widget.lName,
                    ),
                  ),
                );
                break;
              default:
                LoadingScaffoldMessage.showSnackbar(
                  context,
                  "Something went wrong!",
                  ConstantColor.primaryMainColor,
                  const Duration(seconds: 2),
                );
            }
          } else{
            LoadingScaffoldMessage.showSnackbar(
              context,
              "Something went wrong!",
              ConstantColor.primaryMainColor,
              const Duration(seconds: 2),
            );
          }
        }
      }
    } catch (error) {
      // Handle error
    } finally {
      setState(() => isLoading101 = false);
    }
  }


  //-----------------------------------------------------------
  @override
  void initState() {
    super.initState();
    getAccessToken();
    fetchGetProfileApi();
    if (widget.id != "" && widget.lName != "") {
      fetchDataForCity(
        city: widget.lName,
        lat: widget.lattude,
        long: widget.longitude,
      );
    }
    else {
      fetchDataForCity(
        city: "Indore",
        lat: "22.7177",
        long: "75.8545",
      );
    }
    _pageController.addListener(() {
      setState(() {
      });
    });
  }


  void fetchDataForCity({
    required String city,
    required String lat,
    required String long,
  }) {
    fetchHomePageBanner(city: city, lat: lat, long: long);
    fetchTopSeller(city: city, lat: lat, long: long);
    fetchTopMobileAndElectronic(city: city, lat: lat, long: long);
  }

/*-----------------------------Api Related Data Here end---------------------------------------*/
  final PageController _pageController = PageController(initialPage: 0.round());
  final PageController _pageController1 = PageController(initialPage: 0);
  final PageController _pageController2 = PageController(initialPage: 0);
  final PageController _pageController3 = PageController(initialPage: 0);
  final PageController _pageController4 = PageController(initialPage: 0);
  // final TextEditingController _searchController = TextEditingController();
  int _currentCarouselPage = 0;
  int _currentCarouselPage2 = 0;
  int _currentCarouselPage3 = 0;
  int _currentCarouselPage4 = 0;
  //final CarouselController _carouselController = CarouselController();
/*---------------------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------------------*/
  void launchWhatsApp(String? phoneWhatsapp, String? smsText) async {
    if (!phoneWhatsapp!.startsWith("+91")) {
      phoneWhatsapp = "+91$phoneWhatsapp";}
    String url = 'https://wa.me/$phoneWhatsapp?text=${Uri.encodeComponent(smsText ?? 'I found you on CItyBazaarOnline')}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch WhatsApp $url';
    }
  }

  final ScrollController scrollController = ScrollController();
  final RefreshController _refreshController2 = RefreshController(initialRefresh: false);
/*---------------------------------------------------------------------------------------*/

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leadingWidth: 0,
        // toolbarHeight: screenHeight/15,
        backgroundColor: ConstantColor.primaryBackgroundMainColor,
        elevation: 0.0,
    automaticallyImplyLeading: false,
    /*--------------------------------------Search box section start-------------------------------------*/
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SearchBoxScreen(
                        id: '',
                        longitude: '',
                        latitude: '',
                        lName: '',
                      )),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                color: ConstantColor.primaryGreyColor
              ),
              color: ConstantColor.searchBoxColor,
            ),
            margin: EdgeInsets.symmetric(horizontal: screenWidth / 40),
            padding: EdgeInsets.symmetric(horizontal: screenWidth / 50),
            height: screenHeight / 20,
            width: screenWidth,
            child: Row(
              children: [
                const Icon(
                  Icons.search_rounded,
                  color: ConstantColor.primaryMainColor,
                ),
                SizedBox(width: screenWidth/40,),
                Flexible(
                  child: Text(
                    'Search for, Products, Shop and More',
                    style: ConstantTextStyle.becomeSellerDiscText,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
        ),
    /*--------------------------------------Search box section end-------------------------------------*/
        titleSpacing: 0.0,
      ),
    extendBodyBehindAppBar: false,
    /*---------------------------------carouselSlider start --------------------------------------------*/
      body:
      SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        controller: _refreshController2,
        onRefresh: ()  {
          if (widget.id != "" && widget.lName != "") {
            fetchDataForCity(
              city: widget.lName,
              lat: widget.lattude,
              long: widget.longitude,
            );
          }
          else {
            fetchDataForCity(
              city: "Indore",
              lat: "22.7177",
              long: "75.8545",
            );
          }

         promotionStores.clear();
          topBanners.clear();
          adsBannerMiddles.clear();
          topOffers.clear();
          topCategoryIcons.clear();
          discountZones.clear();
          famousMarkets.clear();
          topFashionAcs.clear();
          topSellers.clear();
          bestProductMobileElectonicProducts.clear();
          famousStore.clear();
          topRatingStores.clear();
          adsBannerBottom.clear();
          adsBannerMiddle2.clear();
          recentSearch.clear();
          topHomeKitchenProducts.clear();
          rentalItems.clear();
          _refreshController2.refreshCompleted();
        },
        child: isLoading1
            ? const SpinKitCircle(color: ConstantColor.primaryMainColor, size: 30.0)
            :SingleChildScrollView(
                      controller: scrollController,
                child: Container(
                    color: ConstantColor.carColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                           Stack(
                            children: [
                              carouselSlider(
                                bannerHeight: screenHeight / 7,
                                autoPlay: true,
                                viewportFraction: 1.0,
                                enlargeCenterPage: true,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _currentCarouselPage = index;
                                  });
                                },
                                controller: _pageController1,
                                data: List.generate(topBanners.length, (index) {
                                  final banner = topBanners[index];
                                  return GestureDetector(
                                    onTap: () {
                                      switch (banner.type) {
                                        case "shop_detail":
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => StoreDetailScreen(
                                                sellersId: topBanners[index].keyword,
                                                id: widget.id,
                                                longitude: widget.longitude,
                                                latitude: widget.lattude,
                                                lName: widget.lName,
                                              ),
                                            ),
                                          );
                                          break;
                                          case "product_details":
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ProductDetailScreen(proId:topBanners[index].keyword,
                                                id: widget.id,
                                                longitude: widget.longitude,
                                                latitude: widget.lattude,
                                                lName: widget.lName,)),
                                          );
                                          break;
                                        case "product_List":
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => SeeMoreProductsScreen(
                                                keyword: topBanners[index].bannerTitle,
                                                id: widget.id,
                                                longitude: widget.longitude,
                                                latitude: widget.lattude,
                                                lName: widget.lName,
                                              ),
                                            ),
                                          );
                                          break;
                                        case "reel":
                                          Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => HomePageNavReelScreen(
                                                id:  widget.id,
                                                longitude: widget.longitude,
                                                latitude: widget.lattude,
                                                lName: widget.lName,
                                                myBannerReelId: topBanners[index].keyword.toString()??""
                                              // '16'
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
                                                latitude: widget.lattude,
                                                longitude: widget.longitude,
                                                lName: widget.lName,
                                                fmId: topBanners[index].bannerTitle,
                                              ),
                                            ),
                                          );
                                          break;
                                          case "contest_details":
                                      launchWhatsApp(topBanners[index].keyword.toString(), topBanners[index].whatsapptext.toString());
                                      break;
                                      default:
                                    launchWhatsApp(topBanners[index].keyword.toString(), topBanners[index].whatsapptext.toString());
                                      }
                                    },
                                    child:
                                    CachedNetworkImage(
                                      imageUrl: banner.bannerImage ?? "",
                                      width: screenWidth,
                                      fit: BoxFit.fill,
                                      imageBuilder:
                                          (context, imageProvider) =>
                                              Container(
                                                margin: EdgeInsets.symmetric(horizontal: screenWidth/40),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.0),
                                          border: Border.all(color: ConstantColor.primaryMainColor,
                                          width: 0.5),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        ConstantImage.imageIsNotAvailable,
                                        height: screenHeight,
                                        width: screenWidth,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: topBanners.map((banner) {
                                  int index = topBanners.indexOf(banner);
                                  return dotS(
                                    width: screenWidth /25.0,
                                    height:  screenHeight/160,
                                    // width: _currentCarouselPage == index ? screenWidth / 50.0:screenWidth / 20.0,
                                    // height:  _currentCarouselPage == index ? screenHeight / 100.0 : screenHeight/200,
                                    margin: EdgeInsets.only(
                                      top: screenHeight / 8.0,
                                    ),
                                    shape: BoxShape.circle,
                                    color: _currentCarouselPage == index
                                        ? ConstantColor.primaryMainColor
                                        : ConstantColor.primaryGreyColor,
                                  );
                                }).toList(),
                              ),
                            ],
                          ),

                        /*---------------------------------carouselSlider  end  --------------------------------------------*/
                          SizedBox(height: screenHeight / 80,),
                        /*-------------------------------Sub Categoty Sliding Avatar items  -----------------------------------*/
                          Container(
                            // height: screenHeight/4.1,
                            color: ConstantColor.homeScreenAvatarBGColor,
                            padding: EdgeInsets.symmetric(vertical: screenHeight/80),
                            // padding: EdgeInsets.symmetric(
                            //   vertical: screenHeight / 80,
                            //   horizontal: screenWidth / 30,
                            // ),
                            child: GridView.builder(
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: topOffers.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 10.0,
                                    mainAxisSpacing: 10.0,
                              ),
                              itemBuilder: (BuildContext context, index) {
                                return allHomeScreenAvatar(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TopCategoriesSectionScreen(
                                                  topCategories:
                                                      topOffers[index]
                                                          .offerTitle
                                                          .toString(),
                                                  city: topOffers[index]
                                                      .offerTitle
                                                      .toString(),
                                                  id: widget.id,
                                                  logitude: widget.longitude,
                                                  latitude: widget.lattude,
                                                  lName: widget.lName)),
                                    );
                                  },
                                  width: screenWidth /7,
                                  // width: screenWidth /6,
                                  height: double.minPositive,
                                  borderRadius: BorderRadius.circular(100),
                                  image: CachedNetworkImage(
                                    imageUrl: topOffers[index].offerImage ?? "",
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      ConstantImage.imageIsNotAvailable,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  text: topOffers[index].offerTitle ?? "",
                                  textAlign: TextAlign.center,
                                  color:
                                      ConstantColor.primaryBackgroundMainColor,
                                );
                              },
                            ),
                          ),
                        /*----------------------------Sub Categoty Sliding Avatar items end -------------------------------------*/
                          SizedBox(
                            height: screenHeight / 80,
                          ),
                        /*---------------------------------Top category start  --------------------------------------------*/
                          Container(
                            width: double.infinity,
                            color: ConstantColor.primaryBackgroundMainColor,
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight / 80,
                              horizontal: screenWidth / 30,
                            ),
                            child: Text("TOP CATEGORY".toUpperCase(),
                                style: ConstantTextStyle.topCategoryText),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: screenHeight/80),
                            color: Colors.white,
                            child: GridView.builder(
                              padding: EdgeInsets.symmetric(horizontal: screenWidth/30),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              // itemCount: topCategoryIcons.length > 5 ? 5 : topCategoryIcons.length,
                              itemCount: topCategoryIcons.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 20.0,
                              ),
                              itemBuilder: (BuildContext context, index) {
                                final topCategoryIconsHere =
                                topCategoryIcons[index];
                                return allHomeScreenAvatar(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            TopCategoriesSectionScreen(
                                              topCategories:
                                              topCategoryIcons[index]
                                                  .iconTitle
                                                  .toString(),
                                              city: topCategoryIcons[index]
                                                  .iconTitle
                                                  .toString(),
                                              id: widget.id,
                                              logitude: widget.longitude,
                                              latitude: widget.lattude,
                                              lName: widget.lName,
                                            )),
                                    );
                                  },
                                  width: screenWidth / 8,
                                  height: double.minPositive,
                                  borderRadius: BorderRadius.circular(100),
                                  image: CachedNetworkImage(
                                    imageUrl: topCategoryIconsHere.iconImage ?? "",
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                          ConstantImage.imageIsNotAvailable,
                                          fit: BoxFit.fill,
                                        ),
                                  ),
                                  text: topCategoryIconsHere.iconTitle ?? "",
                                  textAlign: TextAlign.center,
                                  color: ConstantColor.primaryBackgroundMainColor,
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
                        /*---------------------------------Top category end  --------------------------------------------*/
                          //  SizedBox(height: screenHeight / 80,),
                        /*---------------------------------cashback store card start --------------------------------------------*/
                        //                   Container(
                        //                     color: ConstantColor.primaryBackgroundMainColor,
                        //                     child: Row(
                        //                       mainAxisAlignment: MainAxisAlignment.center,
                        //                       children: [
                        //                         GestureDetector(
                        //                           onTap: () {
                        //                             Navigator.push(
                        //                               context,
                        //                               MaterialPageRoute(
                        //                                   builder: (context) =>
                        //                                   const ProductCashbackStore()),
                        //                             );
                        //                           },
                        //                           child: cards(
                        //                             context: context,
                        //                             radius: 30.0,
                        //                             icon: Icons.add_business_rounded,
                        //                             text: "Cashback Stores",
                        //                             textAlign: TextAlign.center,
                        //                             style: ConstantTextStyle.topCategoryText,
                        //                           ),
                        //                         ),
                        //                         GestureDetector(
                        //                           onTap: () {
                        //                             Navigator.push(
                        //                               context,
                        //                               MaterialPageRoute(
                        //                                   builder: (context) => const CashbackCoins()),
                        //                             );
                        //                           },
                        //                           child: cards(
                        //                             context: context,
                        //                             radius: 30.0,
                        //                             icon: Icons.card_giftcard_rounded,
                        //                             text: " Redeem Points",
                        //                             textAlign: TextAlign.center,
                        //                             style: ConstantTextStyle.topCategoryText,
                        //                           ),
                        //                         ),
                        //                       ],
                        //                     ),
                        //                   ),
                          SizedBox(height: screenHeight / 80,),
                        /*---------------------------------cashback store card end --------------------------------------------*/
                          if (widget.lName == "Indore")
                            TrendingReelsContainer(
                              id: widget.id,
                              longitude: widget.longitude,
                              latitude: widget.lattude,
                              lName: widget.lName,
                            )
                          else
                            Container(),
                          if (widget.lName == "Indore")
                            SizedBox(
                              height: screenHeight / 80,
                            )
                          else
                            Container(),
                        /*---------------------------------Fashion Accessories start --------------------------------------------*/
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: screenHeight / 100,
                                horizontal: screenWidth / 40),
                            color: ConstantColor.primaryBackgroundMainColor,
                            child:
                            widget.lName != "Indore" ? null: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    customeText(
                                      text: "FASHION & ACCESSORIES".toUpperCase(),
                                      textAlign: TextAlign.start,
                                      style: ConstantTextStyle.topCategoryText,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SeeMoreProductsScreen(
                                                    // keyword: "fashion-accessories",
                                                    keyword: "fashionaccessories",
                                                    id: widget.id,
                                                    longitude: widget.longitude,
                                                    latitude: widget.lattude,
                                                    lName: widget.lName,
                                                  )),
                                        );
                                      },
                                      child: customeText(
                                        text: "See More".toUpperCase(),
                                        textAlign: TextAlign.start,
                                        style: ConstantTextStyle
                                            .seeMoreButtonStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: screenHeight / 80,
                                ),
                                Stack(
                                  children: [
                                    SizedBox(
                                      height: screenHeight / 6.0,
                                      child: ListView.builder(
                                        controller: _scrollControllerfac,
                                        itemExtent: screenWidth / 2.5,
                                        itemCount: topFashionAcs.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                        //*****************************************************************************
                                          final product = topFashionAcs[index];
                        //*****************************************************************************
                                          return Card(
                                            elevation: 3,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: screenWidth / 60),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ProductDetailScreen(
                                                                    proId: topFashionAcs[
                                                                            index]
                                                                        .productId,
                                                                    id: widget
                                                                        .id,
                                                                    longitude:
                                                                        widget
                                                                            .longitude,
                                                                    latitude: widget
                                                                        .lattude,
                                                                    lName: widget
                                                                        .lName,
                                                                  )));
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical:
                                                                  screenHeight /
                                                                      200),
                                                      child: Center(
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(5.0),
                                                          child:
                                                              CachedNetworkImage(height: screenHeight /
                                                                    8,
                                                            width:
                                                                screenWidth / 2,
                                                            imageUrl: product
                                                                    .productImage ??
                                                                "",
                                                            imageBuilder: (context,
                                                                    imageProvider) =>
                                                                Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  image:
                                                                      imageProvider,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                            ),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                Image.asset(
                                                                    ConstantImage
                                                                        .imageIsNotAvailable,
                                                                    height:
                                                                        screenHeight /
                                                                            8,
                                                                    width:
                                                                        screenWidth /
                                                                            2,
                                                                    fit: BoxFit
                                                                        .contain),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: customeText(
                                                      text: product.productTitle ?? '',
                                                      overflow: TextOverflow.ellipsis,
                                                      textAlign: TextAlign.start,
                                                      style: ConstantTextStyle.allHomeScreenAvatarText,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      right: screenWidth / 40,
                                      top: 0,
                                      bottom: 0,
                                      child: arrowButons(
                                        onTap: () {
                                          setState(() {
                                            fAcs = !fAcs;
                                          });
                                          Future.delayed(
                                              const Duration(milliseconds: 500),
                                              () {
                                            setState(() {
                                              fAcs = !fAcs;
                                            });
                                          });
                                          scrollListRightSideFcs();
                                        },
                                        radius: 15.0,
                                        backgroundColor: fAcs
                                            ? ConstantColor.primaryMainColor
                                            : ConstantColor.iconBackTPColor,
                                        icon: Icons.arrow_forward_ios_rounded,
                                        iconSize: 20.0,
                                        color: fAcs
                                            ? ConstantColor.searchBoxColor
                                            : ConstantColor.primaryMainColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        /*---------------------------------Fashion Accessories end --------------------------------------------*/
                          adsBannerMiddles.isEmpty
                              ? Container()
                              : SizedBox(height: screenHeight / 80,),
                        /*---------------------------------carouselSlider  start  --------------------------------------------*/
                          adsBannerMiddles.isEmpty
                              ? Container()
                              : Stack(
                            children: [
                              carouselSlider(
                                bannerHeight: screenHeight / 7,
                                autoPlay: true,
                                viewportFraction: 1.0,
                                enlargeCenterPage: true,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _currentCarouselPage2 = index;
                                  });
                                },
                                controller: _pageController2,
                                data: List.generate(adsBannerMiddles.length,
                                        (index) {
                                      final MiddleBanner = adsBannerMiddles[index];
                                      return GestureDetector(
                                        onTap: () {
                                          switch (MiddleBanner.type) {
                                            case "shop_detail":
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => StoreDetailScreen(
                                                    sellersId: MiddleBanner.keyword,
                                                    id: widget.id,
                                                    longitude: widget.longitude,
                                                    latitude: widget.lattude,
                                                    lName: widget.lName,
                                                  ),
                                                ),
                                              );
                                              break;
                                            case "product_details":
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => ProductDetailScreen(proId:MiddleBanner.keyword,
                                                      id: widget.id,
                                                      longitude: widget.longitude,
                                                      latitude: widget.lattude,
                                                      lName: widget.lName,)),
                                              );
                                              break;
                                            case "product_List":
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => SeeMoreProductsScreen(
                                                    keyword: MiddleBanner.bannerTitle,
                                                    id: widget.id,
                                                    longitude: widget.longitude,
                                                    latitude: widget.lattude,
                                                    lName: widget.lName,
                                                  ),
                                                ),
                                              );
                                              break;
                                            case "reel":
                                              Navigator.push(context,
                                                MaterialPageRoute(builder: (context) => HomePageNavReelScreen(
                                                    id:  widget.id,
                                                    longitude: widget.longitude,
                                                    latitude: widget.lattude,
                                                    lName: widget.lName,
                                                    myBannerReelId: MiddleBanner.keyword.toString()??""
                                                  // '16'
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
                                                    latitude: widget.lattude,
                                                    longitude: widget.longitude,
                                                    lName: widget.lName,
                                                    fmId: MiddleBanner.bannerTitle,
                                                  ),
                                                ),
                                              );
                                              break;
                                            case "contest_details":
                                              launchWhatsApp(MiddleBanner.keyword.toString(), MiddleBanner.whatsapptext.toString());
                                              break;
                                            default:
                                              launchWhatsApp(MiddleBanner.keyword.toString(), MiddleBanner.whatsapptext.toString());
                                          }
                                        },
                                        child: CachedNetworkImage(
                                          imageUrl:
                                          MiddleBanner.bannerImage ?? "",
                                          width: screenWidth,
                                          fit: BoxFit.fill,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                              Container(
                                                margin: EdgeInsets.symmetric(horizontal: screenWidth/40),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5.0),
                                                  border: Border.all(color: ConstantColor.primaryMainColor,
                                                      width: 0.5),
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                                ConstantImage.imageIsNotAvailable,
                                                height: screenHeight,
                                                width: screenWidth,
                                                fit: BoxFit.fill,
                                              ),
                                        ),
                                      );
                                    }),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: adsBannerMiddles.map((banner) {
                                  int index = adsBannerMiddles.indexOf(banner);
                                  return dotS(
                                    width: screenWidth /25.0,
                                    height:  screenHeight/160,
                                    // width: _currentCarouselPage2 == index ? screenWidth / 50.0:screenWidth / 20.0,
                                    // height:  _currentCarouselPage2 == index ? screenHeight / 100.0 : screenHeight/200,
                                    margin: EdgeInsets.only(
                                      top: screenHeight / 8.0,
                                    ),
                                    shape: BoxShape.circle,
                                    color: _currentCarouselPage2 == index
                                        ? ConstantColor.primaryMainColor
                                        : ConstantColor.primaryGreyColor,
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        /*---------------------------------carouselSlider  end  --------------------------------------------*/
                          mySizedBox(),
                        /*---------------------------------famous market start --------------------------------------------*/
                          Container(
                            padding: widget.lName != "Indore" ? null: EdgeInsets.symmetric(
                                vertical: screenHeight / 40,
                                horizontal: screenWidth / 40),
                            color: ConstantColor.primaryBackgroundMainColor,
                            child: widget.lName != "Indore" ? null: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                customeText(
                                  text: "FAMOUS MARKET".toUpperCase(),
                                  textAlign: TextAlign.start,
                                  style: ConstantTextStyle.topCategoryText,
                                ),
                                SizedBox(height: screenHeight / 80),
                                Stack(
                                  children: [
                                    SizedBox(
                                      height: screenHeight / 6.0,
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        itemExtent: screenWidth / 2.5,
                                        controller: _scrollController,
                                        itemCount: famousMarkets.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          final market = famousMarkets[index];
                                          return homepageFamousMarketCard(
                                            onTapped: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => FamousMarketListScreen(
                                                    id: widget.id,
                                                    latitude: widget.lattude,
                                                    longitude: widget.longitude,
                                                    lName: widget.lName,
                                                    fmId: famousMarkets[index].fmId.toString(),
                                                  ),
                                                ),
                                              );
                                            },
                                            context: context,
                                            cardBorderRadius:
                                                BorderRadius.circular(10.0),
                                            imgBorderRadius:
                                                BorderRadius.circular(8.0),
                                            img: market.imageUrl ?? "",
                                            fit: BoxFit.fill,
                                            imgHeight: screenHeight / 8,
                                            imgWidth: screenWidth,
                                            icon: Icons.pin_drop_rounded,
                                            iconColor:
                                                ConstantColor.primaryMainColor,
                                            iconSize: 15.0,
                                            marketTitleText:
                                                market.location ?? "",
                                            marketTitleTextStyle:
                                                ConstantTextStyle
                                                    .allHomeScreenAvatarText,
                                          );
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      left: screenWidth / 40,
                                      top: 0,
                                      bottom: 0,
                                      child: arrowButons(
                                        onTap: () {
                                          setState(() {
                                            famousMarketLeftIconBGColor =
                                                !famousMarketLeftIconBGColor;
                                          });
                                          Future.delayed(
                                              const Duration(milliseconds: 500),
                                              () {
                                            setState(() {
                                              famousMarketLeftIconBGColor =
                                                  !famousMarketLeftIconBGColor;
                                            });
                                          });
                                          scrollListLeftSide();
                                        },
                                        radius: 14.0,
                                        backgroundColor:
                                            famousMarketLeftIconBGColor
                                                ? ConstantColor.primaryMainColor
                                                : ConstantColor.iconBackTPColor,
                                        icon: Icons.arrow_back_ios_new_rounded,
                                        color: famousMarketLeftIconBGColor
                                            ? ConstantColor.searchBoxColor
                                            : ConstantColor.primaryMainColor,
                                      ),
                                    ),
                                    Positioned(
                                      right: screenWidth / 40,
                                      top: 0,
                                      bottom: 0,
                                      child: arrowButons(
                                        onTap: () {
                                          setState(() {
                                            famousMarketRightIconBGColor =
                                                !famousMarketRightIconBGColor;
                                          });
                                          Future.delayed(
                                              const Duration(milliseconds: 500),
                                              () {
                                            setState(() {
                                              famousMarketRightIconBGColor =
                                                  !famousMarketRightIconBGColor;
                                            });
                                          });
                                          scrollListRightSide();
                                        },
                                        radius: 15.0,
                                        iconSize: 20.0,
                                        backgroundColor:
                                            famousMarketRightIconBGColor
                                                ? ConstantColor.primaryMainColor
                                                : ConstantColor.iconBackTPColor,
                                        icon: Icons.arrow_forward_ios_rounded,
                                        color: famousMarketRightIconBGColor
                                            ? ConstantColor.searchBoxColor
                                            : ConstantColor.primaryMainColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        /*---------------------------------famous market end --------------------------------------------*/
                          mySizedBox(),
                        /*---------------------------------Top seller start --------------------------------------------*/

                          Container(
                            color: ConstantColor.primaryBackgroundMainColor,
                            padding:  EdgeInsets.symmetric(
                                vertical: screenHeight / 80,
                                horizontal: screenWidth / 40),
                            child: widget.lName != "Indore" ? null:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                  visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                                  title: customeText(
                                    text:"Top Seller".toUpperCase(),
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    style:  ConstantTextStyle.topCategoryText, ),
                                  trailing:   GestureDetector(
                                    onTap: () {
                                      Navigator.push( context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              GetSellerScreen(
                                                keyword: "focused_shop",
                                                id: widget.id,
                                                lattude: widget.lattude,
                                                longitude: widget.longitude,
                                                lName: widget.lName,
                                              ),
                                        ),
                                      );
                                      },
                                    child: customeText(
                                      text: "See More".toUpperCase(),
                                      textAlign: TextAlign.start,
                                      style: ConstantTextStyle
                                          .seeMoreButtonStyle,
                                    ),
                                  ),
                                ),
                                Stack(
                                  children: [
                                    SizedBox(
                                      height: screenHeight / 7,
                                      child: ListView.builder(
                                          controller: scrollControllerTopSeller,
                                          itemCount: topSellers.length,
                                          shrinkWrap: true,
                                          itemExtent: screenWidth / 3.5,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return topSellerCard(
                                              context: context,
                                              borderColor: ConstantColor
                                                  .primaryMainColor,
                                              cardBorderRadius:
                                                  BorderRadius.circular(8.0),
                                              imgBorderRadius:
                                                  BorderRadius.circular(8.0),
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          StoreDetailScreen(
                                                            sellersId:
                                                                topSellers[index].shop?.sellerId,
                                                              id: widget.id, longitude: widget.longitude, latitude: widget.lattude,lName: widget.lName,
                                                          )),
                                                );
                                              },
                                              img: topSellers[index].shop?.shopImage ?? "",
                                              imgWidth: screenWidth / 4,
                                              imgHeight: screenHeight / 10,
                                              fit: BoxFit.fill,
                                              titleText: topSellers[index]
                                                      .shop
                                                      ?.name ??
                                                  "",
                                              titleTextStyle: ConstantTextStyle
                                                  .allHomeScreenAvatarText,
                                              textAlign: TextAlign.start,
                                              maxLines: 2,
                                            );
                                          }),
                                    ),
                                    Positioned(
                                      right: screenWidth / 50,
                                      top: 0,
                                      bottom: 0,
                                      child: arrowButons(
                                        onTap: () {
                                          setState(() {
                                            topSellerIconBGColor =
                                                !topSellerIconBGColor;
                                          });
                                          Future.delayed(
                                              const Duration(
                                                  milliseconds: 500), () {
                                            setState(() {
                                              topSellerIconBGColor =
                                                  !topSellerIconBGColor;
                                            });
                                          });
                                          scrollTopSeller();
                                        },
                                        radius: 15.0,
                                        iconSize: 20.0,
                                        backgroundColor: topSellerIconBGColor
                                            ? ConstantColor.primaryMainColor
                                            : ConstantColor.iconBackTPColor,
                                        icon: Icons.arrow_forward_ios_rounded,
                                        color: topSellerIconBGColor
                                            ? ConstantColor.searchBoxColor
                                            : ConstantColor.primaryMainColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        /*---------------------------------Top seller end --------------------------------------------*/
                          SizedBox(height: screenHeight / 80,),
                        /*----------------------Promotion Stores index[0] Grid view start --------------------*/
                          Flexible(
                            child:  Container(
                              padding: widget.lName != "Indore" ? null: EdgeInsets.symmetric(
                                  vertical: screenHeight / 80,
                                  horizontal: screenWidth / 40),
                              color: ConstantColor.primaryBackgroundMainColor,
                              child: widget.lName != "Indore" ? null: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                    visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                                    title: customeText(
                                      text: promotionStores.isNotEmpty
                                          ? promotionStores[0].shop?.name
                                          : "".toUpperCase(),
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style:  ConstantTextStyle.topCategoryText, ),
                                    trailing:   GestureDetector(
                                      onTap: () {
                                        Navigator.push( context,
                                          MaterialPageRoute( builder: (context) =>
                                              StoreDetailScreen(
                                                sellersId: promotionStores[0].shop?.sellerId,
                                                id: widget.id,
                                                longitude: widget.longitude,
                                                latitude: widget.lattude,
                                                lName: widget.lName, )),  );  },
                                      child: customeText(
                                        text: "See More".toUpperCase(),
                                        textAlign: TextAlign.start,
                                        style: ConstantTextStyle
                                            .seeMoreButtonStyle,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenHeight / 2.8,
                                    child: GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1/1.2,
                                        crossAxisSpacing: screenWidth / 50,
                                        mainAxisSpacing: screenHeight / 80,
                                      ),
                                      itemCount: promotionStores.length > 4 ? 4 : promotionStores.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final topPromotionsStore = promotionStores[0];
                                        return promotionStore(
                                          onTapped: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductDetailScreen(
                                                        proId: promotionStores[0]
                                                            .products?[index]
                                                            .productId
                                                            .toString(),
                                                        id: widget.id,
                                                        longitude:
                                                            widget.longitude,
                                                        latitude:
                                                            widget.lattude,
                                                        lName: widget.lName,
                                                      )),
                                            );
                                          },
                                          context: context,
                                          cardBorderRadius:
                                              BorderRadius.circular(10.0),
                                          cardPadding: EdgeInsets.symmetric(
                                              horizontal: screenWidth / 80),
                                          image: topPromotionsStore.products?[index].productImage ??
                                              "",
                                          imageRadius:
                                              BorderRadius.circular(8.0),
                                          fit: BoxFit.fill,
                                          imgHeight: screenHeight / 7.0,
                                          imgWidth: screenWidth / 2.0,
                                          titleText: topPromotionsStore.products?[index].productTitle ??
                                              "",
                                          overflow: TextOverflow.ellipsis,
                                          titleTextAlign: TextAlign.start,
                                          titleTextStyle: ConstantTextStyle
                                              .allHomeScreenAvatarText,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        /*-----------------------Promotion Stores index[0] Grid view end --------------------------------------------*/
                          mySizedBox(),
                        /*---------------------------------Scrolling discount zone start --------------------------------------------*/
                          // Container(
                          //   padding: EdgeInsets.symmetric(
                          //       vertical: screenHeight / 80,
                          //       horizontal: screenWidth / 40),
                          //   color: ConstantColor.primaryBackgroundMainColor,
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       customeText(
                          //         text: "DISCOUNT ZONE".toUpperCase(),
                          //         textAlign: TextAlign.start,
                          //         style: ConstantTextStyle.topCategoryText,
                          //       ),
                          //       SizedBox(
                          //         height: screenHeight / 80,
                          //       ),
                          //       Stack(
                          //         children: [
                          //           SizedBox(
                          //             height: screenHeight / 9,
                          //             child: ListView.builder(
                          //                 controller: _scrollController2,
                          //                 itemCount: discountZones.length,
                          //                 shrinkWrap: true,
                          //                 scrollDirection: Axis.horizontal,
                          //                 itemBuilder: (context, index) {
                          //                   final discountedZone =
                          //                       discountZones[index];
                          //                   return Container(
                          //                     margin: EdgeInsets.only(
                          //                         right: screenWidth / 50),
                          //                     width: screenWidth / 2.3,
                          //                     height: screenHeight / 8,
                          //                     decoration: BoxDecoration(
                          //                       border: Border.all(
                          //                         color: ConstantColor
                          //                             .secondoryCardeBoarder,
                          //                         width: 1.0,
                          //                       ),
                          //                       color: ConstantColor
                          //                           .secondoryWhiteColors,
                          //                       borderRadius:
                          //                           BorderRadius.circular(10.0),
                          //                     ),
                          //                     child: ClipRRect(
                          //                       borderRadius:
                          //                           BorderRadius.circular(8.0),
                          //                       child: GestureDetector(
                          //                         onTap: () {
                          //                           Navigator.push(
                          //                             context,
                          //                             MaterialPageRoute(
                          //                                 builder: (context) =>
                          //                                     SeeMoreProductsScreen(
                          //                                       keyword: discountZones[index].name
                          //                                           .toString(),
                          //                                       id: widget.id,
                          //                                       longitude: widget
                          //                                           .longitude,
                          //                                       latitude: widget
                          //                                           .lattude,
                          //                                       lName: widget
                          //                                           .lName,
                          //                                     )),
                          //                           );
                          //                         },
                          //                         child: CachedNetworkImage(
                          //                           imageUrl:
                          //                               discountedZone.image ??
                          //                                   "",
                          //                           fit: BoxFit.fill,
                          //                           imageBuilder: (context,
                          //                                   imageProvider) =>
                          //                               Container(
                          //                             decoration: BoxDecoration(
                          //                               image: DecorationImage(
                          //                                 image: imageProvider,
                          //                                 fit: BoxFit.fill,
                          //                               ),
                          //                             ),
                          //                           ),
                          //                           errorWidget:
                          //                               (context, url, error) =>
                          //                                   Image.asset(
                          //                             ConstantImage
                          //                                 .imageIsNotAvailable,
                          //                             fit: BoxFit.fill,
                          //                           ),
                          //                         ),
                          //                       ),
                          //                     ),
                          //                   );
                          //                 }),
                          //           ),
                          //           Positioned(
                          //             left: screenWidth / 40,
                          //             top: 0,
                          //             bottom: 0,
                          //             child: arrowButons(
                          //               onTap: () {
                          //                 setState(() {
                          //                   discountZoneLeftIconBGColor =
                          //                       !discountZoneLeftIconBGColor;
                          //                 });
                          //                 Future.delayed(
                          //                     const Duration(milliseconds: 500),
                          //                     () {
                          //                   setState(() {
                          //                     discountZoneLeftIconBGColor =
                          //                         !discountZoneLeftIconBGColor;
                          //                   });
                          //                 });
                          //                 scrollListLeftSide2();
                          //               },
                          //               iconSize: 20.0,
                          //               radius: 15.0,
                          //               backgroundColor:
                          //                   discountZoneLeftIconBGColor
                          //                       ? ConstantColor.primaryMainColor
                          //                       : ConstantColor.iconBackTPColor,
                          //               icon: Icons.arrow_back_ios_new_rounded,
                          //               color: discountZoneLeftIconBGColor
                          //                   ? ConstantColor.searchBoxColor
                          //                   : ConstantColor.primaryMainColor,
                          //             ),
                          //           ),
                          //           Positioned(
                          //             right: screenWidth / 40,
                          //             top: 0,
                          //             bottom: 0,
                          //             child: arrowButons(
                          //               onTap: () {
                          //                 setState(() {
                          //                   discountZoneRightIconBGColor =
                          //                       !discountZoneRightIconBGColor;
                          //                 });
                          //                 Future.delayed(
                          //                     const Duration(milliseconds: 500),
                          //                     () {
                          //                   setState(() {
                          //                     discountZoneRightIconBGColor =
                          //                         !discountZoneRightIconBGColor;
                          //                   });
                          //                 });
                          //                 scrollListRightSide2();
                          //               },
                          //               radius: 15.0,
                          //               iconSize: 20.0,
                          //               backgroundColor:
                          //                   discountZoneRightIconBGColor
                          //                       ? ConstantColor.primaryMainColor
                          //                       : ConstantColor.iconBackTPColor,
                          //               icon: Icons.arrow_forward_ios_rounded,
                          //               color: discountZoneRightIconBGColor
                          //                   ? ConstantColor.searchBoxColor
                          //                   : ConstantColor.primaryMainColor,
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        /*---------------------------------Scrolling discount zone end --------------------------------------------*/
                          // SizedBox(height: screenHeight / 80),
                        /*---------------------------------carouselSlider start --------------------------------------------*/
                          Stack(
                            children: [
                              carouselSlider(
                                bannerHeight: screenHeight / 7,
                                autoPlay: true,
                                viewportFraction: 1.0,
                                enlargeCenterPage: true,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _currentCarouselPage3 = index;
                                  });
                                },
                                controller: _pageController3,
                                data: List.generate(adsBannerMiddle2.length,
                                    (index) {
                                  final MiddleBanner2 = adsBannerMiddle2[index];
                                  return GestureDetector(
                                    onTap: () {
                                      switch (MiddleBanner2.type) {
                                        case "shop_detail":
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => StoreDetailScreen(
                                                sellersId: MiddleBanner2.keyword,
                                                id: widget.id,
                                                longitude: widget.longitude,
                                                latitude: widget.lattude,
                                                lName: widget.lName,
                                              ),
                                            ),
                                          );
                                          break;
                                        case "product_details":
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ProductDetailScreen(proId:MiddleBanner2.keyword,
                                                  id: widget.id,
                                                  longitude: widget.longitude,
                                                  latitude: widget.lattude,
                                                  lName: widget.lName,)),
                                          );
                                          break;
                                        case "product_List":
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => SeeMoreProductsScreen(
                                                keyword: MiddleBanner2.bannerTitle,
                                                id: widget.id,
                                                longitude: widget.longitude,
                                                latitude: widget.lattude,
                                                lName: widget.lName,
                                              ),
                                            ),
                                          );
                                          break;
                                        case "reel":
                                          Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => HomePageNavReelScreen(
                                                id:  widget.id,
                                                longitude: widget.longitude,
                                                latitude: widget.lattude,
                                                lName: widget.lName,
                                                myBannerReelId: MiddleBanner2.keyword.toString()??""
                                              // '16'
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
                                                latitude: widget.lattude,
                                                longitude: widget.longitude,
                                                lName: widget.lName,
                                                fmId: MiddleBanner2.bannerTitle,
                                              ),
                                            ),
                                          );
                                          break;
                                        case "contest_details":
                                          launchWhatsApp(MiddleBanner2.keyword.toString(), MiddleBanner2.whatsapptext.toString());
                                          break;
                                        default:
                                          launchWhatsApp(MiddleBanner2.keyword.toString(), MiddleBanner2.whatsapptext.toString());
                                      }
                                    },
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          MiddleBanner2.bannerImage ?? "",
                                      width: screenWidth,
                                      fit: BoxFit.fill,
                                      imageBuilder:
                                          (context, imageProvider) =>
                                              Container(
                                                margin: EdgeInsets.symmetric(horizontal: screenWidth/40),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5.0),
                                                  border: Border.all(color: ConstantColor.primaryMainColor,
                                                      width: 0.5),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        ConstantImage.imageIsNotAvailable,
                                        height: screenHeight,
                                        width: screenWidth,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: adsBannerMiddle2.map((banner) {
                                  int index = adsBannerMiddle2.indexOf(banner);
                                  return dotS(
                                    // width: _currentCarouselPage3 == index ? screenWidth / 30.0:screenWidth / 50.0,
                                    // height:  _currentCarouselPage3 == index ? screenHeight / 150.0 : screenHeight/200,
                                    width: screenWidth /25.0,
                                    height:  screenHeight/160,
                                    margin: EdgeInsets.only(
                                      top: screenHeight / 8.0,
                                        //left: screenWidth/200.0,right: screenWidth/200.0
                                    ),
                                    shape: BoxShape.circle,
                                    color: _currentCarouselPage3 == index
                                        ? ConstantColor.primaryMainColor
                                        : ConstantColor.primaryGreyColor,
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        /*---------------------------------carouselSlider end --------------------------------------------*/
                          SizedBox(
                            height: screenHeight / 80,
                          ),
                        /*---------------------------------Top mobile & electronics Listview start --------------------------------------------*/
                          Container(
                            padding: widget.lName != "Indore" ? null: EdgeInsets.symmetric(
                                vertical: screenHeight / 50,
                                horizontal: screenWidth / 40),
                            color: ConstantColor.primaryBackgroundMainColor,
                            child: widget.lName != "Indore" ? null: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    customeText(
                                      text: "top mobile & electronics"
                                          .toUpperCase(),
                                      textAlign: TextAlign.start,
                                      style: ConstantTextStyle.topCategoryText,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SeeMoreProductsScreen(
                                                    keyword: "topmobileandelectronics",
                                                    // keyword: "top-mobile-and-electronics",
                                                    id: widget.id,
                                                    longitude: widget.longitude,
                                                    latitude: widget.lattude,
                                                    lName: widget.lName,
                                                  )),
                                        );
                                      },
                                      child: customeText(
                                        text: "See More".toUpperCase(),
                                        textAlign: TextAlign.start,
                                        style: ConstantTextStyle
                                            .seeMoreButtonStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: screenHeight / 80),
                                Stack(
                                  children: [
                                    SizedBox(
                                      height: screenHeight /4.5,
                                      // height: screenHeight / 3.8,
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        controller: _scrollController3,
                                        itemExtent: screenWidth / 2.1,
                                        itemCount: topHomeKitchenProducts.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                        //*****************************************************************************
                                          // discount Logic is here
                                          double getPercantageOff(
                                              double price, double offerPrice) {
                                            double result =
                                                ((price - offerPrice) / price) *
                                                    100;
                                            return result.floor().toDouble();
                                          }

                                          final TopMobileProduct = bestProductMobileElectonicProducts[index];
                                          final offerPrice = double.tryParse(
                                                  TopMobileProduct.offerPrice ??
                                                      '0') ??
                                              0.0;
                                          final price = double.tryParse(
                                                  TopMobileProduct.price ??
                                                      '0') ??
                                              0.0;
                                          final percentageOff =
                                              offerPrice != 0.0
                                                  ? getPercantageOff(
                                                      price, offerPrice)
                                                  : 0.0;
                                          final roundedPercentageOff =
                                              percentageOff.toStringAsFixed(0);
                        //*****************************************************************************
                                          return
                                            Card(
                                            elevation: 4,
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            child:
                                            // Container(
                                            //   margin: EdgeInsets.all(6.0),
                                            //   padding: EdgeInsets.symmetric(horizontal: screenWidth /50),
                                            //   decoration: BoxDecoration(
                                            //     color: Colors.white, // Background color
                                            //     borderRadius: BorderRadius.circular(8.0), // Border radius
                                            //     boxShadow: [
                                            //       BoxShadow(
                                            //         color: Colors.grey.withOpacity(0.5),
                                            //         spreadRadius: 1,
                                            //         blurRadius: 3,
                                            //         offset: Offset(0, 1), // changes position of shadow
                                            //       ),
                                            //     ],
                                            //   ),
                                            //   child:

                                            Padding(
                                            padding: EdgeInsets.symmetric(horizontal: screenWidth /40),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                cashBackChip(
                                                  context: context,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  text: percentageOff > 0
                                                      ? '$roundedPercentageOff% off'
                                                      : "",
                                                  style: ConstantTextStyle
                                                      .newiconButtonText,
                                                  textAlign: TextAlign.start,
                                                  color: percentageOff > 0
                                                      ? ConstantColor
                                                          .chipColor
                                                      : null,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProductDetailScreen(
                                                                proId: TopMobileProduct.productId.toString(),
                                                                id: widget.id,
                                                                longitude: widget.longitude,
                                                                latitude: widget.lattude,
                                                                lName: widget.lName,
                                                              )),
                                                    );
                                                  },
                                                  child: Center(
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(8.0),
                                                      child: CachedNetworkImage(
                                                        imageUrl: TopMobileProduct.productImage ?? "",
                                                        height: screenHeight /8.5,
                                                        width: screenWidth / 3,
                                                        fit: BoxFit.contain,
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Image.asset(
                                                          height: screenHeight / 8,
                                                          width: screenWidth / 3,
                                                          ConstantImage.imageIsNotAvailable,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: screenHeight / 200,),
                                                customeText(
                                                  text: TopMobileProduct.productTitle ?? '',
                                                  overflow: TextOverflow.ellipsis,
                                                  style: ConstantTextStyle.allHomeScreenAvatarText
                                                ),
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical:
                                                                screenHeight /
                                                                    200),
                                                    child: customRichText(
                                                      text1: NumberFormat
                                                              .simpleCurrency(
                                                                  locale:
                                                                      "hi-NI",
                                                                  decimalDigits:
                                                                      2)
                                                          .format(
                                                              double.parse(
                                                        TopMobileProduct
                                                                .offerPrice ??
                                                            TopMobileProduct
                                                                .price ??
                                                            "N/A",
                                                      )),
                                                      style1:
                                                          ConstantTextStyle
                                                              .richtext1,
                                                      TextAlign:
                                                          TextAlign.start,
                                                      text2: percentageOff > 0
                                                          ? NumberFormat.simpleCurrency(
                                                                  locale:
                                                                      "hi-NI",
                                                                  decimalDigits:
                                                                      2)
                                                              .format(double.parse(
                                                                  TopMobileProduct
                                                                          .price ??
                                                                      ''))
                                                          : " ",
                                                      style2:
                                                          ConstantTextStyle
                                                              .richtext2,
                                                    ),
                                                  ),
                                                ),
                                                // Flexible(
                                                //   child: ElevatedButton.icon(
                                                //     onPressed: bestProductMobileElectonicProducts[index].wantToBuy == "1" ? null : () async {
                                                //       SharedPreferences preferences = await SharedPreferences.getInstance();
                                                //       setState(() {
                                                //         isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                                                //         tokenAccess = preferences.getString("access-token");
                                                //       });
                                                //       if (isUserLoggedIn) {
                                                //         await fetchSendEnquiryAPi(
                                                //           prodId: bestProductMobileElectonicProducts[index].productId ?? '',
                                                //           wantBuy: "1",
                                                //           tokenAccess:tokenAccess,
                                                //           index: index,
                                                //         );
                                                //       } else {
                                                //         showDialog(
                                                //           barrierDismissible: false,
                                                //           context: context,
                                                //           builder: (BuildContext context) {
                                                //             return  const CheckIsLogin();
                                                //           },
                                                //         );
                                                //       }
                                                //     },
                                                //     icon: const Icon(
                                                //       Icons.content_paste_search,
                                                //       color: ConstantColor.primaryBackgroundMainColor,
                                                //       size: 18.0,
                                                //     ),
                                                //     label: Text(
                                                //       'Send Enquiry',
                                                //       style: ConstantTextStyle.newiconButtonText,
                                                //     ),
                                                //     style: ElevatedButton.styleFrom(
                                                //       minimumSize: Size.fromHeight(screenHeight / 25),
                                                //       backgroundColor: bestProductMobileElectonicProducts[index].wantToBuy == "1"
                                                //           ? ConstantColor.primaryGreyColor
                                                //           : ConstantColor.primaryMainColor,
                                                //       shape: RoundedRectangleBorder(
                                                //         borderRadius: BorderRadius.circular(10.0),
                                                //       ),
                                                //     ),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                            ),
                                            );
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      left: screenWidth / 40,
                                      top: 0,
                                      bottom: 0,
                                      child: arrowButons(
                                        onTap: () {
                                          setState(() {
                                            topMobileElectronicsLeftIconBGColor =
                                                !topMobileElectronicsLeftIconBGColor;
                                          });
                                          Future.delayed(
                                              const Duration(milliseconds: 500),
                                              () {
                                            setState(() {
                                              topMobileElectronicsLeftIconBGColor = !topMobileElectronicsLeftIconBGColor;
                                            });
                                          });
                                          scrollListLeftSide3();
                                        },
                                        radius: 15.0,
                                        backgroundColor:
                                            topMobileElectronicsLeftIconBGColor
                                                ? ConstantColor.primaryMainColor
                                                : ConstantColor.iconBackTPColor,
                                        icon: Icons.arrow_back_ios_rounded,
                                        iconSize: 20.0,
                                        color:
                                            topMobileElectronicsLeftIconBGColor
                                                ? ConstantColor.searchBoxColor
                                                : ConstantColor
                                                    .primaryMainColor,
                                      ),
                                    ),
                                    Positioned(
                                      right: screenWidth / 40,
                                      top: 0,
                                      bottom: 0,
                                      child: arrowButons(
                                        onTap: () {
                                          setState(() {
                                            topMobileElectronicsRightIconBGColor =
                                                !topMobileElectronicsRightIconBGColor;
                                          });
                                          Future.delayed(
                                              const Duration(milliseconds: 500),
                                              () {
                                            setState(() {
                                              topMobileElectronicsRightIconBGColor =
                                                  !topMobileElectronicsRightIconBGColor;
                                            });
                                          });
                                          scrollListRightSide3();
                                        },
                                        radius: 15.0,
                                        backgroundColor:
                                            topMobileElectronicsRightIconBGColor
                                                ? ConstantColor.primaryMainColor
                                                : ConstantColor.iconBackTPColor,
                                        icon: Icons.arrow_forward_ios_rounded,
                                        iconSize: 20.0,
                                        color:
                                            topMobileElectronicsRightIconBGColor
                                                ? ConstantColor.searchBoxColor
                                                : ConstantColor
                                                    .primaryMainColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        /*---------------------------------Top mobile List view end --------------------------------------------*/
                          mySizedBox(),
                        /*---------------------------------Famous Store start --------------------------------------------*/
                          Container(
                            padding: widget.lName != "Indore" ? null: EdgeInsets.symmetric(
                                vertical: screenHeight / 100,
                                horizontal: screenWidth / 40),
                            color: ConstantColor.primaryBackgroundMainColor,
                            child:widget.lName != "Indore" ? null: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                  visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                                  title: customeText(
                                    text:"Famous Store".toUpperCase(),
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    style:  ConstantTextStyle.topCategoryText, ),
                                  trailing:  GestureDetector(
                                    onTap: () {
                                      Navigator.push( context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              GetSellerScreen(
                                                keyword: "focused_shop",
                                                id: widget.id,
                                                lattude: widget.lattude,
                                                longitude: widget.longitude,
                                                lName: widget.lName,
                                              ),
                                        ),
                                      );  },
                                    child: customeText(
                                      text: "See More".toUpperCase(),
                                      textAlign: TextAlign.start,
                                      style: ConstantTextStyle
                                          .seeMoreButtonStyle,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight / 7.0,
                                  child: ListView.builder(
                                    controller: _scrollController4,
                                    itemExtent: screenWidth / 2.5,
                                    itemCount: famousStore.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                        //*****************************************************************************
                                      final famousStores = famousStore[index];
                        //*****************************************************************************
                                      return Card(
                                        color: ConstantColor
                                            .secondoryCardeBoarder,
                                        elevation: 0.1,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(8.0),
                                        ),
                                        child: ListView(
                                          physics: const NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: screenWidth / 60),
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        StoreDetailScreen(
                                                          sellersId: famousStore[index].sellerId.toString(),
                                                          id: widget.id,
                                                          longitude: widget.longitude,
                                                          latitude:
                                                          widget.lattude,
                                                          lName: widget.lName,
                                                        ),
                                                  ),
                                                );
                                              },
                                              child: Padding(
                                                padding:
                                                EdgeInsets.symmetric(
                                                    vertical:
                                                    screenHeight /
                                                        200),
                                                child: Center(
                                                  child: ClipRRect(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        8.0),
                                                    child:
                                                    CachedNetworkImage(
                                                      imageUrl: famousStores
                                                          .shopImage ??
                                                          "",
                                                      height:
                                                      screenHeight /
                                                          10,
                                                      width:
                                                      screenWidth / 2,
                                                      fit: BoxFit.fill,
                                                      errorWidget:
                                                          (context, url,
                                                          error) =>
                                                          Image.asset(
                                                            height:
                                                            screenHeight /
                                                                8,
                                                            width:
                                                            screenWidth /
                                                                3,
                                                            ConstantImage
                                                                .imageIsNotAvailable,
                                                            fit: BoxFit.fill,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            customeText(
                                              text:
                                              famousStores.name ?? '',
                                              overflow:
                                              TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: ConstantTextStyle
                                                  .allHomeScreenAvatarText,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                // Stack(
                                //   children: [
                                //
                                //     Positioned(
                                //       left: screenWidth / 40,
                                //       top: 0,
                                //       bottom: 0,
                                //       child: arrowButons(
                                //         onTap: () {
                                //           setState(() {
                                //             famousStoreLeftIconBGColor = !famousStoreLeftIconBGColor;
                                //           });
                                //           Future.delayed(
                                //               const Duration(milliseconds: 500),
                                //               () {
                                //             setState(() {
                                //               famousStoreLeftIconBGColor = !famousStoreLeftIconBGColor;
                                //             });
                                //           });
                                //           scrollListLeftSide4();
                                //         },
                                //         radius: 15.0,
                                //         backgroundColor:
                                //             famousStoreLeftIconBGColor
                                //                 ? ConstantColor.primaryMainColor
                                //                 : ConstantColor.iconBackTPColor,
                                //         icon: Icons.arrow_back_ios_rounded,
                                //         iconSize: 20.0,
                                //         color: famousStoreLeftIconBGColor
                                //             ? ConstantColor.searchBoxColor
                                //             : ConstantColor.primaryMainColor,
                                //       ),
                                //     ),
                                //     Positioned(
                                //       right: screenWidth / 40,
                                //       top: 0,
                                //       bottom: 0,
                                //       child: arrowButons(
                                //         onTap: () {
                                //           setState(() {
                                //             famousStoreRightIconBGColor =
                                //                 !famousStoreRightIconBGColor;
                                //           });
                                //           Future.delayed(
                                //               const Duration(milliseconds: 500),
                                //               () {
                                //             setState(() {
                                //               famousStoreRightIconBGColor =
                                //                   !famousStoreRightIconBGColor;
                                //             });
                                //           });
                                //           scrollListRightSide4();
                                //         },
                                //         radius: 15.0,
                                //         backgroundColor:
                                //             famousStoreRightIconBGColor
                                //                 ? ConstantColor.primaryMainColor
                                //                 : ConstantColor.iconBackTPColor,
                                //         icon: Icons.arrow_forward_ios_rounded,
                                //         iconSize: 20.0,
                                //         color: famousStoreRightIconBGColor
                                //             ? ConstantColor.searchBoxColor
                                //             : ConstantColor.primaryMainColor,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        /*---------------------------------Famous Store end --------------------------------------------*/
                          mySizedBox(),
                        /*----------------------Promotion Stores index[1] Grid view start --------------------*/
                          Flexible(
                            child: Container(
                              padding: widget.lName != "Indore" ? null: EdgeInsets.symmetric(
                                  vertical: screenHeight / 80,
                                  horizontal: screenWidth / 40),
                              color: ConstantColor.primaryBackgroundMainColor,
                              child: widget.lName != "Indore" ? null: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                    visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                                    title: customeText(
                                      text: promotionStores.isNotEmpty
                                          ? promotionStores[1].shop?.name
                                          : "".toUpperCase(),
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style:  ConstantTextStyle.topCategoryText, ),
                                    trailing:   GestureDetector(
                                      onTap: () {
                                        Navigator.push( context,
                                          MaterialPageRoute( builder: (context) =>
                                              StoreDetailScreen(
                                                sellersId:   promotionStores[1].shop?.sellerId,
                                                id: widget.id,
                                                longitude: widget.longitude,
                                                latitude: widget.lattude,
                                                lName: widget.lName, )),  );  },
                                      child: customeText(
                                        text: "See More".toUpperCase(),
                                        textAlign: TextAlign.start,
                                        style: ConstantTextStyle
                                            .seeMoreButtonStyle,
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: screenHeight / 2.8,
                                    child: GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1 / 1.2,
                                        crossAxisSpacing: screenWidth / 80,
                                        mainAxisSpacing: screenHeight / 80,
                                      ),
                                      itemCount:promotionStores.length > 4 ? 4 : promotionStores.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        // final topPromotionsStore = promotionStores[1];
                                        final topPromotionsStore = promotionStores[1];
                                        return promotionStore(
                                          onTapped: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductDetailScreen(
                                                        proId: promotionStores[1]
                                                            .products?[index]
                                                            .productId
                                                            .toString(),
                                                        id: widget.id,
                                                        longitude:
                                                            widget.longitude,
                                                        latitude:
                                                            widget.lattude,
                                                        lName: widget.lName,
                                                      )),
                                            );
                                          },
                                          context: context,
                                          cardBorderRadius:
                                              BorderRadius.circular(10.0),
                                          cardPadding: EdgeInsets.symmetric(
                                              horizontal: screenWidth / 80),
                                          image: topPromotionsStore
                                                  .products?[index]
                                                  .productImage ??
                                              "",
                                          imageRadius:
                                              BorderRadius.circular(8.0),
                                          fit: BoxFit.fill,
                                          imgHeight: screenHeight / 7.0,
                                          imgWidth: screenWidth / 2.0,
                                          titleText: topPromotionsStore
                                                  .products?[index]
                                                  .productTitle ??
                                              "",
                                          overflow: TextOverflow.ellipsis,
                                          titleTextAlign: TextAlign.start,
                                          titleTextStyle: ConstantTextStyle
                                              .allHomeScreenAvatarText,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        /*-----------------------Promotion Stores index[1] Grid view end ---------------------*/
                          mySizedBox(),
                        /*---------------------------------Top Rating Store start --------------------------------------------*/
                          Container(
                            padding: widget.lName != "Indore" ? null: EdgeInsets.symmetric(
                                vertical: screenHeight / 100,
                                horizontal: screenWidth / 40),
                            color: ConstantColor.primaryBackgroundMainColor,
                            child: widget.lName != "Indore" ? null: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                  visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                                  title: customeText(
                                    text:"TOP RATING STORES".toUpperCase(),
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    style:  ConstantTextStyle.topCategoryText, ),
                                  trailing:   GestureDetector(
                                    onTap: () {
                                      Navigator.push( context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              GetSellerScreen(
                                                keyword: "focused_shop",
                                                id: widget.id,
                                                lattude: widget.lattude,
                                                longitude: widget.longitude,
                                                lName: widget.lName,
                                              ),
                                        ),
                                      );  },
                                    child: customeText(
                                      text: "See More".toUpperCase(),
                                      textAlign: TextAlign.start,
                                      style: ConstantTextStyle
                                          .seeMoreButtonStyle,
                                    ),
                                  ),
                                ),
                                Stack(
                                  children: [
                                    SizedBox(
                                      height: screenHeight / 6,
                                      child: ListView.builder(
                                        controller: _scrollController5,
                                        itemExtent: screenWidth / 2.5,
                                        itemCount: topRatingStores.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                        //*****************************************************************************
                                          final TopRatingStore =
                                              topRatingStores[index];
                        //*****************************************************************************
                                          return Card(
                                            color: ConstantColor
                                                .secondoryCardeBoarder,
                                            elevation: 0.1,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: screenWidth / 60),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical:
                                                                screenHeight /
                                                                    200),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  StoreDetailScreen(
                                                                    sellersId: topRatingStores[
                                                                            index]
                                                                        .sellerId
                                                                        .toString(),
                                                                    id: widget
                                                                        .id,
                                                                    longitude:
                                                                        widget
                                                                            .longitude,
                                                                    latitude: widget
                                                                        .lattude,
                                                                    lName: widget
                                                                        .lName,
                                                                  )),
                                                        );
                                                      },
                                                      child: CachedNetworkImage(
                                                        imageUrl: TopRatingStore.shopImage ?? "",
                                                        height:
                                                            screenHeight / 10,
                                                        width: screenWidth,
                                                        fit: BoxFit.fill,
                                                        imageBuilder: (context,
                                                                imageProvider) =>
                                                            Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: ConstantColor
                                                                    .primaryGreyColor),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  imageProvider,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Image.asset(
                                                          ConstantImage
                                                              .imageIsNotAvailable,
                                                          height:
                                                              screenHeight / 8,
                                                          width:
                                                              screenWidth / 3,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                      // Container(
                                                      //   width: screenWidth,
                                                      //   height:
                                                      //       screenHeight / 10,
                                                      //   decoration:
                                                      //       BoxDecoration(
                                                      //     border: Border.all(
                                                      //       color: ConstantColor
                                                      //          .primaryGreyColor,
                                                      //     ),
                                                      //     borderRadius:
                                                      //         BorderRadius
                                                      //             .circular(
                                                      //                 5.0),
                                                      //     image: DecorationImage(
                                                      //       image: NetworkImage(
                                                      //         TopRatingStore
                                                      //             .shopImage ??
                                                      //             "",
                                                      //       ),
                                                      //       fit: BoxFit.fill,
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: customeText(
                                                      text:
                                                          TopRatingStore.name ??
                                                              '',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: ConstantTextStyle
                                                          .allHomeScreenAvatarText,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: screenHeight / 150,
                                                  ),
                                                  Flexible(
                                                    child: startRating(
                                                      width: screenWidth / 5,
                                                      height: screenHeight / 60,
                                                      color: ConstantColor
                                                          .secondoryBlackColors,
                                                      context: context,
                                                      initialRating: double
                                                          .parse(TopRatingStore
                                                                  .ratingNumber ??
                                                              "0"),
                                                      itemSize: 8.0,
                                                      minRating: 1.0,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      onRatingUpdate:
                                                          (rating) {},
                                                      itemBuilder:
                                                          (context, _) =>
                                                              const Icon(
                                                        Icons.star,
                                                        color: ConstantColor
                                                            .starRatingColor,
                                                      ),
                                                      text2:
                                                          "${double.parse(TopRatingStore.ratingNumber ?? "0").toStringAsFixed(1)}/5.0",
                                                      style2: ConstantTextStyle
                                                          .homePageRatingText,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      left: screenWidth / 40,
                                      top: 0,
                                      bottom: 0,
                                      child: arrowButons(
                                        onTap: () {
                                          setState(() {
                                            topRatingStoresLeftIconBGColor =
                                                !topRatingStoresLeftIconBGColor;
                                          });
                                          Future.delayed(
                                              const Duration(milliseconds: 500),
                                              () {
                                            setState(() {
                                              topRatingStoresLeftIconBGColor =
                                                  !topRatingStoresLeftIconBGColor;
                                            });
                                          });
                                          scrollListLeftSide5();
                                        },
                                        radius: 15.0,
                                        backgroundColor:
                                            topRatingStoresLeftIconBGColor
                                                ? ConstantColor.primaryMainColor
                                                : ConstantColor.iconBackTPColor,
                                        icon: Icons.arrow_back_ios_rounded,
                                        iconSize: 20.0,
                                        color: topRatingStoresLeftIconBGColor
                                            ? ConstantColor.searchBoxColor
                                            : ConstantColor.primaryMainColor,
                                      ),
                                    ),
                                    Positioned(
                                      right: screenWidth / 40,
                                      top: 0,
                                      bottom: 0,
                                      child: arrowButons(
                                        onTap: () {
                                          setState(() {
                                            topRatingStoresRightIconBGColor =
                                                !topRatingStoresRightIconBGColor;
                                          });
                                          Future.delayed(
                                              const Duration(milliseconds: 500),
                                              () {
                                            setState(() {
                                              topRatingStoresRightIconBGColor =
                                                  !topRatingStoresRightIconBGColor;
                                            });
                                          });
                                          scrollListRightSide5();
                                        },
                                        radius: 15.0,
                                        backgroundColor:
                                            topRatingStoresRightIconBGColor
                                                ? ConstantColor.primaryMainColor
                                                : ConstantColor.iconBackTPColor,
                                        icon: Icons.arrow_forward_ios_rounded,
                                        iconSize: 20.0,
                                        color: topRatingStoresRightIconBGColor
                                            ? ConstantColor.searchBoxColor
                                            : ConstantColor.primaryMainColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        /*---------------------------------Top Rating Store end --------------------------------------------*/
                          mySizedBox(),
                        /*----------------------Promotion Stores index[2] Grid view start --------------------*/
                          Flexible(
                            child: Container(
                              padding: widget.lName != "Indore" ? null: EdgeInsets.symmetric(
                                  vertical: screenHeight / 80,
                                  horizontal: screenWidth / 40),
                              color: ConstantColor.primaryBackgroundMainColor,
                              child: widget.lName != "Indore" ? null: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                    visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                                    title: customeText(
                                      text: promotionStores.isNotEmpty
                                          ? promotionStores[2].shop?.name
                                          : "".toUpperCase(),
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style:  ConstantTextStyle.topCategoryText, ),
                                    trailing:   GestureDetector(
                                      onTap: () {
                                        Navigator.push( context,
                                          MaterialPageRoute( builder: (context) =>
                                              StoreDetailScreen(
                                                sellersId:   promotionStores[2].shop?.sellerId,
                                                id: widget.id,
                                                longitude: widget.longitude,
                                                latitude: widget.lattude,
                                                lName: widget.lName, )),  );  },
                                      child: customeText(
                                        text: "See More".toUpperCase(),
                                        textAlign: TextAlign.start,
                                        style: ConstantTextStyle
                                            .seeMoreButtonStyle,
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: screenHeight / 2.8,
                                    child: GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1 / 1.2,
                                        crossAxisSpacing: screenWidth / 80,
                                        mainAxisSpacing: screenHeight / 80,
                                      ),
                                      itemCount: promotionStores.length > 4 ? 4 : promotionStores.length,
                                      // itemCount: promotionStores.length > 4 ? 4 : promotionStores.length < 4 ? promotionStores.length : 0,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final topPromotionsStore = promotionStores[2];
                                        return promotionStore(
                                          onTapped: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductDetailScreen(
                                                        proId: promotionStores[2]
                                                            .products?[index]
                                                            .productId
                                                            .toString(),
                                                        id: widget.id,
                                                        longitude:
                                                            widget.longitude,
                                                        latitude:
                                                            widget.lattude,
                                                        lName: widget.lName,
                                                      )),
                                            );
                                          },
                                          context: context,
                                          cardBorderRadius:
                                              BorderRadius.circular(10.0),
                                          cardPadding: EdgeInsets.symmetric(
                                              horizontal: screenWidth / 80),
                                          image: topPromotionsStore
                                                  .products?[index]
                                                  .productImage ??
                                              "",
                                          imageRadius:
                                              BorderRadius.circular(8.0),
                                          fit: BoxFit.contain,
                                          imgHeight: screenHeight / 7.0,
                                          imgWidth: screenWidth / 2.0,
                                          titleText: topPromotionsStore
                                                  .products?[index]
                                                  .productTitle ??
                                              "",
                                          overflow: TextOverflow.ellipsis,
                                          titleTextAlign: TextAlign.start,
                                          titleTextStyle: ConstantTextStyle
                                              .allHomeScreenAvatarText,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        /*-----------------------Promotion Stores index[2] Grid view end ---------------------*/
                          mySizedBox(),
                        /*---------------------------------Top Kitchen Listview start --------------------------------------------*/
                          Container(
                            padding: widget.lName != "Indore" ? null: EdgeInsets.symmetric(
                                vertical: screenHeight / 50,
                                horizontal: screenWidth / 40),
                            color: ConstantColor.primaryBackgroundMainColor,
                            child: widget.lName != "Indore" ? null: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    customeText(
                                      text: "top Home Kitchen Products"
                                          .toUpperCase(),
                                      textAlign: TextAlign.start,
                                      style: ConstantTextStyle.topCategoryText,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SeeMoreProductsScreen(
                                                    // keyword:"top-home-kitchen-products",
                                                    keyword:"tophomekitchenproducts",
                                                    id: widget.id,
                                                    longitude: widget.longitude,
                                                    latitude: widget.lattude,
                                                    lName: widget.lName,
                                                  )),
                                        );
                                      },
                                      child: customeText(
                                        text: "See More".toUpperCase(),
                                        textAlign: TextAlign.start,
                                        style: ConstantTextStyle
                                            .seeMoreButtonStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: screenHeight / 80,
                                ),
                                Stack(
                                  children: [
                                    SizedBox(
                                      height: screenHeight /4.5,
                                      // height: screenHeight / 3.8,
                                      child: ListView.builder(
                                        controller: _scrollController6,
                                        itemExtent: screenWidth / 2.1,
                                        itemCount:
                                            topHomeKitchenProducts.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                        //*****************************************************************************
                                          // discount Logic is here
                                          double getPercantageOff(
                                              double price, double offerPrice) {
                                            double result =
                                                ((price - offerPrice) / price) *
                                                    100;
                                            return result.floor().toDouble();
                                          }
                                          final TopKitchenProduct =
                                              topHomeKitchenProducts[index];
                                          final offerPrice = double.tryParse(
                                                  TopKitchenProduct
                                                          .offerPrice ??
                                                      '0') ??
                                              0.0;
                                          final price = double.tryParse(
                                                  TopKitchenProduct.price ??
                                                      '0') ??
                                              0.0;
                                          final percentageOff =
                                              offerPrice != 0.0
                                                  ? getPercantageOff(
                                                      price, offerPrice)
                                                  : 0.0;
                                          final roundedPercentageOff =
                                              percentageOff.toStringAsFixed(0);
                        //*****************************************************************************
                                          return Card(
                                            elevation: 4,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: screenWidth / 30),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  cashBackChip(
                                                    context: context,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    text: percentageOff > 0
                                                        ? '$roundedPercentageOff% off'
                                                        : "",
                                                    style: ConstantTextStyle
                                                        .newiconButtonText,
                                                    textAlign: TextAlign.start,
                                                    color: percentageOff > 0
                                                        ? ConstantColor
                                                            .chipColor
                                                        : null,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ProductDetailScreen(
                                                                  proId: TopKitchenProduct
                                                                      .productId
                                                                      .toString(),
                                                                  id: widget.id,
                                                                  longitude: widget
                                                                      .longitude,
                                                                  latitude: widget
                                                                      .lattude,
                                                                  lName: widget
                                                                      .lName,
                                                                )),
                                                      );
                                                    },
                                                    child: Center(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              TopKitchenProduct
                                                                      .productImage ??
                                                                  "",
                                                          height: screenHeight / 8.5,
                                                          width: screenWidth / 3.5,
                                                          fit: BoxFit.fill,
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Image.asset(
                                                            ConstantImage
                                                                .imageIsNotAvailable,
                                                            height:
                                                                screenHeight /
                                                                    8,
                                                            width:
                                                                screenWidth / 3,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: screenHeight / 200,
                                                  ),
                                                  customeText(
                                                    text: TopKitchenProduct
                                                            .productTitle ??
                                                        '',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: ConstantTextStyle
                                                        .allHomeScreenAvatarText,
                                                  ),
                                                  Flexible(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical:
                                                                  screenHeight /
                                                                      200),
                                                      child: customRichText(
                                                        text1: NumberFormat
                                                                .simpleCurrency(
                                                                    locale:
                                                                        "hi-NI",
                                                                    decimalDigits:
                                                                        2)
                                                            .format(
                                                                double.parse(
                                                          TopKitchenProduct
                                                                  .offerPrice ??
                                                              TopKitchenProduct
                                                                  .price ??
                                                              "N/A",
                                                        )),
                                                        style1:
                                                            ConstantTextStyle
                                                                .richtext1,
                                                        TextAlign:
                                                            TextAlign.start,
                                                        text2: percentageOff > 0
                                                            ? NumberFormat.simpleCurrency(
                                                                    locale:
                                                                        "hi-NI",
                                                                    decimalDigits:
                                                                        2)
                                                                .format(double.parse(
                                                                    TopKitchenProduct
                                                                            .price ??
                                                                        ''))
                                                            : " ",
                                                        style2:
                                                            ConstantTextStyle
                                                                .richtext2,
                                                      ),
                                                    ),
                                                  ),
                                                  // Flexible(
                                                  //   child: ElevatedButton.icon(
                                                  //     onPressed: topHomeKitchenProducts[index].wantToBuy == "1" ? null : () async {
                                                  //       SharedPreferences preferences = await SharedPreferences.getInstance();
                                                  //       setState(() {
                                                  //         isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                                                  //         tokenAccess = preferences.getString("access-token");
                                                  //       });
                                                  //       if (isUserLoggedIn) {
                                                  //         await fetchSendEnquiryAPi(
                                                  //           prodId: topHomeKitchenProducts[index].productId ?? '',
                                                  //           wantBuy: "1",
                                                  //           tokenAccess:tokenAccess,
                                                  //           index: index,
                                                  //         );
                                                  //       } else {
                                                  //         showDialog(
                                                  //           barrierDismissible: false,
                                                  //           context: context,
                                                  //           builder: (BuildContext context) {
                                                  //             return const CheckIsLogin();
                                                  //           },
                                                  //         );
                                                  //       }
                                                  //     },
                                                  //     icon: const Icon(
                                                  //       Icons.content_paste_search,
                                                  //       color: ConstantColor.primaryBackgroundMainColor,
                                                  //       size: 18.0,
                                                  //     ),
                                                  //     label: Text(
                                                  //       'Send Enquiry',
                                                  //       style: ConstantTextStyle.newiconButtonText,
                                                  //     ),
                                                  //     style: ElevatedButton.styleFrom(
                                                  //       minimumSize: Size.fromHeight(screenHeight / 25),
                                                  //       backgroundColor: topHomeKitchenProducts[index].wantToBuy == "1"
                                                  //           ? ConstantColor.primaryGreyColor
                                                  //           : ConstantColor.primaryMainColor,
                                                  //       shape: RoundedRectangleBorder(
                                                  //         borderRadius: BorderRadius.circular(10.0),
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      left: screenWidth / 40,
                                      top: 0,
                                      bottom: 0,
                                      child: arrowButons(
                                        onTap: () {
                                          setState(() {
                                            topKitchenLeftIconBGColor =
                                                !topKitchenLeftIconBGColor;
                                          });
                                          Future.delayed(
                                              const Duration(milliseconds: 500),
                                              () {
                                            setState(() {
                                              topKitchenLeftIconBGColor =
                                                  !topKitchenLeftIconBGColor;
                                            });
                                          });
                                          scrollListLeftSide6();
                                        },
                                        radius: 15.0,
                                        iconSize: 20.0,
                                        backgroundColor:
                                            topKitchenLeftIconBGColor
                                                ? ConstantColor.primaryMainColor
                                                : ConstantColor.iconBackTPColor,
                                        icon: Icons.arrow_back_ios_new_rounded,
                                        color: topKitchenLeftIconBGColor
                                            ? ConstantColor.searchBoxColor
                                            : ConstantColor.primaryMainColor,
                                      ),
                                    ),
                                    Positioned(
                                      right: screenWidth / 40,
                                      top: 0,
                                      bottom: 0,
                                      child: arrowButons(
                                        onTap: () {
                                          setState(() {
                                            topKitchenRightIconBGColor =
                                                !topKitchenRightIconBGColor;
                                          });
                                          Future.delayed(
                                              const Duration(milliseconds: 500),
                                              () {
                                            setState(() {
                                              topKitchenRightIconBGColor =
                                                  !topKitchenRightIconBGColor;
                                            });
                                          });
                                          scrollListRightSide6();
                                        },
                                        radius: 15.0,
                                        iconSize: 20.0,
                                        backgroundColor:
                                            topKitchenRightIconBGColor
                                                ? ConstantColor.primaryMainColor
                                                : ConstantColor.iconBackTPColor,
                                        icon: Icons.arrow_forward_ios_rounded,
                                        color: topKitchenRightIconBGColor
                                            ? ConstantColor.searchBoxColor
                                            : ConstantColor.primaryMainColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        /*---------------------------------Top Kitchen List view end --------------------------------------------*/
                          mySizedBox(),
                        /*---------------------------------carouselSlider start --------------------------------------------*/
                          Stack(
                            children: [
                              carouselSlider(
                                bannerHeight: screenHeight / 7,
                                autoPlay: true,
                                viewportFraction: 1.0,
                                enlargeCenterPage: true,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _currentCarouselPage4 = index;
                                  });
                                },
                                controller: _pageController4,
                                data: List.generate(adsBannerBottom.length,
                                    (index) {
                                  final bannerBottom = adsBannerBottom[index];
                                  return GestureDetector(
                                    onTap: () {
                                      switch (bannerBottom.type) {
                                        case "shop_detail":
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => StoreDetailScreen(
                                                sellersId: bannerBottom.keyword,
                                                id: widget.id,
                                                longitude: widget.longitude,
                                                latitude: widget.lattude,
                                                lName: widget.lName,
                                              ),
                                            ),
                                          );
                                          break;
                                        case "product_details":
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ProductDetailScreen(proId:bannerBottom.keyword,
                                                  id: widget.id,
                                                  longitude: widget.longitude,
                                                  latitude: widget.lattude,
                                                  lName: widget.lName,)),
                                          );
                                          break;
                                        case "reel":
                                          Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => HomePageNavReelScreen(
                                                id:  widget.id,
                                                longitude: widget.longitude,
                                                latitude: widget.lattude,
                                                lName: widget.lName,
                                                myBannerReelId: bannerBottom.keyword.toString()??""
                                              // '16'
                                            ),
                                            ),
                                          );
                                          break;
                                        case "product_List":
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => SeeMoreProductsScreen(
                                                keyword: bannerBottom.bannerTitle,
                                                id: widget.id,
                                                longitude: widget.longitude,
                                                latitude: widget.lattude,
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
                                                latitude: widget.lattude,
                                                longitude: widget.longitude,
                                                lName: widget.lName,
                                                fmId: bannerBottom.bannerTitle,
                                              ),
                                            ),
                                          );
                                          break;
                                        case "contest_details":
                                          launchWhatsApp(bannerBottom.keyword.toString(), bannerBottom.whatsapptext.toString());
                                          break;
                                        default:
                                          launchWhatsApp(bannerBottom.keyword.toString(), bannerBottom.whatsapptext.toString());
                                      }
                                    },
                                    child: CachedNetworkImage(
                                      imageUrl: bannerBottom.bannerImage ?? "",
                                      width: screenWidth,
                                      fit: BoxFit.fill,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                            margin: EdgeInsets.symmetric(horizontal: screenWidth/40),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5.0),
                                              border: Border.all(color: ConstantColor.primaryMainColor,
                                                  width: 0.5),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        ConstantImage.imageIsNotAvailable,
                                        height: screenHeight,
                                        width: screenWidth,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: adsBannerBottom.map((banner) {
                                  int index = adsBannerBottom.indexOf(banner);
                                  return dotS(
                                    width: screenWidth /25.0,
                                    height:  screenHeight/160,
                                    // width: _currentCarouselPage4 == index ? screenWidth / 50.0:screenWidth / 20.0,
                                    // height:  _currentCarouselPage4 == index ? screenHeight / 100.0 : screenHeight/200,
                                    margin: EdgeInsets.only(
                                      top: screenHeight / 8.0,
                                    ),
                                    shape: BoxShape.circle,
                                    color: _currentCarouselPage4 == index
                                        ? ConstantColor.primaryMainColor
                                        : ConstantColor.primaryGreyColor,
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        /*---------------------------------carouselSlider end --------------------------------------------*/
                          SizedBox(
                            height: screenHeight / 80,
                          ),
                        /*---------------------------------Shop in focus Grid view start --------------------------------------------*/
                          Container(
                            padding:widget.lName != "Indore" ? null: EdgeInsets.symmetric(
                                vertical: screenHeight / 100,
                                horizontal: screenWidth / 40),
                            color: ConstantColor.primaryBackgroundMainColor,
                            child: widget.lName != "Indore" ? null: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                  visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                                  title: customeText(
                                    text:"Shop in focus".toUpperCase(),
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    style:  ConstantTextStyle.topCategoryText, ),
                                  trailing:   GestureDetector(
                                    onTap: () {
                                      Navigator.push( context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              GetSellerScreen(
                                                keyword: "focused_shop",
                                                id: widget.id,
                                                lattude: widget.lattude,
                                                longitude: widget.longitude,
                                                lName: widget.lName,
                                              ),
                                        ),
                                      );  },
                                    child: customeText(
                                      text: "See More".toUpperCase(),
                                      textAlign: TextAlign.start,
                                      style: ConstantTextStyle
                                          .seeMoreButtonStyle,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight / 7,
                                  child: ListView.builder(
                                    itemExtent: screenWidth / 2.5,
                                    scrollDirection: Axis.horizontal,
                                    controller: _scrollController4,
                                    itemCount: famousStore.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      final famousStores = famousStore[index];
                                      return Card(
                                        color:
                                            ConstantColor.secondoryCardeBoarder,
                                        elevation: 0.1,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: screenWidth / 80),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical:
                                                        screenHeight / 200),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            StoreDetailScreen(
                                                          sellersId:
                                                              famousStore[index]
                                                                  .sellerId
                                                                  .toString(),
                                                          id: widget.id,
                                                          longitude:
                                                              widget.longitude,
                                                          latitude:
                                                              widget.lattude,
                                                          lName: widget.lName,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: CachedNetworkImage(
                                                    imageUrl: famousStores
                                                            .shopImage ??
                                                        "",
                                                    height: screenHeight / 10,
                                                    width: screenWidth / 2,
                                                    fit: BoxFit.fill,
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: ConstantColor
                                                                .primaryGreyColor,
                                                            width: 0.5),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Image.asset(
                                                      ConstantImage
                                                          .imageIsNotAvailable,
                                                      height: screenHeight / 10,
                                                      width: screenWidth / 2,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              customeText(
                                                text: famousStores.name ?? '',
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                style: ConstantTextStyle
                                                    .allHomeScreenAvatarText,
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
                          ),
                        /*---------------------------------Shop in focus Grid view end -----------------------------------------*/
                          mySizedBox(),
                        /*----------------------Promotion Stores index[3] Grid view start --------------------*/
                          Container(
                            padding: widget.lName != "Indore" ? null: EdgeInsets.symmetric(
                                vertical: screenHeight / 80,
                                horizontal: screenWidth / 40),
                            color: ConstantColor.primaryBackgroundMainColor,
                            child: widget.lName != "Indore" ? null: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                           ListTile(
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                         title: customeText(
                                text: promotionStores.isNotEmpty
                                 ? promotionStores[3].shop?.name
                                 : "".toUpperCase(),
                                 textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                 style:  ConstantTextStyle.topCategoryText, ),
                          trailing:   GestureDetector(
                                   onTap: () {
                                Navigator.push( context,
                                 MaterialPageRoute( builder: (context) =>
                                    StoreDetailScreen(
                                sellersId:   promotionStores[3].shop?.sellerId,
                                 id: widget.id,
                                 longitude: widget.longitude,
                                  latitude: widget.lattude,
                                  lName: widget.lName, )),  );  },
                                   child: customeText(
                                    text: "See More".toUpperCase(),
                                  textAlign: TextAlign.start,
                                   style: ConstantTextStyle
                                  .seeMoreButtonStyle,
                                 ),
                                  ),
                            ),
                                SizedBox(
                                  height: screenHeight / 2.8,
                                  child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: (1 / 1.2),
                                      crossAxisSpacing: screenWidth / 80,
                                      mainAxisSpacing: screenHeight / 80,
                                    ),
                                    // itemCount: min(promotionStores.length, 4),
                                    itemCount: promotionStores.length > 4 ? 4 : promotionStores.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final topPromotionsStore = promotionStores[3];
                                      var imageFile = topPromotionsStore.products![index].productImage??"";
                                      return promotionStore(
                                        onTapped: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetailScreen(
                                                      proId: promotionStores[3].products?[index].productId.toString(),
                                                      id: widget.id,
                                                      longitude: widget.longitude,
                                                      latitude: widget.lattude,
                                                      lName: widget.lName,
                                                    )),
                                          );
                                        },
                                        context: context,
                                        cardBorderRadius:
                                            BorderRadius.circular(10.0),
                                        cardPadding: EdgeInsets.symmetric(
                                            horizontal: screenWidth / 80),
                                        image: imageFile,
                                        imageRadius: BorderRadius.circular(8.0),
                                        fit: BoxFit.fill,
                                        imgHeight: screenHeight / 7.0,
                                        imgWidth: screenWidth / 2.0,
                                        titleText: topPromotionsStore.products?[index].productTitle ?? "",
                                        overflow: TextOverflow.ellipsis,
                                        titleTextAlign: TextAlign.start,
                                        titleTextStyle: ConstantTextStyle
                                            .allHomeScreenAvatarText,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        /*-----------------------Promotion Stores index[3] Grid view end ---------------------*/
                          mySizedBox(),
                        /*--------------------------------------Rental Items start ----------------------*/
                          Container(
                           padding: EdgeInsets.symmetric(horizontal: screenWidth / 40),
                            color: ConstantColor.primaryBackgroundMainColor,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth / 50,
                                    vertical: screenHeight / 50,
                                  ),
                                  child: customRichText(
                                    text1: "RENTAL items".toUpperCase(),
                                    style1: ConstantTextStyle.topCategoryText,
                                    TextAlign: TextAlign.start,
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight/6.9,
                                  child:
                                  ListView.builder(
                                    itemExtent: screenWidth / 4,
                                    itemCount: rentalItems.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      final RentalItemss = rentalItems[index];
                                      return allHomeScreenAvatar(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>  AllProductListScreen(
                                                keyword:  RentalItemss.keyword ??'',
                                                filterKeyword: RentalItemss.keyword ??'',
                                                suitableFor :const [],
                                                id: widget.id,
                                                longitude: widget.longitude,
                                                latitude: widget.lattude,
                                                lName: widget.lName,

                                              ),
                                            ),
                                          );
                                        },
                                        image: CachedNetworkImage(
                                          imageUrl: RentalItemss.rentImage ?? "",
                                          fit: BoxFit.fill,
                                          errorWidget: (context, url, error) =>
                                              Image.asset(ConstantImage.imageIsNotAvailable, fit: BoxFit.fill),
                                        ),
                                        color: ConstantColor.homeScreenSlidingColor,
                                        text: RentalItemss.rentTitle ?? "",
                                        textAlign: TextAlign.center,
                                        width: screenWidth / 5,
                                        height: double.minPositive,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: ConstantColor.circleAvatar2,
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: Offset(-3, 0),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(100),
                                      );
                                    },
                                    scrollDirection: Axis.horizontal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        /*--------------------------------------Rental Items end----------------------*/
                          mySizedBox(),
                        /*----------------------------Recent search start --------------------------------------------*/
                          recentSearch.isNotEmpty
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: screenHeight / 50,
                                    horizontal: screenWidth / 40,
                                  ),
                                  color: ConstantColor.primaryBackgroundMainColor,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      customeText(
                                        text: "Recent Searches".toUpperCase(),
                                        textAlign: TextAlign.start,
                                        style: ConstantTextStyle.topCategoryText,
                                      ),
                                      SizedBox(height: screenHeight / 80),
                                      SizedBox(
                                        height: screenHeight / 8,
                                        child: ListView.builder(
                                          itemExtent: screenWidth / 3,
                                          itemCount: recentSearch.length,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            final RecentSearchItems = recentSearch[index];
                                            bool isLoading = RecentSearchItems.isLoading ?? false;
                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  recentSearch[index].isLoading = true; // Set loading to true for this item
                                                });
                                                fetchRecentNavigation(
                                                  slug: convertToSlug(recentSearch[index].rsTitle.toString() ?? ""),
                                                ).then((_) {
                                                  setState(() {
                                                    recentSearch[index].isLoading = false; });
                                                });
                                              },
                                              child: Card(
                                                color: ConstantColor.secondoryCardeColors,
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Flexible(
                                                      child: Stack(
                                                        alignment: Alignment.center,
                                                        children: [
                                                          boxImage(
                                                            image: RecentSearchItems.rcImage ?? "",
                                                            imageHeight: screenHeight / 11.0,
                                                            imageWidth: screenWidth / 4.5,
                                                            fit: BoxFit.fill,
                                                          ),
                                                          if (isLoading)
                                                            const SpinKitCircle(color: ConstantColor.primaryMainColor, size: 40.0)
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: screenWidth / 60),
                                                      child: customeText(
                                                        textAlign: TextAlign.start,
                                                        text: RecentSearchItems.rsTitle ?? '',
                                                        overflow: TextOverflow.ellipsis,
                                                        style: ConstantTextStyle.allHomeScreenAvatarText,
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
                                )
                              : const SizedBox.shrink(),
                    SizedBox(height: screenHeight/13),
                    /*----------------------Recent search end  --------------------*/
                        ])),
              ),
      ),
    );
  }
  Widget mySizedBox() {
    var screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: widget.lName != "Indore" ? null : screenHeight / 80,
    );
  }
  String convertToSlug(String input) {
    return input.replaceAll(RegExp(r'[^\w\s-]'),'')
        .replaceAll(RegExp(r'\s+'), '-')
        .toLowerCase();
  }
}



