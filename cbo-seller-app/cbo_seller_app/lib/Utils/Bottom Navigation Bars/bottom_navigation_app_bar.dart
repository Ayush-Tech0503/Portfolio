// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, deprecated_member_use
import 'package:badges/badges.dart' as badges;
import 'package:citybazaronline_seller_app/Widget/custome_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Screen/Seller Dashboard Screen/dashboard_screen.dart';
import '../../Screen/follower_seller_screen.dart';
import '../../Screen/my_profile_screen.dart';
import '../../Widget/Custome Buttons/elevetion_button_widget.dart';
import '../../Widget/Seller Drawers/my_drawer_class_widget.dart';
import '../Font Style/text_styles.dart';
import '../Theme/constant_colors.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  final int initialIndex;
  const BottomNavigationBarScreen({super.key,this.initialIndex = 0});

  @override
  _BottomNavigationBarScreenState createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int _selectedIndex = 0;
  late List<Widget> _widgetOptions;
  int isSellerIn = 0;

  void isSellerKey() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    setState(() {
      isSellerIn = preference.getInt("is_seller") ?? 0;
    });
  }

  @override
  void initState() {
    super.initState();
    isSellerKey();
    _selectedIndex = widget.initialIndex;
    _widgetOptions = [
      const SellerDashboardScreen(),
      // https://citybazaronline.com/indore/store
       const Screen2(),
      const FollowerSellerScreen(myAppbar: true,),
      const MyProfileScreen(myappBar: true,),
    ];
  }



  final List<String> _appBarTitles = [
    "Home",
    "Store",
    "Following Shop",
    "Account"
  ];
  int _backPressCount = 0;

  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Define _scaffoldKey
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return
      WillPopScope(
        onWillPop: () async {
          if (_selectedIndex != 0) {
            // If not on index 0, navigate to index 0
            setState(() {
              _selectedIndex = 0;
            });
            return false;
          }
          else if (_backPressCount == 0) {
            // Show the exit confirmation dialog when on index 0
            showDialog(
              context: context,
              builder: (context) {
                return   AlertDialog(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  backgroundColor: ConstantColor.primaryBackgroundMainColor,
                  title: customeText(text: 'Please confirm!'),
                  content: customeText(text: "Are you sure you want to exit?"),
                  contentPadding: EdgeInsets.symmetric(horizontal: screenWidth / 30),
                  titlePadding: EdgeInsets.symmetric(horizontal: screenWidth / 30, vertical: screenHeight / 60),
                  actionsPadding: EdgeInsets.symmetric(horizontal: screenWidth / 30, vertical: screenHeight / 60),
                  actions:[
                    customButton(
                        elevation: 0,
                        backgroundColor: ConstantColor.primaryBackgroundMainColor,
                        onPressed: (){
                          Navigator.of(context).pop();
                          SystemNavigator.pop();},
                        text: "Yes",
                        textStyleButton: ConstantTextStyle.hintTextStyle2),
                    const SizedBox(width: 10.0,),
                    customButton(
                        elevation: 0,
                        backgroundColor: ConstantColor.primaryBackgroundMainColor,
                        onPressed: () =>Navigator.of(context).pop(),
                        text: "No",
                        textStyleButton: ConstantTextStyle.hintTextStyle2),
                  ],
                );

              },
            );
            return false;
          }
          else {
            _backPressCount = 0;
            return true;
          }
        },
        child: Scaffold(
          backgroundColor: ConstantColor.loginWithOtpButtonColor,
          body: SafeArea(
            child: Scaffold(
              backgroundColor: ConstantColor.primaryBackgroundMainColor,
              key: _scaffoldKey,
              appBar: AppBar(
                backgroundColor: ConstantColor.loginWithOtpButtonColor,
                elevation: 0.0,
                centerTitle: true,
                title:customeText(
                  text:  _appBarTitles[_selectedIndex],
                  style: ConstantTextStyle.landingScreenAppbarText,
                ),
                leading: IconButton(
                  icon: const Icon(Icons.menu), color: ConstantColor.primaryBackgroundMainColor,
                  onPressed: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                ),
                actions: [ Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth/20),
                    child:  GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/notificationScreen');
                      },
                      child:const badges.Badge(
                        badgeContent:  Text(''),
                        child:  Icon(Icons.notifications_none,color: ConstantColor.primaryBackgroundMainColor,),
                      ),
                    ))],
              ),
              drawer: const SellerDrawerScreen(),
              body: _widgetOptions[_selectedIndex],
              //----------------------------------------------------------------
              bottomNavigationBar: isSellerIn == 0 ? Container(): BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                    icon: getCustomIcon(0, Icons.home_outlined),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: getCustomIcon(1, Icons.storefront_outlined),
                    label: 'Store',
                  ),
                  BottomNavigationBarItem(
                    icon: getCustomIcon(2, Icons.store_mall_directory_outlined),
                    label: 'Following Shop',
                  ),
                  BottomNavigationBarItem(
                    icon: getCustomIcon(3, Icons.person_outline),
                    label: 'Account',
                  ),
                ],

                currentIndex: _selectedIndex,
                selectedFontSize : 12.0,
                unselectedFontSize :12.0,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: ConstantColor.primaryBackgroundMainColor,
                unselectedItemColor: ConstantColor.primaryGreyColor,
                backgroundColor: ConstantColor.loginWithOtpButtonColor,
                enableFeedback: false,
                useLegacyColorScheme: false,
                mouseCursor: SystemMouseCursors.click,
                onTap: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      );

  }

  Container getCustomIcon(int index, IconData iconData) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    Color iconColor;
    Color backgroundColor;

    switch (index) {
      case 0:
        iconColor = _selectedIndex == 0 ? ConstantColor.primaryMainColor : ConstantColor.primaryGreyColor;
        backgroundColor = _selectedIndex == 0 ? ConstantColor.primaryBackgroundMainColor : Colors.transparent;
        break;
      case 1:
        iconColor = _selectedIndex == 1 ? ConstantColor.primaryMainColor : ConstantColor.primaryGreyColor;
        backgroundColor = _selectedIndex == 1 ? ConstantColor.primaryBackgroundMainColor : Colors.transparent;
        break;
      case 2:
        iconColor = _selectedIndex == 2 ? ConstantColor.primaryMainColor : ConstantColor.primaryGreyColor;
        backgroundColor = _selectedIndex == 2 ? ConstantColor.primaryBackgroundMainColor : Colors.transparent;
        break;
      case 3:
        iconColor = _selectedIndex == 3 ? ConstantColor.primaryMainColor : ConstantColor.primaryGreyColor;
        backgroundColor = _selectedIndex == 3? ConstantColor.primaryBackgroundMainColor : Colors.transparent;
        break;
      default:
        iconColor = ConstantColor.primaryGreyColor;
        backgroundColor = Colors.transparent;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: backgroundColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: screenHeight/50, vertical: screenWidth/150),
      margin: EdgeInsets.symmetric( vertical: screenWidth/120),
      child: Icon(iconData, color: iconColor),
    );
  }
}



class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: const Center(
        child: Text('Screen 1'),
      ),
    );
  }
}

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  storeLink ({url}) async {await launch('$url');}

  String storeSlug = '';

  void isSellerSlug() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    setState(() {
      storeSlug = preference.getString("store_slug") ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    isSellerSlug();
  }


  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: customeText(text: 'Store screen')),

        // OutlinedButton.icon(
        FilledButton.icon(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(05.0),
            backgroundColor: MaterialStateProperty.all(ConstantColor.primaryMainColor),
          ),
            onPressed: () => storeLink(url: 'https://citybazaronline.com/indore/$storeSlug'),
            icon: const Icon(Icons.store_rounded), label:
        customeText(text: "View store")
        ),
      ],
    );
  }
}
//https://citybazaronline.com/indore/store













