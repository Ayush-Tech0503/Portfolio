// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Models/dashboard_model.dart';
import '../../Services/dashboard_api_services.dart';
import '../../Utils/Constant Size /constant_sizes.dart';
import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';
import '../../Widget/Custome Buttons/elevetion_button_widget.dart';
import '../../Widget/custome_text_widget.dart';
import '../../Widget/images/cached_images_widget.dart';
import '../../Widget/seller_details_widget.dart';

class SellerDashboardScreen extends StatefulWidget {
  const SellerDashboardScreen({super.key});

  @override
  State<SellerDashboardScreen> createState() => _SellerDashboardScreenState();
}

class _SellerDashboardScreenState extends State<SellerDashboardScreen> {

  @override
  void initState() {
    super.initState();
    fetchDashBoardListData();
    isSellerSlug();
  }

  bool isLoading = false;
  DashboardData? dashboardModel;
  CountFollowerSeller? countFollowerSeller;
  // SellerData? sellerData;

  var myPlanDetails = '';
  var subStartDate = '';
  var subEndDate = '';
  var storeName = '';
  var storeAddress = '';
  var storeRating = '';
  var storeMobile = '';
  var SubPlanName = '';
  var SubPlanExpDate = '';
  var SubPlanStartDate = '';
  var SubPlanRemainingDate = '';
  var storeImage = '';

  fetchDashBoardListData() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Call API function to fetch data
      final dashboardResponse = await ApiService.fetchDashboardData(context);
      setState(() {
        storeMobile = dashboardResponse!.storeContactNo.toString()??'';
        storeName = dashboardResponse!.storeName.toString()??'';
        storeAddress = dashboardResponse!.storeAddress.toString()??'';
        _textData = [storeName??'', storeAddress??'', storeMobile??''];
        storeRating = dashboardResponse!.countSellerRating.toString()??'';
        storeImage = dashboardResponse!.imageFile.toString()??'';
        SubPlanName = dashboardResponse!.SubPlanName.toString()??'';
        SubPlanExpDate = dashboardResponse!.SubPlanExpDate.toString()??'';
        SubPlanStartDate = dashboardResponse!.SubPlanStartDate.toString()??'';
        //----------remaining days calculation start------------
        DateTime expDate = DateTime.parse(SubPlanExpDate);
        DateTime currentDate = DateTime.now();
        Duration remainingDuration = expDate.difference(currentDate);
        String remainingDays = remainingDuration.inDays.toString()??'';
        //----------remaining days calculation end------------
        _subText = [SubPlanName, SubPlanExpDate, '$remainingDays Days'];
        dashboardModel = dashboardResponse!.dashboardData;
        countFollowerSeller = dashboardResponse!.countFollowerSeller;
        _counts = [
          // dashboardModel!.wnatBuyCount.toString() ?? '0',
          // dashboardModel!.wnatSellCount.toString() ?? "0",
          dashboardModel!.orderCount.toString() ?? "0",
          dashboardModel!.likedCount ?? "0",
          dashboardModel!.productCount ?? '0',
          dashboardModel!.approvedCount ?? "0",
          dashboardModel!.pendingCount ?? "0",
          dashboardResponse!.countSellerRating.toString() ?? "0",
          countFollowerSeller!.countFollowerSeller.toString() ?? '0',
          dashboardModel!.reelCount.toString() ?? '0',
        ];
        isLoading = !isLoading;
      });
    } catch (e) {
      //
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }




/*--------------------------------Dashboard list start--------------------------------------*/
  List<String> _counts = [
    // "0".toUpperCase(),
    "0".toUpperCase(),
    "0".toUpperCase(),
    "0".toUpperCase(),
    "0".toUpperCase(),
    "0".toUpperCase(),
    "0".toUpperCase(),
    "0".toUpperCase(),
    "0".toUpperCase(),
  ];


  final List<String> _names = [
    // "Pending order".toUpperCase(),
    // "completed order".toUpperCase(),
    "Orders".toUpperCase(),
    "Liked Product".toUpperCase(),
    "uploaded product".toUpperCase(),
    "Approved product".toUpperCase(),
    "pending product".toUpperCase(),
    "store review rating".toUpperCase(),
    "follower seller".toUpperCase(),
    "uploaded video".toUpperCase(),
  ];

  final List<IconData> _rightHendIcons = [
    // Icons.pending_actions_outlined,
    // Icons.check_circle_outline,
    CupertinoIcons.cube_box,
    Icons.thumb_up_alt_outlined,
    Icons.file_upload_outlined,
    Icons.inventory_2_outlined,
    Icons.history_outlined,
    Icons.grade_outlined,
    Icons.message_outlined,
    Icons.video_library_outlined,
    // Add more icons...
  ];
