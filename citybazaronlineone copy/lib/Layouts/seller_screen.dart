// // ignore_for_file: deprecated_member_use
//
//
// import 'package:flutter/material.dart';
//
// import '../Util/constaint_textstyle.dart';
// import '../Util/constant_color.dart';
// import '../Util/constant_image.dart';
// import '../Widgets/custome_button_.dart';
// import '../Widgets/custome_imagies.dart';
// import '../Widgets/custome_text.dart';
// import '../Widgets/landing_screen_slider.dart';
// import '../Widgets/search_bar.dart';
//
// class SellerScreen extends StatefulWidget {
//   const SellerScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SellerScreen> createState() => _SellerScreenState();
// }
//
// class _SellerScreenState extends State<SellerScreen> {
//
// /*----------------------------------------------------------------------*/
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
// /*--------------------------------Dashboard list start--------------------------------------*/
//   final List<String> _counts = [
//     "02".toUpperCase(),
//     "10".toUpperCase(),
//     // "07".toUpperCase(),
//     "03".toUpperCase(),
//     "16".toUpperCase(),
//     "05".toUpperCase(),
//     "01".toUpperCase(),
//     "19".toUpperCase(),
//     "09".toUpperCase(),
//   ];
//
//   final List<String> _names = [
//     "Pending order".toUpperCase(),
//     "completed order".toUpperCase(),
//     // "Wishlisted product".toUpperCase(),
//     "Liked Product".toUpperCase(),
//     "uploaded product".toUpperCase(),
//     "Approved product".toUpperCase(),
//     "pending product".toUpperCase(),
//     "store review rating".toUpperCase(),
//     "follower seller".toUpperCase(),
//   ];
//
//   final List<IconData> _rightHendIcons = [
//     Icons.pending_actions_outlined,
//     Icons.check_circle_outline,
//     // Icons.favorite_border_outlined,
//     Icons.thumb_up_alt_outlined,
//     Icons.file_upload_outlined,
//     Icons.inventory_2_outlined,
//     Icons.history_outlined,
//     Icons.grade_outlined,
//     Icons.message_outlined,
//     // Add more icons...
//   ];
// /*--------------------------------Dashboard list end--------------------------------------*/
//
//
//   final List<String> _textData = [
//     "Aashu Collection",
//     "7000972008",
//     "Delhi",
//
//   ];
//
//   final List<IconData> _iconData = [
//     Icons.storefront,
//     Icons.phone_outlined,
//     Icons.location_on_outlined,
//   ];
//
//   /*-------------------------store detail List data start --------------------------*/
//   final List<String> _headText = [
//     "My Subscription Plan".toUpperCase(),
//     "Expire On".toUpperCase(),
//     "Remaining Days".toUpperCase(),
//   ];
//
//   final List<String> _subText = [
//     "Swagatam",
//     "18-09-2023",
//     "351 days",
//
//   ];
//
//   final List<IconData> _leftHandIcon = [
//     Icons.list_alt_outlined,
//     Icons.history_outlined,
//     Icons.event_note_outlined,
//     // Add more icons...
//   ];
//
//   /*----------------------------- store detail List data end--------------------------*/
//
//   @override
//   Widget build(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width;
//     var screenHeight = MediaQuery.of(context).size.height;
//     return Container(
//       color: ConstantColor.primaryMainColor,
//       child: SafeArea(
//         child: Scaffold(
//           key: _scaffoldKey,
//           //  key: _key,
//           appBar: AppBar(
//           //  toolbarHeight: screenHeight / 10,
//             backgroundColor: ConstantColor.bottonNavIcons,
//             elevation: 0.0,
//             leading: IconButton(
//               icon: const Icon(
//                 Icons.menu,
//                 color: ConstantColor.loginWithOtpButtonColor,
//               ),
//               onPressed: () {
//                 _scaffoldKey.currentState!.openDrawer();
//               },
//             ),
// /*--------------------------------------Search box section start-------------------------------------*/
//             title: searchbarBox(
//               hintText: "Enter keywords",
//               suffixIcon: customeButton(
//                 textStyleButton: ConstantTextStyle.otpResendButtonText,
//                 onPressed: () {},
//                 text: "Advance Search",
//                 backgroundColor: ConstantColor.searchBoxColor,
//                 borderRadius: BorderRadius.circular(0.0),
//                 elevation: 0.0,
//               ),
//               prefixIcon: IconButton(
//                 icon: const Icon(Icons.search),
//                 color: ConstantColor.primaryMainColor,
//                 onPressed: () {},
//               ),
//               context: context,
//               color: ConstantColor.searchBoxColor,
//               cursorColor: ConstantColor.primaryMainColor,
//             ),
// /*--------------------------------------Search box section end-------------------------------------*/
//             titleSpacing: 0.0,
//           ),
//
// /*--------------------------------------Drawer section start-------------------------------------*/
//           // drawer: const SellerDrawerScreen(),
// /*--------------------------------------Drawer section end -------------------------------------*/
//
//           extendBody: true,
//           body: SingleChildScrollView(
//             child: Container(
//               color: ConstantColor.primaryBackgroundMainColor,
//               padding: EdgeInsets.symmetric(vertical: screenHeight/50,horizontal: screenWidth/30,),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   customeText(
//                     text: "Seller Account".toUpperCase(),
//                     style: ConstantTextStyle.secodHearText,
//                   ),
//                   SizedBox(height: screenHeight / 50,),
//                   customeText(
//                     text: "Store Detail".toUpperCase(),
//                     overflow: TextOverflow.ellipsis,
//                     style: ConstantTextStyle.homeScreenHeadingText1,
//                   ),
//
// /*---------------------------------Store Image start----------------------------------------------*/
//
//                Padding(
//                  padding:  EdgeInsets.symmetric(vertical: screenHeight/50),
//                  child: ClipRRect(
//                    borderRadius: BorderRadius.circular(10.0),
//                    child: customImg(
//                      image: ConstantImage.storeimg,
//                      height: screenHeight/5,
//                      width: screenWidth/1,
//                      fit: BoxFit.fill,
//                    ),
//                  ),
//                ),
// /*-------------------------icon and Text in row start------------------------------------*/
//                   Row(
//                     children: [
//                       Icon(_iconData[0],color: ConstantColor.primaryMainColor,size: 20,),
//                       SizedBox(  width: screenWidth/4,
//                         child: customeText(
//                           text: _textData[0],
//                           style: ConstantTextStyle.becomeSellerDiscText,
//                           textAlign: TextAlign.start,
//                         ),
//                       ),
//                       SizedBox(width: screenWidth/40,),
//                       Icon(_iconData[1], color: ConstantColor.primaryMainColor,size: 20,),
//                       customeText(
//                         text: _textData[1],
//                         style: ConstantTextStyle.becomeSellerDiscText,
//                         textAlign: TextAlign.start,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       SizedBox(width: screenWidth / 40,),
//                       Icon(_iconData[2], color: ConstantColor.primaryMainColor,size: 20,),
//                       customeText(
//                         text:_textData[2],
//                         style: ConstantTextStyle.becomeSellerDiscText,
//                         textAlign: TextAlign.start,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
// /*-------------------------icon and Text in row end------------------------------------*/
// /*---------------------------------------Store Image end-------------------------------------------------*/
//                   SizedBox(height: screenHeight / 80,),
//
// /*-----------------------------ListTile Two Buttons section start------------------------------------------*/
//           ListTile(
//             contentPadding: EdgeInsets.zero,
//             leading: customeButton(
//                 elevation: 0.5,
//                 textStyleButton:
//                 ConstantTextStyle.loginButtonTextStyle,
//                 onPressed: () {
//                   // Navigator.push(context, MaterialPageRoute(builder: (context) => const  EditStoreProfileScreen()),);
//                   },
//                 text: "Edit Store Profile",
//                 backgroundColor: ConstantColor.loginWithOtpButtonColor,
//                 borderRadius: BorderRadius.circular(8.0),
//                 minimumSize: Size(screenWidth /2.3, screenHeight / 25.0)
//             ),
//             trailing: customeButton(
//                 elevation: 0.5,
//                 textStyleButton:
//                 ConstantTextStyle.loginButtonTextStyle,
//                 onPressed: () {},
//                 text: "Store View As",
//                 backgroundColor: ConstantColor.filedContainerColor,
//                 borderRadius: BorderRadius.circular(8.0),
//                 minimumSize: Size(screenWidth /2.3, screenHeight / 25.0)
//             ),
//           ),
//
// /*-----------------------------ListTile Two Buttons section end------------------------------------------*/
//                   SizedBox(height: screenHeight / 50,),
// /*-----------------------------Grid view start----------------------------------------------*/
//                   GridView.builder(
//                     physics: const PageScrollPhysics(),
//                     shrinkWrap: true,
//                     itemCount: 3,
//                     gridDelegate:
//                     const SliverGridDelegateWithFixedCrossAxisCount(
//                       childAspectRatio: 2/1,
//                       crossAxisCount: 2, // Number of columns in the grid
//                      crossAxisSpacing: 20.0, // Spacing between each column
//                      mainAxisSpacing: 15.0, // Spacing between each row
//                     ),
//                     itemBuilder: (BuildContext context, int index) {
//                       return GestureDetector(
//                         onTap: () {
//                           // Handle individual icon press based on index
//                           switch (index) {
//                             case 0:
//                             //  _launchPhoneCall();
//                               break;
//                             case 1:
//                          //     _emailContact();
//                               break;
//                             case 2:
//
//                               break;
//                             default:
//                               break;
//                           }
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: ConstantColor.sellerBGColor,
//                             borderRadius: BorderRadius.circular(20.0),
//                           ),
//
//                           child:storeDetailGrid(
//                               icons: _leftHandIcon[index],
//                             iconSize: 25.0,
//                               iconBgcolor:ConstantColor.locationIconColor,
//                               iconColor: ConstantColor.primaryMainColor,
//                               iconBoxHeight: screenHeight / 20.0,
//                             iconBoxWidth: screenWidth / 10.0,
//                               headText: _headText[index],
//                             headTextStyle: ConstantTextStyle.profileGridText,
//                             subText: _subText[index],
//                             subTextStyle: ConstantTextStyle.becomeSellerDiscText,
//
//                           ),
//                         ),
//                       );
//                     },
//                   ),
// /*-----------------------------Grid view  end----------------------------------------------*/
//                   SizedBox(height: screenHeight / 50,),
// /*---------------------------Recharge Button start-------------------------------------------*/
//                   customeButton(
//                       elevation: 0.5,
//                       textStyleButton:
//                       ConstantTextStyle.loginButtonTextStyle,
//                       onPressed: () {
//                         // Navigator.push(context, MaterialPageRoute(builder: (context) => const  NewPlanRenewScreen()),);
//                         },
//                       text: "Recharge",
//                       backgroundColor: ConstantColor.filedContainerColor,
//                       borderRadius: BorderRadius.circular(8.0),
//                       minimumSize:
//                       Size(screenWidth /2.3, screenHeight / 25.0)
//                   ),
// /*---------------------------Recharge Button end-------------------------------------------*/
//
//                   SizedBox(height: screenHeight / 50,),
//
// /*-----------------------------Grid view start----------------------------------------------*/
//
//                   GridView.builder(
//                     physics: const PageScrollPhysics(),
//                     shrinkWrap: true,
//                     itemCount: _counts.length,
//                     gridDelegate:
//                     const SliverGridDelegateWithFixedCrossAxisCount(
//                       childAspectRatio: 2 / 1,
//                       crossAxisCount: 2, // Number of columns in the grid
//                       crossAxisSpacing: 20.0, // Spacing between each column
//                       mainAxisSpacing: 20.0, // Spacing between each row
//                     ),
//                     itemBuilder: (BuildContext context, int index) {
//                       return GestureDetector(
//                         onTap: () {
//                           // Handle individual icon press based on index
//
//                         },
//                         child: profileGridView(
//                           title: customeText(
//                               text: _counts[index],
//                               style: ConstantTextStyle.countingText),
//                           subtitle: customeText(
//                               text: _names[index],
//                               style: ConstantTextStyle.profileGridText),
//                           borderRadius: BorderRadius.circular(20.0),
//                           iconBox: _rightHendIcons[index],
//                           boxHeight: screenHeight / 20,
//                           boxWidth: screenWidth / 10,
//                           boxbgcolor: ConstantColor.primaryBackgroundMainColor,
//                           iconsize: 25.0,
//                           boxiconcolor: ConstantColor.primaryMainColor,
//                           boxborderRadius: BorderRadius.circular(10.0),
//                         ),
//                       );
//                     },
//                   ),
// /*-----------------------------Grid view  end----------------------------------------------*/
//
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
//
// ////////////////// seller screen is hide /////////////////////////////