// ignore_for_file: non_constant_identifier_names, deprecated_member_use, library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../Utils/Constant Size /constant_sizes.dart';
import '../../Widget/Custome Buttons/elevetion_button_widget.dart';
import '../../Widget/No Data Available/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../Layouts/constant_screen_layout.dart';
import '../../../../Utils/Font Style/text_styles.dart';
import '../../../../Utils/Theme/constant_colors.dart';
import '../../../../Widget/custome_text_widget.dart';
import '../../Widget/Text Form Fields/password_text_form.dart';
import '../../Widget/refresh_footer_message.dart';
import '../Models/shop_review_rating.dart';
import '../Services/review_rating_api_services.dart';
import 'Uploaded Products/uploaded_products_dart.dart';

class ShopReviewRatingScreen extends StatefulWidget {
  const ShopReviewRatingScreen({super.key});

  @override
  State<ShopReviewRatingScreen> createState() => _ShopReviewRatingScreenState();
}

class _ShopReviewRatingScreenState extends State<ShopReviewRatingScreen> {

  @override
  void initState() {
    super.initState();
    fetchShopReviewRatingData();
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
  var limit = '16';
  bool isLoading = false;
  bool isHashLoad = false;

  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  ShopReviewRatingModel? shopReviewRatingModel;
  // Totalcount? totalcount;
  List<DataR>? data = [];

  Future<void> fetchShopReviewRatingData() async {
    try {
      setState(() {
        isLoading = true;
        data!.clear();
      });

      final response = await ShopReviewRatingApiService.fetchUploadedProductData(
        context: context,
        search: searchController.text,
        page: currentPage,
        limit: limit.toString(),
      );

      if (response != null) {
        
        final reviewData = response.data!;
        // ShopReviewRatingModel.fromJson(response);

        setState(() {
          // Process reviews
          uploadedProductOdDataList = reviewData?.reveiws?.map((review) {
            return {
              'user': review.user ?? "Unknown",
              'userId': review.userId ?? "",
              'review': review.reveiw ?? "",
              'createdDate': review.createdDate ?? "",
              'rating': review.rating ?? "",
            };
          }).toList() ?? [];
          // Handle pagination and loading states
          isLoading = false;
          // if (currentPage >= (reviewData.totalPages ?? 1)) {
          //   isHashLoad = true;
          //   LoadingScaffoldMessage.showSnackbar(
          //     context,
          //     "No More Data Available...",
          //     ConstantColor.primaryMainColor,
          //     const Duration(seconds: 2),
          //   );
          // } else {
          //   currentPage++;
          // }
        });
      } else {
        setState(() {
          isLoading = false;
          _refreshController.loadNoData();
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        _refreshController.loadNoData();
      });
    }
  }

  List<Map<String, dynamic>>? uploadedProductOdDataList = []; // Assuming this is your data list

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return   AppLayout(
        title: "Your Review Rating",
        titleStyle: ConstantTextStyle.landingScreenAppbarText,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), color: ConstantColor.primaryBackgroundMainColor,
          onPressed: () async =>
              // Navigator.pushNamedAndRemoveUntil(context, '/bottomNavigationBarScreen', (route) => false,),
          Navigator.pop(context)
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
                await fetchShopReviewRatingData();
                _refreshController.refreshCompleted();
              },
              onLoading: () async {
                await fetchShopReviewRatingData();
                // _refreshController.loadComplete();
              },

              child: data == null || data!.toString().isEmpty ? noDataFound(context):
              ListView(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: screenWidth/30,vertical: screenHeight/40),
                children: [
                  // customeText(text: "\tManage Products",style: ConstantTextStyle.topCategoryText4),
                  // constantHeight(context, 40.0),

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
                      await  fetchShopReviewRatingData();
                    },
                    suffixIcon:
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth / 40, vertical: screenHeight / 100),
                      child: customButton(
                        textStyleButton: ConstantTextStyle.otpResendButtonText,
                        onPressed: (searchController.text.toString().isEmpty)?null:() async {
                          currentPage = 1;
                          isLoading = true;
                          data!.clear();
                          await  fetchShopReviewRatingData();
                        },
                        text: searchController.text.toString().isEmpty ? "Search": "Click Me",
                        backgroundColor: ConstantColor.secondryBackgroundMainColor,
                        borderRadius: BorderRadius.circular(6.0),
                        elevation: 1.0,
                      ),
                    ),
                  ),

                  constantHeight(context, 40.0),
                  Skeletonizer(
                    enabled: isLoading,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        child: Table(
                          columnWidths: {
                            0: FixedColumnWidth(screenWidth * 0.2),
                            1: FixedColumnWidth(screenWidth * 0.3),
                            2: FixedColumnWidth(screenWidth * 0.3),
                            3: FixedColumnWidth(screenWidth * 0.3),
                            4: FixedColumnWidth(screenWidth * 0.3)
                          },
                          children: [
                            // Table header row
                            TableRow(
                              decoration:  BoxDecoration(
                                color: ConstantColor.calendarBGHeadColor,
                                borderRadius: BorderRadius.circular(8.0),
                                // border: Border(bottom: BorderSide(color: ConstantColor.textFieldColor)),
                              ),
                              children: [
                                TableCell(child: paddingText(context: context, title:"\t\t\t\t\tS.No.",)),
                                TableCell(child: paddingText(context: context, title:"User Name",)),
                                TableCell(child: paddingText(context: context, title:"Rating",)),
                                TableCell(child: paddingText(context: context, title:"Review",)),
                                TableCell(child: paddingText(context: context, title:"Date",)),
                              ],
                            ),
                            // Data rows
                            ...uploadedProductOdDataList!.map((data) {
                              var user = data['user'];
                              var rating = data['rating'];
                              var review = data['review'];
                              var createdDate = data['createdDate'];
                              DateTime parsedDate = DateTime.parse(createdDate!);
                              // Format the DateTime object to a desired format
                              String formattedDate = DateFormat("dd-MM-yyyy").format(parsedDate);
                              return TableRow(
                                decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide(color: ConstantColor.textFieldColor)),
                                ),
                                children: [
                                  TableCell(
                                    child: Container(
                                      margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
                                      child: customeText(
                                        text: '\t\t\t\t\t${(uploadedProductOdDataList!.indexOf(data) + 1).toString()??""}',
                                        textAlign: TextAlign.start,
                                        style: ConstantTextStyle.allHomeScreenAvatarText,
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
                                      child: customeText(
                                        text: user ??"",
                                        textAlign: TextAlign.start,
                                        style: ConstantTextStyle.allHomeScreenAvatarText,
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
                                      child: customeText(
                                        text: rating ??"",
                                        textAlign: TextAlign.start,
                                        style: ConstantTextStyle.allHomeScreenAvatarText,
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
                                      child: customeText(
                                        text: review ??"",
                                        textAlign: TextAlign.start,
                                        style: ConstantTextStyle.allHomeScreenAvatarText,
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
                                      child: customeText(
                                        text: formattedDate.toString() ??"",
                                        textAlign: TextAlign.start,
                                        style: ConstantTextStyle.allHomeScreenAvatarText,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
          ),
        )
    );
  }
}
