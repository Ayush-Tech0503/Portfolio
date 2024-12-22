import 'package:citybazaronline_seller_app/Utils/Constant%20Size%20/constant_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../Models/Complete Order Model/complete_order_view_model.dart';
import '../../Services/Complete Order Api Services/complete_order_view_api_services.dart';
import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';
import '../../Widget/No Data Available/no_data_found.dart';
import '../../Widget/Scaffold Message/scaffold_message_widget.dart';
import '../../Widget/custome_text_widget.dart';
import '../../Widget/images/cached_images_widget.dart';
import '../../Widget/refresh_footer_message.dart';

class CompleteOrderViewScreen extends StatefulWidget {
  const CompleteOrderViewScreen({super.key});

  @override
  State<CompleteOrderViewScreen> createState() => _CompleteOrderViewScreenState();
}


class _CompleteOrderViewScreenState extends State<CompleteOrderViewScreen> {

  late String userId;
  bool isHashLoad = false;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // Retrieve userId from arguments after the widget has fully initialized
  //   userId = ModalRoute.of(context)!.settings.arguments as String;
  //   fetchCompleteOrderViewData(userId); // Pass userId to fetch function
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      userId = ModalRoute.of(context)!.settings.arguments as String;
      fetchCompleteOrderViewData(userId);
    });
  }

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _finalDealPriceController = TextEditingController();



  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool isPullToRefreshEnabled = true;
  int currentPage = 1;
  var limit = '12';
  bool isLoading = false;

  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  CompleteOrderViewModel? completeOrderViewModel;
  List<CompleteOrderViewData>? data = [];
  Future<void> fetchCompleteOrderViewData(userId) async {
    try {
      if (currentPage == 1) {
        setState(() {
          isLoading = true;
          data!.clear();
        });
      }

      final completeOrderViewResponse = await CompleteOrderViewApiService.fetchCompleteOrderViewData(context: context,userId: userId,  page: currentPage, limit: limit.toString());

      if (completeOrderViewResponse != null && completeOrderViewResponse.data != null) {

        final dataList = completeOrderViewResponse.data!;


        setState(() {
          if (currentPage == 1) {
            data = dataList;
          }
          else {
            data!.addAll(dataList);
            _refreshController.loadComplete();
          }

          isHashLoad = currentPage! > completeOrderViewResponse.totalPages!;
          if (isHashLoad == true){
            LoadingScaffoldMessage.showSnackbar(
              context,
              "Oops!! No More Data Available...",
              ConstantColor.primaryMainColor,
              const Duration(seconds: 2),
            );
          }

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





  bool isExpanded = false;

  String calculateTotalPrice() {
    double total = 0.0;
    if (data != null) {
      for (var orderView in data!) {
          double price = 0.0;
          // Handle offerPrice

          if (orderView.dealPrice != null) {
            if (orderView.dealPrice is double) {
              price = orderView.dealPrice as double; // Direct assignment if offerPrice is double
            } else if (orderView.dealPrice is int) {
              price = (orderView.dealPrice as int).toDouble(); // Convert int to double
            } else if (orderView.dealPrice is String) {
              price = double.tryParse(orderView.dealPrice as String) ?? 0.0; // Parse String to double
            }
          }
          // Fallback to offerPrice if dealPrice is null or couldn't be parsed

          if (orderView.offerPrice != null) {
            if (orderView.offerPrice is double) {
              price = orderView.offerPrice as double; // Direct assignment if offerPrice is double
            } else if (orderView.offerPrice is int) {
              price = (orderView.offerPrice as int).toDouble(); // Convert int to double
            } else if (orderView.offerPrice is String) {
              price = double.tryParse(orderView.offerPrice as String) ?? 0.0; // Parse String to double
            }
          }

          // Fallback to price if offerPrice is null or couldn't be parsed
          if (price == 0.0 && orderView.price != null) {
            if (orderView.price is double) {
              price = orderView.price as double; // Direct assignment if price is double
            } else if (orderView.price is int) {
              price = (orderView.price as int).toDouble(); // Convert int to double
            } else if (orderView.price is String) {
              price = double.tryParse(orderView.price as String) ?? 0.0; // Parse String to double
            }
          }

          total += price;

      }
    }
    return  '₹ ${total.toStringAsFixed(2)}';
  }


  @override
  Widget build(BuildContext context) {
    String totalString = calculateTotalPrice();

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: ConstantColor.primaryBackgroundMainColor,
        appBar: AppBar(
          backgroundColor: ConstantColor.loginWithOtpButtonColor,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back), color: ConstantColor.primaryBackgroundMainColor,
            onPressed: () => Navigator.pop(context),
          ),
          title: customeText(text: 'Your Complete Order View', style:  ConstantTextStyle.landingScreenAppbarText,),
        ),
        body:
        SmartRefresher(
            enablePullDown: true,
            enablePullUp: isHashLoad == false ? true: false,
            controller: _refreshController,
            footer: customFooter(),
            onRefresh: () async {
              currentPage = 1;
              _finalDealPriceController.clear();
              await fetchCompleteOrderViewData(userId);
              _refreshController.refreshCompleted();
            },
            onLoading: () async {
              await fetchCompleteOrderViewData(userId);
            },
            child: CupertinoScrollbar(
              // controller: _scrollController,
              child: ListView(
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
                        trailing: customeText(text: "Date",
                          style: ConstantTextStyle.tabButtonTextStyle,
                          overflow: TextOverflow.ellipsis,
                        ),

                      ),
                    ),
                  ),
                  (data != null && data!.isNotEmpty)
                      ?   Skeletonizer(
                    enabled: isLoading,
                    child: ListView.builder(
                      controller: _scrollController,
                      physics: const ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: data!.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        var pendingOrderView = data![index];
                        // cardStatus = data![index].cartStatus??"";
                        // interestId = data![index].interestId??"";

                        return   Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),
                            color: ConstantColor.sellerBGColor,),
                          padding: EdgeInsets.symmetric(vertical: screenHeight/80.0,horizontal: screenWidth/40.0),
                          child: Column(
                            children: [
                              ListTile(
                                  contentPadding: EdgeInsets.symmetric(horizontal: screenWidth/60),
                                  // dense: true,
                                  // onTap: () {},
                                  leading: Container(
                                      width: screenWidth /6,
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
                                      child:  cachedImageWidget(
                                        context:context,
                                        imageFile: pendingOrderView!.imageFile.toString() ?? "",
                                        assetImageFit: BoxFit.fill,
                                      )
                                  ),

                                  title: customeText(text: pendingOrderView!.productName.toString()??"",
                                    style: ConstantTextStyle.ratingText2,
                                    // maxLines: 5,
                                    // overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      //category_name
                                      customeText(text: "Product Offer Price :\n ₹ ${pendingOrderView!.offerPrice.toString()??""}",
                                        style: ConstantTextStyle.becomeSellerDiscText,
                                      ),

                                      customeText(text: "Product Price :\n₹ ${pendingOrderView!.price.toString()??""}",
                                        style: ConstantTextStyle.becomeSellerDiscText,
                                      ),
                                    ],
                                  ),
                                  trailing: customeText(text: "", style: ConstantTextStyle.becomeSellerDiscText,)),
                              Divider(height: screenHeight/40,), // Divider between ListTile widgets
                            ],
                          ),
                        );
                      },
                    ),
                  ):
                  Column(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        customeText(text: "Total Price ₹ ${totalString??""}",
                          style: ConstantTextStyle.subRatingText,
                        ),
                        customeText(text: "Final Price ₹ ${totalString??""}",
                          style: ConstantTextStyle.subRatingText,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
        )
    );
  }

}








