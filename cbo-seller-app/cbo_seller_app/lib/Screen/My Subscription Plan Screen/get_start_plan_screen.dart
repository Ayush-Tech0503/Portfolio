// ignore_for_file: non_constant_identifier_names, deprecated_member_use, prefer_typing_uninitialized_variables
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../Models/Purchase New Plan Model/Emi Detail Model/subscription_plan_detail_model.dart';
import '../../Services/Purchase New Plan Api Services/Coupon Api/coupon_api_services.dart';
import '../../Services/Purchase New Plan Api Services/Emi Detail Api Services/get_emi_api_services.dart';
import '../../Services/Purchase New Plan Api Services/Purchase Plan/purchase_new_plan_api_service.dart';
import '../../Utils/Constant Size /constant_sizes.dart';
import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';
import '../../Widget/Check_boxs/check_box_widget.dart';
import '../../Widget/Custome Buttons/elevetion_button_widget.dart';
import '../../Widget/No Data Available/no_data_found.dart';
import '../../Widget/Radio Button/radio_list_tile_widget.dart';
import '../../Widget/Text Form Fields/global_text_form_field.dart';
import '../../Widget/custome_rich_text.dart';
import '../../Widget/custome_text_widget.dart';
import '../../Widget/refresh_footer_message.dart';
import '../../Widget/row_title _and _text_field_widget.dart';
import '../../Widget/row_two_title_text_widget.dart';

class GetSubPlanStartScreen extends StatefulWidget {
  const GetSubPlanStartScreen({super.key});

  @override
  State<GetSubPlanStartScreen> createState() => _GetSubPlanStartScreenState();
}

class _GetSubPlanStartScreenState extends State<GetSubPlanStartScreen> {
  final FocusNode _focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _subscriptionValue = false;
  bool _isGSTINUpdated = false;
  bool myBoarder = false;

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _referralCodeController = TextEditingController();
  final TextEditingController _couponCodeController = TextEditingController();

