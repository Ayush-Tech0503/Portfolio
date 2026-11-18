// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables, use_build_context_synchronously, must_be_immutable, empty_catches
import 'dart:convert';
import 'dart:io';
import 'package:Citybazar_app/Layouts/User%20Profile%20My%20Account/Your%20Requirement/your_req.dart';
import 'package:Citybazar_app/Widgets/custome_icon_button.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Models/DashBoard Model/dashboard_model.dart';
import '../Util/Const Toster/awesome_toster.dart';
import '../Util/Const Toster/toster.dart';
import '../Util/Constant APi Url/api_urls.dart';
import '../Util/constaint_textstyle.dart';
import '../Util/constant_color.dart';
import '../Util/constant_image.dart';
import '../View/order_view.dart';
import '../Widgets/Login Check Widget/login_check_widget.dart';
import '../Widgets/Send Enquiry dialogBox/alert_dialog_box.dart';
import '../Widgets/custome_button_.dart';
import '../Widgets/custome_checkbox.dart';
import '../Widgets/custome_text.dart';
import '../Widgets/famous_market_card_widget.dart';
import '../Widgets/landing_screen_slider.dart';
import 'Card Details Screen/My Address Screen/my_address_screen.dart';
import 'Onboarding Screens/login_screen.dart';
import 'User Profile My Account/About Us/about_us_screen.dart';
import 'User Profile My Account/Advertise With Us/ads_with_us.dart';
import 'User Profile My Account/Beacome a Seller/become_a_seller.dart';
import 'User Profile My Account/Cbo Share App/cbo_share_app.dart';
import 'User Profile My Account/Contact Us/contact_us_screen.dart';
import 'User Profile My Account/Dashboard/Following Shop/following_shops.dart';
import 'User Profile My Account/Dashboard/Liked Products/like_products.dart';
import 'User Profile My Account/Dashboard/Order Screen/order_screen.dart';
import 'User Profile My Account/Dashboard/Save Reels/save_reels_datatable.dart';
import 'User Profile My Account/Dashboard/Seller Reviews/Seller Review TableData/seller_reviews_datatable.dart';
import 'User Profile My Account/FAQs/faq_screen.dart';
import 'User Profile My Account/My Profile/my_profile_update_form.dart';
import 'User Profile My Account/Privacy Policy/privacy_policy_screen.dart';
import 'User Profile My Account/Term Of Use/terms_of_use.dart';
import 'plan_validity_screen.dart';

class ProfileScreen extends StatefulWidget {
  final ScrollController controller;
  String id;
  String lName;
  String longitude;
  String latitude;
   ProfileScreen({super.key, required this.controller,required this.id,required this.longitude,required this.latitude,required this.lName});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;
  var tokenAccess;
  var userId;
  var userName;
  var isSeller;
  var storedUserData;
  DashBoardScreenData? dashBoardScreenData;
  bool isPullToRefreshEnabled = false;
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  getDashboardApiData() async {
    try {
      setState(() {
        isLoading = true;
        isPullToRefreshEnabled = true;
      });
      SharedPreferences preference = await SharedPreferences.getInstance();
      tokenAccess = preference.getString("access-token");
      userName = preference.getString("name");
      isSeller = preference.getInt("is_seller");
      userId = preference.getString("userId");
      final body = {"user_id": userId,};
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
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.setString('datacount_data', json.encode(responseData));
        setState(() {
          isLoading = false;
          isPullToRefreshEnabled = false;
        });
      } else {
        setState(() {
          isLoading = false;
          isPullToRefreshEnabled = false;
        });
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
        isPullToRefreshEnabled = false;
        _refreshController.refreshCompleted();
      });
    }
  }


  // fetchCachedDashboardApiData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? cachedData = prefs.getString('datacount_data');
  //
  //   if (cachedData != null) {
  //     var cachedResponseData = json.decode(cachedData);
  //     // Process cached data
  //     dashBoardScreenData = DashBoardScreenData.fromJson(cachedResponseData);
  //     // Update UI with cached data
  //     setState(() {
  //
  //     });
  //   } else {
  //     getDashboardApiData();
  //   }
  // }
//------------------------------------------
  bool isLoadingFeedback = false;
  fetchFeedbackAPi() async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      tokenAccess = preference.getString("access-token");

      setState(() {
        isLoadingFeedback = true;
      });
      final body = {
          "user_id": userId,
          "feedback": [
            selectedData,
          ]
      };
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.feedBackApi}",
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
          isLoadingFeedback = false;
          awesomeTost(context, 'Feedback Submitted Successfully');
        });

      } else {
        setState(() {
          isLoadingFeedback = false;
        });

      }
    } catch (error) {
      setState(() {
        isLoadingFeedback = false;
      });
    }
  }
//------------------------------------------
  bool isUserLoggedIn = false;
//------------------------------------------
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDashboardApiData();
  }

