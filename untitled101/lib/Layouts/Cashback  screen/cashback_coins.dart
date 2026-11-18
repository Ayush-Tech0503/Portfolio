
import 'package:Citybazar_app/Layouts/Cashback%20%20screen/payout_reedem_now.dart';
import 'package:Citybazar_app/Util/constaint_textstyle.dart';
import 'package:Citybazar_app/Util/constant_color.dart';
import 'package:Citybazar_app/Widgets/custome_button_.dart';
import 'package:Citybazar_app/Widgets/custome_richtext.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Widgets/custome_card.dart';
import '../../Widgets/custome_text.dart';

class CashbackCoins extends StatefulWidget {
  const CashbackCoins({super.key});

  @override
  State<CashbackCoins> createState() => _HowCashbackWorkState();
}

class _HowCashbackWorkState extends State<CashbackCoins> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: ConstantColor.primaryMainColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ConstantColor.primaryMainColor,
            elevation: 0.0,
            title: Text(
              'Cashback Coins',
              style: ConstantTextStyle.topCategoryText3,
              overflow: TextOverflow.ellipsis,
            ),
            titleSpacing: 0.0,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: screenWidth / 10),
                child: Container(),
              ),
            ],
          ),
          extendBody: true,

/*----------------------------------Body area---------------------------------------------*/
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
/*-----------------------------------------------------------------------------------*/

                gradientColors(
                  containerHeight: screenHeight/4,
                  containerWidth: double.infinity,
                  widget:  Padding(
                    padding:  EdgeInsets.only(bottom: screenHeight/20),
                    child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              customRichText(
                                text1: NumberFormat.simpleCurrency(
                    locale: "hi-NI", decimalDigits: 2)
                        .format(500),
                                style1: ConstantTextStyle.cashbackCoinsText,
                                TextAlign: TextAlign.center,
                                text2: "\nBalance",
                                style2: ConstantTextStyle.secodHearText1,
                              ),
                              customeButton(
                                  elevation: 0.5,
                                  textStyleButton:
                                  ConstantTextStyle.redeemButtonTextStyle,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const PayoutScreen()),
                                    );
                                  },
                                  text: "Redeem Now",
                                  backgroundColor: ConstantColor.searchBoxColor,
                                  borderRadius: BorderRadius.circular(8.0),
                                  minimumSize: Size(
                                      screenWidth / 3,
                                      screenHeight / 25.0)
                              ),
                            ],
                          ),
                  ),
                   //   ),
                ),

/*-----------------------------------------------------------------------------------*/
                SizedBox(
                  height: screenWidth / 30,
                ),
                 Padding(
                   padding: EdgeInsets.only(left: screenWidth/30),
                   child: customRichText(
                      text1: "History",
                      style1: ConstantTextStyle.secodHearText1,
                      TextAlign: TextAlign.start,
                    ),
                 ),


/*-----------------------------------------------------------------------------------*/
                Center(
                  child: customeText(
                    text: "terms and conditions".toUpperCase(),
                    style: ConstantTextStyle.secodHearText1,
                    textAlign: TextAlign.center,
                  ),
                ),

/*-----------------------------------------------------------------------------------*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
