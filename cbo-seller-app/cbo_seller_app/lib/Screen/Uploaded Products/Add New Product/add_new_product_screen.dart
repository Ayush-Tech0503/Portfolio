// ignore_for_file: non_constant_identifier_names, deprecated_member_use, library_private_types_in_public_api

import 'package:citybazaronline_seller_app/Utils/Constant%20Size%20/constant_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter/material.dart';
import '../../../../../Layouts/constant_screen_layout.dart';
import '../../../../../Utils/Font Style/text_styles.dart';
import '../../../../../Utils/Theme/constant_colors.dart';
import '../../../Widget/Custome Buttons/elevetion_button_widget.dart';
import '../../../Widget/custome_text_widget.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({super.key});

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {

  @override
  void initState() {
    super.initState();
  }

  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    _scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return  AppLayout(
        title: "Add New Product",
        titleStyle: ConstantTextStyle.landingScreenAppbarText,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back), color: ConstantColor.primaryBackgroundMainColor,
            onPressed: () => Navigator.pop(context)),
        scaffoldColor: ConstantColor.primaryBackgroundMainColor,
        appBarColor: ConstantColor.loginWithOtpButtonColor,
        body: CupertinoScrollbar(
          child: Skeletonizer(
            enabled: isLoading,
            child: ListView(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: screenWidth/30,vertical: screenHeight/40),
              children: [
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: ConstantColor.textformFieldDisableColor,width: 0.5),
                    color: ConstantColor.sellerBGColor,),
                  padding: EdgeInsets.symmetric(vertical: screenHeight/80.0,horizontal: screenWidth/40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customeText(text: "Pre - Loaded Products",
                        style: ConstantTextStyle.requirementText,
                      ),
                      constantHeight(context, 80.0),
                      customeText(text: "Select Your Products from widely available Pre- Loaded products from 10000+ Brands. Yu no need to upload Product image and description. You have to only add Price and Quantity of the selected product.",
                        style: ConstantTextStyle.secondryLocationText,
                      ),
                      constantHeight(context, 80.0),
                      Align(
                        alignment: Alignment.centerRight,
                        child: customButton(
                          textStyleButton: ConstantTextStyle.chipText,
                          onPressed: () => Navigator.pushNamed(context, '/preLoadedProductScreen'),
                          toolTipMessage: "add pre - loaded products.",
                          text: 'Add Product',
                          backgroundColor: ConstantColor.primaryMainColor,
                          borderRadius: BorderRadius.circular(6.0),
                          elevation: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),


                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: ConstantColor.textformFieldDisableColor,width: 0.5),
                    color: ConstantColor.sellerBGColor,),
                  padding: EdgeInsets.symmetric(vertical: screenHeight/80.0,horizontal: screenWidth/40.0),
                  margin: EdgeInsets.symmetric(vertical: screenHeight/80.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customeText(text: "Custom Products",
                        style: ConstantTextStyle.requirementText,
                      ),
                      constantHeight(context, 80.0),
                      customeText(text: "Create your customize product catalogue by uploading product Images and description",
                        style: ConstantTextStyle.secondryLocationText,
                      ),
                      constantHeight(context, 80.0),
                      Align(
                        alignment: Alignment.centerRight,
                        child: customButton(
                          textStyleButton: ConstantTextStyle.chipText,
                          onPressed: ()  => Navigator.pushNamed(context, '/customProductScreen'),
                          toolTipMessage: "add custom products.",
                          text: 'Add Product',
                          backgroundColor: ConstantColor.primaryMainColor,
                          borderRadius: BorderRadius.circular(6.0),
                          elevation: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}