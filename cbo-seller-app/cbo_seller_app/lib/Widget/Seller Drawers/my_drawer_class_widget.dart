
import 'package:citybazaronline_seller_app/Screen/notification_screen.dart';
import 'package:citybazaronline_seller_app/Screen/seller_faq_screen.dart';
import 'package:citybazaronline_seller_app/Screen/Your%20Uploaded%20Video/upload_video_screen.dart';
import 'package:citybazaronline_seller_app/Screen/your_like_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Screen/My Subscription Plan Screen/my_subscription_plan_screen.dart';
import '../../Screen/Uploaded Products/uploaded_products_dart.dart';
import '../../Screen/my_profile_screen.dart';
import '../../Screen/your_booked_products.dart';
import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';
import '../page_navigation_animation_widget.dart';
import 'my_drawer_widget.dart';

class SellerDrawerScreen extends StatefulWidget {
  const SellerDrawerScreen({super.key});

  @override
  State<SellerDrawerScreen> createState() => _SellerDrawerScreenState();
}

class _SellerDrawerScreenState extends State<SellerDrawerScreen> {
//------log out flow -----

/*--------------------------------Drawer List start--------------------------------------*/
  static final List<String> _listViewData = [
    "My Subscription Plans",
    // "Seller Dashboard",
    "My Profile", // "Store Profile",
    "My Store",
    "Manage Products",
    "Uploaded videos",
    "Notification",
    "Your Liked Product",
    "Your Booked Product",
    // "Store Review Rating",
    "Seller Faqs",
  ];

  static const _iconTypes = <IconData>[
    Icons.business_center_outlined,
    // Icons.space_dashboard_outlined,
    Icons.person_outline_rounded,
    Icons.storefront,
    Icons.settings_outlined,
    Icons.video_library_outlined,
    Icons.notifications_none_outlined,
    Icons.thumb_up_alt_outlined,
    Icons.inventory_2_outlined,
    // Icons.message_outlined,
    Icons.help_outline_rounded,
  ];
/*--------------------------------Drawer List end--------------------------------------*/
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var name = '';
  var fistLetterName = '';
  var storeSlug = '';
  void isSellerName() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    setState(() {
       storeSlug = preference.getString("store_slug")??"";
      String? rawName = preference.getString("name");
      fistLetterName = rawName != null && rawName.isNotEmpty ? rawName[0].toUpperCase() : "";
      name = rawName != null ? "${rawName[0].toUpperCase()}${rawName.substring(1).toLowerCase()}" : "";
    });
  }

  @override
  void initState() {
    isSellerName();
    super.initState();
  }

  storeLink () async {await launch('https://citybazaronline.com/indore/$storeSlug');}

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ConstantColor.transparent1,
/*--------------------------------------Drawer section start-------------------------------------*/
      body:  Drawer(
        backgroundColor: ConstantColor.loginWithOtpButtonColor,
        child: myDrawer(
          icon: Icons.close,
          closeIconSize: 25.0,
          closeIconColor: ConstantColor.primaryBackgroundMainColor,
          context: context,
          onPressedCloseIcon: () => Navigator.of(context).pop(),
          sizeBoxHeight: screenHeight / 15,
          avtarText: fistLetterName,
          drawerHeaderText: "Hello $name",
          drawerHeaderTextStyle: ConstantTextStyle.topCategoryText3,
          centerDrawerColor: ConstantColor.drawerItemsColor,
          centerDrawerBorder: BorderRadius.circular(20.0),
          child: Scrollbar(
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(10.0),
              separatorBuilder: (context, index) => const Divider(
                  color: ConstantColor.primaryBlackColor, height: 2),
              itemCount: _iconTypes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  minLeadingWidth: 10,
                  leading: Icon(_iconTypes[index],
                    color: ConstantColor.primaryBackgroundMainColor,
                  ),
                  title: Text(
                    _listViewData[index],
                    style: ConstantTextStyle.newiconButtonText,
                  ),
                  onTap: () async {
                    switch (index) {
                      case 0: await Navigator.of(context).push(pageAnimationWidget(begin: const Offset(-1.0, 0.0), const MySubscriptionPlanScreen()));
                        //   Navigator.push(context, MaterialPageRoute(builder: (context) => const MySubscriptionPlanScreen()),);
                        break;
                      // case 1:
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => const  SellerDashBoardScreen()),);
                        break;
                      case 1: await Navigator.of(context).push(pageAnimationWidget(begin: const Offset(-1.0, 0.0), const MyProfileScreen()));
                        break;
                      case 2: storeLink();
                        break;
                      case 3:  await Navigator.of(context).push(pageAnimationWidget(begin: const Offset(-1.0, 0.0), const UploadedProductScreen()));
                        break;
                      case 4: await Navigator.of(context).push(pageAnimationWidget(begin: const Offset(-1.0, 0.0), const UploadVideoScreen()));
                       break;
                      case 5: await  Navigator.of(context).push(pageAnimationWidget(begin: const Offset(-1.0, 0.0), const NotificationScreen()));
                        break;
                      case 6: await Navigator.of(context).push(pageAnimationWidget(begin: const Offset(-1.0, 0.0), const LikeProductScreen()));
                        break;
                      case 7: await Navigator.of(context).push(pageAnimationWidget(begin: const Offset(-1.0, 0.0), const BookedProductScreen()));
                       break;
                      case 8: await Navigator.of(context).push(pageAnimationWidget(begin: const Offset(-1.0, 0.0), const SellerFAQScreen()));
                        break;
                      default:
                        break;
                    }
                  },
                );
              },
            ),
          ),
        ),
      ),
