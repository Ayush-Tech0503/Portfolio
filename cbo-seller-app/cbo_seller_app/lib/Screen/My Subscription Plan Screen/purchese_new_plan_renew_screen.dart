// ignore_for_file: non_constant_identifier_names, deprecated_member_use
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../Utils/Font Style/text_styles.dart';
import '../../../Utils/Theme/constant_colors.dart';
import '../../../Widget/custome_text_widget.dart';
import '../../Services/Purchase New Plan Api Services/subscription_plan_listing_api_services.dart';
import '../../Widget/Custome Buttons/elevetion_button_widget.dart';
import '../../Widget/reed_more_widget.dart';


// class RenewPlanScreen extends StatefulWidget {
//   const RenewPlanScreen({super.key});
//
//   @override
//   State<RenewPlanScreen> createState() => _RenewPlanScreenState();
// }
//
// class _RenewPlanScreenState extends State<RenewPlanScreen> {
//
//   @override
//   void initState() {
//     super.initState();
//     fetchSubPlanListingData();
//   }
//   final ScrollController _scrollController = ScrollController();
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   var planID = '';
//   bool isPullToRefreshEnabled = true;
//   int currentPage = 1;
//   bool isLoading = false;
//   final RefreshController _refreshController = RefreshController(initialRefresh: false);
//
//   SubscriptionPlanListModels? subscriptionPlanListModels;
//   List<PlanListData>? data = [];
//
//   Future<void> fetchSubPlanListingData() async {
//     try {
//       if (currentPage == 1) {
//         setState(() {
//           isLoading = true;
//           data!.clear();
//         });
//       }
//
//       final subPlanListingResponse = await ApiSubPlanListService.fetchSubPlanListData(context: context);
//
//       if (subPlanListingResponse != null && subPlanListingResponse.data != null) {
//         final dataList = subPlanListingResponse.data!;
// print('dataList-------${dataList}');
//         setState(() {
//           if (currentPage == 1) {
//             data = dataList;
//           } else {
//             data!.addAll(dataList);
//             _refreshController.loadComplete();
//           }
//           isLoading = false;
//           currentPage++;
//         });
//       } else {
//         // No more data available
//         setState(() {
//           isLoading = false;
//           _refreshController.loadNoData();
//           isPullToRefreshEnabled = false; // Disable pull-to-refresh
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _refreshController.loadNoData();
//         isLoading = false;
//       });
//     }
//   }
//
// List subRegistration = ["Lifetime","Lifetime","Lifetime","Lifetime","Lifetime"];
// List likeProductList = ["Unlimited","Unlimited","Unlimited","Unlimited","Unlimited"];

