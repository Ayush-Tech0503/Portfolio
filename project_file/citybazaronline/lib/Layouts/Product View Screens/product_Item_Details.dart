// ignore_for_file: depend_on_referenced_packages, prefer_typing_uninitialized_variables, empty_catches, unrelated_type_equality_checks, non_constant_identifier_names, deprecated_member_use, use_build_context_synchronously, must_be_immutable

import 'dart:convert';
import 'dart:io';
import 'package:Citybazar_app/Api%20Services/Card%20Api%20Services/add_to_card_api_services.dart';
import 'package:Citybazar_app/Layouts/Card%20Details%20Screen/card_checkout_screen.dart';
import 'package:Citybazar_app/Widgets/custome_icon_button.dart';
import 'package:Citybazar_app/Widgets/custome_text.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:html/parser.dart' show parse;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Api Services/Card Api Services/get_card_product_count.dart';
import '../../Models/Product details Models/product_details_model.dart';
import '../../Util/Const Toster/toster.dart';
import '../../Util/Constant APi Url/api_urls.dart';
import '../../Util/constaint_textstyle.dart';
import '../../Util/constant_color.dart';
import '../../Util/constant_image.dart';
import '../../Widgets/Login Check Widget/login_check_widget.dart';
import '../../Widgets/Product Deatails CarouselSilder2/product_details_carousel_slider2.dart';
import '../../Widgets/Send Enquiry dialogBox/alert_dialog_box.dart';
import '../../Widgets/arrow_button.dart';
import '../../Widgets/collection_card.dart';
import '../../Widgets/custome_richtext.dart';
import '../../Widgets/landing_screen_slider.dart';
import '../../Widgets/product_list.dart';
import '../../services/KPI Api Service /product_kpi_api_services.dart';
import '../Card Details Screen/card_details_screen.dart';
import '../Famous Market/Store Details/Store Details Screen/store_details.dart';
import '../Famous Market/Store Details/User Store BottomNav Bar/user_bottom_navigation_bar.dart';

class ProductDetailScreen extends StatefulWidget {
  final proId;
  final img_group_id;
  final attribute_list;

  String id;
  String latitude;
  String longitude;
  String lName;
  // final groupImg;
  ProductDetailScreen(
      {super.key,
      this.proId,
      this.img_group_id,
      this.attribute_list,
      required this.id,
      required this.longitude,
      required this.latitude,
      required this.lName});
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
/*------------------------------------------*/
  var tokenAccess;
  final ScrollController _scrollController = ScrollController();
  final ScrollController topScrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    topScrollController.dispose();
    super.dispose();
  }

  bool leftIconBGColor = false;
  bool rightIconBGColor = false;
  bool topRightIconBGColor = false;
  /*------------------------------scrollList controller start-----------------------------------------*/
  final double _scrollAmount = 500.0;
  void scrollListRightSide() {
    _scrollController.animateTo(
      _scrollController.offset + _scrollAmount,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  /*----------------------------------------------------*/
  void scrollTopListRightSide() {
    topScrollController.animateTo(
      topScrollController.offset + _scrollAmount,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  /*----------------------------------------------------*/
  void scrollListLeftSide() {
    _scrollController.animateTo(
      _scrollController.offset - _scrollAmount,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
/*---------------------------------scrollList controller end-------------------------------------------*/
/*------------------------------------------*/

  // String descText = "";
  bool descTextShowFlag = false;
  bool descTextShowFlag2 = false;
  int _currentIndex = 0;
  var userId;
  var createdById;
  get navigationChatWithSellerButton => null;

/*---------------------------------Api Data Start ----------------------------------*/
var wantToBuyGlobal = '';
var contactSellerGlobal = '';
  //********************************************************

  dynamic is_cart ='';
  ProductDetailsField? productDetailsItem1;
  List<Details> productDetailsDataList = [];
  List<Color> productColorList = [];
  List<SizeData> productSizeList = [];
  List<SimilarProduct> similarProducts = [];
  List<AttributeList> productDetailsAttributeList = [];

  bool isLoading = false;

  fetchProductData({pid, lat, long}) async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      tokenAccess = preference.getString("access-token");

      setState(() {
        isLoading = true;
      });

      final body = {
        "pid": pid,
        "user_id": userId,
        "clone_id": "",
        "lat": lat,
        "long": long,
      };
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.productDetailsEndPoint}",
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
        productDetailsItem1 = ProductDetailsField.fromJson(responseData);
        wantToBuyGlobal = productDetailsItem1!.wantToBuy??'';
        is_cart= productDetailsItem1!.is_cart??'';
        contactSellerGlobal = productDetailsItem1!.contactNo??'';
        if (productDetailsItem1?.productDetails != null) {
          productDetailsDataList.addAll(productDetailsItem1!.productDetails!.details ?? []);
          productDetailsAttributeList.addAll(productDetailsItem1!.attributeList ?? []);
          similarProducts.addAll(productDetailsItem1!.similarProduct ?? []);
          productColorList.addAll(productDetailsItem1!.productDetails!.variantList?.color ?? []);
          productSizeList.addAll(productDetailsItem1!.productDetails!.variantList?.size ?? []);
          createdById = productDetailsDataList[0].createdBy ?? "";
        }

        setState(() {
          isLoading = false;
        });
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
          // print("Server error:----------- ${error.response?.statusCode}");
        } else {
          // print("Dio error: ${error.message}");
        }
      } else {}
      setState(() {
        isLoading = false;
      });
    }
  }

//********************************************************
  bool isLoadingEnquiryWish = false;
  fetchSendEnquiryAPi({prodId,wantBuy,index,tokenAccess}) async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      tokenAccess = preference.getString("access-token");
      setState(() {
        isLoadingEnquiryWish = true;
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
          similarProducts[index].wantToBuy = '1';
          productDetailsItem1!.wantToBuy = '1';
          isLoadingEnquiryWish = false;
          var  sellerNumber = productDetailsItem1!.contactNo??"";
          var  sellerWhatsapp = similarProducts[index].shareLink??"";
          String phoneWhatsappText1 = sellerWhatsapp!.replaceAll("api.", "");
          String phoneWhatsappText2 = phoneWhatsappText1.replaceAll(".lab101.cloud", ".com");
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
                  if (sellerNumber!.isNotEmpty && sellerNumber!= "" && sellerNumber!= null ) {
                    _launchWhatsApp(sellerNumber??'', phoneWhatsappText2??"");
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
          isLoadingEnquiryWish = false;
        });
      }
    } catch (error) {
      setState(() {
        isLoadingEnquiryWish = false;
      });
    }
  }

