// ignore_for_file: library_private_types_in_public_api

// import 'dart:convert'; // Import this for JSON decoding
// import 'package:citybazaronline_seller_app/Utils/Theme/constant_colors.dart';
// import 'package:citybazaronline_seller_app/Widget/custome_text_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:readmore/readmore.dart';
// import 'Screen/My Subscription Plan Screen/purchese_new_plan_renew_screen.dart';
// import 'Services/Purchase New Plan Api Services/subscription_plan_listing_api_services.dart';
// import 'Utils/Font Style/text_styles.dart';
// import 'Widget/Custome Buttons/elevetion_button_widget.dart';
//
// class MyTabScreen extends StatefulWidget {
//   const MyTabScreen({super.key});
//
//   @override
//   _MyTabScreenState createState() => _MyTabScreenState();
// }
//
// class _MyTabScreenState extends State<MyTabScreen> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   List<String> _tabs = []; // Initialize with an empty list
//   Map<String, dynamic> _tabData = {}; // Initialize with an empty map
//
//   String jsonString = '';
//   bool _isTopUpPlan = true;
//   bool isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchSubPlanListingData(); // Fetch data on initialization
//   }
//
//   void _togglePlan(bool isTopUpPlan) {
//     setState(() {
//       _isTopUpPlan = isTopUpPlan;
//     });
//   }
//
//   //-------api calling -----------
//   Future<void> fetchSubPlanListingData() async {
//     setState(() {
//       isLoading = true;
//     });
//
//     try {
//       final subPlanListingResponse = await ApiSubPlanListService.fetchSubPlanListData2(context: context);
//
//       if (subPlanListingResponse != null) {
//         jsonString = jsonEncode(subPlanListingResponse);
//
//         // Parse the JSON data and initialize tabs and tabData
//         final Map<String, dynamic> jsonData = jsonDecode(jsonString);
//         final List<dynamic> dataList = jsonData['data'] ?? [];
//
//         setState(() {
//           _tabs = dataList.map<String>((item) => item['group_name'] as String).toList();
//           _tabData = {
//             for (var item in dataList)
//               item['group_name']: {
//                 'Regular Plan': item['regularPlan'] ?? [],
//                 'Top Up Plan': item['topUpPlan'] ?? []
//               }
//           };
//
//           // Initialize TabController with the length of _tabs
//           _tabController = TabController(length: _tabs.length, vsync: this);
//         });
//       } else {
//         jsonString = "";
//       }
//     } catch (e) {
//       jsonString = "";
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   //--------------dialog data-------
//   //-checked data ----is present or not----
//   Widget buildConditionalRowCheckText(BuildContext context, String? value, String title, {IconData? icon, Color? iconColor}) {
//     if (value == null || value.isEmpty) {
//       return const SizedBox.shrink(); // Return an empty widget if the value is null or empty
//     }
//     return rowCheckText(
//       context: context,
//       title: title,
//       icon: icon,
//       iconColor: iconColor,
//     );
//   }
//
//
//   _showPlanDetailsDialog(Map<String, dynamic> item) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         final screenHeight = MediaQuery.of(context).size.height;
//         final screenWidth = MediaQuery.of(context).size.width;
//
//         return AlertDialog(
//           contentPadding: EdgeInsets.zero,
//           elevation: 5.0,
//           //symmetric(horizontal: screenWidth/20.0,vertical: screenHeight/60.0),
//           content: SingleChildScrollView(
//             child: Container(
//               width: screenWidth,
//               padding: EdgeInsets.symmetric(vertical: screenHeight/60.0,horizontal: screenWidth/20.0),
//               // padding: const EdgeInsets.all(10.0),
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [
//                     ConstantColor.calendarBGHeadColor,
//                     ConstantColor.primaryBackgroundMainColor,
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 // color: ConstantColor.primaryBackgroundMainColor,
//                 borderRadius: BorderRadius.circular(8.0),
//                 border: Border.all(color: ConstantColor.calendarBGHeadColor),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.2), // Shadow color
//                     spreadRadius: 1,                       // Shadow spread radius
//                     blurRadius: 4,                         // Shadow blur radius
//                     offset: const Offset(0, 5),                  // Shadow offset
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   customeText(
//                     text: item['subscription_name']?? item['service_name']  ?? '',
//                     style: ConstantTextStyle.homeScreenHeadingText2,
//                   ),
//                   SizedBox(height: screenHeight/80.0),
//                   customeText(
//                       text: '₹ ${(double.tryParse(item['subscription_price'] ?? item['service_price'] ?? '') ?? 0).toStringAsFixed(2)}',
//                       style: ConstantTextStyle.priceText
//                   ),
//                   SizedBox(height: screenHeight/80.0),
//
//                   // rowCheckText(context: context, title: '${item['subscription_validity'] ?? ''} Days Subscription Validity'),
//
//                   buildConditionalRowCheckText(context,
//                     item['subscription_validity']?.toString(),
//                     '${item['subscription_validity'] ?? ''} Days Subscription Validity',
//                   ),
//
//                   rowCheckText(context: context, title: 'Life Time Shop Registration'),
//                   // buildConditionalRowCheckText(
//                   //   context,
//                   //   null, // No value for this row
//                   //   'Life Time Shop Registration',
//                   // ),
//
//                   buildConditionalRowCheckText(
//                     context,
//                     item['no_of_product_allowed']?.toString(),
//                     '${item['no_of_product_allowed'].toString() ?? ''} Space For Products',
//                     icon: item['no_of_product_allowed'].toString() == "0" ? Icons.close_outlined : Icons.check,
//                     iconColor: item['no_of_product_allowed'].toString() == "0" ? ConstantColor.primaryMainColor : ConstantColor.chipCompleteStatus,
//                   ),
//                   // rowCheckText(context: context,
//                   //     icon: item['no_of_product_allowed'].toString() == "0" ?
//                   //     Icons.close_outlined :  Icons.check,
//                   //     iconColor: item['no_of_product_allowed'].toString() == "0" ?
//                   //     ConstantColor.primaryMainColor: ConstantColor.chipCompleteStatus,
//                   //     title: '${item['no_of_product_allowed'].toString() ?? ''} Space For Products'),
//                   buildConditionalRowCheckText(
//                     context,
//                     item['execute_visit_uploads']?.toString(),
//                     '${item['execute_visit_uploads'].toString() ?? ''} Executive Visit For Product',
//                     icon: item['execute_visit_uploads'].toString() == "0" ? Icons.close_outlined : Icons.check,
//                     iconColor: item['execute_visit_uploads'].toString() == "0" ? ConstantColor.primaryMainColor : ConstantColor.chipCompleteStatus,
//                   ),
//                   // rowCheckText(context: context,
//                   //     icon: item['execute_visit_uploads'].toString() == "0" ?
//                   //     Icons.close_outlined :  Icons.check,
//                   //     iconColor: item['execute_visit_uploads'].toString() == "0" ?
//                   //     ConstantColor.primaryMainColor: ConstantColor.chipCompleteStatus,
//                   //     title: '${item['execute_visit_uploads'].toString() ?? ''} Executive Visit For Product'),
//                   buildConditionalRowCheckText(
//                     context,
//                     item['top_product']?.toString(),
//                     '${item['top_product'].toString() ?? ''} Top product',
//                     icon: item['top_product'].toString() == "0" ? Icons.close_outlined : Icons.check,
//                     iconColor: item['top_product'].toString() == "0" ? ConstantColor.primaryMainColor : ConstantColor.chipCompleteStatus,
//                   ),
//                   // rowCheckText(context: context,
//                   //     icon: item['top_product'].toString() == "0" ?
//                   //     Icons.close_outlined :  Icons.check,
//                   //     iconColor: item['top_product'].toString() == "0" ?
//                   //     ConstantColor.primaryMainColor: ConstantColor.chipCompleteStatus,
//                   //     title: '${item['top_product'].toString() ?? ''} Top product'),
//
//                   buildConditionalRowCheckText(
//                     context,
//                     item['shop_in_focus']?.toString(),
//                     '${item['shop_in_focus'].toString() ?? ''} Shop in focus',
//                     icon: item['shop_in_focus'].toString() == "No" ? Icons.close_outlined : Icons.check,
//                     iconColor: item['shop_in_focus'].toString() == "No" ? ConstantColor.primaryMainColor : ConstantColor.chipCompleteStatus,
//                   ),
//                   // rowCheckText(context: context,
//                   //     icon: item['shop_in_focus'].toString() == "No" ?
//                   //     Icons.close_outlined :  Icons.check,
//                   //     iconColor: item['shop_in_focus'].toString() == "No" ?
//                   //     ConstantColor.primaryMainColor: ConstantColor.chipCompleteStatus,
//                   //     title: '${item['shop_in_focus'].toString() ?? ''} Shop in focus'),
//
//                   rowCheckText(context: context, title: 'Unlimited Like Product'),
//
//                   rowCheckText(context: context, title: 'Unlimited Wishlist'),
//
//                   rowCheckText(context: context, title: 'Unlimited Sharing by seller product'),
//
//                   buildConditionalRowCheckText(
//                     context,
//                     item['discount_section']?.toString(),
//                     '${item['discount_section'].toString() ?? ''} Discount Section (Seller Offer) Your Business',
//                     icon: item['discount_section'].toString() == "No" ? Icons.close_outlined : Icons.check,
//                     iconColor: item['discount_section'].toString() == "No" ? ConstantColor.primaryMainColor : ConstantColor.chipCompleteStatus,
//                   ),
//                   // rowCheckText(context: context,
//                   //     icon: item['discount_section'].toString() == "No" ?
//                   //     Icons.close_outlined :  Icons.check,
//                   //     iconColor: item['discount_section'].toString() == "No" ?
//                   //     ConstantColor.primaryMainColor: ConstantColor.chipCompleteStatus,
//                   //     title: '${item['discount_section'].toString() ?? ''} Discount Section (Seller Offer) Your Business'),
//
//                   rowCheckText(context: context, title: 'Yes Chat Function'),
//
//                   buildConditionalRowCheckText(
//                     context,
//                     item['visitor_analytics']?.toString(),
//                     '${item['visitor_analytics'].toString() ?? ''} Visitor analytics',
//                     icon: item['visitor_analytics'].toString() == "No" ? Icons.close_outlined : Icons.check,
//                     iconColor: item['visitor_analytics'].toString() == "No" ? ConstantColor.primaryMainColor : ConstantColor.chipCompleteStatus,
//                   ),
//                   // rowCheckText(context: context,
//                   //     icon: item['visitor_analytics'].toString() == "No" ?
//                   //     Icons.close_outlined :  Icons.check,
//                   //     iconColor: item['visitor_analytics'].toString() == "No" ?
//                   //     ConstantColor.primaryMainColor: ConstantColor.chipCompleteStatus,
//                   //     title: '${item['visitor_analytics'].toString() ?? ''} Visitor analytics'),
//
//                   rowCheckText(context: context, title: 'Yes Unlimited device'),
//
//                   rowCheckText(context: context, title: 'Yes Personalised Web Page'),
//
//                   rowCheckText(context: context, title: 'Yes Online Market Place'),
//
//                   // const SizedBox(height: 20),
//
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       customButton(
//                         textStyleButton:ConstantTextStyle.landingScreenAppbarText,
//                         onPressed: () {
//                           Navigator.pushNamed(context, '/getSubPlanStartScreen', arguments: {
//                             'subscriptionId': item['subscription_id'].toString() ?? item['service_id'].toString(),
//                             'productId': item['subscription_id'].toString() ?? item['service_id'].toString(),
//                           },);
//                         },
//                         text: "Get Start",
//                         backgroundColor:
//                         // subscription.subscriptionName.toString().toUpperCase() == "SWAGATAM"
//                         //     ?
//                         ConstantColor.primaryMainColor,
//                         // : ConstantColor.loginWithOtpButtonColor,
//                         borderRadius: BorderRadius.circular(8.0),
//                         minimumSize: Size(screenWidth/30, screenHeight/30),
//                         elevation: 1.0,
//                       ),
//                       // ElevatedButton(
//                       //   onPressed: () {
//                       //     Navigator.pushNamed(
//                       //       context,
//                       //       '/getSubPlanStartScreen',
//                       //       arguments: {
//                       //         'subscriptionId':
//                       //         subscription.subscriptionId,
//                       //         'productId': subscription.subscriptionId
//                       //             .toString(),
//                       //       },
//                       //     );
//                       //   },
//                       //   style: ElevatedButton.styleFrom(
//                       //     primary: subscription.subscriptionName
//                       //         .toString()
//                       //         .toUpperCase() ==
//                       //         "SWAGATAM"
//                       //         ? ConstantColor.primaryMainColor
//                       //         : ConstantColor.loginWithOtpButtonColor,
//                       //   ),
//                       //   child: Text("Get Start"),
//                       // ),
//                        (item['is_emi'] == null && item['is_emi'].toString() == 'No')
//                       ?  customButton(
//                           textStyleButton:ConstantTextStyle.landingScreenAppbarText,
//                           onPressed: () {
//                             Navigator.pushNamed(context, '/emiOptionsScreen',
//                                 arguments: item['subscription_id'].toString() ?? "");
//                           },
//                           text: "Get EMI",
//                           backgroundColor:
//                           // item['subscription_name'].toString().toUpperCase() == "SWAGATAM"
//                           //     ? ConstantColor.primaryMainColor:
//                                ConstantColor.loginWithOtpButtonColor,
//                           borderRadius: BorderRadius.circular(8.0),
//                           minimumSize: Size(screenWidth/30, screenHeight/30),
//                           elevation: 1.0,
//                         ):Container(),
//                       // ElevatedButton(
//                       //   onPressed: () {
//                       //     Navigator.pushNamed(context, '/emiOptionsScreen',
//                       //       arguments: subscription.subscriptionId.toString() ?? "");
//                       //   },
//                       //   style: ElevatedButton.styleFrom(
//                       //     primary: ConstantColor.loginWithOtpButtonColor,
//                       //   ),
//                       //   child: Text(""),
//                       // ),
//                     ],
//                   ),
//
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     var screenHeight = MediaQuery.of(context).size.height;
//     var screenWidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       backgroundColor: ConstantColor.primaryBackgroundMainColor,
//       appBar: AppBar(
//         backgroundColor: ConstantColor.loginWithOtpButtonColor,
//         title: customeText(text: "Purchase New Plans/Renew",style: ConstantTextStyle.landingScreenAppbarText ),
//         centerTitle: true,
//         // titleStyle: ConstantTextStyle.landingScreenAppbarText,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           color: ConstantColor.primaryBackgroundMainColor,
//           onPressed: () => Navigator.pop(context),
//         ),
//         // backgroundColor: ConstantColor.primaryBackgroundMainColor,
//
//         // flexibleSpace: Container(
//         //   decoration: const BoxDecoration(
//         //     gradient: LinearGradient(
//         //       begin: Alignment.topCenter,
//         //       end: Alignment.bottomCenter,
//         //       colors: [ConstantColor.loginWithOtpButtonColor, ConstantColor.primaryBackgroundMainColor],
//         //     ),
//         //   ),
//         // ),
//         bottom: _tabs.isEmpty
//             ? null
//             : PreferredSize(
//           preferredSize: Size.fromHeight(AppBar().preferredSize.height),
//           child: Container(
//             margin: EdgeInsets.symmetric(horizontal: screenWidth / 30.0),
//             decoration: BoxDecoration(
//               border: Border.all(color: ConstantColor.calendarBGHeadColor),
//               borderRadius: const BorderRadius.only(
//                   topRight: Radius.circular(10.0),
//                   topLeft: Radius.circular(10.0)),
//               color: ConstantColor.primaryBackgroundMainColor,
//             ),
//             child: TabBar(
//               dividerColor: Colors.transparent,
//               indicatorSize: TabBarIndicatorSize.tab,
//               indicator: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10.0),
//                 color: ConstantColor.primaryMainColor,
//               ),
//               isScrollable: true,
//               controller: _tabController,
//               unselectedLabelStyle: ConstantTextStyle.secodHearText,
//               labelStyle: ConstantTextStyle.loginButtonTextStyle,
//               tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
//             ),
//           ),
//         ),
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : TabBarView(
//         controller: _tabController,
//         children: _tabs.map((tab) {
//           final planData = _isTopUpPlan ? _tabData[tab]['Regular Plan'] : _tabData[tab]['Top Up Plan'] ?? [];
//           // Ensure planData is a List<dynamic> before building widgets
//           if (planData is! List<dynamic>) {
//             return const Center(child: Text('No data available for this tab'));
//           }
//
//           return Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(top: screenHeight/80.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     customeText(text: 'Top Up Plan', style: ConstantTextStyle.requirementText),
//                     SizedBox(width: screenWidth/80.0),
//                     Switch(
//                       activeColor: ConstantColor.primaryMainColor,
//                       value: _isTopUpPlan,
//                       onChanged: _togglePlan,
//                     ),
//                     SizedBox(width: screenWidth/80.0),
//                     customeText(text: 'Regular Plan', style: ConstantTextStyle.requirementText),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: ListView(
//                   children: planData.map<Widget>((item) {
//                     List<dynamic> services = item['service'] ?? [];
//                     List<Widget> serviceWidgets = services.map((service) {
//                       // Extract the service name
//                       var serviceName = service['service_name'] ?? '';
//                       var serviceCount = service['service_count'] ?? '';
//
//                       return customeText(
//                         text: "👉 $serviceName : $serviceCount",
//                         style: ConstantTextStyle.cardbottumText,
//                       );
//                     }).toList();
//
//
//                     // Ensure item is a Map
//                     if (item is Map<String, dynamic>) {
//                       return GestureDetector(
//                         onTap: (){
//                           // _showPlanDetailsDialog(item);
//                           },
//                         child: Container(
//                           width: screenWidth,
//                           margin: EdgeInsets.symmetric(vertical: screenHeight/60.0,horizontal: screenWidth/20.0),
//                           padding: const EdgeInsets.all(10.0),
//                           decoration: BoxDecoration(
//                             color: ConstantColor.carColor,
//                         // gradient: const LinearGradient(
//                         //   colors: [
//                         //     ConstantColor.calendarBGHeadColor,
//                         //     ConstantColor.primaryBackgroundMainColor,
//                         //   ],
//                         //   begin: Alignment.topLeft,
//                         //   end: Alignment.bottomRight,
//                         // ),
//                         // color: ConstantColor.primaryBackgroundMainColor,
//                         borderRadius: BorderRadius.circular(8.0),
//                         border: Border.all(color: ConstantColor.calendarBGHeadColor),
//                         boxShadow: [
//                           BoxShadow(
//                             color: ConstantColor.primaryGreyColor.withOpacity(0.4), // Shadow color
//                             spreadRadius: 1,                       // Shadow spread radius
//                             blurRadius: 4,                         // Shadow blur radius
//                             offset: const Offset(0, 5),                  // Shadow offset
//                           ),
//                         ],
//                           ),
//                           child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           customeText(
//                             text: item['subscription_name'] ?? item['service_name'] ?? '',
//                             style: ConstantTextStyle.feedBackHeadText,
//                           ),
//                           SizedBox(height: screenHeight/80.0),
//
//                           customeText(
//                               text: '₹ ${(double.tryParse(item['subscription_price'] ?? item['service_price'] ?? '') ?? 0)
//                                   .toStringAsFixed(2)}',
//                               style: ConstantTextStyle.feedBackHeadText
//                           ),
//
//                           (item['subscription_validity'] != null && item['subscription_validity'].toString().trim().isNotEmpty) ?
//                           customeText(
//                             text: 'Validity : ${item['subscription_validity'] ?? item['subscription_validity'] ?? ''}',
//                             style: ConstantTextStyle.cardbottumText,
//                           ) : const SizedBox(),
//
//                           (item['subscription_details'] != null && item['subscription_details'].toString().trim().isNotEmpty) ?
//                           reedMoreText(text:item['subscription_details'].toString()??"")
//                               : const SizedBox.shrink(),
//
//
//                           SizedBox(height: screenHeight/80.0),
//                             // Generate a list of widgets for each service
//                           ...serviceWidgets,
//
//                           SizedBox(height: screenHeight/80.0),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Flexible(
//                                 child: customButton(
//                                   textStyleButton: ConstantTextStyle.landingScreenAppbarText,
//                                   onPressed: () {
//                                     Navigator.pushNamed(context, '/getSubPlanStartScreen', arguments: {
//                                       'subscriptionId': item['subscription_id'].toString() ?? item['service_id'].toString(),
//                                       'productId': item['subscription_id'].toString() ?? item['service_id'].toString(),
//                                     },);
//                                   },
//                                   text: "Get Start",
//                                   backgroundColor: ConstantColor.primaryMainColor,
//                                   borderRadius: BorderRadius.circular(6.0),
//                                   elevation: 0.0,
//                                   minimumSize: Size(screenWidth, screenHeight / 25.0),
//                                 ),
//                               ),
//                               SizedBox(width: screenWidth/30.0),
//                               (item['is_emi'].toString() == '1') ?
//                               Flexible(
//                                 child: customButton(
//                                   textStyleButton: ConstantTextStyle.landingScreenAppbarText,
//                                   onPressed: () {
//                                     Navigator.pushNamed(context, '/emiOptionsScreen',
//                                         arguments: item['subscription_id'].toString() ?? "");
//                                   },
//                                   text: "Get EMI",
//                                   backgroundColor: ConstantColor.loginWithOtpButtonColor,
//                                   borderRadius: BorderRadius.circular(6.0),
//                                   elevation: 0.0,
//                                   minimumSize: Size(screenWidth, screenHeight / 25.0),
//                                 ),
//                               ) : const SizedBox(),
//                             ],),
//
//                         ],
//                           ),
//                         ),
//                       );
//                     }
//                     return const SizedBox.shrink();
//                   }).toList(),
//                 ),
//               ),
//             ],
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
//

