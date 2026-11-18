// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:Citybazar_app/Util/constaint_textstyle.dart';
import 'package:Citybazar_app/Util/constant_color.dart';
import 'package:Citybazar_app/Util/constant_image.dart';
import 'package:Citybazar_app/Widgets/custome_button_.dart';
import 'package:Citybazar_app/Widgets/custome_richtext.dart';
import 'package:Citybazar_app/Widgets/custome_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../Api Services/Card Api Services/My Addess Services/my_address_submit_api_services.dart';
import '../../Api Services/Card Api Services/add_to_card_api_services.dart';
import '../../Api Services/Card Api Services/card_address_api_services.dart';
import '../../Api Services/Card Api Services/card_checkout_get_api_services.dart';
import '../../Api Services/Card Api Services/get_card_product_count.dart';
import '../../Models/Card Details Model/card_address_model.dart';
import '../../Models/Card Details Model/card_checkout_details_model.dart';
import '../../Util/Constant APi Url/api_urls.dart';
import '../../View/order_view.dart';
import '../../Widgets/Card Details Widgets/Card Images/asset_images_widget.dart';
import '../../Widgets/Card Details Widgets/Card Images/cached_images_widget.dart';
import '../../Widgets/Card Details Widgets/Permition Dialog/permition_dialog_widget.dart';
import '../../Widgets/Card Details Widgets/card_details_header_widget.dart';
import '../../Widgets/Famous Market Widget/store_details_widget.dart';
import '../../collapsing_appbar.dart';
import '../Product View Screens/product_Item_Details.dart';
import '../User Profile My Account/Dashboard/Order Screen/order_screen.dart';
import 'Checkout Card Add Address/checkout_card_add_address.dart';
import 'Checkout Card Add Address/checkout_card_change_address.dart';

class CardCheckoutDetailsScreen extends StatefulWidget {
  final id;
  final sellerId;
  final lName;
  final lattude;
  final longitude;
  const CardCheckoutDetailsScreen({super.key, this.lattude, this.longitude, this.id, this.lName, this.sellerId});

  @override
  State<CardCheckoutDetailsScreen> createState() => _CardCheckoutDetailsScreenState();
}

class _CardCheckoutDetailsScreenState extends State<CardCheckoutDetailsScreen> {