//********************************************************
  bool isWishlistSelected = false;
  bool isLoadingWish = false;
  fetchAddToWishlist({pid, wishVal,tokenAccess}) async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      setState(() {
        isLoadingWish = true;

      });
      final body = {
        "user_id": userId,
        "product_id": pid,
        "like_val": wishVal
      };
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.getUserLikedProductApi}",
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
          isLoadingWish = false;
          LoadingScaffoldMessage.showSnackbar(
            context,
            responseData['msg'],
            ConstantColor.primaryMainColor,
            const Duration(seconds: 1),
          );
        });
      } else {
        isLoadingWish = false;
        // Handle the error case
      }
      setState(() {});
    } catch (error) {
      setState(() {
        isLoadingWish = false;
      });
    }
  }

/*----------------------------------Api data End-------------------------------*/
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

/*----------------------------------inIt State-------------------------------*/
  bool isUserLoggedIn = false;
  bool apiCalled = false;
  
  @override
  void initState() {
    super.initState();
    if (widget.id != "") {
      fetchProductData(pid: widget.proId, lat: widget.latitude, long: widget.longitude);
    } else {
      fetchProductData(pid: widget.proId, lat: 22.6903994, long: 75.8657262);
    }
    productPageKpiApiServices(type: "visit_product", productId:widget.proId.toString());
    // fetchProductKpiApi(type: "visit_product", productId:widget.proId.toString());
  }


  Future<void> fetchProductKpiApi({type, productId}) async {await productPageKpiApiServices(type: type.toString(), productId: productId.toString());}
/*-----------------------------------------------------------------*/
  // bool isWishListKey = false;
  int _selectedImageIndex = 0;
/*-----------------------------------------------------------------*/
  int visibleItemCount = 0;
  bool showAll = false;
/*-----------------------------------------------------------------*/
  void _showImageCarousel(List<String> images) {
    // int _selectedImageIndex = 0;
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
                    imageProvider: NetworkImage(
                      productDetailsDataList?[_selectedImageIndex]?.productImgUrl ?? "",
                    ),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 2,
                  );
                },
                scrollPhysics: const BouncingScrollPhysics(),
                backgroundDecoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                pageController:
                    PageController(initialPage: _selectedImageIndex),
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                    _selectedImageIndex = index;
                  });
                },
              ),
            ),
            //      SizedBox (height: screenHeight/100),
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

/*-----------------------------------------------------------------*/
  String convertHtmlToPlainText(String htmlString) {
    final document = parse(htmlString);
    String parsedString = parse(document.body!.text).documentElement!.text;
    return parsedString;
  }
/*-----------------------------------------------------------------*/
  //------------------------------------------

  shareFile() async {
    String originalUrl = "${productDetailsItem1!.shareLink}";
   String modifiedUrl = originalUrl.replaceAll("api.", "");
   String modifiedUrl2 = modifiedUrl.replaceAll(".lab101.cloud", ".com");
    if (productDetailsDataList != null && productDetailsDataList!.isNotEmpty)
    {
      String networkImageUrl = productDetailsDataList![0]!.productImgUrl??ConstantImage.cityBazaarShareApp??"";
      HttpClient client = HttpClient();
      final Uri uri = Uri.parse(networkImageUrl);
      HttpClientRequest request = await client.getUrl(uri);
      HttpClientResponse response = await request.close();
      List<int> imageBytes = await consolidateHttpClientResponseBytes(response);
      // Save network image to temporary directory
      final temp = await getTemporaryDirectory();
      final path = '${temp.path}/image1.jpg';
      File(path).writeAsBytesSync(imageBytes);
      // Share the network image along with text
      //productDetailsItem1!.shareLink ="https://citybazaronline.com"
      // await Share.shareFiles([path], text: productDetailsItem1!.shareLink??"" );
      await Share.shareFiles([path], text: modifiedUrl2??"" );
      await productPageKpiApiServices(type: "product_share", productId:widget.proId.toString());
    } else {
      LoadingScaffoldMessage.showSnackbar(
        context,
        "No Product Link Available!",
        ConstantColor.primaryMainColor,
        const Duration(seconds: 1),
      );
    }
  }

//------------------------------------------
  ProductCount? productCount;
  Future<void> fetchProductCount() async {
    setState(() {
      isLoading = true; // Set loading state
    });

    try {
      final productCountResponse = await CardProductCountApiService.cardProductCountData(context: context);

      setState(() {
        isLoading = false; // Reset loading state
        productCount = productCountResponse; // Update productCount with API response
      });
    } catch (e) {
      setState(() {
        isLoading = false; // Reset loading state on error
      });
      print('Error fetching product count: $e');
    }
  }
