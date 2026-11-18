// // ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables
//
// import 'package:Citybazar_app/Util/constaint_textstyle.dart';
// import 'package:Citybazar_app/Util/constant_color.dart';
// import 'package:Citybazar_app/Util/constant_image.dart';
// import 'package:Citybazar_app/Widgets/custome_button_.dart';
// import 'package:Citybazar_app/Widgets/custome_richtext.dart';
// import 'package:Citybazar_app/Widgets/custome_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
// import '../../Api Services/Card Api Services/delete_card_api_services.dart';
// import '../../Api Services/Card Api Services/get_card_product_count.dart';
// import '../../Controller/Card Controllers/card_detail_controller.dart';
// import '../../Layouts/Card Details Screen/card_checkout_screen.dart';
// import '../../Layouts/Product View Screens/product_Item_Details.dart';
// import '../../Widgets/Card Details Widgets/Card Images/asset_images_widget.dart';
// import '../../Widgets/Card Details Widgets/Card Images/cached_images_widget.dart';
// import '../../Widgets/Card Details Widgets/Permition Dialog/permition_dialog_widget.dart';
// import '../../Widgets/Card Details Widgets/card_details_header_widget.dart';
// import '../../collapsing_appbar.dart';
//
//
// class CardDetailView extends StatefulWidget {
//   const CardDetailView({super.key});
//
//   @override
//   State<CardDetailView> createState() => _CardDetailViewState();
// }
//
// class _CardDetailViewState extends State<CardDetailView> {
//   @override
//   // void initState() {
//   //   super.initState();
//   //   // fetchCardProductsListData();
//   // }
//
//   // dynamic currentPage = 1;
//   // // final ScrollController _scrollController = ScrollController();
//   // final TextEditingController searchController = TextEditingController();
//
//   // @override
//   // void dispose() {
//   //   // _scrollController.dispose();
//   //   searchController.dispose();
//   //   // selectedCheckBoxs = '';
//   //   super.dispose();
//   // }
//   //
//   // bool isPullToRefreshEnabled = true;
//   // var limit = '12';
//   bool isLoading = false;
//   // bool isHashLoad = false;
//   //
//   // final RefreshController _refreshController = RefreshController(initialRefresh: false);
//   // CardDetailsModel? cardDetailsModel;
//   // List<Data>? data = [];
//   //
//   //
//   //CardDeleteApiService
//   ProductCount? productCount;
//
//   Future<void> fetchProductCount() async {
//     setState(() {
//       isLoading = true; // Set loading state
//     });
//
//     try {
//       final productCountResponse = await CardProductCountApiService.cardProductCountData(context: context);
//
//       setState(() {
//         isLoading = false; // Reset loading state
//         productCount = productCountResponse; // Update productCount with API response
//       });
//     } catch (e) {
//       setState(() {
//         isLoading = false; // Reset loading state on error
//       });
//       print('Error fetching product count: $e');
//     }
//   }
//
//
//   Future<bool> onWillPop() async {
//     Navigator.pushReplacement(context, MaterialPageRoute(
//         builder: (context) => MyHomePageDemo1(mobilenumber: '', lat: '', longitude: '', id: '', lName: '')),);
//     return true;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final arguments = Get.arguments as Map<String, dynamic>?;
//     final id = arguments?['id']??"";
//     final lName = arguments?['lName']??"";
//     final longitude = arguments?['longitude']??"";
//     final latitude = arguments?['latitude']??"";
//     var screenW = MediaQuery.of(context).size.width;
//     var screenH = MediaQuery.of(context).size.width;
//     final CardDetailController controller = Get.put(CardDetailController());
//
//
//     return WillPopScope(
//       onWillPop: onWillPop,
//       child: Scaffold(
//         backgroundColor: ConstantColor.secondryBackgroundMainColor,
//         // backgroundColor: ConstantColor.primaryBackgroundMainColor,
//         appBar: AppBar(
//           elevation: 0.0,
//           centerTitle: false,
//           leading: IconButton(onPressed: () => onWillPop(),icon: const Icon(Icons.arrow_back),),
//           title:customeText(text: "Cart Details",style: ConstantTextStyle.appBarTitleText),
//           backgroundColor: ConstantColor.drawerDividerColor,
//         ),
//         body:   Obx(() {
//           if (controller.isLoading.value) {
//             return const SpinKitCircle(
//                 color: ConstantColor.primaryMainColor, size: 30.0);
//           } else if (controller.cardDetails.isEmpty) {
//             return Center(child: Container(
//                 alignment: Alignment.center,
//                 padding: EdgeInsets.symmetric(
//                     horizontal: screenW / 30.0, vertical: screenH / 80.0),
//                 decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: ConstantColor.primaryGreyColor.withOpacity(0.5),
//                         spreadRadius: 0,
//                         blurRadius: 2,
//                         offset: const Offset(
//                             0, 3), // changes position of shadow
//                       ),
//                     ],
//                     color: ConstantColor.primaryBackgroundMainColor,
//                     borderRadius: BorderRadius.circular(10.0)),
//                 child: Column(
//                   children: [
//                     assetImageWidget(
//                       imageFile: ConstantImage.noCardProductImage ?? "",
//                       width: screenW / 4.0,
//                     ),
//                     customeText(text: "Your cart is empty!",
//                       style: ConstantTextStyle.carouselSliderText,),
//                     SizedBox(height: screenH / 80.0,),
//                     customeText(textAlign: TextAlign.center,
//                       text: "You have no items in your cart.\n Let's go buy something",
//                       style: ConstantTextStyle.homeScreenHeadingText3,),
//                     SizedBox(height: screenH / 80.0,),
//                     customeButton(
//                       onPressed: () => Navigator.pop(context),
//                       text: "Continue Shopping",
//                       style: ConstantTextStyle.chipText,
//                       borderRadius: BorderRadius.circular(10.0),
//                       backgroundColor: ConstantColor.primaryMainColor,
//                       // minimumSize: Size(screenW, screenH/24.0),
//                     ),
//                   ],
//                 )));
//           }
//
//           return SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                   horizontal: screenW / 30.0, vertical: screenH / 80.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   customeText(text: "Cart Details",
//                       style: ConstantTextStyle.passwordScreenLineTexStyle),
//                   SizedBox(height: screenH / 80.0,),
//                   // isLoading
//                   //     ?  const SpinKitCircle(color: ConstantColor.primaryMainColor, size: 40.0)
//                   //     : (data != null && data!.isNotEmpty && data!.toString().isNotEmpty)
//                   //     ?
//                   Container(
//                     width: screenW,
//                     padding: const EdgeInsets.all(15.0),
//                     decoration: BoxDecoration(
//                         color: ConstantColor.primaryBackgroundMainColor,
//                         borderRadius: BorderRadius.circular(8.0),
//                         border: Border.all(color: ConstantColor.progressBGolor)
//                     ),
//                     child: ListView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: controller!.cardDetails?.length ?? 0,
//                         itemBuilder: (context, index) {
//                           return Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: screenW / 40.0,
//                                     vertical: screenH / 60.0),
//                                 margin: EdgeInsets.symmetric(
//                                     vertical: screenH / 60.0),
//                                 decoration: BoxDecoration(
//                                     color: ConstantColor.progressBGolor,
//                                     borderRadius: BorderRadius.circular(8.0)
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     buildListItem(
//                                       icon: Icons.storefront,
//                                       title: controller!.cardDetails![index].storeName ?? "",
//                                       subtitle: "No Exchange, No Return",
//                                       textStyle: ConstantTextStyle
//                                           .carouselSliderText,
//                                       subtitleStyle: ConstantTextStyle
//                                           .hintTextStyle,
//                                     ),
//                                     buildListItem(
//                                       icon: Icons.local_shipping,
//                                       title: controller!.cardDetails![index].deliveryMode ?? "",
//                                       textStyle: ConstantTextStyle
//                                           .topCategoryText,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               ...controller!.cardDetails![index].cart!.map((dataItems) {
//                                 return Container(
//                                   padding: const EdgeInsets.all(8.0),
//                                   margin: EdgeInsets.symmetric(
//                                       vertical: screenH / 100.0),
//                                   decoration: BoxDecoration(border: Border.all(
//                                       color: ConstantColor.primaryGreyColor
//                                           .withOpacity(0.5)),
//                                     borderRadius: BorderRadius.circular(0.5),
//                                   ),
//                                   child: Row(
//                                     children: [
//                                       InkWell(
//                                         onTap: () {
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (_) =>
//                                                   ProductDetailScreen(
//                                                     proId: dataItems!.productId ?? "",
//                                                     id: id ?? "",
//                                                     longitude: longitude ?? "",
//                                                     latitude: latitude ?? "",
//                                                     lName: lName ?? "",
//                                                   ),
//                                             ),
//                                           );
//                                         },
//                                         child: cachedImageWidget(
//                                             imageFile: dataItems!
//                                                 .productImage ?? "",
//                                             width: screenW / 5.0,
//                                             height: screenH / 7.0
//                                         ),
//                                       ),
//                                       Flexible(
//                                         child: Padding(
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: screenW / 40.0,
//                                               vertical: screenH / 80.0),
//                                           child: Column(
//                                             crossAxisAlignment: CrossAxisAlignment
//                                                 .start,
//                                             children: [
//                                               customeText(text: dataItems!
//                                                   .productTitle ?? "",
//                                                   style: ConstantTextStyle
//                                                       .productTitleText),
//                                               customRichText(
//                                                   TextAlign: TextAlign.start,
//                                                   text1: '₹ ${dataItems!
//                                                       .offerPrice == null
//                                                       ? dataItems!.price
//                                                       .toString()
//                                                       : dataItems!.offerPrice
//                                                       .toString() ?? ""}\t\t',
//                                                   style1: ConstantTextStyle
//                                                       .allHomeScreenAvatarText,
//                                                   text2: '₹ ${dataItems!
//                                                       .price ?? ""}',
//                                                   style2: ConstantTextStyle
//                                                       .offerPriceGrey),
//
//                                               Align(
//                                                 alignment: Alignment
//                                                     .centerRight,
//                                                 child: OutlinedButton(
//                                                     onPressed: () {
//                                                       YesNoPermissionDialog
//                                                           .showExitConfirmationDialog(
//                                                         context: context,
//                                                         title: 'Please Confirm!',
//                                                         content: 'Are you sure want to remove this Product?',
//                                                         actions: [
//                                                           customeButton(
//                                                             textStyleButton: ConstantTextStyle
//                                                                 .landingScreenAppbarText,
//                                                             onPressed: () async {
//                                                               Navigator.pop(
//                                                                   context);
//                                                               await CardDeleteApiService
//                                                                   .fetchCardDeleteData(
//                                                                 context: context,
//                                                                 cartId: dataItems!
//                                                                     .cartId ??
//                                                                     "",
//                                                                 onSuccess: () {
//                                                                   controller!.isLoading;
//                                                                   controller!.cardDetails!.clear();
//                                                                   controller.refreshCardDetails();
//                                                                   // fetchCardProductsListData();
//                                                                   fetchProductCount();
//                                                                 },
//                                                               );
//                                                             },
//                                                             text: "Yes",
//                                                             backgroundColor: ConstantColor
//                                                                 .loginWithOtpButtonColor,
//                                                             borderRadius: BorderRadius
//                                                                 .circular(20.0),
//                                                             elevation: 0.0,
//                                                           ),
//                                                           SizedBox(
//                                                             width: screenW /
//                                                                 100.0,),
//                                                           customeButton(
//                                                             textStyleButton: ConstantTextStyle
//                                                                 .landingScreenAppbarText,
//                                                             onPressed: () =>
//                                                                 Navigator.pop(
//                                                                     context),
//                                                             text: "No",
//                                                             backgroundColor: ConstantColor
//                                                                 .primaryMainColor,
//                                                             borderRadius: BorderRadius
//                                                                 .circular(20.0),
//                                                             elevation: 0.0,
//                                                           ),
//                                                         ],
//                                                       );
//                                                     },
//                                                     style: ButtonStyle(
//                                                         side: MaterialStateProperty
//                                                             .all(
//                                                             const BorderSide(
//                                                                 color: ConstantColor
//                                                                     .primaryMainColor,
//                                                                 width: 1.0))),
//                                                     child: customeText(
//                                                         text: 'Remove',
//                                                         style: ConstantTextStyle
//                                                             .hintTextStyle)
//
//                                                 ),
//                                               ),
//
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//
//                                     ],
//                                   ),
//                                 );
//                               }),
//
//
//                               customeButton(
//                                 //textStyleButton,onPressed,text,backgroundColor,borderRadius,minimumSize,elevation,textStyle,style
//                                 onPressed: () {
//                                   Navigator.push(context,
//                                     MaterialPageRoute(builder: (context) =>
//                                         CardCheckoutDetailsScreen(
//                                           sellerId: controller!.cardDetails![index].sellerId ?? "",
//                                           id: id??"",
//                                           longitude: longitude??"",
//                                           lattude: latitude??"",
//                                           lName: lName??"",
//                                         )),
//                                   );
//                                 },
//                                 text: "Place Order",
//                                 style: ConstantTextStyle.chipText,
//                                 borderRadius: BorderRadius.circular(10.0),
//                                 backgroundColor: ConstantColor.primaryMainColor,
//                                 minimumSize: Size(screenW, screenH / 24.0),
//
//                               ),
//
//                             ],
//                           );
//                         }
//                     ),
//                   )
//                   // : Center(child: Container(
//                   // padding: EdgeInsets.symmetric(horizontal: screenW/30.0,vertical: screenH/80.0),
//                   // decoration: BoxDecoration(
//                   //     boxShadow: [
//                   //       BoxShadow(
//                   //         color: ConstantColor.primaryGreyColor.withOpacity(0.5),
//                   //         spreadRadius: 0,
//                   //         blurRadius: 2,
//                   //         offset: const Offset(0, 3), // changes position of shadow
//                   //       ),
//                   //     ],
//                   //     color: ConstantColor.primaryBackgroundMainColor,
//                   //     borderRadius: BorderRadius.circular(10.0)),
//                   // child: Column(
//                   //   children: [
//                   //     assetImageWidget(
//                   //       imageFile: ConstantImage.noCardProductImage??"",
//                   //       width: screenW/4.0,
//                   //     ),
//                   //     customeText(text: "Your cart is empty!",style: ConstantTextStyle.carouselSliderText,),
//                   //     SizedBox(height: screenH/80.0,),
//                   //     customeText(textAlign: TextAlign.center,
//                   //       text: "You have no items in your cart.\n Let's go buy something",style: ConstantTextStyle.homeScreenHeadingText3,),
//                   //     SizedBox(height: screenH/80.0,),
//                   //     customeButton(
//                   //       onPressed: () => onWillPop(),
//                   //       text: "Continue Shopping",
//                   //       style: ConstantTextStyle.chipText,
//                   //       borderRadius: BorderRadius.circular(10.0),
//                   //       backgroundColor: ConstantColor.primaryMainColor,
//                   //       // minimumSize: Size(screenW, screenH/24.0),
//                   //     ),
//                   //   ],
//                   // ))),
//                 ],
//               ),
//             ),
//           );
//         }
//         ),
//       ),
//     );
//   }
// }
//
//
