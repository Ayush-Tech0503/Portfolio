import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../Controller/order_controller.dart';
import '../Layouts/Famous Market/Store Details/Store Details Screen/store_details.dart';
import '../Layouts/Product View Screens/product_Item_Details.dart';
import '../Util/constaint_textstyle.dart';
import '../Util/constant_color.dart';
import '../Util/constant_image.dart';
import '../Widgets/Card Details Widgets/Card Images/asset_images_widget.dart';
import '../Widgets/Card Details Widgets/Card Images/cached_images_widget.dart';
import '../Widgets/Card Details Widgets/Permition Dialog/permition_dialog_widget.dart';
import '../Widgets/Card Details Widgets/card_details_header_widget.dart';
import '../Widgets/custome_button_.dart';
import '../Widgets/custome_richtext.dart';
import '../Widgets/custome_text.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});


   _showAlertDialog(context,titleText, phoneNumber,message,orderStatus) {
     AwesomeDialog(
       context: context,
       animType: AnimType.scale,
       dialogType: orderStatus == "0" ? DialogType.info : orderStatus == "1" ?  DialogType.success : orderStatus == "2" ? DialogType.error : DialogType.question,
       title: titleText??"",
       titleTextStyle:  ConstantTextStyle.feedBackHeadText,
       desc: message ??'',
       descTextStyle: ConstantTextStyle.allHomeScreenAvatarText,
       btnOkColor: ConstantColor.loginWithOtpButtonColor,
       btnOkOnPress: () {},
     ).show();
  }



  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>?;
    final id = arguments?['id']??"";
    final lName = arguments?['lName']??"";
    final longitude = arguments?['longitude']??"";
    final latitude = arguments?['latitude']??"";
    var screenW = MediaQuery.of(context).size.width;
    var screenH = MediaQuery.of(context).size.width;
    final OrderController controller = Get.put(OrderController());

    return Container(
      color: ConstantColor.loginWithOtpButtonColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ConstantColor.primaryBackgroundMainColor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ConstantColor.primaryBackgroundMainColor,
            iconTheme: const IconThemeData(color: ConstantColor.loginWithOtpButtonColor),
            title: customeText(textAlign: TextAlign.start,
                text: "Orders Details", style: ConstantTextStyle.secodHearText),
          ),
          body: Obx(() {
            if (controller.isLoading.value) {
              return const SpinKitCircle(color: ConstantColor.primaryMainColor, size: 30.0);
            } else if (controller.orders.isEmpty) {
              return Center(child: Container(
                alignment: Alignment.center,
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
                        onPressed: () => Navigator.pop(context),
                        text: "Continue Shopping",
                        style: ConstantTextStyle.chipText,
                        borderRadius: BorderRadius.circular(10.0),
                        backgroundColor: ConstantColor.primaryMainColor,
                        // minimumSize: Size(screenW, screenH/24.0),
                      ),
                    ],
                  )));
            }

            return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenW/30.0, vertical: screenH/20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      customeText(text: "Orders Details".toUpperCase(), style: ConstantTextStyle.secodHearText),

                      SizedBox(height: screenH/20.0,),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.orders?.length ?? 0,
                        itemBuilder: (context, index) {
                          // Define the input format --------------date formatting start-------
                          DateFormat inputFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
                          // Parse the date string
                          var dateStr = controller.orders![index].insertDate??"";

                          DateTime dateTime = inputFormat.parse(dateStr);
                          // Define the output format
                          DateFormat outputFormat = DateFormat("dd MMMM yyyy HH:mm");
                          // Format the DateTime object into the desired format
                          String formattedDate = outputFormat.format(dateTime);
                          //--------------date formatting end-------
                          // Parse price and quantity
                          double parseToDouble(String? value) {
                            double result = double.tryParse(value ?? "") ?? 0.0;
                            return result;
                          }

                          int parseToInt(String? value) {
                            int result = int.tryParse(value ?? "") ?? 0;
                            return result;
                          }

                          double subtotal = 0.0;
                          int totalQuantity = 0;

                          for (var product in controller.orders![index].product ?? []) {
                            double price = parseToDouble(product.offerPrice ?? product.price);
                            int quantity = parseToInt(product.productQuantity);
                            subtotal += price * quantity;
                            totalQuantity += quantity;
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StoreDetailScreen(
                                      // sellersId: controller.orders![index].sellerId??"",
                                      sellersId: controller.orders![index].storeId??"",
                                      id: id,
                                      longitude: longitude,
                                      latitude: latitude,
                                      lName: lName,
                                    ),
                                  ),
                                );
                                  },
                                child: Container(
                                  padding:EdgeInsets.symmetric(horizontal: screenW/40.0,vertical: screenH/60.0),
                                  // margin: EdgeInsets.symmetric(vertical: screenH/30.0),
                                  decoration: const BoxDecoration(
                                    color: ConstantColor.progressBGolor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      topRight: Radius.circular(8.0),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      buildListItem(
                                        icon: Icons.storefront,
                                        title: controller.orders![index].storeName??"",
                                        // subtitle: '${formattedDate??""}\nStatus - ${controller.orders![index].orderStatus??""}',
                                        textStyle: ConstantTextStyle.carouselSliderText,
                                        subtitleStyle: ConstantTextStyle.topCategoryText,
                                      ),
                                      SizedBox(height: screenH/80.0),
                                      customeText(text: formattedDate??'', style: ConstantTextStyle.becomeSellerDiscText),
                                      SizedBox(height: screenH/80.0),

                                      SizedBox(height: screenH/80.0),
                                      customeText(text: controller.orders![index].storeAddress??"", style: ConstantTextStyle.becomeSellerDiscText),
                                      SizedBox(height: screenH/80.0),
                                      buildListItem(
                                        icon: Icons.phone,
                                        title: controller.orders![index].contactNo??"",
                                        // subtitle: '${formattedDate??""}\nStatus - ${controller.orders![index].orderStatus??""}',
                                        textStyle: ConstantTextStyle.topCategoryText,
                                        subtitleStyle: ConstantTextStyle.topCategoryText,
                                      ),
                                      SizedBox(height: screenH/80.0),
                                      // customeText(text: "${orderListData![index].insertDate??""}\n ${orderListData![index].storeName??""}"),
                                      buildListItem(
                                        icon: Icons.local_shipping,
                                        title: controller.orders![index].deliveryMode??"",
                                        textStyle: ConstantTextStyle.topCategoryText,
                                      ),
                                      SizedBox(height: screenH/80.0),
                                      customeText(
                                        textAlign: TextAlign.start,
                                        text: 'Subtotal ($totalQuantity item${totalQuantity > 1 ? '' : ''}): ₹ $subtotal',
                                        style: ConstantTextStyle.carouselSliderText,
                                      ),
                                      SizedBox(height: screenH/30.0),

                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () => _showAlertDialog(context,
                                                controller.orders![index].statusText ?? "keep wait for order status!",
                                                controller.orders![index].contactNo??"",
                                                controller.orders![index].statusMessage??"",
                                                controller.orders![index].orderStatus??"",
                                            ),
                                            child: customeText(text: 'Check Status',
                                                style: ConstantTextStyle.seeMoreButtonStyle2),
                                          ),
                                          SizedBox(width: screenW/20.0),
                                          controller.orders![index].orderStatus != "0"?  Container() :
                                          InkWell(
                                            onTap: () {
                                              YesNoPermissionDialog.showExitConfirmationDialog(
                                                context:context, title: 'Please Confirm!', content: 'Are you sure want to cancel this order?',
                                                actions: [
                                                  customeButton(
                                                    textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                                                    onPressed:() async {
                                                      Navigator.pop(context);
                                                      bool result = await controller.cancelOrder(context: context,
                                                          orderId: controller.orders![index].orderId ?? "", status: "2");
                                                    },
                                                    text: "Yes",
                                                    backgroundColor: ConstantColor.loginWithOtpButtonColor,
                                                    borderRadius: BorderRadius.circular(20.0),
                                                    elevation: 0.0,
                                                  ),
                                                  SizedBox(width: screenW/100.0,),
                                                  customeButton(
                                                    textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                                                    onPressed:() => Navigator.pop(context),
                                                    text: "No",
                                                    backgroundColor: ConstantColor.primaryMainColor,
                                                    borderRadius: BorderRadius.circular(20.0),
                                                    elevation: 0.0,
                                                  ),
                                                ],
                                              );
                                            },
                                            child: customeText(text: 'Cancel Order',
                                                style: ConstantTextStyle.seeMoreButtonStyle2),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              ...controller.orders![index].product!.map((dataItems) {
                                return Container(
                                  padding: const EdgeInsets.all(8.0),
                                  margin:  EdgeInsets.only(bottom: screenH/30.0),
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
                                                id: id??"",
                                                longitude: longitude??"",
                                                latitude: latitude??"",
                                                lName: lName??"",
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
                                              customeText(text: "Qyt : ${dataItems!.productQuantity??""}",style: ConstantTextStyle.productTitleText),
                                              customRichText(
                                                  TextAlign: TextAlign.start,
                                                  text1:'₹ ${dataItems!.offerPrice == null ? dataItems!.price.toString() : dataItems!.offerPrice.toString() ??""}\t\t',style1: ConstantTextStyle.allHomeScreenAvatarText,
                                                  text2:'₹ ${dataItems!.price??""}',style2: ConstantTextStyle.offerPriceGrey),
                                            ],
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                );
                              }),
                              SizedBox(height: screenH/30.0),
                            ],
                          );
                        }
                    ),
                  ],
                  ),
                ),
              );
          }),
        ),
      ),
    );
  }
}
