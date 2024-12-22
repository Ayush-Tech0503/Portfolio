// ignore_for_file: camel_case_types

import 'package:citybazaronline_seller_app/Utils/Constant%20Size%20/constant_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../Models/order_listing_model/cancel_order_api.dart';
import '../../Models/order_listing_model/order_listing_model.dart';
import '../../Services/Order Listing  Api/order_listing_api.dart';
import '../../Services/Seller Forms Api Services/Seller Form Submit Api Services/step_1st_form_submit_api.dart';
import '../../Utils/Constant Api Routs/constant_api_routs.dart';
import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';
import '../../Widget/Alert Dialogs/alert_dialog_widget.dart';
import '../../Widget/Custome Buttons/elevetion_button_widget.dart';
import '../../Widget/No Data Available/no_data_found.dart';
import '../../Widget/Status Chip Object Color /status_chip_bg_color_widget.dart';
import '../../Widget/color_box_widget.dart';
import '../../Widget/custome_text_widget.dart';
import '../../Widget/images/cached_images_widget.dart';

class PendingBookedOrderScreen extends StatefulWidget {
  const PendingBookedOrderScreen({super.key});

  @override
  State<PendingBookedOrderScreen> createState() => _PendingBookedOrderScreenState();
}


class _PendingBookedOrderScreenState extends State<PendingBookedOrderScreen> {

