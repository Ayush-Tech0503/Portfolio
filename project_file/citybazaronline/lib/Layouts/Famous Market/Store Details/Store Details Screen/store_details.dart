// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables, non_constant_identifier_names, empty_catches, use_build_context_synchronously, must_be_immutable

import 'dart:async';
import 'dart:convert';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:latlong2/latlong.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../Api Services/store_plan_validity_api_service.dart';
import '../../../../Models/Plan Validity Model/plan_validity_model.dart';
import '../../../../Models/Show Store Details Models/Seller Product Filter/seller_product_filter.dart';
import '../../../../Models/Show Store Details Models/get_seller_details_products.dart';
import '../../../../Models/Show Store Details Models/store_details.dart';
import '../../../../Util/Constant APi Url/api_urls.dart';
import '../../../../Util/constaint_textstyle.dart';
import '../../../../Util/constant_color.dart';
import '../../../../Util/constant_image.dart';
import '../../../../Util/map_utils.dart';
import '../../../../Widgets/Famous Market Widget/store_details_widget.dart';
import '../../../../Widgets/Login Check Widget/login_check_widget.dart';
import '../../../../Widgets/Seller Store Review And Rating/seller_review_rating.dart';
import '../../../../Widgets/Send Enquiry dialogBox/alert_dialog_box.dart';
import '../../../../Widgets/collection_card.dart';
import '../../../../Widgets/custome_button_.dart';
import '../../../../Widgets/custome_icon_button.dart';
import '../../../../Widgets/custome_imagies.dart';
import '../../../../Widgets/custome_richtext.dart';
import '../../../../Widgets/custome_text.dart';
import '../../../../Widgets/famous_market_card_widget.dart';
import '../../../../Widgets/store_details_widget.dart';
import '../../../../services/KPI Api Service /shop_addmin_permition_kpi_api.dart';
import '../../../Product View Screens/Product Price Filter/product_price_range_filter.dart';
import '../../../Product View Screens/product_Item_Details.dart';
import '../../../User Profile My Account/Dashboard/Liked Products/Liked Product TableData/liked_products_datatable.dart';
import '../../../plan_validity_screen.dart';
import '../Store Reels Screen/store_reels_screen.dart';
import '../User Store BottomNav Bar/user_bottom_navigation_bar.dart';
import '../share_app.dart';

class StoreDetailScreen extends StatefulWidget {
  final storeDetails;
  final String? sellersId;
  String? filterKeyword;
  String id;
  String latitude;
  String longitude;
  String lName;

   StoreDetailScreen({super.key,this.filterKeyword, this.storeDetails, this.sellersId, required this.id,required this.longitude,required this.latitude,required this.lName});
  @override
  State<StoreDetailScreen> createState() => _StoreDetailScreenState();

}

class _StoreDetailScreenState extends State<StoreDetailScreen>
    with TickerProviderStateMixin {
/*--------------------------------*/
  bool isListIcon = false;
  bool isUserLoggedIn = false;
  String buttonText = 'View Contact Details';
  // bool isSelectedValue = false;
  int _selectedIndex = 0;
/*--------------------------------*/
  late TabController _tabController;
  int defaultTabIndex = 1;
  final GlobalKey<ScaffoldState> scaffoldKey2 = GlobalKey<ScaffoldState>();
  ScrollController filterScrollController = ScrollController();


  String transformValue(String value) {
    switch (value) {
      case "Price High to Low":
        return "price_high_to_low";
      case "Price Low to High":
        return "price_low_to_high";
      case "What's New":
        return "date";
      default:
        return value.toLowerCase().replaceAll(RegExp(r'[-&]|(\s+)'), "_");
    }
  }

  final List<String> itemsData = [
    'Price High to Low',
    'Price Low to High',
    'What\'s New',
  ];
  String selectedValue = "";
  String hintText = "Sort By";

  void _handleTabSelection() {
    setState(() {
      _selectedIndex = _tabController.index;
    });
  }

  /*----------------------------- Calling button redirect class code start--------------------------*/
  void _launchPhoneCall(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  /*-------------------- Calling button redirect class code end--------------------------*/
  var userId;
  String rating = "";
  // var rating;
  var review;
/*--------------------api data start-------------------------*/
//******************************************************
  //Seller Store Details Api data start
//*****************************************************
  dynamic? userUniSellerId = '';
  ShowStoreDetails? sellerStoreDetails;
  List<SellerDetails> sellerAllDetailsList = [];
  List<SellerCategories> sellerDealsInList = [];
  List<PhotoGallery> sellerPhotoList = [];
  List<SellerOpenHrs> sellerStoreTimeList = [];
  List<Reveiws> allReviewList = [];
  bool isLoading = false;
  bool isLoading2 = false;
  var tokenAccess;
  fetchSellerDataList({sIds, lat, long}) async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      tokenAccess = preference.getString("access-token");
      setState(() {
        isLoading = true;
        isLoading2 = true;
      });
      final body = {
        "sid": sIds,
        "lat":lat,
        "long": long,
        "user_id": userId
      };
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.getSellerDetails}",
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
        sellerStoreDetails = ShowStoreDetails.fromJson(responseData);
        setState(() {
          sellerAllDetailsList.add(sellerStoreDetails!.data!.sellerDetails!);
          sellerDealsInList.addAll(sellerStoreDetails!.data!.sellerCategories ?? []);
           userUniSellerId = sellerAllDetailsList.first.userId??"";
          sellerPhotoList.addAll(sellerStoreDetails!.data?.photoGallery ?? []);
          sellerStoreTimeList.addAll(sellerStoreDetails!.data?.sellerOpenHrs ?? []);
          allReviewList.addAll(sellerStoreDetails!.data?.reveiws ?? []);
          //  }
          isLoading = false;
        });
      } else {
        // Handle the error case
      }
      setState(() {
        isLoading = false;
        isLoading2 = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
        isLoading2 = false;
      });
    }
  }

  fetchFollowUnFollow({sIds, follow_val}) async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      final body = {"seller_id":sIds,"follow_val":follow_val};
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.sellerFollowUnFollow}",
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
          // if (sellerStoreDetails?.data?.sellerDetails != null ) {
          //  }
        });
      } else {
        // Handle the error case
      }
      setState(() {});
    } catch (error) {
      setState(() {
      });
    }
  }


  bool isLoadingWish = false;
  fetchSendEnquiryAPi({prodId,wantBuy,index,mobileNo,tokenAccess}) async {
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
        setState(() {
          var  sellerNumber = mobileNo??"";
          productList[index].wantToBuy = '1';
          isLoadingWish = false;
          var  sellerWhatsapp = productList[index].shareLink??"";
          String phoneWhatsappText1 = sellerWhatsapp!.replaceAll("api.", "");
          String phoneWhatsappText2 = phoneWhatsappText1.replaceAll(".lab101.cloud", ".com");
          // var  sellerWhatsapp =  productList[index].shareLink?? 'I found you on CItyBazaarOnline';
          showDialog(
            context: context,
            builder: (ctx) {
              return alertDialogBox(
                context: context,
                titleText: "Enquiry Send Successfully",
                titleTextAlign: TextAlign.center,
                titleStyle: ConstantTextStyle.topCategoryText,
                descriptionText: "+91 ${sellerNumber??''}.\n",
                phoneNumber: sellerNumber??"",
                icon: Icons.message_sharp,
                buttonText: "Chat with seller",
                buttonStyle: ConstantTextStyle.newiconButtonText,
                iconbuttononPress: () {
                  if (sellerNumber!.isNotEmpty && sellerNumber!= ""
                      && sellerNumber!= null ) {
                    _launchWhatsApp(sellerNumber??'', "I found you on CItyBazaarOnline : $phoneWhatsappText2");
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
    }
  }

//---------------review and rating api start -----------------------
//   bool reviewLoader = false;
//   TextEditingController sellerRatingController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//
//   fetchReviewRating({tokenAccess}) async {
//     try {
//       SharedPreferences preference = await SharedPreferences.getInstance();
//       userId = preference.getString("userId");
//       tokenAccess = preference.getString("access-token");
//       setState(() {
//         reviewLoader = true;
//       });
//       final body = {
//         "user_id": userId,
//         "seller_id": widget.sellersId,
//         "rate_val": rating,
//         "review": sellerRatingController.text.toString(),
//       };
//       final response = await Dio().post(
//         "${ConstantUrls.baseUriApi}${ConstantUrls.getSellerReviewsRating}",
//         options: Options(
//           headers: {
//             "Authorization": tokenAccess,
//             'Content-Type': 'application/json',
//           },
//         ),
//         data: json.encode(body),
//       );
//       if (response.statusCode == 200) {
//         final responseData = json.decode(response.data);
//         if (responseData["status"] == "success") {
//           LoadingScaffoldMessage.showSnackbar(
//             context,
//             responseData['msg'],
//             ConstantColor.primaryMainColor,
//             const Duration(seconds: 2),
//           );
//         }
//         else{
//           LoadingScaffoldMessage.showSnackbar(
//             context,
//             responseData['msg'],
//             ConstantColor.primaryMainColor,
//             const Duration(seconds: 2),
//           );
//         }
//         Navigator.pop(context);
//       }
//       setState(() {
//         reviewLoader = false;
//       });
//     } catch (error) {
//       setState(() {
//         reviewLoader = false;
//       });
//     }
//   }

//---------------review and rating api end -----------------------
  /*--------------------api data start-------------------------*/
  // "filter_item": {
  //   "Color": filterItem["Color"],
  //   "colour": filterItem["colour"],
  //   "URL of Product detail": filterItem["URL of Product detail"],
  //   "RAM": filterItem["RAM"],
  //   "Screen Size": filterItem["Screen Size"],
  //   "Processor": filterItem["Processor"],
  //   "Battery Capacity": filterItem["Battery Capacity"],
  //   "Memory": filterItem["Memory"],
  //   "Camera Resolution": filterItem["Camera Resolution"],
  //   "Selfie Camera": filterItem["Selfie Camera"],
  //   "Operating System": filterItem["Operating System"],
  //   "Smart TV": filterItem["Smart TV"],
  //   "Resolution": filterItem["Resolution"],
  //   "Screen Type": filterItem["Screen Type"],
  //   "Curve Screen": filterItem["Curve Screen"],
  //   "Connectivity": filterItem["Connectivity"],
  //   "Type of Speakers": filterItem["Type of Speakers"],
  //   "Speaker Configuration": filterItem["Speaker Configuration"],
  //   "Form Factor":filterItem["Form Factor"],
  //   "Type of HDD": filterItem["Type of HDD"],
  //   "Suitable for": filterItem["Suitable for"],
  //   "Battery Backup": filterItem["Battery Backup"],
  //   "Power Source": filterItem["Power Source"],
  //   "Body Material": filterItem["Body Material"],
  //   "Trimmer Purpose": filterItem["Trimmer Purpose"],
  //   "Type Of Headphones or Earphones": filterItem["Type Of Headphones or Earphones"],
  //   "Waterproof": filterItem["Waterproof"],
  //   "Capacity of washing machine": filterItem["Capacity of washing machine"],
  //   "Type of Washing machine": filterItem["Type of Washing machine"],
  //   "Type Of Keyboard": filterItem["Type Of Keyboard"],
  //   "capacity of Refrigerator": filterItem["capacity of Refrigerator"],
  //   "Type of Refrigerator": filterItem["Type of Refrigerator"],
  //   "Star Rating": filterItem["Star Rating"],
  //   "Type of Watches or Clock": filterItem["Type of Watches or Clock"],
  //   "Dial Shape": filterItem["Dial Shape"],
  //   "Strap Material": filterItem["Strap Material"],
  //   "brands": filterItem["brands"],
  //   "Fabric": filterItem["Fabric"],
  //   "Sleeve Type": filterItem["Sleeve_Type"],
  //   "Neck Type": filterItem["Neck_Type"],
  //   "Size":  filterItem["Size"],
  //   "Brands": filterItem["Brands"]
  // },
/*---------------------------ALl Product List start----------------*/
  SellerProductsDetails? sellerProducts;
  List<Product> productList = [];
  bool isLoading3 = false;
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final RefreshController _refreshControllerListView = RefreshController(initialRefresh: false);
  int page = 1;
  fetchAllProductList({sellerId,lat,long}) async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      if (page == 1) {
        setState(() {
          isLoading3 = true;
          productList.clear();
        });
      }
      final body = {
        "searchKeyword": "",
        "seller_id": sellerId,
        "user_id": userId,
        "order_by" : selectedValue,
        "category": selectedCategoryString,
        "distance": 10,
        "min_price": minPriceValue,
        "max_price": maxnPriceValue,
        "lat":lat,
        "long": long,
        'filter_item':filterItem,
        "page_no": page
      };
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.getSellerProducts}",
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
        sellerProducts = SellerProductsDetails.fromJson(responseData);
        var allDataList=sellerProducts!.products?? [];
        if (allDataList.isNotEmpty) {
          productList.addAll(allDataList);
          if (page == 1) {
            setState(() {
              isLoading3 = false;
            });
          } else {
            setState(() {});
            _refreshController.loadComplete();
            _refreshControllerListView.loadComplete();
          }
          page += 1;
        } else {
          if (page == 1) {
            setState(() {
              isLoading3 = false;
            });
          } else {
            setState(() {});
            _refreshController.loadNoData();
            _refreshControllerListView.loadNoData();
            isLoading3 = false;
          }
        }
      } else {
        _refreshController.loadNoData();
        _refreshControllerListView.loadNoData();
      }
      setState(() {
        isLoading3 = false;
      });
    } catch (error) {
      setState(() {
        isLoading3 = false;
        _refreshController.loadNoData();
        _refreshControllerListView.loadNoData();

      });
    }
  }
/*----------------------------All Product List End-------------------*/
/*------------------seller product Filter start-------------------*/
  var minPriceValue;
  var maxnPriceValue;
  SellerProductFilter? allProductListFilter;
  List<Attribute>? filterAttributes = [];
  List<Category>? filterCategories = [];
  bool isLoading4 = false;
  fetchSellerProductListFilter({sellerId}) async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      setState(() {
        isLoading4 = true;
      });
      final body = {"seller_id":sellerId};
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.getSellerProductFilter}",
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
        allProductListFilter = SellerProductFilter.fromJson(responseData);
        setState(() {
          filterAttributes!.addAll(allProductListFilter!.attributes ?? []);
          filterCategories!.addAll(allProductListFilter!.categories ?? []);
        });
      } else {
        // Print the DataList after parsing
      }
      setState(() {
        isLoading4 = false;
      });
    } catch (error) {
      setState(() {
        isLoading4 = false;
      });
      throw Exception('Failed to fetch data $error');
    }
  }

  bool isFollowing = false;