  @override
  void initState() {
    super.initState();
    fetchCardProductsListData();
    fetchCardAddressData();
  }
  dynamic currentPage = 1;
  // final ScrollController _scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    // _scrollController.dispose();
    searchController.dispose();
    // selectedCheckBoxs = '';
    super.dispose();
  }

  bool isPullToRefreshEnabled = true;
  var limit = '12';
  bool isLoading = false;
  bool isHashLoad = false;

  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  CheckOutCartModel? cardDetailsModel;
  List<CheckOutCartData>? data = [];
  List<Address>? addressData = [];

  Future<void> fetchCardProductsListData() async {
    try {
      if (currentPage == 1) {
        setState(() {
          isLoading = true;
          data!.clear();
          // pendingProductOdDataList!.clear();
        });
      }

      final getCardDetailsResponse = await CardCheckoutDetailsApiService.fetchCardDetailsData(context: context,sellerId: widget.sellerId??"");

      if (getCardDetailsResponse != null && getCardDetailsResponse.data != null) {

        final dataList = getCardDetailsResponse.data!;
        addressData = getCardDetailsResponse.address??[];
        setState(() {
          data = dataList;
        });
        setState(() {
          if (currentPage == 1) {
            data = dataList;
          }
          else {
            data!.addAll(dataList);
            _refreshController.loadComplete();
          }
          isLoading = false;
          // currentPage++;
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

  //-------------------------------
  //CardAddressApiService
  CardAddressModel? cardAddressModel;
  List<CardAddressData>? cardAddressData = [];
  List<CardAddressData>? cardAddressDataCheck = [];

  Future<void> fetchCardAddressData() async {
    try {
      setState(() {
        isLoading = true;
        cardAddressData!.clear();
        cardAddressDataCheck!.clear();
      });

      final getCardAddressResponse = await CardAddressApiService.fetchCardAddressData(context: context);
      if (getCardAddressResponse != null && getCardAddressResponse.data != null) {
        setState(() {
          cardAddressData = getCardAddressResponse.data!.where((data) => data.deflate == "1").toList();
          cardAddressDataCheck = getCardAddressResponse.data??[];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  //-------------------------------
  //CardDeleteApiService
  ProductCount? productCount;
  Future<void> fetchProductCount() async {
    setState(() {
      isLoading = true; // Set loading state
    });

    try {
      final productCountResponse = await CardProductCountApiService.cardProductCountData(context: context);

      setState(() {
        isLoading = false; // Reset loading state
        productCount = productCountResponse; // Update productCount with API response
      });
    } catch (e) {
      setState(() {
        isLoading = false; // Reset loading state on error
      });
    }
  }

  //--------home-page-navigation
  Future<bool> onWillPop() async {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => MyHomePageDemo1(mobilenumber: '', lat: widget.lattude??"", longitude: widget.longitude??"", id: widget.id??"", lName: widget.lName??"")),);
    return true;
  }

  //-------place order handle funtion --------
  void _handlePlaceOrderSubmit() {
    YesNoPermissionDialog.showExitConfirmationDialog(
      context:context, title: 'Please Confirm!', content: 'Citybazaronline do not sell product. Order will be placed to corresponding seller. You should discuss payment terms, return policy and delivery conditions with seller.',
      actions: [
        customeButton(
          textStyleButton: ConstantTextStyle.landingScreenAppbarText,
          onPressed:() {
            Navigator.pop(context);
            fetchSubmitFormApiService(
              context: context,
              baseUrl: '${ConstantUrls.baseUriApi}${ConstantUrls.placeOrderEndPoint}',
              body: {"seller_id":widget.sellerId??""},
              onSuccess: () async {
                data?.clear();
                cardAddressData?.clear();
                cardAddressDataCheck?.clear();
                await fetchCardAddressData();
                await fetchProductCount();
                await fetchCardProductsListData();
                Get.to(
                      () => const OrderView(),
                  arguments: {'id': widget.id, "lName": widget.lName, "latitude": widget.lattude, "longitude": widget.longitude}, // Pass your arguments here
                );
                // Navigator.push(context, MaterialPageRoute(
                //     builder: (context) => OrderScreen(latitude: widget.lattude??"",
                //         longitude: widget.longitude??"", id: widget.id??"", lName: widget.lName??"")),
                // );
              },
            );
          },
          text: "Confirm",
          backgroundColor: ConstantColor.loginWithOtpButtonColor,
          borderRadius: BorderRadius.circular(20.0),
          elevation: 0.0,
        ),
       const SizedBox(width: 10.0,),
        customeButton(
          textStyleButton: ConstantTextStyle.landingScreenAppbarText,
          onPressed:() => Navigator.pop(context),
          text: "Cancel",
          backgroundColor: ConstantColor.primaryMainColor,
          borderRadius: BorderRadius.circular(20.0),
          elevation: 0.0,
        ),
      ],
    );
    }


  var quantity = 1;

  @override
  Widget build(BuildContext context) {

    var screenH = MediaQuery.of(context).size.height;
    var screenW = MediaQuery.of(context).size.width;
    return
      Scaffold(
        backgroundColor: ConstantColor.secondryBackgroundMainColor,
        // backgroundColor: ConstantColor.primaryBackgroundMainColor,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: false,
          leading: IconButton(icon:const Icon(Icons.arrow_back),onPressed: ()=>Navigator.pop(context),),
          title:customeText(text: "Cart Details",style: ConstantTextStyle.appBarTitleText),
          backgroundColor: ConstantColor.loginWithOtpButtonColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenW/30.0,vertical: screenH/80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customeText(text: "Checkout Cart Details",style: ConstantTextStyle.passwordScreenLineTexStyle),
                SizedBox(height: screenH/80.0,),
                isLoading
                    ?  const SpinKitCircle(color: ConstantColor.primaryMainColor, size: 40.0)
                    : (data != null && data!.isNotEmpty && data!.toString().isNotEmpty)
                    ? Container(
                  width: screenW,
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: ConstantColor.primaryBackgroundMainColor,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: ConstantColor.progressBGolor)
                  ),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data?.length ?? 0,
                      itemBuilder: (context, index) {
                      var  sum =   0.0;
                      double totalPrice = 0.0;

                        return  Column(
                         children: [
                           (data![index].cart != null && data![index].cart!.isNotEmpty) ?
                           Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding:EdgeInsets.symmetric(horizontal: screenW/40.0,vertical: screenH/60.0),
                                  margin: EdgeInsets.symmetric(vertical: screenH/60.0),
                                  decoration: BoxDecoration(
                                      color: ConstantColor.progressBGolor,
                                      borderRadius: BorderRadius.circular(8.0)
                                  ),
                                  child: buildListItem(
                                    icon: Icons.storefront,
                                    title: data![index].storeName??"",
                                    textStyle: ConstantTextStyle.carouselSliderText,
                                    subtitleStyle: ConstantTextStyle.hintTextStyle,
                                  ),
                                ),
                                ...data![index].cart!.map((dataItems) {
                                  // Convert offerPrice to a numeric type (double in this case)
                                  double numericOfferPrice = double.tryParse(dataItems!.offerPrice??"") ?? 0.0;
                                  double numericPrice = double.tryParse(dataItems!.price??"") ?? 0.0;
                                  var quantity = int.tryParse(dataItems!.productQuantity??"") ?? 1;
                                  sum +=  double.tryParse(dataItems!.productQuantity??"") ?? 0.0;
                                  // Calculate totalPrice
                                  if (numericOfferPrice != 0.0) {
                                    totalPrice = sum * numericOfferPrice;
                                  } else {
                                    totalPrice = sum * numericPrice;
                                  }

                                  return Container(
                                    padding: const EdgeInsets.all(8.0),
                                    margin:  EdgeInsets.symmetric(vertical: screenH/100.0),
                                    decoration: BoxDecoration(border: Border.all(color: ConstantColor.primaryGreyColor.withOpacity(0.5)),
                                      borderRadius: BorderRadius.circular(0.5),
                                    ),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => ProductDetailScreen(
                                                  proId: dataItems!.productId??"",
                                                  id: widget.id??"",
                                                  longitude: widget.longitude??"",
                                                  latitude: widget.lattude??"",
                                                  lName: widget.lName??"",
                                                ),
                                              ),
                                            );
                                          },
                                          child: cachedImageWidget(
                                              imageFile: dataItems!.productImage??"",
                                              width: screenW/5.0,
                                              height: screenH/7.0
                                          ),
                                        ),

                                        Flexible(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: screenW/40.0,vertical: screenH/80.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                customeText(text: dataItems!.productTitle??"",style: ConstantTextStyle.productTitleText),
                                                customRichText(
                                                    TextAlign: TextAlign.start,
                                                    text1:'₹ ${dataItems!.offerPrice == null ? dataItems!.price.toString() :dataItems!.offerPrice.toString() ??""}\t\t',style1: ConstantTextStyle.allHomeScreenAvatarText,
                                                    text2:'₹ ${dataItems!.price??""}',style2: ConstantTextStyle.offerPriceGrey),
                                                SizedBox(height: screenH/60.0),
                                                Row(
                                                  children: [
                                                    boxIcon(
                                                        onTap: (){
                                                          if (quantity > 1) {
                                                            setState(() {
                                                              quantity--;
                                                            });
                                                            CardAddApiService.fetchCardAddData(
                                                                context: context,productId: dataItems!.productId??"",quantity: '$quantity',
                                                                onSuccess: (){
                                                                  data!.clear();
                                                                  fetchCardProductsListData();});
                                                          }

                                                        },
                                                        bgcolor: ConstantColor.calendarBGHeadColor,
                                                        icon: Icons.remove_circle_outline_rounded
                                                    ),
                                                    SizedBox(width: screenW/20.0),
                                                    customeText(text: '${dataItems!.productQuantity??" "}',style: ConstantTextStyle.productTitleText),
                                                    SizedBox(width: screenW/20.0),

                                                    boxIcon(
                                                        onTap: (){setState(() {quantity++;});
                                                        CardAddApiService.fetchCardAddData(
                                                            context: context,productId: dataItems!.productId??"",quantity: '$quantity',
                                                            onSuccess: (){
                                                              data!.clear();
                                                              fetchCardProductsListData();
                                                            });
                                                        },
                                                        bgcolor: ConstantColor.calendarBGHeadColor,
                                                        icon: Icons.add_circle_outline_rounded
                                                    ),
                                                    // SizedBox(width: screenW/30.0),
                                                    // IconButton(onPressed: () {
                                                    //   YesNoPermissionDialog.showExitConfirmationDialog(
                                                    //     context:context, title: 'Please Confirm!', content: 'Are you sure want to remove this Product?',
                                                    //     actions: [
                                                    //       customeButton(
                                                    //         textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                                                    //         onPressed:() async {
                                                    //           Navigator.pop(context);
                                                    //           await CardDeleteApiService.fetchCardDeleteData(
                                                    //             context: context,cartId: dataItems!.cartId??"",
                                                    //             onSuccess: (){
                                                    //               isLoading = true;
                                                    //               data!.clear();
                                                    //               fetchCardProductsListData();
                                                    //               fetchProductCount();
                                                    //               //  Navigator.pop(context);
                                                    //             },
                                                    //           );
                                                    //         },
                                                    //         text: "Yes",
                                                    //         backgroundColor: ConstantColor.loginWithOtpButtonColor,
                                                    //         borderRadius: BorderRadius.circular(20.0),
                                                    //         elevation: 0.0,
                                                    //       ),
                                                    //       SizedBox(width: screenW/100.0,),
                                                    //       customeButton(
                                                    //         textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                                                    //         onPressed:() => Navigator.pop(context),
                                                    //         text: "No",
                                                    //         backgroundColor: ConstantColor.primaryMainColor,
                                                    //         borderRadius: BorderRadius.circular(20.0),
                                                    //         elevation: 0.0,
                                                    //       ),
                                                    //     ],
                                                    //   );
                                                    // }, icon: const Icon(Icons.delete_forever_outlined,color: ConstantColor.primaryMainColor)),
                                                    //
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),


                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  margin:  EdgeInsets.symmetric(vertical: screenH/100.0),
                                  decoration: BoxDecoration(border: Border.all(color: ConstantColor.primaryGreyColor.withOpacity(0.5)),
                                    borderRadius: BorderRadius.circular(0.5),
                                  ),
                                  width: double.maxFinite,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: data?.map((dataItems) {
                                     return Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         customRichText(
                                              TextAlign: TextAlign.start,
                                              text1: 'Subtotal (${sum.toInt()} item) : ',
                                              text4: '₹ $totalPrice\n',
                                              text2: 'Mode of delivery : ',
                                              text3: dataItems!.deliveryMode ?? "",
                                              style1: ConstantTextStyle.productTitleText,
                                              style2: ConstantTextStyle.productTitleText,
                                              style3: ConstantTextStyle.secodHearText,
                                              style4: ConstantTextStyle.secodHearText,
                                         ),

                                        const Divider(),

                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: [
                                             customeText(text: 'Shipping Details',style: ConstantTextStyle.productTitleText),
                                             InkWell(
                                               onTap: (){
                                                 showDialog(
                                                   context: context,
                                                   builder: (BuildContext context) {
                                                     return CheckoutChangeAddressScreen(
                                                       onSuccess:() async {
                                                         data?.clear();
                                                         cardAddressData?.clear();
                                                         cardAddressDataCheck?.clear();
                                                         await fetchCardAddressData();
                                                         await fetchCardProductsListData();
                                                       },
                                                     );
                                                   },
                                                 );
                                               },
                                                 child: customeText(text: '✎  Change',style: ConstantTextStyle.carouselSliderText)),
                                           ],
                                         ),
                                         SizedBox(height: screenH/60.0),
                                         Column(
                                           children: cardAddressData!.map((dataItem){
                                           // cardAddressData?.where((dataItem) => dataItem.deflate == 1)?.map((dataItem) {
                                             return Column(
                                               children: [
                                                 addressDataWidget(
                                                   text1: 'Address line1',
                                                   text2: dataItem.address ?? "",
                                                 ),
                                                 addressDataWidget(
                                                   text1: 'Address line2',
                                                   text2: dataItem.landmark ?? "",
                                                 ),
                                                 addressDataWidget(
                                                   text1: 'City',
                                                   text2: dataItem.city ?? "",
                                                 ),
                                                 addressDataWidget(
                                                   text1: 'Pincode',
                                                   text2: dataItem.pincode ?? "",
                                                 ),
                                                 addressDataWidget(
                                                   text1: 'State',
                                                   text2: dataItem.state ?? "",
                                                 ),
                                               ],
                                             );
                                           })?.toList() ?? [],
                                         )
                                       ],
                                     );
                                    }).toList()??[],
                                  ),
                                ),

                                customeButton(
                                  onPressed: (){
                                    if (cardAddressDataCheck!.length!= 0 && cardAddressDataCheck!= null && cardAddressDataCheck!.isNotEmpty) {
                              _handlePlaceOrderSubmit();
                                    }else{
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CheckoutAddAddressScreen(
                                            onSuccess:() async {
                                              data?.clear();
                                              cardAddressData?.clear();
                                              cardAddressDataCheck?.clear();
                                              await fetchCardAddressData();
                                              await fetchCardProductsListData();
                                            },
                                          );
                                        },
                                      );
                                    }
                                  },
                                  text: cardAddressDataCheck!.isNotEmpty ? "Proceed To Checkout" : "Add Address",
                                  style: ConstantTextStyle.chipText,
                                  borderRadius: BorderRadius.circular(10.0),
                                  backgroundColor: ConstantColor.primaryMainColor,
                                  minimumSize: Size(screenW, screenH/24.0),
                                ),
                              ],
                            )
                           : Center(child: Container(
                           padding: EdgeInsets.symmetric(horizontal: screenW/30.0,vertical: screenH/80.0),
                           decoration: BoxDecoration(
                               boxShadow: [
                                 BoxShadow(
                                   color: ConstantColor.primaryGreyColor.withOpacity(0.5),
                                   spreadRadius: 0,
                                   blurRadius: 2,
                                   offset: const Offset(0, 3), // changes position of shadow
                                 ),
                               ],
                               color: ConstantColor.primaryBackgroundMainColor,
                               borderRadius: BorderRadius.circular(10.0)),
                           child: Column(
                             children: [
                               assetImageWidget(
                                 imageFile: ConstantImage.noCardProductImage??"",
                                 width: screenW/4.0,
                               ),
                               customeText(text: "Your cart is empty!",style: ConstantTextStyle.carouselSliderText,),
                               SizedBox(height: screenH/80.0,),
                               customeText(textAlign: TextAlign.center,
                                 text: "You have no items in your cart.\n Let's go buy something",style: ConstantTextStyle.homeScreenHeadingText3,),
                               SizedBox(height: screenH/80.0,),
                               customeButton(
                                 onPressed: () => onWillPop(),
                                 text: "Continue Shopping",
                                 style: ConstantTextStyle.chipText,
                                 borderRadius: BorderRadius.circular(10.0),
                                 backgroundColor: ConstantColor.primaryMainColor,
                                 // minimumSize: Size(screenW, screenH/24.0),
                               ),
                             ],
                           ))
                           )
                         ],
                       );
                      }
                  ),
                ) : Center(child: Container(
                    padding: EdgeInsets.symmetric(horizontal: screenW/30.0,vertical: screenH/80.0),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: ConstantColor.primaryGreyColor.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 2,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        color: ConstantColor.primaryBackgroundMainColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: [
                        assetImageWidget(
                          imageFile: ConstantImage.noCardProductImage??"",
                          width: screenW/4.0,
                        ),
                        customeText(text: "Your cart is empty!",style: ConstantTextStyle.carouselSliderText,),
                        SizedBox(height: screenH/80.0,),
                        customeText(textAlign: TextAlign.center,
                          text: "You have no items in your cart.\n Let's go buy something",style: ConstantTextStyle.homeScreenHeadingText3,),
                        SizedBox(height: screenH/80.0,),
                        customeButton(
                          onPressed: () => onWillPop(),
                          text: "Continue Shopping",
                          style: ConstantTextStyle.chipText,
                          borderRadius: BorderRadius.circular(10.0),
                          backgroundColor: ConstantColor.primaryMainColor,
                          // minimumSize: Size(screenW, screenH/24.0),
                        ),
                      ],
                    ))),
              ],
            ),
          ),
        ),
      );
  }
}





Widget addressDataWidget({text1,style1,text2,style2}){
  return Padding(
    padding:const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customeText(textAlign: TextAlign.start,text: text1,style: style1 ?? ConstantTextStyle.productTitleText),
        const SizedBox(width: 30.0),
        Flexible(child: customeText(textAlign: TextAlign.start, text: text2??"",style: style2 ?? ConstantTextStyle.subtitleGreyText)),
      ],
    ),
  );
}