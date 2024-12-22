import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';
import '../../Widget/No Data Available/no_data_found.dart';
import '../../Widget/Scaffold Message/scaffold_message_widget.dart';
import '../../Widget/custome_text_widget.dart';
import '../../Widget/images/cached_images_widget.dart';
import '../../Widget/refresh_footer_message.dart';
import '../Models/follower_seller_model.dart';
import '../Services/follower_seller_api_services.dart';
import '../Utils/Constant Size /constant_sizes.dart';
import '../Widget/Custome Buttons/elevetion_button_widget.dart';
import '../Widget/Text Form Fields/password_text_form.dart';
import '../Widget/color_box_widget.dart';
import '../Widget/star_rating_widget.dart';

class FollowerSellerScreen extends StatefulWidget {
  final bool? myAppbar;
  const FollowerSellerScreen({super.key, this.myAppbar = false});

  @override
  State<FollowerSellerScreen> createState() => _FollowerSellerScreenState();
}


class _FollowerSellerScreenState extends State<FollowerSellerScreen> {

  late String userId;
  bool isHashLoad = false;
  

  @override
  void initState() {
    super.initState();
    fetchFollowerSellerData();
  }


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

  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();


  FollowerSellerListingModel? followerSellerListingModel;
  List<FollowerSellerListingData>? data = [];
  Future<void> fetchFollowerSellerData() async {
    try {
      if (currentPage == 1) {
        setState(() {
          isLoading = true;
          data!.clear();
        });
      }

      final followerSellerResponse = await FollowerSellerApiService.fetchFollowerSellerData(context: context, search: searchController.text.toString(), page: currentPage, limit: limit.toString());

      if (followerSellerResponse != null && followerSellerResponse.data != null) {

        final dataList = followerSellerResponse.data!;


        setState(() {
          if (currentPage == 1) {
            data = dataList;
          }
          else {
            data!.addAll(dataList);
            _refreshController.loadComplete();
          }

          isHashLoad = currentPage! > followerSellerResponse.totalPages!;
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


  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: ConstantColor.primaryBackgroundMainColor,
        appBar: widget.myAppbar == true ? null : AppBar(
          backgroundColor: ConstantColor.loginWithOtpButtonColor,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back), color: ConstantColor.primaryBackgroundMainColor,
            onPressed: () => Navigator.pop(context),
          ),
          title: customeText(text: 'Your Following Shops', style:  ConstantTextStyle.landingScreenAppbarText,),
        ),
        body:
        SmartRefresher(
            enablePullDown: true,
            enablePullUp: isHashLoad == false ? true: false,
            controller: _refreshController,
            footer: customFooter(),
            onRefresh: () async {
              searchController.clear();
              currentPage = 1;
              await fetchFollowerSellerData();
              _refreshController.refreshCompleted();
            },
            onLoading: () async {
              await fetchFollowerSellerData();
            },
            child: CupertinoScrollbar(
              controller: _scrollController,
              child: ListView(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: screenWidth/30,vertical: screenHeight/60),
                children: [
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
                      await  fetchFollowerSellerData();
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
                          await  fetchFollowerSellerData();
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
                        var followerSellerView = data![index];
                        String avgRatingString = followerSellerView.avgRating.toString()??"";
                        double avgRatingInt = double.tryParse(avgRatingString) ?? 0;
                        String formattedAvgRating = avgRatingInt.toStringAsFixed(2);
                        return   Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),
                            color: ConstantColor.sellerBGColor,),
                          padding: EdgeInsets.symmetric(vertical: screenHeight/80.0,horizontal: screenWidth/40.0),
                          child: Column(
                            children: [
                              ListTile(
                                  contentPadding: EdgeInsets.symmetric(horizontal: screenWidth/60),
                                  leading: Container(
                                      width: screenWidth /6,
                                      height: screenHeight / 10,
                                      decoration: BoxDecoration(
                                        color: ConstantColor.primaryBackgroundMainColor,
                                        borderRadius: BorderRadius.circular(8.0),
                                        boxShadow: const [
                                          BoxShadow(color: ConstantColor.primaryGreyColor, blurRadius: 0.1,),
                                        ],
                                      ),
                                      child:  cachedImageWidget(
                                        context:context,
                                        imageFile: followerSellerView!.storeImageUrl.toString() ?? "",
                                        assetImageFit: BoxFit.fill,
                                      )
                                  ),

                                  title: customeText(text: followerSellerView!.storeName.toString()??"",
                                    style: ConstantTextStyle.ratingText2,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          colorBoxWidget(
                                              context:context,
                                            text: formattedAvgRating.toString()??"",
                                            style: ConstantTextStyle.loginButtonTextStyle,
                                          ),
                                          constantWidth(context, 80.0),
                                          ratingsStar(
                                            initialRating: avgRatingInt,
                                            itemSize: 16.0,
                                            minRating: 1.0,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            onRatingUpdate: (rating) {},
                                            itemBuilder: (context, _) =>
                                            const Icon(Icons.star, color: ConstantColor.starRatingColor),
                                          ),
                                        ],
                                      ),

                                      customeText(text: "📍 ${followerSellerView!.storeAddress.toString()??""}",
                                        style: ConstantTextStyle.becomeSellerDiscText,
                                      ),
                                    ],
                                  ),
                                  // trailing: customeText(text: "", style: ConstantTextStyle.becomeSellerDiscText,)
                              ),
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
                ],
              ),
            )
        )
    );
  }

}








