// import 'dart:convert';
//
// import 'package:Citybazar_app/Widgets/custome_text.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../../Api Services/Constant APi Url/api_urls.dart';
// import '../../Util/constaint_textstyle.dart';
// import '../../Util/constant_color.dart';
// import '../../Util/constant_token.dart';
// import '../../Widgets/Custome Widget/screen_widget.dart';
// import '../../Widgets/Send Enquiry dialogBox/alert_dialog_box.dart';
// import '../../Widgets/arrow_button.dart';
// import '../../Widgets/avatar_scrolling.dart';
// import '../../Widgets/collection_card.dart';
// import '../../Widgets/custom_head_text.dart';
// import '../../Widgets/custome_button_.dart';
// import '../../Widgets/custome_imagies.dart';
// import '../../Widgets/famous_market_card_widget.dart';
// import '../../Widgets/landing_screen_slider.dart';
// import '../Famous Market/Store Details/Store Details Screen/store_details.dart';
// import 'product_list.dart';
//
// class MansProductViewScreen extends StatefulWidget {
//   const MansProductViewScreen({Key? key}) : super(key: key);
//
//   @override
//   State<MansProductViewScreen> createState() => _MansProductViewScreenState();
// }
//
// class _MansProductViewScreenState extends State<MansProductViewScreen> {
//
//   bool discountZoneLeftIconBGColor = false;
//   bool discountZoneRightIconBGColor = false;
//   /*----------------------Arrow Controller left and right start --------------------------*/
//   final ScrollController _scrollController = ScrollController();
//   final double _scrollAmount = 500.0;
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   /*------------------------------scrollList controller start-----------------------------------------*/
//
//   void scrollListRightSide() {
//     _scrollController.animateTo(
//       _scrollController.offset + _scrollAmount,
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.easeInOut,);
//   }
//   void scrollListLeftSide() {
//     _scrollController.animateTo(
//       _scrollController.offset - _scrollAmount,
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//     );
//   }
//
// /*---------------------------------scrollList controller end-------------------------------------------*/
//   /*-----------------------------Arrow Controller left and right end --------------------------*/
//
//   /*----------------------------- Calling button redirect class code start--------------------------*/
//
//   void _launchPhoneCall(String phoneNumber) async {
//     String url = 'tel:$phoneNumber';
//     // ignore: deprecated_member_use
//     if (await canLaunch(url)) {
//       // ignore: deprecated_member_use
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//   /*----------------------------- Calling button redirect class code end--------------------------*/
//
//   /*-------------Api Data start--------------------------*/
// //******************************************************
//   //Banner1 Api data start
// //*****************************************************
//   CategoryCatalog1Banner1? categoryCatalog1Banner1;
//   List<Banner1> banner1st=[];
//
//   fetchBanner1(userId, String city) async {
//     try {
//       //  isLoading = true;
//       final body = {
//         "user_id": userId,
//         "category": "Men",
//         "lat": "22.7177",
//         "long": "75.8545",
//         "city": city,
//       };
//       final response = await Dio().post(
//         "${ConstantUrls.baseUriApi}${ConstantUrls.categoryCatalog}",
//         options: Options(
//           headers: {
//             "Authorization": ConstantToken.authorizationToken,
//             'Content-Type': 'application/json',
//           },
//         ),
//         data: json.encode(body),
//       );
//       if (response.statusCode == 200) {
//         var responseData = json.decode(response.data.toString());
//         categoryCatalog1Banner1 = CategoryCatalog1Banner1.fromJson(responseData);
//         banner1st.addAll(categoryCatalog1Banner1!.banner1);
//         setState(() {
//           //  isLoading = false;
//         });}
//     } catch (error) {
//       print('API request error: $error');
//       throw Exception('Failed to fetch data');
//     }}
//
// //******************************************************
//   //Banner1 Api data end
//   //Banner2 Api data start
// //*****************************************************
//   CategoryCatalog1Banner2? categoryCatalog1Banner2;
//   List<Banner2> banner2nd=[];
//
//   fetchBanner2(userId, String city) async {
//     try {
//       //  isLoading = true;
//       final body = {
//         "user_id": userId,
//         "category": "Men",
//         "lat": "22.7177",
//         "long": "75.8545",
//         "city": city,
//       };
//       final response = await Dio().post(
//         "${ConstantUrls.baseUriApi}${ConstantUrls.categoryCatalog}",
//         options: Options(
//           headers: {
//             "Authorization": ConstantToken.authorizationToken,
//             'Content-Type': 'application/json',
//           },
//         ),
//         data: json.encode(body),
//       );
//       if (response.statusCode == 200) {
//         var responseData = json.decode(response.data.toString());
//         categoryCatalog1Banner2 = CategoryCatalog1Banner2.fromJson(responseData);
//         banner2nd.addAll(categoryCatalog1Banner2!.banner2);
//         setState(() {
//           //  isLoading = false;
//         });}
//     } catch (error) {
//       print('API request error: $error');
//       throw Exception('Failed to fetch data');
//     }}
//
// //******************************************************
//   //Banner2 Api data end
//   //SubCategory Api data start
// //*****************************************************
//
//   CategoryCatalog1SubCategory? categoryCatalog1SubCategory;
//   List<SubCategories> subCategories=[];
//
//   fetchSubCategories(userId, String city) async {
//     try {
//       //  isLoading = true;
//       final body = {
//         "user_id": userId,
//         "category": "Men",
//         "lat": "22.7177",
//         "long": "75.8545",
//         "city": city,
//       };
//       final response = await Dio().post(
//         "${ConstantUrls.baseUriApi}${ConstantUrls.categoryCatalog}",
//         options: Options(
//           headers: {
//             "Authorization": ConstantToken.authorizationToken,
//             'Content-Type': 'application/json',
//           },
//         ),
//         data: json.encode(body),
//       );
//       if (response.statusCode == 200) {
//         var responseData = json.decode(response.data.toString());
//         categoryCatalog1SubCategory =
//             CategoryCatalog1SubCategory.fromJson(responseData);
//         subCategories.addAll(categoryCatalog1SubCategory!.subCategories);
//          }
//         setState(() {
//         });
//     } catch (error) {
//       print('API request error: $error');
//       throw Exception('Failed to fetch data');
//     }}
//
// //******************************************************
//   //SubCategory Api data end
//   //Special Discount Zone Api data start
// //*****************************************************
//
//   CategoryCatalog1SpecialDiscount? categoryCatalog1SpecialDiscount;
//   List<SpecialDiscountZone> specialDiscountZone=[];
//
//   fetchSpecialDiscountZone(userId, String city) async {
//     try {
//       //  isLoading = true;
//       final body = {
//         "user_id": userId,
//         "category": "Men",
//         "lat": "22.7177",
//         "long": "75.8545",
//         "city": city,
//       };
//       final response = await Dio().post(
//         "${ConstantUrls.baseUriApi}${ConstantUrls.categoryCatalog}",
//         options: Options(
//           headers: {
//             "Authorization": ConstantToken.authorizationToken,
//             'Content-Type': 'application/json',
//           },
//         ),
//         data: json.encode(body),
//       );
//       if (response.statusCode == 200) {
//         var responseData = json.decode(response.data.toString());
//         categoryCatalog1SpecialDiscount =
//             CategoryCatalog1SpecialDiscount.fromJson(responseData);
//         specialDiscountZone.addAll(categoryCatalog1SpecialDiscount!.specialDiscountZone);
//         setState(() {
//           //  isLoading = false;
//         });}
//     } catch (error) {
//       print('API request error: $error');
//       throw Exception('Failed to fetch data');
//     }}
//
//
// //******************************************************
//   //Special Discount Zone Api data end
//   //Top Product store Api data start
// //*****************************************************
//
//   CategoryCatalog2TopStoreProducts? categoryCatalog2TopStoreProducts;
//   List<TopStoreProducts> topStoreProductss=[];
//
//   fetchTopStoreProducts(userId, String city) async {
//     try {
//       //  isLoading = true;
//       final body = {
//         "user_id": userId,
//         "category": "Men",
//         "lat": "22.7177",
//         "long": "75.8545",
//         "city": city,
//       };
//       final response = await Dio().post(
//         "${ConstantUrls.baseUriApi}${ConstantUrls.categoryCatalog2}",
//         options: Options(
//           headers: {
//             "Authorization": ConstantToken.authorizationToken,
//             'Content-Type': 'application/json',
//           },
//         ),
//         data: json.encode(body),
//       );
//       if (response.statusCode == 200) {
//         var responseData = json.decode(response.data.toString());
//         categoryCatalog2TopStoreProducts =
//             CategoryCatalog2TopStoreProducts.fromJson(responseData);
//         topStoreProductss.addAll(categoryCatalog2TopStoreProducts!.topStoreProducts);
//         setState(() {
//           //  isLoading = false;
//         });}
//     } catch (error) {
//       print('API request error: $error');
//       throw Exception('Failed to fetch data');
//     }}
//
//
// //******************************************************
//   //Top product store Api data end
//   //Top store Api data start
// //*****************************************************
//
//   CategoryCatalog2TopStores? categoryCatalog2TopStores;
//   List<YourCityFocusStore> topStoreCity=[];
//   bool isLoading = true;
//
//   fetchYourCityFocusStore(userId, String city) async {
//     try {
//       setState(() {
//         isLoading = true;
//       });
//       final body = {
//         "user_id": userId,
//         "category": "Men",
//         "lat": "22.7177",
//         "long": "75.8545",
//         "city": city,
//       };
//       final response = await Dio().post(
//         "${ConstantUrls.baseUriApi}${ConstantUrls.categoryCatalog2}",
//         options: Options(
//           headers: {
//             "Authorization": ConstantToken.authorizationToken,
//             'Content-Type': 'application/json',
//           },
//         ),
//         data: json.encode(body),
//       );
//       if (response.statusCode == 200) {
//         var responseData = json.decode(response.data.toString());
//         categoryCatalog2TopStores =
//             CategoryCatalog2TopStores.fromJson(responseData);
//         topStoreCity.addAll(categoryCatalog2TopStores!.yourCityFocusStore);
//         setState(() {
//           isLoading = false;
//         });}
//     } catch (error) {
//       print('API request error: $error');
//       setState(() {
//         isLoading = false;
//       });
//       throw Exception('Failed to fetch data');
//     }}
//
//
// //******************************************************
//   //Top store Api data end
// //*****************************************************
//
//
//
//   /*-------------Api Data end--------------------------*/
//
//
//   final PageController _pageController = PageController(initialPage: 0);
//   final PageController _pageController2 = PageController(initialPage: 0);
//   int _currentPage = 0;
//   int _currentPage2 = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchBanner1("8681", "Indore" );
//     fetchBanner2("8681", "Indore" );
//     fetchSubCategories("8681", "Indore" );
//     fetchSpecialDiscountZone("8681", "Indore" );
//     fetchTopStoreProducts("8681", "Indore" );
//     fetchYourCityFocusStore("8681", "Indore" );
//     _pageController.addListener(() {
//       setState(() {
//         _currentPage = _pageController.page! as int;
//         _currentPage2 = _pageController.page! as int;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width;
//     var screenHeight =  MediaQuery.of(context).size.height;
//     return Container(
//       color: ConstantColor.primaryMainColor,
//       child: SafeArea(
//         child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: ConstantColor.primaryMainColor,
//             elevation: 0.0,
//             title: Center(
//               child: Text(
//                 'Man',
//                 style: ConstantTextStyle.topCategoryText3,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//             titleSpacing: 0.0,
//             actions: [
//               Padding(
//                 padding: EdgeInsets.only(
//                     right: screenWidth / 10),
//                 child: Container(),
//               ),
//             ],
//           ),
//           extendBody: true,
//
// /*----------------------------------Body area---------------------------------------------*/
//           body: SingleChildScrollView(
//             child: Container(
//               color: ConstantColor.carColor,
//               child: Column(
//                 children: [
// /*--------------------------------Slider start -----------------------------------------*/
//
//                   carouselSlider(
//                     color: ConstantColor.primaryBackgroundMainColor,
//                     context: context,
//                     controller: _pageController,
//                     data: List.generate(banner1st.length, (index) {
//                       final bannerNo1 = banner1st[index];
//                       return Container(
//                         color: ConstantColor.transparent1,
//                         child: Image.network(bannerNo1.bannerImage?? "",
//                             errorBuilder: (context, error, stackTrace) {
//                               return const Icon(Icons.error, color: ConstantColor.primaryMainColor);},
//                             fit: BoxFit.fill),
//                       );
//                     }),
//                   ),
//
// /*--------------------------------Slider end -----------------------------------------*/
//
// /*--------------------------------Man,s start-----------------------------------------*/
//
//                   SizedBox(
//                     height: screenHeight / 50,
//                   ),
//
//                   Container(
//                     color: ConstantColor.bottonNavIcons,
//                     padding: EdgeInsets.only(
//                       top: 15,
//                       right: screenWidth/ 30,
//                       left: screenWidth/ 30,
//                     ),
//                     child: Column(
//                       children: [
// /*-------builder -----------------------------------------------------------*/
//                         GridView.builder(
//                           physics: const ScrollPhysics(),
//                           shrinkWrap: true,
//                     //   itemCount: 12,
//                           itemCount: subCategories.length,
//                           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 4,
//                             childAspectRatio: (2 / 3),
//                             crossAxisSpacing: 10.0,
//                             mainAxisSpacing: 10,
//                           ),
//                           itemBuilder: (BuildContext context, int index) {
//                            final topCategory = subCategories[index];
//                             return allHomeScreenAvatar(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(builder: (context) => const ProductListScreen()),
//                                 );
//                               },
//                               width: 80.0,
//                               height: double.minPositive,
//                               borderRadius: BorderRadius.circular(100),
//                               image: Image.network(
//                                 topCategory.img?? "",
//                                 fit: BoxFit.cover,
//                                 errorBuilder: (context, error, stackTrace) {
//                                   return const Icon(Icons.error,color: ConstantColor.primaryMainColor,);
//                                 },
//                               ),
//                          text: topCategory.name?? "",
//                               textAlign: TextAlign.center,
//                               color: ConstantColor.primaryMainColor,
//                               boxShadow: const [
//                                 BoxShadow(
//                                   color: ConstantColor.circleAvatar2,
//                                   spreadRadius: 1,
//                                   blurRadius: 1,
//                                   offset: Offset(-3, -3),
//                                 ),
//                               ],
//                             );
//                           },
//                         ),
// /*-------builder end-----------------------------------------------------------*/
//                         Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Container(
//                           child: customeButton(
//                             textStyleButton:
//                             ConstantTextStyle.seeMoreButtonStyle2,
//                             onPressed: () {},
//                             text: "See More",
//                             backgroundColor: ConstantColor.transparent1,
//                             borderRadius: BorderRadius.circular(0.0),
//                             elevation: 0.0,
//                           ),
//                         ),
//                       ],
//                     ),
//                       ],
//                     ),
//                   ),
// /*--------------------------------Man,s end-----------------------------------------*/
//
// /*---------------------------------Scrolling discount zone start --------------------------------------------*/
//
//                   SizedBox(
//                     height: screenHeight / 50,
//                   ),
//                   Column(
//                     children: [
//                       discountZone(
//                         bgcolor: ConstantColor.bottonNavIcons,
//                         context: context,
//                         widget: cardHeading(
//                           text: "DISCOUNT ZONE",
//                           style: ConstantTextStyle.topCategoryText,
//                           context: context,
//                         ),
//                         widget2: arrowButons(
//                           onTap: () {
//                             setState(() {
//                               discountZoneLeftIconBGColor= !discountZoneLeftIconBGColor;
//                             });
//                             Future.delayed(const Duration(milliseconds: 500), () {
//                               setState(() {
//                                 discountZoneLeftIconBGColor= !discountZoneLeftIconBGColor;
//                               });
//                             });
//                             scrollListLeftSide();
//                           },
//                           radius: 14.0,
//                           backgroundColor:discountZoneLeftIconBGColor?
//                           ConstantColor.primaryMainColor :
//                           ConstantColor.searchBoxColor ,
//                           icon: Icons.arrow_back_ios_new_rounded,
//                           color: discountZoneLeftIconBGColor?
//                           ConstantColor.searchBoxColor :
//                           ConstantColor.primaryMainColor,
//                         ),
//                         widget3: arrowButons(
//                           onTap: () {
//                             setState(() {
//                               discountZoneRightIconBGColor= !discountZoneRightIconBGColor;
//                             });
//                             Future.delayed(const Duration(milliseconds: 500), () {
//                               setState(() {
//                                 discountZoneRightIconBGColor= !discountZoneRightIconBGColor;
//                               });
//                             });
//                             scrollListRightSide();
//                           },
//                           radius: 14.0,
//                           backgroundColor: discountZoneRightIconBGColor?
//                           ConstantColor.primaryMainColor :
//                           ConstantColor.searchBoxColor,
//                           icon: Icons.arrow_forward_ios_rounded,
//                           color: discountZoneRightIconBGColor
//                               ?ConstantColor.searchBoxColor
//                           : ConstantColor.primaryMainColor,
//                         ),
//                         widget4: ListView.builder(
//                             controller: _scrollController,
//                             itemCount: specialDiscountZone.length,
//                             shrinkWrap: true,
//                             scrollDirection: Axis.horizontal,
//                             itemBuilder: (context, index) {
//                      final specialDiscountZones = specialDiscountZone[index];
//                               return Column(children: [
//                                 Stack(
//                                   children: [
//                        Container(
//                          margin: EdgeInsets.only(
//                          right: screenWidth / 50),
//                          width: screenWidth / 2.5,
//                          height: screenHeight / 8,
//                              decoration: BoxDecoration(
//                                border: Border.all(
//                                  color: ConstantColor.secondoryCardeBoarder,
//                                  width: 2,
//                                ),
//                           color: ConstantColor.secondoryWhiteColors,
//                      borderRadius: BorderRadius.circular(10.0),),
//                                       child: Image.network(
//                                specialDiscountZones.image?? "",
//                                         fit: BoxFit.fill,
//                                         errorBuilder: (context, error, stackTrace) {
//                                           return const Icon(Icons.error,color: ConstantColor.primaryMainColor,);
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ]);
//                             }),
//                       ),
//                     ],
//                   ),
//
// /*---------------------------------Scrolling discount zone end --------------------------------------------*/
//                   SizedBox(height: screenHeight / 50,),
// /*--------------------------------Top products start-----------------------------------------*/
//
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: screenWidth/30),
//                     color: ConstantColor.bottonNavIcons,
//                     child: ListTile(
//                       contentPadding: EdgeInsets.zero,
//                        leading:  customeText(
//                          textAlign: TextAlign.center,
//                          text: "Top Product".toUpperCase(),
//                          style: ConstantTextStyle.topCategoryText2,),
//                         trailing: customeButton(
//                           textStyleButton:
//                           ConstantTextStyle.seeMoreButtonStyle2,
//                           onPressed: () {},
//                           text: "See More",
//                           backgroundColor: ConstantColor.transparent1,
//                           borderRadius: BorderRadius.circular(0.0),
//                           elevation: 0.0,
//                         ),
//                     ),
//                   ),
//
// /*---------------------------------Ganesh collection Grid view start --------------------------------------------*/
//
//              Container(
//          padding: EdgeInsets.symmetric(horizontal: screenWidth/40, vertical: screenHeight / 80,  ),
//                     color: ConstantColor.primaryBackgroundMainColor,
//                     child: collectionCards(
//                       onTap: () {},
//                       context: context,
//                       itemCount: topStoreProductss.length,
//                       gridDelegate:
//                       const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         childAspectRatio: (1 /1.6),
//                       ),
//                       itemBuilder: (BuildContext context, index) {
//  //*****************************************************************************
//                         final topProducts = topStoreProductss[index];
//                         // discount Logic is here
//                         double getPercantageOff(double price, double offerPrice) {
//                           double result = ((price - offerPrice) / price) * 100;
//                           return result.floor().toDouble();
//                         }
//                         final offerPrice = double.parse(topProducts.offerPrice ?? '0');
//                         final price = double.parse(topProducts.price ?? '0');
//                         final percentageOff = getPercantageOff(price, offerPrice);
// //*****************************************************************************
//                         return collectionCardBody(
//                           cardchiptext:'$percentageOff% off',
//                           cardChipstyle:
//                           ConstantTextStyle.newiconButtonText,
//                           cardchiptextAlign: TextAlign.center,
//                           color: ConstantColor.chipColor,
//                           context: context,
//                           image: Padding(
//                             padding: EdgeInsets.symmetric( vertical: screenHeight/80,),
//                             child: ClipRRect(borderRadius: BorderRadius.circular(8.0),
//                               child: customNetworkImg(
//                                 ontap: (){},
//                            image: topProducts.productImage?? "",
//                                 height:screenHeight / 8,
//                                 width:screenWidth / 4.5,
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                           ),
//                          text1: topProducts.productTitle?? "",
//                           overflow1: TextOverflow.ellipsis,
//                           style1:
//                           ConstantTextStyle.allHomeScreenAvatarText,
//                           widget: secondryText(
//                             text2: topProducts.storeName?? "",
//                             overflow2: TextOverflow.ellipsis,
//                             style2: ConstantTextStyle.secondorGrayText,
//                           ),
//                           widget1: produtListRichText2(
//                             icon: Icons.currency_rupee_outlined,
//                             color: ConstantColor.primaryMainColor,
//                             context: context,
//                             text1: '${topProducts.offerPrice} ' ?? "N/A",
//                             style1: ConstantTextStyle.richtext1,
//                             text2: NumberFormat.simpleCurrency(
//                                 locale: "hi-NI", decimalDigits: 2)
//                                 .format(double.parse(topProducts.price ?? '0')),
//                             style2: ConstantTextStyle.richtext2,
//                             widget: produtListRichText3(
//                                 icon: Icons.content_paste_search,
//                                 color: ConstantColor.primaryBackgroundMainColor,
//                                 text1: "Send Enquiry",
//                                 style1:
//                                 ConstantTextStyle.newiconButtonText,
//                                 context: context,
//                                 recognizer: TapGestureRecognizer()
//                                   ..onTap = () {
//                                     showDialog(
//                                         context: context,
//                                         builder: (ctx) {
//                                           return alertDialogBox(
//                                             context:context,
//                                             titleText: "Enquiry Send Successfully",
//                                             titleTextAlign: TextAlign.center,
//                                             titleStyle: ConstantTextStyle.allHomeScreenAvatarText,
//                                             descriptionText: "आपकी Enquiry विक्रेता को शेयर कर दी गई है विक्रेता से बात करने के लिए कॉल करें 123 123 123.\n"
//                                                 "\nनोट:- सिटी बाज़ार ऑनलाइन द्वारा प्रोडक्ट की डिलीवरी प्रदान नही की जाती हैं"
//                                                 "यदि आप प्रोडक्ट डिलेवरी चाहिते हैं तो कृपया विक्रेता से संपर्क करे"
//                                                 "या स्टोर पर जाकर ही खरीदें ।",
//                                             descriptionTextStyle:ConstantTextStyle.secondorGrayText,
//                                             icon: Icons.message_sharp,
//                                             buttonText: "Chat with seller",
//                                             buttonStyle:ConstantTextStyle.newiconButtonText,
//                                             iconbuttononPress: () {
//                                               Navigator.of(ctx).pop();
//                                             },
//                                           );
//                                         }
//                                     );
//                                   }),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//
// /*---------------------------------Ganesh collection Grid view end --------------------------------------------*/
//
//
// /*--------------------------------Top products end-----------------------------------------*/
//                   SizedBox(height: screenHeight / 50,),
// /*--------------------------------Slider start -----------------------------------------*/
//                   carouselSlider(
//                     color: ConstantColor.primaryBackgroundMainColor,
//                     context: context,
//                     controller: _pageController2,
//                     data: List.generate(banner2nd.length, (index) {
//                       final bannerNo2 = banner2nd[index];
//                       return Container(
//                         color: ConstantColor.transparent1,
//                         child: Image.network(bannerNo2.bannerImage?? "",
//                             errorBuilder: (context, error, stackTrace) {
//                               return const Icon(Icons.error, color: ConstantColor.primaryMainColor);},
//                             fit: BoxFit.fill),
//                       );
//                     }),
//                   ),
//
// /*--------------------------------Slider end -----------------------------------------*/
//                   SizedBox(height: screenHeight / 50,),
// /*--------------------------------Top Store start -----------------------------------------*/
//
//                   Container(
//                     color: ConstantColor.primaryBackgroundMainColor,
//                     padding: EdgeInsets.only(
//                         left: screenWidth/40,
//                         right: screenWidth/40,
//                         bottom: screenHeight/30),
//                     child: Column(
//                       children: [
//                         ListTile(
//                           contentPadding: EdgeInsets.zero,
//                           leading:  customeText(
//                             textAlign: TextAlign.center,
//                             text: "Top Stores".toUpperCase(),
//                             style: ConstantTextStyle.topCategoryText2,),
//                           trailing: customeButton(
//                             textStyleButton:
//                             ConstantTextStyle.seeMoreButtonStyle2,
//                             onPressed: () {},
//                             text: "See More",
//                             backgroundColor: ConstantColor.transparent1,
//                             borderRadius: BorderRadius.circular(0.0),
//                             elevation: 0.0,
//                           ),
//                         ),
//                         collectionCards(
//                           context: context,
//                         itemCount: topStoreCity.length,
//                         //  itemCount: 10,
//                           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             crossAxisSpacing: 20,
//                             mainAxisSpacing: 20,
//                             childAspectRatio: (2 /2.5),
//                           ),
//                           itemBuilder: (BuildContext context, index) {
//                             final topStores = topStoreCity[index];
//                             return Container(
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                        color: ConstantColor.secondoryCardeBoarder,),
//                          borderRadius: BorderRadius.circular(10.0),
//                         color: ConstantColor.secondoryCardeColors,
//                               ),
//                               padding: EdgeInsets.only(
//                                 left: screenWidth/50,
//                                 right: screenWidth/50,
//                                 top: screenHeight/80,
//                               ),
//                               child:Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Stack(
//                                     children: [
//                                 ClipRRect(
//                                         borderRadius: BorderRadius.circular(8.0),
//                                         child:customNetworkImg(
//                                           ontap: (){
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) => const StoreDetailScreen()),
//                                             );
//                                           },
//                                    image: topStores.shopImage?? "",
//                                           height: screenHeight/8.5,
//                                           width: screenWidth/2.4,
//                                           fit: BoxFit.fill,),
//
//                                       ),
//  /*--------------------------------Cash back chip start -----------------------------------------*/
//                  if (topStores.cashbackText != null && topStores.cashbackText.isNotEmpty)
//                                       cashBackChip(
//                                         padding: EdgeInsets.symmetric(vertical: screenHeight/200),
//                                         color: ConstantColor.filedContainerColor,
//                                         context: context,
//                                         textAlign: TextAlign.start,
//                                      text: topStores.cashbackText,
//                                         style: ConstantTextStyle.chashBackchipText,),
//
// /*--------------------------------Cash back chip end -----------------------------------------*/
//                if (topStores.cashbackText != null && topStores.cashbackText.isNotEmpty)
//                  ShineEffect(
//                    padding: EdgeInsets.only(top: screenHeight / 80,),
//                    height: screenHeight / 50,
//                    width: screenWidth / 4.2,
//                  ),
//                                     ],
//                                   ),
//                    ListTile(
//                      contentPadding: EdgeInsets.zero,
//                      dense: true,
//                      leading: SizedBox(
//                        width: screenWidth/3,
//                        child: iconRichText(
//                          text1: topStores.name?? "",
//                          style1:ConstantTextStyle.cardbottumText,
//                        ),
//                      ),
// /*--------------------------------calling iconButton start -----------------------------------------*/
//                   trailing: GestureDetector(
//                     onTap: (){
//                       String phoneNumber = topStoreCity[index].contactNo ?? "";
//                       if (phoneNumber.isNotEmpty) {
//                         _launchPhoneCall(phoneNumber);
//                       } else {
//                         print("Phone number not available.");
//                       }
//                       },
//                     child: const CircleAvatar(
//                       radius: 15.0,
//                       backgroundColor: ConstantColor.primaryMainColor,
//                       child: Icon(Icons.call_outlined,
//                           size: 20.0, color: ConstantColor.primaryBackgroundMainColor),
//                     ),
//                   ),
// /*--------------------------------calling iconButton end -----------------------------------------*/
//                    ),
//                                   iconRichText(icon: Icons.location_on_outlined,
//                                     color: ConstantColor.filedContainerColor,
//                                     size: 14.0,
//                                     text2: topStores.storeAddress?? "",
//                                     style2: ConstantTextStyle.secondryLocationText,),
//                                   SizedBox( height: screenHeight/50,),
//                                   startRating(
//                                     width: screenWidth/4.5,
//                                     height: screenHeight/40,
//                                     context: context,
//                                     color: ConstantColor.secondoryBlackColors,
//                               text2:double.parse(topStores.rating?? "").toStringAsFixed(2),
//                                     style2: ConstantTextStyle.ratingText,
//                                     initialRating: 3.0,
//                                     itemSize: 10.0,
//                                     minRating: 1.0,
//                                     allowHalfRating: true,
//                                     itemCount: 5,
//                                     onRatingUpdate: (rating) {},
//                                     itemBuilder: (context, _) => const Icon(
//                                       Icons.star, color: ConstantColor.starRatingColor,),
//                                   ),
//                                 ],
//                               ),
//                             );},),
//                       ],
//                     ),
//                   ),
//
// /*--------------------------------Top Store end -----------------------------------------*/
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//
//
//   }
//
// }
