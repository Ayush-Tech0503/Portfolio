// ignore_for_file: must_be_immutable, deprecated_member_use, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';
import 'Layouts/Home Page Trending Reals/See More Reels/see_more_reels.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'Layouts/Notification Screen/notification_screen.dart';
import 'Layouts/Onboarding Screens/alert_registration_form.dart';
import 'Layouts/User Profile My Account/Custom AppBar Screen/custom_user_appbar.dart';
import 'Layouts/home_screen.dart';
import 'Layouts/profile_screen.dart';
import 'Layouts/store_screen.dart';
import 'Util/Constant APi Url/api_urls.dart';
import 'Util/constaint_textstyle.dart';
import 'Util/constant_color.dart';
import 'Widgets/Login Check Widget/login_check_widget.dart';
import 'Widgets/custome_text.dart';

class DialogUtils {
  static Future<bool> showExitConfirmationDialog(BuildContext context) async {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var tokenAccess;
    fetchFeedbackCheckAPi() async {
      try {
        SharedPreferences preference = await SharedPreferences.getInstance();
        tokenAccess = preference.getString("access-token");
        final response = await Dio().get(
          "${ConstantUrls.baseUriApi2}${ConstantUrls.feedBackCheckApi}",
          options: Options(
            headers: {
              "Authorization": tokenAccess,
              'Content-Type': 'application/json',
            },
          ),
        );
        if (response.statusCode == 200) {
          var responseData = json.decode(response.data.toString());
          if ( responseData['msg'] == "false"){
            showFeedbackDialog(context);
          }else {
            SystemNavigator.pop();
          }
        } else { }
        // setState(() {});
      } catch (error) {
        // setState(() {});
      }
    }
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: screenWidth/30),
        titlePadding: EdgeInsets.symmetric(horizontal: screenWidth/30,vertical: screenHeight/60),
        backgroundColor: ConstantColor.primaryBackgroundMainColor,
        title: const Text('Please confirm!'),
        content: const Text('Are you sure you want to exit?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            // style: ElevatedButton.styleFrom(
            //   //backgroundColor: ConstantColor.primaryBackgroundMainColor,
            // ),
            child: const Text('No',),
          ),
          const SizedBox(width: 10.0,),
          TextButton(
            onPressed: (){
              fetchFeedbackCheckAPi();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ConstantColor.primaryBackgroundMainColor,
            ),
            child: Text('Yes', style: ConstantTextStyle.hintTextStyle2),
          ),
        ],
      ),
    ) ?? false;
  }
}



class MyHomePageDemo1 extends StatefulWidget {
  String lat;
  String? getReelsId;
  String longitude;
  String id;
  String lName;
  var index;
  final int initialIndex;
   MyHomePageDemo1({super.key,
     required String mobilenumber,
     required this.lat,
     this.getReelsId,
     required this.longitude,
     required this.id,
     required this.lName,
     this.initialIndex = 0});

  @override
  State<MyHomePageDemo1> createState() => _MyHomePageDemo1State();
}

class _MyHomePageDemo1State extends State<MyHomePageDemo1> {
  int currentPageIndex = 0;

  int index = 0;
  final ScrollController scrollController = ScrollController();
  final ScrollController _storesScreenController = ScrollController();
  final ScrollController couponController = ScrollController();
  final ScrollController personAccountController = ScrollController();
  final ScrollController floatingButtonController = ScrollController();



  String locationName = "";
  getLocationName({latitude, longitude}) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final placemark = placemarks[0];
        final location = "${placemark.street}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea}";
        setState(() {
          locationName = location;
        });
        saveLocationName(location);
      } else {
        setState(() {
          locationName = "Location details not found for the given coordinates.";
        });
      }
    } catch (e) {
      setState(() {
        locationName = "An error occurred while fetching location details.";
      });
    }
  }

  saveLocationName(String location) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('locationName', location);
  }
  saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("location", locationName);
  }
  String getLocationPart(String location, int index) {
    List<String> parts = location.split(',');
    return parts.length > index && parts[index].isNotEmpty ? parts[index].trim() : "";
  }

  void checkUserStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasSeenDialog = prefs.getBool('hasSeenDialog') ?? false;
    bool isProfileCompleted = prefs.getBool("isProfileCompleted") ?? false;
    bool isUserLoggedIn = prefs.getBool("isLogin") ?? false;

    if (isUserLoggedIn && !isProfileCompleted && !hasSeenDialog) {
      // Show registration dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertRegistrationForm();
        },
      );
      prefs.setBool('hasSeenDialog', true);
    } else if (!isUserLoggedIn) {
      // Show login dialog
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return const CheckIsLogin();
        },
      );
    }
  }
