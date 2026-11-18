import 'package:flutter/material.dart';
import '../../../Util/constaint_textstyle.dart';
import '../../../Util/constant_color.dart';
import '../../../Widgets/custome_text.dart';
import 'Order Tab/order_tab_screen.dart';
class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});
  @override
  State<FAQScreen> createState() => _FAQScreenState();
}
class _FAQScreenState extends State<FAQScreen>
    with TickerProviderStateMixin {
  String location = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late TabController _tabController;
  bool isExpanded = false;
  bool isTextColor = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: ConstantColor.loginWithOtpButtonColor,
      child: SafeArea(
        child: Scaffold(
/*--------------------------------------appbar section start-------------------------------------*/
          key: _scaffoldKey,
          appBar: AppBar(
            elevation: 1,
            backgroundColor: ConstantColor.primaryBackgroundMainColor,
            iconTheme: const IconThemeData(color: ConstantColor.loginWithOtpButtonColor),
            title: customeText(textAlign: TextAlign.start,
                text: "FAQ", style: ConstantTextStyle.secodHearText),
          ),
/*--------------------------------------appbar section end-------------------------------------*/
          body:  Container(
            color: ConstantColor.primaryBackgroundMainColor,
            padding: EdgeInsets.symmetric(vertical: screenHeight/50, horizontal: screenWidth/40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customeText(
                  text: "User FAQs",
                  style: ConstantTextStyle.secodHearText,),
                SizedBox(height: screenHeight/80,),
                const Expanded(
                  child: DefaultTabController(
                    length: 1,
                    child: Column(
                      children: [
                        // ButtonsTabBar(
                        //   // contentPadding: EdgeInsets.symmetric(horizontal: screenWidth/60),
                        //   // backgroundColor: ConstantColor.homeScreenAvatarBGColor ,
                        //   // unselectedBackgroundColor: ConstantColor.primaryBackgroundMainColor,
                        //   // unselectedLabelStyle: ConstantTextStyle.imageColorTextStyle,
                        //   // labelStyle: ConstantTextStyle.tabButtonTextStyle,
                        //   tabs: const [
                        //     Tab(text: "Order",),
                        //     // Tab(text: "Payments",),
                        //     // Tab(text: "Returns and Cancelling",),
                        //     // Tab(text: "Wallet",),
                        //   ],
                        // ),
                        Expanded(
                          child: TabBarView(
                            children: [
                    /*-----------------------------------1St Tab Order Tab Start------------------------------------------*/
                              OrderTabScreen(),
                    /*-----------------------------------1St Tab Order Tab end------------------------------------------*/
                    /*-----------------------------------2nd Tab  start------------------------------------------*/
                           //   Center(child:  Text("Tab 2"),),
                    /*-----------------------------------2nd Tab  end------------------------------------------*/
                    /*-----------------------------------3rd Tab  start------------------------------------------*/
                            //  Center(child:  Text("Tab 3"),),
                    /*-----------------------------------3rd Tab  end------------------------------------------*/
                    /*-----------------------------------4th Tab  start------------------------------------------*/
                            //  Center(child:  Text("Tab 3"),),
                    /*-----------------------------------4th Tab  end------------------------------------------*/
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
