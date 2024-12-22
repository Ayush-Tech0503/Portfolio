// ignore_for_file: deprecated_member_use

import 'package:citybazaronline_seller_app/Widget/images/cached_images_widget.dart';
import 'package:citybazaronline_seller_app/Widget/images/circle_avtar_image_widget.dart';
import 'package:citybazaronline_seller_app/Widget/span_title_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Layouts/constant_screen_layout.dart';
import '../../Models/Shop Info Preview Model/registration_preview_model.dart';
import '../../Services/shop_registration_preview_api_services.dart';
import '../../Utils/Constant Images/constant_images.dart';
import '../../Utils/Constant Size /constant_sizes.dart';
import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';
import '../../Widget/Custome Buttons/elevetion_button_widget.dart';
import '../../Widget/No Data Available/no_data_found.dart';
import '../../Widget/custome_text_widget.dart';
import '../../Widget/divider_widget.dart';
import '../../Widget/refresh_footer_message.dart';

class ShopProfileInfoScreen extends StatefulWidget {
  const ShopProfileInfoScreen({super.key});

  @override
  State<ShopProfileInfoScreen> createState() => _ShopProfileInfoScreenState();
}


class _ShopProfileInfoScreenState extends State<ShopProfileInfoScreen> {

  @override
  void initState() {
    super.initState();
    fetchShopInfoListData();
  }
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool isPullToRefreshEnabled = true;
  int currentPage = 1;
  bool isLoading = false;
  var limit = "12";

  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  ShopInfoPreviewModel? shopInfoPreviewModel;
  List<ShopInfoPreviewData>? data = [];

  String fileData = '';
  String shopEmail = '';
  String userContactNo = '';
  String sellerContactNo = '';
  String shopLogo = '';
  String shopBanner = '';


  Future<void> fetchShopInfoListData() async {
    try {
      if (currentPage == 1) {
        setState(() {
          isLoading = true;
          data!.clear();
        });
      }

      final shopInfoResponse = await ApiShopInfoPreviewService.fetchShopInfoPreviewData(context: context);

      if (shopInfoResponse != null && shopInfoResponse.data != null) {
        final dataList = shopInfoResponse.data!;

        setState(() {
          if (currentPage == 1) {
            data = [dataList];
          } else {
            data!.addAll([dataList]);
            _refreshController.loadComplete();
          }

          isLoading = false;
          currentPage++;
        });

        setState(() {
          fileData = data!.first.seller!.scRegistrationFile??"";
          shopEmail = data!.first.seller!.email??"";
          userContactNo = data!.first.userInfo!.mobile??"";
          sellerContactNo = data!.first.seller!.contactNo??"";
          shopLogo = data!.first.seller!.storeLogoName??"";
          shopBanner = data!.first.seller!.storeBannerName??"";
          shopInfoData = [
            {"title": "Store Name :", "content": data!.first.seller!.storeName??""},
            {"title": "Store Slug  :", "content": data!.first.seller!.storeSlug??""},
            {"title": "Designation :", "content": data!.first.seller!.designation??""},
            {"title": "Store Address :", "content": data!.first.seller!.storeAddress??""},
            {"title": "Store Description :", "content": data!.first.seller!.storeDescription??""},
            {"title": "Location Address :", "content": data!.first.seller!.storeLocAddress??""},
            {"title": "Referral Code :", "content": data!.first.seller!.referralCode??""},
            {"title": "Latitude :", "content": data!.first.seller!.storeLatitude??""},
            {"title": "Longitude :", "content": data!.first.seller!.storeLongitude??""},
            {"title": "Landmark :", "content": data!.first.seller!.landmark??""},
            {"title": "City :", "content": data!.first.seller!.cityId??""},
            {"title": "Pin Code :", "content": data!.first.seller!.pincode??""},
            {"title": "State :", "content": data!.first.seller!.stateId??""},
            {"title": "Country :", "content": data!.first.seller!.countryId??""},
            {"title": "Contact No. :", "content": userContactNo.isNotEmpty ? userContactNo : sellerContactNo ??""},
            {"title": "is active :", "content": data!.first.seller!.isActive??""},
            {"title": "is approved :", "content": data!.first.seller!.isApproved??""},
            {"title": "Sell/Rent :", "content": data!.first.seller!.buyOrRent??""},
            {"title": "Contact No. (Optional) :", "content": data!.first.seller!.contactNoOpt??""},
            {"title": "Delivery Mode :", "content": data!.first.seller!.deliveryMode??""},
            {"title": "Shop/Company Registration No. Type :", "content": data!.first.seller!.scRegistrationType??""},
            {"title": "Shop/Company Registration No. Other Type :", "content": data!.first.seller!.otherScRegType??""},
            {"title": "Shop/Company Registration No. :", "content": data!.first.seller!.gstNo??""},
            {"title": "Registration Document :", "content": fileData??""},
            {"title": "Deals In :", "content": data!.first.seller!.dealsIn??""},
            {"title": "Payment Modes Accepted :", "content": data!.first.seller!.paymentModesAccepted??""},
          ];
          seoKeyData = [
            {"title": "Meta Keyword :", "content": data!.first.seller!.metaKeyword??""},
            {"title": "Meta Description :", "content": data!.first.seller!.metaDescription??""},
          ];
          openHoursData = [
            {"title": "Monday :", "content": '${data!.first.sellerOpenHrs!.first.opensAt??""} - ${data!.first.sellerOpenHrs!.first.closesAt??""}', 'on/off': data!.first.sellerOpenHrs!.first.onOff??""},
            {"title": "Tuesday :", "content": '${data!.first.sellerOpenHrs![1].opensAt??""} - ${data!.first.sellerOpenHrs![1].closesAt??""}', 'on/off': data!.first.sellerOpenHrs![1].onOff??""},
            {"title": "Wednesday :", "content": '${data!.first.sellerOpenHrs![2].opensAt??""} - ${data!.first.sellerOpenHrs![2].closesAt??""}', 'on/off': data!.first.sellerOpenHrs![2].onOff??""},
            {"title": "Thursday :", "content": '${data!.first.sellerOpenHrs![3].opensAt??""} - ${data!.first.sellerOpenHrs![3].closesAt??""}', 'on/off': data!.first.sellerOpenHrs![3].onOff??""},
            {"title": "Friday :", "content": '${data!.first.sellerOpenHrs![4].opensAt??""} - ${data!.first.sellerOpenHrs![4].closesAt??""}', 'on/off': data!.first.sellerOpenHrs![4].onOff??""},
            {"title": "Saturday :", "content": '${data!.first.sellerOpenHrs![5].opensAt??""} - ${data!.first.sellerOpenHrs![5].closesAt??""}', 'on/off': data!.first.sellerOpenHrs![5].onOff??""},
            {"title": "Sunday :", "content": '${data!.first.sellerOpenHrs![6].opensAt??""} - ${data!.first.sellerOpenHrs![6].closesAt??""}', 'on/off': data!.first.sellerOpenHrs![6].onOff??""},
          ];
        });

      } else {
        // No more data available
        setState(() {
          isLoading = false;
          _refreshController.loadNoData();
          isPullToRefreshEnabled = false; // Disable pull-to-refresh
        });
      }
    } catch (e) {
      setState(() {
        _refreshController.loadNoData();
        isLoading = false;
      });
    }
  }


