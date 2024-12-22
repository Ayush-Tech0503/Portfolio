// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:citybazaronline_seller_app/Utils/Constant%20Size%20/constant_sizes.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../Models/Shop Info Preview Model/child_category_listing_model.dart';
import '../../Models/Shop Info Preview Model/registration_preview_model.dart';
import '../../Services/Seller Forms Api Services/Seller Form Submit Api Services/step_1st_form_submit_api.dart';
import '../../Services/Seller Forms Api Services/child_category_listing_api.dart';
import '../../Services/shop_registration_preview_api_services.dart';
import '../../Utils/Constant Api Routs/constant_api_routs.dart';
import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';
import '../../Widget/Custome Buttons/elevetion_button_widget.dart';
import '../../Widget/Drop Down /drop_down_form_widget.dart';
import '../../Widget/Scaffold Message/scaffold_message_widget.dart';
import '../../Widget/custome_text_widget.dart';

class Step4thSellerFormScreen extends StatefulWidget {
  final currectPageValue;
  final Function onNext;
  final Function onPreview;

  const Step4thSellerFormScreen({
    super.key,
    required this.onNext,
    this.currectPageValue,
    required this.onPreview,
  });

  @override
  State<Step4thSellerFormScreen> createState() => _Step4thSellerFormScreenState();
}

class _Step4thSellerFormScreenState extends State<Step4thSellerFormScreen> {
  String? selectedItem;
  String selectedCategoryNamesString = '';
  String selectedPCategoryID = '';

  final FocusNode _focusNode = FocusNode();

  ShopInfoPreviewModel? shopInfoPreviewModel;
  List<ChildCat>? data = [];
  CatCheckBoxListModel? catCheckBoxList;
  List<DataCheck> checkBoxListData = [];
  List<Seller> sellerData = [];
  bool isPullToRefreshEnabled = true;
  int currentPage = 1;
  bool isLoading = false;


  @override
  void initState() {
    super.initState();
    fetchPreFiledData();
    _focusNode.addListener(() {
      setState(() {
        _focusNode.hasFocus;
      });
    });
  }

