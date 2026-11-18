// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables, library_private_types_in_public_api

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Util/Const Toster/awesome_toster.dart';
import '../../../Util/Const Toster/toster.dart';
import '../../../Util/Constant APi Url/api_urls.dart';
import '../../../Util/constaint_textstyle.dart';
import '../../../Util/constant_color.dart';
import '../../../Widgets/custome_button_.dart';
import '../../../Widgets/custome_text.dart';

class NoProductDataFound extends StatefulWidget {
  final String messageText;
  const NoProductDataFound({super.key, required this.messageText});

  @override
  _NoProductDataFoundState createState() => _NoProductDataFoundState();
}

class _NoProductDataFoundState extends State<NoProductDataFound> {
  bool isFocused1 = false;
  bool isFocused2 = false;
  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();

  String productName = '';
  String productDetail = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDetailController = TextEditingController();
var tokenAccess;
var userId;
  noDataFoundApi() async {
    try {
      showLoggingInDialog(context);
      SharedPreferences preference = await SharedPreferences.getInstance();
      tokenAccess = preference.getString("access-token");
      userId = preference.getString("userId");

        final body = {
          "product_name": productNameController.text.toString(),
          "query": productDetailController.text.toString(),
        };

        final response = await Dio().post(
          "${ConstantUrls.baseUriApi}${ConstantUrls.productRequirementApi}",
          options: Options(
            headers: {
              "Authorization": tokenAccess,
              'Content-Type': 'application/json',
            },
          ),
          data: json.encode(body),
        );
      if (response.statusCode == 200) {
          var responseData = json.decode(response.data.toString());
          Navigator.of(context).pop();
          setState(() {
            awesomeTost(context,
                'Your request has been received and submitted successfully.'
                ' You can expect sellers to contact you soon.'
                ' Once your requirements have been fulfilled,'
                ' please close the enquiry.');
          });
          productNameController.clear();
          productDetailController.clear();
        } else {
          LoadingScaffoldMessage.showSnackbar(
            context, "API call failed",
            ConstantColor.primaryMainColor,
            const Duration(seconds: 2),
          );
          // Navigator.of(context).pop();
        }
    } catch (error) {
      LoadingScaffoldMessage.showSnackbar(
        context, "An error occurred",
        ConstantColor.primaryMainColor,
        const Duration(seconds: 2),
      );
      Navigator.of(context).pop();
    }
  }

@override
  void initState() {
    super.initState();
    focusNode1.addListener(() {
      setState(() {
        isFocused1 = focusNode1.hasFocus;
      });
    });
    focusNode2.addListener(() {
      setState(() {
        isFocused2 = focusNode2.hasFocus;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        customeText(
          textAlign: TextAlign.center,
          text: widget.messageText),
        SizedBox(height: screenHeight / 60),
        customeButton(
          textStyleButton: ConstantTextStyle.reviewsRatingsText,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      // contentPadding: EdgeInsets.zero,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: screenHeight/80,
                        horizontal: screenWidth /40,),
                     insetPadding: EdgeInsets.symmetric(horizontal: screenWidth/20,),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                     titlePadding: EdgeInsets.symmetric(vertical: screenHeight/60,),
                      title: customeText(
                        text: "Post Your Requirement",
                        style: ConstantTextStyle.homeScreenHeadingText1,
                        textAlign: TextAlign.center,
                      ),
                      content: Form(
                        key: _formKey,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                style: ConstantTextStyle.textFormFildStyle2,
                                controller: productNameController,
                                onChanged: (value) {
                                  setState(() {
                                    productName = value;
                                  });
                                },
                                autofocus: false,
                                decoration: InputDecoration(
                                  labelText: 'Product Name *',
                                  labelStyle: ConstantTextStyle.topCategoryText,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(color: ConstantColor.secondtryGrayColor),),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(color: ConstantColor.primaryMainColor),
                                  ),
                                  filled: true,
                                  fillColor:ConstantColor.primaryBackgroundMainColor,
                                  contentPadding: EdgeInsets.symmetric(horizontal:screenWidth/40),
                                ),
                                cursorColor: ConstantColor.primaryMainColor,
                              ),
                              SizedBox(height: screenHeight/60,),
                              TextFormField(
                                style: ConstantTextStyle.textFormFildStyle2,
                                controller: productDetailController,
                                onChanged: (value) {
                                  setState(() {
                                    productDetail = value;
                                  });
                                },
                                maxLines: 4,
                                minLines: 4,
                                autofocus: false,
                                decoration: InputDecoration(
                                  labelText: 'Product Detail *',
                                  labelStyle: ConstantTextStyle.topCategoryText,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(color: ConstantColor.secondtryGrayColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(color: ConstantColor.primaryMainColor),
                                  ),
                                  filled: true,
                                  fillColor:ConstantColor.primaryBackgroundMainColor,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: screenHeight/80, horizontal:screenWidth/40),
                                ),
                                cursorColor: ConstantColor.primaryMainColor,
                              ),
                              SizedBox(height: screenHeight/60,),
                              customeButton(
                                textStyleButton: ConstantTextStyle.reviewsRatingsText,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (productNameController.text.isNotEmpty) {
                                      if (productDetailController.text.isNotEmpty) {
                                        if (productDetailController.text.length >= 25) {
                                          noDataFoundApi();
                                        } else {
                                          // Show error message for insufficient product detail length
                                          LoadingScaffoldMessage.showSnackbar(
                                            context,
                                            "Product Detail should be at least 25 characters",
                                            ConstantColor.primaryMainColor,
                                            const Duration(seconds: 2),
                                          );
                                        }
                                      } else {
                                        // Show error message for empty product detail
                                        LoadingScaffoldMessage.showSnackbar(
                                          context,
                                          "Product Detail is required",
                                          ConstantColor.primaryMainColor,
                                          const Duration(seconds: 2),
                                        );
                                      }
                                    } else {
                                      // Show error message for empty product name
                                      LoadingScaffoldMessage.showSnackbar(
                                        context,
                                        "Product Name is required",
                                        ConstantColor.primaryMainColor,
                                        const Duration(seconds: 2),
                                      );
                                    }
                                  }

                                },
                                text: "Submit".toUpperCase(),
                                backgroundColor: ConstantColor.primaryMainColor,
                                borderRadius: BorderRadius.circular(10.0),
                                minimumSize: Size.fromHeight(screenHeight / 22),
                              ),
                            ],
                          ),
                        ),
                      ),
                      );
                  },
                );
              },
            );
          },
          text: "Post Your Requirements".toUpperCase(),
          backgroundColor: ConstantColor.primaryMainColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ],
    );
  }
}

void showLoggingInDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        content: Row(
          children: [
            const CircularProgressIndicator(
              color: ConstantColor.primaryMainColor,
            ),
            const SizedBox(width: 20),
            Text(
              'Logging In...',
              style: ConstantTextStyle.allHomeScreenAvatarText,
            ),
          ],
        ),
      );
    },
  );
}