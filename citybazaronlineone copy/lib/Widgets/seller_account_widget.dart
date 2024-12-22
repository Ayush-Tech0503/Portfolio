//
// import 'package:flutter/material.dart';
//
// Widget richTextWidgetSpan ({firstText,firstTextStyle ,secondText, secondTextStyle,  context,widgetSpans}) {
//  // var screenWidth = MediaQuery.of(context).size.width;
//    var screenHeight = MediaQuery.of(context).size.height;
//   return Padding(
//     padding: EdgeInsets.symmetric(vertical: screenHeight/200),
//     child: RichText(
//       text: TextSpan(
//         children: [
//           TextSpan(
//             text: firstText,
//             style:firstTextStyle,
//           ),
//           TextSpan(
//             text: secondText,
//             style:secondTextStyle,
//           ),
//           WidgetSpan(
//         child: widgetSpans,
//           ),
//         ],
//       ),
//     ),
//   );
// }