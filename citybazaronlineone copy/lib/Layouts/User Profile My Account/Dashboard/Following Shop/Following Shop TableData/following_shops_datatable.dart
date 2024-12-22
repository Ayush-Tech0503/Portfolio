import 'package:flutter/material.dart';

import '../../../../../../Util/constaint_textstyle.dart';
import '../../../../../../Util/constant_color.dart';
import '../../../../../../Util/constant_image.dart';
import '../../../../../../Widgets/custome_imagies.dart';
import '../../../../../../Widgets/custome_text.dart';
import '../../../../../Widgets/Famous Market Widget/store_details_widget.dart';
import '../../../../../Widgets/User Profile Screen Widgets/following_shop_product_details.dart';

class FollowingShopsDataTable extends StatefulWidget {
  const FollowingShopsDataTable({super.key});

  @override
  State<FollowingShopsDataTable> createState() => _FollowingShopsDataTableState();
}

class _FollowingShopsDataTableState extends State<FollowingShopsDataTable> {
  final ScrollController _scrollController = ScrollController();

  bool _isSelect = false;
  bool _isSelect1 = false;


  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.width;
    return  SingleChildScrollView(
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: screenHeight/30, horizontal: screenWidth/30),
        child: Column(
            children: [
/*------------------------Add More Button end -------------------------------------------*/

              Container(
                padding: EdgeInsets.symmetric(horizontal: screenWidth/20, vertical: screenHeight/20),
                decoration: BoxDecoration(
                  color: ConstantColor.sellerBGColor,
                  borderRadius:BorderRadius.circular(10.0),
                ),
                child: ScrollbarTheme(
                  data: ScrollbarThemeData(
                    crossAxisMargin: 2.5,
                    radius: const Radius.circular(10.0),
                    thickness: MaterialStateProperty.all(5.0),
                    trackBorderColor: MaterialStateProperty.all(ConstantColor.trackBGolor),
                    thumbColor: MaterialStateProperty.all(ConstantColor.primaryMainColor),
                    trackColor: MaterialStateProperty.all(ConstantColor.trackBGolor),
                  ),
                  child: Scrollbar(
                    controller: _scrollController,
                    trackVisibility: true,
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DataTable(
                            dataRowHeight: screenHeight/5,
                            showBottomBorder: true,
                            dividerThickness:0.5,
                            headingRowColor: MaterialStateProperty.resolveWith(
                                  (states) => ConstantColor.calendarBGHeadColor,),
                            headingRowHeight: screenHeight/10,
                            columns: [
                              DataColumn(   //
                                label:customeText(text: "Product Image",
                                  textAlign: TextAlign.start, style:ConstantTextStyle.tabButtonTextStyle,),),
                              DataColumn(
                                label:customeText(text: "Product Details",
                                  textAlign: TextAlign.start, style:ConstantTextStyle.tabButtonTextStyle,),),
                              DataColumn(
                                label:customeText(text: "Action",
                                  textAlign: TextAlign.start, style:ConstantTextStyle.tabButtonTextStyle,),),
                            ],
                            rows:[
/*---------------------------------1st Row start------------------------------*/

                              DataRow( cells:[
                                DataCell( boxImage(backGroundColor: ConstantColor.primaryBackgroundMainColor,
                                    backGroundborderRadius:BorderRadius.circular(8.0),
                                    shadowColor: ConstantColor.carColor,
                                    blurRadius: 20.0,
                                    borderColor: ConstantColor.carColor,
                                    image: ConstantImage.imageIsNotAvailable,
                                    imageHeight: screenHeight/10,
                                    imageWidth: screenWidth/10
                                ),

                                ),
                                DataCell(
                                  followingShopProductDetails( context: context),),
                                DataCell(
                                  boxIcon(
                                    height: screenHeight/10,width: screenWidth/10,
                                    icon: Icons.delete_outline,
                                    borderRadius: BorderRadius.circular(8.0),
                                    bgcolor: _isSelect ? ConstantColor.calendarBGHeadColor : ConstantColor.primaryMainColor,
                                    iconcolor: _isSelect ? ConstantColor.primaryMainColor : ConstantColor.primaryBackgroundMainColor ,
                                    iconsize: 25.0,
                                    onTap: () { setState(() {
                                      _isSelect = !_isSelect;
                                    });
                                    },

                                  ),
                                ),

                              ]),

/*---------------------------------1st Row end--------------------------------*/
/*---------------------------------2nd Row start------------------------------*/

                              DataRow( cells:[
                                DataCell( boxImage(backGroundColor: ConstantColor.primaryBackgroundMainColor,
                                    backGroundborderRadius:BorderRadius.circular(8.0),
                                    shadowColor: ConstantColor.carColor,
                                    blurRadius: 20.0,
                                    borderColor: ConstantColor.carColor,
                                    image: ConstantImage.imageIsNotAvailable,
                                    imageHeight: screenHeight/10,
                                    imageWidth: screenWidth/10
                                ),

                                ),
                                DataCell(
                                  followingShopProductDetails( context: context),),
                                DataCell(
                                  boxIcon(
                                    height: screenHeight/10,width: screenWidth/10,
                                    icon: Icons.delete_outline,
                                    borderRadius: BorderRadius.circular(8.0),
                                    bgcolor: _isSelect1 ? ConstantColor.primaryMainColor : ConstantColor.calendarBGHeadColor,
                                    iconcolor: _isSelect1 ? ConstantColor.primaryBackgroundMainColor : ConstantColor.primaryMainColor ,
                                    iconsize: 25.0,
                                    onTap: () { setState(() {
                                      _isSelect1 = !_isSelect1;
                                    });
                                    },

                                  ),
                                ),

                              ]),

/*---------------------------------2nd Row end--------------------------------*/


                            ],
                          ),
                          SizedBox(height: screenHeight/20,),
                        ],
                      ),

                    ),
                  ),
                ),
              ),
            ]
        ),
      ),

    );
  }
}
