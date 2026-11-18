// import 'package:flutter/material.dart';
// import '../../../../../Util/constaint_textstyle.dart';
// import '../../../../../Util/constant_color.dart';
// import '../../../../../Widgets/custome_text.dart';
// import 'Booked Products TableData/booked_products_datatable.dart';
//
// class YourBookedProductScreen extends StatefulWidget {
//   const YourBookedProductScreen({Key? key}) : super(key: key);
//
//   @override
//   State<YourBookedProductScreen> createState() =>
//       _YourBookedProductScreenState();
// }
//
// class _YourBookedProductScreenState extends State<YourBookedProductScreen> {
//   String location = '';
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   get valuefirst => null;
//   bool _isFocused = false;
//   bool isExpanded = false;
//   final FocusNode _focusNode = FocusNode();
//   String search = '';
//
//
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
//         child:Scaffold(
//           appBar: AppBar(
//             elevation: 1,
//             leadingWidth: 24,
//             backgroundColor: ConstantColor.primaryBackgroundMainColor,
//             iconTheme: const IconThemeData(color: ConstantColor.loginWithOtpButtonColor),
//             title: customeText(textAlign: TextAlign.start,
//                 text: "Booked Products", style: ConstantTextStyle.secodHearText),
//           ),
//           key: _scaffoldKey,
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   width: double.maxFinite,
//                   color: ConstantColor.primaryBackgroundMainColor,
//                   padding:EdgeInsets.only(left:screenWidth/20,top: screenHeight/60,bottom: screenHeight/60  ),
//                   child: customeText(
//                     text: "Your Booking Products".toUpperCase(),
//                     style: ConstantTextStyle.secodHearText,
//                   ),
//                 ),
//
// /*----------------Show : DropDown : Entries : searchBox section start--------------------------------------------*/
//
// /*----------------Show : DropDown : Entries : searchBox section end--------------------------------------------*/
// /*--------------------------------Your Booked Product Section Table start  -------------------------------------*/
//                  BookedProductDataTable(
//
//                  ),
// /*--------------------------------Your Booked Product Section Table end  -------------------------------------*/
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
