import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';
import '../../Widget/No Data Available/no_data_found.dart';
import '../../Widget/Scaffold Message/scaffold_message_widget.dart';
import '../../Widget/custome_text_widget.dart';
import '../../Widget/images/cached_images_widget.dart';
import '../../Widget/refresh_footer_message.dart';
import '../Models/booked_product_model.dart';
import '../Services/booked_product_api_services.dart';
import '../Utils/Constant Size /constant_sizes.dart';
import '../Widget/Custome Buttons/elevetion_button_widget.dart';
import '../Widget/Text Form Fields/password_text_form.dart';
import '../Widget/rich_title_icon_title_widget.dart';

class BookedProductScreen extends StatefulWidget {
  const BookedProductScreen({super.key});

  @override
  State<BookedProductScreen> createState() => _BookedProductScreenState();
}


class _BookedProductScreenState extends State<BookedProductScreen> {

  // late String userId;
  bool isHashLoad = false;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // Retrieve userId from arguments after the widget has fully initialized
  //   userId = ModalRoute.of(context)!.settings.arguments as String;
  //   fetchBookedProductData(userId); // Pass userId to fetch function
  // }

  @override
  void initState() {
    super.initState();
    fetchBookedProductData();
  }

  final ScrollController _scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();



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
  BookedProductModel? bookedProductModel;
  List<BookedProductData>? data = [];
  Future<void> fetchBookedProductData() async {
    try {
      if (currentPage == 1) {
        setState(() {
          isLoading = true;
          data!.clear();
        });
      }

      final bookedProductResponse = await BookedProductApiService.fetchBookedProductData(context: context,search: searchController.text.toString(),  page: currentPage, limit: limit.toString());

      if (bookedProductResponse != null && bookedProductResponse.data != null) {

        final dataList = bookedProductResponse.data!;


        setState(() {
          if (currentPage == 1) {
            data = dataList;
          }
          else {
            data!.addAll(dataList);
            _refreshController.loadComplete();
          }

          isHashLoad = currentPage! > bookedProductResponse.totalPages!;
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


  @override
  Widget build(BuildContext context) {
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
          title: customeText(text: 'Your Booked Products', style:  ConstantTextStyle.landingScreenAppbarText,),
        ),
        body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: isHashLoad == false ? true: false,
            controller: _refreshController,
            footer: customFooter(),
            onRefresh: () async {
              currentPage = 1;
              searchController.clear();
              await fetchBookedProductData();
              _refreshController.refreshCompleted();
            },
            onLoading: () async {
              await fetchBookedProductData();
            },
            child: ListView(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: screenWidth/30,vertical: screenHeight/40),
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
                  await  fetchBookedProductData();
                },
                  suffixIcon: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth / 40,
                        vertical: screenHeight / 100),
                    child: customButton(
                      textStyleButton: ConstantTextStyle.otpResendButtonText,
                      onPressed: (searchController.text.toString().isEmpty)?null:() async {
                        currentPage = 1;
                        isLoading = true;
                        data!.clear();
                        await  fetchBookedProductData();
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
                (data != null && data!.isNotEmpty) ?
                Skeletonizer(
                  enabled: isLoading,
                  child: ListView.builder(
                    controller: _scrollController,
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: data!.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      var bookedProductView = data![index];
                      // cardStatus = data![index].cartStatus??"";
                     var createDate = data![index].createdDate??"";
                      createDate = DateFormat('dd MMMM yyyy', 'en_US').format(
                          DateTime.parse(createDate).add(const Duration(days: 365)));
                      return Container(
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
                                      imageFile: bookedProductView!.productImgUrl.toString() ?? "",
                                      assetImageFit: BoxFit.fill,
                                    )
                                ),

                                title: customeText(text: bookedProductView!.productName.toString()??"",
                                  style: ConstantTextStyle.ratingText2,
                                  // maxLines: 5,
                                  // overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customTitleIconTextWidget(
                                      context: context,
                                      f1Text: "Buyer Name:\t",
                                      styleF1: ConstantTextStyle.allHomeScreenAvatarText,
                                      icon: Icons.person_outline_outlined,
                                      f2Text: bookedProductView!.firstName.toString()??"",
                                      styleF2: ConstantTextStyle.becomeSellerDiscText,
                                    ),
                                    customTitleIconTextWidget(
                                      context: context,
                                      f1Text: "Buyer Email:\t\t",
                                      styleF1: ConstantTextStyle.allHomeScreenAvatarText,
                                      icon: Icons.email_outlined,
                                      f2Text: bookedProductView!.email.toString()??"",
                                      styleF2: ConstantTextStyle.becomeSellerDiscText,
                                    ),
                                    customTitleIconTextWidget(
                                      context: context,
                                      f1Text: "Buyer Mobile:",
                                      styleF1: ConstantTextStyle.allHomeScreenAvatarText,
                                      icon: Icons.call_outlined,
                                      f2Text: bookedProductView!.mobile.toString()??"",
                                      styleF2: ConstantTextStyle.becomeSellerDiscText,
                                    ),
                                    customTitleIconTextWidget(
                                      context: context,
                                      f1Text: "Buyer Date:\t\t\t\t",
                                      styleF1: ConstantTextStyle.allHomeScreenAvatarText,
                                      icon: Icons.calendar_month,
                                      f2Text: createDate.toString()??"",
                                      styleF2: ConstantTextStyle.becomeSellerDiscText,
                                    ),

                                  ],
                                ),
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
            )
        )
    );
  }

}








