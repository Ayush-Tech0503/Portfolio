// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:citybazaronline_seller_app/Widget/images/cached_images_widget.dart';
import 'package:citybazaronline_seller_app/Widget/span_title_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../Layouts/constant_screen_layout.dart';
import '../../../Models/Uploaded Products Model/view_and_edit_product_model.dart';
import '../../../Services/Uploaded Products Api Services/view_product_api_services.dart';
import '../../../Utils/Constant Size /constant_sizes.dart';
import '../../../Utils/Font Style/text_styles.dart';
import '../../../Utils/Theme/constant_colors.dart';
import '../../../Widget/No Data Available/no_data_found.dart';
import '../../../Widget/Status Chip Object Color /status_chip_bg_color_widget.dart';
import '../../../Widget/custome_text_widget.dart';
import '../../../Widget/divider_widget.dart';
import '../../../Widget/refresh_footer_message.dart';

class ViewProductScreen extends StatefulWidget {
  String productId;
   ViewProductScreen({super.key, this.productId=''});

  @override
  State<ViewProductScreen> createState() => _ViewProductScreenState();
}


class _ViewProductScreenState extends State<ViewProductScreen> {


  @override
  void initState() {
    super.initState();
    fetchViewProductListData();
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
  var limit = "12";

  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  ViewProductModel? viewProductModel;
  List<ProductDetails>? data = [];


  String stockStatus = '';
  String productStatus = '';
  String approveStatus = '';
  String shopBanner = '';


  Future<void> fetchViewProductListData() async {
    try {
      if (currentPage == 1) {
        setState(() {
          isLoading = true;
          data!.clear();
        });
      }

      final viewProductResponse = await ViewProductApiService.fetchViewProductData(context: context,reqId: widget.productId??"");

      if (viewProductResponse != null && viewProductResponse.productDetails != null) {
        final dataList = viewProductResponse.productDetails!;

        setState(() {
          if (currentPage == 1) {
            data = dataList;
          } else {
            data!.addAll(dataList);
            _refreshController.loadComplete();
          }

          isLoading = false;
          currentPage++;
        });

        setState(() {
          stockStatus = data!.first.isAvailable == "1"?'In Stock':'Out Of Stock'??"";
          productStatus = data!.first.isActive == "1"?'Active':'Deactive'??"";
          approveStatus = data!.first.isApproved == "1"?'Approved':'Pending'??"";
          shopBanner = data!.first.imageFile??"";
          var offerDate = data!.first.offerStartDate??"";
          var offerEndDate = data!.first.offerEndDate??"";
          //DateFormat("dd-MM-yyyy").format(DateTime.parse(offerDate??"")
          shopInfoData = [
            {"title": "Product Name :", "content": data!.first.productName??""},
            {"title": "Product Slug  :", "content": data!.first.productSlug??""},
            {"title": "Model Name :", "content": data!.first.model??""},
            {"title": "Brand Name :", "content": data!.first.brand??""},
            {"title": "Regular Price :", "content": data!.first.price??""},
            {"title": "Offer Price :", "content": data!.first.offerPrice??""},
            {"title": "Stock Quantity :", "content": data!.first.stockQuantity??""},
            {"title": "Referral Code :", "content": ""},
            {"title": "Offer Start Date :", "content": offerDate??""},
            {"title": "Offer End Date :", "content": offerEndDate??""},
            {"title": "Warranty :", "content": data!.first.warranty??""},
            {"title": "Short Description :", "content": data!.first.shortDescription??""},
            {"title": "Full Description :", "content": data!.first.description??""},
            {"title": "Other Features :", "content": data!.first.otherFeature??""},
          ];

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


  List<Map<String, String>> shopInfoData = [];



  @override
  Widget build(BuildContext context) {

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    // final List<dynamic> uploadedProductOdDataList = ModalRoute.of(context)!.settings.arguments as List<dynamic>;

    return AppLayout(
        title: "View Product Details",
        titleStyle: ConstantTextStyle.landingScreenAppbarText,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), color: ConstantColor.primaryBackgroundMainColor,
          onPressed: () => Navigator.pop(context),
        ),
        scaffoldColor: ConstantColor.primaryBackgroundMainColor,
        appBarColor: ConstantColor.loginWithOtpButtonColor,
        body: data == null || data!.toString().isEmpty ? noDataFound(context):
        CupertinoScrollbar(
          // controller: _scrollController,
          child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              controller: _refreshController,
              footer: customFooter(),
              onRefresh: () async {
                currentPage = 1;
                await fetchViewProductListData();
                _refreshController.refreshCompleted();
              },
              child: Skeletonizer(
                enabled: isLoading,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth/40.0,vertical: screenHeight/80.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customeText(text: "View Product Details : ",style: ConstantTextStyle.topCategoryText4),
                        constantHeight(context, 80.0),

                        Column(
                          children: shopInfoData.map((item) {
                            return richTextWithSpanWidget(
                              context: context,
                              firstText: item["title"],
                              secondText: '\t${item["content"]}',
                              firstTextStyle: ConstantTextStyle.cardbottumText,
                              secondTextStyle: ConstantTextStyle.colorsHeadingText,
                            );
                          }).toList(),
                        ),


                        dividerWidget(height: screenHeight/60.0,),

                        SizedBox(
                          width: screenWidth,
                          child: Card(
                            elevation: 0.5,
                            margin: EdgeInsets.symmetric(vertical: screenHeight/60.0),
                            child: customeText(text: "\t\tImages",
                                style: ConstantTextStyle.otpHintTextStyle),
                          ),
                        ),


                        dividerWidget(height: screenHeight/60.0,),

                        cachedImageWidget(
                          context:context,
                          height: screenHeight/6,
                          width: screenWidth,
                          imageFile: shopBanner??"",
                        ),

                        SizedBox(
                          width: screenWidth,
                          child: Card(
                            elevation: 0.5,
                            margin: EdgeInsets.symmetric(vertical: screenHeight/60.0),
                            child: customeText(text: "\t\tCategory",
                                style: ConstantTextStyle.otpHintTextStyle),
                          ),
                        ),


                        Row(
                          children: [
                            customeText(text: 'Stock Status : ',style:ConstantTextStyle.cardbottumText ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
                              padding: EdgeInsets.symmetric(horizontal: screenHeight /100.0),
                              decoration: BoxDecoration(color: getStatusColor(stockStatus.toUpperCase()), borderRadius: BorderRadius.circular(5.0)),
                              child: customeText(text: stockStatus.toString()??"", textAlign: TextAlign.center, style:  ConstantTextStyle.chipText
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            customeText(text: 'Product Status : ',style:ConstantTextStyle.cardbottumText ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
                              padding: EdgeInsets.symmetric(horizontal: screenHeight /100.0),
                              decoration: BoxDecoration(color: getStatusColor(productStatus.toUpperCase()), borderRadius: BorderRadius.circular(5.0)),
                              child: customeText(text: productStatus.toString()??"", textAlign: TextAlign.center, style:  ConstantTextStyle.chipText
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            customeText(text: 'Approval Status : ',style:ConstantTextStyle.cardbottumText ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
                              padding: EdgeInsets.symmetric(horizontal: screenHeight /100.0),
                              decoration: BoxDecoration(color: getStatusColor(approveStatus.toUpperCase()), borderRadius: BorderRadius.circular(5.0)),
                              child: customeText(text: approveStatus.toString()??"", textAlign: TextAlign.center, style:  ConstantTextStyle.chipText
                              ),
                            ),
                          ],
                        ),


                        dividerWidget(height: screenHeight/60.0,),


                      ],
                    ),
                  ),
                ),
              )),
        )
    );
  }
}