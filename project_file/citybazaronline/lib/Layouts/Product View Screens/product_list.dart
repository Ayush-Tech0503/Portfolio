// import 'package:Citybazar_app/Layouts/Product%20View%20Screens/product_Item_Details.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../../Util/constaint_textstyle.dart';
// import '../../Util/constant_color.dart';
// import '../../Util/constant_image.dart';
// import '../../Widgets/Send Enquiry dialogBox/alert_dialog_box.dart';
// import '../../Widgets/collection_card.dart';
// import '../../Widgets/custome_imagies.dart';
// import '../../Widgets/custome_richtext.dart';
// import '../../Widgets/custome_text.dart';
// import '../../Widgets/store_details_widget.dart';
// class ProductListScreen extends StatefulWidget {
//  // required this.id,required this.longitude,required this.latitude,required this.lName
//   String id;
//   String longitude;
//   String latitude;
//   String lName;
//    ProductListScreen({Key? key,required this.id,required this.longitude,required this.latitude,required this.lName}) : super(key: key);
//
//   @override
//   State<ProductListScreen> createState() => _ProductListScreenState();
// }
//
// class _ProductListScreenState extends State<ProductListScreen> {
//   final GlobalKey<ScaffoldState> scaffoldKey2 = GlobalKey<ScaffoldState>();
//   ScrollController filterScrollController = ScrollController();
//   RangeValues _currentRangeValues = const RangeValues(0, 100);
//   static String _valueToString(double value) {
//     return value.toStringAsFixed(0);
//   }
//   bool isListIcon = false;
//
//   final List<String> itemsData = [
//     'Item1',
//     'Item2',
//     'Item3',
//     'Item4',
//     'Item5',
//     'Item6',
//     'Item7',
//     'Item8',
//   ];
//   String? selectedValue;
//
// /*----------------------------Api data Here start----------------*/
//   // AllProducts? allProductData;
//   // List<ProductList> allProductList=[];
//   // bool isLoading = false;///////
//   // fetchAdsBannerMiddle({userId, String? city, lat, long}) async {
//   //   try {
//   //       isLoading = true;
//   //     final body = {
//   //         "user_id": "4577",
//   //         "sub_category_id": "",
//   //         "sub_category_keyword": "",
//   //         "keyword": "T-Shirt",
//   //         "pcatid": "",
//   //         "interested_in": "buy",
//   //         "distance": 10,
//   //         "lat": "22.7177",
//   //         "long": "75.8545",
//   //         "order_by": "Default",
//   //         "page_no": 1,
//   //         "filter_item": {
//   //           "Color": [],
//   //           "Fabric": [],
//   //           "Sleeve Type": [],
//   //           "Neck Type": [],
//   //           "Size": [],
//   //           "Suitable for": [],
//   //           "brands": []
//   //         },
//   //         "category": "",
//   //         "min_price": 100,
//   //         "max_price": 999
//   //     };
//   //     final response = await Dio().post(
//   //       "${ConstantUrls.baseUriApi}${ConstantUrls.allProductsEndPoint}",
//   //       options: Options(
//   //         headers: {
//   //           "Authorization": ConstantToken.authorizationToken,
//   //           'Content-Type': 'application/json',
//   //         },
//   //       ),
//   //       data: json.encode(body),
//   //     );
//   //     if (response.statusCode == 200) {
//   //       var responseData = json.decode(response.data.toString());
//   //       allProductData = AllProducts.fromJson(responseData);
//   //       allProductList.addAll(allProductData!.productList);
//   //       setState(() {
//   //           isLoading = false;
//   //       });
//   //     }
//   //   } catch (error) {////
//   //     throw Exception('Failed to fetch data');
//   //   }}
// /*----------------------------Api data Here End-------------------*/
//   @override
//   Widget build(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width;
//     var screenHeight = MediaQuery.of(context).size.height;
//     return Container(
//       color: ConstantColor.loginWithOtpButtonColor,
//       child: SafeArea(
//         child: Scaffold(
//           appBar: AppBar(
//             // toolbarHeight: screenHeight / 10,
//             backgroundColor: ConstantColor.bottonNavIcons,
//             elevation: 0.0,
//             iconTheme: const IconThemeData(
//              color: ConstantColor.loginWithOtpButtonColor
//             ),
// /*-----------------------------------------------------------------------*/
//         title:  Text('All Products',
//           style: ConstantTextStyle.topCategoryText2,
//           overflow: TextOverflow.ellipsis,
//         ),
// /*--------------------------------------------------------------*/
//             titleSpacing: 0.0,
//           ),
//           backgroundColor: ConstantColor.primaryBackgroundMainColor,
//           body: Scaffold(
// /*---------------------Filter Drawer Start------------------------------*/
//             key: scaffoldKey2,
//             drawer: Drawer(
//                 backgroundColor:ConstantColor.primaryBackgroundMainColor,
//                 child:DrawerHeader(
//                   padding: EdgeInsets.zero,
//                   child: SingleChildScrollView(
//                     controller: filterScrollController,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ListTile(
//                           horizontalTitleGap: screenWidth/2.5,
//                           // minLeadingWidth: screenWidth/2.1,
//                           dense: true,
//                           leading: customeText(
//                             text: "Filter",
//                             overflow: TextOverflow.ellipsis,
//                             style: ConstantTextStyle.cardbottumText,
//                           ),
//                           title: GestureDetector(
//                             onTap: () {},
//                             child: customeText(
//                               text: "Clear All",
//                               textAlign: TextAlign.start,
//                               style: ConstantTextStyle.seeMoreButtonStyle,
//                             ),
//                           ),
//                         ),
//                         const Divider(
//                           color: ConstantColor.primaryGreyColor,
//                           thickness: 1.0,
//                           height: 0.0,
//                         ),
//                         ScrollbarTheme(
//                           data: ScrollbarThemeData(
//                             thumbColor: MaterialStateProperty.all<Color>(ConstantColor.filedContainerColor),
//                             trackColor: MaterialStateProperty.all<Color>(ConstantColor.carColor),
//                           ),
//                           child: Scrollbar(
//                             trackVisibility: true,
//                             thumbVisibility: true,
//                             controller: filterScrollController,
//                             thickness: 5.0,
//                             radius: const Radius.circular(10.0),
//                             child: Column(
//                               children: [
//                                 ExpansionTile(
//                                   iconColor: ConstantColor.primaryMainColor,
//                                   title: customeText(
//                                     text: "Price",
//                                     style: ConstantTextStyle.allHomeScreenAvatarText,
//                                   ),
//                                   children: [
//                                     ListTile(
//                                       visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
//                                       dense: true,
//                                       leading: Container(
//                                         padding:EdgeInsets.symmetric(horizontal: screenHeight/80, vertical: screenHeight/80),
//                                         color: ConstantColor.calendarBGHeadColor,
//                                         child: customeText(text: _currentRangeValues.start.round().toString(),
//                                             textAlign: TextAlign.center,
//                                             style: ConstantTextStyle.becomeSellerDiscText),
//                                       ),
//                                       title: customeText(
//                                         textAlign: TextAlign.center,
//                                         text: "TO",
//                                         style: ConstantTextStyle.allHomeScreenAvatarText,
//                                       ),
//                                       trailing:  Container(
//                                         padding:EdgeInsets.symmetric(horizontal: screenHeight/80, vertical: screenHeight/80),
//                                         color: ConstantColor.calendarBGHeadColor,
//                                         child: customeText(text: _currentRangeValues.end.round().toString(),
//                                             textAlign: TextAlign.center,
//                                             style: ConstantTextStyle.becomeSellerDiscText),
//                                       ),
//                                     ),
//                                     RangeSlider(
//                                       activeColor: ConstantColor.primaryMainColor,
//                                       values: _currentRangeValues,
//                                       min: 0,
//                                       max: 10000,
//                                       divisions: 10,
//                                       labels: RangeLabels(
//                                         _currentRangeValues.start.round().toString(),
//                                         _currentRangeValues.end.round().toString(),
//                                       ),
//                                       onChanged: (RangeValues values) {
//                                         setState(() {
//                                           _currentRangeValues = values;
//                                         });
//                                       },
//                                     )
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: screenHeight/1.5,
//                                   child: ListView.builder(
//                                     physics: const AlwaysScrollableScrollPhysics(),
//                                     itemCount: 5,
//                                     itemBuilder: (BuildContext context, int index) {
//                                       return ExpansionTile(
//                                         iconColor: ConstantColor.primaryMainColor,
//                                         title: customeText(
//                                           text: "Category",
//                                           style: ConstantTextStyle.allHomeScreenAvatarText,
//                                         ),
//                                         children: [
//                                           ListView.builder(
//                                             physics: const NeverScrollableScrollPhysics(),
//                                             shrinkWrap: true,
//                                             itemCount: 5, // Replace with your actual item count
//                                             itemBuilder: (BuildContext context, int index) {
//                                               bool checkedValue = false; // Initialize the checkbox value
//                                               return CheckboxListTile(
//                                                 title: Text("Option ${index + 1}"), // Replace with your text
//                                                 value: checkedValue,
//                                                 onChanged: (newValue) {
//                                                   setState(() {
//                                                     checkedValue = newValue ?? false;
//                                                   });
//                                                 },
//                                                 controlAffinity: ListTileControlAffinity.leading,
//                                               );
//                                             },
//                                           ),
//                                           // You can add more content here
//                                         ],
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ],),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//             ),
// /*---------------------Filter Drawer end------------------------------*/
//             appBar: AppBar(
//               titleSpacing: 0,
//               automaticallyImplyLeading: false,
//               backgroundColor: ConstantColor.primaryBackgroundMainColor,
//               centerTitle: true,
//               title:  IntrinsicHeight(
//                 child: Row(
//                   children: [
//                     iconAndText(
//                       onPressed: (){ scaffoldKey2.currentState!.openDrawer();},
//                       icons: Icons.filter_alt_outlined,
//                       iconsSize: 20.0,
//                       iconsColor: ConstantColor.loginWithOtpButtonColor,
//                       iconText: "Filter",
//                       iconTextStyle: ConstantTextStyle.allHomeScreenAvatarText,),
//                     const VerticalDivider(
//                       color: ConstantColor.GrayLineColor,
//                       thickness: 1,
//                     ),
//                     Flexible(
//                       child: ListTile(
//                         onTap: () {},
//                         minVerticalPadding: 0,
//                         minLeadingWidth: 0,
//                         contentPadding: EdgeInsets.zero,
//                         dense: true,
//                         visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
//                         leading:  iconAndText(
//                           onPressed: (){},
//                           icons: Icons.sort,
//                           iconsSize: 20.0,
//                           iconsColor: ConstantColor.loginWithOtpButtonColor,
//                           iconText: "Sort By",
//                           iconTextStyle: ConstantTextStyle.allHomeScreenAvatarText,),
//                         title:DropdownButtonHideUnderline(
//                           child: DropdownButton2(
//                             isExpanded: true,
//                             hint: customeText(
//                               text: "Popularity",
//                               overflow: TextOverflow.ellipsis,
//                               style: ConstantTextStyle.becomeSellerDiscText,),
//                             items: itemsData
//                                 .map((String itemsData) => DropdownMenuItem<String>(
//                               value: itemsData,
//                               child: Text(
//                                 textAlign: TextAlign.start,
//                                 itemsData, style:  ConstantTextStyle.becomeSellerDiscText,
//                                 overflow: TextOverflow.ellipsis,),
//                             )).toList(),
//                             value: selectedValue,
//                             onChanged: (String? value) {
//                               setState(() {
//                                 selectedValue = value;
//                               });
//                             },
//                             buttonStyleData: ButtonStyleData(
//                               height: screenHeight/30,
//                               width: screenWidth/4,
//                               padding:  EdgeInsets.symmetric( horizontal: screenWidth/40),
//                               decoration:  BoxDecoration(
//                                   border: Border.all(color: ConstantColor.primaryGreyColor),
//                                   borderRadius: BorderRadius.circular(5.0),
//                                   color:ConstantColor.primaryBackgroundMainColor
//                               ),
//                               // elevation: 1,
//                             ),
//                             iconStyleData: const IconStyleData(
//                                 icon: Icon(Icons.expand_circle_down,size: 20.0,
//                                   color: ConstantColor.loginWithOtpButtonColor,)
//                               // icon: Visibility (visible:false, child: Icon(Icons.arrow_downward)),
//                             ),
//                             dropdownStyleData: DropdownStyleData(
//                               maxHeight: 200,
//                               width: 200,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10.0),
//                                 color: ConstantColor.primaryBackgroundMainColor,
//                               ),
//                               offset: const Offset(-20, 0),
//                               scrollbarTheme: ScrollbarThemeData(
//                                 radius: const Radius.circular(40),
//                                 thumbColor: MaterialStateProperty.all(ConstantColor.primaryMainColor),
//                                 thickness: MaterialStateProperty.all(5),
//                                 thumbVisibility: MaterialStateProperty.all(true),
//                               ),
//                             ),
//                             menuItemStyleData:  MenuItemStyleData(
//                               height: screenHeight/25,
//                               padding: EdgeInsets.symmetric(horizontal: screenWidth/40),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const VerticalDivider(
//                       color: ConstantColor.GrayLineColor,
//                       thickness: 1,
//                     ),
//                     IconButton(
//                       padding:EdgeInsets.zero,
//                       visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
//                       icon:  isListIcon ? const Icon(Icons.list, color: ConstantColor.loginWithOtpButtonColor,)
//                           : const Icon(Icons.border_all, color: ConstantColor.loginWithOtpButtonColor,),
//                       onPressed: () {
//                         setState(() {
//                           isListIcon = !isListIcon;
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             body: isListIcon
//                 ? _buildListView() // Show the ListView
//                 : _buildGridView(),
//           ),
//         ),
//       ),
//     );
// /*-----------------------------------Product cards end------------------------------------*/
//   }
// /*---------------------this is grid view builder widget start--------*/
//   Widget _buildGridView() {
//     var screenWidth = MediaQuery.of(context).size.width;
//     var screenHeight = MediaQuery.of(context).size.height;
//     return     Container(
//       padding: EdgeInsets.symmetric(vertical: screenHeight/80,horizontal: screenWidth/50),
//       decoration: BoxDecoration(
//         color: ConstantColor.secondryBackgroundMainColor,
//         borderRadius: BorderRadius.circular(5.0),),
//       child: collectionCards(
//         onTap: () {},
//         context: context,
//         itemCount: 30,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 5,
//           mainAxisSpacing: 5,
//           childAspectRatio: 1/1.25,
//         ),
//         itemBuilder: (BuildContext context, index) {
//           return Card(
//             elevation: 1,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                   horizontal: screenWidth/50),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   cashBackChip(
//                     context: context,
//                     borderRadius: BorderRadius.circular(5.0),
//                     text: "7% OFF",
//                     style: ConstantTextStyle.newiconButtonText,
//                     textAlign: TextAlign.start,
//                     color: ConstantColor.chipColor,),
//                   Center(
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context) =>  ProductDetailScreen(id: widget.id, longitude: widget.longitude,lName: widget.lName,latitude: widget.latitude,)));
//                       },
//                       child: Container(
//                         width: screenWidth / 2.7,
//                         height: screenHeight / 8,
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                             image: AssetImage(ConstantImage.footware),
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: screenHeight/100,),
//                   customeText(
//                     text: "Product Name Here",
//                     overflow: TextOverflow.ellipsis,
//                     style: ConstantTextStyle.cardbottumText,),
//                   SizedBox(height: screenHeight/200,),
//                   Flexible(
//                     child: customRichText(
//                       text1: NumberFormat.simpleCurrency(
//                           locale: "hi-NI", decimalDigits: 2)
//                           .format(double.parse( "300",)) ,
//                       style1: ConstantTextStyle.richtext1,
//                       TextAlign: TextAlign.start,
//                       text2: NumberFormat.simpleCurrency(
//                           locale: "hi-NI", decimalDigits: 2)
//                           .format(double.parse("200")) ,
//                       style2: ConstantTextStyle.richtext2, ),
//                   ),
//                   SizedBox(height: screenHeight/200,),
//                   Flexible(
//                     child: ElevatedButton.icon(
//                       onPressed: () {
//                         showDialog(
//                           context: context,
//                           builder: (ctx) {
//                             return alertDialogBox(
//                               context: context,
//                               titleText: "Enquiry Send Successfully",
//                               titleTextAlign: TextAlign.center,
//                               titleStyle: ConstantTextStyle.allHomeScreenAvatarText,
//                               descriptionText:
//                               "आपकी Enquiry विक्रेता को शेयर कर दी गई है विक्रेता से बात करने के लिए कॉल करें 123 1231 23.\n"
//                                   "\nनोट:- सिटी बाज़ार ऑनलाइन द्वारा प्रोडक्ट की डिलीवरी प्रदान नही की जाती हैं"
//                                   "यदि आप प्रोडक्ट डिलेवरी चाहिते हैं तो कृपया विक्रेता से संपर्क करे"
//                                   "या स्टोर पर जाकर ही खरीदें ।",
//                               descriptionTextStyle: ConstantTextStyle.secondorGrayText,
//                               icon: Icons.message_sharp,
//                               buttonText: "Chat with seller",
//                               buttonStyle: ConstantTextStyle.newiconButtonText,
//                               iconbuttononPress: () {
//                                 Navigator.of(ctx).pop();
//                               },
//                             );
//                           },
//                         );
//                       },
//                       icon: const Icon(
//                         Icons.content_paste_search,
//                         size: 20.0,
//                       ),
//                       label: Text('Send Enquiry',
//                         style: ConstantTextStyle.newiconButtonText,),
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: Size.fromHeight(screenHeight/25),
//                         backgroundColor: ConstantColor.primaryMainColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15.0),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// /*---------------------this is grid view builder widget end --------*/
// /*---------------------this is List view builder widget start --------*/
//   Widget _buildListView() {
//     var screenWidth = MediaQuery.of(context).size.width;
//     var screenHeight = MediaQuery.of(context).size.height;
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: screenWidth/60,),
//       color: ConstantColor.secondryBackgroundMainColor,
//       height: screenHeight,
//       child: ListView.builder(
//         shrinkWrap: true,
//         physics: const AlwaysScrollableScrollPhysics(),
//         scrollDirection: Axis.vertical,
//         itemCount: 10,
//         itemBuilder: (BuildContext context, int index) {
//           return Container(
//             padding: EdgeInsets.symmetric(horizontal: screenWidth/40),
//             margin: EdgeInsets.only(bottom: screenHeight/100),
//             color: ConstantColor.primaryBackgroundMainColor,
//             child: ListTile (
//               minVerticalPadding: screenHeight/100,
//               visualDensity: const VisualDensity(vertical: 4),
//               contentPadding: EdgeInsets.zero,
//               dense: true,
//               leading:
//               customImg(
//                   ontap: (){Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) =>
//                          ProductDetailScreen(id: widget.id, longitude: widget.longitude, latitude: widget.latitude, lName: widget.lName,)),
//                   );},
//                   image: ConstantImage.mobile2,
//                   height: screenHeight/8,
//                   width: screenWidth/5,
//                   fit: BoxFit.fill
//               ),
//               title: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   customRichText(
//                     text1: "Product Name",
//                     TextAlign: TextAlign.start,
//                     //overflow1: TextOverflow.ellipsis,
//                     style1: ConstantTextStyle.allHomeScreenAvatarText,
//                   ),
//                   SizedBox(height: screenHeight/300,),
//                   customRichText(
//                     text1: NumberFormat.simpleCurrency(
//                         locale: "hi-NI", decimalDigits: 2)
//                         .format(double.parse( "300",)) ,
//                     style1: ConstantTextStyle.richtext1,
//                     TextAlign: TextAlign.start,
//                     text2: NumberFormat.simpleCurrency(
//                         locale: "hi-NI", decimalDigits: 2)
//                         .format(double.parse("200")) ,
//                     style2: ConstantTextStyle.richtext2, ),
//                   SizedBox(height: screenHeight/300,),
//                   ElevatedButton.icon(
//                     onPressed: (){
//                       showDialog(
//                         context: context,
//                         builder: (ctx) {
//                           return alertDialogBox(
//                             context: context,
//                             titleText: "Enquiry Send Successfully",
//                             titleTextAlign: TextAlign.center,
//                             titleStyle: ConstantTextStyle.allHomeScreenAvatarText,
//                             descriptionText:
//                             "आपकी Enquiry विक्रेता को शेयर कर दी गई है विक्रेता से बात करने के लिए कॉल करें 123 1231 23.\n"
//                                 "\nनोट:- सिटी बाज़ार ऑनलाइन द्वारा प्रोडक्ट की डिलीवरी प्रदान नही की जाती हैं"
//                                 "यदि आप प्रोडक्ट डिलेवरी चाहिते हैं तो कृपया विक्रेता से संपर्क करे"
//                                 "या स्टोर पर जाकर ही खरीदें ।",
//                             descriptionTextStyle: ConstantTextStyle.secondorGrayText,
//                             icon: Icons.message_sharp,
//                             buttonText: "Chat with seller",
//                             buttonStyle: ConstantTextStyle.newiconButtonText,
//                             iconbuttononPress: () {
//                               Navigator.of(ctx).pop();
//                             },
//                           );
//                         },
//                       );
//                     },
//                     icon: const Icon(
//                       Icons.content_paste_search,
//                       size: 17.0,
//                     ),
//                     label: Text('Send Enquiry',
//                       style: ConstantTextStyle.newiconButtonText,),
//                     style: ElevatedButton.styleFrom(
//                       // padding: EdgeInsets.symmetric(horizontal:screenWidth/10),
//                       backgroundColor: ConstantColor.primaryMainColor,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               trailing: Icon(Icons.store_outlined,size: screenHeight/35,
//               color: ConstantColor.loginWithOtpButtonColor,),
//             ),
//           );
//         },
//       ),
//     );
//   }
// /*---------------------this is List view builder widget end --------*/
// }