/*----------------------------product Filter End-------------------*/
  Timer? _debounceTimer;
  onDataFromChild(min,max){
    setState(() {
      minPriceValue = min??'';
      maxnPriceValue = max??'';
      _debounceTimer?.cancel();
      _debounceTimer = Timer(const Duration(seconds: 1), () {
        page = 1;
        if(widget.id!=""){
          fetchAllProductList(sellerId: widget.sellersId,lat:widget.latitude, long: widget.longitude);
          productList.clear();
        }
        else{
          fetchAllProductList(sellerId: widget.sellersId,lat:"22.7177", long: " 75.8545",);
          productList.clear();
        }
      });
    });
  }
//--------------------------
  String selectedCategoryString ="";
  /*--------------------------------------------*/
  void clearAllCheckboxes() {
    setState(() {
      for (var filterCat in filterCategories!) {
        filterCat.isSelected = false;
      }
      for (var filterAttribute in filterAttributes!) {
        for (var attrValue in filterAttribute.attrValues ?? []) {
          filterItem![filterAttribute.attrName ?? '']?.remove(attrValue);
          filterAttribute.isSelectedValues = List<bool?>.generate(filterAttribute.attrValues?.length ?? 0, (_) => false);
        }
      }
      // for (var filterAttribute in filterAttributes!) {
      //   for (var attrValue in filterAttribute.attrValues ?? []) {
      //     filterItem[filterAttribute.attrName ?? '']?.remove(attrValue);
      //     filterAttribute.isSelectedValues = List<bool?>.generate(filterAttribute.attrValues?.length ?? 0, (_) => false);
      //   }
      // }
      page = 1;
      selectedCategoryString = '';
      if (widget.id != "") {
        fetchAllProductList(sellerId: widget.sellersId, lat: widget.latitude, long: widget.longitude);
      } else {
        fetchAllProductList(sellerId: widget.sellersId, lat: "22.7177", long: " 75.8545",);
      }
      productList.clear();
    });
  }
  //-----------------------
  Map<String, List<String>>? filterItem = {};
  // Map<String, dynamic> filterItem = {
  //   "Fabric": [],
  //   "Sleeve Type": [],
  //   "Neck Type": [],
  //   "Size":  [],
  //   "Brands": [],
  //   "Color": [],
  //   "colour": [],
  //   "URL of Product detail": [],
  //   "RAM": [],
  //   "Screen Size": [],
  //   "Processor": [],
  //   "Battery Capacity": [],
  //   "Memory": [],
  //   "Camera Resolution": [],
  //   "Selfie Camera": [],
  //   "Operating System": [],
  //   "Smart TV": [],
  //   "Resolution": [],
  //   "Screen Type": [],
  //   "Curve Screen": [],
  //   "Connectivity": [],
  //   "Type of Speakers": [],
  //   "Speaker Configuration": [],
  //   "Form Factor": [],
  //   "Type of HDD": [],
  //   "Suitable for": [],
  //   "Battery Backup": [],
  //   "Power Source": [],
  //   "Body Material": [],
  //   "Trimmer Purpose": [],
  //   "Type Of Headphones or Earphones": [],
  //   "Waterproof": [],
  //   "Capacity of washing machine": [],
  //   "Type of Washing machine": [],
  //   "Type Of Keyboard": [],
  //   "capacity of Refrigerator": [],
  //   "Type of Refrigerator": [],
  //   "Star Rating": [],
  //   "Type of Watches or Clock": [],
  //   "Dial Shape": [],
  //   "Strap Material": [],
  //   "brands": []
  // };
  //-----------------------