  late String productOrderId;
  String? orderStatus;
   String?  orderStatusText;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // Retrieve productOrderId from arguments after the widget has fully initialized
  //   productOrderId = ModalRoute.of(context)!.settings.arguments as String;
  //   fetchPendingOrderViewData(productOrderId); // Pass productOrderId to fetch function
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      productOrderId = ModalRoute.of(context)!.settings.arguments as String;
      fetchPendingOrderViewData(productOrderId);
    });
  }

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _finalDealPriceController = TextEditingController();


  String? _finalDealPriceError;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool isPullToRefreshEnabled = true;
  int currentPage = 1;
  var limit = '100000';
  bool isLoading = false;

  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  // PendingOrderViewModel? pendingOrderViewModel;


  double totalPrice = 0.0;


  List<OderListingData>? data = [];


  Future<void> fetchPendingOrderViewData(productOrderId) async {
    try {
      if (currentPage == 1) {
        setState(() {
          isLoading = true;
          data!.clear();
          totalPrice = 0.0;
        });
      }

      final gePendingOrderResponse = await OrderListingApiService.orderListingData(context: context, keyId : "order_id", orderId: productOrderId??"");

      if (gePendingOrderResponse != null && gePendingOrderResponse.data != null) {
        final dataList = gePendingOrderResponse.data!;

        setState(() {
          for (var pendingData in dataList) {
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
          }
          orderStatusText = dataList![0].statusText??"";
          orderStatus = dataList![0].orderStatus??"";
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


  dynamic interestId = '';
  dynamic cardStatus = '';
  void _handleCardSubmit() {
      fetchSellerRegistrationBodyApi(
        context: context,
        baseUrl: '${ConstantUrls.baseUriApi}${ConstantUrls.updateCardProductEndPoint}',
        body: {"interest_id": interestId.toString()??"", "cart_status": cardStatus == 'Remove' ? 1 : 0},
        onSuccess: () {},
      );
  }


  bool isExpanded = false;
  var createdDateKey = '';
  final _formKey = GlobalKey<FormState>();

//------------------------------------
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ConstantColor.primaryBackgroundMainColor,
      bottomNavigationBar:
      Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth/30.0),
        child: (orderStatus == "0" && orderStatusText == "Pending") ?
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
            child: customButton(
              textStyleButton: ConstantTextStyle.landingScreenAppbarText,
              onPressed: () async => await YesNoPermissionDialog.showExitConfirmationDialog(
                context:context,
                title: 'Please Confirm!',
                content: 'Are you sure want to cancel order?',
                actions: [
                  customButton(
                    textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                    onPressed:() async => await OrderStatusApi.cancelOrder(context: context, orderId: productOrderId, status: "2"),
                    text: "Yes",
                    backgroundColor: ConstantColor.loginWithOtpButtonColor,
                    borderRadius: BorderRadius.circular(20.0),
                    elevation: 0.0,
                  ),
                  constantWidth(context, 100.0),
                  customButton(
                    textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                    onPressed:() => Navigator.pop(context),
                    text: "No",
                    backgroundColor: ConstantColor.primaryMainColor,
                    borderRadius: BorderRadius.circular(20.0),
                    elevation: 0.0,
                  ),
                ],
              ),
              text: "Cancel order",
              backgroundColor: ConstantColor.primaryMainColor,
              borderRadius: BorderRadius.circular(6.0),
              elevation: 0.0,
              minimumSize: Size(screenWidth, screenHeight / 25.0),
            ),
          ),
          SizedBox(width: screenWidth/30.0),
          Flexible(
            child: customButton(
              textStyleButton: ConstantTextStyle.landingScreenAppbarText,
              onPressed: () async => await YesNoPermissionDialog.showExitConfirmationDialog(
            context:context,
            title: 'Please Confirm!',
            content: 'Are you sure want to confirm order?',
            actions: [
              customButton(
                textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                onPressed:() async => await OrderStatusApi.cancelOrder(context: context, orderId: productOrderId, status: "1"),
                text: "Yes",
                backgroundColor: ConstantColor.loginWithOtpButtonColor,
                borderRadius: BorderRadius.circular(20.0),
                elevation: 0.0,
              ),
              constantWidth(context, 100.0),
              customButton(
                textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                onPressed:() => Navigator.pop(context),
                text: "No",
                backgroundColor: ConstantColor.primaryMainColor,
                borderRadius: BorderRadius.circular(20.0),
                elevation: 0.0,
              ),
            ],
          ),
              text: "Confirm order",
              backgroundColor: ConstantColor.loginWithOtpButtonColor,
              borderRadius: BorderRadius.circular(6.0),
              elevation: 0.0,
              minimumSize: Size(screenWidth, screenHeight / 25.0),
            ),
          ),
        ],)  : null,
      ),
      appBar: AppBar(
        backgroundColor: ConstantColor.loginWithOtpButtonColor,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), color: ConstantColor.primaryBackgroundMainColor,
          onPressed: () => Navigator.pop(context),
        ),
        title: customeText(text: 'Your Order Details', style:  ConstantTextStyle.landingScreenAppbarText,),
      ),
      body:
      CupertinoScrollbar(
        controller: _scrollController,
        child:
        ListView(
          controller: _scrollController,
          padding: EdgeInsets.symmetric(horizontal: screenWidth/30,vertical: screenHeight/60),
          children: [
            constantHeight(context, 80.0),

            Skeletonizer(
              enabled: isLoading,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: ConstantColor.calendarBGHeadColor,
                ),
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: screenWidth/30),
                  leading: customeText(
                    text: "Image",
                    textAlign: TextAlign.start,
                    style: ConstantTextStyle.tabButtonTextStyle,
                  ),
                  horizontalTitleGap: screenWidth/8.0,
                  title: customeText(text: "Product Details",
                    style: ConstantTextStyle.tabButtonTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: customeText(text: "Status   ",
                    style: ConstantTextStyle.tabButtonTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),

                ),
              ),
            ),
            (data != null && data!.isNotEmpty)
                ?  Skeletonizer(
              enabled: isLoading,
              child: ListView.builder(
              controller: _scrollController,
              physics: const ScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: data?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                // Get the OrderListingData for the current index
                var orderListingData = data![index];
                var productList = orderListingData.product ?? [];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: productList.map((product) {
                    createdDateKey = DateFormat('dd MMMM yyyy', 'en_US').format(
                        DateTime.parse(product!.insertDate.toString()??"").add(const Duration(days: 365)));
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: ConstantColor.sellerBGColor,
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: screenWidth / 60),
                            leading: Container(
                              width: screenWidth / 6,
                              height: screenHeight / 10,
                              decoration: BoxDecoration(
                                color: ConstantColor.primaryBackgroundMainColor,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: ConstantColor.primaryGreyColor,
                                    blurRadius: 0.1,
                                  ),
                                ],
                              ),
                              child: cachedImageWidget(
                                context: context,
                                imageFile: product.productImage ?? "", // Display product image
                                assetImageFit: BoxFit.contain,
                              ),
                            ),
                            title: customeText(
                              text: product.productTitle ?? "",
                              style: ConstantTextStyle.ratingText2,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (product.offerPrice != null && product.offerPrice.toString().isNotEmpty && product.offerPrice.toString() != "0.00")
                                customeText(
                                  text: "Offer Price : ₹ ${product.offerPrice ?? ""}",
                                  style: ConstantTextStyle.becomeSellerDiscText,
                                ),

                                if (product.price != null && product.price.toString().isNotEmpty && product.price.toString() != "0.00")
                                  customeText(
                                  text: "Price :₹ ${product.price ?? ""}",
                                  style: ConstantTextStyle.becomeSellerDiscText,
                                ),

                                  customeText(
                                  text: "Date : $createdDateKey",
                                  style: ConstantTextStyle.becomeSellerDiscText,
                                ),
                                colorBoxWidget(
                                  margin: EdgeInsets.only(right: screenWidth/8.0,top: screenHeight/80.0,bottom: screenHeight/80.0),
                                  textAlign: TextAlign.center,
                                  context:context,
                                  color: ConstantColor.calendarBGHeadColor,
                                  text: 'Quantity : ${product.productQuantity.toString()??""}',
                                  style: ConstantTextStyle.tabButtonTextStyle,
                                ),
                                Text('${orderListingData!.statusText.toString()??""}   ', style: ConstantTextStyle.chipText),
                              ],
                            ),
                            trailing:
                            Container(
                              width: screenWidth/5.0,
                              margin: EdgeInsets.symmetric(vertical: screenHeight/80.0),
                              decoration: BoxDecoration(color: getStatusColor(orderListingData!.statusText.toString().toUpperCase()?? ''), borderRadius: BorderRadius.circular(5.0)),
                              child: Center(child: Text(orderListingData!.statusText.toString()??"", style: ConstantTextStyle.chipText)),
                            ),
                            // customButton(
                            //   textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                            //   onPressed:(){},
                            //   toolTipMessage: orderListingData!.statusText.toString()??"",
                            //   text: orderListingData!.statusText.toString()??"",
                            //   backgroundColor: ConstantColor.primaryMainColor,
                            //   borderRadius: BorderRadius.circular(6.0),
                            //   elevation: 0.0,
                            //   minimumSize: Size(screenWidth /80.0, screenHeight /30.0),
                            // ),
                          ),
                          Divider(height: screenHeight / 40.0), // Divider between ListTile widgets
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
                    ): Column(
              children: [
                constantHeight(context, 10.0),
                noDataFound(context),
              ],
            ),
            constantHeight(context, 30.0),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),
                color: ConstantColor.sellerBGColor,),
              padding: EdgeInsets.symmetric(vertical: screenHeight/80.0,horizontal: screenWidth/40.0),
              child: customeText(text: "Total Price ₹ $totalPrice",
                style: ConstantTextStyle.lableTextHeading1,
              ),
            ),


          ],
        ),
      )
    );
  }

}


