// ignore_for_file: camel_case_types

import 'package:citybazaronline_seller_app/Utils/Constant%20Size%20/constant_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../Layouts/constant_screen_layout.dart';
import '../Models/FAQs Model/faqs_model.dart';
import '../Services/faq_api_services.dart';
import '../Utils/Font Style/text_styles.dart';
import '../Utils/Theme/constant_colors.dart';
import '../Widget/No Data Available/no_data_found.dart';
import '../Widget/custome_text_widget.dart';
import '../Widget/faq_expansion_tile_widget.dart';
import '../Widget/refresh_footer_message.dart';

class SellerFAQScreen extends StatefulWidget {
  const SellerFAQScreen({super.key});

  @override
  State<SellerFAQScreen> createState() => _sellerFAQScreenState();
}


class _sellerFAQScreenState extends State<SellerFAQScreen> {

  @override
  void initState() {
    super.initState();
    fetchFAQSListData();
  }
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool isPullToRefreshEnabled = true;
  int currentPage = 1;
  bool isLoading = false;

  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  SellerFAQModel? notificationModels;
  List<Data>? data = [];
  Future<void> fetchFAQSListData() async {
    try {
      if (currentPage == 1) {
        setState(() {
          isLoading = true;
          data!.clear();
        });
      }

      final faqsResponse = await ApiService.fetchFAQsData(context: context);

      if (faqsResponse != null && faqsResponse.data != null) {
        final dataList = faqsResponse.data!;

        setState(() {
          if (currentPage == 1) {
            data = dataList;
          } else {
            data!.addAll(dataList);
            _refreshController.loadComplete();
          }

          isLoading = !isLoading;
          currentPage++;

        });
      } else {
        // No more data available
        setState(() {
          isLoading = !isLoading;
          _refreshController.loadNoData();
          isPullToRefreshEnabled = false; // Disable pull-to-refresh
        });
      }
    } catch (e) {
      setState(() {
        _refreshController.loadNoData();
        isLoading = false;
      });
    }
  }


  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return  AppLayout(
      title: "FAQs",
      titleStyle: ConstantTextStyle.landingScreenAppbarText,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back), color: ConstantColor.primaryBackgroundMainColor,
        onPressed: () => Navigator.pop(context),
      ),
      scaffoldColor: ConstantColor.primaryBackgroundMainColor,
      appBarColor: ConstantColor.loginWithOtpButtonColor,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
         : CupertinoScrollbar(
        controller: _scrollController,
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          controller: _refreshController,
          footer: customFooter(),
          onRefresh: () async {
            currentPage = 1;
            await fetchFAQSListData();
            _refreshController.refreshCompleted();
          },
          // onLoading: () async {
          //   await fetchFAQSListData();
          // },
            //
          child:ListView(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(horizontal: screenWidth/30,vertical: screenHeight/60),
            children: [
              customeText(text: "\tHelp Topics",style: ConstantTextStyle.topCategoryText4),
              constantHeight(context, 80.0),
              (data != null && data!.isNotEmpty && data!.toString().isNotEmpty)
             ? AnimationLimiter(
               child: ListView.builder(
                  controller: _scrollController,
                  physics: const ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: data!.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    var faqsData = data![index];
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      columnCount: 2,
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                          child: Card(
                            elevation: 0.5,
                            margin: EdgeInsets.symmetric(vertical: screenHeight / 150),
                            child: faqExpansionTile(
                              backgroundColor: ConstantColor.circleAvatar2,
                              collapsedBackgroundColor: ConstantColor.secondoryCardeColors,
                              collapsedShapeBoarder: BorderRadius.circular(10.0),
                              headText: faqsData!.question.toString()??'',
                              headStyle: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal),
                              subText: faqsData!.answer.toString()??'',
                              subTextContainerBoarder: BorderRadius.circular(10.0),
                              subTextContainerColor: ConstantColor.secondoryCardeColors,
                              onExpansionChanged: (value) {
                                setState(() {
                                  isExpanded = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
             ): noDataFound(context),
            ],
          )
        ),
      )
    );
  }
}