bool isUserLoggedIn = false;

  void newAppUpdate()async {
    WidgetsFlutterBinding.ensureInitialized();
    await Upgrader.clearSavedSettings();
    await Upgrader().initialize();
  }


  @override
  void initState() {
    super.initState();
    newAppUpdate();
    saveData();widget.id != ""
        ? getLocationName(
        latitude: double.parse(widget.lat),
        longitude: double.parse(widget.longitude))
        : getLocationName(latitude: 22.7177, longitude: 75.855217);

    SharedPreferences.getInstance().then((prefs) {
      bool hasSeenDialog = prefs.getBool('hasSeenDialog') ?? false;
      bool isProfileCompleted = prefs.getBool("isProfileCompleted") ?? false;
      isUserLoggedIn = prefs.getBool("isLogin") ?? false;
      tokenAccess = prefs.getString("access-token");
      if(isUserLoggedIn) {
        if (!isProfileCompleted && !hasSeenDialog) {
          // Show the dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AlertRegistrationForm();
            },
          );
          prefs.setBool('hasSeenDialog', true);
        }
      }
      else{

      }
    });
    index = widget.initialIndex;
    currentPageIndex = widget.initialIndex;
    // myFile();
  }




  Future<bool> _onWillPop() async {
    // Check if the current index is not 0 (Home screen)
    if (_controller.index != 0 && _pageController.page != 0) {
      // Navigate to index 0 (Home screen)
      setState(() {
        _pageController.jumpToPage(0);
        _pageController.page != 0;
        _controller.index = 0;
      });
      return false; // Do not exit, as we've navigated to index 0
    }
    // Show the exit confirmation dialog
    bool exit = await DialogUtils.showExitConfirmationDialog(context);
    return exit;
  }



  var userId;
  var tokenAccess;
  String selectedData = '';
  @override
  void dispose() {
    scrollController.dispose();
    _getControllerByIndex(index).dispose();
    _pageController.dispose();
    super.dispose();
  }

  /// Controller to handle PageView and also handles initial page
  final _pageController = PageController(initialPage: 2);
  /// Controller to handle bottom nav bar and also handles initial page
  final _controller = NotchBottomBarController(index: 2);

  ScrollController _getControllerByIndex(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return scrollController;
      case 1:
        return _storesScreenController;
      case 2:
        return couponController;
      case 3:
        return personAccountController;
      case 4:
        return floatingButtonController;
      default:
        return scrollController; // Use a default controller or handle differently as needed
    }
  }
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: _onWillPop,
      child: UpgradeAlert(
        showLater: false,
        dialogStyle: Platform.isIOS ? UpgradeDialogStyle.cupertino : UpgradeDialogStyle.material,
        showIgnore: false,
        showReleaseNotes: false,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ConstantColor.drawerDividerColor,
            elevation: 0.0,
            leading: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return const CustomAppbarLeadingData();
                      });
                },
                child: const Icon(
                  Icons.my_location_outlined,
                  color: ConstantColor.primaryBackgroundMainColor,
                )),
            title: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return const CustomAppbarLeadingData();
                    });
              },
              child: Text(locationName,
                style: ConstantTextStyle.landingScreenAppbarText,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            titleSpacing: 0.0,
            actions: [
              Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width / 30),
                child: GestureDetector(
                  child: const Icon(Icons.notifications_on_outlined,
                    color: ConstantColor.primaryBackgroundMainColor,),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          const NotificationScreen()),
                    );
                  },
                ),
              ),
            ],
          ),

              body: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    HomeScreen(
                      controller: scrollController,
                      lattude: widget.lat,
                      longitude: widget.longitude,
                      id: widget.id,
                      lName: locationName.isNotEmpty
                          ? getLocationPart(locationName, 2)
                          : '',
                    ),
                    StoresScreen(
                      controller: _storesScreenController,
                      lattude: widget.lat,
                      longitude: widget.longitude,
                      id: widget.id,
                      lName: locationName.isNotEmpty
                          ? getLocationPart(locationName, 2)
                          : '',
                    ),
                    SeeMoreReelsScreen(
                      // getReelsId: widget.getReelsId= "",
                      latitude: widget.lat,
                      longitude: widget.longitude,
                      id: widget.id,
                      lName: locationName.isNotEmpty
                          ? getLocationPart(locationName, 2)
                          : '',
                    ),
                    Center(child: customeText(text: '# Coupons'.toUpperCase(),style: ConstantTextStyle.topCategoryText,),),
                    ProfileScreen(
                      controller: personAccountController,
                      id: widget.id,
                      longitude: widget.longitude,
                      latitude: widget.lat,
                      lName: locationName.isNotEmpty
                          ? getLocationPart(locationName, 2)
                          : '',
                    ),
                  ]
              ),




          extendBody: true,
          bottomNavigationBar: AnimatedNotchBottomBar(
            /// Provide NotchBottomBarController
            notchBottomBarController: _controller,
            color: Colors.white,
            showLabel: false,
            shadowElevation: 5,
            kBottomRadius: 10.0,
            // notchShader: const SweepGradient(
            //   startAngle: 0,
            //   // endAngle: pi / 2,
            //   colors: [ConstantColor.primaryMainColor, Colors.green, Colors.orange],
            //   tileMode: TileMode.mirror,
            // ).createShader(Rect.fromCircle(center: Offset.zero, radius: 8.0)),
            notchColor: ConstantColor.primaryMainColor,

            /// restart app if you change removeMargins
            removeMargins: false,
            bottomBarWidth: 500,
            durationInMilliSeconds: 300,
            bottomBarItems: const [
               BottomBarItem(
                inActiveItem: Icon(
                  Icons.home_outlined,
                  color: ConstantColor.secondoryBlackColors,
                ),
                activeItem: Icon(
                  Icons.home,
                  color: ConstantColor.primaryBackgroundMainColor,
                ),
                itemLabel: 'Page 1',
              ),
               BottomBarItem(
                inActiveItem: Icon(
                  Icons.store_mall_directory_outlined,
                  color: ConstantColor.secondoryBlackColors,
                ),
                activeItem: Icon(
                  Icons.store_mall_directory,
                  color: ConstantColor.primaryBackgroundMainColor,
                ),
                itemLabel: 'Page 2',
              ),
               BottomBarItem(
                inActiveItem: Icon(
                  Icons.play_circle_outline_rounded,
                  color: ConstantColor.secondoryBlackColors,
                ),
                activeItem: Icon(
                  Icons.play_circle_rounded,
                  color: ConstantColor.primaryBackgroundMainColor,
                ),
                itemLabel: 'Page 3',
              ),
               BottomBarItem(
                inActiveItem: Icon(
                  Icons.sell_outlined,
                  color: ConstantColor.secondoryBlackColors,
                ),
                activeItem: Icon(
                  Icons.sell,
                  color: ConstantColor.primaryBackgroundMainColor,
                ),
                itemLabel: 'Page 4',
              ),
               BottomBarItem(
                inActiveItem: Icon(
                  Icons.person_pin_outlined,
                  color: ConstantColor.secondoryBlackColors,
                ),
                activeItem: Icon(
                  Icons.person_pin_rounded,
                  color: ConstantColor.primaryBackgroundMainColor,
                ),
                itemLabel: 'Page 5',
              ),
            ],
            onTap: (index) {
              /// perform action on tab change and to update pages you can update pages without pages
              _pageController.jumpToPage(index);
            },
            kIconSize: 24.0,
          )
        ),
      ),
    );
  }
}