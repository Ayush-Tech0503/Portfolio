// import 'package:flutter/material.dart';
// import '../../Util/constaint_textstyle.dart';
// import '../../Util/constant_color.dart';
// import '../custome_text.dart';
// import '../famous_market_card_widget.dart';
//
// Widget sellerReviewProductDetails ({context, }){
//   var screenHeight = MediaQuery.of(context).size.height;
//   var screenWidth = MediaQuery.of(context).size.height;
//   return     SizedBox(
//     width: screenWidth/3,
//     child: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         customeText(
//           text: "G KALPANA GOWN HOUSE".toUpperCase(),
//           textAlign: TextAlign.start,
//           overflow: TextOverflow.ellipsis,
//           style: ConstantTextStyle.ratingText2,
//         ) ,
//         Row(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(5.0),
//                 color: ConstantColor.primaryMainColor,
//               ),
//               child:  Padding(
//                 padding:  EdgeInsets.symmetric(vertical: screenHeight/300,horizontal: screenWidth/80),
//                 child: customeText(
//                   text: (5).toStringAsFixed(2),
//                   textAlign: TextAlign.start,
//                   style:ConstantTextStyle.loginButtonTextStyle,
//                 ),
//               ) ,
//             ),
//             Padding(
//               padding: EdgeInsets.only(top: screenHeight/100, left: screenWidth/80),
//               child: ratingsStar(
//                 width: screenWidth /5,
//                 height: screenHeight / 30,
//                 bgColor: ConstantColor.transparent1,
//                 initialRating: 3.5,
//                 itemSize: 16.0,
//                 minRating: 1.0,
//                 allowHalfRating: true,
//                 itemCount: 5,
//                 onRatingUpdate: (rating) {},
//                 itemBuilder: (context, _) => const Icon(
//                   Icons.star,
//                   color: ConstantColor.starRatingColor,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         iconRichText2(
//           context: context,
//           icon: Icons.location_on_outlined,
//           color: ConstantColor.filedContainerColor,
//           size: 14.0,
//           text: "149, Ada Bazar, Indore M.P.",
//           style: ConstantTextStyle.secondryLocationText,),
//         SizedBox(height: screenHeight/100,),
//
//         Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.".toUpperCase(),
//             textAlign: TextAlign.start,
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//             style: ConstantTextStyle.subtitleGreyText,),
//       ],
//     ),
//   );
// }
//
//
