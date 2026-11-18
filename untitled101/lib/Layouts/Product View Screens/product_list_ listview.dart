// ignore_for_file: must_be_immutable

import 'package:Citybazar_app/Layouts/Product%20View%20Screens/product_Item_Details.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Util/constaint_textstyle.dart';
import '../../Util/constant_color.dart';
import '../../Util/constant_image.dart';
import '../../Widgets/Send Enquiry dialogBox/alert_dialog_box.dart';
import '../../Widgets/collection_card.dart';
import '../../Widgets/custome_imagies.dart';
import '../../Widgets/custome_richtext.dart';
import '../../Widgets/product_list.dart';
import '../Famous Market/Store Details/Store Details Screen/store_details.dart';

class ProductListViewScreen extends StatefulWidget {
  //id: widget.id, longitude: '', latitude: '', lName: ''
  String id;
  String longitude;
  String latitude;
  String lName;
   ProductListViewScreen({super.key,required this.id,required this.longitude,required this.latitude,required this.lName});

  @override
  State<ProductListViewScreen> createState() => _ProductListViewScreenState();
}

class _ProductListViewScreenState extends State<ProductListViewScreen> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: ConstantColor.loginWithOtpButtonColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: ConstantColor.loginWithOtpButtonColor,
            ),
            title: Center(
              child: Text(
                'Product List',
                style: ConstantTextStyle.topCategoryText2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            backgroundColor: ConstantColor.carColor,
            elevation: 0.0,
            titleSpacing: 0.0,
            //   actions: [],
          ),
          extendBody: true,
          body: Container(
            color: ConstantColor.secondryBackgroundMainColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
/*------------------------------filter and sort_by section start-----------------------------*/
                  SizedBox(height: screenHeight / 60,),
                  Row(
                    children: [
                      filterSort(
                        padding: EdgeInsets.only(left: screenWidth / 20),
                        context: context,
                        text1: "Filter",
                        style1: ConstantTextStyle.allHomeScreenAvatarText,
                        thickness: 1.5,
                        text2: "Sort By",
                        style2: ConstantTextStyle.allHomeScreenAvatarText,
                      ),
                      filterTextIcon(
                        height: screenHeight / 25,
                        width: screenWidth / 3.5,
                        bgcolor: ConstantColor.bottonNavIcons,
                        text: "Popularity",
                        style: ConstantTextStyle.allHomeScreenAvatarText,
                        context: context,
                        color: ConstantColor.searchBoxColor,
                        icon: (Icons.arrow_drop_down),
                        onTap: () {},
                        size: 25.0,
                      ),
                    ],
                  ),
/*------------------------------filter and sort_by section end-----------------------------*/

/*--------------------------------Product cards list view start---------------------------------------*/
                  SizedBox(
                    height: screenHeight / 60,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric( horizontal: screenWidth/20,),
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenWidth/.3,
                          child: ListView.builder(
                            physics: const ScrollPhysics(),
                            scrollDirection: Axis.vertical,
                        itemCount: 10,
                       itemBuilder: (BuildContext context, int index) {
                               return Container(
                                 height: screenHeight/7,
                                 margin: EdgeInsets.only(bottom: screenHeight/100),
                                 color: ConstantColor.primaryBackgroundMainColor,
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     customImg(
                                     ontap: (){ Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                       builder: (context) =>
                                        ProductDetailScreen(id: widget.id, longitude: '', latitude: '', lName: '',)),
                                 );},
                         image: ConstantImage.imageIsNotAvailable,
                         height: screenHeight / 10,
                         width: screenWidth / 5,
                        // fit: BoxFit.fill,
                         ),
                                     Column(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         customRichText(
                                           text1: "Man's t-shirt",
                                             TextAlign: TextAlign.start,
                                             //overflow1: TextOverflow.ellipsis,
                                             style1: ConstantTextStyle.allHomeScreenAvatarText,
                                         ),
                                         customRichText(
                                           text1: "Rudra Collection",
                                           TextAlign: TextAlign.start,
                                           //overflow1: TextOverflow.ellipsis,
                                           style1: ConstantTextStyle.secondorGrayText,
                                         ),
                                         produtListRichText2(
                                           icon: Icons.currency_rupee_outlined,
                                           color: ConstantColor.primaryMainColor,
                                           context: context,
                                           text1: "600 ",
                                           style1: ConstantTextStyle.richtext1,
                                           text2: NumberFormat.simpleCurrency(
                                               locale: "hi-NI", decimalDigits: 2)
                                               .format(700),
                                           style2: ConstantTextStyle.richtext2,
                                           widget: produtListRichText3(
                                               icon: Icons.content_paste_search,
                                               color: ConstantColor.bottonNavIcons,
                                               text1: "Send Enquiry",
                                               style1: ConstantTextStyle.newiconButtonText,
                                               context: context,
                                               recognizer: TapGestureRecognizer()
                                                 ..onTap = () {
                                                   showDialog(
                                                     context: context,
                                                     builder: (ctx) {
                                                       return alertDialogBox(
                                                         context:context,
                                                         titleText: "Enquiry Send Successfully",
                                                         titleTextAlign: TextAlign.center,
                                                         titleStyle: ConstantTextStyle.allHomeScreenAvatarText,
                                                         descriptionText: "आपकी Enquiry विक्रेता को शेयर कर दी गई है विक्रेता से बात करने के लिए कॉल करें 9907138155.\n"
                                                     "\nनोट:- सिटी बाज़ार ऑनलाइन द्वारा प्रोडक्ट की डिलीवरी प्रदान नही की जाती हैं"
                                                       "यदि आप प्रोडक्ट डिलेवरी चाहिते हैं तो कृपया विक्रेता से संपर्क करे"
                                                       "या स्टोर पर जाकर ही खरीदें ।",
                                                         descriptionTextStyle:ConstantTextStyle.secondorGrayText,
                                                         icon: Icons.message_sharp,
                                                         buttonText: "Chat with seller",
                                                         buttonStyle:ConstantTextStyle.newiconButtonText,
                                                         iconbuttononPress: () {
                                                           Navigator.of(ctx).pop();
                                                         },
                                                       );
                                                     }
                                                   );

                                                 }),
                                         ),
                                       ],
                                     ),

                                  SizedBox(width: screenWidth/6,),
                                     IconButton(
                                       icon: const Icon(Icons.store_outlined,size: 30,),
                                       color: ConstantColor.loginWithOtpButtonColor,
                                       onPressed: () { Navigator.push(
                                         context,
                                         MaterialPageRoute(
                                             builder: (context) =>
                                              StoreDetailScreen(id: widget.id, longitude: widget.latitude, latitude: widget.longitude,lName: widget.lName,)),
                                       );},
                                     ),

                                   ],
                                 ),
                               );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),


/*-----------------------------------Product cards list view end------------------------------------*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
