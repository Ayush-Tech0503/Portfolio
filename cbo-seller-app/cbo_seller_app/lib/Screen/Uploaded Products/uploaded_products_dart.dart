// ignore_for_file: non_constant_identifier_names, deprecated_member_use, library_private_types_in_public_api

import 'package:citybazaronline_seller_app/Models/Complete%20Order%20Model/complete_order_model.dart';
import 'package:citybazaronline_seller_app/Screen/Uploaded%20Products/View%20Product/view_product_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../Models/Uploaded Products Model/uploaded_products_listing_model.dart';
import '../../Services/Seller Forms Api Services/Seller Form Submit Api Services/step_1st_form_submit_api.dart';
import '../../Services/Uploaded Products Api Services/uploaded_products_api_services.dart';
import '../../Utils/Constant Api Routs/constant_api_routs.dart';
import '../../Utils/Constant Size /constant_sizes.dart';
import '../../Widget/Alert Dialogs/alert_dialog_widget.dart';
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
import '../../Widget/bottom_buttons_widget.dart';
import '../../Widget/color_box_widget.dart';
import '../../Widget/images/cached_images_widget.dart';
import '../../Widget/refresh_footer_message.dart';
import 'Edit Product/edit_product_screen.dart';

class UploadedProductScreen extends StatefulWidget {
  const UploadedProductScreen({super.key});

  @override
  State<UploadedProductScreen> createState() => _UploadedProductScreenState();
}

class _UploadedProductScreenState extends State<UploadedProductScreen> {

  @override
  void initState() {
    super.initState();
    fetchUploadedProductListData();
  }