/*--------------------------------Dashboard list end--------------------------------------*/

  List<String> _textData = [
    "Store Name",
    "Address",
    "Mobile no."
  ];

  final List<IconData> _iconData = [
    Icons.storefront,
    Icons.location_on_outlined,
    Icons.phone_outlined,
  ];

  /*-------------------------store detail List data start --------------------------*/
  final List<String> _headText = [
    "My Subscription Plan".toUpperCase(),
    "Expire On".toUpperCase(),
    "Remaining Days".toUpperCase(),
  ];

  List<String> _subText = ['','','0 Days'];

  final List<IconData> _leftHandIcon = [
    Icons.list_alt_outlined,
    Icons.history_outlined,
    Icons.event_note_outlined,
    // Add more icons...
  ];

  /*----------------------------- store detail List data end--------------------------*/
  storeLink ({url}) async {await launch('$url');}
  String storeSlug = '';

  void isSellerSlug() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    setState(() {
      storeSlug = preference.getString("store_slug") ?? '';
    });
  }


  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return CupertinoScrollbar(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: screenHeight/80,horizontal: screenWidth/30,),
        child: Skeletonizer(
          enabled: isLoading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customeText(
                text: "Store Detail".toUpperCase(),
                overflow: TextOverflow.ellipsis,
                style: ConstantTextStyle.homeScreenHeadingText1,
              ),

              /*---------------------------------Store Image start----------------------------------------------*/
              Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight/80),
                  child: cachedImageWidget(
                    context:context,
                    height: screenHeight/6,
                    width: screenWidth,
                    imageFile: storeImage,
                  )
              ),
              /*-------------------------icon and Text in row start------------------------------------*/
              Row(
                children: [
                  Icon(
                    _iconData[0],
                    color: ConstantColor.primaryMainColor,
                    size: 20,
                  ),
                  constantWidth(context,60.0),
                  customeText(
                      text: _textData[0],
                      style: ConstantTextStyle.becomeSellerDiscText,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis
                  ),
                  constantWidth(context,20.0),
                  Icon(
                    _iconData[1],
                    color: ConstantColor.primaryMainColor,
                    size: 20,
                  ),
                  constantWidth(context,60.0),
                  customeText(
                    text: _textData[1],
                    style: ConstantTextStyle.becomeSellerDiscText,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                  constantWidth(context,20.0),
                  Icon(
                    _iconData[2],
                    color: ConstantColor.primaryMainColor,
                    size: 20,
                  ),
                  constantWidth(context,60.0),
                  Expanded(
                    child: customeText(
                      text:"+91 ${_textData[2]}",
                      style: ConstantTextStyle.becomeSellerDiscText,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              /*-------------------------icon and Text in row end------------------------------------*/
              /*---------------------------------------Store Image end-------------------------------------------------*/
              constantHeight(context, 100.0),
              /*-----------------------------ListTile Two Buttons section start------------------------------------------*/
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customButton(
                      elevation: 0.5,
                      textStyleButton:
                      ConstantTextStyle.loginButtonTextStyle,
                      onPressed: () => Navigator.pushNamed(context, "/shopProfileInfoScreen"),
                      text: "Edit Store Profile",
                      backgroundColor: ConstantColor.loginWithOtpButtonColor,
                      borderRadius: BorderRadius.circular(8.0),
                      minimumSize: Size(screenWidth /2.3, screenHeight / 25.0)
                  ),
                  constantWidth(context, 50.0),
                  customButton(
                      elevation: 0.5,
                      textStyleButton: ConstantTextStyle.loginButtonTextStyle,
                      onPressed: () => storeLink(url: 'https://citybazaronline.com/indore/$storeSlug'),
                      text: "Store View As",
                      backgroundColor: ConstantColor.filedContainerColor,
                      borderRadius: BorderRadius.circular(8.0),
                      minimumSize: Size(screenWidth /2.3, screenHeight / 25.0)
                  ),
                ],
              ),
              /*-----------------------------ListTile Two Buttons section end------------------------------------------*/
              constantHeight(context, 80.0),
              /*-----------------------------Grid view start----------------------------------------------*/
              AnimationLimiter(
                child: GridView.builder(
                  physics: const PageScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 3,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2,
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 20.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    String subTitleText = _subText[index];
                    // String count = _counts[index];
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      columnCount: 2,
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: ConstantColor.locationIconColor,width: 0.5),
                              color: ConstantColor.sellerBGColor,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: storeDetailGrid(
                              context: context,
                              icons: _leftHandIcon[index],
                              iconBoxHeight: screenHeight / 20.0,
                              iconBoxWidth: screenWidth / 10.0,
                              headText: _headText[index],
                              headTextStyle: ConstantTextStyle.profileGridText,
                              subText: subTitleText,
                              subTextStyle: ConstantTextStyle.becomeSellerDiscText,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              /*-----------------------------Grid view  end----------------------------------------------*/
              constantHeight(context, 80.0),
              /*---------------------------Recharge Button start-------------------------------------------*/
              customButton(
                  elevation: 0.5,
                  textStyleButton:
                  ConstantTextStyle.loginButtonTextStyle,
                  onPressed: () async{await Navigator.pushNamed(context, '/purchaseRenewPlanScreen');},
                  text: "Recharge",
                  backgroundColor: ConstantColor.filedContainerColor,
                  borderRadius: BorderRadius.circular(8.0),
                  minimumSize: Size(screenWidth /2.3, screenHeight / 25.0)
              ),
              /*---------------------------Recharge Button end-------------------------------------------*/
              constantHeight(context, 80.0),
              /*-----------------------------Grid view start----------------------------------------------*/
              AnimationLimiter(
                child: GridView.builder(
                  physics: const PageScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _names.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2,
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 20.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      columnCount: 2,
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                          child: GestureDetector(
                            onTap: () {
                              switch (index) {
                                // case 0: Navigator.pushNamed(context, '/pendingOrderScreen');
                                // break;
                                // case 1: Navigator.pushNamed(context, '/completeOrderScreen');
                                // break;
                                case 0: Navigator.pushNamed(context, '/pendingOrderScreen');
                                break;
                                case 1: Navigator.pushNamed(context, '/likeProductScreen');
                                break;
                                case 2:  Navigator.pushNamed(context, '/uploadedProductScreen');
                                break;
                                case 3: Navigator.pushNamed(context, '/approvedPendingScreen');
                                break;
                                case 4: Navigator.pushNamed(context, '/pendingProductScreen');
                                break;
                                case 5:Navigator.pushNamed(context, '/shopReviewRatingScreen');  //ShopReviewRatingScreen
                                break;
                                case 6: Navigator.pushNamed(context, '/followerSellerScreen');
                                break;
                                case 7: Navigator.pushNamed(context, '/uploadVideoScreen');
                                break;
                                default:
                                  break;
                              }
                            },
                            child: profileGridView(
                              context: context,
                              title: customeText(
                                text: _counts[index],
                                style: ConstantTextStyle.countingText,
                              ),
                              subtitle: customeText(
                                text: _names[index],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: ConstantTextStyle.profileGridText,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                              iconBox: _rightHendIcons[index],
                              boxHeight: screenHeight / 20,
                              boxWidth: screenWidth / 10,
                              boxbgcolor: ConstantColor.primaryBackgroundMainColor,
                              iconsize: 25.0,
                              boxiconcolor: ConstantColor.primaryMainColor,
                              boxborderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

        /*-----------------------------Grid view  end----------------------------------------------*/
            ],
          ),
        ),
      ),
    );
  }
}