  Future<void> fetchPreFiledData() async {
    try {
      setState(() {
        isLoading = true;
        data!.clear();
      });

      final shopInfoResponse = await ApiShopInfoPreviewService.fetchShopInfoPreviewData(context: context);

      if (shopInfoResponse != null && shopInfoResponse.data != null && shopInfoResponse.data!.seller != null) {
        // Handle dealsIn data if available
        String? dealsIn = shopInfoResponse.data!.seller!.dealsIn?.toString();
        if (dealsIn != null && dealsIn.isNotEmpty) {
          List<String> dealsInList = dealsIn.split(',').map((categoryName) => categoryName.trim()).where((categoryName) => categoryName.isNotEmpty).toList();
          checkBoxListData = dealsInList.map((categoryName) => DataCheck(categoryName: categoryName, isSelected: true)).toList();
        }
      }

      if (shopInfoResponse != null && shopInfoResponse.data != null) {
        final List<ChildCat> dataList = shopInfoResponse.data!.childCat ?? [];
        setState(() {
          if (currentPage == 1) {
            data = dataList;
          } else {
            data!.addAll(dataList);
          }
          isLoading = false;
          currentPage++;
        });
      } else {
        setState(() {
          isLoading = false;
          isPullToRefreshEnabled = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      final Map<String, dynamic> formData = {
        "parent_categories_list": selectedPCategoryID,
        "child_categories_list": selectedCategoryNamesString,
      };

      if (selectedPCategoryID == "null" || selectedPCategoryID.isEmpty) {
        LoadingScaffoldMessage.showSnackbar(
          context,
          "Please select category it is required.",
          Colors.red,
          const Duration(seconds: 2),
        );
      } else {
        fetchSellerRegistrationBodyApi(
          context: context,
          body: {
            "parent_categories_list": selectedPCategoryID,
            "child_categories_list": selectedCategoryNamesString,
          },
          baseUrl: "${ConstantUrls.baseUriApi}${ConstantUrls.registrationFourthApi}",
          onSuccess: () async {
            Navigator.pushNamed(context, "/shopProfileInfoScreen");
            }
        );
      }
    }
  }

  final ScrollController _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Skeletonizer(
        enabled: isLoading,
        child: ListView(
          controller: _scrollController,
          shrinkWrap: true,
          children: [
            customeText(
              text: "Deals In *",
              style: const TextStyle(
                fontFamily: 'Montserrat',
              ),
              textAlign: TextAlign.start,
            ),
            constantHeight(context, 80.0),

            dropDownForm(
              context: context,
              focusNode: _focusNode,
              colorBorder: ConstantColor.primaryMainColor,
              headText: 'Select Category',
              value: selectedItem,
              items: data!.map((ChildCat item) {
                List<String> parts = [
                  (item.cat != null && item.cat.toString().isNotEmpty) ? "${item.cat} ( " : ' ( ',
                  (item.pcat1 != null && item.pcat1.toString().isNotEmpty) ? "${item.pcat1}" : '',
                  (item.pcat2 != null && item.pcat2.toString().isNotEmpty) ? " >> ${item.pcat2}" : '',
                  (item.pcat3 != null && item.pcat1.toString().isNotEmpty) ? " >> ${item.pcat3} )" : ' ) ',
                ];
                String displayText = parts.where((part) => part.isNotEmpty).join('');
                displayText = displayText.replaceAll(RegExp(r'[\d=]'), '');
                return DropdownMenuItem<String>(
                  value: item.categoryId,
                  child: customeText(text: displayText, style: ConstantTextStyle.dropDownPrimeText),
                );
              }).toList(),
              onChanged: (newValue) async {
                setState(() {
                  selectedItem = newValue;
                  for (ChildCat item in data!) {
                    if (item.categoryId == selectedItem) {
                      // Extract parts
                      String cat = item.cat ?? '';
                      String pcat1 = item.pcat1 ?? '';
                      String pcat2 = item.pcat2 ?? '';
                      String pcat3 = item.pcat3 ?? '';
                      // Check conditions to determine selectedPCategoryID
                      if (pcat3 != null && pcat3.isNotEmpty) {
                        selectedPCategoryID = pcat3;
                      }
                      else if (pcat2 != null && pcat2.isNotEmpty) {
                        selectedPCategoryID = pcat2;
                      }
                      else if (pcat1 != null && pcat1.isNotEmpty) {
                        selectedPCategoryID = pcat1;
                      }
                      else {selectedPCategoryID = cat;}
                      // Remove everything after the first '=' character
                      if (selectedPCategoryID.contains('=')) {
                        selectedPCategoryID = selectedPCategoryID.split('=')[0];
                      }
                      break; // Exit loop once found
                    }
                  }
                });
                var result = await ApiChildCatListingService.fetchChildCatListingData(
                  categoryId: selectedPCategoryID,
                  context: context, // Pass your BuildContext here if needed
                );
                setState(() {
                  checkBoxListData = result!.data ?? [];
                });
              },
              // onChanged: (newValue) async {
              //   setState(() {
              //     selectedItem = newValue;
              //     if (selectedItem != null) {
              //       if (selectedPCategoryID.isNotEmpty) {
              //         selectedPCategoryID += ', ';
              //       }
              //       selectedPCategoryID += selectedItem!;
              //     }
              //   });
              //
              //   var result = await ApiChildCatListingService.fetchChildCatListingData(
              //     categoryId: newValue,
              //     context: context, // Pass your BuildContext here if needed
              //   );
              //   setState(() {
              //     checkBoxListData = result!.data ?? [];
              //   });
              // },
            ),

            constantHeight(context, 50.0),

            // Display checkboxes based on checkBoxListData
            ...checkBoxListData.map((categoryName) {
              return Card(
                elevation: categoryName.isSelected ?? false ? 0 : .2,
                child: CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  activeColor: ConstantColor.filedContainerColor,
                  checkColor: ConstantColor.primaryBackgroundMainColor,
                  title: customeText(
                    text: categoryName.categoryName ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: ConstantTextStyle.allHomeScreenAvatarText,
                  ),
                  value: categoryName.isSelected ?? false,
                  onChanged: (bool? value) {
                    setState(() {
                      categoryName.isSelected = value ?? false;
                      //  store check box data in string
                      if (value == true) {
                        selectedCategoryNamesString += (selectedCategoryNamesString.isNotEmpty ? ', ' : '') +
                            (categoryName.categoryName ?? '');
                      } else {
                        final removedName = (categoryName.categoryName ?? '');
                        final List<dynamic> sringName = selectedCategoryNamesString.split(',');
                        sringName.removeLast();
                        selectedCategoryNamesString = sringName.join(',');
                      }
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              );
              // return Visibility(
              //   visible: selectedItem != null,
              //   child:
              //   Card(
              //     elevation: categoryName.isSelected ?? false ? 0 : .2,
              //     child: CheckboxListTile(
              //       contentPadding: EdgeInsets.zero,
              //       dense: true,
              //       checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              //       activeColor: ConstantColor.filedContainerColor,
              //       checkColor: ConstantColor.primaryBackgroundMainColor,
              //       title: customeText(
              //         text: categoryName.categoryName ?? '',
              //         overflow: TextOverflow.ellipsis,
              //         style: ConstantTextStyle.allHomeScreenAvatarText,
              //       ),
              //       value: categoryName.isSelected ?? false,
              //       onChanged: (bool? value) {
              //         setState(() {
              //           categoryName.isSelected = value ?? false;
              //           //  store check box data in string
              //           if (value == true) {
              //             selectedCategoryNamesString += (selectedCategoryNamesString.isNotEmpty ? ', ' : '') +
              //                 (categoryName.categoryName ?? '');
              //           } else {
              //             final removedName = (categoryName.categoryName ?? '');
              //             final List<dynamic> sringName = selectedCategoryNamesString.split(',');
              //             sringName.removeLast();
              //             selectedCategoryNamesString = sringName.join(',');
              //           }
              //         });
              //       },
              //       controlAffinity: ListTileControlAffinity.leading,
              //     ),
              //   ),
              // );
            }),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customButton(
                  textStyleButton: ConstantTextStyle.topCategoryText4,
                  onPressed: () {
                    setState(() {
                      widget.onPreview();
                    });
                  },
                  text: 'Previous',
                  backgroundColor: ConstantColor.sellerBGColor,
                  borderRadius: BorderRadius.circular(20.0),
                  elevation: 1.0,
                ),

                customButton(
                  textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                  onPressed: isLoading ? null : _handleSubmit,
                  text: "Submit",
                  backgroundColor: ConstantColor.primaryMainColor,
                  borderRadius: BorderRadius.circular(20.0),
                  elevation: 1.0,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
