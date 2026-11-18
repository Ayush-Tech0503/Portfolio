// // ignore_for_file: library_private_types_in_public_api
//
// import 'dart:async';
//
// import 'package:Citybazar_app/Layouts/Onboarding%20Screens/alert_registration_form.dart';
// import 'package:curved_nav_bar/curved_bar/curved_action_bar.dart';
// import 'package:curved_nav_bar/fab_bar/fab_bottom_app_bar_item.dart';
// import 'package:curved_nav_bar/flutter_curved_bottom_nav_bar.dart';
// import 'package:flutter/material.dart';
//
// import '../../Util/constaint_textstyle.dart';
// import '../../Util/constant_color.dart';
// import '../Notification Screen/notification_screen.dart';
// import '../User Profile My Account/Custom AppBar Screen/custom_user_appbar.dart';
// import '../home_screen.dart';
// import '../profile_screen.dart';
// import '../reels_screen.dart';
// import '../store_screen.dart';
// class LandingScreens extends StatefulWidget {
//   const LandingScreens({super.key, required String mobilenumber});
//   @override
//   _LandingScreensState createState() => _LandingScreensState();
// }
// class _LandingScreensState extends State<LandingScreens> {
//     final ScrollController scrollController = ScrollController();
//
// ///////////////////////Alert Dialog box start//////////////////////////////
//   @override
//   void initState() {
//     super.initState();
//     Timer(const Duration(seconds: 1), () {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return const AlertRegistrationForm();
//         },
//       );
//     });
//
//   }
// ///////////////////////Alert Dialog box end//////////////////////////////
//
//   String? location;
//    int _selectedIndex = 0;
//   static const TextStyle optionStyle =
//   TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
//   @override
//   Widget build(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width;
//     return Container(
//       color: ConstantColor.loginWithOtpButtonColor,
//       child: SafeArea(
//         child: Scaffold(
//           body: CustomScrollView(
//             slivers: [
//             //  if (_selectedIndex != 2)
//                 SliverAppBar(
//                 backgroundColor: ConstantColor.drawerDividerColor,
//                 floating: true,
//                 elevation: 0.0,
//                 leading: const CustomAppbarLeadingData(),
//                 title: Text(
//                   '3,Sarvahara Nagar,Indore,madhya pradesh',
//                   style: ConstantTextStyle.landingScreenAppbarText,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 titleSpacing: 0.0,
//                 actions: [
//                   Padding(
//                     padding: EdgeInsets.only(right: screenWidth / 30),
//                     child: GestureDetector(
//                       child: const Icon(Icons.notifications_on_outlined),
//                       onTap: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationScreen()),);},
//                     ),
//                   ),
//                 ],
//               ),
//               SliverFillRemaining(
//                 child:  CurvedNavBar(
//                   actionButton: CurvedActionBar(
//                       onTab: (value) {},
//                       activeIcon: Container(
//                         padding: EdgeInsets.all(screenWidth/20),
//                         decoration: const BoxDecoration(
//                             color: ConstantColor.primaryMainColor,
//                        shape: BoxShape.circle),
//                         child: Text("Reels",style: ConstantTextStyle.newiconButtonText,),
//                       ),
//                       inActiveIcon: Container(
//                         padding: EdgeInsets.all(screenWidth/20),
//                         decoration: const BoxDecoration(
//                             color:ConstantColor.primaryBackgroundMainColor,
//                        shape: BoxShape.circle),
//                         child: Text("Reels",style: ConstantTextStyle.ratingText2,),
//                       ),
//                   ),
//                   navBarBackgroundColor:ConstantColor.primaryBackgroundMainColor,
//                   appBarItems: [
//                     FABBottomAppBarItem(
//                         activeIcon: Column(
//                           children: [
//                             const Icon(Icons.home_outlined, color:ConstantColor.loginWithOtpButtonColor,),
//                             Text("Home",style: ConstantTextStyle.bottomNavActiveText,),
//                           ],
//                         ),
//                         inActiveIcon: Column(
//                           children: [
//                             const Icon(Icons.home_outlined,  color: Colors.black26,),
//                             Text("Home",style: ConstantTextStyle.bottomNavInActiveText,),
//                           ],
//                         ),
//                         text: ''),
//                     FABBottomAppBarItem(
//                         activeIcon: Column(
//                           children: [
//                             const Icon(Icons.storefront_outlined, color:ConstantColor.loginWithOtpButtonColor,),
//                             Text("Store",style: ConstantTextStyle.bottomNavActiveText,),
//                           ],
//                         ),
//                         inActiveIcon: Column(
//                           children: [
//                             const Icon(Icons.storefront_outlined,  color: Colors.black26,),
//                             Text("Store",style: ConstantTextStyle.bottomNavInActiveText,),
//                           ],
//                         ),
//                       text: ""
//                     ),
//                     FABBottomAppBarItem(
//                         activeIcon: Column(
//                           children: [
//                             const Icon(Icons.sell_outlined, color:ConstantColor.loginWithOtpButtonColor,),
//                             Text("Coupon",style: ConstantTextStyle.bottomNavActiveText,),
//                           ],
//                         ),
//                         inActiveIcon: Column(
//                           children: [
//                             const Icon(Icons.sell_outlined,  color: Colors.black26,),
//                             Text("Coupon",style: ConstantTextStyle.bottomNavInActiveText,),
//                           ],
//                         ),
//                         text: ""
//                     ),
//                     FABBottomAppBarItem(
//                         activeIcon: Column(
//                           children: [
//                             const Icon(Icons.person_pin, color:ConstantColor.loginWithOtpButtonColor,),
//                             Text("Manage",style: ConstantTextStyle.bottomNavActiveText,),
//                           ],
//                         ),
//                         inActiveIcon: Column(
//                           children: [
//                             const Icon(Icons.person_pin,  color: Colors.black26,),
//                             Text("Manage",style: ConstantTextStyle.bottomNavInActiveText,),
//                           ],
//                         ),
//                         text: ""
//                     ),
//                   ],
//                   actionBarView: const ReelsPage(),
//                   bodyItems: [
//                      HomeScreen(controller: scrollController,),
//                      StoresScreen(controller: scrollController,),
//                      const Text('Index 1: Coupon', style: optionStyle,),
//                      ProfileScreen(controller: scrollController,),
//                   ],
//
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }