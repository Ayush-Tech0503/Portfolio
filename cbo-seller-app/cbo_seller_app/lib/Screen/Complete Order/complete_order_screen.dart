// ignore_for_file: non_constant_identifier_names, deprecated_member_use, library_private_types_in_public_api

import 'package:citybazaronline_seller_app/Models/Complete%20Order%20Model/complete_order_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
// import 'package:skeletonizer/skeletonizer.dart';
import '../../Services/Complete Order Api Services/complete_order_api_services.dart';
import '../../Utils/Constant Size /constant_sizes.dart';
import '../../Widget/Custome Buttons/elevetion_button_widget.dart';
import '../../Widget/No Data Available/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../Layouts/constant_screen_layout.dart';
import '../../../../Utils/Font Style/text_styles.dart';
import '../../../../Utils/Theme/constant_colors.dart';
import '../../../../Widget/custome_text_widget.dart';
import '../../Widget/Scaffold Message/scaffold_message_widget.dart';
import '../../Widget/Text Form Fields/password_text_form.dart';
import '../../Widget/color_box_widget.dart';
import '../../Widget/refresh_footer_message.dart';

class CompleteOrderScreen extends StatefulWidget {
  const CompleteOrderScreen({super.key});

  @override
  State<CompleteOrderScreen> createState() => _CompleteOrderScreenState();
}

class _CompleteOrderScreenState extends State<CompleteOrderScreen> {

  @override
  void initState() {
    super.initState();
    fetchCompleteOrderListData();
  }

  final ScrollController _scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    _scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  bool isPullToRefreshEnabled = true;
  int currentPage = 1;
  var limit = '12';
  bool isLoading = false;
  bool isHashLoad = false;

  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  CompleteOrderListModel? completeOrderListModel;
  Totalcount? totalcount;
  List<CompleteOrderData>? data = [];


  dynamic userCount = '';
  dynamic totalDealAmount = '';
  dynamic totalPrice = '';
  dynamic cashBackWon = '';