  final ScrollController _scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    _scrollController.dispose();
    searchController.dispose();
    selectedCheckBoxs = '';
    super.dispose();
  }

  bool isPullToRefreshEnabled = true;
  int currentPage = 1;
  var limit = '12';
  bool isLoading = false;
  bool isHashLoad = false;

  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  UploadedProductListModel? uploadedProductListModel;
  Totalcount? totalcount;
  List<UploadedProductListData>? data = [];


  dynamic userCount = '';
  dynamic totalDealAmount = '';
  dynamic totalPrice = '';
  dynamic cashBackWon = '';

  Future<void> fetchUploadedProductListData() async {
    try {
      if (currentPage == 1) {
        setState(() {
          isLoading = true;
          data!.clear();
          uploadedProductOdDataList!.clear();
        });
      }

      final getUploadedProductResponse = await UploadedProductApiService.fetchUploadedProductData(context: context,search: searchController.text.toString(),  page: currentPage, limit: limit.toString(),status: '');

      if (getUploadedProductResponse != null && getUploadedProductResponse.data != null) {

        final dataList = getUploadedProductResponse.data!;

        setState(() {
          for (var uploadedProductOdData in dataList) {
            Map<String, dynamic> mapData = {
              'productImg': uploadedProductOdData.productImgUrl??"",
              'productName': uploadedProductOdData.productName??"",
              'category': uploadedProductOdData.categoryName ?? '',
              'model': uploadedProductOdData.model ?? '',
              'brand': uploadedProductOdData.brand ?? '',
              'price':  uploadedProductOdData.price ?? '',
              'offerPrice':  uploadedProductOdData.offerPrice ?? '',
              'quantity':  uploadedProductOdData.stockQuantity ?? '',
              'status':  uploadedProductOdData.isActive ?? '',
              'approval':  uploadedProductOdData.isApproved ?? '',
              'productIDs':  uploadedProductOdData.productId ?? '',
              'selected': false,
              'action': 'Delete',
            };
            uploadedProductOdDataList!.add(mapData);
          }

        });

        setState(() {
          if (currentPage == 1) {
            data = dataList;
          }
          else {
            data!.addAll(dataList);
            _refreshController.loadComplete();
          }

          isHashLoad = currentPage! > getUploadedProductResponse.totalPages!;
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



  List<Map<String, dynamic>>? uploadedProductOdDataList = []; // Assuming this is your data list

  var selectedCheckBoxs = '';

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, '/bottomNavigationBarScreen', (route) => false,);
        return false; // Prevent default back navigation
      },
      child: AppLayout(
        title: "Your Manage Products",
        titleStyle: ConstantTextStyle.landingScreenAppbarText,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: ConstantColor.primaryBackgroundMainColor,
          onPressed: () async => Navigator.pushNamedAndRemoveUntil(context, '/bottomNavigationBarScreen', (route) => false,),
        ),
        // actions: [
        //   PopupMenuButton(
        //     offset: Offset(-screenWidth/30, screenHeight/14),
        //     icon: const Icon(Icons.more_vert_rounded, color: ConstantColor.primaryBackgroundMainColor),
        //     onSelected: (newValue) {
        //       if (newValue == 0) {
        //         Navigator.pushNamed(context, '/addNewProductScreen');
        //       } else {
        //         YesNoPermissionDialog.showExitConfirmationDialog(
        //           context:context,
        //           title: 'Please Confirm!',
        //           content: 'Are you sure want to delete this Product?',
        //           actions: [
        //             customButton(
        //               textStyleButton: ConstantTextStyle.landingScreenAppbarText,
        //               onPressed:() async {
        //                 Navigator.pop(context);
        //                 if (selectedCheckBoxs.isEmpty || selectedCheckBoxs == null) {
        //                   LoadingScaffoldMessage.showSnackbar(
        //                     context,
        //                     "Please select at least one card!",
        //                     ConstantColor.primaryMainColor,
        //                     const Duration(seconds: 2),
        //                   );
        //                 } else {
        //                   await fetchSellerRegistrationBodyApi(
        //                     context: context,
        //                     baseUrl: '${ConstantUrls.baseUriApi}${ConstantUrls.getBulkDeleteProductsEndPoint}',
        //                     body: {"products_ids": selectedCheckBoxs.toString()},
        //                     onSuccess: () {
        //                       setState(() {
        //                         currentPage = 1;
        //                         isLoading = true;
        //                         selectedCheckBoxs = '';
        //                         data!.clear();
        //                         uploadedProductOdDataList!.clear();
        //                         fetchUploadedProductListData();
        //                       });
        //                     },
        //                   );
        //                 }
        //               },
        //               text: "Yes",
        //               backgroundColor: ConstantColor.loginWithOtpButtonColor,
        //               borderRadius: BorderRadius.circular(20.0),
        //               elevation: 0.0,
        //             ),
        //             constantWidth(context, 100.0),
        //             customButton(
        //               textStyleButton: ConstantTextStyle.landingScreenAppbarText,
        //               onPressed:() => Navigator.pop(context),
        //               text: "No",
        //               backgroundColor: ConstantColor.primaryMainColor,
        //               borderRadius: BorderRadius.circular(20.0),
        //               elevation: 0.0,
        //             ),
        //           ],
        //         );
        //       }
        //     },
        //     itemBuilder: (context) => [
        //       PopupMenuItem(
        //         value: 0,
        //         child: Container(
        //           padding: const EdgeInsets.all(10.0),
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(8.0),
        //             color: ConstantColor.primaryMainColor,
        //           ),
        //           child: Row(
        //             children: [
        //               const Icon(Icons.add_shopping_cart_rounded, color: ConstantColor.primaryBackgroundMainColor, size: 16.0),
        //               constantWidth(context, 80.0),
        //               customeText(
        //                 text: 'Add New Product',
        //                 style: ConstantTextStyle.chipText,
        //                 textAlign: TextAlign.center,
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //       PopupMenuItem(
        //         value: 2,
        //         child: Container(
        //           padding: const EdgeInsets.all(10.0),
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(8.0),
        //             color: ConstantColor.loginWithOtpButtonColor,
        //           ),
        //           child: Row(
        //             children: [
        //               const Icon(Icons.delete_sweep_outlined, color: ConstantColor.primaryBackgroundMainColor, size: 16.0),
        //               constantWidth(context, 80.0),
        //               customeText(
        //                 text: 'Delete Selected Product',
        //                 style: ConstantTextStyle.chipText,
        //                 textAlign: TextAlign.center,
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ],
        scaffoldColor: ConstantColor.primaryBackgroundMainColor,
        bottomNavigationBar:bottomButtons(
          context: context,
          icon1: Icons.add_shopping_cart_rounded,
          icon2: Icons.delete_sweep_outlined,
          lable1: 'Add New Product\t\t\t\t\t',
          lable2: 'Delete Selected Product',
          onTap1: () async => await Navigator.pushNamed(context, '/addNewProductScreen'),
          onTap2: () async => await YesNoPermissionDialog.showExitConfirmationDialog(
            context:context,
            title: 'Please Confirm!',
            content: 'Are you sure want to delete this Product?',
            actions: [
              customButton(
                textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                onPressed:() async {
                  Navigator.pop(context);
                  if (selectedCheckBoxs.isEmpty || selectedCheckBoxs == null) {
                    LoadingScaffoldMessage.showSnackbar(
                      context,
                      "Please select at least one card!",
                      ConstantColor.primaryMainColor,
                      const Duration(seconds: 2),
                    );
                  } else {
                    await fetchSellerRegistrationBodyApi(
                      context: context,
                      baseUrl: '${ConstantUrls.baseUriApi}${ConstantUrls.getBulkDeleteProductsEndPoint}',
                      body: {"products_ids": selectedCheckBoxs.toString()},
                      onSuccess: () {
                        setState(() {
                          currentPage = 1;
                          isLoading = true;
                          selectedCheckBoxs = '';
                          data!.clear();
                          uploadedProductOdDataList!.clear();
                          fetchUploadedProductListData();
                        });
                      },
                    );
                  }
                },
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
        ),

        appBarColor: ConstantColor.loginWithOtpButtonColor,
        body: CupertinoScrollbar(
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: !isHashLoad,
            controller: _refreshController,
            footer: customFooter(),
            onRefresh: () async {
              searchController.clear();
              selectedCheckBoxs = '';
              currentPage = 1;
              await fetchUploadedProductListData();
              _refreshController.refreshCompleted();
            },
            onLoading: () async {
              await fetchUploadedProductListData();
            },
            child:

            data == null || data!.toString().isEmpty ? noDataFound(context) :
            isLoading ? const Center(child: CircularProgressIndicator()):
            ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: screenWidth/30, vertical: screenHeight/40),
              itemCount: uploadedProductOdDataList?.length ?? 0,
              itemBuilder: (context, index) {
                var data = uploadedProductOdDataList![index];
                var odStatus = data['status'].toString() == "1" ? "Active" : "Inactive";
                var odApprove = data['approval'].toString() == "1" ? "Approved" : "Pending";
                bool isSelected = data['selected'] ?? false; // Track selection status

                return
                  GestureDetector(
                    onDoubleTap: () async => await Navigator.push(context,MaterialPageRoute(builder: (context) => ViewProductScreen(productId: data['productIDs'].toString()??"")),),
                    onLongPress: () {
                      setState(() {
                        data['selected'] = !(data['selected'] ?? false); // Toggle selection
                        if (data['selected']) {
                          selectedCheckBoxs += selectedCheckBoxs.isEmpty ? data['productIDs'].toString() : ",${data['productIDs']}";
                        } else {
                          List<String> ids = selectedCheckBoxs.split(',');
                          ids.remove(data['productIDs'].toString());
                          selectedCheckBoxs = ids.join(',');
                        }
                      });
                    },
                    child: Slidable(
                      key: Key(data['productIDs'].toString()),
                      startActionPane: ActionPane(
                        motion: const StretchMotion(),
                        children: [
                          SlidableAction(
                            onPressed:(direction) async {
                              await fetchSellerRegistrationBodyApi(
                                context: context,
                                baseUrl: '${ConstantUrls.baseUriApi}${ConstantUrls.getBulkDeleteProductsEndPoint}',
                                body: {"products_ids": data['productIDs'].toString()},
                                onSuccess: () {
                                  setState(() {
                                    currentPage = 1;
                                    isLoading = true;
                                    selectedCheckBoxs = '';
                                    data!.clear();
                                    uploadedProductOdDataList!.clear();
                                    fetchUploadedProductListData();
                                  });
                                },
                              );
                            },
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete_forever,
                            label: 'Delete',
                          ),
                        ],
                      ),
                    // Dismissible(
                    //   key: Key(data['productIDs'].toString()),
                    //   direction: DismissDirection.endToStart,
                    //   background: Container(
                    //     alignment: Alignment.centerRight,
                    //     color: ConstantColor.primaryMainColor,
                    //     padding: EdgeInsets.symmetric(horizontal: screenWidth/20.0),
                    //     child:  Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         const Icon(Icons.delete_forever,
                    //             color: ConstantColor.primaryBackgroundMainColor),
                    //         customeText(text: "Delete",
                    //             style: ConstantTextStyle.loginButtonTextStyle)
                    //       ],
                    //     ),
                    //   ),
                    //   onDismissed: (direction) async {
                    //     await fetchSellerRegistrationBodyApi(
                    //       context: context,
                    //       baseUrl: '${ConstantUrls.baseUriApi}${ConstantUrls.getBulkDeleteProductsEndPoint}',
                    //       body: {"products_ids": data['productIDs'].toString()},
                    //       onSuccess: () {
                    //         setState(() {
                    //           currentPage = 1;
                    //           isLoading = true;
                    //           selectedCheckBoxs = '';
                    //           data!.clear();
                    //           uploadedProductOdDataList!.clear();
                    //           fetchUploadedProductListData();
                    //         });
                    //       },
                    //     );
                    //   },
                      child: Stack(
                        children: [
                          // Card(
                          Container(// color: ConstantColor.primaryBackgroundMainColor,
                            margin: EdgeInsets.symmetric(vertical: screenHeight / 40.0),
                            decoration: BoxDecoration(
                              color: isSelected ? ConstantColor.carColor2 :ConstantColor.primaryBackgroundMainColor,
                              border: Border.all(color: ConstantColor.secondtryGrayColor),
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: isSelected ? Colors.black26 : Colors.black12,
                                  offset: const Offset(0, 2),
                                  blurRadius: 4.0,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  cachedImageWidget(
                                    context:context,
                                    height: screenHeight / 18.0,
                                    imageFile: data['productImg'].toString()??"",
                                    assetImageFit: BoxFit.fill,
                                  ),
                                  SizedBox(width: screenWidth/40.0),
                                  // Product Details
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            width: screenWidth/2.2,
                                            child: customeText(text: 'Product Name : ${data['productName'] ?? ""}', style: ConstantTextStyle.allHomeScreenAvatarText)),
                                        customeText(text:'Category : ${data['category'] ?? ""}', style: ConstantTextStyle.allHomeScreenAvatarText),
                                        customeText(text:'Modal : ${data['model'] ?? ""}', style: ConstantTextStyle.allHomeScreenAvatarText),
                                        customeText(text:data['brand'] ?? "", style: ConstantTextStyle.allHomeScreenAvatarText),
                                        Row(children: [
                                          customeText(
                                            text: "₹ ${data['price'].toString() ?? ""}",
                                            style: (data['offerPrice'] != null && data['offerPrice'].toString().isNotEmpty && data['offerPrice'].toString() != "0.00") ? ConstantTextStyle.greyCancelText : ConstantTextStyle.dropDownPrimeText, // Changed to dropDownPrimeText
                                          ),
                                          SizedBox(width: screenWidth/80.0),
                                          if (data['offerPrice'] != null && data['offerPrice'].toString().isNotEmpty && data['offerPrice'].toString() != "0.00")
                                            customeText(
                                              text: "₹ ${data['offerPrice'].toString() ?? ""}",
                                              style: ConstantTextStyle.dropDownPrimeText,
                                            ),
                                        ],),
                                        colorBoxWidget(
                                          margin: EdgeInsets.only(right: screenWidth/8.0,top: screenHeight/80.0,bottom: screenHeight/80.0),
                                          textAlign: TextAlign.center,
                                          context:context,
                                          color: ConstantColor.calendarBGHeadColor,
                                          text: 'Quantity : ${data['quantity'].toString()??""}',
                                          style: ConstantTextStyle.tabButtonTextStyle,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(color: getStatusColor(odStatus.toUpperCase()), borderRadius: BorderRadius.circular(5.0)),
                                                child: Center(child: Text(odStatus, style: ConstantTextStyle.chipText)),
                                              ),
                                            ),
                                            SizedBox(width: screenWidth/40.0),
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(color: getStatusColor(odApprove.toUpperCase()), borderRadius: BorderRadius.circular(5.0)),
                                                child: Center(child: Text(odApprove, style: ConstantTextStyle.chipText)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: FilledButton.icon(
                                style: FilledButton.styleFrom(
                                    backgroundColor: ConstantColor.calendarBGHeadColor),
                                onPressed: () async => await Navigator.push(context,MaterialPageRoute(builder: (context) => EditProductScreen(productId: data['productIDs'].toString()??"")),),
                                icon: const Icon(Icons.edit_outlined,color: ConstantColor.primaryMainColor,),
                                label: Text("Edit",style: ConstantTextStyle.sellerHintTextStyle,)),
                          ),

                        ],
                      ),
                    ),
                  );
              },
            ),
          ),
        ),
      ),
    );
  }
}

