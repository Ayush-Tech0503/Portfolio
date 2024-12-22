// import 'package:Citybazar_app/Layouts/Onboarding%20Screens/login_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../../Util/constaint_textstyle.dart';
// import '../../../Util/constant_color.dart';
// import '../../../Widgets/Drawer Widget/custom_drawer.dart';
// import '../../../Widgets/Send Enquiry dialogBox/alert_dialog_box.dart';
// import '../../../Widgets/custome_button_.dart';
// import '../../../Widgets/custome_checkbox.dart';
// import '../../../Widgets/custome_text.dart';
// import '../../../Widgets/famous_market_card_widget.dart';
// import '../../Famous Market/Store Details/share_app.dart';
// import '../About Us/about_us_screen.dart';
// import '../Advertise With Us/ads_with_us.dart';
// import '../Beacome a Seller/become_a_seller.dart';
// import '../Contact Us/contact_us_screen.dart';
// import '../Dashboard/dashboard_screen.dart';
// import '../FAQs/faq_screen.dart';
// import '../My Profile/my_profile_update_form.dart';
// import '../Privacy Policy/privacy_policy_screen.dart';
// import '../Term Of Use/terms_of_use.dart';
//
// class CustomUserDrawerMenu extends StatefulWidget {
//   const CustomUserDrawerMenu({super.key});
//
//   @override
//   State<CustomUserDrawerMenu> createState() => _CustomUserDrawerMenuState();
// }
//
// class _CustomUserDrawerMenuState extends State<CustomUserDrawerMenu> {
// /*-------------------------Drawer data start-----------------------*/
// /*-------------------------whatsapp share start------------------------------------------------*/
//   void _launchWhatsApp() async {
//       const phoneNumber = '1234567890';
//       const message = 'Hello, how are you?';
//
//       final url =
//           'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';
//       // ignore: deprecated_member_use
//       if (await canLaunch(url)) {
//         // ignore: deprecated_member_use
//         await launch(url);
//       } else {
//         throw 'Could not launch WhatsApp $url';
//       }
//   }
//
// /*-------------------------------whatsapp share end----------------------------------------*/
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
// /*--------------------------------Drawer List start--------------------------------------*/
//   static final List<String> _listViewData = [
//     "Dashboard",
//     "My Profile",
//     "Become a Seller",
//     "Share App",
//     "Join Whatsapp",
//     "Rating / Feedback",
//     "FAQ",
//     "About Us",
//     "Contact Us",
//     "Privacy Policy",
//     "Advertise With Us",
//     "Term Of Use",
//     "Log Out"
//   ];
//
//   static const _iconTypes = <IconData>[
//     Icons.space_dashboard_outlined,
//     Icons.person_outline,
//     Icons.storefront_outlined,
//     Icons.share_outlined,
//     FontAwesome.whatsapp,
//     Icons.star_border_rounded,
//     Icons.quiz_outlined,
//     Icons.info_outlined,
//     Icons.contact_mail_outlined,
//     Icons.privacy_tip_outlined,
//     FontAwesome.bullhorn,
//     FontAwesome.info_circle,
//     Icons.logout
//   ];
//
// /*--------------------------------Drawer List end--------------------------------------*/
// /*-------------------------DialogBox Hindi data List For listview builder start-----------------------*/
//   final List<String> _hindiTextData = [
//     "मुझे ऐप कांसेप्ट समझ नहीं आया |",
//     "ऐप को ऑपरेट करना कठिन हैं |",
//     "मुझे अपनी पसंद का प्रोडक्ट नहीं मिला |",
//     "अन्य",
//   ];
//   void clearToken() async {
//     SharedPreferences preference = await SharedPreferences.getInstance();
//
//     preference.clear();
//   }
//
// /*-------------------------DialogBox Hindi data List For listview builder end-----------------------*/
// /*-------------------------Drawer data end-----------------------*/
//
//   @override
//   Widget build(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width;
//     var screenHeight = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       extendBody: true,
//       key: _scaffoldKey,
//       backgroundColor: ConstantColor.transparent1,
//       body: Drawer(
//         backgroundColor: ConstantColor.loginWithOtpButtonColor,
//         child: myDrawer(
//           icon: Icons.close,
//           closeIconSize: 25.0,
//           closeIconColor: ConstantColor.primaryBackgroundMainColor,
//           context: context,
//           onPressedCloseIcon: () {
//             Navigator.of(context).pop();
//           },
//           sizeBoxHeight: screenHeight / 15,
//           drawerHeaderText: "My Account",
//           drawerHeaderTextStyle: ConstantTextStyle.topCategoryText3,
//           centerDrawerColor: ConstantColor.drawerItemsColor,
//           centerDrawerBorder: BorderRadius.circular(20.0),
//           child: ListView.separated(
//             padding: const EdgeInsets.all(10.0),
//             separatorBuilder: (context, index) => const Divider(
//                 color: ConstantColor.primaryBlackColor, height: 2),
//             itemCount: _listViewData.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 minLeadingWidth: 10,
//                 leading: Icon(
//                   _iconTypes[index],
//                   color: ConstantColor.primaryBackgroundMainColor,
//                 ),
//                 title: Text(
//                   _listViewData[index],
//                   style: ConstantTextStyle.newiconButtonText,
//                 ),
//                 onTap: () {
//                   // Handle individual icon press based on index
//                   switch (index) {
//                     case 0:
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => DashBoardScreen(
//                               id: widget.id??"",
//                               lName: widget.lName??"",
//                               latitude: widget.latitude??"",
//                               longitude: widget.longitude??"",
//                             )),
//                       );
//                       break;
//                     case 1:
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const MyProfileUpdate()),
//                       );
//                       break;
//                     case 2:
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) =>  BecomeASellerform(id: '', longitude: '', latitude: '', lName: '',)),
//                       );
//                       break;
//
//                     case 3:
//                       //    links
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return const ShareAppScreen();
//                         },
//                       );
//                       break;
//
//                     case 4:
//                       _launchWhatsApp();
//                       break;
//                     case 5:
// /*---------------------------------Dialog Box start----------------------------------------*/
//
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return AlertDialog(
//                             shape: const RoundedRectangleBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(20.0))),
//                             icon: circleIcon(
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                               backgroundColor: ConstantColor.primaryMainColor,
//                               iconSize: 15.0,
//                               radius: 15.0,
//                               icons: Icons.close_outlined,
//                               iconcolor:
//                                   ConstantColor.primaryBackgroundMainColor,
//                             ),
//                             contentPadding: EdgeInsets.zero,
//                             iconPadding: EdgeInsets.only(
//                                 left: screenWidth / 1.7,
//                                 top: screenHeight / 150),
//                             title: Center(
//                               child: ratingsStar(
//                                 bgColor: ConstantColor.transparent1,
//                                 initialRating: 4.5,
//                                 itemSize: 40.0,
//                                 minRating: 1.0,
//                                 allowHalfRating: true,
//                                 itemCount: 5,
//                                 onRatingUpdate: (rating) {},
//                                 itemBuilder: (context, _) => const Icon(
//                                   Icons.star,
//                                   color: ConstantColor.starRatingColor,
//                                 ),
//                               ),
//                             ),
//                             content: customeText(
//                                 text: "Do you like us? give 5 Star",
//                                 style: ConstantTextStyle.ratingText2,
//                                 textAlign: TextAlign.center),
//                             actionsPadding: EdgeInsets.symmetric(
//                                 vertical: screenHeight / 40),
//                             actions: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   customeButton(
//                                     textStyleButton:
//                                         ConstantTextStyle.tabButtonTextStyle,
//                                     onPressed: () {
// /*--------------------------Nested AlertBox start with builder --------------------------------*/
//                                       showDialog(
//                                         context: context,
//                                         builder: (context) {
//                                           List<bool> checkBoxValues =
//                                               List<bool>.filled(
//                                                   _hindiTextData.length, false);
//                                           return StatefulBuilder(
//                                             builder: (context, setState) {
//                                               return AlertDialog(
//                                                 shape:
//                                                     const RoundedRectangleBorder(
//                                                         borderRadius:
//                                                             BorderRadius.all(
//                                                                 Radius.circular(
//                                                                     20.0))),
//                                                 title: customeText(
//                                                     text:
//                                                         "आपका फीड बैक हमारे लिए मह्त्वपूर्ण हैं | ",
//                                                     style: ConstantTextStyle
//                                                         .secodHearText,
//                                                     textAlign:
//                                                         TextAlign.center),
//                                                 content: SizedBox(
//                                                   width: double.maxFinite,
//                                                   child: ListView.builder(
//                                                     shrinkWrap: true,
//                                                     itemCount:
//                                                         _hindiTextData.length,
//                                                     itemBuilder:
//                                                         (BuildContext context,
//                                                             int index) {
//                                                       return ListTile(
//                                                         contentPadding:
//                                                             EdgeInsets.zero,
//                                                         visualDensity:
//                                                             const VisualDensity(
//                                                                 horizontal: -4,
//                                                                 vertical: -4),
//                                                         leading:
//                                                             customeCheckbox(
//                                                           checkColor: ConstantColor
//                                                               .primaryBackgroundMainColor,
//                                                           activeColor: ConstantColor
//                                                               .filedContainerColor,
//                                                           value: checkBoxValues[
//                                                               index],
//                                                           onChanged:
//                                                               (newValue) {
//                                                             setState(() {
//                                                               checkBoxValues[
//                                                                       index] =
//                                                                   newValue!;
//                                                             });
//                                                           },
//                                                         ),
//                                                         title: customeText(
//                                                             text:
//                                                                 _hindiTextData[
//                                                                     index],
//                                                             style:
//                                                                 ConstantTextStyle
//                                                                     .ratingText2),
//                                                       );
//                                                     },
//                                                   ),
//                                                 ),
//                                                 actionsPadding:
//                                                     EdgeInsets.symmetric(
//                                                         vertical:
//                                                             screenHeight / 40),
//                                                 actions: [
//                                                   Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .center,
//                                                     children: [
//                                                       customeButton(
//                                                         textStyleButton:
//                                                             ConstantTextStyle
//                                                                 .tabButtonTextStyle,
//                                                         onPressed: () {
//                                                           Navigator.of(context)
//                                                               .pop();
//                                                         },
//                                                         text: "Cancel"
//                                                             .toUpperCase(),
//                                                         backgroundColor:
//                                                             ConstantColor
//                                                                 .homeScreenAvatarBGColor,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(8.0),
//                                                         elevation: 2.0,
//                                                       ),
//                                                       SizedBox(
//                                                         width: screenWidth / 20,
//                                                       ),
//                                                       customeButton(
//                                                         textStyleButton:
//                                                             ConstantTextStyle
//                                                                 .loginButtonTextStyle,
//                                                         onPressed: () {
//                                                           // Check if at least one checkbox is selected
//                                                           if (checkBoxValues
//                                                               .contains(true)) {
//                                                             // Perform the submit action
//                                                           } else {
//                                                             // Show an error message or perform any other validation action
//                                                             showDialog(
//                                                               context: context,
//                                                               builder:
//                                                                   (context) {
//                                                                 return AlertDialog(
//                                                                   title:
//                                                                       customeText(
//                                                                     text:
//                                                                         "Validation Error",
//                                                                     style: ConstantTextStyle
//                                                                         .secodHearText,
//                                                                     textAlign:
//                                                                         TextAlign
//                                                                             .center,
//                                                                   ),
//                                                                   content:
//                                                                       customeText(
//                                                                     text:
//                                                                         "Please select at least one Option.",
//                                                                     style: ConstantTextStyle
//                                                                         .passwordScreenLineTexStyle,
//                                                                     textAlign:
//                                                                         TextAlign
//                                                                             .center,
//                                                                   ),
//                                                                   actions: [
//                                                                     customeButton(
//                                                                       textStyleButton:
//                                                                           ConstantTextStyle
//                                                                               .loginButtonTextStyle,
//                                                                       onPressed:
//                                                                           () =>
//                                                                               Navigator.pop(context),
//                                                                       text: "OK"
//                                                                           .toUpperCase(),
//                                                                       backgroundColor:
//                                                                           ConstantColor
//                                                                               .primaryMainColor,
//                                                                       borderRadius:
//                                                                           BorderRadius.circular(
//                                                                               8.0),
//                                                                       elevation:
//                                                                           2.0,
//                                                                     ),
//                                                                   ],
//                                                                 );
//                                                               },
//                                                             );
//                                                           }
//                                                         },
//                                                         text: "Submit"
//                                                             .toUpperCase(),
//                                                         backgroundColor:
//                                                             ConstantColor
//                                                                 .primaryMainColor,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(8.0),
//                                                         elevation: 2.0,
//                                                       ),
//                                                     ],
//                                                   )
//                                                 ],
//                                               );
//                                             },
//                                           );
//                                         },
//                                       );
//
// /*--------------------------Nested AlertBox end with builder --------------------------------*/
//                                     },
//                                     text: "1-4 Star".toUpperCase(),
//                                     backgroundColor:
//                                         ConstantColor.homeScreenAvatarBGColor,
//                                     borderRadius: BorderRadius.circular(8.0),
//                                     elevation: 2.0,
//                                   ),
//                                   SizedBox(
//                                     width: screenWidth / 20,
//                                   ),
//                                   customeButton(
//                                     textStyleButton:
//                                         ConstantTextStyle.loginButtonTextStyle,
//                                     onPressed: () {},
//                                     text: "5 Start".toUpperCase(),
//                                     backgroundColor:
//                                         ConstantColor.primaryMainColor,
//                                     borderRadius: BorderRadius.circular(8.0),
//                                     elevation: 2.0,
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           );
//                         },
//                       );
// /*---------------------------------Dialog Box end----------------------------------------*/
//
//                       break;
//                     case 6:
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const FAQScreen()),
//                       );
//                       break;
//                     case 7:
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const AboutUsScreen()),
//                       );
//                       break;
//                     case 8:
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const ContactUsScreen()),
//                       );
//                       break;
//                     case 9:
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const PrivacyPolicyScreen()),
//                       );
//                       break;
//                     case 10:
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) =>
//                                 const AdvertiseWithUsScreen()),
//                       );
//                       break;
//                     case 11:
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const TermOfUseScreen()),
//                       );
//                       break;
//                     case 12:
//                       clearToken();
//
//                       Navigator.of(context).pushAndRemoveUntil(
//                         // the new route
//                         MaterialPageRoute(
//                           builder: (BuildContext context) => const LoginScreen(),
//                         ),
//
//                         (Route route) => false,
//                       );
//
//                       break;
//                     default:
//                       break;
//                   }
//                 },
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