  var subscriptionIds = '';
  var productId = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments != null && arguments is Map) {
        setState(() {
          subscriptionIds = arguments['subscriptionId'] ?? '';
          productId = arguments['productId'] ?? '';
          fetchGetPlanStartData(subscriptionIds: subscriptionIds);
        });
      }
    });
    _focusNode.addListener(() {
      setState(() {
      });
    });

  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  var planName = '';
  var planDetails = '';
  var planAmount = '';
  var planEndDate = '';
  var planSubId = '';
  var state = '';
  var planExpiryDayKey = '0.0';
  double cgstAmount = 0.0;
  double igstAmount = 0.0;
  var totalAmount;
  var totalAmount2;


  void cgstCal(double planAmount) {
    if (planAmount != null) { // Check if planAmount is not null
      cgstAmount = (9 / 100) * planAmount;
      totalAmount = planAmount + cgstAmount + cgstAmount;
    } else {}
  }

  void igstCal(double planAmount) {
    if (planAmount != null) {
      igstAmount = (18 / 100) * planAmount;
      totalAmount2 = planAmount + igstAmount;
    } else {}
  }


  bool isPullToRefreshEnabled = true;
  int currentPage = 1;
  bool isLoading = false;
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  SubscriptionPlanDetailsModel? subscriptionPlanDetailsModel;
  // List<SubscriptionPlanDetailsData>? data = [];
  List<Map<String, dynamic>>? data;

  Future<void> fetchGetPlanStartData({required String subscriptionIds}) async {
    try {
      if (currentPage == 1) {
        setState(() {
          isLoading = true;
          data = []; // Initialize as an empty list of Map<String, dynamic>
        });
      }

      final subPlanDetailsResponse = await ApiGetEMIService.fetchGetEMIData(context: context, subscriptionIds: subscriptionIds);

      if (subPlanDetailsResponse != null && subPlanDetailsResponse['data'] != null) {
        final responseData = subPlanDetailsResponse['data'];

        setState(() {
          if (currentPage == 1) {
            // Ensure data is of type List<Map<String, dynamic>>
            data = (responseData['subs_data'] as List<dynamic>).cast<Map<String, dynamic>>();
          } else {
            data!.addAll((responseData['subs_data'] as List<dynamic>).cast<Map<String, dynamic>>());
          }
          isLoading = false;

          // Accessing plan details assuming data contains at least one element
          if (data != null && data!.isNotEmpty) {
            planName = "${data![0]['subscription_name'] ?? ""}";
            planAmount = "${data![0]['subscription_price'] ?? ""}";
            planDetails = "${data![0]['subscription_details'] ?? ""}";
            planSubId = "${data![0]['subscription_id'] ?? ""}";
            state = responseData['satus'] ?? "";

            cgstCal(double.parse(planAmount));
            igstCal(double.parse(planAmount));


            // Accessing plan end date from my_subs_data assuming it contains at least one element
            if (responseData['my_subs_data'] != null && responseData['my_subs_data'].isNotEmpty) {
              planEndDate = responseData['my_subs_data'][0]['sbuscription_end_date'] ?? "";
              //----------remaining days calculation start------------
              DateTime expDate = DateTime.parse(planEndDate);
              DateTime currentDate = DateTime.now();
              Duration remainingDuration = expDate.difference(currentDate);
              planExpiryDayKey = remainingDuration.inDays.toString()??'';
              //----------remaining days calculation end------------
            }
          }
        });
      } else {
        // Handle no data scenario
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }


//--------------------------------------
  //CouponsPaiService
  var discountVal ='';
  var extPlanDis ='';
  var payAmt ='';
  var tax;
  var totalAmt ='';
  Future<void> fetchCouponData({planCode,pid,plan}) async {
    try {
        setState(() {
          data!.clear();
          isLoading = true;
        });

      final couponResponse = await CouponsPaiService.fetchCouponsData(context: context,planCode: planCode??"", pid: pid??'', plan: plan?? '');
      if (couponResponse != null) {
        setState(() {
          discountVal =  couponResponse.discountVal??"";
          extPlanDis =  couponResponse.extPlanDis??"";
          payAmt =  couponResponse.payAmt??"";
          tax =  couponResponse.tax;
          totalAmt =  couponResponse.totalAmt??"";
          isLoading = false;
        });
      } else {
        // Handle no data scenario
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }
//--------------------------------------

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: ConstantColor.primaryBackgroundMainColor,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back), color: ConstantColor.primaryBackgroundMainColor,
            onPressed: () => Navigator.pop(context),
          ),

          title: customeText(
            text: "Buy Subscription Plan",
            style: ConstantTextStyle.landingScreenAppbarText,
          ),
          backgroundColor:ConstantColor.loginWithOtpButtonColor,
        ),
        body:  data == null || data!.toString().isEmpty ? noDataFound(context):
        Skeletonizer(
          enabled: isLoading,
          child: Form(
            key: _formKey,
            child: CupertinoScrollbar(
              child:  SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  controller: _refreshController,
                  footer: customFooter(),
                  onRefresh: () async {
                    currentPage = 1;
                    await fetchGetPlanStartData(subscriptionIds:subscriptionIds);
                    _refreshController.refreshCompleted();
                  },
                  child: ListView(
                    // controller: _scrollController,
                    padding: EdgeInsets.symmetric(horizontal: screenWidth/30,vertical: screenHeight/40),

                    children: [
                      customeText(text: "\tSubscription Order",style: ConstantTextStyle.topCategoryText4),
                      constantHeight(context, 60.0),

                      customeText(text: 'You Can Buy Only One Subscription Plan In Advance', style: ConstantTextStyle.colorsHeadingText),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: screenHeight/50.0),
                        padding: EdgeInsets.symmetric(horizontal: screenWidth/60.0,vertical: screenHeight/100.0),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),
                          color: ConstantColor.calendarBGHeadColor,
                          // border: Border.all(color: ConstantColor.sellerBGColor,width: 1.0)
                        ),
                        child: customeText(text: "Your current existing plan validity remaining - \n$planExpiryDayKey Days",
                            style: ConstantTextStyle.colorsHeadingText),
                      ),

                      customeText(text: planName??"", style: ConstantTextStyle.cardbottumText),

                      Divider(height: screenHeight/30.0,color: ConstantColor.calendarBGHeadColor,),

                      customeText(text: planDetails??"", style: ConstantTextStyle.colorsHeadingText),

                      Divider(height: screenHeight/30.0,color: ConstantColor.calendarBGHeadColor,),

                      rowTwoTitleTextWidget(title2: 'Plan amount : ₹ ${planAmount??""}'),
                      Divider(height: screenHeight/30.0,color: ConstantColor.calendarBGHeadColor,),

                      discountVal != '' ?rowTwoTitleTextWidget(title2: 'Discount amount : ₹ ${discountVal??""}'):Container(),
                      discountVal != '' ?Divider(height: screenHeight/30.0,color: ConstantColor.calendarBGHeadColor,):Container(),

                      rowTwoTitleTextWidget(title2: 'Existing Plan Discount : ₹ ${extPlanDis.isNotEmpty ? extPlanDis : '0.00'}'),
                      Divider(height: screenHeight/30.0,color: ConstantColor.calendarBGHeadColor,),

                      rowTwoTitleTextWidget(title2: 'Payable Amount : ₹ ${payAmt.isNotEmpty ? payAmt : planAmount??""}'),
                      Divider(height: screenHeight/30.0,color: ConstantColor.calendarBGHeadColor,),
                      rowTwoTitleTextWidget(
                          title2: 'CGST(9%) : ₹ ${tax != null && tax != 0.0 ? (tax/2).toStringAsFixed(2) : cgstAmount.toStringAsFixed(2)??''}'
                      ),
                      Divider(height: screenHeight/30.0,color: ConstantColor.calendarBGHeadColor,),

                      rowTwoTitleTextWidget(
                          title2: 'SGST(9%) : ₹ ${tax != null && tax != 0.0 ? (tax/2).toStringAsFixed(2) : cgstAmount.toStringAsFixed(2)??''}'
                      ),
                      Divider(height: screenHeight/30.0,color: ConstantColor.calendarBGHeadColor,),

                      rowTwoTitleTextWidget(title2: 'Total : ₹ ${
                      totalAmt.isNotEmpty ? totalAmt :
                          state == "Madhya Pradesh" ? (totalAmount != null ? (totalAmount).toStringAsFixed(2) : " ") : (totalAmount2 != null ? (totalAmount2).toStringAsFixed(2) : " ")
                      } '),
                      Divider(height: screenHeight/30.0,color: ConstantColor.calendarBGHeadColor,),

                      rowTitleAndFormWidget(
                        // context:context,
                        title: "Coupon Code\t\t\t\t\t\t\t",
                        formFieldWidget:
                        GlobalTextFormField(enabled: true,
                          controller: _couponCodeController,
                          keyboardType: TextInputType.text,
                          hintText: "Your Coupon Code",
                          hintStyle: ConstantTextStyle.otpHintTextStyle,
                          suffixIcon:  customButton(
                            textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                            onPressed: () {
                              // Check if the controller text is not empty before calling the API
                              final couponCode = _couponCodeController.text.trim();
                              if (couponCode.isNotEmpty) {
                                fetchCouponData(
                                  planCode: couponCode,
                                  pid: productId ?? "",
                                  plan: 'yearly_price',
                                );
                              }
                            },
                            text: 'Apply',
                            backgroundColor: ConstantColor.primaryMainColor,
                            borderRadius: BorderRadius.zero,
                            elevation: 4.0,
                          ),
                          onChanged: (value) {
                          },
                        ),
                      ),

                      constantHeight(context, 40.0),
                      rowTitleAndFormWidget(
                        // context:context,
                        title: "Referral Code\t\t\t\t\t\t\t",
                        formFieldWidget:
                        GlobalTextFormField(enabled: true,
                          controller: _referralCodeController,
                          keyboardType: TextInputType.text,
                          hintText: "Your Referral Code",
                          hintStyle: ConstantTextStyle.otpHintTextStyle,
                          //const Icon(Icons.date_range_outlined,color: ConstantColor.landingScreenSubHaddingColor,),
                          onChanged: (value) {
                            // print("data-----------${_referralCodeController.text.toString()}");
                          },
                        ),
                      ),


                      Divider(height: screenHeight/30.0,color: ConstantColor.calendarBGHeadColor,),


                      customRadioButtonTitle(
                        groupValue: _subscriptionValue,
                        onChanged: (value) {
                          setState(() {
                            _subscriptionValue = value!;
                          });
                        },
                        title: customeText(
                            text: "Do you want to take a subscription plan for future? "
                                "To avail GST input credit, please update your GSTIN in your profile",
                            style: ConstantTextStyle.colorsHeadingText),
                      ),

                      Row(
                        children: [
                          customeCheckbox(
                            checkColor: ConstantColor.primaryBackgroundMainColor,
                            activeColor: ConstantColor.primaryMainColor,
                            value: _isGSTINUpdated,
                            onChanged: (bool? value) {
                              setState(() {
                                _isGSTINUpdated = value!;
                              });
                              // String? error = validateCheckbox(value);
                              // if (error != null) {}
                            },
                          ),

                          Flexible(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/termsAndConditions');
                                FocusScope.of(context).unfocus();
                              },
                              child: customRichText(
                                text1: "\t\tI agree to these ",
                                textAlign: TextAlign.start,
                                style1: ConstantTextStyle.checkboxTextStyle1,
                                text2: "Terms and conditions",
                                style2: ConstantTextStyle.checkboxTextStyle2,
                              ),
                            ),
                          ),
                        ],
                      ),

                      customButton(
                        textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                        onPressed:
                        (_isGSTINUpdated == false || _subscriptionValue == false) ? null :
                            () async{
                          await ApiOrderService.fetchOrderData(
                              context: context,
                              accode: _couponCodeController.text??'',
                              subEndDate : planEndDate,
                              orderAmount: totalAmt.isNotEmpty ? totalAmt : '${state == "Madhya Pradesh" ? (totalAmount != null ? (totalAmount).toStringAsFixed(2) : " ") : (totalAmount2 != null ? (totalAmount2).toStringAsFixed(2) : " ")}',
                              planAmt: payAmt.isNotEmpty ? payAmt : planAmount,
                              referralCode: _referralCodeController.text.toString(),
                              subscriptionId: planSubId,
                              cgstAmount: tax != null && tax != 0.0 ? (tax/2).toStringAsFixed(2) : (cgstAmount).toStringAsFixed(2),
                              sgstAmount: tax != null && tax != 0.0 ? (tax/2).toStringAsFixed(2) : (cgstAmount).toStringAsFixed(2),
                              stateName: state,
                              taxableAmt: planAmount
                          );

                        },
                        text: 'Submit',
                        backgroundColor: ConstantColor.primaryMainColor,
                        borderRadius: BorderRadius.circular(8.0),
                        minimumSize:  Size(screenWidth/2.0, screenHeight/25),
                        elevation: 1.0,
                      ),

                    ],
                  )
              ),
            ),
          ),
        )
    );
  }
}