//   @override
//   Widget build(BuildContext context) {
//     var screenHeight = MediaQuery.of(context).size.height;
//     var screenWidth = MediaQuery.of(context).size.width;
//     return AppLayout(
//         title: "Purchase New Plans/Renew",
//         titleStyle: ConstantTextStyle.landingScreenAppbarText,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back), color: ConstantColor.primaryBackgroundMainColor,
//           onPressed: () => Navigator.pop(context),
//         ),
//         scaffoldColor: ConstantColor.primaryBackgroundMainColor,
//         appBarColor: ConstantColor.loginWithOtpButtonColor,
//         body: CupertinoScrollbar(
//           child: SmartRefresher(
//               enablePullDown: true,
//               enablePullUp: false,
//               controller: _refreshController,
//               footer: customFooter(),
//               onRefresh: () async {
//                 currentPage = 1;
//                 await fetchSubPlanListingData();
//                 _refreshController.refreshCompleted();
//               },
//               child:
//                data == null || data!.toString().isEmpty ? noDataFound(context):
//               ListView(
//                 controller: _scrollController,
//                 padding: EdgeInsets.symmetric(horizontal: screenWidth/30,vertical: screenHeight/40),
//                 children: [
//                   customeText(text: "\tPurchase New Plans/Renew",style: ConstantTextStyle.topCategoryText4),
//                   constantHeight(context, 40.0),
//
//                   Skeletonizer(
//                     enabled: isLoading,
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.vertical,
//                       child: SingleChildScrollView(
//                         controller: _scrollController,
//                         scrollDirection: Axis.horizontal,
//                         child: Column(
//                           children: [
//                             DataTable(
//                               columnSpacing: screenWidth/5.0,
//                               headingRowHeight: screenHeight/8.0,
//                               // horizontalMargin: screenWidth/10.0,
//                               decoration: BoxDecoration(
//                                 color: ConstantColor.calendarBGHeadColor,
//                                   border: Border.all(color: ConstantColor.calendarBGHeadColor),
//                                   borderRadius: const BorderRadius.only(topRight: Radius.circular(8.0), topLeft: Radius.circular(8.0))),
//                               columns: [
//                                  DataColumn(label: customeText(text: "Subscription Plan", textAlign: TextAlign.start, style: ConstantTextStyle.carouselSliderText)),
//                                 ...data!.map((subscription) {
//                                   return  DataColumn(label:  tablePlanHeaderDataWidget(
//                                     context: context,
//                                     planName: subscription.subscriptionName ?? '',
//                                     planAmount: subscription.subscriptionPrice ?? '',
//                                     onPressed: () {
//                                       Navigator.pushNamed(context, '/getSubPlanStartScreen', arguments: {
//                                       'subscriptionId': subscription.subscriptionId,
//                                       'productId': subscription.subscriptionId.toString(),
//                                       },);
//                                     },
//                                     buttonTitle: "Get Start",
//                                     buttonBackground: subscription.subscriptionName.toString().toUpperCase() == "SWAGATAM"
//                                         ? ConstantColor.primaryMainColor
//                                         : ConstantColor.loginWithOtpButtonColor,
//                                   ),
//                                   );
//                                 })
//                               ],
//                               rows: const [],
//                             ),
//                             DataTable(
//                               columnSpacing: screenWidth/6.0,
//                               headingRowHeight: 0.0,
//                               horizontalMargin: screenWidth/40.0,
//                               decoration: BoxDecoration(
//                                   border: Border.all(color: ConstantColor.calendarBGHeadColor),
//                                   borderRadius: const BorderRadius.only(bottomRight: Radius.circular(8.0), bottomLeft: Radius.circular(8.0))),
//                               columns: [
//                                  const DataColumn(label: Text("")),
//                                 ...data!.map((subscription) {
//                                   return const DataColumn(label: Text(""));
//                                 })
//                               ],
//                               rows: [
//                                 DataRow(
//                                     cells: [
//                                       DataCell(tablePlanBodyWidget(titleText: 'Quarterly Price')),
//                                       // for (var dataSubPlan in data!)
//                                       ...data!.map((subscription) {
//                                         return  DataCell(tablePlanBodyWidget(titleText: '₹ ${(double.tryParse(subscription.quarterlyPrice ?? '') ?? 0).toStringAsFixed(2)} | 90 days | 0.0% Off'));
//                                       } )
//                                     ]
//                                 ),
//                                 DataRow(
//                                     cells: [
//                                       DataCell(tablePlanBodyWidget(titleText: 'Half Yearly Price')),
//                                       // for (var dataSubPlan in data!)
//                                       ...data!.map((subscription) {
//                                         return  DataCell(tablePlanBodyWidget(titleText: '₹ ${(double.tryParse(subscription.halfYearlyPrice ?? '') ?? 0).toStringAsFixed(2)} | 180 days | 0.0% Off'));
//                                       } )
//                                     ]
//                                 ),
//                                 DataRow(
//                                     cells: [
//                                       DataCell(tablePlanBodyWidget(titleText: 'Yearly Price')),
//                                       // for (var dataSubPlan in data!)
//                                       ...data!.map((subscription) {
//                                         return  DataCell(tablePlanBodyWidget(titleText: '₹ ${(double.tryParse(subscription.yearlyPrice ?? '') ?? 0).toStringAsFixed(2)} | 365 days | 0.0% Off'));
//                                       } )
//                                     ]
//                                 ),
//                                 DataRow(
//                                     cells: [
//                                       DataCell(tablePlanBodyWidget(titleText: 'Subscription Validity')),
//                                       // for (var dataSubPlan in data!)
//                                       ...data!.map((subscription) {
//                                         return  DataCell(tablePlanBodyWidget(titleText: subscription.subscriptionValidity ?? ''));
//                                       } )
//                                     ]
//                                 ),
//                                 DataRow(
//                                     cells: [
//                                       DataCell(tablePlanBodyWidget(titleText: 'Shop Registration')),
//                                       // for (var dataSubPlan in data!)
//                                       ...data!.map((subscription) {
//                                         return  DataCell(tablePlanBodyWidget(titleText: 'Life Time' ?? ''));
//                                       } )
//                                     ]
//                                 ),
//                                 DataRow(
//                                     cells: [
//                                       DataCell(tablePlanBodyWidget(titleText: 'Space For Products')),
//                                       // for (var dataSubPlan in data!)
//                                       ...data!.map((subscription) {
//                                         return  DataCell(tablePlanBodyWidget(titleText: subscription.noOfProductAllowed ?? ''));
//                                       } )
//                                     ]
//                                 ),
//                                 DataRow(
//                                     cells: [
//                                       DataCell(tablePlanBodyWidget(titleText: 'Executive Visit For Product')),
//                                       // for (var dataSubPlan in data!)
//                                       ...data!.map((subscription) {
//                                         return  DataCell(tablePlanBodyWidget(titleText: subscription.executeVisitUploads ?? ''));
//                                       } )
//                                     ]
//                                 ),
//                                 DataRow(
//                                     cells: [
//                                       DataCell(tablePlanBodyWidget(titleText: 'Top product')),
//                                       // for (var dataSubPlan in data!)
//                                       ...data!.map((subscription) {
//                                         return  DataCell(tablePlanBodyWidget(titleText: subscription.topProduct ?? ''));
//                                       } )
//                                     ]
//                                 ),
//                                 DataRow(
//                                     cells: [
//                                       DataCell(tablePlanBodyWidget(titleText: 'Shop in focus')),
//                                       // for (var dataSubPlan in data!)
//                                       ...data!.map((subscription) {
//                                         return  DataCell(tablePlanBodyWidget(titleText: subscription.shopInFocus ?? ''));
//                                       } )
//                                     ]
//                                 ),
//                                 DataRow(
//                                     cells: [
//                                       DataCell(tablePlanBodyWidget(titleText: 'Like Product')),
//                                       // for (var dataSubPlan in data!)
//                                       ...data!.map((subscription) {
//                                         return  DataCell(tablePlanBodyWidget(titleText: 'Unlimited' ?? ''));
//                                       } )
//                                     ]
//                                 ),
//                                 DataRow(
//                                     cells: [
//                                       DataCell(tablePlanBodyWidget(titleText: 'Buyer Leads')),
//                                       // for (var dataSubPlan in data!)
//                                       ...data!.map((subscription) {
//                                         return  DataCell(tablePlanBodyWidget(titleText: ''));
//                                       } )
//                                     ]
//                                 ),
//                                 DataRow(
//                                     cells: [
//                                       DataCell(tablePlanBodyWidget(titleText: 'Wishlist')),
//                                       // for (var dataSubPlan in data!)
//                                       ...data!.map((subscription) {
//                                         return  DataCell(tablePlanBodyWidget(titleText: 'Unlimited'));
//                                       } )
//                                     ]
//                                 ),
//                                 DataRow(
//                                     cells: [
//                                       DataCell(tablePlanBodyWidget(titleText: 'Sharing by seller product')),
//                                       // for (var dataSubPlan in data!)
//                                       ...data!.map((subscription) {
//                                         return  DataCell(tablePlanBodyWidget(titleText: 'Unlimited'));
//                                       } )
//                                     ]
//                                 ),
//                                 DataRow(
//                                     cells: [
//                                       DataCell(tablePlanBodyWidget(titleText: 'Discount Section (sale offer) your business')),
//                                       // for (var dataSubPlan in data!)
//                                       ...data!.map((subscription) {
//                                         return  DataCell(tablePlanBodyWidget(titleText: subscription.discountSection??''));
//                                       } )
//                                     ]
//                                 ),
//                                 DataRow(
//                                     cells: [
//                                       DataCell(tablePlanBodyWidget(titleText: 'Chat Function')),
//                                       // for (var dataSubPlan in data!)
//                                       ...data!.map((subscription) {
//                                         return  DataCell(tablePlanBodyWidget(titleText: 'Yes'));
//                                       } )
//                                     ]
//                                 ),
//                                 DataRow(
//                                     cells: [
//                                       DataCell(tablePlanBodyWidget(titleText: 'Visitor analytics')),
//                                       // for (var dataSubPlan in data!)
//                                       ...data!.map((subscription) {
//                                         return  DataCell(tablePlanBodyWidget(titleText: subscription.visitorAnalytics??""));
//                                       } )
//                                     ]
//                                 ),
//                                 DataRow(
//                                     cells: [
//                                       DataCell(tablePlanBodyWidget(titleText: 'Unlimited device')),
//                                       // for (var dataSubPlan in data!)
//                                       ...data!.map((subscription) {
//                                         return  DataCell(tablePlanBodyWidget(titleText: 'Yes'));
//                                       } )
//                                     ]
//                                 ),
//                                 DataRow(
//                                     cells: [
//                                       DataCell(tablePlanBodyWidget(titleText: 'Personalised Web Page')),
//                                       // for (var dataSubPlan in data!)
//                                       ...data!.map((subscription) {
//                                         return  DataCell(tablePlanBodyWidget(titleText: 'Yes'));
//                                       } )
//                                     ]
//                                 ),
//                                 DataRow(
//                                     cells: [
//                                       DataCell(tablePlanBodyWidget(titleText: 'Promotional')),
//                                       // for (var dataSubPlan in data!)
//                                       ...data!.map((subscription) {
//                                         return  DataCell(tablePlanBodyWidget(titleText: ''));
//                                       } )
//                                     ]
//                                 ),
//                                 DataRow(
//                                     cells: [
//                                       DataCell(tablePlanBodyWidget(titleText: 'Online Market Place')),
//                                       // for (var dataSubPlan in data!)
//                                       ...data!.map((subscription) {
//                                         return  DataCell(tablePlanBodyWidget(titleText: 'Yes'));
//                                       } )
//                                     ]
//                                 ),
//                               ],
//                             ),
//                             DataTable(
//                               columnSpacing: screenWidth/5.0,
//                               headingRowHeight: screenHeight/8.0,
//                               // horizontalMargin: screenWidth/10.0,
//                               // decoration: BoxDecoration(
//                               //     color: ConstantColor.calendarBGHeadColor,
//                               //     border: Border.all(color: ConstantColor.calendarBGHeadColor),
//                               //     borderRadius: const BorderRadius.only(topRight: Radius.circular(8.0), topLeft: Radius.circular(8.0))),
//                               columns: [
//                                 DataColumn(label:
//                                 customeText(text: "EMI OPTIONS", textAlign: TextAlign.start, style: ConstantTextStyle.topCategoryText4)
//                                 ),
//                                 ...data!.map((subscription) {
//                                   if (subscription.subscriptionName.toString().toUpperCase() != "SWAGATAM") {
//                                     return DataColumn(
//                                       label: tablePlanHeaderDataWidget(
//                                         context: context,
//                                         planName: subscription.subscriptionName ?? "",
//                                         planAmount: subscription.subscriptionPrice ?? '',
//                                         onPressed: () {
//                                           Navigator.pushNamed(context, '/emiOptionsScreen', arguments: subscription.subscriptionId.toString()??"");
//                                           // Navigator.pushNamed(context, '/emiOptionsScreen');
//                                         },
//                                         buttonTitle: "Get EMI",
//                                         buttonBackground: ConstantColor.loginWithOtpButtonColor,
//                                       ),
//                                     );
//                                   } else {
//                                     return  DataColumn( label: tablePlanBodyWidget(titleText: "Yes"));
//                                   }
//                                 }),
//                               ],
//                               rows: const [],
//                             ),
//
//                           ],
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               )
//           ),
//         )
//     );
//   }
// }



class RenewPlanScreen extends StatefulWidget {
  const RenewPlanScreen({super.key});

  @override
  State<RenewPlanScreen> createState() => _RenewPlanScreenState();
}

