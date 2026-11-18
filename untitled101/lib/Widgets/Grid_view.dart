// import 'package:flutter/material.dart';
//
// import 'custome_text.dart';
//
// Widget myWidgetGrid() {
//  return GridView.builder(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//         ),
//         itemCount: 300,
//         itemBuilder: (BuildContext context, int index) {
//           return Card(
//             color: Colors.amber,
//             child: Center(child: Text('$index')),
//           );
//         }
//     );
// }
// /*----I used this widget : My subscription plans -> my active plan Details(Button)------
// ---this is section 1nd (subscription name end )-------------------------------*/
// Widget planDetailInvisible ({visible, context, backgroundColor,listTileBGColor,headTextBGColor,titleHeadText,
//   subtitleText, builderWidget }) {
//   var screenWidth = MediaQuery.of(context).size.width;
//   var screenHeight = MediaQuery.of(context).size.height;
//   return Visibility(
//     visible: visible,
//     child: Padding(
//       padding: EdgeInsets.symmetric( vertical: screenHeight / 30,),
//       child: Container(
//         padding: EdgeInsets.symmetric(
//           vertical: screenHeight / 50,
//           horizontal: screenWidth / 30,
//         ),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10.0),
//           color: backgroundColor,
//         ),
//         child: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.symmetric(
//                 vertical: screenHeight / 50,
//                 horizontal: screenWidth / 30,
//               ),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10.0),
//                 color: listTileBGColor,
//               ),
//               child: ListTile(
//                 contentPadding: EdgeInsets.zero,
//                 title: Container(
//                   padding: EdgeInsets.symmetric(vertical: screenHeight/100),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8.0),
//                     color: headTextBGColor,
//                   ),
//                   child: Padding(
//                     padding:  EdgeInsets.only(left: screenWidth/30),
//                     child: titleHeadText,),),
//                 subtitle: Padding(
//                   padding: EdgeInsets.only(left: screenWidth/30),
//                   child: subtitleText,
//                   ),
//                 ),
//             ),
//            builderWidget,
//           ],
//         ),
//       ),
//     ),
//   );
// }
// /*----I used this widget : My subscription plans -> my active plan Details(Button)---
// ---this is section 1nd (subscription name end )-------------------------------*/
//
// /*----I used this widget : My subscription plans -> my active plan Details(Button)---
// ---this is section 2nd (order Details Start )-------------------------------*/
//
// Widget orderDetailsInvisible (
//     {
//   context,
//   backgroundColor,
//   headTextBGColor,
//   headText,
//   headTextStyle,
//   lisBuilderWidget,
//   visible,
// }){
//   var screenWidth = MediaQuery.of(context).size.width;
//   var screenHeight = MediaQuery.of(context).size.height;
//  return Visibility(
//    visible: visible,
//    child: Container(
//       padding: EdgeInsets.symmetric(vertical: screenHeight/50, horizontal: screenWidth/30),
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width:double.infinity,
//             padding: EdgeInsets.symmetric(vertical: screenHeight/50, horizontal: screenWidth/30),
//             decoration: BoxDecoration(
//               color: headTextBGColor,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: customeText(
//               text: headText,
//               textAlign: TextAlign.start,
//               style: headTextStyle,
//             ),
//           ),
//          lisBuilderWidget,
//         ],
//       ),
//     ),
//  );
// }
//
//
// /*----I used this widget : My subscription plans -> my active plan Details(Button)---
// ---this is section 2nd (order Details end )-------------------------------*/