/*--------------------api data end-------------------------*/

   _onLoading() async {
     if(widget.id!=""){
       fetchAllProductList(sellerId: widget.sellersId,lat:widget.latitude, long: widget.longitude);
     }else{
       fetchAllProductList(sellerId: widget.sellersId,lat:"22.7177", long: " 75.8545",);}
  }

  Future<void> _initializeData() async {
    // Fetch data
    fetchSellerProductListFilter(sellerId: widget.sellersId);
    if (widget.id != "") {
      await fetchAllProductList(sellerId: widget.sellersId, lat: widget.latitude, long: widget.longitude);
      await fetchSellerDataList(sIds: widget.sellersId, lat: widget.latitude, long: widget.longitude);
    } else {
      await fetchSellerDataList(sIds: widget.sellersId, lat: 22.7177, long: 75.8545);
      await fetchAllProductList(sellerId: widget.sellersId, lat: 22.7177, long: 75.8545);
    }

    // Update defaultTabIndex based on productList
    setState(() {
      defaultTabIndex = productList.isEmpty ? 0 : 1;
      _tabController.index = defaultTabIndex; // Update the TabController index
    });

    storePageKpiApiServices(type: "visit_store", sellerId: widget.sellersId.toString());
  }


   bool planeValidity = false;
  List<PlanValidityData>? data = [];
  Future<void> fetchPlanData() async {
    setState(() {
      isLoading = true; // Start loading
    });

    try {
      final getCardDetailsResponse = await PlanValidityApiService.fetchPlanValidityData(
        context: context,
        sellerId: widget.sellersId??"",
      );

      if (getCardDetailsResponse != null && getCardDetailsResponse.data != null) {
        setState(() {
          data = getCardDetailsResponse.data!;
          planeValidity = getCardDetailsResponse.planeValidity??false;
          if (planeValidity == false) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => PlanValidityScreen(dataList: data),
              ),
            );}
        });
      } else {
        // Handle case where no data is returned
        setState(() {
          data = []; // Ensure data is an empty list if no data
        });
      }
    } catch (e) {
      // Handle errors
      setState(() {
        // Optionally show an error message
        data = []; // Ensure data is an empty list in case of an error
      });
    } finally {
      setState(() {
        isLoading = false; // Stop loading
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeData();
    fetchPlanData();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }


  // @override
  // void initState() {
  //   super.initState();
  //   fetchSellerProductListFilter(sellerId: widget.sellersId,);
  //   productList.clear();
  //   if(widget.id!=""){
  //     fetchAllProductList(sellerId: widget.sellersId,lat:widget.latitude, long: widget.longitude);
  //     fetchSellerDataList(sIds: widget.sellersId, lat: widget.latitude, long: widget.longitude);
  //   }else{
  //     fetchSellerDataList(sIds: widget.sellersId, lat: 22.7177, long: 75.8545);
  //     fetchAllProductList(sellerId: widget.sellersId,lat:22.7177, long: 75.8545,);
  //   }
  //   storePageKpiApiServices(type: "visit_store", sellerId: widget.sellersId.toString());
  //   _tabController = TabController(length: 3, vsync: this);
  //   _tabController.addListener(_handleTabSelection);
  //   _tabController.index = defaultTabIndex;
  // }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  //------------------------reals data --------------

  Future<void> openMap(double lat, double lng) async {
    final mapUrl = getMapUrls(lat, lng);

    if (await canLaunch(mapUrl)) {
      await launch(mapUrl, forceSafariVC: false);
    } else {
      throw 'Unable to open the map.';
    }
  }
  /*-----------------------------------------------------------------*/
  void _showImageCarousel(List<String> images, int selectedIndex) {
    showModalBottomSheet(
      enableDrag: false,
      context: context,
      isScrollControlled: true,
      backgroundColor: ConstantColor.primaryBackgroundMainColor,
      builder: (BuildContext context) {
        return Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: PhotoViewGallery.builder(
                itemCount: images.length,
                builder: (context, index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(images[index]),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 2,
                  );
                },
                scrollPhysics: const BouncingScrollPhysics(),
                backgroundDecoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                pageController: PageController(initialPage: selectedIndex),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 15.0),
              child: customeIconButton(
                icon: const Icon(
                  Icons.close_rounded,
                  size: 30,
                ),
                color: ConstantColor.primaryMainColor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }
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
/*-----------------------------------------------------------------*/
  // Function to calculate the count of filter items excluding "Suitable for"
  int getFilterItemCount(Map<String, List<String>> filterItem) {
    int count = 0;
    filterItem.forEach((key, values) {
      if (values.isNotEmpty) {
        count += 1;
      }
    });

    return count;
  }

/*-----------------------------------------------------------------*/
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        SharedPreferences preference = await SharedPreferences.getInstance();
        preference.remove("minMyPrice");
        preference.remove("maxMyPrice");
        return true;
      },
      child:
      Scaffold(
        backgroundColor: ConstantColor.primaryBackgroundMainColor,
        key: scaffoldKey2,
        drawer: Drawer(
            backgroundColor: ConstantColor.primaryBackgroundMainColor,
            child: DrawerHeader(
              padding: EdgeInsets.zero,
              child: SingleChildScrollView(
                controller: filterScrollController,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      // horizontalTitleGap: screenWidth/3,
                      // minLeadingWidth: screenWidth/2.1,
                      dense: true,
                      title: customeText(
                        text: "Filter",
                        overflow: TextOverflow.ellipsis,
                        style: ConstantTextStyle.secodHearText1,
                      ),
                      trailing: Wrap(
                        spacing: screenWidth/50,
                        children: [
                          customeButton(
                            text: "Clear All",
                            style: ConstantTextStyle.loginButtonTextStyle,
                            borderRadius: BorderRadius.circular(8.0),
                            backgroundColor: ConstantColor.loginWithOtpButtonColor,
                            onPressed: () {
                              setState(() {clearAllCheckboxes();});
                              filterItem!.clear();
                              Navigator.pop(context);},
                          ),
                          customeButton(
                            text: "Apply",
                            style: ConstantTextStyle.loginButtonTextStyle,
                            borderRadius: BorderRadius.circular(8.0),
                            backgroundColor: ConstantColor.primaryMainColor,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: ConstantColor.primaryGreyColor,
                      thickness: 1.0,
                      height: 0.0,
                    ),
                    isLoading2 ? const SpinKitCircle(
                      color: ConstantColor.primaryMainColor,
                      size: 30.0,
                    ): filterAttributes!.isNotEmpty
                        ? Column(
                      children: [
                        /*---------------category section start--------------------*/
                        ExpansionTile(
                          textColor:  ConstantColor.primaryMainColor,
                          iconColor: ConstantColor.primaryMainColor,
                          title: customeText(
                            text: "Category",),
                          children: filterCategories!.map((filterCat) {
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return CheckboxListTile(
                                  dense: true,
                                  checkboxShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  activeColor: ConstantColor.primaryMainColor,
                                  checkColor: ConstantColor.primaryBackgroundMainColor,
                                  title: customeText(
                                    text: filterCat.categoryName?? "",
                                    style: ConstantTextStyle.allHomeScreenAvatarText,
                                  ),
                                  value:  filterCat.isSelected ?? false,
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      filterCat.isSelected = newValue;
                                      page=1;
                                      if (newValue == true) {
                                        selectedCategoryString += (selectedCategoryString.isNotEmpty ? ',' : '') + (filterCat.categoryId ?? '');
                                      }
                                      else {
                                        final List<dynamic> sringName;
                                        sringName = selectedCategoryString.split(',');
                                        sringName.removeLast();
                                        selectedCategoryString = sringName.join(',');
                                      }
                                      if(widget.id!=""){
                                        fetchAllProductList(sellerId: widget.sellersId,lat:widget.latitude, long: widget.longitude);
                                        productList.clear();
                                      }
                                      else{
                                        fetchAllProductList(sellerId: widget.sellersId,lat:"22.7177", long: " 75.8545",);
                                        productList.clear();
                                      }
                                    });
                                  },
                                  controlAffinity: ListTileControlAffinity.leading,
                                );
                              },
                            );
                          }).toList(),
                        ),
                        /*---------------category section end--------------------*/
                        /*---------------Price section end--------------------*/
                        ExpansionTile(
                          iconColor: ConstantColor.primaryMainColor,
                          textColor: ConstantColor.primaryMainColor,
                          title: customeText(
                            text: "Price",),
                          children: [
                            ListTile(
                              visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
                              dense: true,
                              leading: Container(
                                padding:EdgeInsets.symmetric(horizontal: screenHeight/80, vertical: screenHeight/80),
                                color: ConstantColor.calendarBGHeadColor,
                                child: customeText(text: minPriceValue == null
                                    ? allProductListFilter!.minPrice.toString()
                                    : minPriceValue.toString(),
                                    textAlign: TextAlign.center,
                                    style: ConstantTextStyle.becomeSellerDiscText),
                              ),
                              title: customeText(
                                textAlign: TextAlign.center,
                                text: "TO",
                                style: ConstantTextStyle.allHomeScreenAvatarText,
                              ),
                              trailing:  Container(
                                padding:EdgeInsets.symmetric(horizontal: screenHeight/80, vertical: screenHeight/80),
                                color: ConstantColor.calendarBGHeadColor,
                                child: customeText(text: maxnPriceValue == null
                                    ? allProductListFilter!.maxPrice.toString()
                                    :maxnPriceValue.toString()??'',
                                    textAlign: TextAlign.center,
                                    style: ConstantTextStyle.becomeSellerDiscText),
                              ),
                            ),
                            ProductPriceSliderClass(
                                callback: onDataFromChild,
                                minV1: allProductListFilter!.minPrice?.toDouble() ?? 0.0,
                                maxV1: allProductListFilter!.maxPrice?.toDouble() ?? 0.0)
                          ],
                        ),
                        /*---------------Price section end--------------------*/
                        /*---------------Attribute section Start--------------------*/
                        SizedBox(
                          height: screenHeight / 1.5,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: filterAttributes!.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              final filterAttribute = filterAttributes![index];
                              final selectedCount = filterAttribute.isSelectedValues
                                  ?.where((selected) => selected ?? false)
                                  .length ?? 0;
                              // var selectedCount;
                              return ExpansionTile(
                                iconColor: ConstantColor.primaryMainColor,
                                textColor: ConstantColor.primaryMainColor,
                                title: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    customeText(
                                      text: filterAttribute.attrName ?? "",
                                    ),
                                    selectedCount == 0 ? Container():
                                    CircleAvatar(
                                      radius: 10.0,
                                      backgroundColor: ConstantColor.primaryMainColor,
                                      child: Text(selectedCount.toString()??'',style: ConstantTextStyle.chipText,),
                                    ),
                                  ],
                                ),

                                children: [
                                  SizedBox(
                                    height: screenHeight / 5,
                                    child: ScrollbarTheme(
                                      data: ScrollbarThemeData(
                                        thumbColor: MaterialStateProperty.all<Color>(ConstantColor.filedContainerColor),
                                        trackColor: MaterialStateProperty.all<Color>(ConstantColor.carColor),
                                      ),
                                      child: Scrollbar(
                                        trackVisibility: true,
                                        thumbVisibility: true,
                                        controller: filterScrollController,
                                        thickness: 5.0,
                                        radius: const Radius.circular(10.0),
                                        child: ListView.builder(
                                          physics: const BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: filterAttribute.attrValues?.length ?? 0,
                                          itemBuilder: (BuildContext context, int valueIndex) {
                                            final attributeValue = filterAttribute.attrValues?[valueIndex] ?? "";
                                            return StatefulBuilder(
                                              builder: (context, setState) {
                                                return CheckboxListTile(
                                                  key: ValueKey<String>(attributeValue),
                                                  dense: true,
                                                  checkboxShape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(5)),
                                                  activeColor: ConstantColor.primaryMainColor,
                                                  checkColor: ConstantColor.primaryBackgroundMainColor,
                                                  title: Text(
                                                    attributeValue,
                                                    style: ConstantTextStyle.allHomeScreenAvatarText,
                                                  ),
                                                  value: filterAttribute.isSelectedValues?[valueIndex] ?? false,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      // filterAttribute.isSelectedValues?.where((selected) => selected).length ?? 0;
                                                      filterAttribute.isSelectedValues?[valueIndex] = newValue;
                                                      page = 1;
                                                      // Update filterItem dynamically based on attribute name
                                                      if (newValue == true) {
                                                        filterItem!.update(
                                                          filterAttribute.attrName ?? '',
                                                              (existingValues) => [
                                                            ...(existingValues ?? []),
                                                            attributeValue ?? '',
                                                          ],
                                                          ifAbsent: () => [attributeValue ?? ''],
                                                        );
                                                      } else {
                                                        filterItem!.update(
                                                          filterAttribute.attrName ?? '',
                                                              (existingValues) => [
                                                            ...(existingValues ?? []),
                                                          ]..remove(attributeValue ?? ''),
                                                          ifAbsent: () => [],
                                                        );
                                                      }
                                                    });

                                                    // Call API with updated filterItem
                                                    if (widget.id != "") {
                                                      fetchAllProductList(sellerId: widget.sellersId,lat:widget.latitude, long: widget.longitude);
                                                    } else {
                                                      fetchAllProductList(sellerId: widget.sellersId,lat: "22.7177", long: "75.8545",);
                                                    }
                                                    productList.clear();
                                                  },
                                                  controlAffinity: ListTileControlAffinity.leading,
                                                );
                                              },
                                            );
                                          },
                                        ),

                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        // SizedBox(
                        //   height: screenHeight / 1.5,
                        //   child: ListView.builder(
                        //     physics: const BouncingScrollPhysics(),
                        //     itemCount: filterAttributes!.length,
                        //     itemBuilder: (BuildContext context, int index) {
                        //       final filterAttribute = filterAttributes![index];
                        //       return ExpansionTile(
                        //         iconColor: ConstantColor.primaryMainColor,
                        //         textColor: ConstantColor.primaryMainColor,
                        //         title: customeText(
                        //           text: filterAttribute.attrName ?? "",),
                        //         children: [
                        //           SizedBox(
                        //             height: screenHeight / 5,
                        //             child: ScrollbarTheme(
                        //               data: ScrollbarThemeData(
                        //                 thumbColor: MaterialStateProperty.all<Color>(ConstantColor.filedContainerColor),
                        //                 trackColor: MaterialStateProperty.all<Color>(ConstantColor.carColor),
                        //               ),
                        //               child: Scrollbar(
                        //                 trackVisibility: true,
                        //                 thumbVisibility: true,
                        //                 controller: filterScrollController,
                        //                 thickness: 5.0,
                        //                 radius: const Radius.circular(10.0),
                        //                 child: ListView.builder(
                        //                   physics: const BouncingScrollPhysics(),
                        //                   shrinkWrap: true,
                        //                   itemCount: filterAttribute.attrValues?.length ?? 0,
                        //                   itemBuilder: (BuildContext context, int valueIndex) {
                        //                     final attributeValue = filterAttribute.attrValues?[valueIndex] ?? "";
                        //                     return StatefulBuilder(
                        //                       builder: (context, setState) {
                        //                         return CheckboxListTile(
                        //                           key: ValueKey<String>(attributeValue),
                        //                           dense: true,
                        //                           checkboxShape: RoundedRectangleBorder(
                        //                               borderRadius: BorderRadius.circular(5)),
                        //                           activeColor: ConstantColor.primaryMainColor,
                        //                           checkColor: ConstantColor.primaryBackgroundMainColor,
                        //                           title: customeText(
                        //                             text: attributeValue,
                        //                             style: ConstantTextStyle.allHomeScreenAvatarText,
                        //                           ),
                        //                           value: filterAttribute.isSelectedValues?[valueIndex] ?? false,
                        //                           onChanged: (newValue) {
                        //                             setState(() {
                        //                               filterAttribute.isSelectedValues?[valueIndex] = newValue; // Update the selected state for this checkbox
                        //                               page = 1;
                        //                               if (newValue == true) {
                        //                                 filterItem![filterAttribute.attrName ?? '']?.add(attributeValue ?? "");
                        //                               } else {
                        //                                 filterItem![filterAttribute.attrName ?? '']?.remove(attributeValue ?? '');
                        //                               }
                        //                             });
                        //                             if(widget.id!=""){
                        //                               fetchAllProductList(sellerId: widget.sellersId,lat:widget.latitude, long: widget.longitude);
                        //                               productList.clear();
                        //                             }
                        //                             else{
                        //                               fetchAllProductList(sellerId: widget.sellersId,lat:"22.7177", long: " 75.8545",);
                        //                               productList.clear();
                        //                             }
                        //                           },
                        //                           controlAffinity: ListTileControlAffinity.leading,
                        //                         );
                        //                       },
                        //                     );
                        //                   },
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       );
                        //     },
                        //   ),
                        // ),
                        /*---------------Attribute section end--------------------*/
                      ],) : customeText(text: "Data not Available yet"),
                  ],
                ),
              ),
            )
        ),
        /*---------------------Filter Drawer end------------------------------*/
        /*--------------------------------------appbar section start-------------------------------------*/
                    appBar: AppBar(
                      iconTheme: const IconThemeData(
                        color: ConstantColor.loginWithOtpButtonColor,
                      ),
                      backgroundColor: ConstantColor.primaryBackgroundMainColor,
                      elevation: 0.0,
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: ()  async {
                          SharedPreferences preference = await SharedPreferences.getInstance();
                          preference.remove("minMyPrice");
                          preference.remove("maxMyPrice");
                          Navigator.of(context).pop();
                        },
                      ),
                      titleSpacing: 0.0,
                      title: Center(
                        child: customImg(
                          height: screenHeight / 30,
                          fit: BoxFit.fill,
                          image: ConstantImage.cityBazaarStoreLogo,
                        ),
                      ),
                      actions: [
                        Padding(
                          padding: EdgeInsets.only(right: screenWidth / 30),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ShareAppScreen(
                                    myStoreImage: sellerStoreDetails!.data!.sellerDetails!.storeImageUrl??"",
                                      latitude: widget.latitude,
                                      longitude: widget.longitude,
                                    sellerIds: widget.sellersId.toString(),
                                  );
                                },
                              );
                            },
                            child: Icon(
                              FontAwesomeIcons.share,
                              color: ConstantColor.loginWithOtpButtonColor,
                              size: 0.025 * screenHeight,
                            ),
                          ),
                        ),
                      ],
                    ),
        /*--------------------------------------appbar section end-------------------------------------*/

        /*------------------------------bottomNavigationBar Button Start-----------------------------------*/
                    bottomNavigationBar: _selectedIndex == 1 || _selectedIndex == 2
                        ? null
                         : userBottomNavBarScreen(
                      context: context,
                      senEnquiryTitleText: "Enquiry Send Successfully",
                      sendEnquiryDescriptionText:
                      "+91 ${sellerStoreDetails?.data?.sellerDetails?.contactNo ?? ''}.\n",
                        phoneNumber:sellerStoreDetails?.data?.sellerDetails?.contactNo ?? '',
                        buttonText: buttonText,
                      sendEnqButton: () async {
                        SharedPreferences preferences = await SharedPreferences.getInstance();
                        setState(() {
                          isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                          tokenAccess = preferences.getString("access-token");
                        });
                        // Toggle buttonText based on user login status
                        setState(() {
                          if (isUserLoggedIn) {
                            buttonText = sellerStoreDetails?.data?.sellerDetails?.contactNo??"";
                          } else {
                            buttonText = "View Contact Details";
                          }
                           storePageKpiApiServices(type: "phone_request", sellerId: widget.sellersId.toString());
                        });

                        // Show login dialog if user is not logged in
                        if (!isUserLoggedIn) {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return const CheckIsLogin();
                            },
                          );
                        }
                      },

                      navigationChatWithSellerButton: () async {
                        SharedPreferences preferences = await SharedPreferences.getInstance();
                        setState(() {
                          isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                          tokenAccess = preferences.getString("access-token");
                        });
                   if (isUserLoggedIn) {
                     String? phoneWhatsappNo = sellerStoreDetails?.data?.sellerDetails?.contactNo;
                     String? phoneWhatsappText = sellerStoreDetails?.data?.sellerDetails?.whatsapptext;
                     if (phoneWhatsappNo != null && phoneWhatsappNo.isNotEmpty) {
                       _launchWhatsApp(phoneWhatsappNo, phoneWhatsappText);
                     }
                     await storePageKpiApiServices(type: "chat_with_seller", sellerId: widget.sellersId.toString());
                   }else{
                     showDialog(
                     barrierDismissible: false,
                     context: context,
                     builder: (BuildContext context) {
                       return const CheckIsLogin();
                     },
                   );}
                      },
                    ),

        /*------------------------------bottomNavigationBar Button end-----------------------------------*/
        body:
        //planeValidity == true? PlanValidityScreen():
        DefaultTabController(
          length: 3,
          child: NestedScrollView(
            body: TabBarView(
              controller: _tabController,
              children: [
 /*-------------------------------About us Screen Section ------------------------------*/
/*-------------------------------Photos Section start------------------------------*/
                                        if (isLoading2)
                                          const SpinKitCircle(
                                              color: ConstantColor.primaryMainColor, size: 30.0)
                                        else
                                          ListView(
                                            padding:EdgeInsets.symmetric(horizontal: screenWidth/30),
                                          //    crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height:  screenHeight / 80,),
                                              headingTextWithIcon(
                                                icon: Icons.image_outlined,
                                                iconSize: 15.0,
                                                iconColor: ConstantColor.primaryBlackColor,
                                                text: "  Photos",
                                                textStyle:
                                                    ConstantTextStyle.allHomeScreenAvatarText,
                                              ),
                /*-------------------------------Photos Section end------------------------------*/
                                              SizedBox(
                                                height: screenHeight / 80,
                                              ),
                /*----------------------------- ListView Scrolling image start --------------------------------*/
                                              SizedBox(
                                                height: screenHeight / 12,
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  scrollDirection: Axis.horizontal,
                                                  itemCount: sellerPhotoList.length,
                                                  itemExtent: screenWidth / 3,
                                                  itemBuilder:
                                                      (BuildContext context, int index) {
                                                    final sellerPhotoGallery =
                                                        sellerPhotoList[index];
                                                    return GestureDetector(
                                                      onTap: () {
                                                        _showImageCarousel(
                                                            sellerPhotoList
                                                                .map((photo) =>
                                                                    photo.url ?? "")
                                                                .toList(),
                                                            index);
                                                      },
                                                      child: Padding(
                                                        padding: EdgeInsets.only(
                                                            right: screenWidth / 80),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.circular(8.0),
                                                          child: CachedNetworkImage(
                                                            imageUrl:
                                                                sellerPhotoGallery.url ?? "",
                                                            height: screenHeight / 10,
                                                            width: screenWidth / 2.5,
                                                            fit: BoxFit.fill,
                                                            errorWidget:
                                                                (context, url, error) =>
                                                                    Image.asset(
                                                              ConstantImage
                                                                  .imageIsNotAvailable,
                                                              height: screenHeight / 10,
                                                              width: screenWidth / 2.5,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                /*----------------------------- ListView Scrolling image end --------------------------------*/
                /*----------------------------- Divider start --------------------------------*/
                                              Divider(
                                                color: ConstantColor.GrayLineColor,
                                                height: screenHeight / 50,
                                                thickness: 1,
                                              ),
                /*----------------------------- Divider end --------------------------------*/
                                              SizedBox(
                                                height: screenHeight / 80,
                                              ),
                /*----------------------------- Store info section start --------------------------------*/
                                              headingTextWithIcon(
                                                icon: Icons.public,
                                                iconSize: 15.0,
                                                iconColor: ConstantColor.primaryBlackColor,
                                                text: "  Store Information",
                                                textStyle:
                                                    ConstantTextStyle.allHomeScreenAvatarText,
                                              ),
                                              SizedBox(
                                                height: screenHeight / 80,
                                              ),
                                              ...sellerAllDetailsList.map((sellerDetails) {
                                                return customeText(
                                                  text: sellerDetails.storeDescription ?? "",
                                                  style: ConstantTextStyle.storeDetailsText2,
                                                  textAlign: TextAlign.start,
                                                );
                                              }),

                /*----------------------------- Store info section end --------------------------------*/
                                              SizedBox(
                                                height: screenHeight / 80,
                                              ),
                 /*----------------------------- Deals In section start --------------------------------*/
                                              headingTextWithIcon(
                                                icon: Icons.production_quantity_limits,
                                                iconSize: 15.0,
                                                iconColor: ConstantColor.primaryBlackColor,
                                                text: "  Deals In",
                                                textStyle:
                                                    ConstantTextStyle.allHomeScreenAvatarText,
                                              ),
                                              SizedBox(
                                                height: screenHeight / 80,
                                              ),
                                              Wrap(
                                                spacing: 10.0,
                                                runSpacing: 10.0,
                                                children: sellerDealsInList
                                                    .map((sellerDealsInData) {
                                                  return Card(
                                                    color: ConstantColor.primaryBackgroundMainColor,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: Text(
                                                        sellerDealsInData.categoryName ?? "",
                                                        style: ConstantTextStyle
                                                            .storeDetailsText2,
                                                        textAlign: TextAlign.start,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),

                /*----------------------------- Deals In section end --------------------------------*/
                /*----------------------------- Divider start --------------------------------*/
                                              Divider(
                                                color: ConstantColor.GrayLineColor,
                                                height: screenHeight / 50,
                                                thickness: 1,
                                              ),
                /*----------------------------- Divider end --------------------------------*/
                                              SizedBox(
                                                height: screenHeight / 80,
                                              ),
                /*----------------------------- Address section start --------------------------------*/
                                              headingTextWithIcon(
                                                icon: Icons.location_on_outlined,
                                                iconSize: 15.0,
                                                iconColor: ConstantColor.primaryBlackColor,
                                                text: "  Address",
                                                textStyle:
                                                    ConstantTextStyle.allHomeScreenAvatarText,
                                              ),
                                              SizedBox(
                                                height: screenHeight / 80,
                                              ),

                                              ...sellerAllDetailsList.map((sellerDetails) {
                                                return customeText(
                                                  text: sellerDetails.storeLocAddress ?? "",
                                                  style: ConstantTextStyle.storeDetailsText2,
                                                  textAlign: TextAlign.start,
                                                );
                                              }),
                /*-----------------------------------------Address section end ---------------------------------------*/
                                              SizedBox(
                                                height: screenHeight / 80,
                                              ),
                /*----------------------------- Location section start --------------------------------*/
                                              headingTextWithIcon(
                                                icon: Icons.map,
                                                iconSize: 15.0,
                                                iconColor: ConstantColor.primaryBlackColor,
                                                text: "  Location",
                                                textStyle:
                                                    ConstantTextStyle.allHomeScreenAvatarText,
                                              ),
                /*----------------------------- Location section end --------------------------------*/
                                          SizedBox(height: screenHeight / 80,),


                                              // ...sellerAllDetailsList.map((shopMap) {
                                              //   String latitude = shopMap.storeLatitude.toString() ?? "";
                                              //   String longitude = shopMap.storeLongitude.toString() ?? '';
                                              //   if (latitude.isNotEmpty && longitude.isNotEmpty) {
                                              //     return
                                              //       SizedBox(
                                              //       height: screenHeight / 4,
                                              //       child: MapScreen(
                                              //         shopLatitude: double.parse(latitude),
                                              //         shopLongitude: double.parse(longitude),
                                              //       ),
                                              //     );
                                              //   } else {
                                              //     // Handle the case where latitude or longitude is empty
                                              //     return Container();
                                              //   }
                                              // }).toList(),
                /*-----------------------------------------Map section start ---------------------------------------*/

                                              ...sellerAllDetailsList.map((shopMap) {
                                                final MapController mapController = MapController();
                                                String latitude = shopMap.storeLatitude.toString() ?? "";
                                                String longitude = shopMap.storeLongitude.toString() ?? '';
                                                return  SizedBox(
                                                  height: screenHeight/4,
                                                  child:
                                                  Stack(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.circular(10.0),
                                                        child: FlutterMap(
                                                          mapController: mapController,
                                                          options: MapOptions(
                                                            center: LatLng(double.parse(latitude), double.parse(longitude)),
                                                            zoom: 12.0,
                                                            minZoom: 5,
                                                            maxZoom: 18,
                                                          ),
                                                          children: [
                                                            TileLayer(
                                                              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                                            ),
                                                            MarkerLayer(
                                                              markers: [
                                                                Marker(
                                                                  width: 80.0,
                                                                  height: 80.0,
                                                                  point: LatLng(double.parse(latitude), double.parse(longitude)),
                                                                  builder: (ctx) => GestureDetector(
                                                                    onTap: () {
                                                                      // Handle marker tap here, e.g., zoom in
                                                                      mapController.move(
                                                                        LatLng(double.parse(latitude), double.parse(longitude)),
                                                                        17.0, // Zoom level you desire
                                                                      );
                                                                    },
                                                                    child: const Icon(
                                                                      Icons.location_pin,
                                                                      color: ConstantColor.primaryMainColor,
                                                                      size: 40.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),

                                                          ],
                                                        ),
                                                      ),
                                                      
                                                      Positioned(
                                                        bottom: 0,
                                                        right: 0,
                                                        child: customeIconButton(
                                                          onPressed: () async {
                                                            var doubleValueLatitude = double.tryParse(sellerStoreDetails!.data!.sellerDetails!.storeLatitude.toString());
                                                            var doubleValueLongitude = double.tryParse(sellerStoreDetails!.data!.sellerDetails!.storeLongitude.toString());
                                                            await openMap(doubleValueLatitude!, doubleValueLongitude!);
                                                            await storePageKpiApiServices(type: "location", sellerId: widget.sellersId.toString());
                                                          },
                                                          icon: const Icon(
                                                            color: ConstantColor.emailBGColor,
                                                              size: 30,
                                                              Icons.assistant_direction,
                                                          )
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                );    }),

                /*-----------------------------------------Map section end ---------------------------------------*/

                /*----------------------------- Divider start --------------------------------*/
                                              Divider(
                                                color: ConstantColor.GrayLineColor,
                                                height: screenHeight / 50,
                                                thickness: 1,
                                              ),
                /*----------------------------- Divider end --------------------------------*/
                /*-----------------------------------------Timing section start ---------------------------------------*/
                                              headingTextWithIcon(
                                                icon: Icons.access_time,
                                                iconSize: 15.0,
                                                iconColor: ConstantColor.primaryBlackColor,
                                                text: "  Store Time",
                                                textStyle: ConstantTextStyle.allHomeScreenAvatarText,
                                              ),
                                              SizedBox(
                                                height: screenHeight / 80,
                                              ),

                                              ...sellerStoreTimeList
                                                  .map((sellerStoreTimeHere) {
                                                return customeText(
                                                  text:
                                                      "${sellerStoreTimeHere.day ?? ""} :- ${sellerStoreTimeHere.opensAt ?? ""}"
                                                      " - ${sellerStoreTimeHere.closesAt ?? ""}",
                                                  style: ConstantTextStyle.storeDetailsText2,
                                                  textAlign: TextAlign.start,
                                                );
                                              }),

                /*----------------------------- Divider start --------------------------------*/
                                              Divider(
                                                color: ConstantColor.GrayLineColor,
                                                height: screenHeight / 50,
                                                thickness: 1,
                                              ),
                /*----------------------------- Divider end --------------------------------*/

                /*-----------------------------------------Timing section end ---------------------------------------*/
                                              SizedBox(
                                                height: screenHeight / 80,
                                              ),

                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.local_shipping,
                                                    size: 18,
                                                    color: ConstantColor.primaryBlackColor,
                                                  ),
                                                  SizedBox(
                                                    width: screenWidth / 40,
                                                  ),
                                                  ...sellerAllDetailsList
                                                      .map((sellerDetails) {
                                                    return customeText(
                                                        textAlign: TextAlign.start,
                                                        text:
                                                            sellerDetails.deliveryMode ?? "",
                                                        style: ConstantTextStyle.richtext1);
                                                  }),
                                                ],
                                              ),
                                              SizedBox(
                                                height: screenHeight / 40,
                                              ),
                /*-------------------------Review & Rating start ---------------------------*/
                                              customRichText(
                                                TextAlign: TextAlign.start,
                                                text1: "Review & Rating",
                                                style1:
                                                    ConstantTextStyle.allHomeScreenAvatarText,
                                              ),
                /*----------------------------Review & Rating end -----------------------------*/
                                              SizedBox(
                                                height: screenHeight / 80,
                                              ),
                /*------------------------------Start Rating with text start------------------------------------------*/
                                              ...sellerAllDetailsList.map((sellerDetails) {
                                                return  Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: screenWidth / 60),
                                                  decoration: BoxDecoration(
                                                    color: ConstantColor.boxGrayColor,
                                                    borderRadius: BorderRadius.circular(8.0),
                                                  ),
                                                  child: ListTile(
                                                    dense: true,
                                                    minVerticalPadding: 0.0,
                                                    horizontalTitleGap: screenWidth /7.0,
                                                    contentPadding: EdgeInsets.zero,
                                                    leading: startRating(
                                                      width: screenWidth / 3,
                                                      height: screenHeight / 30,
                                                      context: context,
                                                      color: ConstantColor.bottonNavIcons,
                                                      text2: "${double.parse(sellerDetails.avgRating ?? "0").toStringAsFixed(1)}/5.0",
                                                      style2: ConstantTextStyle
                                                          .allHomeScreenAvatarText,
                                                      initialRating: double.parse(
                                                          sellerDetails.avgRating ?? "0"),
                                                      itemSize: 14.0,
                                                      minRating: 1.0,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      onRatingUpdate: (rating) {},
                                                      itemBuilder: (context, _) => const Icon(
                                                        Icons.star,
                                                        color: ConstantColor.starRatingColor,
                                                      ),
                                                    ),
                /*---------------------------------------Start Rating with text end--------------------------------------*/
                /*-------------------------------------Review and Rating button start-----------------------------------*/
                                                    title: ElevatedButton(
                                                      onPressed:()  async {

                                                        SharedPreferences preferences = await SharedPreferences.getInstance();
                                                        setState(() {
                                                          isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                                                          tokenAccess = preferences.getString("access-token");
                                                        });
                                                        if (isUserLoggedIn){
                                                        showDialog(
                                                          context: context,
                                                          builder: (ctx) {
                                                            return
                                                              ReviewRatingScreen(sellersId:widget.sellersId);
                                                          },
                                                        );
                                                        }
                                                        else{
                                                          showDialog(
                                                            barrierDismissible: false,
                                                            context: context,
                                                            builder: (BuildContext context) {
                                                              return const CheckIsLogin();
                                                            },
                                                          );
                                                        }
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        minimumSize: Size.fromHeight(screenHeight / 25),
                                                        backgroundColor:ConstantColor.primaryMainColor,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                        ),
                                                      ),
                                                      child: customeText(
                                                        text: 'Review and Rating',
                                                        textAlign: TextAlign.center,
                                                        style: ConstantTextStyle.newiconButtonText,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                /*----------------------------- Divider start --------------------------------*/
                                              Divider(
                                                color: ConstantColor.GrayLineColor,
                                                height: screenHeight / 50,
                                                thickness: 1,
                                              ),
                /*----------------------------- Divider end --------------------------------*/
                /*-----------------------user Review & Rating ListTile start  --------------------------*/
                                                    ListView.builder(
                                                      physics: const ScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: allReviewList.length,
                                                      itemBuilder: (BuildContext context, index) {
                                                        final allReviewHere = allReviewList[index];
                                                        if (allReviewHere.user == null || allReviewHere.user!.isEmpty
                                                            ||allReviewHere.reveiw == null || allReviewHere.reveiw!.isEmpty
                                                        ) {
                                                          return null;
                                                        }
                                                        return Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            reviewRatingWidget(
                                                              left: 0.0,
                                                              top: 0.0,
                                                              text: allReviewHere.user??"",
                                                              style: ConstantTextStyle.storeDetailsText3,
                                                              radius: 20.0,
                                                              context: context,
                                                              backgroundImage: AssetImage(ConstantImage.imageIsNotAvailable,),
                                                              starRatingWidget:startRating(
                                                                width: screenWidth / 3,
                                                                height: screenHeight /30,
                                                                context: context,
                                                                color: ConstantColor.transparent1,
                                                                text2: "${double.parse(allReviewHere.rating ?? "0").toStringAsFixed(1)}/5.0",
                                                                style2: ConstantTextStyle.allHomeScreenAvatarText,
                                                                initialRating:double.parse(allReviewHere.rating ?? "0"),
                                                                itemSize: 14.0,
                                                                minRating: 1.0,
                                                                allowHalfRating: true,
                                                                itemCount: 5,
                                                                onRatingUpdate: (rating) {},
                                                                itemBuilder: (context, _) =>
                                                                const Icon(
                                                                  Icons.star,
                                                                  color:
                                                                  ConstantColor.starRatingColor,
                                                                ),
                                                              ),),
                                  /*-----------------------user Review & Rating section end  --------------------------*/
                                                      SizedBox(
                                                        height: screenHeight / 100,
                                                      ),
                                                            customRichText(
                                                              TextAlign: TextAlign.start,
                                                              text1: allReviewHere.reveiw ?? "",
                                                              style1: ConstantTextStyle.storeDetailsText2,
                                                            ),


/*----------------------------- Divider start --------------------------------*/
                                                      Divider(
                                                        color: ConstantColor.GrayLineColor,
                                                        height: screenHeight / 50,
                                                        thickness: 1,
                                                      ),
/*----------------------------- Divider end --------------------------------*/
                                                    ],
                                                                                                      );
                                                                                                    },
                                                                                                  ),
                                            ],
                                          ),
                /*-------------------------------About Us Screen Section end ---------------------------------------------*/

                /*-------------------------------Product Screen Section start---------------------------------------------*/
                /*------------------------------filter and sort_by section start-----------------------------*/
                isLoading3
                    ? const SpinKitCircle(
                  color: ConstantColor.primaryMainColor,
                  size: 30.0,
                ) :
                Container(
                  height: screenHeight/1.55,
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth / 100),
                  decoration: BoxDecoration(
                    color: ConstantColor.secondryBackgroundMainColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: SmartRefresher(
                    enablePullDown: false,
                    enablePullUp: true,
                    footer: customFooter(),
                    controller: _refreshController,
                    onLoading: _onLoading,
                    child: ListView(
                      physics: const ScrollPhysics(),
                      children: [
                        Row(
                          children: [
                            iconAndText(
                              onPressed: () {
                                scaffoldKey2.currentState!.openDrawer();
                              },
                              icons: Icons.filter_alt_outlined,
                              iconsSize: 20.0,
                              iconsColor:
                              ConstantColor.loginWithOtpButtonColor,
                              iconText: "Filter",
                              iconTextStyle: ConstantTextStyle
                                  .allHomeScreenAvatarText,
                            ),
                            getFilterItemCount(filterItem??{}) == 0? Container():
                            CircleAvatar(
                              radius: 10.0,
                              backgroundColor: ConstantColor.primaryMainColor,
                              child: Text(getFilterItemCount(filterItem??{}).toString()??'',style: ConstantTextStyle.chipText,),
                            ),
                            const VerticalDivider(
                              color: ConstantColor.GrayLineColor,
                              thickness: 1,
                            ),
                            Flexible(
                              child: ListTile(
                                onTap: () {},
                                minVerticalPadding: 0,
                                minLeadingWidth: 0,
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                visualDensity: const VisualDensity(
                                    horizontal: 0, vertical: -4),
                                leading: const Icon(Icons.sort,color: ConstantColor.loginWithOtpButtonColor,size: 20.0,),
                                // leading:  iconAndText(
                                //   onPressed: () {},
                                //   icons: Icons.sort,
                                //   iconsSize: 20.0,
                                //   iconsColor: ConstantColor
                                //       .loginWithOtpButtonColor,
                                //   iconText: "Sort By",
                                //   iconTextStyle: ConstantTextStyle.allHomeScreenAvatarText,
                                // ),
                                title: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: customeText(
                                      text: hintText,
                                      overflow: TextOverflow.ellipsis,
                                      style: ConstantTextStyle
                                          .allHomeScreenAvatarText,
                                    ),
                                    items: itemsData.map((String itemsData)  {
                                      return
                                        DropdownMenuItem<String>(
                                          value: itemsData.toString(),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                textAlign: TextAlign.start,
                                                itemsData,
                                                style: ConstantTextStyle.allHomeScreenAvatarText,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              if (itemsData.toString() == hintText)
                                                const Icon(
                                                  Icons.check_circle_outline_rounded,
                                                  size: 20,
                                                  color: ConstantColor.primaryMainColor,
                                                ),
                                            ],
                                          ),
                                        );
                                    }).toList(),
                                    onChanged: (String? value) async {
                                      setState(() {
                                        page =1;
                                        if (value != null && value.isNotEmpty) {
                                          selectedValue = transformValue(value);
                                          hintText = value;
                                        }
                                        if(widget.id!=""){
                                          fetchAllProductList(sellerId: widget.sellersId,lat:widget.latitude, long: widget.longitude);}
                                        else{
                                          fetchAllProductList(sellerId: widget.sellersId,lat:"22.7177", long: " 75.8545",);}
                                        productList.clear();
                                      });
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: screenHeight/30,
                                      width: screenWidth/4,
                                      padding:  EdgeInsets.symmetric( horizontal: screenWidth/40),
                                      decoration:  BoxDecoration(
                                          border: Border.all(color: ConstantColor.primaryGreyColor),
                                          borderRadius: BorderRadius.circular(5.0),
                                          color:ConstantColor.primaryBackgroundMainColor
                                      ),
                                      // elevation: 1,
                                    ),
                                    iconStyleData: const IconStyleData(
                                        icon: Icon(Icons.expand_circle_down,size: 20.0,
                                          color: ConstantColor.loginWithOtpButtonColor,)
                                      // icon: Visibility (visible:false, child: Icon(Icons.arrow_downward)),
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: ConstantColor.primaryBackgroundMainColor,
                                      ),
                                      offset: const Offset(-10, -5),
                                      scrollbarTheme: ScrollbarThemeData(
                                        radius: const Radius.circular(40),
                                        thumbColor: MaterialStateProperty.all(ConstantColor.primaryMainColor),
                                        thickness: MaterialStateProperty.all(5),
                                        thumbVisibility: MaterialStateProperty.all(true),
                                      ),
                                    ),
                                    menuItemStyleData:  MenuItemStyleData(
                                      height: screenHeight/25,
                                      padding: EdgeInsets.symmetric(horizontal: screenWidth/40),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const VerticalDivider(
                              color: ConstantColor.GrayLineColor,
                              thickness: 1,
                            ),
                            IconButton(
                              padding:EdgeInsets.zero,
                              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                              icon:  isListIcon ? const Icon(Icons.border_all, color: ConstantColor.loginWithOtpButtonColor,)
                                  : const Icon(Icons.list, color: ConstantColor.loginWithOtpButtonColor,),
                              onPressed: () {
                                setState(() {
                                  isListIcon = !isListIcon;
                                });
                              },
                            ),
                          ],
                        ),
           /*------------------------------filter and sort_by section end-----------------------------*/
                        isListIcon ? productList.isEmpty ?
                            customeText(textAlign: TextAlign.center,
                             text:'No Data Found!')
                            : ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth/40),
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: productList.length,
                          itemBuilder: (BuildContext context, int index) {
                            //*****************************************************************************
                            final productListView = productList[index];
                            double getPercantageOff(
                                double price,
                                double showPrice) {
                              double result = ((price - showPrice) / price) * 100;
                              return result
                                  .floor()
                                  .toDouble();
                            }

                            final double showPrice =
                                double.tryParse(
                                    productListView
                                        .showPrice ??
                                        '0') ??
                                    0.0;
                            final double price =
                                double.tryParse(
                                    productListView.price ??
                                        '0') ??
                                    0.0;
                            //  final int price = productListView.price ?? 0;
                            final double percentageOff =
                            showPrice != 0.0
                                ? getPercantageOff(
                                price
                                    .toDouble(),
                                showPrice)
                                : 0.0;
                            //*****************************************************************************
                            return Column(
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                              children: [
                                Visibility(
                                  visible:
                                  percentageOff > 0,
                                  child: cashBackChip(
                                    context: context,
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        5.0),
                                    text: percentageOff >
                                        0
                                        ? '$percentageOff% OFF'
                                        : "",
                                    style: ConstantTextStyle
                                        .newiconButtonText,
                                    textAlign: TextAlign
                                        .center,
                                    width: screenWidth /
                                        4.0,
                                    // height: screenHeight / 60,
                                    color: percentageOff >
                                        0
                                        ? ConstantColor
                                        .chipColor
                                        : null,
                                  ),
                                ),
                                ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetailScreen(
                                                  proId:
                                                  productList[index].productId ?? "",
                                                  id: widget.id,
                                                  longitude:
                                                  widget.longitude,
                                                  latitude:
                                                  widget.latitude,
                                                  lName:
                                                  widget.lName,
                                                )));
                                  },
                                  // minVerticalPadding: screenHeight/100,
                                  visualDensity: const VisualDensity(
                                      vertical: 4),
                                  contentPadding:
                                  EdgeInsets.zero,
                                  dense: true,
                                  leading:
                                  CachedNetworkImage(
                                    imageUrl:
                                    productListView.productImgUrl ?? "",
                                    height: screenHeight / 8,
                                    width: screenWidth / 5,
                                    fit: BoxFit.contain,
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
                                              5,
                                          fit:
                                          BoxFit.contain,
                                        ),
                                  ),
                                  title: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: [
                                      customeText(
                                        text: productListView
                                            .productName ??
                                            "",
                                        maxLine: 2,
                                        textAlign:
                                        TextAlign
                                            .start,
                                        overflow:
                                        TextOverflow
                                            .ellipsis,
                                        //overflow1: TextOverflow.ellipsis,
                                        style: ConstantTextStyle
                                            .allHomeScreenAvatarText,
                                      ),
                                      SizedBox(
                                        height:
                                        screenHeight /
                                            300,
                                      ),
                                      customRichText(
                                        text1:
                                        "\u{20B9}${productListView.showPrice ?? productListView.price} " ??
                                            "N/A",
                                        style1:
                                        ConstantTextStyle
                                            .richtext1,
                                        TextAlign:
                                        TextAlign
                                            .start,
                                        text2: percentageOff >
                                            0
                                            ? "\u{20B9}${productListView.price} " ??
                                            "N/A"
                                            : " ",
                                        style2:
                                        ConstantTextStyle
                                            .richtext2,
                                      ),
                                      SizedBox(
                                        height:
                                        screenHeight /
                                            300,
                                      ),
                                      // ElevatedButton.icon(
                                      //   onPressed: productList[index].wantToBuy == "1" ? null : () async {
                                      //     SharedPreferences preferences = await SharedPreferences.getInstance();
                                      //     setState(() {
                                      //       isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                                      //       tokenAccess = preferences.getString("access-token");
                                      //     });
                                      //     if (isUserLoggedIn) {
                                      //       await fetchSendEnquiryAPi(
                                      //         mobileNo: productList[index].contactNo??"",
                                      //         prodId: productList[index].productId ?? '',
                                      //         tokenAccess: tokenAccess,
                                      //         wantBuy: "1",
                                      //         index: index,
                                      //       );
                                      //     }
                                      //     else {
                                      //       showDialog(
                                      //         barrierDismissible: false,
                                      //         context: context,
                                      //         builder: (BuildContext context) {
                                      //           return const CheckIsLogin();
                                      //         },
                                      //       );
                                      //     }
                                      //   },
                                      //   icon: const Icon(
                                      //     Icons.content_paste_search,
                                      //     color:  ConstantColor.primaryBackgroundMainColor,
                                      //     size: 18.0,
                                      //   ),
                                      //   label: Text(
                                      //     'Send Enquiry',
                                      //     style: ConstantTextStyle.newiconButtonText,
                                      //   ),
                                      //   style: ElevatedButton.styleFrom(
                                      //     // minimumSize: Size.fromHeight(screenHeight / 25),
                                      //     backgroundColor: productList[index].wantToBuy == "1"
                                      //         ? ConstantColor.primaryGreyColor
                                      //         : ConstantColor.primaryMainColor,
                                      //     shape: RoundedRectangleBorder(
                                      //       borderRadius: BorderRadius.circular(20.0),
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  trailing: Icon(
                                    Icons
                                        .store_outlined,
                                    size: screenHeight /
                                        35,
                                    color: ConstantColor
                                        .loginWithOtpButtonColor,
                                  ),
                                ),
                                Divider(
                                  color: ConstantColor
                                      .locationIconColor,
                                  height:
                                  screenHeight / 40,
                                  thickness: 2,
                                ),
                              ],
                            );
                          },
                        )
                        : productList.isEmpty ?
                        Center(child: customeText(
                            textAlign: TextAlign.center,
                            text:'No Data Found!')
                        ): GridView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          // physics: const NeverScrollableScrollPhysics(),
                          itemCount: productList.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            // childAspectRatio: 1/1.25,
                            childAspectRatio: 1/1.1,
                          ),
                          itemBuilder: (BuildContext context, index) {
                            //*****************************************************************************
                            final productGridView = productList[index];
                            double getPercantageOff(double price, double showPrice) {
                              double result = ((price - showPrice) / price) * 100;
                              return result.floor().toDouble();}
                            final double showPrice = double.tryParse(productGridView.showPrice ?? '0') ?? 0.0;
                            final double price = double.tryParse(productGridView.price ?? '0') ?? 0.0;
                            //  final int price = productListView.price ?? 0;
                            final double percentageOff = showPrice != 0.0 ? getPercantageOff(price.toDouble(), showPrice) : 0.0;
                            final roundedPercentageOff = percentageOff.toStringAsFixed(0);
                            //*****************************************************************************
                            return Card(
                              elevation: 1,
                              color: ConstantColor.primaryBackgroundMainColor,
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
                                      text:percentageOff> 0 ? '$roundedPercentageOff% OFF' : "",
                                      style: ConstantTextStyle.newiconButtonText,
                                      textAlign: TextAlign.center,
                                      color: percentageOff> 0 ? ConstantColor.chipColor : null,),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  ProductDetailScreen(
                                          proId: productList[index].productId??"", id: widget.id, longitude: widget.longitude, latitude: widget.latitude, lName: widget.lName,

                                        )));
                                      },
                                      child:CachedNetworkImage(
                                        imageUrl: productGridView.productImgUrl?? "",
                                        width: screenWidth,
                                        height: screenHeight / 7,
                                        fit: BoxFit.contain,
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                              ConstantImage.imageIsNotAvailable,
                                              width: screenWidth,
                                              height: screenHeight / 7,
                                              fit: BoxFit.fill,
                                            ),
                                      ),
                                    ),
                                    SizedBox(height: screenHeight/100,),
                                    customeText(
                                      text: productGridView.productName?? "",
                                      overflow: TextOverflow.ellipsis,
                                      style: ConstantTextStyle.allHomeScreenAvatarText,),
                                    SizedBox(height: screenHeight/200,),
                                    Flexible(
                                      child: customRichText(
                                        text1: "\u{20B9}${productGridView.showPrice ?? productGridView.price} "?? "N/A",
                                        style1: ConstantTextStyle.richtext1,
                                        TextAlign: TextAlign.start,
                                        text2:percentageOff> 0 ? "\u{20B9}${productGridView.price} "?? "N/A" : " ",
                                        style2: ConstantTextStyle.richtext2, ),
                                    ),
                                    SizedBox(height: screenHeight/200,),
                                    // Flexible(
                                    //   child: ElevatedButton.icon(
                                    //     onPressed: productList[index].wantToBuy == "1" ? null : () async {
                                    //       SharedPreferences preferences = await SharedPreferences.getInstance();
                                    //       setState(() {
                                    //         isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                                    //         tokenAccess = preferences.getString("access-token");
                                    //       });
                                    //       if (isUserLoggedIn) {
                                    //         await fetchSendEnquiryAPi(
                                    //           mobileNo: productList[index].contactNo??"",
                                    //           prodId: productList[index].productId ?? '',
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
                                    //       backgroundColor: productList[index].wantToBuy == "1"
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
/*----------------------listview builder end -------------------------------*/
                      ],
                    ),
                  ),
                ),
                //     :  Center(child: customeText(
                //     textAlign: TextAlign.center,
                //     text:'No Data Found!')
                // ),
          /*-----------------------------------Product cards end------------------------------------*/


           /*-----------------------------------Reals Screen Section end------------------------------------*/
                StoreReelScreen(SellerIds: widget.sellersId.toString()??'',
                  id: widget.id,
                  newSellerId: userUniSellerId??"",
                  latitude: widget.latitude,
                  longitude:widget.longitude,
                  lName: widget.lName,),
          /*-----------------------------------Reals Screen Section end------------------------------------*/
                // Text("Page 3")
              ],
            ),
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth / 40,
                    vertical: screenHeight / 200,
                ),
                sliver: SliverToBoxAdapter(
                  child:
                  Container(
                    color: ConstantColor.bottonNavIcons,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      /*----------------------------------------------------------------------------*/
                          isLoading? const SpinKitCircle(
                              color: ConstantColor.primaryMainColor,
                              size: 30.0):   sellerStoreDetails==null?const Text("")
                              :
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: CachedNetworkImage(
                                  imageUrl: sellerStoreDetails!.data!.sellerDetails!.storeImageUrl ?? "",
                                  height: screenHeight/7,
                                  width: screenWidth/3,
                                  fit: BoxFit.fill,
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                        ConstantImage.imageIsNotAvailable,
                                        height: screenHeight/7,
                                        width: screenWidth/3,
                                        fit: BoxFit.fill,
                                      ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: screenWidth / 40),
                                child:
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /*-----------------------Store name section start------------------*/
                                    headingWithIcon(
                                      textWidth: screenWidth / 2.0,
                                      overflow: TextOverflow.ellipsis,
                                      text: sellerStoreDetails!.data!.sellerDetails!.storeName ?? "Store Name",
                                      textStyle: ConstantTextStyle.lableTextHeading1,
                                      icon: Icons.call_outlined,
                                      onTap: () async {
                                        SharedPreferences preferences = await SharedPreferences.getInstance();
                                        setState(() {
                                          isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                                          tokenAccess = preferences.getString("access-token");
                                        });
                                        if (isUserLoggedIn) {
                                          String phoneNumber = sellerStoreDetails?.data?.sellerDetails?.contactNo ?? "";
                                          if (phoneNumber.isNotEmpty) {
                                            _launchPhoneCall(phoneNumber);
                                          } else {
                                            // Handle case when phone number is empty
                                          }
                                          await storePageKpiApiServices(type: "phone_request", sellerId: widget.sellersId.toString());
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
                                      iconColor: ConstantColor.primaryMainColor,
                                      iconSize: 18.0,
                                    ),
                                    /*-----------------------Store name section end------------------*/
                                    SizedBox(
                                      height: screenHeight / 200,
                                    ),
                                    /*-----------------------Store Address section start------------------*/
                                    InkWell(
                                      onTap: () async {
                                        var doubleValueLatitude = double.tryParse(sellerStoreDetails!.data!.sellerDetails!.storeLatitude.toString());
                                        var doubleValueLongitude = double.tryParse(sellerStoreDetails!.data!.sellerDetails!.storeLongitude.toString());
                                        await openMap(doubleValueLatitude!, doubleValueLongitude!);
                                        await storePageKpiApiServices(type: "location", sellerId: widget.sellersId.toString());
                                      },
                                      child: headingWithIcon(
                                        text: sellerStoreDetails!.data!.sellerDetails!.storeAddress ?? "Store Address",
                                        textWidth: screenWidth / 2.0,
                                        maxLine: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textStyle: ConstantTextStyle.storeDetailsText2,
                                        icon: Icons.pin_drop_outlined,
                                        iconColor: ConstantColor.primaryMainColor,
                                        iconSize: 20.0,
                                      ),
                                    ),


                                    startRating(
                                      height: screenHeight / 30,
                                      context: context,
                                      color: ConstantColor.transparent1,
                                      text2: "${double.parse(sellerStoreDetails!.data!.sellerDetails!.avgRating ?? "0").toStringAsFixed(1)}/5.0",
                                      style2: ConstantTextStyle.allHomeScreenAvatarText,
                                      initialRating:double.parse(sellerStoreDetails!.data!.sellerDetails!.avgRating ?? "0"),
                                      itemSize: 14.0,
                                      minRating: 1.0,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      onRatingUpdate: (rating) {},
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: ConstantColor.starRatingColor,
                                      ),
                                    ),

                                    /*-----------------------Store StartRating section start------------------*/
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        minimumSize:
                                        MaterialStateProperty.all<Size>(Size(0, screenHeight / 40)),
                                        backgroundColor: MaterialStateProperty.all<Color>(ConstantColor.primaryMainColor),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8.0),),
                                        ),
                                      ),
                                      onPressed: () async{
                                        SharedPreferences preferences = await SharedPreferences.getInstance();
                                        setState(() {
                                          isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                                          tokenAccess = preferences.getString("access-token");
                                        });
                                        if (isUserLoggedIn){
                                        var followValue = sellerStoreDetails!.data!.followVal;
                                        if (sellerStoreDetails!.data!.followVal == "0") {
                                          fetchFollowUnFollow(
                                              sIds: widget.sellersId,
                                              follow_val: "1");
                                        }
                                        else {
                                          fetchFollowUnFollow(
                                              sIds: widget.sellersId,
                                              follow_val: "0");
                                        }
                                        setState(() {
                                          isFollowing = !isFollowing;
                                        }); }
                                        else{
                                          showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return const CheckIsLogin();
                                            },
                                          );
                                        }
                                      },
                                      child: isFollowing
                                          ? Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        mainAxisSize:
                                        MainAxisSize.min,
                                        children: [
                                          sellerStoreDetails!.data!
                                              .followVal ==
                                              "0"
                                              ? Text("Following",
                                              style: ConstantTextStyle
                                                  .reviewsRatingsText)
                                              : Text("Follow",
                                              style: ConstantTextStyle
                                                  .reviewsRatingsText),
                                          SizedBox(width: screenWidth / 100),
                                          sellerStoreDetails!.data!.followVal == "1"
                                              ? const Icon(
                                            Icons.add_circle_outline,
                                            color: ConstantColor.primaryBackgroundMainColor,
                                            size: 15.0,
                                          )
                                              :const Icon(
                                            Icons.check_circle_outline,
                                            color: ConstantColor.primaryBackgroundMainColor,
                                            size: 15.0,
                                          )
                                          // const Text(""),
                                        ],
                                      )
                                          : Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        mainAxisSize:
                                        MainAxisSize.min,
                                        children: [
                                          sellerStoreDetails!.data!
                                              .followVal ==
                                              "1"
                                              ? Text("Following",
                                              style: ConstantTextStyle
                                                  .reviewsRatingsText)
                                              : Text("Follow",
                                              style: ConstantTextStyle
                                                  .reviewsRatingsText),
                                          SizedBox(
                                              width:
                                              screenWidth / 100),
                                          sellerStoreDetails!.data!
                                              .followVal ==
                                              "0"
                                              ? const Icon(
                                            Icons.add_circle_outline,
                                            color: ConstantColor.primaryBackgroundMainColor,
                                            size: 15.0,
                                          )
                                              : const Icon(
                                            Icons.check_circle_outline,
                                            color: ConstantColor.primaryBackgroundMainColor,
                                            size: 15.0,
                                          )
                                          //const Text(""),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                            /*-----------------------Store StartRating section end------------------*/ // Space between store details

                              ),
                            ],
                          ),
                                            ],
                                          ),
                    )
                ),
              ),
              SliverAppBar(
                backgroundColor: ConstantColor.primaryBackgroundMainColor,
                pinned: true,
                elevation: 12.0,
                leading: Container(),
                titleSpacing: 0.0,
                toolbarHeight: 0.0,
                bottom: TabBar(
                    controller: _tabController,
                    indicatorWeight: 2,
                    labelStyle: ConstantTextStyle.topCategoryText2,
                    labelColor: ConstantColor.filedContainerColor,
                    unselectedLabelColor:   ConstantColor.loginWithOtpButtonColor,
                    indicatorColor: ConstantColor.filedContainerColor,
                    tabs: const [
                      Tab(
                        text: 'About us',
                      ),
                      Tab(
                        text: 'Products',
                      ),
                      Tab(
                        text: 'Reels',
                      ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