//------------------------------------------
  bool addCardCheck = false;
//------------------------------------------

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: ConstantColor.loginWithOtpButtonColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: ConstantColor.primaryBackgroundMainColor,
          appBar: AppBar(
            leading:IconButton(
              icon: const Icon(Icons.arrow_back,color: ConstantColor.primaryBackgroundMainColor,),
              onPressed: ()=> Navigator.pop(context),
            ),
            iconTheme: const IconThemeData(
              color: ConstantColor.primaryBackgroundMainColor
            ),
            backgroundColor: ConstantColor.loginWithOtpButtonColor,
            elevation: 0.0,
            centerTitle: true,
            title: productDetailsDataList.isNotEmpty
                ? customeText(
                  text: productDetailsDataList[0].productName ?? "",
                  style: ConstantTextStyle.topCategoryText3,
                  overflow: TextOverflow.ellipsis,
                )
                : customeText(
                text: "Activity",
                style: ConstantTextStyle.topCategoryText3,
                overflow: TextOverflow.ellipsis,
                                    ),
            titleSpacing: 0.0,
            actions: [
            IconButton(
              onPressed: (){
                shareFile();
                },
              icon: const Icon(
                FontAwesomeIcons.share,
                color: ConstantColor.primaryBackgroundMainColor,
                size: 20.0
              ),
            ),
            ],
          ),
        /*---------------------------------------------------------------------*/
        /*------------------------------bottomNavigationBar Button Start-----------------------------------*/
          bottomNavigationBar: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth/40.0),
                child: iconTextButton(
                  backgroundColor: ConstantColor.filedContainerColor,
                  icon: Icons.message_sharp,
                  iconColor: ConstantColor.primaryBackgroundMainColor,
                  iconSize: 20.0,
                  buttonOnPressed: () async {
                    SharedPreferences preferences = await SharedPreferences.getInstance();
                    setState(() {
                      isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                      tokenAccess = preferences.getString("access-token");
                    });
                    if (isUserLoggedIn) {
                      await productPageKpiApiServices(type: "chat_with_seller", productId:widget.proId.toString(),);
                      String? phoneWhatsappNo = contactSellerGlobal??"";
                      String? phoneWhatsappText = productDetailsItem1?.whatsapptext??"";
                      String phoneWhatsappText1 = phoneWhatsappText!.replaceAll("api.", "");
                      String phoneWhatsappText2 = phoneWhatsappText1.replaceAll(".lab101.cloud", ".com");
                      if (phoneWhatsappNo != null && phoneWhatsappNo.isNotEmpty) {
                        _launchWhatsApp(phoneWhatsappNo, phoneWhatsappText2);
                      }
                      setState(() {
                        apiCalled = true; // Set the flag to true after the API call
                      });
                    }
                    else {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return const CheckIsLogin();
                        },
                      );
                    }
                  },
                  fixedSize:  Size(screenWidth, 1),
                  buttontext: "Chat With Seller",
                  buttontextStyle: ConstantTextStyle.newiconButtonText,
                  //  fixedSize: const Size(190, 1),
                ),
              ),
               (is_cart == '1') ?
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth/30.0),
                  child: iconTextButton(
                    backgroundColor: ConstantColor.loginWithOtpButtonColor,
                    icon: Icons.shopping_cart_outlined,
                    iconColor: ConstantColor.primaryBackgroundMainColor,
                    iconSize: 20.0,
                    buttonOnPressed: () =>
                        Navigator.push(context, MaterialPageRoute(
                        builder: (_) => CardDetailsScreen(
                          id: widget.id,
                          longitude: widget.longitude,
                          lattude: widget.latitude,
                          lName: widget.lName,
                        ))),
                    fixedSize:  Size(screenWidth, 1),
                    buttontext: "Go To Cart",
                    buttontextStyle: ConstantTextStyle.newiconButtonText,
                    //  fixedSize: const Size(190, 1),
                  ),
                )
              : addToCardButtonsWidget(
                  context: context,
                  addToCardButtonOnPressed: () async {
                    SharedPreferences preferences = await SharedPreferences.getInstance();
                    setState(() {
                      isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                      tokenAccess = preferences.getString("access-token");
                    });
                    if (isUserLoggedIn) {
                      await CardAddApiService.fetchCardAddData(
                        context: context,productId: widget.proId??"",quantity: '1',
                        onSuccess: (){
                          isLoading = true;
                          productDetailsDataList.clear();
                          productColorList.clear();
                          productSizeList.clear();
                          similarProducts.clear();
                          productDetailsAttributeList.clear();
                          if (widget.id != "") {
                            fetchProductData(pid: widget.proId, lat: widget.latitude, long: widget.longitude);
                          } else {
                            fetchProductData(pid: widget.proId, lat: 22.6903994, long: 75.8657262);
                          }
                          fetchProductCount();
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
                  navigationBuyWithSellerButton: () async {
                    SharedPreferences preferences = await SharedPreferences.getInstance();
                    setState(() {
                      isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                      tokenAccess = preferences.getString("access-token");
                    });
                    if (isUserLoggedIn) {
                      CardAddApiService.fetchCardAddData(
                        context: context,productId: widget.proId??"",quantity: '1',
                        onSuccess: () {
                          isLoading = true;
                          productDetailsDataList.clear();
                          productColorList.clear();
                          productSizeList.clear();
                          similarProducts.clear();
                          productDetailsAttributeList.clear();
                          if (widget.id != "") {
                            fetchProductData(pid: widget.proId, lat: widget.latitude, long: widget.longitude);
                          } else {
                            fetchProductData(pid: widget.proId, lat: 22.6903994, long: 75.8657262);
                          }
                          fetchProductCount();
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => CardCheckoutDetailsScreen(
                              sellerId: createdById??"",
                              id: widget.id,
                              longitude: widget.longitude,
                              lattude: widget.latitude,
                              lName: widget.lName,
                            )),
                          );
                        },
                      );
                    } else{
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return const CheckIsLogin();
                        },
                      );
                    }
                  },

                ),
            ],
          ),
        /*------------------------------bottomNavigationBar Button end-----------------------------------*/
        /*---------------------------------------------------------------------*/
          extendBody: true,
          body: isLoading
              ? const SpinKitCircle(
                  color: ConstantColor.primaryMainColor,
                  size: 30.0,
                )
              : productDetailsDataList.isNotEmpty ?
          Container(
                      color: ConstantColor.bottonNavIcons,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth / 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: screenHeight/80,),
        /*----------------------------Product Scrolling Image and icons start-----------------------------*/
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _showImageCarousel(productDetailsDataList.map((image) =>
                                            productDetailsDataList[_selectedImageIndex]?.productImgUrl ??
                                            "")
                                        .toList());
                                    _selectedImageIndex = _currentIndex;
                                  });
                                },
                                child: productDetailsCarouselSlider2(
                                  // carouselHeight: screenHeight/4,
                                  context: context,
                                  autoPlay: true,
                                  carouselSliderOnPageChange:
                                      (index, reason) {
                                    setState(() {
                                      _currentIndex = index;
                                      _selectedImageIndex = index;
                                    });
                                  },
                                  items: productDetailsDataList!.map((image) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return CachedNetworkImage(
                                          imageUrl: productDetailsDataList?[
                                                      _selectedImageIndex]
                                                  ?.productImgUrl ??
                                              "",
                                          fit: BoxFit.fill,
                                          errorWidget:
                                              (context, url, error) =>
                                                  Image.asset(
                                            ConstantImage.imageIsNotAvailable,
                                            fit: BoxFit.fill,
                                          ),
                                        );
                                      },
                                    );
                                  }).toList(),
                                  /////////////////////////////////////////////////////////

                                  favoriteIcon: productDetailsItem1!.liked == "1"
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_border_rounded,
                                  favoriteIconSize: 30.0,
                                  leftPositionedFavoriteIcon: screenWidth / 1.2,
                                  favoriteIconColor: productDetailsItem1!.liked == "1"
                                      ? ConstantColor.primaryMainColor
                                      : ConstantColor.primaryBlackColor,
                                  favoriteIconOnTap: () async {
                                    SharedPreferences preferences = await SharedPreferences.getInstance();
                                    setState(() {
                                       isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                                       tokenAccess = preferences.getString("access-token");
                                    });
                                    if (!isUserLoggedIn) {
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const CheckIsLogin();
                                        },
                                      );
                                    } else {
                                      setState(() {
                                        productDetailsItem1!.liked = (productDetailsItem1!.liked == "1") ? "0" : "1";
                                      });
                                      await fetchAddToWishlist(
                                          tokenAccess : tokenAccess??"",
                                          pid: widget.proId ?? '',
                                          wishVal: productDetailsItem1!.liked ?? '');
                                    }
                                  },

                                ),
                              ),
        /*--------------------Carolus_slider scrolling dots start ------------------------------*/
                              SizedBox(height: screenHeight / 100),
                              Center(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children:
                                        productDetailsDataList!.map((image) {
                                      int index = productDetailsDataList
                                          .indexOf(image);
                                      return slidingDots2(
                                        slidingDotsColor: _currentIndex ==
                                                index
                                            ? ConstantColor.primaryMainColor
                                            : ConstantColor.carColor2,
                                        slidingDotsMargin:
                                            const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),

        /*--------------------Carolus_slider scrolling dots end ------------------------------*/
        /*-------------------Product Scrolling Image and icons end-----------------*/
        /*------------------------------Scrolling cards start-----------------------------*/
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: screenHeight / 50),
                                width: screenWidth,
                                height: screenHeight / 8,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: screenWidth / 1.2,
                                      child: ListView.builder(
                                        controller: topScrollController,
                                        itemCount:
                                            productDetailsDataList.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          final detailsProductsHere =
                                              productDetailsDataList?[index];
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _currentIndex = index;
                                                _selectedImageIndex = index;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                vertical: screenHeight / 100,
                                                horizontal: screenWidth / 60,
                                              ),
                                              margin: EdgeInsets.only(
                                                  right: screenWidth / 30),
                                              width: screenWidth / 6,
                                              height: screenHeight / 20,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: ConstantColor
                                                      .primaryMainColor,
                                                  width: 0.5,
                                                ),
                                                color: ConstantColor
                                                    .bottonNavIcons,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        5.0),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl: detailsProductsHere?.productImgUrl ??
                                                    "",
                                                fit: BoxFit.contain,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Image.asset(
                                                  ConstantImage
                                                      .imageIsNotAvailable,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    arrowButons(
                                      onTap: () {
                                        setState(() {
                                          topRightIconBGColor =
                                              !topRightIconBGColor;
                                        });
                                        Future.delayed(
                                            const Duration(milliseconds: 300),
                                            () {
                                          setState(() {
                                            topRightIconBGColor =
                                                !topRightIconBGColor;
                                          });
                                        });
                                        scrollTopListRightSide();
                                      },
                                      radius: 15.0,
                                      backgroundColor: topRightIconBGColor
                                          ? ConstantColor.primaryMainColor
                                          : ConstantColor.searchBoxColor,
                                      icon: Icons.arrow_forward_ios_rounded,
                                      iconSize: 20.0,
                                      color: topRightIconBGColor
                                          ? ConstantColor.searchBoxColor
                                          : ConstantColor.primaryMainColor,
                                    ),
                                  ],
                                ),
                              ),
        /*------------------------------Scrolling cards end-----------------------------*/
                              SizedBox(
                                height: screenHeight / 100,
                              ),
        /*-----------------------------------product Text Start------------------------------------*/
                              Text(
                                productDetailsDataList[0].productName ?? "",
                                textAlign: TextAlign.justify,
                                style: ConstantTextStyle.cardbottumText,
                                overflow: TextOverflow.ellipsis,
                              ),
        /*-----------------------------------product Text end------------------------------------*/
                              SizedBox(
                                height: screenHeight / 100,
                              ),
        /*-----------------------------------Amount rupee ans discount chip start------------------------------------*/
                              Builder(
                                builder: (BuildContext context) {
                                  double screenWidth = MediaQuery.of(context).size.width;
                                  // discount Logic is here
                                  double getPercantageOff(
                                      double price, double offerPrice) {
                                    if (price == 0.0) {
                                      return 0.0;
                                    }
                                    double result =
                                        ((price - offerPrice) / price) * 100;
                                    return result.isFinite
                                        ? result.floor().toDouble()
                                        : 0.0;
                                  }

                                  var productPriceDiscount =
                                      productDetailsDataList[0];
                                  final offerPrice = double.tryParse(
                                          productPriceDiscount.offerPrice ??
                                              '0') ??
                                      0.0;
                                  final price = double.tryParse(
                                          productPriceDiscount.price ??
                                              '0') ??
                                      0.0;
                                  final percentageOff = offerPrice != 0.0
                                      ? getPercantageOff(price, offerPrice)
                                      : 0.0;
                                  final roundedPercentageOff =
                                      percentageOff.toStringAsFixed(0);

                                  return Row(
                                    children: [
                                      Flexible(
                                        child: customRichText(
                                          text1:
                                              "\u{20B9}${productPriceDiscount.offerPrice ?? productPriceDiscount.price} " ??
                                                  "N/A",
                                          style1: ConstantTextStyle
                                              .topCategoryText2,
                                          TextAlign: TextAlign.start,
                                          style2: ConstantTextStyle.richtext2,
                                          text2: percentageOff > 0
                                              ? NumberFormat.simpleCurrency(
                                                      locale: "hi-NI",
                                                      decimalDigits: 2)
                                                  .format(double.parse(
                                                      productPriceDiscount
                                                              .price ??
                                                          ''))
                                              : " ",
                                        ),
                                      ),
                                      SizedBox(width: screenWidth / 80),
                                      Flexible(
                                        child: cashBackChip(
                                          context: context,
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          text: percentageOff > 0
                                              ? 'Save $roundedPercentageOff %'
                                              : "",
                                          style: ConstantTextStyle
                                              .newiconButtonText,
                                          textAlign: TextAlign.start,
                                          padding: EdgeInsets.symmetric(
                                            vertical: screenWidth / 200,
                                          ),
                                          color: percentageOff > 0
                                              ? ConstantColor.chipColor
                                              : null,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
        /*-----------------------------------Amount rupee ans discount chip end------------------------------------*/
        /*-----------------------------------Sold by section start------------------------------------*/
                              ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            StoreDetailScreen(
                                              sellersId: productDetailsDataList?[0].sellerId,
                                              id: widget.id,
                                              longitude: widget.longitude,
                                              latitude: widget.latitude,
                                              lName: widget.lName,
                                            )),
                                  );
                                },
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                leading: Card(
                                  color: ConstantColor.primaryMainColor,
                                  child: customeIconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => StoreDetailScreen(
                                                    sellersId: productDetailsDataList?[0].sellerId,
                                                    id: widget.id,
                                                    longitude: widget.longitude,
                                                    latitude: widget.latitude,
                                                    lName: widget.lName,
                                                  )),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.storefront,
                                        size: 25.0,
                                        color: ConstantColor
                                            .primaryBackgroundMainColor,
                                      )),
                                ),
                                title: customeText(
                                  text:
                                      productDetailsDataList?[0].storeName ??
                                          "",
                                  style: ConstantTextStyle.proDetailBlueText,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                ),
                              ),
        /*-----------------------------------Sold by section end------------------------------------*/
                              SizedBox(
                                height: screenHeight / 80,
                              ),
        /*-----------------------------------Product Color category start------------------------------------*/
                              productColorList.isEmpty ? const SizedBox() : customeText(
                                text: "Colors",
                                style: ConstantTextStyle.colorsHeadingText,
                                textAlign: TextAlign.start,
                              ),
                              productColorList.isEmpty ? const SizedBox() :  SizedBox(height: screenHeight / 100,),
                              Wrap(
                                spacing: screenWidth / 50,
                                children:
                                    productColorList!.map((produtsColors) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (widget.id != "" && produtsColors.productId != null) {
                                          fetchProductData(pid: produtsColors.productId, lat: widget.latitude, long: widget.longitude);
                                        } else {
                                          fetchProductData(pid: produtsColors.productId, lat: 22.6903994, long: 75.8657262);
                                        }
                                      });
                                      productDetailsDataList.clear();
                                      productDetailsAttributeList.clear();
                                       productColorList.clear();
                                      productSizeList.clear();
                                    },
                                    child: Card(
                                      child: Column(
                                        children: [
                                          Image.network(
                                            produtsColors.imageFile != null
                                                ? produtsColors.imageFile!
                                                : "",
                                            height: screenHeight / 15,
                                            width: screenWidth / 7,
                                            fit: BoxFit.contain,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Image.asset(
                                                  ConstantImage
                                                      .imageIsNotAvailable,
                                                  height: screenHeight / 15,
                                                  width: screenWidth / 7,
                                                  fit: BoxFit.fill);
                                            },
                                          ),
                                          SizedBox(
                                            width: screenWidth / 7,
                                            child: Text(
                                                produtsColors
                                                        .attributeValue ??
                                                    "",
                                                maxLines: 2,
                                                overflow:
                                                    TextOverflow.ellipsis,
                                                style: ConstantTextStyle
                                                    .storeLocationText,
                                                textAlign: TextAlign.center),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
        /*-----------------------------------Product Color category end------------------------------------*/
                              productColorList.isEmpty ? const SizedBox() :  SizedBox(height: screenHeight / 80,),
        /*-----------------------------------item Size start------------------------------------*/
                              productSizeList.isEmpty ? const SizedBox() : customeText(
                                text: "Sizes",
                                style: ConstantTextStyle.colorsHeadingText,
                                textAlign: TextAlign.start,
                              ),
                              productSizeList.isEmpty ? const SizedBox() :SizedBox(height: screenHeight / 80,),
                              Wrap(
                                spacing: screenWidth / 50.0,
                                children:
                                    productSizeList!.map((productSizeDetails) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (widget.id != "" && productSizeDetails.attributeValue !=null ) {
                                          fetchProductData(pid: productSizeDetails.productId.toString(), lat: widget.latitude, long: widget.longitude);
                                        }
                                        else {
                                          fetchProductData(pid: productSizeDetails.productId.toString(), lat: 22.6903994, long: 75.8657262);
                                        }
                                      });
                                      productDetailsDataList.clear();
                                      productDetailsAttributeList.clear();
                                      productColorList.clear();
                                      productSizeList.clear();

                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        border: Border.all(
                                          color:
                                              ConstantColor.primaryMainColor,
                                          width: 0.5,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: customeText(
                                        text: productSizeDetails
                                                .attributeValue ??
                                            "",
                                        maxLine: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: ConstantTextStyle
                                            .storeLocationText,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
        /*-----------------------------------item Size end------------------------------------*/
                              productSizeList.isEmpty ? const SizedBox() :SizedBox(height: screenHeight / 80,),
        /*-------------------------- Product details start------------------------------------*/

                              customRichText(
                                TextAlign: TextAlign.center,
                                text1: "PRODUCT DETAILS"..toUpperCase(),
                                style1: ConstantTextStyle.topCategoryText,
                              ),

                              SizedBox(
                                height: screenHeight / 80,
                              ),
        /*----------------------------------- product Details section start------------------------------------*/
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: productDetailsAttributeList.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      productDetailsSection(
                                        text1:
                                            productDetailsAttributeList[index]
                                                    .attrName ??
                                                "",
                                        textAlign1: TextAlign.start,
                                        style1: ConstantTextStyle
                                            .colorsHeadingText,
                                        context: context,
                                        text2:
                                            productDetailsAttributeList[index]
                                                    .attrValue ??
                                                "",
                                        textAlign2: TextAlign.end,
                                        style2: ConstantTextStyle
                                            .topCategoryText2,
                                      ),
                                      if (index !=
                                          productDetailsAttributeList.length -
                                              1)
                                        Divider(
                                          color:
                                              ConstantColor.locationIconColor,
                                          height: screenHeight / 50,
                                          thickness: 1,
                                        ),
                                    ],
                                  );
                                },
                              ),
        /*----------------------------------- product Details section end------------------------------------*/
                              Divider(
                                color: ConstantColor.locationIconColor,
                                height: screenHeight / 40,
                                thickness: 2,
                              ),
        /*----------------------------------- product section line 5nd end------------------------------------*/
        /*-----------------------------------Short Description start------------------------------------*/

                              productDetailsDataList.isNotEmpty &&
                                      productDetailsDataList[0]
                                              .shortDescription !=
                                          null &&
                                      productDetailsDataList[0]
                                              .shortDescription !=
                                          "NULL"
                                  ? customeText(
                                      textAlign: TextAlign.start,
                                      text: "SHORT Description".toUpperCase(),
                                      style:
                                          ConstantTextStyle.topCategoryText,
                                    )
                                  : Container(),
                              SizedBox(
                                height: screenHeight / 50,
                              ),
                              productDetailsDataList.isNotEmpty &&
                                      productDetailsDataList[0]
                                              .shortDescription !=
                                          null &&
                                      productDetailsDataList[0]
                                              .shortDescription !=
                                          "NULL"
                                  ? readMoreText(
                                      maxLines: descTextShowFlag ? null : 2,
                                      desctexttextAlign: TextAlign.start,
                                      descriptiontext:
                                          productDetailsDataList[0]
                                                  .shortDescription ??
                                              "",
                                      descriptiontextStyle:
                                          ConstantTextStyle.colorsHeadingText,
                                      ontap: () {
                                        setState(() {
                                          descTextShowFlag =
                                              !descTextShowFlag;
                                        });
                                      },
                                      context: context,
                                      widget: productDetailsDataList[0]
                                                  .shortDescription!
                                                  .length >
                                              74
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                descTextShowFlag
                                                    ? customeText(
                                                        text: "Read Less...",
                                                        style: ConstantTextStyle
                                                            .tabButtonTextStyle,
                                                      )
                                                    : customeText(
                                                        text: "Read More...",
                                                        style: ConstantTextStyle
                                                            .tabButtonTextStyle,
                                                      ),
                                              ],
                                            )
                                          : Container(),
                                    )
                                  : Container(),
                              productDetailsDataList.isNotEmpty &&
                                      productDetailsDataList[0]
                                              .shortDescription !=
                                          null &&
                                      productDetailsDataList[0]
                                              .shortDescription !=
                                          "NULL"
                                  ? Divider(
                                      color: ConstantColor.locationIconColor,
                                      height: screenHeight / 50,
                                      thickness: 2,
                                    )
                                  : Container(),
        /*-----------------------------------Short Description end------------------------------------*/
        /*-----------------------------------full Description start------------------------------------*/
                              productDetailsDataList.isNotEmpty &&
                                      productDetailsDataList[0].description !=
                                          null &&
                                      productDetailsDataList[0].description !=
                                          "NULL"
                                  ? customeText(
                                      textAlign: TextAlign.start,
                                      text: "full Description".toUpperCase(),
                                      style:
                                          ConstantTextStyle.topCategoryText,
                                    )
                                  : Container(),
                              SizedBox(
                                height: screenHeight / 50,
                              ),
                              productDetailsDataList.isNotEmpty &&
                                      productDetailsDataList[0].description !=
                                          null &&
                                      productDetailsDataList[0].description !=
                                          "NULL"
                                  ? readMoreText(
                                      maxLines: descTextShowFlag2 ? null : 2,
                                      desctexttextAlign: TextAlign.start,
                                      descriptiontext: convertHtmlToPlainText(
                                          productDetailsDataList[0]
                                                  .description ??
                                              ""),
                                      descriptiontextStyle:
                                          ConstantTextStyle.colorsHeadingText,
                                      ontap: () {
                                        setState(() {
                                          descTextShowFlag2 =
                                              !descTextShowFlag2;
                                        });
                                      },
                                      context: context,
                                      widget: productDetailsDataList[0]
                                                  .description!
                                                  .length >
                                              74
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                descTextShowFlag2
                                                    ? Text(
                                                        "Read Less...",
                                                        style: ConstantTextStyle
                                                            .tabButtonTextStyle,
                                                      )
                                                    : Text(
                                                        "Read More...",
                                                        style: ConstantTextStyle
                                                            .tabButtonTextStyle,
                                                      ),
                                              ],
                                            )
                                          : Container(),
                                    )
                                  : Container(),
                              productDetailsDataList.isNotEmpty &&
                                      productDetailsDataList[0].description !=
                                          null &&
                                      productDetailsDataList[0].description !=
                                          "NULL"
                                  ? Divider(
                                      color: ConstantColor.locationIconColor,
                                      height: screenHeight / 80,
                                      thickness: 2,
                                    )
                                  : Container(),
        /*-----------------------------------full Description end------------------------------------*/
        /*-----------------------------------Similar product section Start------------------------------------*/
                              similarProducts.isEmpty ? Container() : customeText(
                                text: "similar products".toUpperCase(),
                                style: ConstantTextStyle.topCategoryText,
                                textAlign: TextAlign.start,
                              ),
                              similarProducts.isEmpty ? Container() : SizedBox(
                                height: screenHeight / 80,
                              ),
        /*--------------------------------------------------------------------*/
                              similarProducts.isEmpty ? Container()
                                  : Stack(
                                children: [
                                  SizedBox(
                                    // height: screenHeight / 4,
                                    height: screenHeight /4.5,
                                    child:
                                    similarProducts.isNotEmpty &&
                                                similarProducts != null &&
                                                similarProducts != "NULL"
                                       ?ListView.builder(
                                                controller: _scrollController,
                                                itemExtent: screenWidth / 2.1,
                                                itemCount: similarProducts.isNotEmpty
                                                    ? similarProducts!.length
                                                    : null,
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder:
                                                    (context, index) {
        //*****************************************************************************
                                                  // discount Logic is here
                                                  double getPercantageOff(
                                                      double price,
                                                      double offerPrice) {
                                                    double result = ((price -
                                                                offerPrice) /
                                                            price) *
                                                        100;
                                                    return result
                                                        .floor()
                                                        .toDouble();
                                                  }
                                                  final similarProductsItem =
                                                      similarProducts[index];
                                                  final offerPrice = double.tryParse(
                                                          similarProductsItem
                                                                  .offerPrice ??
                                                              '0') ??
                                                      0.0;
                                                  final price = double.tryParse(
                                                          similarProductsItem
                                                                  .price ??
                                                              '0') ??
                                                      0.0;
                                                  final percentageOff =
                                                      offerPrice != 0.0
                                                          ? getPercantageOff(
                                                              price,
                                                              offerPrice)
                                                          : 0.0;
                                                  final roundedPercentageOff =
                                                      percentageOff
                                                          .toStringAsFixed(0);
        //*****************************************************************************
                                                  return Card(
                                                    color: ConstantColor.primaryBackgroundMainColor,
                                                    elevation: 4,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(5.0),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets
                                                          .symmetric(
                                                              horizontal:
                                                                  screenWidth /
                                                                      60),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Visibility(
                                                            visible:
                                                                percentageOff >
                                                                    0,
                                                            child:
                                                                cashBackChip(
                                                              context:
                                                                  context,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0),
                                                              text: percentageOff >
                                                                      0
                                                                  ? '$roundedPercentageOff% OFF'
                                                                  : "",
                                                              style: ConstantTextStyle
                                                                  .newiconButtonText,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              color: percentageOff >
                                                                      0
                                                                  ? ConstantColor
                                                                      .chipColor
                                                                  : null,
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) => ProductDetailScreen(
                                                                    proId: similarProducts[index].productId.toString(),
                                                                    id: widget.id,
                                                                    longitude: widget.longitude,
                                                                    latitude: widget.latitude,
                                                                    lName: widget.lName,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            child: CachedNetworkImage(
                                                              imageUrl: similarProductsItem.imageFile ?? "",
                                                              width: percentageOff > 0 ? screenWidth : screenWidth / 2,
                                                              height: percentageOff > 0 ? screenHeight / 8 : screenHeight / 6.5,
                                                              fit: BoxFit.contain,
                                                              errorWidget: (context, url, error) => Image.asset(
                                                                ConstantImage.imageIsNotAvailable,
                                                                width: screenWidth / 2,
                                                                height: screenHeight / 8,
                                                                fit: BoxFit.fill,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                screenHeight /
                                                                    200,
                                                          ),
                                                          customeText(
                                                            text: similarProductsItem
                                                                    .productName ??
                                                                "",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: ConstantTextStyle
                                                                .allHomeScreenAvatarText,
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                screenHeight /
                                                                    300,
                                                          ),
                                                          Flexible(
                                                            child:
                                                                customRichText(
                                                              text1:
                                                                  "\u{20B9}${similarProductsItem.offerPrice ?? similarProductsItem.price} " ??
                                                                      "N/A",
                                                              style1:
                                                                  ConstantTextStyle
                                                                      .richtext1,
                                                              TextAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style2:
                                                                  ConstantTextStyle
                                                                      .richtext2,
                                                              text2: percentageOff >
                                                                      0
                                                                  ? NumberFormat.simpleCurrency(
                                                                          locale:
                                                                              "hi-NI",
                                                                          decimalDigits:
                                                                              2)
                                                                      .format(double.parse(similarProductsItem.price ??
                                                                          ''))
                                                                  : " ",
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                screenHeight /
                                                                    200,
                                                          ),
                                                          // Flexible(
                                                          //   child:
                                                          //   ElevatedButton.icon(
                                                          //     onPressed: similarProducts[index].wantToBuy == "1" ?
                                                          //     null : () async {
                                                          //       SharedPreferences preferences = await SharedPreferences.getInstance();
                                                          //       setState(() {
                                                          //         isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                                                          //         tokenAccess = preferences.getString("access-token");
                                                          //       });
                                                          //       if (isUserLoggedIn) {
                                                          //         await fetchSendEnquiryAPi(
                                                          //           prodId: similarProducts[index].productId ?? '',
                                                          //           tokenAccess: tokenAccess,
                                                          //           wantBuy: "1",
                                                          //           index: index,
                                                          //         );
                                                          //       }
                                                          //       else {
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
                                                          //       color:  ConstantColor.primaryBackgroundMainColor,
                                                          //       size: 18.0,
                                                          //     ),
                                                          //     label: Text(
                                                          //       'Send Enquiry',
                                                          //       style: ConstantTextStyle.newiconButtonText,
                                                          //     ),
                                                          //     style: ElevatedButton.styleFrom(
                                                          //       minimumSize: Size.fromHeight(screenHeight / 25),
                                                          //       backgroundColor: similarProducts[index].wantToBuy == "1"
                                                          //           ? ConstantColor.primaryGreyColor
                                                          //           : ConstantColor.primaryMainColor,
                                                          //       shape: RoundedRectangleBorder(
                                                          //         borderRadius: BorderRadius.circular(8.0),
                                                          //       ),
                                                          //     ),
                                                          //   ),
                                                          // ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ) : null,
                                  ),
                                  Positioned(
                                    left: screenWidth / 40,
                                    top: 0,
                                    bottom: 0,
                                    child: arrowButons(
                                      onTap: () {
                                        setState(() {
                                          leftIconBGColor = !leftIconBGColor;
                                        });
                                        Future.delayed(
                                            const Duration(milliseconds: 500),
                                            () {
                                          setState(() {
                                            leftIconBGColor =
                                                !leftIconBGColor;
                                          });
                                        });
                                        scrollListLeftSide();
                                      },
                                      radius: 15.0,
                                      backgroundColor: leftIconBGColor
                                          ? ConstantColor.primaryMainColor
                                          : ConstantColor.iconBackTPColor,
                                      icon: Icons.arrow_back_ios_rounded,
                                      iconSize: 20.0,
                                      color: leftIconBGColor
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
                                          rightIconBGColor =
                                              !rightIconBGColor;
                                        });
                                        Future.delayed(
                                            const Duration(milliseconds: 500),
                                            () {
                                          setState(() {
                                            rightIconBGColor =
                                                !rightIconBGColor;
                                          });
                                        });
                                        scrollListRightSide();
                                      },
                                      radius: 15.0,
                                      backgroundColor: rightIconBGColor
                                          ? ConstantColor.primaryMainColor
                                          : ConstantColor.iconBackTPColor,
                                      icon: Icons.arrow_forward_ios_rounded,
                                      iconSize: 20.0,
                                      color: rightIconBGColor
                                          ? ConstantColor.searchBoxColor
                                          : ConstantColor.primaryMainColor,
                                    ),
                                  ),
                                ],
                              ),
        /*--------------------------------------------------------------------*/
                              SizedBox(height: screenHeight /7.0,),
        /*-----------------------------------Similar product section end------------------------------------*/
                            ],
                          ),
                        ),
                      ),
                    )
           : const Center(child: Text('No product details found!')),
        ),
      ),
    );
  }
}
