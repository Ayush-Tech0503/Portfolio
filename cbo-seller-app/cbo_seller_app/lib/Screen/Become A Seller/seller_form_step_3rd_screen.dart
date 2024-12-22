// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use, use_build_context_synchronously

import 'dart:convert';

import 'package:citybazaronline_seller_app/Screen/Become%20A%20Seller/upload_store_banner_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../Models/Shop Info Preview Model/registration_preview_model.dart';
import '../../Services/Seller Forms Api Services/Seller Form Submit Api Services/step_2nd_form_submit_api.dart';
import '../../Services/shop_registration_preview_api_services.dart';
import '../../Utils/Constant Api Routs/constant_api_routs.dart';
import '../../Utils/Constant Size /constant_sizes.dart';
import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';
import '../../Widget/Custome Buttons/elevetion_button_widget.dart';
import '../../Widget/Scaffold Message/scaffold_message_widget.dart';
import '../../Widget/Text Form Fields/global_text_form_field.dart';
import '../../Widget/custome_text_widget.dart';
import '../../Widget/times_dropdown_widget.dart';
import 'upload_store_logo_screen.dart';

class Step3rdSellerFormScreen extends StatefulWidget {
  final currectPageValue;
  final Function onNext;
  final Function onPreview;


   const Step3rdSellerFormScreen({Key? key, required this.onNext, this.currectPageValue, required this.onPreview,}) : super(key: key);

  @override
  State<Step3rdSellerFormScreen> createState() => _Step3rdSellerFormScreenState();
}

class _Step3rdSellerFormScreenState extends State<Step3rdSellerFormScreen> {
  final TextEditingController _yoeController = TextEditingController();

  final TextEditingController _mondayOpenController = TextEditingController();
  final TextEditingController _mondayCloseController = TextEditingController();
  final TextEditingController _mondayOnOffController = TextEditingController();

  final TextEditingController _tuesdayOpenController = TextEditingController();
  final TextEditingController _tuesdayCloseController = TextEditingController();
  final TextEditingController _tuesdayOnOffController = TextEditingController();

  final TextEditingController _wednesdayOpenController = TextEditingController();
  final TextEditingController _wednesdayCloseController = TextEditingController();
  final TextEditingController _wednesdayOnOffController = TextEditingController();

  final TextEditingController _thursdayOpenController = TextEditingController();
  final TextEditingController _thursdayCloseController = TextEditingController();
  final TextEditingController _thursdayOnOffController = TextEditingController();

  final TextEditingController _fridayOpenController = TextEditingController();
  final TextEditingController _fridayCloseController = TextEditingController();
  final TextEditingController _fridayOnOffController = TextEditingController();

  final TextEditingController _saturdayOpenController = TextEditingController();
  final TextEditingController _saturdayCloseController = TextEditingController();
  final TextEditingController _saturdayOnOffController = TextEditingController();

  final TextEditingController _sundayOpenController = TextEditingController();
  final TextEditingController _sundayCloseController = TextEditingController();
  final TextEditingController _sundayOnOffController = TextEditingController();


  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  final _formKey = GlobalKey<FormState>();



  //api here

  ShopInfoPreviewModel? shopInfoPreviewModel;
  List<ShopInfoPreviewData>? data = [];
  bool isPullToRefreshEnabled = true;
  int currentPage = 1;
  bool isLoading = false;