class _RenewPlanScreenState extends State<RenewPlanScreen>     with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<String> _tabs = []; // Initialize with an empty list
  Map<String, dynamic> _tabData = {}; // Initialize with an empty map

  String jsonString = '';
  bool _isTopUpPlan = true;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchSubPlanListingData(); // Fetch data on initialization
  }

  void _togglePlan(bool isTopUpPlan) {
    setState(() {
      _isTopUpPlan = isTopUpPlan;
    });
  }

  //-------api calling -----------
  Future<void> fetchSubPlanListingData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final subPlanListingResponse = await ApiSubPlanListService.fetchSubPlanListData2(context: context);

      if (subPlanListingResponse != null) {
        jsonString = jsonEncode(subPlanListingResponse);

        // Parse the JSON data and initialize tabs and tabData
        final Map<String, dynamic> jsonData = jsonDecode(jsonString);
        final List<dynamic> dataList = jsonData['data'] ?? [];

        setState(() {
          _tabs = dataList.map<String>((item) => item['group_name'] as String).toList();
          _tabData = {
            for (var item in dataList)
              item['group_name']: {
                'Regular Plan': item['regularPlan'] ?? [],
                'Top Up Plan': item['topUpPlan'] ?? []
              }
          };

          // Initialize TabController with the length of _tabs
          _tabController = TabController(length: _tabs.length, vsync: this);
        });
      } else {
        jsonString = "";
      }
    } catch (e) {
      jsonString = "";
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  //--------------dialog data-------
  //-checked data ----is present or not----
  Widget buildConditionalRowCheckText(BuildContext context, String? value, String title, {IconData? icon, Color? iconColor}) {
    if (value == null || value.isEmpty) {
      return const SizedBox.shrink(); // Return an empty widget if the value is null or empty
    }
    return rowCheckText(
      context: context,
      title: title,
      icon: icon,
      iconColor: iconColor,
    );
  }


  // _showPlanDetailsDialog(Map<String, dynamic> item) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       final screenHeight = MediaQuery.of(context).size.height;
  //       final screenWidth = MediaQuery.of(context).size.width;
  //
  //       return AlertDialog(
  //         contentPadding: EdgeInsets.zero,
  //         elevation: 5.0,
  //         //symmetric(horizontal: screenWidth/20.0,vertical: screenHeight/60.0),
  //         content: SingleChildScrollView(
  //           child: Container(
  //             width: screenWidth,
  //             padding: EdgeInsets.symmetric(vertical: screenHeight/60.0,horizontal: screenWidth/20.0),
  //             // padding: const EdgeInsets.all(10.0),
  //             decoration: BoxDecoration(
  //               gradient: const LinearGradient(
  //                 colors: [
  //                   ConstantColor.calendarBGHeadColor,
  //                   ConstantColor.primaryBackgroundMainColor,
  //                 ],
  //                 begin: Alignment.topLeft,
  //                 end: Alignment.bottomRight,
  //               ),
  //               // color: ConstantColor.primaryBackgroundMainColor,
  //               borderRadius: BorderRadius.circular(8.0),
  //               border: Border.all(color: ConstantColor.calendarBGHeadColor),
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.black.withOpacity(0.2), // Shadow color
  //                   spreadRadius: 1,                       // Shadow spread radius
  //                   blurRadius: 4,                         // Shadow blur radius
  //                   offset: const Offset(0, 5),                  // Shadow offset
  //                 ),
  //               ],
  //             ),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 customeText(
  //                   text: item['subscription_name']?? item['service_name']  ?? '',
  //                   style: ConstantTextStyle.homeScreenHeadingText2,
  //                 ),
  //                 SizedBox(height: screenHeight/80.0),
  //                 customeText(
  //                     text: '₹ ${(double.tryParse(item['subscription_price'] ?? item['service_price'] ?? '') ?? 0).toStringAsFixed(2)}',
  //                     style: ConstantTextStyle.priceText
  //                 ),
  //                 SizedBox(height: screenHeight/80.0),
  //
  //                 // rowCheckText(context: context, title: '${item['subscription_validity'] ?? ''} Days Subscription Validity'),
  //
  //                 buildConditionalRowCheckText(context,
  //                   item['subscription_validity']?.toString(),
  //                   '${item['subscription_validity'] ?? ''} Days Subscription Validity',
  //                 ),
  //
  //                 rowCheckText(context: context, title: 'Life Time Shop Registration'),
  //                 // buildConditionalRowCheckText(
  //                 //   context,
  //                 //   null, // No value for this row
  //                 //   'Life Time Shop Registration',
  //                 // ),
  //
  //                 buildConditionalRowCheckText(
  //                   context,
  //                   item['no_of_product_allowed']?.toString(),
  //                   '${item['no_of_product_allowed'].toString() ?? ''} Space For Products',
  //                   icon: item['no_of_product_allowed'].toString() == "0" ? Icons.close_outlined : Icons.check,
  //                   iconColor: item['no_of_product_allowed'].toString() == "0" ? ConstantColor.primaryMainColor : ConstantColor.chipCompleteStatus,
  //                 ),
  //                 // rowCheckText(context: context,
  //                 //     icon: item['no_of_product_allowed'].toString() == "0" ?
  //                 //     Icons.close_outlined :  Icons.check,
  //                 //     iconColor: item['no_of_product_allowed'].toString() == "0" ?
  //                 //     ConstantColor.primaryMainColor: ConstantColor.chipCompleteStatus,
  //                 //     title: '${item['no_of_product_allowed'].toString() ?? ''} Space For Products'),
  //                 buildConditionalRowCheckText(
  //                   context,
  //                   item['execute_visit_uploads']?.toString(),
  //                   '${item['execute_visit_uploads'].toString() ?? ''} Executive Visit For Product',
  //                   icon: item['execute_visit_uploads'].toString() == "0" ? Icons.close_outlined : Icons.check,
  //                   iconColor: item['execute_visit_uploads'].toString() == "0" ? ConstantColor.primaryMainColor : ConstantColor.chipCompleteStatus,
  //                 ),
  //                 // rowCheckText(context: context,
  //                 //     icon: item['execute_visit_uploads'].toString() == "0" ?
  //                 //     Icons.close_outlined :  Icons.check,
  //                 //     iconColor: item['execute_visit_uploads'].toString() == "0" ?
  //                 //     ConstantColor.primaryMainColor: ConstantColor.chipCompleteStatus,
  //                 //     title: '${item['execute_visit_uploads'].toString() ?? ''} Executive Visit For Product'),
  //                 buildConditionalRowCheckText(
  //                   context,
  //                   item['top_product']?.toString(),
  //                   '${item['top_product'].toString() ?? ''} Top product',
  //                   icon: item['top_product'].toString() == "0" ? Icons.close_outlined : Icons.check,
  //                   iconColor: item['top_product'].toString() == "0" ? ConstantColor.primaryMainColor : ConstantColor.chipCompleteStatus,
  //                 ),
  //                 // rowCheckText(context: context,
  //                 //     icon: item['top_product'].toString() == "0" ?
  //                 //     Icons.close_outlined :  Icons.check,
  //                 //     iconColor: item['top_product'].toString() == "0" ?
  //                 //     ConstantColor.primaryMainColor: ConstantColor.chipCompleteStatus,
  //                 //     title: '${item['top_product'].toString() ?? ''} Top product'),
  //
  //                 buildConditionalRowCheckText(
  //                   context,
  //                   item['shop_in_focus']?.toString(),
  //                   '${item['shop_in_focus'].toString() ?? ''} Shop in focus',
  //                   icon: item['shop_in_focus'].toString() == "No" ? Icons.close_outlined : Icons.check,
  //                   iconColor: item['shop_in_focus'].toString() == "No" ? ConstantColor.primaryMainColor : ConstantColor.chipCompleteStatus,
  //                 ),
  //                 // rowCheckText(context: context,
  //                 //     icon: item['shop_in_focus'].toString() == "No" ?
  //                 //     Icons.close_outlined :  Icons.check,
  //                 //     iconColor: item['shop_in_focus'].toString() == "No" ?
  //                 //     ConstantColor.primaryMainColor: ConstantColor.chipCompleteStatus,
  //                 //     title: '${item['shop_in_focus'].toString() ?? ''} Shop in focus'),
  //
  //                 rowCheckText(context: context, title: 'Unlimited Like Product'),
  //
  //                 rowCheckText(context: context, title: 'Unlimited Wishlist'),
  //
  //                 rowCheckText(context: context, title: 'Unlimited Sharing by seller product'),
  //
  //                 buildConditionalRowCheckText(
  //                   context,
  //                   item['discount_section']?.toString(),
  //                   '${item['discount_section'].toString() ?? ''} Discount Section (Seller Offer) Your Business',
  //                   icon: item['discount_section'].toString() == "No" ? Icons.close_outlined : Icons.check,
  //                   iconColor: item['discount_section'].toString() == "No" ? ConstantColor.primaryMainColor : ConstantColor.chipCompleteStatus,
  //                 ),
  //                 // rowCheckText(context: context,
  //                 //     icon: item['discount_section'].toString() == "No" ?
  //                 //     Icons.close_outlined :  Icons.check,
  //                 //     iconColor: item['discount_section'].toString() == "No" ?
  //                 //     ConstantColor.primaryMainColor: ConstantColor.chipCompleteStatus,
  //                 //     title: '${item['discount_section'].toString() ?? ''} Discount Section (Seller Offer) Your Business'),
  //
  //                 rowCheckText(context: context, title: 'Yes Chat Function'),
  //
  //                 buildConditionalRowCheckText(
  //                   context,
  //                   item['visitor_analytics']?.toString(),
  //                   '${item['visitor_analytics'].toString() ?? ''} Visitor analytics',
  //                   icon: item['visitor_analytics'].toString() == "No" ? Icons.close_outlined : Icons.check,
  //                   iconColor: item['visitor_analytics'].toString() == "No" ? ConstantColor.primaryMainColor : ConstantColor.chipCompleteStatus,
  //                 ),
  //                 // rowCheckText(context: context,
  //                 //     icon: item['visitor_analytics'].toString() == "No" ?
  //                 //     Icons.close_outlined :  Icons.check,
  //                 //     iconColor: item['visitor_analytics'].toString() == "No" ?
  //                 //     ConstantColor.primaryMainColor: ConstantColor.chipCompleteStatus,
  //                 //     title: '${item['visitor_analytics'].toString() ?? ''} Visitor analytics'),
  //
  //                 rowCheckText(context: context, title: 'Yes Unlimited device'),
  //
  //                 rowCheckText(context: context, title: 'Yes Personalised Web Page'),
  //
  //                 rowCheckText(context: context, title: 'Yes Online Market Place'),
  //
  //                 // const SizedBox(height: 20),
  //
  //                 Row(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     customButton(
  //                       textStyleButton:ConstantTextStyle.landingScreenAppbarText,
  //                       onPressed: () {
  //                         Navigator.pushNamed(context, '/getSubPlanStartScreen', arguments: {
  //                           'subscriptionId': item['subscription_id'].toString() ?? item['service_id'].toString(),
  //                           'productId': item['subscription_id'].toString() ?? item['service_id'].toString(),
  //                         },);
  //                       },
  //                       text: "Get Start",
  //                       backgroundColor:
  //                       // subscription.subscriptionName.toString().toUpperCase() == "SWAGATAM"
  //                       //     ?
  //                       ConstantColor.primaryMainColor,
  //                       // : ConstantColor.loginWithOtpButtonColor,
  //                       borderRadius: BorderRadius.circular(8.0),
  //                       minimumSize: Size(screenWidth/30, screenHeight/30),
  //                       elevation: 1.0,
  //                     ),
  //                     // ElevatedButton(
  //                     //   onPressed: () {
  //                     //     Navigator.pushNamed(
  //                     //       context,
  //                     //       '/getSubPlanStartScreen',
  //                     //       arguments: {
  //                     //         'subscriptionId':
  //                     //         subscription.subscriptionId,
  //                     //         'productId': subscription.subscriptionId
  //                     //             .toString(),
  //                     //       },
  //                     //     );
  //                     //   },
  //                     //   style: ElevatedButton.styleFrom(
  //                     //     primary: subscription.subscriptionName
  //                     //         .toString()
  //                     //         .toUpperCase() ==
  //                     //         "SWAGATAM"
  //                     //         ? ConstantColor.primaryMainColor
  //                     //         : ConstantColor.loginWithOtpButtonColor,
  //                     //   ),
  //                     //   child: Text("Get Start"),
  //                     // ),
  //                     (item['is_emi'] == null && item['is_emi'].toString() == 'No')
  //                         ?  customButton(
  //                       textStyleButton:ConstantTextStyle.landingScreenAppbarText,
  //                       onPressed: () {
  //                         Navigator.pushNamed(context, '/emiOptionsScreen',
  //                             arguments: item['subscription_id'].toString() ?? "");
  //                       },
  //                       text: "Get EMI",
  //                       backgroundColor:
  //                       // item['subscription_name'].toString().toUpperCase() == "SWAGATAM"
  //                       //     ? ConstantColor.primaryMainColor:
  //                       ConstantColor.loginWithOtpButtonColor,
  //                       borderRadius: BorderRadius.circular(8.0),
  //                       minimumSize: Size(screenWidth/30, screenHeight/30),
  //                       elevation: 1.0,
  //                     ):Container(),
  //                     // ElevatedButton(
  //                     //   onPressed: () {
  //                     //     Navigator.pushNamed(context, '/emiOptionsScreen',
  //                     //       arguments: subscription.subscriptionId.toString() ?? "");
  //                     //   },
  //                     //   style: ElevatedButton.styleFrom(
  //                     //     primary: ConstantColor.loginWithOtpButtonColor,
  //                     //   ),
  //                     //   child: Text(""),
  //                     // ),
  //                   ],
  //                 ),
  //
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }




  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ConstantColor.primaryBackgroundMainColor,
      appBar: AppBar(
        backgroundColor: ConstantColor.loginWithOtpButtonColor,
        title: customeText(text: "Purchase New Plans/Renew",style: ConstantTextStyle.landingScreenAppbarText ),
        centerTitle: true,
        // titleStyle: ConstantTextStyle.landingScreenAppbarText,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: ConstantColor.primaryBackgroundMainColor,
          onPressed: () => Navigator.pop(context),
        ),
        // backgroundColor: ConstantColor.primaryBackgroundMainColor,

        // flexibleSpace: Container(
        //   decoration: const BoxDecoration(
        //     gradient: LinearGradient(
        //       begin: Alignment.topCenter,
        //       end: Alignment.bottomCenter,
        //       colors: [ConstantColor.loginWithOtpButtonColor, ConstantColor.primaryBackgroundMainColor],
        //     ),
        //   ),
        // ),
        bottom: _tabs.isEmpty
            ? null
            : PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: screenWidth / 30.0),
            decoration: BoxDecoration(
              border: Border.all(color: ConstantColor.calendarBGHeadColor),
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0)),
              color: ConstantColor.primaryBackgroundMainColor,
            ),
            child: TabBar(
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: ConstantColor.primaryMainColor,
              ),
              isScrollable: true,
              controller: _tabController,
              unselectedLabelStyle: ConstantTextStyle.secodHearText,
              labelStyle: ConstantTextStyle.loginButtonTextStyle,
              tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
        controller: _tabController,
        children: _tabs.map((tab) {
          final planData = _isTopUpPlan ? _tabData[tab]['Regular Plan'] : _tabData[tab]['Top Up Plan'] ?? [];
          // Ensure planData is a List<dynamic> before building widgets
          if (planData is! List<dynamic>) {
            return const Center(child: Text('No data available for this tab'));
          }

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: screenHeight/80.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customeText(text: 'Top Up Plan', style: ConstantTextStyle.requirementText),
                    SizedBox(width: screenWidth/80.0),
                    Switch(
                      activeColor: ConstantColor.primaryMainColor,
                      value: _isTopUpPlan,
                      onChanged: _togglePlan,
                    ),
                    SizedBox(width: screenWidth/80.0),
                    customeText(text: 'Regular Plan', style: ConstantTextStyle.requirementText),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: planData.map<Widget>((item) {
                    List<dynamic> services = item['service'] ?? [];
                    List<Widget> serviceWidgets = services.map((service) {
                      // Extract the service name
                      var serviceName = service['service_name'] ?? '';
                      var serviceCount = service['service_count'] ?? '';

                      return customeText(
                        text: "👉 $serviceName - $serviceCount",
                        style: ConstantTextStyle.cardbottumText,
                      );
                    }).toList();


                    // Ensure item is a Map
                    if (item is Map<String, dynamic>) {
                      return GestureDetector(
                        onTap: (){
                          // _showPlanDetailsDialog(item);
                        },
                        child: Container(
                          width: screenWidth,
                          margin: EdgeInsets.symmetric(vertical: screenHeight/60.0,horizontal: screenWidth/20.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: ConstantColor.carColor,
                            // gradient: const LinearGradient(
                            //   colors: [
                            //     ConstantColor.calendarBGHeadColor,
                            //     ConstantColor.primaryBackgroundMainColor,
                            //   ],
                            //   begin: Alignment.topLeft,
                            //   end: Alignment.bottomRight,
                            // ),
                            // color: ConstantColor.primaryBackgroundMainColor,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: ConstantColor.calendarBGHeadColor),
                            boxShadow: [
                              BoxShadow(
                                color: ConstantColor.primaryGreyColor.withOpacity(0.4), // Shadow color
                                spreadRadius: 1,                       // Shadow spread radius
                                blurRadius: 4,                         // Shadow blur radius
                                offset: const Offset(0, 5),                  // Shadow offset
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customeText(
                                text: item['subscription_name'] ?? item['service_name'] ?? '',
                                style: ConstantTextStyle.feedBackHeadText,
                              ),
                              SizedBox(height: screenHeight/80.0),

                              customeText(
                                  text: '₹ ${(double.tryParse(item['subscription_price'] ?? item['service_price'] ?? '') ?? 0)
                                      .toStringAsFixed(2)}',
                                  style: ConstantTextStyle.feedBackHeadText
                              ),

                              (item['subscription_validity'] != null && item['subscription_validity'].toString().trim().isNotEmpty) ?
                              customeText(
                                text: 'Validity - ${item['subscription_validity'] ?? item['subscription_validity'] ?? ''}',
                                style: ConstantTextStyle.cardbottumText,
                              ) : const SizedBox(),

                              (item['subscription_details'] != null && item['subscription_details'].toString().trim().isNotEmpty) ?
                              InkWell(
                                  onTap: () {
                                    _showCustomDialog(
                                      context,
                                      '${item['subscription_name'] ?? item['service_name'] ?? ''}',
                                      '${item['subscription_details'] ?? item['subscription_details'] ?? ''}',
                                    );
                                  },
                                  child: reedMoreText(text:item['subscription_details'].toString()??""))
                                  : const SizedBox.shrink(),


                              SizedBox(height: screenHeight/80.0),
                              // Generate a list of widgets for each service
                              ...serviceWidgets,

                              SizedBox(height: screenHeight/80.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: customButton(
                                      textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/getSubPlanStartScreen', arguments: {
                                          'subscriptionId': item['subscription_id'].toString() ?? item['service_id'].toString(),
                                          'productId': item['subscription_id'].toString() ?? item['service_id'].toString(),
                                        },);
                                      },
                                      text: "Get Start",
                                      backgroundColor: ConstantColor.primaryMainColor,
                                      borderRadius: BorderRadius.circular(6.0),
                                      elevation: 0.0,
                                      minimumSize: Size(screenWidth, screenHeight / 25.0),
                                    ),
                                  ),
                                  SizedBox(width: screenWidth/30.0),
                                  (item['is_emi'].toString() == '1') ?
                                  Flexible(
                                    child: customButton(
                                      textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/emiOptionsScreen',
                                            arguments: item['subscription_id'].toString() ?? "");
                                      },
                                      text: "Get EMI",
                                      backgroundColor: ConstantColor.loginWithOtpButtonColor,
                                      borderRadius: BorderRadius.circular(6.0),
                                      elevation: 0.0,
                                      minimumSize: Size(screenWidth, screenHeight / 25.0),
                                    ),
                                  ) : const SizedBox(),
                                ],),

                            ],
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  }).toList(),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