/*-------------------------whatsapp share start------------------------------------------------*/
  void _joinWhatsAppGroup() async {
    const groupLink = 'https://chat.whatsapp.com/https://chat.whatsapp.com/LN4ItKnPrW8Jtrdwby4Vsk';
    if (await canLaunch(groupLink)) {
      await launch(groupLink);
    } else {
      throw 'Could not launch WhatsApp group: $groupLink';
    }
  }
/*-------------------------------whatsapp share end----------------------------------------*/
/*-------------------------------PlaystoreLink  ----------------------------------------*/
  void _launchPlayStore() async {
    const playStoreLink = 'https://play.google.com/store/apps/details?id=com.citybazaronline&pcampaignid=web_share';

    if (await canLaunch(playStoreLink)) {
      await launch(playStoreLink);
    } else {
      throw 'Could not launch $playStoreLink';
    }
  }

/*--------------------------------Drawer List start--------------------------------------*/
  static final List<String> _listViewData = [
    'Review and rating',
    'Advertise with us',
    'contact us',
    "Share App",
    'Follow us',
    "Join Whatsapp",
    // "Rating / Feedback",
    // "Dashboard",
    "FAQ",
    "About us",
    // "Contact Us",
    "Term of use",
    "Privacy policy"
    // "Advertise With Us",
  ];

  static const _iconTypes = <IconData>[
    Icons.star_border_rounded,
    FontAwesome.bullhorn,
    Icons.contact_mail_outlined,
    Icons.share_outlined,
    Icons.person_add_alt_1_outlined,
    FontAwesome.whatsapp,
    // Icons.space_dashboard_outlined,
    Icons.quiz_outlined,
    Icons.info_outlined,
    Icons.privacy_tip_outlined,
    FontAwesome.info_circle,
  ];

/*--------------------------------Drawer List end--------------------------------------*/
  shareFile() async {
    ByteData imagebyte = await rootBundle
        .load(ConstantImage.cityBazaarShareApp);
    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/image1.jpg';
    File(path).writeAsBytesSync(imagebyte.buffer.asUint8List());
    await Share.shareFiles([path], text: '''
    Hi..!
    अब आप देख सकते है, इंदौर का लोकल बाजार आपके अपने मोबाइल फोन पर।\n
    प्लेस्टोर से ऐप डाउनलोड करे -
    https://citybazaronline.page.link/app\n
    1. अपना अकाउंट login करें।\n
    2. अपनी मनपंसद इंदौर की कोई भी लोकेशन सेलेक्ट करें।\n
    3. अब अपने आसपास की सभी लोकल दुकानों के products ऑनलाइन देखें या अपनी जरुरत के अनुसार सर्च करे।\n
    4. होम डिलीवरी के लिए डायरेक्ट सेलर से कांटेक्ट करें या अपना product दुकान पर जाकर देख परख कर ही खरीदें।\n
    5. लोकल बाज़ार के स्पेशल ऑफर्स का हमेशा लाभ उठाए।\n
    6. यदि बाज़ार में आपकी भी कोई दुकान है, तो अभी अपना ऑनलाइन स्टोर बनवाए और सभी ऑनलाइन ग्राहक तक अपनी पहुंच बनाए।\n
    एप्लीकेशन डाउनलोड लिंक-
    https://citybazaronline.page.link/app\n
    Www.citybazaronline.com\n\n
    WhatsApp 9406710101
    Toll-free 18008892780
  ''');
  }