  Future<void> fetchCompleteOrderListData() async {
    try {
      if (currentPage == 1) {
        setState(() {
          isLoading = true;
          data!.clear();
          completeOdDataList!.clear();
        });
      }

      final getCompleteOrderResponse = await CompleteOrderApiService.fetchCompleteOrderData(context: context,search: searchController.text.toString(),  page: currentPage, limit: limit.toString()??'12');

      if (getCompleteOrderResponse != null && getCompleteOrderResponse.data != null) {

        final dataList = getCompleteOrderResponse.data!;

        setState(() {
          for (var completeOdData in dataList) {
            Map<String, String> mapData = {
              'firstName': completeOdData.firstName??"",
              'mobile': completeOdData.mobile??"",
              'totalPrice': completeOdData.totalPrice ?? '',
              'productCount': completeOdData.productCount ?? '',
              'createdDate':  completeOdData.createdDate ?? '',
              'userId':  completeOdData.userId ?? '',
              'action': 'Delete',
            };

            completeOdDataList.add(mapData);
          }
        });


        final CompleteOrderListModel orderModel = getCompleteOrderResponse;

        setState(() {
          if (orderModel != null && orderModel.totalcount != null) {
            userCount = orderModel.totalcount!.userCount ?? '';
            totalDealAmount = orderModel.totalcount!.totlaDealAmount ?? '';
            totalPrice = orderModel.totalcount!.totalPrice ?? '';
            cashBackWon = orderModel.totalcount!.cashBackWon ?? '';
          } else {}
        });
        setState(() {
          if (currentPage == 1) {
            data = dataList;
          }
          else {
            data!.addAll(dataList);
            _refreshController.loadComplete();
          }

          isHashLoad = currentPage! > getCompleteOrderResponse.totalPages!;
          if (isHashLoad == true){
            LoadingScaffoldMessage.showSnackbar(
              context,
              "Oops!! No More Data Available...",
              ConstantColor.primaryMainColor,
              const Duration(seconds: 2),
            );
          }

          // if (currentPage! > getCompleteOrderResponse.totalPages!) {
          //   isPullToRefreshEnabled = false;
          //   isLoading = false;
          //   _refreshController.loadNoData();
          //   return; // Exit early to prevent unnecessary setState
          // }
          isLoading = false;
          currentPage++;
        });
      } else {
        // No more data available
        setState(() {
          isLoading = false;
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



  List<Map<String, String>> completeOdDataList = [];

  var createdDateKey = '';


  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return    AppLayout(
        title: "Your Complete Order",
        titleStyle: ConstantTextStyle.landingScreenAppbarText,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), color: ConstantColor.primaryBackgroundMainColor,
          onPressed: () => Navigator.pop(context),
        ),
        scaffoldColor: ConstantColor.primaryBackgroundMainColor,
        appBarColor: ConstantColor.loginWithOtpButtonColor,
        body: CupertinoScrollbar(
          child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: isHashLoad == false ? true: false,
              controller: _refreshController,
              footer: customFooter(),
              onRefresh: () async {
                searchController.clear();
                currentPage = 1;
                await fetchCompleteOrderListData();
               _refreshController.refreshCompleted();
              },
              onLoading: () async {
                await fetchCompleteOrderListData();
                // _refreshController.loadComplete();
                },

              child: data == null || data!.toString().isEmpty ? noDataFound(context):
        ListView(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: screenWidth/30,vertical: screenHeight/40),
                children: [
                  // customeText(text: "\tComplete Order",style: ConstantTextStyle.topCategoryText4),

                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [

                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: ConstantColor.calendarBGHeadColor,
                            ),
                            padding: EdgeInsets.symmetric( vertical: screenHeight/60),
                            margin: EdgeInsets.only(bottom: screenHeight/60),
                            child: Table(
                              columnWidths: {
                                0: FixedColumnWidth(screenWidth * 0.4), // Adjust column width as needed
                                1: FixedColumnWidth(screenWidth * 0.4),
                                2: FixedColumnWidth(screenWidth * 0.4),
                                3: FixedColumnWidth(screenWidth * 0.4),
                              },
                              children: [
                                TableRow(
                                  children: [
                                    TableCell(child: customeText(text: "Product Count", textAlign: TextAlign.center, style: ConstantTextStyle.tabButtonTextStyle)),
                                    TableCell(child: Text("Total Deal Amount", textAlign: TextAlign.start, style: ConstantTextStyle.tabButtonTextStyle)),
                                    TableCell(child: Text("Total Order Amount", textAlign: TextAlign.start, style: ConstantTextStyle.tabButtonTextStyle)),
                                    TableCell(child: Text("Cash Back Won", textAlign: TextAlign.start, style: ConstantTextStyle.tabButtonTextStyle)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Table(

                            columnWidths: {
                              0: FixedColumnWidth(screenWidth * 0.4),
                              1: FixedColumnWidth(screenWidth * 0.4),
                              2: FixedColumnWidth(screenWidth * 0.4),
                              3: FixedColumnWidth(screenWidth * 0.4),

                            },

                              children: [
                                TableRow(
                                  decoration: const BoxDecoration(
                                      border: Border(bottom: BorderSide(color: ConstantColor.textFieldColor),)),
                                  children: [
                                    TableCell(child: Container(
                                        margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0,horizontal: screenWidth / 10.0,),
                                        padding: EdgeInsets.symmetric(horizontal: screenWidth / 30.0,),
                                        child: customeText(text: userCount??"",textAlign: TextAlign.start,
                                            style:  ConstantTextStyle.allHomeScreenAvatarText))),
                                    TableCell(child: Container(
                                        margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0,),
                                        child: customeText(text: totalDealAmount??"", textAlign: TextAlign.start,
                                            style:  ConstantTextStyle.allHomeScreenAvatarText))),
                                    TableCell(child: Container(
                                        margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
                                        child: customeText(text:  totalPrice??"", textAlign: TextAlign.start,
                                            style:  ConstantTextStyle.allHomeScreenAvatarText))),
                                    TableCell(child: Container(
                                        margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
                                        child: customeText(text:  cashBackWon??"", textAlign: TextAlign.start,
                                            style:  ConstantTextStyle.allHomeScreenAvatarText))),

                                  ],
                                )
                              ]


                          )
                        ],
                      ),
                    ),
                  ),


                  constantHeight(context, 40.0),

                  customTextFormField(
                    filled: true,
                    autofocus: false,
                    onChanged: (value) {
                      setState(() {
                        value = searchController.text.toString();
                      });
                    },
                    formBorderRadius : const BorderRadius.all(Radius.circular(8.0)),
                    controller: searchController,
                    fillColor: ConstantColor.primaryBackgroundMainColor,
                    borderSideColor:ConstantColor.transparent1,
                    focusNode: null,
                    context: context,
                    iconButton: IconButton,
                    hintText: "Search",
                    cursorColor: ConstantColor.primaryMainColor,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (searchController.text.toString().isEmpty)?null:(value) async {
                      currentPage = 1;
                      isLoading = true;
                      data!.clear();
                      await  fetchCompleteOrderListData();
                    },
                    suffixIcon:
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth / 40,
                          vertical: screenHeight / 100),
                      child: customButton(
                        textStyleButton: ConstantTextStyle.otpResendButtonText,
                        onPressed: (searchController.text.toString().isEmpty)?null:() async {
                          currentPage = 1;
                          isLoading = true;
                          data!.clear();
                          await  fetchCompleteOrderListData();
                        },
                        text: searchController.text.toString().isEmpty ? "Search": "Click Me",
                        backgroundColor: ConstantColor.secondryBackgroundMainColor,
                        borderRadius: BorderRadius.circular(6.0),
                        elevation: 1.0,
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight/100.0),


                  ListView.builder(
                    // padding: EdgeInsets.symmetric(horizontal: screenWidth/30, vertical: screenHeight/40),
                    itemCount: completeOdDataList?.length ?? 0,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var data = completeOdDataList![index];
                      createdDateKey = DateFormat('dd MMMM yyyy', 'en_US').format(
                          DateTime.parse(data['createdDate']??"").add(const Duration(days: 365)));
                      return
                        GestureDetector(
                      onTap: () async => await Navigator.pushNamed(context, '/completeOrderViewScreen', arguments: data['userId']),
                          child:
                          Container(
                            // color: ConstantColor.primaryBackgroundMainColor,
                            margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
                            decoration: BoxDecoration(
                              color: ConstantColor.primaryBackgroundMainColor,
                              //isSelected ? Colors.grey :ConstantColor.primaryBackgroundMainColor,
                              border: Border.all(color: ConstantColor.secondtryGrayColor),
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow:const [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset:  Offset(0, 2),
                                  blurRadius: 4.0,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        customeText(text: 'User Name :-  ${data['firstName'] ?? ""}', style: ConstantTextStyle.allHomeScreenAvatarText),
                                        customeText(text:'User Mobile :-  ${data['mobile'] ?? ""}', style: ConstantTextStyle.allHomeScreenAvatarText),
                                        customeText(text:'Total Price :-  ${data['totalPrice'] ?? ""}', style: ConstantTextStyle.allHomeScreenAvatarText),
                                        customeText(text:'Date :-  ${createdDateKey ?? ""}', style: ConstantTextStyle.allHomeScreenAvatarText),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: screenWidth/40.0),
                                  // Product Details
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      colorBoxWidget(
                                        // margin: EdgeInsets.symmetric(vertical: screenHeight/100.0),
                                        textAlign: TextAlign.center,
                                        context:context,
                                        color: ConstantColor.calendarBGHeadColor,
                                        text: 'Product Count : ${data['productCount'].toString()??""}',
                                        style: ConstantTextStyle.tabButtonTextStyle,
                                      ),
                                      SizedBox(height: screenHeight/100.0),
                                      IconButton(
                                        tooltip: "View",
                                        style: IconButton.styleFrom(
                                            backgroundColor: ConstantColor.carColor,
                                            shape: const CircleBorder()
                                        ),
                                        onPressed: () async => await Navigator.pushNamed(context, '/completeOrderViewScreen', arguments: data['userId']),
                                        icon: const Icon(Icons.remove_red_eye_outlined,color: ConstantColor.primaryMainColor,),)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                    },
                  ),

                  // Skeletonizer(
                  //   enabled: isLoading,
                  //   child: SingleChildScrollView(
                  //     scrollDirection: Axis.vertical,
                  //     child: SingleChildScrollView(
                  //       controller: _scrollController,
                  //       scrollDirection: Axis.horizontal,
                  //       child: Column(
                  //         children: [
                  //
                  //           Container(
                  //             decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(8.0),
                  //               color: ConstantColor.calendarBGHeadColor,
                  //             ),
                  //             padding: EdgeInsets.symmetric( vertical: screenHeight/60),
                  //             margin: EdgeInsets.symmetric(vertical: screenHeight/60),
                  //             child: Table(
                  //               columnWidths: {
                  //                 0: FixedColumnWidth(screenWidth * 0.3), // Adjust column width as needed
                  //                 1: FixedColumnWidth(screenWidth * 0.3),
                  //                 2: FixedColumnWidth(screenWidth * 0.3),
                  //                 3: FixedColumnWidth(screenWidth * 0.3),
                  //                 4: FixedColumnWidth(screenWidth * 0.35),
                  //                 5: FixedColumnWidth(screenWidth * 0.35),
                  //                 6: FixedColumnWidth(screenWidth * 0.3),
                  //               },
                  //               children: [
                  //                 TableRow(
                  //                   children: [
                  //                     TableCell(child: customeText(text: "S.No.", textAlign: TextAlign.center, style: ConstantTextStyle.tabButtonTextStyle)),
                  //                     TableCell(child: Text("User Name", textAlign: TextAlign.start, style: ConstantTextStyle.tabButtonTextStyle)),
                  //                     TableCell(child: Text("User Mobile", textAlign: TextAlign.start, style: ConstantTextStyle.tabButtonTextStyle)),
                  //                     TableCell(child: Text("Total Price", textAlign: TextAlign.start, style: ConstantTextStyle.tabButtonTextStyle)),
                  //                     TableCell(child: Text("Product Count", textAlign: TextAlign.start, style: ConstantTextStyle.tabButtonTextStyle)),
                  //                     TableCell(child: Text("Date",  textAlign: TextAlign.start,style: ConstantTextStyle.tabButtonTextStyle)),
                  //                     TableCell(child: Text("Action",  textAlign: TextAlign.start,style: ConstantTextStyle.tabButtonTextStyle)),
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //           Table(
                  //             columnWidths: {
                  //               0: FixedColumnWidth(screenWidth * 0.2), // Adjust column width as needed
                  //               1: FixedColumnWidth(screenWidth * 0.3),
                  //               2: FixedColumnWidth(screenWidth * 0.3),
                  //               3: FixedColumnWidth(screenWidth * 0.3),
                  //               4: FixedColumnWidth(screenWidth * 0.3),
                  //               5: FixedColumnWidth(screenWidth * 0.3),
                  //               6: FixedColumnWidth(screenWidth * 0.3),
                  //             },
                  //
                  //             children: completeOdDataList!.map((data) {
                  //               createdDateKey = DateFormat('dd MMMM yyyy', 'en_US').format(
                  //                   DateTime.parse(data['createdDate']??"").add(const Duration(days: 365)));
                  //               return TableRow(
                  //                 decoration: const BoxDecoration(
                  //                     border: Border(bottom: BorderSide(color: ConstantColor.textFieldColor),)),
                  //                 children: [
                  //                   TableCell(child: Container(
                  //                       margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0,),
                  //                       child: customeText(text: (completeOdDataList.indexOf(data) + 1).toString(),textAlign: TextAlign.start,
                  //                           style:  ConstantTextStyle.allHomeScreenAvatarText))
                  //                   ),
                  //                   TableCell(child: Container(
                  //                       margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0,),
                  //                       child: customeText(text: data['firstName'] ?? "", textAlign: TextAlign.start,
                  //                           style:  ConstantTextStyle.allHomeScreenAvatarText))
                  //                   ),
                  //                   TableCell(child: Container(
                  //                       margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
                  //                       child: customeText(text: data['mobile'] ?? "", textAlign: TextAlign.start,
                  //                           style:  ConstantTextStyle.allHomeScreenAvatarText))
                  //                   ),
                  //                   TableCell(child: Container(
                  //                       margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
                  //                       child: customeText(text: data['totalPrice'] ?? "", textAlign: TextAlign.start,
                  //                           style:  ConstantTextStyle.allHomeScreenAvatarText))
                  //                   ),
                  //                   TableCell(child: Container(
                  //                       margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
                  //                       child: customeText(text: data['productCount'] ?? "", textAlign: TextAlign.start,
                  //                           style:  ConstantTextStyle.allHomeScreenAvatarText))
                  //                   ),
                  //                   TableCell(child: Container(
                  //                       margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
                  //                       child: customeText(text: createdDateKey ?? "", textAlign: TextAlign.start,
                  //                           style:  ConstantTextStyle.allHomeScreenAvatarText))
                  //                   ),
                  //
                  //                   TableCell(child: IconButton(onPressed: () {
                  //                    Navigator.pushNamed(context, '/completeOrderViewScreen', arguments: data['userId']);
                  //                   }, icon: const Card(child: Icon(Icons.remove_red_eye_outlined,color: ConstantColor.primaryMainColor,)),)),
                  //
                  //                 ],
                  //               );
                  //             }).toList() ?? [],
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              )
          ),
        )
    );

  }
}