// class RenewPlanScreen extends StatefulWidget {
//   const RenewPlanScreen({super.key});
//
//   @override
//   _RenewPlanScreenState createState() => _RenewPlanScreenState();
// }
//
// class _RenewPlanScreenState extends State<RenewPlanScreen>  with SingleTickerProviderStateMixin {
//   bool isYearly = false;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchSubPlanListingData();
//     // _tabController = TabController(length: _tabs.length, vsync: this);
//     _tabController = TabController(length: 3, vsync: this);
//   }
//   final ScrollController _scrollController = ScrollController();
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   var planID = '';
//   bool isPullToRefreshEnabled = true;
//   int currentPage = 1;
//   bool isLoading = false;
//   final RefreshController _refreshController = RefreshController(initialRefresh: false);
//
//   SubscriptionPlanListModels? subscriptionPlanListModels;
//   List<PlanListData>? data = [];
//
//   Future<void> fetchSubPlanListingData() async {
//     try {
//       if (currentPage == 1) {
//         setState(() {
//           isLoading = true;
//           data!.clear();
//         });
//       }
//
//       final subPlanListingResponse = await ApiSubPlanListService.fetchSubPlanListData(context: context);
//
//       if (subPlanListingResponse != null && subPlanListingResponse.data != null) {
//         final dataList = subPlanListingResponse.data!;
//         setState(() {
//           if (currentPage == 1) {
//             data = dataList;
//           } else {
//             data!.addAll(dataList);
//             _refreshController.loadComplete();
//           }
//           isLoading = false;
//           currentPage++;
//         });
//       }
//       else {
//         // No more data available
//         setState(() {
//           isLoading = false;
//           _refreshController.loadNoData();
//           isPullToRefreshEnabled = false; // Disable pull-to-refresh
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _refreshController.loadNoData();
//         isLoading = false;
//       });
//     }
//   }
//
//   List subRegistration = ["Lifetime","Lifetime","Lifetime","Lifetime","Lifetime"];
//   List likeProductList = ["Unlimited","Unlimited","Unlimited","Unlimited","Unlimited"];
//
//
//    TabController? _tabController;
//
//   @override
//   Widget build(BuildContext context) {
//     var screenHeight = MediaQuery.of(context).size.height;
//     var screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor:  ConstantColor.primaryBackgroundMainColor,
//       appBar: AppBar(
//         title: customeText(text: "Purchase New Plans/Renew",style: ConstantTextStyle.landingScreenAppbarText ),
//         centerTitle: true,
//         // titleStyle: ConstantTextStyle.landingScreenAppbarText,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           color: ConstantColor.primaryBackgroundMainColor,
//           onPressed: () => Navigator.pop(context),
//         ),
//         bottom:  TabBar(
//           controller: _tabController,
//             labelColor: ConstantColor.primaryBackgroundMainColor,
//             unselectedLabelColor: ConstantColor.secondtryGrayColor,
//             indicatorColor: ConstantColor.primaryMainColor,
//             labelStyle: const TextStyle(
//               fontSize: 16, // Size of the text for the active tab
//               fontWeight: FontWeight.bold, // Weight of the text for the active tab
//             ),
//             unselectedLabelStyle: const TextStyle(
//               fontSize: 14, // Size of the text for the inactive tabs
//               fontWeight: FontWeight.normal, // Weight of the text for the inactive tabs
//             ),
//           // tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
//           tabs: const [
//             Tab(text: "Quarterly"),
//             Tab(text: "Half Yearly"),
//             Tab(text: "Yearly"),
//           ],
//         ),
//         backgroundColor: ConstantColor.loginWithOtpButtonColor,
//       ),
//
//
//       body: CupertinoScrollbar(
//         child: SmartRefresher(
//           enablePullDown: true,
//           enablePullUp: false,
//           controller: _refreshController,
//           footer: customFooter(),
//           onRefresh: () async {
//             currentPage = 1;
//             await fetchSubPlanListingData();
//             _refreshController.refreshCompleted();
//           },
//           child: data == null || data!.toString().isEmpty
//               ? noDataFound(context)
//               : TabBarView(
//             controller: _tabController,
//             children:
//             [
//    //------tab 1
//               Skeletonizer(
//                 enabled: isLoading,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: data!.map((subscription) {
//                       return Container(
//                         width: screenWidth,
//                         margin: EdgeInsets.symmetric(vertical: screenHeight/60.0,horizontal: screenWidth/20.0),
//                         padding: const EdgeInsets.all(10.0),
//                         decoration: BoxDecoration(
//                           gradient: const LinearGradient(
//                             colors: [
//                               ConstantColor.calendarBGHeadColor,
//                               ConstantColor.primaryBackgroundMainColor,
//                             ],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                           // color: ConstantColor.primaryBackgroundMainColor,
//                           borderRadius: BorderRadius.circular(8.0),
//                           border: Border.all(color: ConstantColor.calendarBGHeadColor),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.2), // Shadow color
//                               spreadRadius: 1,                       // Shadow spread radius
//                               blurRadius: 4,                         // Shadow blur radius
//                               offset: const Offset(0, 5),                  // Shadow offset
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Expanded(
//                                   child: customeText(
//                                     text: subscription.subscriptionName ?? '',
//                                     style: ConstantTextStyle.homeScreenHeadingText2,
//                                   ),
//                                 ),
//                                 subscription.planDiscount.toString().toLowerCase() == '0.0% off' ?
//                                 Container():
//                                 ShineEffect(
//                                     context: context,
//                                     text: subscription.planDiscount.toString()??""
//                                 ),
//                               ],
//                             ),
//                              SizedBox(height: screenHeight/80.0),
//                             customeText(
//                                 text: '₹ ${(double.tryParse(
//                                     subscription.quarterlyPrice ?? '') ?? 0)
//                                     .toStringAsFixed(2)}',
//                                 style: ConstantTextStyle.priceText
//                             ),
//                             SizedBox(height: screenHeight/80.0),
//
//                             // Text(
//                             //   'Half Yearly Price: ₹ ${(double.tryParse(
//                             //       subscription.halfYearlyPrice ?? '') ?? 0)
//                             //       .toStringAsFixed(2)} | 180 days | 0.0% Off',
//                             // ),
//                             // Text(
//                             //   'Yearly Price: ₹ ${(double.tryParse(
//                             //       subscription.yearlyPrice ?? '') ?? 0)
//                             //       .toStringAsFixed(2)} | 365 days | 0.0% Off',
//                             // ),
//                             //  Widget rowCheckText({context, icon, iconColor, title, style}){
//
//                             rowCheckText(context: context, title: '${subscription.subscriptionValidity ?? ''} Days Subscription Validity'),
//
//                             rowCheckText(context: context, title: 'Life Time Shop Registration'),
//
//                             rowCheckText(context: context,
//                                 icon: subscription.noOfProductAllowed.toString() == "0" ?
//                                 Icons.close_outlined :  Icons.check,
//                                 iconColor: subscription.noOfProductAllowed.toString() == "0" ?
//                                 ConstantColor.primaryMainColor: ConstantColor.chipCompleteStatus,
//                                 title: '${subscription.noOfProductAllowed ?? ''} Space For Products'),
//
//                             rowCheckText(context: context,
//                                 icon: subscription.executeVisitUploads.toString() == "0" ?
//                                 Icons.close_outlined :  Icons.check,
//                                 iconColor: subscription.executeVisitUploads.toString() == "0" ?
//                                 ConstantColor.primaryMainColor: ConstantColor.chipCompleteStatus,
//                                 title: '${subscription.executeVisitUploads ?? ''} Executive Visit For Product'),
//
//                             rowCheckText(context: context,
//                                 icon: subscription.topProduct.toString() == "0" ?
//                                 Icons.close_outlined :  Icons.check,
//                                 iconColor: subscription.topProduct.toString() == "0" ?
//                                 ConstantColor.primaryMainColor: ConstantColor.chipCompleteStatus,
//                                 title: '${subscription.topProduct ?? ''} Top product'),
//
//                             rowCheckText(context: context,
//                                 icon: subscription.shopInFocus.toString() == "No" ?
//                                 Icons.close_outlined :  Icons.check,
//                                 iconColor: subscription.shopInFocus.toString() == "No" ?
//                                 ConstantColor.primaryMainColor: ConstantColor.chipCompleteStatus,
//                                 title: '${subscription.shopInFocus ?? ''} Shop in focus'),
//
//                             rowCheckText(context: context, title: 'Unlimited Like Product'),
//
//                             rowCheckText(context: context, title: 'Unlimited Wishlist'),
//
//                             rowCheckText(context: context, title: 'Unlimited Sharing by seller product'),
//
//                             rowCheckText(context: context,
//                                 icon: subscription.discountSection.toString() == "No" ?
//                                 Icons.close_outlined :  Icons.check,
//                                 iconColor: subscription.discountSection.toString() == "No" ?
//                                 ConstantColor.primaryMainColor: ConstantColor.chipCompleteStatus,
//                                 title: '${subscription.discountSection ?? ''} Discount Section (Seller Offer) Your Business'),
//
//                             rowCheckText(context: context, title: 'Yes Chat Function'),
//
//                             rowCheckText(context: context,
//                                 icon: subscription.visitorAnalytics.toString() == "No" ?
//                                 Icons.close_outlined :  Icons.check,
//                                 iconColor: subscription.visitorAnalytics.toString() == "No" ?
//                                 ConstantColor.primaryMainColor: ConstantColor.chipCompleteStatus,
//                                 title: '${subscription.visitorAnalytics ?? ''} Visitor analytics'),
//
//                             rowCheckText(context: context, title: 'Yes Unlimited device'),
//
//                             rowCheckText(context: context, title: 'Yes Personalised Web Page'),
//
//
//                             // Text(
//                             //   'Promotional: ',
//                             // ),
//
//                             rowCheckText(context: context, title: 'Yes Online Market Place'),
//
//                             // const SizedBox(height: 20),
//
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 customButton(
//                                   textStyleButton:ConstantTextStyle.landingScreenAppbarText,
//                                   onPressed: () {
//                                     Navigator.pushNamed(context, '/getSubPlanStartScreen', arguments: {
//                                       'subscriptionId': subscription.subscriptionId,
//                                       'productId': subscription.subscriptionId.toString(),
//                                     },);
//                                   },
//                                   text: "Get Start",
//                                   backgroundColor:
//                                   // subscription.subscriptionName.toString().toUpperCase() == "SWAGATAM"
//                                   //     ?
//                                   ConstantColor.primaryMainColor,
//                                   // : ConstantColor.loginWithOtpButtonColor,
//                                   borderRadius: BorderRadius.circular(8.0),
//                                   minimumSize: Size(screenWidth/30, screenHeight/30),
//                                   elevation: 1.0,
//                                 ),
//                                 // ElevatedButton(
//                                 //   onPressed: () {
//                                 //     Navigator.pushNamed(
//                                 //       context,
//                                 //       '/getSubPlanStartScreen',
//                                 //       arguments: {
//                                 //         'subscriptionId':
//                                 //         subscription.subscriptionId,
//                                 //         'productId': subscription.subscriptionId
//                                 //             .toString(),
//                                 //       },
//                                 //     );
//                                 //   },
//                                 //   style: ElevatedButton.styleFrom(
//                                 //     primary: subscription.subscriptionName
//                                 //         .toString()
//                                 //         .toUpperCase() ==
//                                 //         "SWAGATAM"
//                                 //         ? ConstantColor.primaryMainColor
//                                 //         : ConstantColor.loginWithOtpButtonColor,
//                                 //   ),
//                                 //   child: Text("Get Start"),
//                                 // ),
//                                 if (subscription.subscriptionName.toString().toUpperCase() != "SWAGATAM")
//                                   customButton(
//                                     textStyleButton:ConstantTextStyle.landingScreenAppbarText,
//                                     onPressed: () {
//                                       Navigator.pushNamed(context, '/emiOptionsScreen',
//                                           arguments: subscription.subscriptionId.toString() ?? "");
//                                     },
//                                     text: "Get EMI",
//                                     backgroundColor:  subscription.subscriptionName.toString().toUpperCase() == "SWAGATAM"
//                                         ? ConstantColor.primaryMainColor
//                                         : ConstantColor.loginWithOtpButtonColor,
//                                     borderRadius: BorderRadius.circular(8.0),
//                                     minimumSize: Size(screenWidth/30, screenHeight/30),
//                                     elevation: 1.0,
//                                   ),
//                                 // ElevatedButton(
//                                 //   onPressed: () {
//                                 //     Navigator.pushNamed(context, '/emiOptionsScreen',
//                                 //       arguments: subscription.subscriptionId.toString() ?? "");
//                                 //   },
//                                 //   style: ElevatedButton.styleFrom(
//                                 //     primary: ConstantColor.loginWithOtpButtonColor,
//                                 //   ),
//                                 //   child: Text(""),
//                                 // ),
//                               ],
//                             ),
//
//                           ],
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ),
//   //------tab 2
//               Skeletonizer(
//                 enabled: isLoading,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: data!.map((subscription) {
//                       return Container(
//                         width: screenWidth,
//                         margin: EdgeInsets.symmetric(vertical: screenHeight/60.0,horizontal: screenWidth/20.0),
//                         padding: const EdgeInsets.all(10.0),
//                         decoration: BoxDecoration(
//                           gradient: const LinearGradient(
//                             colors: [
//                               ConstantColor.calendarBGHeadColor,
//                               ConstantColor.primaryBackgroundMainColor,
//                             ],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                           // color: ConstantColor.primaryBackgroundMainColor,
//                           borderRadius: BorderRadius.circular(8.0),
//                           border: Border.all(color: ConstantColor.calendarBGHeadColor),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.2), // Shadow color
//                               spreadRadius: 1,                       // Shadow spread radius
//                               blurRadius: 4,                         // Shadow blur radius
//                               offset: const Offset(0, 5),                  // Shadow offset
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Expanded(
//                                   child: customeText(
//                                     text: subscription.subscriptionName ?? '',
//                                     style: ConstantTextStyle.homeScreenHeadingText2,
//                                   ),
//                                 ),
//                                 subscription.planDiscount.toString().toLowerCase() == '0.0% off' ?
//                                 Container():
//                                 ShineEffect(
//                                     context: context,
//                                     text: subscription.planDiscount.toString()??""
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: screenHeight/80.0),
//                             customeText(
//                                 text: '₹ ${(double.tryParse(
//                                     subscription.halfYearlyPrice ?? '') ?? 0)
//                                     .toStringAsFixed(2)}',
//                                 style: ConstantTextStyle.priceText
//                             ),
//                             SizedBox(height: screenHeight/80.0),
//                             // Text(
//                             //   'Half Yearly Price: ₹ ${(double.tryParse(
//                             //       subscription.halfYearlyPrice ?? '') ?? 0)
//                             //       .toStringAsFixed(2)} | 180 days | 0.0% Off',
//                             // ),
//                             // Text(
//                             //   'Yearly Price: ₹ ${(double.tryParse(
//                             //       subscription.yearlyPrice ?? '') ?? 0)
//                             //       .toStringAsFixed(2)} | 365 days | 0.0% Off',
//                             // ),
//                             //  Widget rowCheckText({context, icon, iconColor, title, style}){
//                             rowCheckText(context: context, title: '${subscription.subscriptionValidity ?? ''} Days Subscription Validity'),
//
//                             rowCheckText(context: context, title: 'Life Time Shop Registration'),
//
//                             rowCheckText(context: context,
//                                 icon: subscription.noOfProductAllowed.toString() == "0" ?
//                                 Icons.close_outlined :  Icons.check,
//                                 iconColor: subscription.noOfProductAllowed.toString() == "0" ?
//                                 ConstantColor.primaryMainColor: ConstantColor.chipCompleteStatus,
//                                 title: '${subscription.noOfProductAllowed ?? ''} Space For Products'),
//
//                             rowCheckText(context: context,
//                                 icon: subscription.executeVisitUploads.toString() == "0" ?
//                                 Icons.close_outlined :  Icons.check,
//                                 iconColor: subscription.executeVisitUploads.toString() == "0" ?
//                                 ConstantColor.primaryMainColor: ConstantColor.chipCompleteStatus,
//                                 title: '${subscription.executeVisitUploads ?? ''} Executive Visit For Product'),
//
//                             rowCheckText(context: context,
//                                 icon: subscription.topProduct.toString() == "0" ?
//                                 Icons.close_outlined :  Icons.check,
//                                 iconColor: subscription.topProduct.toString() == "0" ?
//                                 ConstantColor.primaryMainColor: ConstantColor.chipCompleteStatus,
//                                 title: '${subscription.topProduct ?? ''} Top product'),
//
//                             rowCheckText(context: context,
//                                 icon: subscription.shopInFocus.toString() == "No" ?
//                                 Icons.close_outlined :  Icons.check,
//                                 iconColor: subscription.shopInFocus.toString() == "No" ?
//                                 ConstantColor.primaryMainColor: ConstantColor.chipCompleteStatus,
//                                 title: '${subscription.shopInFocus ?? ''} Shop in focus'),
//
//                             rowCheckText(context: context, title: 'Unlimited Like Product'),
//
//                             rowCheckText(context: context, title: 'Unlimited Wishlist'),
//
//                             rowCheckText(context: context, title: 'Unlimited Sharing by seller product'),
//
//                             rowCheckText(context: context,
//                                 icon: subscription.discountSection.toString() == "No" ?
//                                 Icons.close_outlined :  Icons.check,
//                                 iconColor: subscription.discountSection.toString() == "No" ?
//                                 ConstantColor.primaryMainColor: ConstantColor.chipCompleteStatus,
//                                 title: '${subscription.discountSection ?? ''} Discount Section (Seller Offer) Your Business'),
//
//                             rowCheckText(context: context, title: 'Yes Chat Function'),
//
//                             rowCheckText(context: context,
//                                 icon: subscription.visitorAnalytics.toString() == "No" ?
//                                 Icons.close_outlined :  Icons.check,
//                                 iconColor: subscription.visitorAnalytics.toString() == "No" ?
//                                 ConstantColor.primaryMainColor: ConstantColor.chipCompleteStatus,
//                                 title: '${subscription.visitorAnalytics ?? ''} Visitor analytics'),
//
//                             rowCheckText(context: context, title: 'Yes Unlimited device'),
//
//                             rowCheckText(context: context, title: 'Yes Personalised Web Page'),
//
//
//                             // Text(
//                             //   'Promotional: ',
//                             // ),
//
//                             rowCheckText(context: context, title: 'Yes Online Market Place'),
//
//                             // const SizedBox(height: 20),
//
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 customButton(
//                                   textStyleButton:ConstantTextStyle.landingScreenAppbarText,
//                                   onPressed: () {
//                                     Navigator.pushNamed(context, '/getSubPlanStartScreen', arguments: {
//                                       'subscriptionId': subscription.subscriptionId,
//                                       'productId': subscription.subscriptionId.toString(),
//                                     },);
//                                   },
//                                   text: "Get Start",
//                                   backgroundColor:
//                                   // subscription.subscriptionName.toString().toUpperCase() == "SWAGATAM"
//                                   //     ?
//                                   ConstantColor.primaryMainColor,
//                                   // : ConstantColor.loginWithOtpButtonColor,
//                                   borderRadius: BorderRadius.circular(8.0),
//                                   minimumSize: Size(screenWidth/30, screenHeight/30),
//                                   elevation: 1.0,
//                                 ),
//                                 // ElevatedButton(
//                                 //   onPressed: () {
//                                 //     Navigator.pushNamed(
//                                 //       context,
//                                 //       '/getSubPlanStartScreen',
//                                 //       arguments: {
//                                 //         'subscriptionId':
//                                 //         subscription.subscriptionId,
//                                 //         'productId': subscription.subscriptionId
//                                 //             .toString(),
//                                 //       },
//                                 //     );
//                                 //   },
//                                 //   style: ElevatedButton.styleFrom(
//                                 //     primary: subscription.subscriptionName
//                                 //         .toString()
//                                 //         .toUpperCase() ==
//                                 //         "SWAGATAM"
//                                 //         ? ConstantColor.primaryMainColor
//                                 //         : ConstantColor.loginWithOtpButtonColor,
//                                 //   ),
//                                 //   child: Text("Get Start"),
//                                 // ),
//                                 if (subscription.subscriptionName.toString().toUpperCase() != "SWAGATAM")
//                                   customButton(
//                                     textStyleButton:ConstantTextStyle.landingScreenAppbarText,
//                                     onPressed: () {
//                                       Navigator.pushNamed(context, '/emiOptionsScreen',
//                                           arguments: subscription.subscriptionId.toString() ?? "");
//                                     },
//                                     text: "Get EMI",
//                                     backgroundColor:  subscription.subscriptionName.toString().toUpperCase() == "SWAGATAM"
//                                         ? ConstantColor.primaryMainColor
//                                         : ConstantColor.loginWithOtpButtonColor,
//                                     borderRadius: BorderRadius.circular(8.0),
//                                     minimumSize: Size(screenWidth/30, screenHeight/30),
//                                     elevation: 1.0,
//                                   ),
//                                 // ElevatedButton(
//                                 //   onPressed: () {
//                                 //     Navigator.pushNamed(context, '/emiOptionsScreen',
//                                 //       arguments: subscription.subscriptionId.toString() ?? "");
//                                 //   },
//                                 //   style: ElevatedButton.styleFrom(
//                                 //     primary: ConstantColor.loginWithOtpButtonColor,
//                                 //   ),
//                                 //   child: Text(""),
//                                 // ),
//                               ],
//                             ),
//
//                           ],
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ),
//   //------tab 3
//               Skeletonizer(
//                 enabled: isLoading,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: data!.map((subscription) {
//                       return Container(
//                         width: screenWidth,
//                         margin: EdgeInsets.symmetric(vertical: screenHeight/60.0,horizontal: screenWidth/20.0),
//                         padding: const EdgeInsets.all(10.0),
//                         decoration: BoxDecoration(
//                           gradient: const LinearGradient(
//                             colors: [
//                               ConstantColor.calendarBGHeadColor,
//                               ConstantColor.primaryBackgroundMainColor,
//                             ],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                           // color: ConstantColor.primaryBackgroundMainColor,
//                           borderRadius: BorderRadius.circular(8.0),
//                           border: Border.all(color: ConstantColor.calendarBGHeadColor),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.2), // Shadow color
//                               spreadRadius: 1,                       // Shadow spread radius
//                               blurRadius: 4,                         // Shadow blur radius
//                               offset: const Offset(0, 5),                  // Shadow offset
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Expanded(
//                                   child: customeText(
//                                     text: subscription.subscriptionName ?? '',
//                                     style: ConstantTextStyle.homeScreenHeadingText2,
//                                   ),
//                                 ),
//                                 subscription.planDiscount.toString().toLowerCase() == '0.0% off' ?
//                                 Container():
//                                 ShineEffect(
//                                     context: context,
//                                     text: subscription.planDiscount.toString()??""
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: screenHeight/80.0),
//                             customeText(
//                                 text: '₹ ${(double.tryParse(
//                                     subscription.yearlyPrice ?? '') ?? 0)
//                                     .toStringAsFixed(2)}',
//                                 style: ConstantTextStyle.priceText
//                             ),
//                             SizedBox(height: screenHeight/80.0),
//                             // Text(
//                             //   'Half Yearly Price: ₹ ${(double.tryParse(
//                             //       subscription.halfYearlyPrice ?? '') ?? 0)
//                             //       .toStringAsFixed(2)} | 180 days | 0.0% Off',
//                             // ),
//                             // Text(
//                             //   'Yearly Price: ₹ ${(double.tryParse(
//                             //       subscription.yearlyPrice ?? '') ?? 0)
//                             //       .toStringAsFixed(2)} | 365 days | 0.0% Off',
//                             // ),
//                             //  Widget rowCheckText({context, icon, iconColor, title, style}){
//                             rowCheckText(context: context, title: '${subscription.subscriptionValidity ?? ''} Days Subscription Validity'),
//
//                             rowCheckText(context: context, title: 'Life Time Shop Registration'),
//
//                             rowCheckText(context: context,
//                                 icon: subscription.noOfProductAllowed.toString() == "0" ?
//                                 Icons.close_outlined :  Icons.check,
//                                 iconColor: subscription.noOfProductAllowed.toString() == "0" ?
//                                 ConstantColor.primaryMainColor: ConstantColor.chipCompleteStatus,
//                                 title: '${subscription.noOfProductAllowed ?? ''} Space For Products'),
//
//                             rowCheckText(context: context,
//                                 icon: subscription.executeVisitUploads.toString() == "0" ?
//                                 Icons.close_outlined :  Icons.check,
//                                 iconColor: subscription.executeVisitUploads.toString() == "0" ?
//                                 ConstantColor.primaryMainColor: ConstantColor.chipCompleteStatus,
//                                 title: '${subscription.executeVisitUploads ?? ''} Executive Visit For Product'),
//
//                             rowCheckText(context: context,
//                                 icon: subscription.topProduct.toString() == "0" ?
//                                 Icons.close_outlined :  Icons.check,
//                                 iconColor: subscription.topProduct.toString() == "0" ?
//                                 ConstantColor.primaryMainColor: ConstantColor.chipCompleteStatus,
//                                 title: '${subscription.topProduct ?? ''} Top product'),
//
//                             rowCheckText(context: context,
//                                 icon: subscription.shopInFocus.toString() == "No" ?
//                                 Icons.close_outlined :  Icons.check,
//                                 iconColor: subscription.shopInFocus.toString() == "No" ?
//                                 ConstantColor.primaryMainColor: ConstantColor.chipCompleteStatus,
//                                 title: '${subscription.shopInFocus ?? ''} Shop in focus'),
//
//                             rowCheckText(context: context, title: 'Unlimited Like Product'),
//
//                             rowCheckText(context: context, title: 'Unlimited Wishlist'),
//
//                             rowCheckText(context: context, title: 'Unlimited Sharing by seller product'),
//
//                             rowCheckText(context: context,
//                                 icon: subscription.discountSection.toString() == "No" ?
//                                 Icons.close_outlined :  Icons.check,
//                                 iconColor: subscription.discountSection.toString() == "No" ?
//                                 ConstantColor.primaryMainColor: ConstantColor.chipCompleteStatus,
//                                 title: '${subscription.discountSection ?? ''} Discount Section (Seller Offer) Your Business'),
//
//                             rowCheckText(context: context, title: 'Yes Chat Function'),
//
//                             rowCheckText(context: context,
//                                 icon: subscription.visitorAnalytics.toString() == "No" ?
//                                 Icons.close_outlined :  Icons.check,
//                                 iconColor: subscription.visitorAnalytics.toString() == "No" ?
//                                 ConstantColor.primaryMainColor: ConstantColor.chipCompleteStatus,
//                                 title: '${subscription.visitorAnalytics ?? ''} Visitor analytics'),
//
//                             rowCheckText(context: context, title: 'Yes Unlimited device'),
//
//                             rowCheckText(context: context, title: 'Yes Personalised Web Page'),
//
//
//                             // Text(
//                             //   'Promotional: ',
//                             // ),
//
//                             rowCheckText(context: context, title: 'Yes Online Market Place'),
//
//                             // const SizedBox(height: 20),
//
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 customButton(
//                                   textStyleButton:ConstantTextStyle.landingScreenAppbarText,
//                                   onPressed: () {
//                                     Navigator.pushNamed(context, '/getSubPlanStartScreen', arguments: {
//                                       'subscriptionId': subscription.subscriptionId,
//                                       'productId': subscription.subscriptionId.toString(),
//                                     },);
//                                   },
//                                   text: "Get Start",
//                                   backgroundColor:
//                                   // subscription.subscriptionName.toString().toUpperCase() == "SWAGATAM"
//                                   //     ?
//                                   ConstantColor.primaryMainColor,
//                                   // : ConstantColor.loginWithOtpButtonColor,
//                                   borderRadius: BorderRadius.circular(8.0),
//                                   minimumSize: Size(screenWidth/30, screenHeight/30),
//                                   elevation: 1.0,
//                                 ),
//                                 // ElevatedButton(
//                                 //   onPressed: () {
//                                 //     Navigator.pushNamed(
//                                 //       context,
//                                 //       '/getSubPlanStartScreen',
//                                 //       arguments: {
//                                 //         'subscriptionId':
//                                 //         subscription.subscriptionId,
//                                 //         'productId': subscription.subscriptionId
//                                 //             .toString(),
//                                 //       },
//                                 //     );
//                                 //   },
//                                 //   style: ElevatedButton.styleFrom(
//                                 //     primary: subscription.subscriptionName
//                                 //         .toString()
//                                 //         .toUpperCase() ==
//                                 //         "SWAGATAM"
//                                 //         ? ConstantColor.primaryMainColor
//                                 //         : ConstantColor.loginWithOtpButtonColor,
//                                 //   ),
//                                 //   child: Text("Get Start"),
//                                 // ),
//                                 if (subscription.subscriptionName.toString().toUpperCase() != "SWAGATAM")
//                                   customButton(
//                                     textStyleButton:ConstantTextStyle.landingScreenAppbarText,
//                                     onPressed: () {
//                                       Navigator.pushNamed(context, '/emiOptionsScreen',
//                                           arguments: subscription.subscriptionId.toString() ?? "");
//                                     },
//                                     text: "Get EMI",
//                                     backgroundColor:  subscription.subscriptionName.toString().toUpperCase() == "SWAGATAM"
//                                         ? ConstantColor.primaryMainColor
//                                         : ConstantColor.loginWithOtpButtonColor,
//                                     borderRadius: BorderRadius.circular(8.0),
//                                     minimumSize: Size(screenWidth/30, screenHeight/30),
//                                     elevation: 1.0,
//                                   ),
//                                 // ElevatedButton(
//                                 //   onPressed: () {
//                                 //     Navigator.pushNamed(context, '/emiOptionsScreen',
//                                 //       arguments: subscription.subscriptionId.toString() ?? "");
//                                 //   },
//                                 //   style: ElevatedButton.styleFrom(
//                                 //     primary: ConstantColor.loginWithOtpButtonColor,
//                                 //   ),
//                                 //   child: Text(""),
//                                 // ),
//                               ],
//                             ),
//
//                           ],
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



Widget ShineEffect({context, text}) {
  var screenWidth = MediaQuery.of(context).size.width;
  return Stack(
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: screenWidth/40.0),
        decoration: BoxDecoration(
          color: ConstantColor.primaryMainColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12.0),
            bottomLeft: Radius.circular(12.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.5), // Shadow color matching the container
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: customeText(
            text: text??"",
            style: ConstantTextStyle.chipText
        ),
      ),
      Shimmer.fromColors(
        baseColor: ConstantColor.transparent1,
        highlightColor: ConstantColor.carColor,
        child: Container(
          decoration: const BoxDecoration(
            color: ConstantColor.primaryMainColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              bottomLeft: Radius.circular(12.0),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: screenWidth/40.0),
          child: customeText(
              text: text??"",
              style: ConstantTextStyle.chipText
          ),
        ),
      ),
    ],
  );
}

Widget rowCheckText({context, icon, iconColor, title, style}){
  var screenWidth = MediaQuery.of(context).size.width;
  return  Row(
    children: [
      Icon(icon ?? Icons.check, color: iconColor ?? ConstantColor.chipCompleteStatus),
      SizedBox(width: screenWidth/80.0),
      Expanded(child: customeText(
          text:  title ?? '',
          style: style?? ConstantTextStyle.topCategoryText
      ),),
    ],
  );
}




Future<void> _showCustomDialog(BuildContext context, String title, String? details) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 0.0,
        iconPadding: EdgeInsets.zero,
        icon: Align(
            alignment: Alignment.centerRight,
            child: IconButton(icon: const Icon(Icons.close_outlined,color: ConstantColor.primaryMainColor),onPressed: () => Navigator.pop(context),)),
        title: Text(title??"",textAlign: TextAlign.start,style: ConstantTextStyle.countingText,),
        titlePadding: const EdgeInsets.symmetric(horizontal: 20.0),
        content: Text(details??"",textAlign: TextAlign.start,style: ConstantTextStyle.lableTextHeading1),
      );
    },
  );
}