  List<Map<String, String>> shopInfoData = [];

  List<Map<String, String>> seoKeyData = [];

  List<Map<String, String>> openHoursData = [];



  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
        onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(context, '/bottomNavigationBarScreen', (Route<dynamic> route) => false,);
          return true; // Return true to allow the pop action
        },
      child: AppLayout(
        title: "Shop Information",
        titleStyle: ConstantTextStyle.landingScreenAppbarText,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), color: ConstantColor.primaryBackgroundMainColor,
          onPressed: () => Navigator.pop(context),
        ),
        scaffoldColor: ConstantColor.primaryBackgroundMainColor,
        appBarColor: ConstantColor.loginWithOtpButtonColor,
        body: data == null || data!.toString().isEmpty ? noDataFound(context):
        CupertinoScrollbar(
          // controller: _scrollController,
          child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              controller: _refreshController,
              footer: customFooter(),
              onRefresh: () async {
                currentPage = 1;
             await fetchShopInfoListData();
                _refreshController.refreshCompleted();
              },
              child: Skeletonizer(
                enabled: isLoading,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth/40.0,vertical: screenHeight/80.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customeText(text: "\tShop Information",style: ConstantTextStyle.topCategoryText4),
                        constantHeight(context, 80.0),
      
                        cachedImageWidget(
                          context:context,
                          height: screenHeight/6,
                          width: screenWidth,
                          imageFile: shopBanner??"",
                        ),
      
                        dividerWidget(height: screenHeight/60.0,),
                        circleImageWidget(
                            circle1Radius: screenHeight/15.7,
                            circle2Radius: screenHeight/16.0,
                            backgroundImage: shopLogo.isNotEmpty
                                ? NetworkImage(shopLogo??"")
                                : AssetImage(ConstantImage.imageIsNotAvailable),
                        ),
                        SizedBox(
                          width: screenWidth,
                          child: Card(
                            elevation: 0.5,
                            margin: EdgeInsets.symmetric(vertical: screenHeight/50.0),
                            child: customeText(text: "\t\tShop Information",
                                style: ConstantTextStyle.otpHintTextStyle),
                          ),
                        ),
                        Column(
                          children: shopInfoData.map((item) {
                            if (item["title"] == "Registration Document :") {
                              return Row(
                                children: [
                                  customeText(
                                    text: '${item["title"]}\t\t',
                                    style: ConstantTextStyle.cardbottumText,
                                  ),
                                  customButton(
                                      elevation: 4.0,
                                      textStyleButton:
                                      ConstantTextStyle.loginButtonTextStyle,
                                      onPressed: () async { await launch(fileData);},
                                      text: "view file",
                                      backgroundColor: ConstantColor.filedContainerColor,
                                      borderRadius: BorderRadius.circular(6.0),
                                      minimumSize: Size(screenWidth /20, screenHeight /40.0)
                                  ),
                                ],
                              );
                            } else {
                              return richTextWithSpanWidget(
                                context: context,
                                firstText: item["title"],
                                secondText: '\t${item["content"]}',
                                firstTextStyle: ConstantTextStyle.cardbottumText,
                                secondTextStyle: ConstantTextStyle.colorsHeadingText,
                              );
                            }
                          }).toList(),
                        ),
      
      
                        dividerWidget(height: screenHeight/60.0,),
      
                        SizedBox(
                          width: screenWidth,
                          child: Card(
                            elevation: 0.5,
                            margin: EdgeInsets.symmetric(vertical: screenHeight/60.0),
                            child: customeText(text: "\t\tSEO Keyword",
                                style: ConstantTextStyle.otpHintTextStyle),
                          ),
                        ),
                        Column(
                            children:    seoKeyData.map((item) {
                              return richTextWithSpanWidget(
                                context: context,
                                firstText: item["title"],
                                secondText: '\t${item["content"]}',
                                firstTextStyle: ConstantTextStyle.cardbottumText,
                                secondTextStyle: ConstantTextStyle.colorsHeadingText,
                              );
                            }).toList()
                        ),
      
                        dividerWidget(height: screenHeight/60.0,),
      
                        SizedBox(
                          width: screenWidth,
                          child: Card(
                            elevation: 0.5,
                            margin: EdgeInsets.symmetric(vertical: screenHeight/60.0),
                            child: customeText(text: "\t\tOpen Hours",
                                style: ConstantTextStyle.otpHintTextStyle),
                          ),
                        ),
                        Column(
                          children: openHoursData.map((item) {
                            return richTextWithSpanWidget(
                              context: context,
                              firstText: item["title"],
                              secondText: item["on/off"] == '0' ? '\t\tShop Close Today' : '\t${item["content"]}',
                              firstTextStyle: ConstantTextStyle.cardbottumText,
                              secondTextStyle: ConstantTextStyle.colorsHeadingText,
                            );
                          }).toList(),
                        ),
      
                        dividerWidget(height: screenHeight/60.0,),
      
                        SizedBox(
                          width: screenWidth,
                          child: Card(
                            elevation: 0.5,
                            margin: EdgeInsets.symmetric(vertical: screenHeight/60.0),
                            child: customeText(text: "\t\tEmail",
                                style: ConstantTextStyle.otpHintTextStyle),
                          ),
                        ),
                       richTextWithSpanWidget(
                                context: context,
                                firstText: 'Email : ',
                                secondText: '\t$shopEmail',
                                firstTextStyle: ConstantTextStyle.cardbottumText,
                                secondTextStyle: ConstantTextStyle.colorsHeadingText,
                              ),
                        dividerWidget(height: screenHeight/60.0,),
                        SizedBox(
                          width: screenWidth,
                          child: Card(
                            elevation: 0.5,
                            margin: EdgeInsets.symmetric(vertical: screenHeight/60.0),
                            child: customeText(text: "\t\tContact No.",
                                style: ConstantTextStyle.otpHintTextStyle),
                          ),
                        ),
                       richTextWithSpanWidget(
                                context: context,
                                firstText: 'Contact No. : ',
                                secondText: '\t${userContactNo.isNotEmpty ? userContactNo : sellerContactNo ??""}',
                                firstTextStyle: ConstantTextStyle.cardbottumText,
                                secondTextStyle: ConstantTextStyle.colorsHeadingText,
                              ),
      
                        dividerWidget(height: screenHeight/60.0,),
      
      
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            customButton(
                                elevation: 0.5,
                                textStyleButton:
                                ConstantTextStyle.loginButtonTextStyle,
                                onPressed: () {
                                  Navigator.pushNamed(context, '/sellerForm');
                                },
                                text: "Edit info.",
                                backgroundColor: ConstantColor.loginWithOtpButtonColor,
                                borderRadius: BorderRadius.circular(8.0),
                                minimumSize: Size(screenWidth /2.3, screenHeight / 25.0)
                            ),
                            constantWidth(context, 50.0),
                            customButton(
                                elevation: 0.5,
                                textStyleButton:
                                ConstantTextStyle.loginButtonTextStyle,
                                onPressed: () => Navigator.pushNamed(context, '/purchaseRenewPlanScreen'),
                                text: "Submit Now",
                                backgroundColor: ConstantColor.filedContainerColor,
                                borderRadius: BorderRadius.circular(8.0),
                                minimumSize: Size(screenWidth /2.3, screenHeight / 25.0)
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )),
        )
      ),
    );
  }
}