//   Widget build(BuildContext context) {
//     var screenHeight = MediaQuery.of(context).size.height;
//     var screenWidth = MediaQuery.of(context).size.width;
//     return   WillPopScope(
//       onWillPop: () async {
//         Navigator.pushNamedAndRemoveUntil(context, '/bottomNavigationBarScreen', (route) => false,);
//         return false; // Prevent default back navigation
//       },
//       child: AppLayout(
//           title: "Your Manage Products",
//           titleStyle: ConstantTextStyle.landingScreenAppbarText,
//           leading: IconButton(
//               icon: const Icon(Icons.arrow_back), color: ConstantColor.primaryBackgroundMainColor,
//               onPressed: () async => Navigator.pushNamedAndRemoveUntil(context, '/bottomNavigationBarScreen', (route) => false,),
//             // Navigator.pop(context)
//           ),
//           actions: [
//             PopupMenuButton(
//               offset: Offset(-screenWidth/30, screenHeight/14),
//               icon: const Icon(Icons.more_vert_rounded, color: ConstantColor.primaryBackgroundMainColor),
//               onSelected: (newValue) {
//                 if (newValue == 0) {
//                   Navigator.pushNamed(context, '/addNewProductScreen');
//                 }else{
//                   YesNoPermissionDialog.showExitConfirmationDialog(
//                     context:context, title: 'Please Confirm!', content: 'Are you sure want to delete this Product?',
//                     actions: [
//                       customButton(
//                         textStyleButton: ConstantTextStyle.landingScreenAppbarText,
//                         onPressed:() async {
//                           Navigator.pop(context);
//                           if (selectedCheckBoxs.isEmpty || selectedCheckBoxs == null ){
//                             LoadingScaffoldMessage.showSnackbar(
//                               context,
//                               "Please select at least one check box!",
//                               ConstantColor.primaryMainColor,
//                               const Duration(seconds: 2),
//                             );
//                           }else{
//                             await fetchSellerRegistrationBodyApi(
//                               context: context,
//                               baseUrl: '${ConstantUrls.baseUriApi}${ConstantUrls.getBulkDeleteProductsEndPoint}',
//                               body: {"products_ids": selectedCheckBoxs.toString()},
//                               onSuccess: ()  {
//                                 setState(()  {
//                                   currentPage = 1;
//                                   isLoading = true;
//                                   selectedCheckBoxs = '';
//                                   data!.clear();
//                                   uploadedProductOdDataList!.clear();
//                                   fetchUploadedProductListData();
//                                 });
//                               },
//                             );
//                           }
//                         },
//                         text: "Yes",
//                         backgroundColor: ConstantColor.loginWithOtpButtonColor,
//                         borderRadius: BorderRadius.circular(20.0),
//                         elevation: 0.0,
//                       ),
//                       constantWidth(context, 100.0),
//                       customButton(
//                         textStyleButton: ConstantTextStyle.landingScreenAppbarText,
//                         onPressed:() => Navigator.pop(context),
//                         text: "No",
//                         backgroundColor: ConstantColor.primaryMainColor,
//                         borderRadius: BorderRadius.circular(20.0),
//                         elevation: 0.0,
//                       ),
//
//                     ],
//
//                   );
//                 }
//               },
//               itemBuilder: (context) => [
//                 PopupMenuItem(
//                   value: 0,
//                   child: Container(
//                     padding: const EdgeInsets.all(10.0),
//                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),
//                       color: ConstantColor.primaryMainColor,),
//                     child: Row(
//                       children: [
//                         const Icon(Icons.add_shopping_cart_rounded, color: ConstantColor.primaryBackgroundMainColor,size: 16.0,), // Add video icon
//                         constantWidth(context,80.0),
//                         customeText(
//                           text: 'Add New Product',
//                           style: ConstantTextStyle.chipText,
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 PopupMenuItem(
//                   value: 2,
//                   child: Container(
//                     padding: const EdgeInsets.all(10.0),
//                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),
//                       color: ConstantColor.loginWithOtpButtonColor,),
//                     child: Row(
//                       children: [
//                         const Icon(Icons.delete_sweep_outlined, color: ConstantColor.primaryBackgroundMainColor,size: 16.0,), // Add video icon
//                         constantWidth(context,80.0),
//                         customeText(
//                           text: 'Delete Selected Product',
//                           style: ConstantTextStyle.chipText,
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           ],
//           scaffoldColor: ConstantColor.primaryBackgroundMainColor,
//           appBarColor: ConstantColor.loginWithOtpButtonColor,
//           body: CupertinoScrollbar(
//             child: SmartRefresher(
//                 enablePullDown: true,
//                 enablePullUp: isHashLoad == false ? true: false,
//                 controller: _refreshController,
//                 footer: customFooter(),
//                 onRefresh: () async {
//                   searchController.clear();
//                   selectedCheckBoxs = '';
//                   currentPage = 1;
//                   await fetchUploadedProductListData();
//                   _refreshController.refreshCompleted();
//                 },
//                 onLoading: () async {
//                   await fetchUploadedProductListData();
//                   // _refreshController.loadComplete();
//                 },
//
//                 child: data == null || data!.toString().isEmpty ? noDataFound(context):
//                 ListView(
//                   controller: _scrollController,
//                   padding: EdgeInsets.symmetric(horizontal: screenWidth/30,vertical: screenHeight/40),
//                   children: [
//                     // customeText(text: "\tManage Products",style: ConstantTextStyle.topCategoryText4),
//                     // constantHeight(context, 40.0),
//
//                     customTextFormField(
//                       filled: true,
//                       autofocus: false,
//                       onChanged: (value) {
//                         setState(() {
//                           value = searchController.text.toString();
//                         });
//                       },
//                       formBorderRadius : const BorderRadius.all(Radius.circular(8.0)),
//                       controller: searchController,
//                       fillColor: ConstantColor.primaryBackgroundMainColor,
//                       borderSideColor:ConstantColor.transparent1,
//                       focusNode: null,
//                       context: context,
//                       iconButton: IconButton,
//                       hintText: "Search",
//                       cursorColor: ConstantColor.primaryMainColor,
//                       keyboardType: TextInputType.text,
//                       onFieldSubmitted: (searchController.text.toString().isEmpty)?null:(value) async {
//                         currentPage = 1;
//                         isLoading = true;
//                         data!.clear();
//                         await  fetchUploadedProductListData();
//                       },
//                       suffixIcon:
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: screenWidth / 40, vertical: screenHeight / 100),
//                         child: customButton(
//                           textStyleButton: ConstantTextStyle.otpResendButtonText,
//                           onPressed: (searchController.text.toString().isEmpty)?null:() async {
//                             currentPage = 1;
//                             isLoading = true;
//                             data!.clear();
//                             await  fetchUploadedProductListData();
//                           },
//                           text: searchController.text.toString().isEmpty ? "Search": "Click Me",
//                           backgroundColor: ConstantColor.secondryBackgroundMainColor,
//                           borderRadius: BorderRadius.circular(6.0),
//                           elevation: 1.0,
//                         ),
//                       ),
//                     ),
//
//                     constantHeight(context, 40.0),
//                     Skeletonizer(
//                       enabled: isLoading,
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.vertical,
//                         child: SingleChildScrollView(
//                           controller: _scrollController,
//                           scrollDirection: Axis.horizontal,
//                           child: Table(
//                             columnWidths: {
//                               0: FixedColumnWidth(screenWidth * 0.3),
//                               1: FixedColumnWidth(screenWidth * 0.3),
//                               2: FixedColumnWidth(screenWidth * 0.3),
//                               3: FixedColumnWidth(screenWidth * 0.3),
//                               4: FixedColumnWidth(screenWidth * 0.3),
//                               5: FixedColumnWidth(screenWidth * 0.3),
//                               6: FixedColumnWidth(screenWidth * 0.3),
//                               7: FixedColumnWidth(screenWidth * 0.3),
//                               8: FixedColumnWidth(screenWidth * 0.3),
//                               9: FixedColumnWidth(screenWidth * 0.3),
//                               10: FixedColumnWidth(screenWidth * 0.3),
//                             },
//                             children: [
//                               // Table header row
//                               TableRow(
//
//                                 decoration:  BoxDecoration(
//                                   color: ConstantColor.calendarBGHeadColor,
//                                   borderRadius: BorderRadius.circular(8.0),
//                                   // border: Border(bottom: BorderSide(color: ConstantColor.textFieldColor)),
//                                 ),
//                                 children: [
//                                   TableCell(child: paddingText(context: context, title:"\t\t\tSelect Box",)),
//                                   TableCell(child: paddingText(context: context, title:"Image",)),
//                                   TableCell(child: paddingText(context: context, title:"Product Name",)),
//                                   TableCell(child: paddingText(context: context, title:"Category",)),
//                                   TableCell(child: paddingText(context: context, title:"Model",)),
//                                   TableCell(child: paddingText(context: context, title:"Brand",)),
//                                   TableCell(child: paddingText(context: context, title:"Price",)),
//                                   TableCell(child: paddingText(context: context, title:"Quantity",)),
//                                   TableCell(child: paddingText(context: context, title:"Status",)),
//                                   TableCell(child: paddingText(context: context, title:"Approval",)),
//                                   TableCell(child: paddingText(context: context, title:"Action",)),
//                                 ],
//                               ),
//                               // Data rows
//                               ...uploadedProductOdDataList!.map((data) {
//                                 var odStatus = data['status'].toString() == "1" ? "Active" : "Inactive";
//                                 var odApprove = data['approval'].toString() == "1" ? "Approved" : "Pending";
//                                 return TableRow(
//                                   decoration: const BoxDecoration(
//                                     border: Border(bottom: BorderSide(color: ConstantColor.textFieldColor)),
//                                   ),
//                                   children: [
//                                     // TableCell(
//                                     //   child: Container(
//                                     //     margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
//                                     //     child: customeText(
//                                     //       text: '\t\t\t\t\t${(uploadedProductOdDataList!.indexOf(data) + 1).toString()??""}',
//                                     //       textAlign: TextAlign.start,
//                                     //       style: ConstantTextStyle.allHomeScreenAvatarText,
//                                     //     ),
//                                     //   ),
//                                     // ),
//                                     TableCell(
//                                       child: Align(
//                                         alignment: Alignment.center,
//                                         child: customeCheckbox(
//                                           checkColor: ConstantColor.primaryBackgroundMainColor,
//                                           activeColor: ConstantColor.primaryMainColor,
//                                           value: data['selected'],
//                                           onChanged: (bool? value) {
//                                             setState(() {
//                                               data['selected'] = value ?? false;
//                                               if (value == true) {
//                                                 if (selectedCheckBoxs.isEmpty) {
//                                                   selectedCheckBoxs = "${data['productIDs']}";
//                                                 } else {
//                                                   selectedCheckBoxs += ",${data['productIDs']}";
//                                                 }
//                                               } else {
//                                                 // Remove current id from selectedCheckBoxs string
//                                                 List<String> ids = selectedCheckBoxs.split(',');
//                                                 ids.remove("${data['productIDs']}");
//                                                 selectedCheckBoxs = ids.join(',');
//                                               }
//                                             });
//                                           },
//                                         ),
//                                       ),
//                                     ),
//
//                                     TableCell(
//                                       child: Container(
//                                         padding: EdgeInsets.only(right: screenWidth / 20.0,top: screenHeight/80.0,bottom: screenHeight/80.0),
//                                         child: cachedImageWidget(
//                                           context:context,
//                                           height: screenHeight / 18.0,
//                                           imageFile: data['productImg'].toString()??"",
//                                           assetImageFit: BoxFit.fill,
//                                         ),
//                                       ),
//                                     ),
//                                     TableCell(
//                                       child: Container(
//                                         margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
//                                         child: customeText(
//                                           text: data['productName'] ?? "",
//                                           textAlign: TextAlign.start,
//                                           style: ConstantTextStyle.allHomeScreenAvatarText,
//                                         ),
//                                       ),
//                                     ),
//                                     TableCell(
//                                       child: Container(
//                                         margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
//                                         child: customeText(
//                                           text: data['category'] ?? "",
//                                           textAlign: TextAlign.start,
//                                           style: ConstantTextStyle.allHomeScreenAvatarText,
//                                         ),
//                                       ),
//                                     ),
//                                     TableCell(
//                                       child: Container(
//                                         margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
//                                         child: customeText(
//                                           text: data['model'] ?? "",
//                                           textAlign: TextAlign.start,
//                                           style: ConstantTextStyle.allHomeScreenAvatarText,
//                                         ),
//                                       ),
//                                     ),
//                                     TableCell(
//                                       child: Container(
//                                         margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
//                                         child: customeText(
//                                           text: data['brand'] ?? "",
//                                           textAlign: TextAlign.start,
//                                           style: ConstantTextStyle.allHomeScreenAvatarText,
//                                         ),
//                                       ),
//                                     ),
//                                     TableCell(
//                                       child: Container(
//                                         margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             customeText(
//                                               text: "₹ ${data['price'].toString() ?? ""}",
//                                               style: (data['offerPrice'] != null && data['offerPrice'].toString().isNotEmpty && data['offerPrice'].toString() != "0.00") ? ConstantTextStyle.greyCancelText : ConstantTextStyle.dropDownPrimeText, // Changed to dropDownPrimeText
//                                             ),
//                                             if (data['offerPrice'] != null && data['offerPrice'].toString().isNotEmpty && data['offerPrice'].toString() != "0.00")
//                                               customeText(
//                                                 text: "₹ ${data['offerPrice'].toString() ?? ""}",
//                                                 style: ConstantTextStyle.dropDownPrimeText,
//                                               ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     TableCell(
//                                       child: colorBoxWidget(
//                                         margin: EdgeInsets.only(right: screenWidth/8.0,top: screenHeight/80.0,bottom: screenHeight/80.0),
//                                         textAlign: TextAlign.center,
//                                         context:context,
//                                         color: ConstantColor.calendarBGHeadColor,
//                                         text: data['quantity'].toString()??"",
//                                         style: ConstantTextStyle.tabButtonTextStyle,
//                                       ),
//                                     ),
//                                     TableCell(
//                                       child: Container(
//                                         margin: EdgeInsets.only(top: screenHeight / 80.0,bottom: screenHeight / 80.0, right: screenWidth /10.0),
//                                         decoration: BoxDecoration(color: getStatusColor(odStatus.toUpperCase()), borderRadius: BorderRadius.circular(5.0)),
//                                         child: customeText(text: odStatus.toString()??"", textAlign: TextAlign.center, style:  ConstantTextStyle.chipText
//                                         ),
//                                       ),
//                                     ),
//                                     TableCell(
//                                       child: Container(
//                                         margin: EdgeInsets.only(top: screenHeight / 80.0,bottom: screenHeight / 80.0, right: screenWidth /14.0),
//                                         decoration: BoxDecoration(color: getStatusColor(odApprove.toUpperCase()), borderRadius: BorderRadius.circular(5.0)),
//                                         child: customeText(text: odApprove.toString()??"", textAlign: TextAlign.center, style:  ConstantTextStyle.chipText
//                                         ),
//                                       ),
//                                     ),
//                                     TableCell(
//                                         child:
//                                         createIconButtonCell(
//                                           context: context,
//                                           icon1: Icons.remove_red_eye_outlined,
//                                           onPressed1: () => Navigator.push(context,MaterialPageRoute(builder: (context) => ViewProductScreen(productId: data['productIDs'].toString()??"")),),
//                                           icon2: Icons.edit,
//                                           onPressed2: () => Navigator.push(context,MaterialPageRoute(builder: (context) => EditProductScreen(productId: data['productIDs'].toString()??"")),),
//                                           icon3: Icons.delete,
//                                           onPressed3: () {
//                                             YesNoPermissionDialog.showExitConfirmationDialog(
//                                               context:context, title: 'Please Confirm!', content: 'Are you sure want to delete this Product?',
//                                               actions: [
//                                                 customButton(
//                                                   textStyleButton: ConstantTextStyle.landingScreenAppbarText,
//                                                   onPressed:() async {
//                                                     Navigator.pop(context);
//                                                     await fetchSellerRegistrationBodyApi(
//                                                       context: context,
//                                                       baseUrl: '${ConstantUrls.baseUriApi}${ConstantUrls.getBulkDeleteProductsEndPoint}',
//                                                       body: {"products_ids": data['productIDs'].toString()},
//                                                       onSuccess: ()  {
//                                                         setState(()  {
//                                                           currentPage = 1;
//                                                           isLoading = true;
//                                                            selectedCheckBoxs = '';
//                                                           data!.clear();
//                                                           uploadedProductOdDataList!.clear();
//                                                           fetchUploadedProductListData();
//                                                         });
//                                                       },
//                                                     );
//                                                   },
//                                                   text: "Yes",
//                                                   backgroundColor: ConstantColor.loginWithOtpButtonColor,
//                                                   borderRadius: BorderRadius.circular(20.0),
//                                                   elevation: 0.0,
//                                                 ),
//                                                 constantWidth(context, 100.0),
//                                                 customButton(
//                                                   textStyleButton: ConstantTextStyle.landingScreenAppbarText,
//                                                   onPressed:() => Navigator.pop(context),
//                                                   text: "No",
//                                                   backgroundColor: ConstantColor.primaryMainColor,
//                                                   borderRadius: BorderRadius.circular(20.0),
//                                                   elevation: 0.0,
//                                                 ),
//
//                                               ],
//
//                                             );
//                                           },
//                                         )
//                                     ),
//                                   ],
//                                 );
//                               }),
//                             ],
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 )
//             ),
//           )
//       ),
//     );
//   }
// }

Widget paddingText({context, title, textAlign}){
  var screenHeight = MediaQuery.of(context).size.height;
  return Padding(
    padding: EdgeInsets.symmetric(vertical:screenHeight/60.0),
    child: customeText(
      text: title??"",
      textAlign: textAlign ?? TextAlign.start,
      style: ConstantTextStyle.tabButtonTextStyle,
    ),
  );
}
