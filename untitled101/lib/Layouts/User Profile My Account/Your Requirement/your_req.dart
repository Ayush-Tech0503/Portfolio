import 'package:flutter/material.dart';
import '../../../Util/constaint_textstyle.dart';
import '../../../Util/constant_color.dart';
import '../../../Widgets/custome_text.dart';
import '../../Product View Screens/No product Found/no_product_found.dart';

class YourRequirementScreen extends StatefulWidget {

  const YourRequirementScreen({super.key,});

  @override
  State<YourRequirementScreen> createState() => _YourRequirementScreenState();
}

class _YourRequirementScreenState extends State<YourRequirementScreen> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      color: ConstantColor.loginWithOtpButtonColor,
      child: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: ConstantColor.primaryBackgroundMainColor,
            appBar: AppBar(
              // titleSpacing: 0.0,
              elevation: 0,
              backgroundColor: ConstantColor.primaryBackgroundMainColor,
              iconTheme: const IconThemeData(color: ConstantColor.loginWithOtpButtonColor),
              title: customeText(textAlign: TextAlign.start,
                  text: "Your Requirements", style: ConstantTextStyle.secodHearText),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(AppBar().preferredSize.height),
                child: Container(
                  // height: screenHeight/18,
                  padding:  EdgeInsets.symmetric(horizontal: screenWidth/30,),
                  child: Container(
                    height: screenHeight/22,
                    decoration: BoxDecoration(
                      border: Border.all(color: ConstantColor.loginWithOtpButtonColor,
                      width: 0.2),
                      borderRadius: BorderRadius.circular(10,),
                      color: Colors.grey[200],
                    ),
                    child: TabBar(
                      labelColor: Colors.white,
                      labelStyle: ConstantTextStyle.reviewsRatingsText,
                      unselectedLabelColor: ConstantColor.loginWithOtpButtonColor,
                      unselectedLabelStyle: ConstantTextStyle.ratingText2,
                      indicator: BoxDecoration(borderRadius: BorderRadius.circular(10,),
                        color:ConstantColor.primaryMainColor,
                      ),
                      tabs: const [
                        Tab(
                          text: 'OPEN',
                        ),
                        Tab(
                          text: 'CLOSED',
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body:   TabBarView(
              children: [
                  Center(
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: screenWidth/20.0),
                      child: const NoProductDataFound(
                      messageText: "Provide us with your requirements by clicking "
                              "the \"POST YOUR REQUIREMENTS\" buttons bellow we will do us utmost to deliver the best possible results for you."),
                    ),
                  ),

                 const Center(
                  child: Text(
                    'Closed',
                    style: TextStyle(
                      fontSize: 30,
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