/*-------------------------DialogBox Hindi data List For listview builder start-----------------------*/
  final List<String> _hindiTextData = [
    "मुझे ऐप कांसेप्ट समझ नहीं आया |",
    "ऐप को ऑपरेट करना कठिन हैं |",
    "मुझे अपनी पसंद का प्रोडक्ट नहीं मिला |",
    "अन्य",
  ];
  List<bool> checkBoxValues = List.generate(4, (index) => false);
  String selectedData = '';

  void clearToken() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    preference.clear();
  }
  final TextEditingController _textEditingController = TextEditingController();


  void _launchURL(BuildContext context) async {
    const url = 'https://seller.citybazaronline.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
/*-------------------------DialogBox Hindi data List For listview builder end-----------------------*/
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return  Scaffold(
      backgroundColor: ConstantColor.primaryBackgroundMainColor,
      // appBar:  AppBar(
      //   backgroundColor: ConstantColor.drawerDividerColor,
      //   elevation: 0,
      //     title: Text('My App'),
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.vertical(
      //         bottom: Radius.circular(20),
      //       ),
      //     ),
      //   ),
      body:
      SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        controller: _refreshController,
        onRefresh: () async {
          await getDashboardApiData();
          _refreshController.refreshCompleted();
        },
        child:
        ListView(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
                color: ConstantColor.loginWithOtpButtonColor,
              ),
              child: ListTile(
               horizontalTitleGap: 0.0,
                contentPadding: EdgeInsets.only(left: screenHeight/60),
                dense: true,
                onTap: () async{
                  SharedPreferences preferences = await SharedPreferences.getInstance();
                  setState(() {
                    isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                    tokenAccess = preferences.getString("access-token");
                    isSeller = preferences.getInt("is_seller");
                    userName = preferences.getString("name");
                  });
                  if (isUserLoggedIn) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyProfileUpdate()),
                    );
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
                leading: const Icon(Icons.person_outline_rounded,
                    // color: ConstantColor.loginWithOtpButtonColor
                    color: ConstantColor.primaryBackgroundMainColor
                ),
                title: customeText(
                  textAlign: TextAlign.start,
                  text: (userName != null && userName.isNotEmpty) ? "Hello! $userName" : "Hello! User",
                  // style: ConstantTextStyle.secodHearText,
                  style: ConstantTextStyle.reviewsRatingsText,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    customeIconButton(
                      icon: const Icon(Icons.mode_edit_outlined,
                          color: ConstantColor.primaryBackgroundMainColor
                          // color: ConstantColor.primaryMainColor
                      ),
                      // onPressed: () {},
                    ),
                    const SizedBox(width: 8.0),
                    customeIconButton(
                      icon: const Icon(Icons.output_outlined,
                          color: ConstantColor.primaryBackgroundMainColor
                      ),
                      onPressed: () {
                     LogoutDialog.showExitConfirmationDialog(
                       context,
                         (){  clearToken();
                         Navigator.of(context).pushAndRemoveUntil(
                             MaterialPageRoute(
                               builder: (BuildContext context) => const LoginScreen(),
                             ),
                         (Route route) => false,  );},

                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

SizedBox(height: screenHeight/150,),
/*-----------------------------Grid view start----------------------------------------------*/
            Padding(
              padding: EdgeInsets.only(left: screenWidth/30,right: screenWidth/30,top: screenWidth/80,),
              child: GestureDetector(
                onTap: () async{
                  SharedPreferences preferences = await SharedPreferences.getInstance();
                  setState(() {
                    isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                    tokenAccess = preferences.getString("access-token");
                    isSeller = preferences.getInt("is_seller");
                    userName = preferences.getString("name");
                  });
                  if (isUserLoggedIn) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyAddressScreen(
                        id: widget.id,
                        lName: widget.lName,
                        longitude: widget.longitude,
                        lattude: widget.latitude,
                      ),),
                    );
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
                child: Card(
                  color: ConstantColor.profileGridBGolor,
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: screenHeight/50),
                    alignment: Alignment.center,
                    child: customeText(
                      text: "MY ADDRESS",
                      style: ConstantTextStyle.tabButtonTextStyle,
                    ),
                  ),
                ),
              ),
            ),



        isLoading
            ? const SpinKitCircle(
          color: ConstantColor.primaryMainColor,
          size: 30.0,
        ) : GridView(
              padding: EdgeInsets.only(top: screenHeight/300.0,left: screenWidth/30,right: screenWidth/30),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 2 / 1,
                crossAxisCount: 2, // Number of columns in the grid
                crossAxisSpacing: 8.0, // Spacing between each column
                mainAxisSpacing: 8.0,
              ),
              children: [
                InkWell(
                  onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                              YourLikedProductsScreen(
                                id: widget.id,
                                lName: widget.lName,
                                latitude: widget.latitude,
                                longitude: widget.longitude,
                              )),);
                  },
                  child: profileGridView(
                    title: customeText(
                        text: dashBoardScreenData?.dashboardData?.totLikedProduct.toString() ?? "",
                        style: ConstantTextStyle.countingText),
                    subtitle: customeText(
                        text: "Liked Product".toUpperCase(),
                        style: ConstantTextStyle.allHomeScreenAvatarText),
                    borderRadius: BorderRadius.circular(12.0),
                    iconBox: Icons.thumb_up_alt_outlined,
                    boxHeight: screenHeight / 20,
                    boxWidth: screenWidth / 10,
                    boxbgcolor:
                    ConstantColor.primaryBackgroundMainColor,
                    iconsize: 25.0,
                    boxiconcolor: ConstantColor.primaryMainColor,
                    boxborderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(
                          () => const OrderView(),
                      arguments: {'id': widget.id, "lName": widget.lName, "latitude": widget.latitude, "longitude": widget.longitude}, // Pass your arguments here
                    );
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) =>
                              // OrderScreen(
                              //   id: widget.id,
                              //   lName: widget.lName,
                              //   latitude: widget.latitude,
                              //   longitude: widget.longitude,
                              // )
                      // ),
                    // );
                  },
                  child: profileGridView(
                    title: customeText(
                        text: dashBoardScreenData?.dashboardData?.orderCount.toString() ?? "",
                        style: ConstantTextStyle.countingText),
                    subtitle: customeText(
                        text: "Order".toUpperCase(),
                        style: ConstantTextStyle.allHomeScreenAvatarText),
                    borderRadius: BorderRadius.circular(12.0),
                    iconBox: Icons.calendar_month_outlined,
                    boxHeight: screenHeight / 20,
                    boxWidth: screenWidth / 10,
                    boxbgcolor:
                    ConstantColor.primaryBackgroundMainColor,
                    iconsize: 25.0,
                    boxiconcolor: ConstantColor.primaryMainColor,
                    boxborderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FollowingShopScreen(
                                id: widget.id,
                                lName: widget.lName,
                                latitude: widget.latitude,
                                longitude: widget.longitude,
                              )),
                    );
                  },
                  child: profileGridView(
                    title: customeText(
                        text: dashBoardScreenData?.dashboardData?.totFollowedSeller.toString() ?? "",
                        style: ConstantTextStyle.countingText),
                    subtitle: customeText(
                        text: "following shops".toUpperCase(),
                        style: ConstantTextStyle.allHomeScreenAvatarText),
                    borderRadius: BorderRadius.circular(12.0),
                    iconBox: Icons.storefront_outlined,
                    boxHeight: screenHeight / 20,
                    boxWidth: screenWidth / 10,
                    boxbgcolor: ConstantColor.primaryBackgroundMainColor,
                    iconsize: 25.0,
                    boxiconcolor: ConstantColor.primaryMainColor,
                    boxborderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SellerReviewDataTable(
                                id: widget.id,
                                lName: widget.lName,
                                latitude: widget.latitude,
                                longitude: widget.longitude,
                              )),
                    );
                  },
                  child: profileGridView(
                    title: customeText(
                        text: dashBoardScreenData?.dashboardData?.totSellerReviews.toString() ?? "",
                        style: ConstantTextStyle.countingText),
                    subtitle: customeText(
                        text: "My seller Reviews".toUpperCase(),
                        style: ConstantTextStyle.allHomeScreenAvatarText),
                    borderRadius: BorderRadius.circular(12.0),
                    iconBox: Icons.message_outlined,
                    boxHeight: screenHeight / 20,
                    boxWidth: screenWidth / 10,
                    boxbgcolor:
                    ConstantColor.primaryBackgroundMainColor,
                    iconsize: 25.0,
                    boxiconcolor: ConstantColor.primaryMainColor,
                    boxborderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>   SaveReelsDashboardScreen(
                            id: widget.id,
                            lName: widget.lName,
                            latitude: widget.latitude,
                            longitude: widget.longitude,
                          )),
                    );
                  },
                  child: profileGridView(
                    title: customeText(
                        text: dashBoardScreenData?.dashboardData?.saveCount.toString() ?? "",
                        style: ConstantTextStyle.countingText),
                    subtitle: customeText(
                        text: "Saved Reels".toUpperCase(),
                        style: ConstantTextStyle.profileGridText),
                    borderRadius: BorderRadius.circular(12.0),
                    iconBox: FontAwesomeIcons.bookmark,
                    boxHeight: screenHeight / 20,
                    boxWidth: screenWidth / 10,
                    boxbgcolor:
                    ConstantColor.primaryBackgroundMainColor,
                    iconsize: 25.0,
                    boxiconcolor: ConstantColor.primaryMainColor,
                    boxborderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    SharedPreferences preferences = await SharedPreferences.getInstance();
                    setState(() {
                      isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                      tokenAccess = preferences.getString("access-token");
                      isSeller = preferences.getInt("is_seller");
                      userName = preferences.getString("name");
                    });
                    if (isUserLoggedIn) {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const YourRequirementScreen()),);
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
                  child: profileGridView(
                    title: customeText(
                        text: "Your Requirements".toUpperCase(),
                        style: ConstantTextStyle.tabButtonTextStyle),
                    borderRadius: BorderRadius.circular(12.0),
                    iconBox: Icons.menu_outlined,
                    boxHeight: screenHeight / 20,
                    boxWidth: screenWidth / 10,
                    boxbgcolor: ConstantColor.primaryBackgroundMainColor,
                    iconsize: 25.0,
                    boxiconcolor: ConstantColor.primaryMainColor,
                    boxborderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ],
            ),
 /*-----------------------------Grid view  end----------------------------------------------*/
            Padding(
              padding: EdgeInsets.only(left: screenWidth/30,right: screenWidth/30,top: screenWidth/80,),
              child: GestureDetector(
                onTap: () async {
                  SharedPreferences preferences = await SharedPreferences.getInstance();
                  setState(() {
                    isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                    tokenAccess = preferences.getString("access-token");
                    isSeller = preferences.getInt("is_seller");
                    userName = preferences.getString("name");
                  });
                  if (isUserLoggedIn) {
                    if (isSeller == 1) {
                      _launchURL(context);
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BecomeASellerform(
                            id: widget.id,
                            lName: widget.lName,
                            longitude: widget.longitude,
                            latitude: widget.latitude,
                          ),
                        ),
                      );
                    }
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
                child: Card(
                  color: ConstantColor.profileGridBGolor,
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: screenHeight/50),
                    alignment: Alignment.center,
                    child: customeText(
                      text: isSeller == 1 ? "Seller Options".toUpperCase() : "Become a seller".toUpperCase(),
                      style: ConstantTextStyle.tabButtonTextStyle,
                    ),
                  ),
                ),
              ),
            ),
