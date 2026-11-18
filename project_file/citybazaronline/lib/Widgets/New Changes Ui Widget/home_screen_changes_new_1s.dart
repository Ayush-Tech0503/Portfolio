// import 'package:flutter/material.dart';
// import '../collection_card.dart';
// import '../custome_text.dart';
//
// Widget listViewProductCards (context,backgroundColor,headText,headTextStyle, returnData,
//     leftIconData, rightIconData,child){
//   var screenHeight = MediaQuery.of(context).size.height;
//   var screenWidth = MediaQuery.of(context).size.height;
//   return   Container(
//     padding: EdgeInsets.symmetric(vertical: screenHeight/50, horizontal: screenWidth/40),
//     color: backgroundColor,
//    // ConstantColor.primaryBackgroundMainColor,
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         customeText(
//           text: headText,
//          // "top mobile & electronics".toUpperCase(),
//           style: headTextStyle,
//         //  ConstantTextStyle.topCategoryText,),
//     //    SizedBox(height: screenHeight/80,),
//         Stack(
//           children: [
//             SizedBox(height: screenHeight/3.5,
//               child: child,
//             ),
//             Positioned(
//               left: screenWidth/40, top: 0, bottom: 0,
//               child: leftIconData,),
//             Positioned(
//               right: screenWidth/40, top: 0, bottom: 0,
//               child:
//               rightIconData
//             ),
//           ],
//         ),
//         ),
//       ],
//     ),
//   );
// }
// //////////////////////////////
//
// Widget listCardInSideData ({context,chipText,chipTextStyle, chipColor,cardPadding,
//   imageWidth, imageHeight, fit,imageData,  titleOverFlow, titleText, titleTextStyle,}){
//   return Card(
//     elevation: 4,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(10.0),
//     ),
//     child: Padding(
//
//       padding: cardPadding,
//       //EdgeInsets.symmetric(horizontal: screenWidth/30),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           cashBackChip(
//             context: context,
//             borderRadius: BorderRadius.circular(5.0),
//             text: chipText,
//            // percentageOff> 0 ? '$percentageOff% off' : "",
//             style: chipTextStyle,
//           //  ConstantTextStyle.newiconButtonText,
//             textAlign: TextAlign.start,
//             color: chipColor,
//           //  percentageOff> 0 ? ConstantColor.chipColor : null,
//           ),
//           Center(
//             child: Container(
//               width: imageWidth,
//               height:imageHeight,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: imageData,
//                //   NetworkImage(TopMobileSandElectronics.productImage?? "",),
//                   fit: fit,
//                 //  BoxFit.fill,
//                 ),
//               ),
//             ),
//           ),
//           customeText(
//              titleText,
//           //  TopMobileSandElectronics.productTitle ?? '',
//             overflow: titleOverFlow,
//            // TextOverflow.ellipsis,
//             style: titleTextStyle,
//             //ConstantTextStyle.allHomeScreenAvatarText,),
//           // Flexible(
//           //   child: RichText(
//           //     text: TextSpan(
//           //       children: [
//           //         TextSpan(
//           //           text:
//           //           NumberFormat.simpleCurrency(
//           //               locale: "hi-NI", decimalDigits: 2)
//           //               .format(double.parse(
//           //             TopMobileSandElectronics.offerPrice ?? TopMobileSandElectronics.price ?? "N/A",)) ,
//           //           style: ConstantTextStyle.richtext1,),
//           //         TextSpan(
//           //           text: percentageOff> 0 ? NumberFormat.simpleCurrency(
//           //               locale: "hi-NI", decimalDigits: 2)
//           //               .format(double.parse(
//           //               TopMobileSandElectronics.price ?? ''
//           //           )) : " ",
//           //           style: ConstantTextStyle.richtext2,
//           //
//           //         ),
//           //       ],
//           //     ),
//           //   ),
//           // ),
//           // Center(
//           //   child: ElevatedButton.icon(
//           //     onPressed: () {
//           //       showDialog(
//           //         context: context,
//           //         builder: (ctx) {
//           //           return alertDialogBox(
//           //             context: context,
//           //             titleText: "Enquiry Send Successfully",
//           //             titleTextAlign: TextAlign.center,
//           //             titleStyle: ConstantTextStyle.allHomeScreenAvatarText,
//           //             descriptionText:
//           //             "आपकी Enquiry विक्रेता को शेयर कर दी गई है विक्रेता से बात करने के लिए कॉल करें 9907138155.\n"
//           //                 "\nनोट:- सिटी बाज़ार ऑनलाइन द्वारा प्रोडक्ट की डिलीवरी प्रदान नही की जाती हैं"
//           //                 "यदि आप प्रोडक्ट डिलेवरी चाहिते हैं तो कृपया विक्रेता से संपर्क करे"
//           //                 "या स्टोर पर जाकर ही खरीदें ।",
//           //             descriptionTextStyle: ConstantTextStyle.secondorGrayText,
//           //             icon: Icons.message_sharp,
//           //             buttonText: "Chat with seller",
//           //             buttonStyle: ConstantTextStyle.newiconButtonText,
//           //             iconbuttononPress: () {
//           //               Navigator.of(ctx).pop();
//           //             },
//           //           );
//           //         },
//           //       );
//           //     },
//           //     icon: const Icon(
//           //       Icons.content_paste_search,
//           //       size: 20.0,
//           //     ),
//           //     label: Text('Send Enquiry',
//           //       style: ConstantTextStyle.newiconButtonText,),
//           //     style: ElevatedButton.styleFrom(
//           //       padding: EdgeInsets.all(screenWidth/80),
//           //       primary: ConstantColor.primaryMainColor,
//           //       shape: RoundedRectangleBorder(
//           //         borderRadius: BorderRadius.circular(5.0),
//           //       ),
//           //     ),
//           //   ),
//            ),
//         ],
//       ),
//     ),
//   );
// }