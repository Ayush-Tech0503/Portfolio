// ignore_for_file: camel_case_types

import 'package:citybazaronline_seller_app/Utils/Constant%20Size%20/constant_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../Layouts/constant_screen_layout.dart';
import '../Models/like_product_listing_model.dart';
import '../Services/like_products_api_services.dart';
import '../Utils/Font Style/text_styles.dart';
import '../Utils/Theme/constant_colors.dart';
import '../Widget/Custome Buttons/elevetion_button_widget.dart';
import '../Widget/Icon_Titles/color_icon_text_widget.dart';
import '../Widget/Icon_Titles/icon_title_widget.dart';
import '../Widget/No Data Available/no_data_found.dart';
import '../Widget/Scaffold Message/scaffold_message_widget.dart';
import '../Widget/Text Form Fields/password_text_form.dart';
import '../Widget/custome_text_widget.dart';
import '../Widget/images/cached_images_widget.dart';
import '../Widget/refresh_footer_message.dart';

class LikeProductScreen extends StatefulWidget {
  const LikeProductScreen({super.key});

  @override
  State<LikeProductScreen> createState() => _LikeProductScreenState();
}


class _LikeProductScreenState extends State<LikeProductScreen> {

  @override
  void initState() {
    super.initState();
    fetchLikeProductListData();
  }
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool isPullToRefreshEnabled = true;
  int currentPage = 1;
  var limit = '12';
  bool isLoading = false;
  bool isHashLoad = false;

  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  LikeProductsModel? notificationModels;
  List<LikeProductsData>? data = [];
  Future<void> fetchLikeProductListData() async {
    try {
      if (currentPage == 1) {
        setState(() {
          isLoading = true;
          data!.clear();
        });
      }

      final likeProductsResponse = await LikeProductApiService.fetchLikeProductsData(context: context,search: searchController.text.toString(),  page: currentPage, limit: limit);

      if (likeProductsResponse != null && likeProductsResponse.data != null) {
        final dataList = likeProductsResponse.data!;
        setState(() {
          if (currentPage == 1) {
            data = dataList;
          }
          else {
            data!.addAll(dataList);
            _refreshController.loadComplete();
          }
          isHashLoad = currentPage! > likeProductsResponse.totalPages!;
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
          // if (currentPage! > likeProductsResponse.totalPages!) {
          //   isPullToRefreshEnabled = false;
          //   _refreshController.loadNoData();
          //   return; // Exit early to prevent unnecessary setState
          // }
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


  final TextEditingController searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return AppLayout(
      title: "Your Like Products",
      titleStyle: ConstantTextStyle.landingScreenAppbarText,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back), color: ConstantColor.primaryBackgroundMainColor,
        onPressed: () => Navigator.pop(context),
      ),
      scaffoldColor: ConstantColor.primaryBackgroundMainColor,
      appBarColor: ConstantColor.loginWithOtpButtonColor,
      body:
     //  isLoading
     //      ? const Center(child: CircularProgressIndicator())
     // :
      CupertinoScrollbar(
        controller: _scrollController,
        child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: isHashLoad == false ? true: false,
            controller: _refreshController,
            footer: customFooter(),
            onRefresh: () async {
              searchController.clear();
              currentPage = 1;
              await fetchLikeProductListData();
              _refreshController.refreshCompleted();
            },
            onLoading: () async {
              await fetchLikeProductListData();
            },
            child:ListView(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: screenWidth/30,vertical: screenHeight/60),
              children: [
                // customeText(text: "\tLike Products",style: ConstantTextStyle.topCategoryText4),
                // constantHeight(context, 80.0),

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
                    await  fetchLikeProductListData();
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
                       await  fetchLikeProductListData();
                      },
                      text: searchController.text.toString().isEmpty ? "Search": "Click Me",
                      backgroundColor: ConstantColor.secondryBackgroundMainColor,
                      borderRadius: BorderRadius.circular(6.0),
                      elevation: 1.0,
                    ),
                  ),
                ),
                constantHeight(context, 80.0),

                Skeletonizer(
                  enabled: isLoading,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: ConstantColor.calendarBGHeadColor,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: screenWidth/30,vertical: screenHeight/60),
                    child: Row(
                      children: [
                        customeText(
                          text: "Image",
                          textAlign: TextAlign.start,
                          style: ConstantTextStyle.tabButtonTextStyle,
                        ),
                        constantWidth(context, 10.0),
                        Text("Product Details",
                          style: ConstantTextStyle.tabButtonTextStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
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
                    itemCount: data!.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      var likeProductData = data![index];
                      return   Column(
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
                                child:cachedImageWidget(
                                  context:context,
                                  imageFile: likeProductData!.productImgUrl.toString() ?? "",
                                  assetImageFit: BoxFit.contain,
                                )
                            ),
                            title: customeText(text: likeProductData!.productName.toString()??"",
                              style: ConstantTextStyle.ratingText2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //category_name
                                customeText(text: likeProductData!.categoryName.toString()??'',
                                  style: ConstantTextStyle.skyBlueColorShopName,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                constantHeight(context, 200.0),
                                iconRichText2(
                                  context: context,
                                  icon: Icons.currency_rupee_outlined,
                                  color: ConstantColor.filedContainerColor,
                                  size: 14.0,
                                  text: likeProductData!.price.toString()??"",
                                  style: ConstantTextStyle.becomeSellerDiscText,
                                ),
                              ],
                            ),
                            trailing: iconTextWidget(
                        context : context,
                        iconData: const Icon(Icons.thumb_up_alt_outlined,color: ConstantColor.primaryMainColor,size: 14.0),
                        titleText: "\t${likeProductData!.firstName.toString()??''}\t")),
                          Divider(height: screenHeight/40,), // Divider between ListTile widgets
                        ],
                      );
                    },
                  ),
               ): Column(
                  children: [
                    constantHeight(context, 10.0),
                    noDataFound(context),
                  ],
                ),
              ],
            )
        ),
      )
    );
  }

}