/*----------------ListView Separate start------------------------------------------*/
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: screenHeight/80.0,left: screenWidth/30.0,right: screenWidth/30.0),
              separatorBuilder: (context, index) => const Divider(
                  color: ConstantColor.primaryBlackColor, height: 2),
              itemCount: _listViewData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  minLeadingWidth: 10,
                  leading: Icon(_iconTypes[index],
                    color: ConstantColor.landingScreenSubHaddingColor,),
                  title: Text(
                    _listViewData[index],
                    style: ConstantTextStyle.allHomeScreenAvatarText,
                  ),
                  onTap: () async {
                    SharedPreferences preferences = await SharedPreferences.getInstance();
                    setState(() {
                      isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                      tokenAccess = preferences.getString("access-token");
                      isSeller = preferences.getInt("is_seller");
                      userName = preferences.getString("name");
                    });
                    switch (index) {

                      case 0:
/*---------------------------------Dialog Box start----------------------------------------*/
                        if (isUserLoggedIn) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                                icon: circleIcon(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  backgroundColor: ConstantColor.primaryMainColor,
                                  iconSize: 15.0,
                                  radius: 15.0,
                                  icons: Icons.close_outlined,
                                  iconcolor:
                                  ConstantColor.primaryBackgroundMainColor,
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: screenHeight/50),
                                iconPadding: EdgeInsets.only(
                                    left: screenWidth / 1.7,
                                    top: screenHeight / 150),
                                title: Center(
                                  child: ratingsStar(
                                    ignoreGestures: false,
                                    bgColor: ConstantColor.transparent1,
                                    initialRating: 0.0,
                                    itemSize: 40.0,
                                    minRating: 1.0,
                                    allowHalfRating: false,
                                    itemCount: 5,
                                    onRatingUpdate: (rating) {
                                      Navigator.of(context).pop();
                                      if (rating <  5.0) {
/*--------------------------Nested AlertBox start with builder --------------------------------*/
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return StatefulBuilder(
                                              builder: (context, setState) {
                                                return AlertDialog(
                                                  insetPadding: EdgeInsets.symmetric(horizontal: screenWidth /20,),
                                                  shape: const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                                  ),
                                                  titlePadding: EdgeInsets.symmetric(vertical: screenHeight/60,horizontal: screenWidth/40),
                                                  title: customeText(
                                                    text: "आपका Feed-Back हमारे लिए महत्वपूर्ण हैं | ",
                                                    style: ConstantTextStyle.feedBackHeadText,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  content: SizedBox(
                                                    width: double.maxFinite,
                                                    child:
                                                    Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        ListView.builder(
                                                          shrinkWrap: true,
                                                          itemCount: _hindiTextData.length,
                                                          itemBuilder: (BuildContext context, int index) {
                                                            return ListTile(
                                                              dense: true,
                                                              contentPadding: EdgeInsets.zero,
                                                              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                                                              leading:
                                                              customeCheckbox(
                                                                checkColor: ConstantColor.primaryBackgroundMainColor,
                                                                activeColor: ConstantColor.filedContainerColor,
                                                                value: checkBoxValues[index],
                                                                onChanged: (newValue) {
                                                                  setState(() {
                                                                    checkBoxValues[index] = newValue!;
                                                                    if (newValue == true) {
                                                                      selectedData +=
                                                                          (selectedData.isNotEmpty ? ',' : '') +
                                                                              (_hindiTextData[index].toString());
                                                                    } else {
                                                                      final List<String> selectedDataString =
                                                                      selectedData.split(',');
                                                                      selectedDataString.remove(
                                                                          _hindiTextData[index].toString());
                                                                      selectedData = selectedDataString.join(',');
                                                                    }
                                                                  });
                                                                },
                                                              ),
                                                              title: customeText(
                                                                text: _hindiTextData[index],
                                                                style: ConstantTextStyle.ratingText2,
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                        if (checkBoxValues[_hindiTextData.indexOf("अन्य")])
                                                          Padding(
                                                            padding:  EdgeInsets.symmetric(horizontal: screenWidth/30,vertical: screenHeight/80),
                                                            child: TextFormField(
                                                              controller: _textEditingController,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  selectedData = value;
                                                                });
                                                              },
                                                              autofocus: true,
                                                              decoration: InputDecoration(
                                                                hintText: 'अन्य कारण बताइये ?',
                                                                border: OutlineInputBorder(
                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                  borderSide: const BorderSide(color: ConstantColor.secondtryGrayColor),
                                                                ),
                                                                focusedBorder: OutlineInputBorder(
                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                  borderSide: const BorderSide(color: ConstantColor.primaryMainColor),
                                                                ),
                                                                filled: true,
                                                                fillColor:ConstantColor.boxGrayColor,
                                                                contentPadding: EdgeInsets.symmetric(horizontal:screenWidth/20),
                                                              ),
                                                              cursorColor: ConstantColor.primaryMainColor,
                                                              // Add more properties for validation, controller, etc.
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                  contentPadding: EdgeInsets.symmetric(horizontal: screenWidth/50),
                                                  actionsPadding: EdgeInsets.symmetric(vertical: screenHeight /80),
                                                  actions: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        customeButton(
                                                          textStyleButton: ConstantTextStyle.tabButtonTextStyle,
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                          },
                                                          text: "Cancel".toUpperCase(),
                                                          backgroundColor:
                                                          ConstantColor.homeScreenAvatarBGColor,
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          elevation: 2.0,
                                                        ),
                                                        SizedBox(width: screenWidth / 20),
                                                        customeButton(
                                                          // minimumSize: Size.fromHeight(screenHeight / 25),
                                                          textStyleButton:
                                                          ConstantTextStyle.loginButtonTextStyle,
                                                          onPressed: () {
                                                            // Check if at least one checkbox is selected
                                                            if (checkBoxValues.contains(true)) {
                                                              //this is toast
                                                              fetchFeedbackAPi();
                                                            } else {
                                                              // Show an error message or perform any other validation action
                                                              showDialog(
                                                                context: context,
                                                                builder: (context) {
                                                                  return AlertDialog(
                                                                    contentPadding: EdgeInsets.zero,
                                                                    title: customeText(
                                                                      text: "Validation Error!",
                                                                      style: ConstantTextStyle.secodHearText,
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                    content: customeText(
                                                                      text: "Please select at least one Option.",
                                                                      style: ConstantTextStyle.passwordScreenLineTexStyle,
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                    actions: [
                                                                      customeButton(
                                                                        textStyleButton:
                                                                        ConstantTextStyle.loginButtonTextStyle,
                                                                        onPressed: () {
                                                                          Navigator.pop(context);
                                                                        },
                                                                        text: "OK".toUpperCase(),
                                                                        backgroundColor:
                                                                        ConstantColor.primaryMainColor,
                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                        elevation: 2.0,
                                                                        minimumSize: Size(double.infinity, screenHeight/25),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            }
                                                          },
                                                          text: "Submit".toUpperCase(),
                                                          backgroundColor: ConstantColor.primaryMainColor,
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          elevation: 2.0,
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        );
/*--------------------------Nested AlertBox end with builder --------------------------------*/
                                      }
                                      else{
                                        _launchPlayStore();
                                      }
                                    },
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: ConstantColor.starRatingColor,
                                    ),
                                  ),
                                ),
                                content: customeText(
                                    text: "Do you like us? give 5 Star",
                                    style: ConstantTextStyle.cardbottumText,
                                    textAlign: TextAlign.center),
                              );
                            },
                          );
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
/*---------------------------------Dialog Box end----------------------------------------*/
                        break;
                      case 1:
                        if (isUserLoggedIn) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AdvertiseWithUsScreen()),
                          );
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
                        break;
                      case 2:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ContactUsScreen()),
                        );
                        break;
                      case 3:
                        shareFile();
                        break;
                      case 4:
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const CBOShareAppScreen();
                          },
                        );
                        break;
                        case 5:
                        _joinWhatsAppGroup();
                        break;
                      case 6:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FAQScreen()),
                        );
                        break;
                      case 7:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutUsScreen()),
                        );
                        break;
                      case 8:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TermOfUseScreen()),
                        );
                        break;
                      case 9:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PrivacyPolicyScreen()),
                        );
                        break;
                   //   case 9:
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => DashBoardScreen(
                      //         id: widget.id??"",
                      //         lName: widget.lName??"",
                      //         latitude: widget.latitude??"",
                      //         longitude: widget.longitude??"",
                      //       )),
                      // );
                     //   break;
                      default:
                        break;
                    }
                  },
                  trailing: const Icon(Icons.arrow_circle_right_outlined,
                    color: ConstantColor.landingScreenSubHaddingColor,),
                );
              },
            ),
