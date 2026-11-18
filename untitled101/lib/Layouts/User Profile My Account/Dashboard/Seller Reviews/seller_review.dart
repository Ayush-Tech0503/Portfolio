//
// import 'package:Citybazar_app/Layouts/User%20Profile%20My%20Account/Dashboard/Seller%20Reviews/Seller%20Review%20TableData/seller_reviews_datatable.dart';
// import 'package:flutter/material.dart';
// import '../../../../Util/constaint_textstyle.dart';
// import '../../../../Util/constant_color.dart';
// import '../../../../Widgets/custome_text.dart';
//
// class SellerReviewsScreen extends StatefulWidget {
//   const SellerReviewsScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SellerReviewsScreen> createState() => _SellerReviewsScreenState();
// }
//
// class _SellerReviewsScreenState extends State<SellerReviewsScreen> {
//   String location = '';
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//
//   get valuefirst => null;
//   bool _isFocused = false;
//   bool isExpanded = false;
//
//
//   final FocusNode _focusNode = FocusNode();
//   String search = '';
//
//   @override
//   void initState() {
//     super.initState();
//
//     _focusNode.addListener(() {
//       setState(() {
//         _isFocused = _focusNode.hasFocus;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var screenHeight = MediaQuery.of(context).size.height;
//     var screenWidth = MediaQuery.of(context).size.width;
//     return Container(
//       color: ConstantColor.loginWithOtpButtonColor,
//       child: SafeArea(
//         child: Scaffold(
// /*--------------------------------------appbar section start-------------------------------------*/
//           key: _scaffoldKey,
//           appBar: AppBar(
//             elevation: 1,
//             leadingWidth: 24,
//             backgroundColor: ConstantColor.primaryBackgroundMainColor,
//             iconTheme: const IconThemeData(color: ConstantColor.loginWithOtpButtonColor),
//             title: customeText(textAlign: TextAlign.start,
//                 text: "Seller Reviews", style: ConstantTextStyle.secodHearText),
//           ),
// /*--------------------------------------appbar section end-------------------------------------*/
//           body:  SingleChildScrollView(
//             child: Column(
//                 children: [
//                   Container(
//                     width: double.maxFinite,
//                     color: ConstantColor.primaryBackgroundMainColor,
//                     padding: EdgeInsets.only(left:screenWidth/20,top: screenHeight/60,bottom: screenHeight/60 ),
//                     child: customeText(
//                       text: "Your Seller Reviews".toUpperCase(),
//                       style: ConstantTextStyle.secodHearText,
//                     ),
//                   ),
//
// /*--------------------------------Seller Review Table start  -------------------------------------*/
//                   const SellerReviewDataTable(),
// /*--------------------------------Seller Review Table end  -------------------------------------*/
//                 ],
//               ),
//           ),
//           ),
//         ),
//
//     );
//   }
// }
