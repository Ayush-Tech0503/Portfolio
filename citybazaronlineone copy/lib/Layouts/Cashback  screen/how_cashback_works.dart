
// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:Citybazar_app/Util/constaint_textstyle.dart';
import 'package:Citybazar_app/Widgets/custome_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/Cash Back Models/cash_back_store.dart';
import '../../Util/Constant APi Url/api_urls.dart';
import '../../Util/constant_color.dart';
import '../../Util/constant_token.dart';
import '../../Widgets/custome_richtext.dart';

class HowCashbackWork extends StatefulWidget {
  const HowCashbackWork({super.key});

  @override
  State<HowCashbackWork> createState() => _HowCashbackWorkState();
}

class _HowCashbackWorkState extends State<HowCashbackWork> {

  final List dataList = [
    {'icon': Icons.search, 'title': 'Step 1', 'trailing': 'Search a product you want to purchase'},
    {'icon': Icons.book_outlined, 'title': 'Step 2', 'trailing': 'Book the selected product'},
    {'icon': Icons.storefront_outlined, 'title': 'Step 3', 'trailing': 'Purchase selected from seller'},
    {'icon': Icons.call_outlined, 'title': 'Step 4', 'trailing': 'Ask the seller to confirm the purchase'},
    {'icon': Icons.money_outlined, 'title': 'Step 5', 'trailing': 'After the confirmation from seller you will get cashback'
        'in your citybazaronline wallet '},
    {'icon': Icons.account_balance_wallet_outlined, 'title': 'Step 6', 'trailing': 'You can redeem it into bank'
        'account by providing your UPI'},
  ];
  var usersId;

  @override
  void initState() {
    super.initState();
    fetchAllCashBackList();
  }

//-----------------------api data start -----------------------
  CashBacks? cashBackStoreData;
  List<TermsAndCondition> cashBackWork=[];
  bool isLoading = false;
  fetchAllCashBackList() async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      usersId = preference.getString("userId");
      setState(() {
        isLoading = true;
      });
      final body = {"user_id":usersId,"lat":"22.6616282","long":"75.8910446","city":"Indore"};
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.cashBackStoreEndPoint}",
        options: Options(
          headers: {
            "Authorization": ConstantToken.authorizationToken,
            'Content-Type': 'application/json',
          },
        ),
        data: json.encode(body),
      );
      if (response.statusCode == 200) {
        var responseData = json.decode(response.data.toString());
        cashBackStoreData = CashBacks.fromJson(responseData);

        setState(() {
          cashBackWork.addAll(cashBackStoreData!.termsAndCondition?? []);
        });
      }
      else {
        // Print the productDetailsDataList after parsing
      }
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to fetch data $error');
    }
  }