/*--------------------------------------Drawer section end -------------------------------------*/
    );
  }
}

void clearToken() async {
  SharedPreferences preference = await SharedPreferences.getInstance();
  preference.clear();
}

//  Widget build(BuildContext context) {
//     var screenHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: ConstantColor.transparent1,
// /*--------------------------------------Drawer section start-------------------------------------*/
//       body:  Drawer(
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
//           avtarText: fistLetterName,
//           drawerHeaderText: "Hello $name",
//           drawerHeaderTextStyle: ConstantTextStyle.topCategoryText3,
//           centerDrawerColor: ConstantColor.drawerItemsColor,
//           centerDrawerBorder: BorderRadius.circular(20.0),
//           child: Scrollbar(
//             child: ReorderableListView.builder(
//               shrinkWrap: true,
//               padding: const EdgeInsets.all(10.0),
//               onReorder: (oldIndex, newIndex) {
//                 setState(() {
//                   if (newIndex > oldIndex) {
//                     newIndex -= 1;
//                   }
//                   final String item = _listViewData.removeAt(oldIndex);
//                   _listViewData.insert(newIndex, item);
//                 });
//               },
//               // separatorBuilder: (context, index) => const Divider(
//               //     color: ConstantColor.primaryBlackColor, height: 2),
//               itemCount: _iconTypes.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   key: Key('$index'),
//                   minLeadingWidth: 10,
//                   leading: Icon(_iconTypes[index],
//                     color: ConstantColor.primaryBackgroundMainColor,
//                   ),
//                   title: Text(
//                     _listViewData[index],
//                     style: ConstantTextStyle.newiconButtonText,
//                   ),
//                   onTap: () async {
//                     // Retrieve the current index of the item being tapped
//                     int originalIndex = index;
//
//                     // Find the new index of the item after reordering
//                     int newIndex = originalIndex;
//                     for (int i = 0; i < _listViewData.length; i++) {
//                       if (originalIndex == i) continue;
//                       if (originalIndex < newIndex && i <= newIndex && i > originalIndex) {
//                         newIndex--;
//                       } else if (originalIndex > newIndex && i >= newIndex && i < originalIndex) {
//                         newIndex++;
//                       }
//                     }
//
//                     // Update the index to the new position
//                     index = newIndex;
//
//                     switch (index) {
//                       case 0:
//                         await Navigator.of(context).push(pageAnimationWidget(begin: const Offset(-1.0, 0.0), const MySubscriptionPlanScreen()));
//
//                         //   Navigator.push(context, MaterialPageRoute(builder: (context) => const MySubscriptionPlanScreen()),);
//                         break;
//                       case 1:
//                       // Navigator.push(context, MaterialPageRoute(builder: (context) => const  SellerDashBoardScreen()),);
//                         break;
//                       case 2:
//                       // Navigator.push(context, MaterialPageRoute(builder: (context) => const  EditStoreProfileScreen()),);
//                         break;
//                       case 3:
//                       //   Navigator.push(context, MaterialPageRoute(builder: (context) => const SellerMyShopScreen()),);
//                         break;
//                       case 4:
//                       //    Navigator.push(context, MaterialPageRoute(builder: (context) => const UploadedProductScreen()),);
//                         break;
//                       case 5:
//                       await  Navigator.of(context).push(pageAnimationWidget(begin: const Offset(-1.0, 0.0), const NotificationScreen()));
//                       //    Navigator.push(context, MaterialPageRoute(builder: (context) => const SellerNotificationScreen()),);
//                         break;
//                       case 6:
//                         await Navigator.of(context).push(pageAnimationWidget(begin: const Offset(-1.0, 0.0), const LikeProductScreen()));
//                       //  Navigator.push(context, MaterialPageRoute(builder: (context) => const LikedProductsScreen()),);
//                         break;
//                       case 7:
//                       //   Navigator.push(context, MaterialPageRoute(builder: (context) => const YourBookingProductScreen()),);
//                         break;
//                       case 8:
//                       //   Navigator.push(context, MaterialPageRoute(builder: (context) => const StoreReviewRatingScreen()),);
//                         break;
//                       case 9:
//                       //    Navigator.push(context, MaterialPageRoute(builder: (context) => const SellerFAQScreen()),);
//                         await Navigator.of(context).push(pageAnimationWidget(begin: const Offset(-1.0, 0.0), const SellerFAQScreen()));
//                       // Navigator.pushNamed(context, '/sellerFAQScreen');
//                         break;
//                       case 10:
//                         clearToken();
//                         await Navigator.pushNamedAndRemoveUntil(context, '/loginScreen', ModalRoute.withName('loginScreen'));
//                         break;
//                       default:
//                         break;
//                     }
//                   },
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
// /*--------------------------------------Drawer section end -------------------------------------*/
//     );
//   }