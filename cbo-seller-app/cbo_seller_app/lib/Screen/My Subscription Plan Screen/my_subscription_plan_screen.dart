// ignore_for_file: non_constant_identifier_names

import 'package:citybazaronline_seller_app/Widget/Chips/title_with_chip_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../Layouts/constant_screen_layout.dart';
import '../../Models/subscription_plan_model.dart';
import '../../Services/subscription_plan_api_services.dart';
import '../../Utils/Constant Size /constant_sizes.dart';
import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';
import '../../Widget/Custome Buttons/elevetion_button_widget.dart';
import '../../Widget/custome_text_widget.dart';
import '../../Widget/refresh_footer_message.dart';
import '../../Widget/span_title_text_widget.dart';
import 'payment_history_screen.dart';

class MySubscriptionPlanScreen extends StatefulWidget {
  const MySubscriptionPlanScreen({super.key});

  @override
  State<MySubscriptionPlanScreen> createState() => _MySubscriptionPlanScreenState();
}

class _MySubscriptionPlanScreenState extends State<MySubscriptionPlanScreen> {

  @override
  void initState() {
    super.initState();
    fetchSubscriptionPlanData();
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

  String planNameKey = '';
  String planValidityKey = '';
  String planStartDateKey = '';
  String planEndDateKey = '';
  String planExpiryDayKey = '';
  String planDescriptionKey = '';
  String planTypeKey = '';
  String planStatusKey = '';
  String planAmountKey = '';
  String planSpaceProductKey = '';


  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  SubscriptionPlanModel? subscriptionPlanModel;
  List<SubscriptionPlanData>? data = [];
  List<AllSubsData>? allSubsData = [];

  // Map<String, dynamic> paymentHistoryData = {}; // Define a map to hold the data
  Future<void> fetchSubscriptionPlanData() async {
    try {
      if (currentPage == 1) {
        setState(() {
          isLoading = true;
          data!.clear();
          allSubsData!.clear();
        });
      }

      final subscriptionPlanResponse = await SubscriptionApiService.fetchSubscriptionPlanData(context: context);

      if (subscriptionPlanResponse != null && subscriptionPlanResponse.data != null) {
        final dataList = subscriptionPlanResponse.data!;

        setState(() {
          planNameKey = dataList.msubsData!.planDetails!.subscriptionName.toString()??'';
          planStartDateKey = dataList.msubsData!.sbuscriptionStartDate.toString()??'';
          planEndDateKey = dataList.msubsData!.sbuscriptionEndDate.toString()??'';
          planDescriptionKey = dataList.msubsData!.planDetails!.subscriptionDetails.toString()??'';
          planTypeKey = dataList.msubsData!.planType.toString()??'';
          planStatusKey = dataList.msubsData!.paymentStatus.toString()??'';
          planAmountKey = dataList.msubsData!.planAmt.toString()??'';
          //------------Subscription-plan-right-side-data---------
          planRightSideData[1] = dataList.msubsData!.planDetails!.noOfProductAllowed.toString()??'';
          planRightSideData[2] = dataList.msubsData!.planDetails!.executeVisitUploads.toString()??'';
          planRightSideData[3] = dataList.msubsData!.planDetails!.topProduct.toString()??'';
          planRightSideData[4] = dataList.msubsData!.planDetails!.shopInFocus.toString()??'';
          planRightSideData[6] = dataList.msubsData!.planDetails!.wantToBuyLimit.toString() == "1"?"Yes":"No"??"";
          planRightSideData[9] = dataList.msubsData!.planDetails!.discountSection.toString() == "1"?"Yes":"No"??"";
          planRightSideData[10] = dataList.msubsData!.planDetails!.noOfProductAllowed.toString()??'';
          planRightSideData[12] = dataList.msubsData!.planDetails!.visitorAnalytics.toString()??'';
          planRightSideData[16] = dataList.msubsData!.planDetails!.socialBoosting.toString()??'';
          planValidityKey = DateFormat('dd MMMM yyyy', 'en_US').format(
              DateTime.parse(planStartDateKey).add(const Duration(days: 365)));

          //-----------order-plan-right-side-data------------
          orderDetailsRightSideDataList[0] =  dataList.msubsData!.orderId.toString()??'';
          orderDetailsRightSideDataList[1] =  planStartDateKey ??'';
          orderDetailsRightSideDataList[2] =  planStatusKey ??'';
          orderDetailsRightSideDataList[3] =  planAmountKey ??'';
          orderDetailsRightSideDataList[4] =  planStartDateKey ??'';
          orderDetailsRightSideDataList[5] =  planEndDateKey ??'';
          orderDetailsRightSideDataList[6] =  "$planExpiryDayKey Days" ??'';

          allSubsData!.addAll(dataList.allSubsData ?? []);
        });
        //----------remaining days calculation start------------
        setState(() {
          DateTime expDate = DateTime.parse(planEndDateKey);
          DateTime currentDate = DateTime.now();
          Duration remainingDuration = expDate.difference(currentDate);
          planExpiryDayKey = remainingDuration.inDays.toString()??'';
        });
        //----------remaining days calculation end------------

        setState(() {
          if (currentPage == 1) {
            data = [dataList];
          }
          else {
            data!.addAll([dataList]);
            _refreshController.loadComplete();


          }
          isLoading = !isLoading;
          currentPage++;
        });
      } else {
        // No more data available
        setState(() {
          isLoading = !isLoading;
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

//-----------subscription plan details listing data------------
  List<String> planLeftSideData = [
    'Shop Registration',
    'Space For Products',
    'Executive Visit for product uploading',
    'Top Product',
    'Shop in focus',
    'Like Product',
    'Want To Buy Info',
    'Wishlist',
    'Sharing by seller (Product, Shop)',
    'Discount Section (sale offer)',
    'Sharing by seller (Product, Shop)',
    'Chat Function',
    'Visitor analytics',
    'Unlimited device',
    'Unlimited visitor',
    'citybazaronline shop URL',
    'Promotional Video',
    'Online Market Place',
  ];

  List<String> planRightSideData = [
    'Lifetime',
    '0',
    '0',
    '0',
    'No',
    'Unlimited',
    'No',
    'Unlimited',
    'Unlimited',
    'No',
    '10',
    'Yes',
    'No',
    'Yes',
    'Yes',
    'Yes',
    '0',
    'Yes'
  ];

//-----------order details listing data --------------------

  List<String> orderDetailsLeftSideDataList = [
    'Order No.',
    'Order Date',
    'Order Status',
    'Amount Paid',
    'Subscription Start Date',
    'Subscription End Date',
    'No of Days left',
  ];

  List<String> orderDetailsRightSideDataList =[
    '- - - - - -',
    '00-00-0000',
    '- - - -',
    '00.00',
    '00-00-0000',
    '00-00-0000',
    '00 Days',
  ];



  bool isExpanded = false;
  final TextEditingController searchController = TextEditingController();
  bool isDetails = false;



  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return AppLayout(
        title: "My Subscription Plan",
        titleStyle: ConstantTextStyle.landingScreenAppbarText,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), color: ConstantColor.primaryBackgroundMainColor,
          onPressed: () => Navigator.pop(context),
        ),
        scaffoldColor: ConstantColor.primaryBackgroundMainColor,
        appBarColor: ConstantColor.loginWithOtpButtonColor,
        body:
        // Container()
      // isLoading
      //     ? const Center(child: CircularProgressIndicator())
      //     :
      CupertinoScrollbar(
        controller: _scrollController,
        child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            controller: _refreshController,
            footer: customFooter(),
            onRefresh: () async {
              currentPage = 1;
              await fetchSubscriptionPlanData();
              _refreshController.refreshCompleted();
            },
            child: Skeletonizer(
              enabled: isLoading,
              child: ListView(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: screenWidth/30,vertical: screenHeight/60),
                children: [
                  customeText(text: "\tMy Subscription Plan",style: ConstantTextStyle.topCategoryText4),
                  constantHeight(context, 80.0),
                  //--------my sub plan ----

                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),
                      color: ConstantColor.sellerBGColor,
                    ),
                    padding: EdgeInsets.symmetric(vertical: screenHeight/80.0,horizontal: screenWidth/40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customeText(text: "My Active Plans",style: ConstantTextStyle.topCategoryText),
                        constantHeight(context, 100.0),

                        customButton(
                          textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                          onPressed: (){
                            setState(() {
                              isDetails = !isDetails;
                            });
                          },
                          text: 'Details',
                          backgroundColor: ConstantColor.primaryMainColor,
                          borderRadius: BorderRadius.circular(6.0),
                          minimumSize: Size(screenWidth/20, screenHeight/24),
                          elevation: 1.0,
                        ),

                        constantHeight(context, 100.0),

                        customeText(text: planNameKey??'',style: ConstantTextStyle.topCategoryText),

                        constantHeight(context, 100.0),

                        Row(
                       children: [
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             titleWithChipWidget(
                               context: context,
                               text: "Validity Upto\t\t-\t",
                               chipTitle: planValidityKey??'',
                               style: ConstantTextStyle.becomeSellerDiscText,
                             ),
                             titleWithChipWidget(
                               context: context,
                               text: "Your plan will Expire in\t\t-\t",
                               chipTitle: "${planExpiryDayKey??""} Days",
                               style: ConstantTextStyle.becomeSellerDiscText,
                             ),
                             titleWithChipWidget(
                               context: context,
                               text: "Description\t\t-\t",
                               chipTitle: planDescriptionKey??'',
                               chipTextStyle: ConstantTextStyle.topCategoryText2,
                               chipBackgroundColor: ConstantColor.primaryBackgroundMainColor,
                               style: ConstantTextStyle.becomeSellerDiscText,
                             ),
                             titleWithChipWidget(
                               context: context,
                               text: "Plan Type\t\t-\t",
                               chipTitle: planTypeKey??'',
                               chipTextStyle: ConstantTextStyle.topCategoryText2,
                               chipBackgroundColor: ConstantColor.primaryBackgroundMainColor,
                               style: ConstantTextStyle.becomeSellerDiscText,
                             ),
                             titleWithChipWidget(
                               context: context,
                               text: "Plan Status\t\t-\t",
                               chipTitle: planStatusKey??'',
                               chipTextStyle: ConstantTextStyle.topCategoryText2,
                               chipBackgroundColor: ConstantColor.primaryBackgroundMainColor,
                               style: ConstantTextStyle.becomeSellerDiscText,
                             ),
                           ],
                         ),
                       ]

                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                        Flexible(
                              child: customButton(
                                textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                                onPressed: () async{await Navigator.pushNamed(context, '/purchaseRenewPlanScreen');},
                                text: 'Upgrade',
                                backgroundColor: ConstantColor.primaryMainColor,
                                borderRadius: BorderRadius.circular(6.0),
                                elevation: 1.0,
                                minimumSize: Size(screenWidth/2.5, screenHeight/25),
                              ),
                            ),
                            Flexible(
                              child: customButton(
                                textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                                onPressed: () async{await Navigator.pushNamed(context, '/purchaseRenewPlanScreen');},
                                text: 'New Plan/Renew',
                                backgroundColor: ConstantColor.loginWithOtpButtonColor,
                                minimumSize: Size(screenWidth/2.5, screenHeight/24),
                                borderRadius: BorderRadius.circular(6.0),
                                elevation: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  //-------- hide details 1st  data -------
                  // constantHeight(context, 50.0),
                  isDetails ? Container(
                    margin: EdgeInsets.symmetric(vertical: screenHeight/50.0),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),
                        color: ConstantColor.primaryBackgroundMainColor,
                        border: Border.all(color: ConstantColor.sellerBGColor,width: 4.0)),
                    child: ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: screenWidth/40.0),
                      title: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0),
                          color: ConstantColor.calendarBGHeadColor,),
                        padding: EdgeInsets.symmetric(vertical: screenHeight/80.0,horizontal: screenWidth/40.0),

                        child: titleWithChipWidget(
                          context: context,
                          text: "Subscription Name\t\t-\t",
                          chipTitle: planNameKey??'',
                          chipTextStyle: ConstantTextStyle.topCategoryText2,
                          chipBackgroundColor: ConstantColor.primaryBackgroundMainColor,
                          style: ConstantTextStyle.tabButtonTextStyle,
                        ),
                      ),
                      subtitle:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          richTextWithSpanWidget(
                            firstText: 'Descripation - ${planDescriptionKey??''}\t\t-\t',
                            firstTextStyle: ConstantTextStyle.allHomeScreenAvatarText,
                            context: context,
                            widgetSpans: customeText(
                            text: '\u20B9 ${planAmountKey??''} /',
                              style: ConstantTextStyle.tabButtonTextStyle,
                            ),
                          ),
                          ListView.separated(
                            padding: EdgeInsets.only(top: screenHeight/30),
                            physics: const NeverScrollableScrollPhysics(), // Disable scrolling of the inner ListView
                            shrinkWrap: true,
                            itemCount: planLeftSideData.length,
                            itemBuilder: (context, int index) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  customeText(
                                    text: planLeftSideData[index],
                                    style: ConstantTextStyle.allHomeScreenAvatarText,
                                  ),

                                  Container(
                                    decoration: BoxDecoration(
                                        color: ConstantColor.primaryMainColor,
                                        borderRadius: BorderRadius.circular(5.0)),
                                    child: customeText(text: '\t${planRightSideData[index]}\t',
                                        style:ConstantTextStyle.chipText),)

                                ],
                              );
                            },
                            separatorBuilder: (context, position) {
                              return const Divider(
                                color: ConstantColor.locationIconColor,
                                height: 40,
                                thickness: 1,
                              );
                            },
                          ),
                        ],
                      ),

                    ),
                  ) : Container(),

                  //-------- hide details 2nd data -------
                  // constantHeight(context, 50.0),
                  isDetails ? Container(
                      margin: EdgeInsets.symmetric(vertical: screenHeight/50.0),
                      padding: EdgeInsets.symmetric(vertical: screenHeight/80.0,horizontal: screenWidth/40.0),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),
                        color: ConstantColor.primaryBackgroundMainColor,
                        border: Border.all(color: ConstantColor.sellerBGColor,width: 4.0)),
                    child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.maxFinite,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0),
                                  color: ConstantColor.calendarBGHeadColor,),
                                padding: EdgeInsets.symmetric(vertical: screenHeight/80.0,horizontal: screenWidth/40.0),

                                child: customeText(text: 'Order Details',
                                style:ConstantTextStyle.tabButtonTextStyle, )),

                              ListView.separated(
                                padding: EdgeInsets.only(top: screenHeight/30),
                                physics: const NeverScrollableScrollPhysics(), // Disable scrolling of the inner ListView
                                shrinkWrap: true,
                                itemCount: orderDetailsLeftSideDataList.length,
                                itemBuilder: (context, int index) {
                                  return Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      customeText(
                                        text: orderDetailsLeftSideDataList[index],
                                        style: ConstantTextStyle.allHomeScreenAvatarText,
                                      ),

                                      Container(
                                        decoration: BoxDecoration(
                                            color: ConstantColor.primaryMainColor,
                                            borderRadius: BorderRadius.circular(5.0)),
                                        child: customeText(text: '\t${orderDetailsRightSideDataList[index]}\t',
                                            style:ConstantTextStyle.chipText),)
                                    ],
                                  );
                                },
                                separatorBuilder: (context, position) {
                                  return const Divider(
                                    color: ConstantColor.locationIconColor,
                                    height: 40,
                                    thickness: 1,
                                  );
                                },
                              ),
                            ],
                          )
                  ) : Container(),

                  //--------Notes section  ------
                  isDetails ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: customeText(text: "Note : To continue with City Bazar please renew your subscription plan before expiry date.",
                    style: ConstantTextStyle.allHomeScreenAvatarText),
                  ): Container(),
                  //--------explore more section  ------
                  isDetails ?  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: customButton(
                      textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                      onPressed: () async{await Navigator.pushNamed(context, '/purchaseRenewPlanScreen');},
                      text: 'Explore More Plans',
                      backgroundColor: ConstantColor.primaryMainColor,
                      borderRadius: BorderRadius.circular(6.0),
                      minimumSize: Size(screenWidth/20, screenHeight/24),
                      elevation: 1.0,
                    ),
                  ) : Container(),
                  //--------my sub history ------
                  constantHeight(context, 50.0),
                  Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0),
                        color: ConstantColor.sellerBGColor,),
                      padding: EdgeInsets.symmetric(vertical: screenHeight/80.0,horizontal: screenWidth/40.0),
                    height: screenHeight/2.7,
                      child: PaymentHistoryScreen(allSubsData: allSubsData!)),
                ],
              ),
            )
        ),
      )
    );
  }
}