//-----------------------api data End -----------------------

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: ConstantColor.loginWithOtpButtonColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            // automaticallyImplyLeading: false,
            backgroundColor: ConstantColor.primaryBackgroundMainColor,
            centerTitle: true,
            iconTheme: const IconThemeData(
                color: ConstantColor.loginWithOtpButtonColor
            ),
            //   backgroundColor: ConstantColor.primaryBackgroundMainColor,
            elevation: 0.0,
            title: Text("Help",
              style: ConstantTextStyle.topCategoryText2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          extendBody: true,

/*----------------------------------Body area---------------------------------------------*/
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight/80,horizontal: screenWidth/40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemExtent: screenHeight/15,
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
                      final item = dataList[index];
                      return Container(
                        margin:  EdgeInsets.symmetric(vertical: screenHeight/200),
                        padding: EdgeInsets.symmetric(horizontal: screenWidth/80),
                        decoration: BoxDecoration(
                          color: ConstantColor.primaryBackgroundMainColor,
                          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(
                            color : ConstantColor.carColor2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(item['icon'] as IconData,color: ConstantColor.primaryMainColor,),
                            SizedBox(width: screenWidth/20,),
                            Text(item['title']!,style: ConstantTextStyle.allHomeScreenAvatarText,),
                            SizedBox(width: screenWidth/20,),
                            Flexible(child: Text(item['trailing']!)),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: screenHeight/50,),
                  isLoading
                      ? const SpinKitCircle(
                    color: ConstantColor.primaryMainColor,
                    size: 30.0,
                  ): cashBackWork.isNotEmpty
                      ? ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cashBackWork.length,
                          itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customeText(
                              textAlign: TextAlign.start,
                                text: cashBackWork[index].title??"".toUpperCase(),
                            style: ConstantTextStyle.secodHearText2,
                            ),
                            SizedBox(height: screenHeight/80,),
                            customeText(
                              textAlign: TextAlign.start,
                              text: cashBackWork[index].descripation??"",
                              style: ConstantTextStyle.allHomeScreenAvatarText,
                            ),
                          ],
                        );
                      }):Center(child: customeText(
                      textAlign: TextAlign.center,
                      text:'No Data Available')),

                  SizedBox(height: screenHeight/50,),

              customRichText(
                  text1: "Didn't find what you are looking for ?".toUpperCase(),
                  style1: ConstantTextStyle.secodHearText1,
                  TextAlign: TextAlign.center,
                  text2: "Contact Us",
                  style2: ConstantTextStyle.secodHearText1,
              ),
              SizedBox(height: screenWidth/20,),
              Center(
                child: customRichText(
                  text1: "Call Us: 180088-92780\n".toUpperCase(),
                  style1: ConstantTextStyle.secodHearText1,
                  TextAlign: TextAlign.center,
                  text2: "Write Us: contact@citybazaronline.com",
                ),
                ),

                ],
              ),
            ),
          ),


          // SingleChildScrollView(
          //        padding: EdgeInsets.symmetric(horizontal: screenWidth/40,),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //
          //
          //
          //
          //
          //
          //
          //       customeText(
          //         text: "terms and conditions".toUpperCase(),
          //         style: ConstantTextStyle.secodHearText2,
          //         textAlign: TextAlign.start,
          //       ),
          //             SizedBox(
          //               height: screenWidth/50,
          //             ),
          //       customeText(
          //         text: "1. user will get cashback only when he/she will buy product from seller and seller confirm the sale.\n"
          //             "2. minimum amount for the cashback will be either 2% of purchase or ?10 which one is higher.\n"
          //             "3. maximum purchase amount of ?2500.00 will be considered for calculation of cashback. irrespective of actual purchase amount.\n"
          //             "3. a user can get cashback only once in a 15 days on purchase from a particular seller. he/she can get cashback on purchase from different seller.\n"
          //             "4. seller can not get cashback on purchase from his/ her own store.\n"
          //             "5. cashback amount will be transferred to UPI id only. 6. this scheme is available in India only.\n"
          //             "7. user can redeem cashback through application only. the application is available on google play store.\n"
          //             "8. in case of dispute the final decision will be of board of directors of CB BUSINESS SOLUTION PVT LTD and"
          //             "it will be binding on all.\n"
          //             "9. this scheme is subject to change any time without notice.\n".toUpperCase(),
          //         style: ConstantTextStyle.allHomeScreenAvatarText,
          //         textAlign: TextAlign.start,
          //       ),
          //
          //       customRichText(
          //         text1: "Didn't find what you are looking for ?".toUpperCase(),
          //         style1: ConstantTextStyle.secodHearText1,
          //           TextAlign: TextAlign.center,
          //         text2: "Contact Us"
          //       ),
          //       SizedBox(
          //         height: screenWidth/10,
          //       ),
          //       Center(
          //         child: customRichText(
          //             text1: "Call Us: 11111111\n".toUpperCase(),
          //             style1: ConstantTextStyle.secodHearText1,
          //             TextAlign: TextAlign.center,
          //             text2: "Write Us: example@doiman.com",
          //         ),
          //       ),
          //
          //     ],
          //   ),
          //
          // ),
        ),
      ),
    );
  }
}
