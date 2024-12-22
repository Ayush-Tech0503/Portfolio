// ignore_for_file: non_constant_identifier_names, deprecated_member_use, library_private_types_in_public_api

import 'package:citybazaronline_seller_app/Services/Order%20Listing%20%20Api/order_listing_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../../Models/Pending Order Model/get_pending_order_model.dart';
import '../../Models/order_listing_model/order_listing_model.dart';
import '../../Services/Pending Order Api Services/pending_order_api_services.dart';
import '../../Widget/Custome Buttons/elevetion_button_widget.dart';
import '../../Widget/No Data Available/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../Layouts/constant_screen_layout.dart';
import '../../../../Utils/Font Style/text_styles.dart';
import '../../../../Utils/Theme/constant_colors.dart';
import '../../../../Widget/custome_text_widget.dart';
import '../../Widget/Scaffold Message/scaffold_message_widget.dart';
import '../../Widget/Status Chip Object Color /status_chip_bg_color_widget.dart';
import '../../Widget/Text Form Fields/password_text_form.dart';
import '../../Widget/color_box_widget.dart';
import '../../Widget/refresh_footer_message.dart';

class PendingOrderScreen extends StatefulWidget {
  const PendingOrderScreen({super.key});

  @override
  State<PendingOrderScreen> createState() => _PendingOrderScreenState();
}

class _PendingOrderScreenState extends State<PendingOrderScreen> {

  @override
  void initState() {
    super.initState();
    fetchPendingOrderListData();
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
  bool isLoading = false;
  bool isHashLoad = false;
  double totalPrice = 0.0;

  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  // PendingOrderModel? pendingOrderModel;
  // List<PendingOrderData>? data = [];


  List<OderListingData>? data = [];


  Future<void> fetchPendingOrderListData() async {
    try {
      if (currentPage == 1) {
        setState(() {
          isLoading = true;
          data!.clear();
          pendingDataList!.clear();
        });
      }

      final gePendingOrderResponse = await OrderListingApiService.orderListingData(context: context, keyId : "seller_id");

      if (gePendingOrderResponse != null && gePendingOrderResponse.data != null) {
        final dataList = gePendingOrderResponse.data!;

        setState(() {
          for (var pendingData in dataList) {
            double totalPrice = 0.0; // Initialize totalPrice for each order
            if (pendingData.product != null) {
              for (var item in pendingData.product!) {
                // Use offerPrice if it's valid, otherwise use price
                double price = double.tryParse(item.offerPrice ?? '0.0') ?? 0.0;
                if (item.offerPrice == '0.00' || item.offerPrice!.isEmpty ?? true) {
                  price = double.tryParse(item.price ?? '0.0') ?? 0.0;
                }
                totalPrice += price;
              }
            }

            Map<String, String> mapData = {
              'firstName': pendingData.userName ?? "",
              'mobile': pendingData.userMobile ?? "",
              'totalPrice': totalPrice.toStringAsFixed(2), // Convert to string with 2 decimal places
              'productCount': (pendingData.product?.length ?? 0).toString(), // Count of products
              'createdDate': pendingData.insertDate ?? '', // Use insertDate for createdDate
              'userId': pendingData.userId ?? "",
              'status': pendingData.statusText ?? "",
              'order_id': pendingData.orderId ?? "",
              'action': 'Delete',
            };

            pendingDataList.add(mapData);
          }

          data!.addAll(dataList);
          _refreshController.loadComplete();
          isLoading = false;
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



  List<Map<String, String>> pendingDataList = [];

  var createdDateKey = '';


  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return  WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, '/bottomNavigationBarScreen', (route) => false,);
        return false; // Prevent default back navigation
      },
      child: AppLayout(
          title: "Your Orders",
          titleStyle: ConstantTextStyle.landingScreenAppbarText,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back), color: ConstantColor.primaryBackgroundMainColor,
            onPressed: () => Navigator.pop(context),
          ),
          scaffoldColor: ConstantColor.primaryBackgroundMainColor,
          appBarColor: ConstantColor.loginWithOtpButtonColor,
          body: CupertinoScrollbar(
            child: data == null || data!.toString().isEmpty ? noDataFound(context):
            isLoading ? const Center(child: CircularProgressIndicator()):
            ListView(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: screenWidth/30,vertical: screenHeight/40),
              children: [
                ListView.builder(
                  // padding: EdgeInsets.symmetric(horizontal: screenWidth/30, vertical: screenHeight/40),
                  itemCount: pendingDataList?.length ?? 0,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var data = pendingDataList![index];
                    createdDateKey = DateFormat('dd MMMM yyyy', 'en_US').format(
                        DateTime.parse(data['createdDate']??"").add(const Duration(days: 365)));
                    return
                      GestureDetector(
                        onDoubleTap: () {},
                        //async => await Navigator.push(context,MaterialPageRoute(builder: (context) => ViewProductScreen(productId: data['productIDs'].toString()??"")),),

                        child:
                        InkWell(onTap: () =>  Navigator.pushNamed(context, '/pendingBookedOrderScreen',  arguments: data['order_id']),
                          child: Container(
                            // color: ConstantColor.primaryBackgroundMainColor,
                            margin: EdgeInsets.symmetric(vertical: screenHeight / 60.0),
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
                                        Row(
                                          children: [
                                            customeText(text:'Status :-  ', style: ConstantTextStyle.allHomeScreenAvatarText),
                                            Container(
                                              margin: EdgeInsets.symmetric(vertical: screenHeight/100.0),
                                              decoration: BoxDecoration(color: getStatusColor(data['status'].toString().toUpperCase()?? ''), borderRadius: BorderRadius.circular(5.0)),
                                              child: Center(child: Text('   ${data['status'].toString()??""}   ', style: ConstantTextStyle.chipText)),
                                            ),
                                          ],
                                        ),
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
                                onPressed: () async => await Navigator.pushNamed(context, '/pendingBookedOrderScreen',
                                    arguments: data['order_id']),
                                  // arguments: data['userId']),
                            icon: const Icon(Icons.remove_red_eye_outlined,color: ConstantColor.primaryMainColor,),)
                                    ],
                                  ),
                                ],
                              ),
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
                //             children: pendingDataList!.map((data) {
                //               createdDateKey = DateFormat('dd MMMM yyyy', 'en_US').format(
                //                   DateTime.parse(data['createdDate']??"").add(const Duration(days: 365)));
                //               return TableRow(
                //                 decoration: const BoxDecoration(
                //                     border: Border(bottom: BorderSide(color: ConstantColor.textFieldColor),)),
                //                 children: [
                //                   TableCell(child: Container(
                //                       margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0,),
                //                       child: customeText(text: (pendingDataList.indexOf(data) + 1).toString(),textAlign: TextAlign.start,
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
                //                     Navigator.pushNamed(context, '/pendingBookedOrderScreen', arguments: data['userId']);
                //                   }, icon: const Card(child: Icon(Icons.remove_red_eye_outlined,color: ConstantColor.primaryMainColor,)),)),
                //
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
            ),
          )
      ),
    );
  }
}