  Future<void> fetchPreFiledData() async {
    try {
      if (currentPage == 1) {
        setState(() {
          isLoading = true;
          data!.clear();
        });
      }

      final shopInfoResponse =
      await ApiShopInfoPreviewService.fetchShopInfoPreviewData(context: context);

      if (shopInfoResponse != null && shopInfoResponse.data != null) {
        final dataList = shopInfoResponse.data!;

        setState(() {
          if (currentPage == 1) {
            data = [dataList];
          } else {
            data!.addAll([dataList]);
          }

          isLoading = false;
          currentPage++;
        });

        setState(() {
          _selectedLogoFilePath = data!.first.seller!.storeLogoName ?? "";
          _selectedBannerFilePath = data!.first.seller!.storeBannerName ?? "";
          _yoeController.text = data!.first.seller!.yearOfEstablishment ?? "";
          selectedPaymentModes = data!.first.seller!.paymentModesAccepted ?? "";

          // Initialize sellerOpenHrs with static data if it's empty
          if (data!.first.sellerOpenHrs!.isEmpty) {
            shopTimeInfo = [
              {"day": 'Monday', "open_time": '10:00 am', "close_time": '8:00 pm', "isOpen": true},
              {"day": 'Tuesday', "open_time": '10:00 am', "close_time": '8:00 pm', "isOpen": true},
              {"day": 'Wednesday', "open_time": '10:00 am', "close_time": '8:00 pm', "isOpen": true},
              {"day": 'Thursday', "open_time": '10:00 am', "close_time": '8:00 pm', "isOpen": true},
              {"day": 'Friday', "open_time": '10:00 am', "close_time": '8:00 pm', "isOpen": true},
              {"day": 'Saturday', "open_time": '10:00 am', "close_time": '8:00 pm', "isOpen": true},
              {"day": 'Sunday', "open_time": '10:00 am', "close_time": '8:00 pm', "isOpen": true},
            ];
          } else {
            for (int i = 0; i < data!.first.sellerOpenHrs!.length; i++) {
              var openHr = data!.first.sellerOpenHrs![i];
              var isOpen = openHr.onOff == "1" ? true : false;
              var openTime = openHr.opensAt ?? "10:00 am";
              var closeTime = openHr.closesAt ?? "8:00 pm";

              switch (i) {
                case 0:
                  _mondayOpenController.text = openTime;
                  _mondayCloseController.text = closeTime;
                  _mondayOnOffController.text = isOpen.toString(); // Store as string
                  break;
                case 1:
                  _tuesdayOpenController.text = openTime;
                  _tuesdayCloseController.text = closeTime;
                  _tuesdayOnOffController.text = isOpen.toString(); // Store as string
                  break;
                case 2:
                  _wednesdayOpenController.text = openTime;
                  _wednesdayCloseController.text = closeTime;
                  _wednesdayOnOffController.text = isOpen.toString(); // Store as string
                  break;
                case 3:
                  _thursdayOpenController.text = openTime;
                  _thursdayCloseController.text = closeTime;
                  _thursdayOnOffController.text = isOpen.toString(); // Store as string
                  break;
                case 4:
                  _fridayOpenController.text = openTime;
                  _fridayCloseController.text = closeTime;
                  _fridayOnOffController.text = isOpen.toString(); // Store as string
                  break;
                case 5:
                  _saturdayOpenController.text = openTime;
                  _saturdayCloseController.text = closeTime;
                  _saturdayOnOffController.text = isOpen.toString(); // Store as string
                  break;
                case 6:
                  _sundayOpenController.text = openTime;
                  _sundayCloseController.text = closeTime;
                  _sundayOnOffController.text = isOpen.toString(); // Store as string
                  break;
              }
            }

            shopTimeInfo = [
              {"day": 'Monday', "open_time": _mondayOpenController.text ?? '10:00 am', "close_time": _mondayCloseController.text ?? '8:00 pm', "isOpen": _mondayOnOffController.text == "true"},
              {"day": 'Tuesday', "open_time": _tuesdayOpenController.text ?? '10:00 am', "close_time": _tuesdayCloseController.text ?? '8:00 pm', "isOpen": _tuesdayOnOffController.text == "true"},
              {"day": 'Wednesday', "open_time": _wednesdayOpenController.text ?? '10:00 am', "close_time": _wednesdayCloseController.text ?? '8:00 pm', "isOpen": _wednesdayOnOffController.text == "true"},
              {"day": 'Thursday', "open_time": _thursdayOpenController.text ?? '10:00 am', "close_time": _thursdayCloseController.text ?? '8:00 pm', "isOpen": _thursdayOnOffController.text == "true"},
              {"day": 'Friday', "open_time": _fridayOpenController.text ?? '10:00 am', "close_time": _fridayCloseController.text ?? '8:00 pm', "isOpen": _fridayOnOffController.text == "true"},
              {"day": 'Saturday', "open_time": _saturdayOpenController.text ?? '10:00 am', "close_time": _saturdayCloseController.text ?? '8:00 pm', "isOpen": _saturdayOnOffController.text == "true"},
              {"day": 'Sunday', "open_time": _sundayOpenController.text ?? '10:00 am', "close_time": _sundayCloseController.text ?? '8:00 pm', "isOpen": _sundayOnOffController.text == "true"},
            ];
          }
        });
      } else {
        setState(() {
          isLoading = false;
          isPullToRefreshEnabled = false; // Disable pull-to-refresh
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Future<void> fetchPreFiledData() async {
  //   try {
  //     if (currentPage == 1) {
  //       setState(() {
  //         isLoading = true;
  //         data!.clear();
  //       });
  //     }
  //
  //     final shopInfoResponse =
  //     await ApiShopInfoPreviewService.fetchShopInfoPreviewData(context: context);
  //
  //     if (shopInfoResponse != null && shopInfoResponse.data != null) {
  //       final dataList = shopInfoResponse.data!;
  //
  //       setState(() {
  //         if (currentPage == 1) {
  //           data = [dataList];
  //         } else {
  //           data!.addAll([dataList]);
  //         }
  //
  //         isLoading = false;
  //         currentPage++;
  //       });
  //
  //       setState(() {
  //         _selectedLogoFilePath = data!.first.seller!.storeLogoName ?? "";
  //         _selectedBannerFilePath = data!.first.seller!.storeBannerName ?? "";
  //         _yoeController.text = data!.first.seller!.yearOfEstablishment ?? "";
  //         selectedPaymentModes = data!.first.seller!.paymentModesAccepted ?? "";
  //
  //         for (int i = 0; i < data!.first.sellerOpenHrs!.length; i++) {
  //           var openHr = data!.first.sellerOpenHrs![i];
  //           var isOpen = openHr.onOff == "1" ? true : false;
  //           var openTime = openHr.opensAt ?? "11:00 am";
  //           var closeTime = openHr.closesAt ?? "8:00 pm";
  //
  //           switch (i) {
  //             case 0:
  //               _mondayOpenController.text = openTime;
  //               _mondayCloseController.text = closeTime;
  //               _mondayOnOffController.text = isOpen.toString(); // Store as string
  //               break;
  //             case 1:
  //               _tuesdayOpenController.text = openTime;
  //               _tuesdayCloseController.text = closeTime;
  //               _tuesdayOnOffController.text = isOpen.toString(); // Store as string
  //               break;
  //             case 2:
  //               _wednesdayOpenController.text = openTime;
  //               _wednesdayCloseController.text = closeTime;
  //               _wednesdayOnOffController.text = isOpen.toString(); // Store as string
  //               break;
  //             case 3:
  //               _thursdayOpenController.text = openTime;
  //               _thursdayCloseController.text = closeTime;
  //               _thursdayOnOffController.text = isOpen.toString(); // Store as string
  //               break;
  //             case 4:
  //               _fridayOpenController.text = openTime;
  //               _fridayCloseController.text = closeTime;
  //               _fridayOnOffController.text = isOpen.toString(); // Store as string
  //               break;
  //             case 5:
  //               _saturdayOpenController.text = openTime;
  //               _saturdayCloseController.text = closeTime;
  //               _saturdayOnOffController.text = isOpen.toString(); // Store as string
  //               break;
  //             case 6:
  //               _sundayOpenController.text = openTime;
  //               _sundayCloseController.text = closeTime;
  //               _sundayOnOffController.text = isOpen.toString(); // Store as string
  //               break;
  //           }
  //         }
  //
  //         shopTimeInfo = [
  //           {"day": 'Monday', "open_time": _mondayOpenController.text??'', "close_time": _mondayCloseController.text??"", "isOpen": _mondayOnOffController.text == "true"},
  //           {"day": 'Tuesday', "open_time": _tuesdayOpenController.text??"", "close_time": _tuesdayCloseController.text??"", "isOpen": _tuesdayOnOffController.text == "true"},
  //           {"day": 'Wednesday', "open_time": _wednesdayOpenController.text??"", "close_time": _wednesdayCloseController.text??"", "isOpen": _wednesdayOnOffController.text == "true"},
  //           {"day": 'Thursday', "open_time": _thursdayOpenController.text??'', "close_time": _thursdayCloseController.text??"", "isOpen": _thursdayOnOffController.text == "true"},
  //           {"day": 'Friday', "open_time": _fridayOpenController.text??"", "close_time": _fridayCloseController.text??"", "isOpen": _fridayOnOffController.text == "true"},
  //           {"day": 'Saturday', "open_time": _saturdayOpenController.text??'', "close_time": _saturdayCloseController.text??"", "isOpen": _saturdayOnOffController.text == "true"},
  //           {"day": 'Sunday', "open_time": _sundayOpenController.text??"", "close_time": _sundayCloseController.text??"", "isOpen": _sundayOnOffController.text == "true"},
  //         ];
  //       });
  //     } else {
  //       setState(() {
  //         isLoading = false;
  //         isPullToRefreshEnabled = false; // Disable pull-to-refresh
  //       });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }


  @override
  void initState() {
    super.initState();
    fetchPreFiledData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


//---------------------
  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      // Create FormData object
      FormData formData = FormData();
      // Convert shopTimeInfo to JSON string
      String jsonShopTimeString = jsonEncode(shopTimeInfo);
      // Add fields to formData
      formData.fields.addAll([
        MapEntry("year_of_establishment", _yoeController.text),
        MapEntry("payment_modes_accepted", selectedPaymentModes),
        MapEntry("shopTimeInfo", jsonShopTimeString),
      ]);


      if (_selectedLogoFilePath != null && _selectedLogoFilePath!.isNotEmpty) {
        try {
          String fileName = _selectedLogoFilePath!.split('/').last;
          formData.files.add(MapEntry("store_logo", await MultipartFile.fromFile(_selectedLogoFilePath!, filename: fileName),));
        } catch (e) {
          formData.fields.add(MapEntry("store_logo", _selectedLogoFilePath!));
        }
      } else {
        LoadingScaffoldMessage.showSnackbar(
          context, "Please upload store logo it is required.",
          Colors.red,
          const Duration(seconds: 2),
        );
        return;
      }

      if (_selectedBannerFilePath != null && _selectedBannerFilePath!.isNotEmpty) {
        try {
          String fileName = _selectedBannerFilePath!.split('/').last;
          formData.files.add(MapEntry("store_logo", await MultipartFile.fromFile(_selectedBannerFilePath!, filename: fileName),));
        } catch (e) {formData.fields.add(MapEntry("store_logo", _selectedBannerFilePath!));}
      } else {
        LoadingScaffoldMessage.showSnackbar(
          context, "Please upload store banner it is required.",
          Colors.red,
          const Duration(seconds: 2),
        );
        return;
      }


      // Call your API function with formData
     await fetchSellerRegistrationFormData(
        context: context,
        formData: formData,
        baseUrl: "${ConstantUrls.baseUriApi}${ConstantUrls.registrationThirdApi}",
        onSuccess: () => widget.onNext(),
      );
    }
  }




  List<Map<String, dynamic>> shopTimeInfo = [];

  final List<String> _timeOptions1 = [
    '10:00 am',
    '11:00 am',
    '12:00 pm',
    '1:00 pm',
    '2:00 pm',
    '3:00 pm',
    '4:00 pm',
    '5:00 pm',
    '6:00 pm',
    '7:00 pm',
    '8:00 pm',
    '9:00 pm',
    '10:00 pm',
    '11:00 pm',
    '12:00 am',
  ];

bool selectAllChecked = false;

  List paymentTextName = [
    "Cash",
    "Money Orders",
    "G Pay",
    'Payumoney',
    'RuPay Card',
    'Master Card',
    'Cheques',
    'UPI',
    'PhonePe',
    'Visa Card',
    'Credit Card',
    'BHIM',
    'NEFT',
    'Debit Cards',
    'Paytm',
    'Cash on Delivery',
    'Pockets by ICICI',
  ];

  String selectedPaymentModes = "";
  updateSelectedPaymentMode(String paymentMode, bool isChecked) {
    setState(() {
      if (isChecked) {
        if (selectedPaymentModes.isNotEmpty) {
          selectedPaymentModes += ",";
        }
        selectedPaymentModes += paymentMode;
      } else {
        // Remove the payment mode from the string
        selectedPaymentModes = selectedPaymentModes
            .split(',')
            .where((mode) => mode != paymentMode)
            .join(',');
      }
    });
  }


  String? _selectedLogoFilePath;
  String? _selectedBannerFilePath;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return  Form(
      key: _formKey,
      child: Skeletonizer(
        enabled: isLoading,
        child: ListView(
          controller: _scrollController,
          shrinkWrap: true,
          children: [
            customeText(
              text: "Store Logo*",
              style: ConstantTextStyle.allHomeScreenAvatarText,
              textAlign: TextAlign.start),

            constantHeight(context, 80.0),

            UploadStoreLogoScreen(
            buttonTitle: 'Upload Store Logo',
            filePath: _selectedLogoFilePath,
            onFileSelected: (filePath) {
              setState(() {_selectedLogoFilePath = filePath;});}),

            constantHeight(context, 40.0),

            customeText(
                text: "Store Banner*",
                style: ConstantTextStyle.allHomeScreenAvatarText,
                textAlign: TextAlign.start),

            constantHeight(context, 80.0),


            UploadStoreBannerScreen(
          buttonTitle: 'Upload Store Banner',
              filePath: _selectedBannerFilePath,
            onFileSelected: (filePath) {
            setState(() {_selectedBannerFilePath = filePath;});}),



            constantHeight(context, 40.0),


            /*--------------------------------Calendar Section start  -------------------------------------*/
            ScrollbarTheme(
              data: ScrollbarThemeData(
                crossAxisMargin: 2.5,
                radius: const Radius.circular(10.0),
                thickness: MaterialStateProperty.all(5.0),
                trackBorderColor: MaterialStateProperty.all(
                    ConstantColor.trackBGolor),
                thumbColor: MaterialStateProperty.all(
                    ConstantColor.primaryMainColor),
                trackColor: MaterialStateProperty.all(
                    ConstantColor.trackBGolor),
              ),
              child:Scrollbar(
                controller: _scrollController2,
                trackVisibility: true,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: _scrollController2,
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    children: [


                      DataTable(
                        border: TableBorder.all(color: ConstantColor.calendarBGHeadColor), // Use TableBorder instead of Border
                        columnSpacing: screenWidth/10,
                        headingRowColor: MaterialStateColor.resolveWith((states) => ConstantColor.calendarBGHeadColor),
                        dataRowHeight: screenHeight/16,
                        columns:  [
                          DataColumn(label: customeText(
                            text:
                            'Day'.toUpperCase(),
                            style: ConstantTextStyle
                                .hintTextStyle2,
                            textAlign: TextAlign.start,),),
                          DataColumn(label: customeText(
                            text: 'Close/open'.toUpperCase(),
                            style: ConstantTextStyle.hintTextStyle2,
                            textAlign: TextAlign.start,),),
                          DataColumn(label: customeText(
                            text:
                            'Open Time'.toUpperCase(),
                            style: ConstantTextStyle.hintTextStyle2,
                            textAlign: TextAlign.start,),),
                          DataColumn(label: customeText(
                            text:
                            'Close Time'.toUpperCase(),
                            style: ConstantTextStyle.hintTextStyle2,
                            textAlign: TextAlign.start,),),
                        ],

                        rows: List.generate(shopTimeInfo.length, (dayIndex) {
                          String? day = shopTimeInfo[dayIndex]['day']??'';
                          bool? isOpen = shopTimeInfo[dayIndex]['isOpen']?? false;
                          String? openTime = shopTimeInfo[dayIndex]['open_time']??'';
                          String? closeTime = shopTimeInfo[dayIndex]['close_time']??'';

                          return DataRow(cells: [
                            DataCell(
                              Text(
                                day!.toUpperCase(),
                                style: ConstantTextStyle.allHomeScreenAvatarText,
                              ),
                            ),
                            DataCell(
                              Center(
                                child: Transform.scale(
                                  scale: 0.7,
                                  child: CupertinoSwitch(
                                    value: isOpen!,
                                    thumbColor: ConstantColor.primaryBackgroundMainColor,
                                    activeColor: ConstantColor.primaryMainColor,
                                    onChanged: (value) {
                                      setState(() {
                                        shopTimeInfo[dayIndex]['isOpen'] = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                height: screenHeight / 25,
                                child: timeDropDownFormField(
                                  formFieldStyle: ConstantTextStyle.allHomeScreenAvatarText,
                                  value: openTime,
                                  onChanged: (newValue) {
                                    setState(() {
                                      shopTimeInfo[dayIndex]['open_time'] = newValue;
                                    });
                                  },
                                  items: _timeOptions1!,
                                  context: context,
                                  enabledBorderColor: ConstantColor.textFieldColor,
                                  focusedBorderColor: ConstantColor.textFieldColor,
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                height: screenHeight / 25,
                                child: timeDropDownFormField(
                                  formFieldStyle: ConstantTextStyle.allHomeScreenAvatarText,
                                  value: closeTime,
                                  onChanged: (newValue) {
                                    setState(() {
                                      shopTimeInfo[dayIndex]['close_time'] = newValue;
                                    });
                                  },
                                  items: _timeOptions1!,
                                  context: context,
                                  enabledBorderColor: ConstantColor.textFieldColor,
                                  focusedBorderColor: ConstantColor.textFieldColor,
                                ),
                              ),
                            ),
                          ]);
                        }),
                      ),
                      //---------------------------------------------------------

                      SizedBox(
                        height: screenHeight / 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            /*--------------------------------Calendar Section end  -------------------------------------*/
            SizedBox(height: screenHeight / 40),
            /*----------------------------Payment Mode  Start----------------------------------*/
            ListTile(
              visualDensity: const VisualDensity(horizontal: 4, vertical: -4),
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: customeText(
                text: "Payment Modes Accepted By You*",
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                ),
                textAlign: TextAlign.start,
              ),
              title: customButton(
                textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                onPressed: (){
                  setState(() {
                    selectAllChecked = !selectAllChecked;
                    if (selectAllChecked) {
                      selectedPaymentModes =paymentTextName.join(',');
                    } else {selectedPaymentModes = "";
                    }
                  });
                },
                text: "Select all",
                backgroundColor: ConstantColor.primaryMainColor,
                borderRadius: BorderRadius.circular(20.0),
                elevation: 1.0,
              )),




            //*------------------------------Payment Row 1 start---------------------------
            ...paymentTextName.map((paymentMode) {
              return CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                checkboxShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                activeColor: ConstantColor.filedContainerColor,
                checkColor: ConstantColor.primaryBackgroundMainColor,
                title: customeText(
                  text:paymentMode.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: ConstantTextStyle.allHomeScreenAvatarText,
                ),
                value: selectedPaymentModes.contains(paymentMode),
                onChanged: (newValue) {
                  updateSelectedPaymentMode(paymentMode, newValue!);
                },
                controlAffinity: ListTileControlAffinity.leading,
              );
            }).toList(),
            /*----------------------------Payment Mode  Start----------------------------------*/

            GlobalTextFormField(
              margin: EdgeInsets.symmetric(vertical: screenHeight/40.0),
              enabled: true,
              controller: _yoeController,
              keyboardType: TextInputType.text,
              hintText: "",
              labelText: "Year Of Establishment",
              hintStyle: ConstantTextStyle.otpHintTextStyle,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter year of establishment';}
                return null;
              },
              // labelStyle: ConstantTextStyle.otpHintTextStyle,
              onChanged: (value) {},
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // if (currentStep > 0)
                customButton(
                  textStyleButton: ConstantTextStyle.topCategoryText4,
                  onPressed:(){ setState(() {
                    widget.onPreview();
                  });},
                  text: 'Previous',
                  backgroundColor: ConstantColor.sellerBGColor,
                  borderRadius: BorderRadius.circular(20.0),
                  elevation: 1.0,
                ),

                customButton(
                  textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                  onPressed: isLoading ? null : _handleSubmit,
                  text: "NEXT",
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