/*------------------ListView Separate end---------------------------------*/
            SizedBox(height: screenHeight/13),
          ],
        ),
      )
      );
  }
}

class LogoutDialog {
  static Future<bool> showExitConfirmationDialog(BuildContext context,logoutOnPress) async {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(18.0)),
        ),
        backgroundColor: ConstantColor.primaryBackgroundMainColor,
        title: const Text('Please confirm!'),
        content: const Text('Are you sure you want to Logout?'),
        contentPadding: EdgeInsets.symmetric(horizontal: screenWidth/30),
        titlePadding: EdgeInsets.symmetric(horizontal: screenWidth/30,vertical: screenHeight/60),
        // contentPadding: EdgeInsets.symmetric(horizontal: screenWidth/20),
        actions: [
          TextButton(
            onPressed: logoutOnPress,
            style: ElevatedButton.styleFrom(
              backgroundColor: ConstantColor.primaryBackgroundMainColor,
            ),
            child: Text('Logout', style: ConstantTextStyle.hintTextStyle2),
          ),
          const SizedBox(width: 10.0,),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            // style: ElevatedButton.styleFrom(
            //   //backgroundColor: ConstantColor.primaryBackgroundMainColor,
            // ),
            child: const Text('Exit'),
          ),
        ],
      ),
    ) ?? false;
  }
}

void showFeedbackDialog(BuildContext context) {
  final TextEditingController textEditingController = TextEditingController();
  var userId;
  var tokenAccess;
  String selectedData = '';
  fetchFeedbackAPi() async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      tokenAccess = preference.getString("access-token");
      final body = {
        "user_id": userId,
        "feedback": [
          selectedData
        ]
      };
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.feedBackApi}",
        options: Options(
          headers: {
            "Authorization": tokenAccess,
            'Content-Type': 'application/json',
          },
        ),
        data: json.encode(body),
      );

      if (response.statusCode == 200) {
          awesomeTost(context, 'Feedback Submitted Successfully');

      } else {
      }
    } catch (error) {}
  }
  void launchPlayStore() async {
    const playStoreLink = 'https://play.google.com/store/apps/details?id=com.citybazaronline&pcampaignid=web_share';

    if (await canLaunch(playStoreLink)) {
      await launch(playStoreLink);
    } else {
      throw 'Could not launch $playStoreLink';
    }
  }
  final List<String> hindiTextData = [
    "मुझे ऐप कांसेप्ट समझ नहीं आया |",
    "ऐप को ऑपरेट करना कठिन हैं |",
    "मुझे अपनी पसंद का प्रोडक्ट नहीं मिला |",
    "अन्य",
  ];
  List<bool> checkBoxValues = List.generate(4, (index) => false);
  var screenWidth = MediaQuery.of(context).size.width;
  var screenHeight = MediaQuery.of(context).size.height;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius:
            BorderRadius.all(Radius.circular(20.0))),
        icon: circleIcon(
          onPressed: () {
            SystemNavigator.pop();
          },
          backgroundColor: ConstantColor.primaryMainColor,
          iconSize: 15.0,
          radius: 15.0,
          icons: Icons.close_outlined,
          iconcolor:
          ConstantColor.primaryBackgroundMainColor,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: screenHeight/50),
        iconPadding: EdgeInsets.only(
            left: screenWidth / 1.7,
            top: screenHeight / 150),
        title: Center(
          child: ratingsStar(
            ignoreGestures: false,
            bgColor: ConstantColor.transparent1,
            initialRating: 0.0,
            itemSize: 40.0,
            minRating: 1.0,
            allowHalfRating: false,
            itemCount: 5,
            onRatingUpdate: (rating) {
              Navigator.of(context).pop();
             if (rating <  5.0) {
 /*--------------------------Nested AlertBox start with builder --------------------------------*/
               showDialog(
                 context: context,
                 builder: (context) {
                   return StatefulBuilder(
                     builder: (context, setState) {
                       return AlertDialog(
                         shape: const RoundedRectangleBorder(
                           borderRadius: BorderRadius.all(Radius.circular(20.0)),
                         ),
                         titlePadding: EdgeInsets.symmetric(vertical: screenHeight/60,horizontal: screenWidth/40),
                         title: customeText(
                           text: "आपका Feed-Back हमारे लिए महत्वपूर्ण हैं | ",
                           style: ConstantTextStyle.feedBackHeadText,
                           textAlign: TextAlign.center,
                         ),
                         content: SizedBox(
                           width: double.maxFinite,
                           child:
                           Column(
                             mainAxisSize: MainAxisSize.min,
                             children: [
                               ListView.builder(
                                 shrinkWrap: true,
                                 itemCount: hindiTextData.length,
                                 itemBuilder: (BuildContext context, int index) {
                                   return ListTile(
                                     dense: true,
                                     contentPadding: EdgeInsets.zero,
                                     visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                                     leading:
                                     customeCheckbox(
                                       checkColor: ConstantColor.primaryBackgroundMainColor,
                                       activeColor: ConstantColor.filedContainerColor,
                                       value: checkBoxValues[index],
                                       onChanged: (newValue) {
                                         setState(() {
                                           checkBoxValues[index] = newValue!;
                                           if (newValue == true) {
                                             selectedData +=
                                                 (selectedData.isNotEmpty ? ',' : '') +
                                                     (hindiTextData[index].toString());
                                           } else {
                                             final List<String> selectedDataString =
                                             selectedData.split(',');
                                             selectedDataString.remove(
                                                 hindiTextData[index].toString());
                                             selectedData = selectedDataString.join(',');
                                           }
                                         });
                                       },
                                     ),
                                     title: customeText(
                                       text: hindiTextData[index],
                                       style: ConstantTextStyle.ratingText2,
                                     ),
                                   );
                                 },
                               ),
                               if (checkBoxValues[hindiTextData.indexOf("अन्य")])
                                 Padding(
                                   padding:  EdgeInsets.symmetric(horizontal: screenWidth/30,vertical: screenHeight/80),
                                   child: TextFormField(
                                     controller: textEditingController,
                                     onChanged: (value) {
                                       setState(() {
                                         selectedData = value;
                                       });
                                     },
                                     autofocus: true,
                                     decoration: InputDecoration(
                                       // labelText: 'Others',
                                       hintText: 'अन्य कारण बताइये ?',
                                       border: OutlineInputBorder(
                                         borderRadius: BorderRadius.circular(10.0),
                                         borderSide: const BorderSide(color: ConstantColor.secondtryGrayColor),
                                       ),
                                       focusedBorder: OutlineInputBorder(
                                         borderRadius: BorderRadius.circular(10.0),
                                         borderSide: const BorderSide(color: ConstantColor.primaryMainColor),
                                       ),
                                       filled: true,
                                       fillColor:ConstantColor.boxGrayColor,
                                       contentPadding: EdgeInsets.symmetric(horizontal:screenWidth/20),
                                     ),
                                     cursorColor: ConstantColor.primaryMainColor,
                                     // Add more properties for validation, controller, etc.
                                   ),
                                 ),
                             ],
                           ),
                         ),
                         contentPadding: EdgeInsets.symmetric(horizontal: screenWidth/50),
                         // actionsPadding: EdgeInsets.symmetric(vertical: screenHeight / 40),
                         actions: [
                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               customeButton(
                                 textStyleButton: ConstantTextStyle.tabButtonTextStyle,
                                 onPressed: () {
                                   Navigator.of(context).pop();
                                 },
                                 text: "Cancel".toUpperCase(),
                                 backgroundColor:
                                 ConstantColor.homeScreenAvatarBGColor,
                                 borderRadius: BorderRadius.circular(8.0),
                                 elevation: 2.0,
                               ),
                               SizedBox(width: screenWidth / 20),
                               customeButton(
                                 textStyleButton:
                                 ConstantTextStyle.loginButtonTextStyle,
                                 onPressed: () {
                                   // Check if at least one checkbox is selected
                                   if (checkBoxValues.contains(true)) {
                                     //this is toast
                                     fetchFeedbackAPi();
                                   } else {
                                     // Show an error message or perform any other validation action
                                     showDialog(
                                       context: context,
                                       builder: (context) {
                                         return AlertDialog(
                                           contentPadding: EdgeInsets.zero,
                                           title: customeText(
                                             text: "Validation Error!",
                                             style: ConstantTextStyle.secodHearText,
                                             textAlign: TextAlign.center,
                                           ),
                                           content: customeText(
                                             text: "Please select at least one Option.",
                                             style: ConstantTextStyle.passwordScreenLineTexStyle,
                                             textAlign: TextAlign.center,
                                           ),
                                           actions: [
                                             customeButton(
                                               textStyleButton:
                                               ConstantTextStyle.loginButtonTextStyle,
                                               onPressed: () {
                                                 Navigator.pop(context);
                                               },
                                               text: "OK".toUpperCase(),
                                               backgroundColor:
                                               ConstantColor.primaryMainColor,
                                               borderRadius: BorderRadius.circular(8.0),
                                               elevation: 2.0,
                                               minimumSize: Size(double.infinity, screenHeight/25),
                                             ),
                                           ],
                                         );
                                       },
                                     );
                                   }
                                 },
                                 text: "Submit".toUpperCase(),
                                 backgroundColor: ConstantColor.primaryMainColor,
                                 borderRadius: BorderRadius.circular(8.0),
                                 elevation: 2.0,
                               ),
                             ],
                           )
                         ],
                       );
                     },
                   );
                 },
               );
/*--------------------------Nested AlertBox end with builder --------------------------------*/
             }else{
               launchPlayStore();
             }
            },
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: ConstantColor.starRatingColor,
            ),
          ),
        ),
        content: customeText(
            text: "Do you like us? give 5 Star",
            style: ConstantTextStyle.cardbottumText,
            textAlign: TextAlign.center),
      );
    },
  );
}