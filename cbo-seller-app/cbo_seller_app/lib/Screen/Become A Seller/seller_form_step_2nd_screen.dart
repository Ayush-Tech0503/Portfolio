// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:dio/dio.dart';
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
import '../../Widget/Drop Down /drop_down_widget.dart';
import '../../Widget/Scaffold Message/scaffold_message_widget.dart';
import '../../Widget/Text Form Fields/global_text_form_field.dart';
import 'upload_document_file_screen.dart';

class Step2ndSellerFormScreen extends StatefulWidget {
  final currectPageValue;
  final Function onNext;
  final Function onPreview;
  const Step2ndSellerFormScreen({super.key, this.currectPageValue, required this.onPreview, required this.onNext,});

  @override
  State<Step2ndSellerFormScreen> createState() => _Step2ndSellerFormScreenState();
}

class _Step2ndSellerFormScreenState extends State<Step2ndSellerFormScreen> {
  final TextEditingController _contactPersonController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _mobileUserController = TextEditingController();
  final TextEditingController _whatsAppNumberController = TextEditingController();
  final TextEditingController _emailIdController = TextEditingController();
  final TextEditingController _emailIdUserController = TextEditingController();
  final TextEditingController _referralCodeController = TextEditingController();
  final TextEditingController _registrationTypeController = TextEditingController();
  final TextEditingController _registrationNoTypeController = TextEditingController();
  final TextEditingController _provideOnRentController = TextEditingController();
  final TextEditingController _registrationNoController = TextEditingController();
  final TextEditingController _deliveryModeController = TextEditingController();
  final TextEditingController _storeDescriptionController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();



   final List<String> _onRentList = ['Sell', 'Provide On Rent', 'Sell & Provide On Rent'];

   final List<String> _onRegistrationTypeList = ['Gumasta', 'Nagar Nigam', 'Gst', 'Any Other'];

   final List<String> _deliveryModeList = ['Pick up from store', 'Home delivery available'];


  String defaultValue = 'Select';
  String rgTypeDefaultValue = 'Select';
  String modeDefaultValue = 'Select';
  String? _selectedFilePath;

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

      final shopInfoResponse = await ApiShopInfoPreviewService.fetchShopInfoPreviewData(context: context);

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
          _contactPersonController.text = data!.first.userInfo!.firstName??"";
          _designationController.text = data!.first.seller!.designation??"";
          _mobileUserController.text =  data?.first.userInfo?.mobile??'';
          _mobileController.text = data?.first.userInfo?.mobile?.isEmpty ?? true ? data?.first.seller?.mobile ?? "" : data?.first.userInfo?.mobile ?? "";
          _whatsAppNumberController.text = data!.first.seller?.contactNoOpt??"";
          _emailIdUserController.text = data!.first.userInfo?.email??"";
          _emailIdController.text = _emailIdUserController.text.isEmpty ? data!.first.seller?.email??"":data?.first.userInfo?.email??"";
          _referralCodeController.text = data!.first.seller!.referralCode??"";
          _registrationTypeController.text = data!.first.seller!.scRegistrationType??"";
          _registrationNoTypeController.text = data!.first.seller!.otherScRegType??"";
          _registrationNoController.text = data!.first.seller!.gstNo??"";
          _provideOnRentController.text = data!.first.seller!.buyOrRent??"";
          _deliveryModeController.text = data!.first.seller!.deliveryMode??"";
          _storeDescriptionController.text = data!.first.seller!.storeDescription??"";
          _selectedFilePath = data!.first.seller!.scRegistrationFile??"";
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

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      // Create FormData object
      FormData formData = FormData();
      formData.fields.addAll([
        MapEntry("contact_person", _contactPersonController.text),
        MapEntry("designation", _designationController.text),
        MapEntry("referral_code", _referralCodeController.text),
        MapEntry("whatsapp_number", _whatsAppNumberController.text),
        MapEntry("email_id", _emailIdController.text),
        MapEntry("mobile", _mobileController.text),
        MapEntry("sc_regno", _registrationTypeController.text),
        MapEntry("sc_other_type", _registrationNoTypeController.text),
        MapEntry("gst_no", _registrationNoController.text),
        MapEntry("buy_or_rent", _provideOnRentController.text),
        MapEntry("delivery_mode", _deliveryModeController.text),
        MapEntry("store_description", _storeDescriptionController.text),
        // MapEntry("reg_document_value", _selectedFilePath!),
      ]);

      if (_selectedFilePath != null && _selectedFilePath!.isNotEmpty) {
        try {
          // Extract file name from the path
          String fileName = _selectedFilePath!.split('/').last;
          // Create MultipartFile from local file path
          formData.files.add(MapEntry(
            "reg_document_value", await MultipartFile.fromFile(_selectedFilePath!, filename: fileName),
          ));
        } catch (e) {
          formData.fields.add(MapEntry("reg_document_value", _selectedFilePath!));
        }
      } else {
        LoadingScaffoldMessage.showSnackbar(
          context, "Please upload document file as it is required.",
          Colors.red,
          const Duration(seconds: 2),
        );
        return;
      }
      // Call your API function with formData
      if (_registrationTypeController.text == "Select" || _registrationTypeController.text.isEmpty){
        LoadingScaffoldMessage.showSnackbar(
          context, "Please select Shop/Company registration type, it is required.",
          Colors.red,
          const Duration(seconds: 2),
        );}
        else if (_provideOnRentController.text == "Select" || _provideOnRentController.text.isEmpty){
        LoadingScaffoldMessage.showSnackbar(
          context, "Please select Sell/Provide on rent registration type, it is required.",
          Colors.red,
          const Duration(seconds: 2),
        );}
        else if (_deliveryModeController.text == "Select" || _deliveryModeController.text.isEmpty){
        LoadingScaffoldMessage.showSnackbar(
          context, "Please select delivery mode registration type, it is required.",
          Colors.red,
          const Duration(seconds: 2),
        );}
        else{
        fetchSellerRegistrationFormData(
          context: context,
          formData: formData,
          baseUrl: "${ConstantUrls.baseUriApi}${ConstantUrls.registrationSecondtApi}",
          onSuccess: () => widget.onNext(),
        );
      }

    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override
  void initState() {
    super.initState();
    fetchPreFiledData();
  }


  @override
  Widget build(BuildContext context) {

    if (!_onRentList.contains(defaultValue)) {
      _onRentList.insert(0, defaultValue);
    }
    if (!_onRegistrationTypeList.contains(rgTypeDefaultValue)) {
      _onRegistrationTypeList.insert(0, rgTypeDefaultValue);
    }

    if (!_deliveryModeList.contains(modeDefaultValue)) {
      _deliveryModeList.insert(0, modeDefaultValue);
    }

    var screenHeight = MediaQuery.of(context).size.height;
    return  Form(
      key: _formKey,
      child: Skeletonizer(
        enabled: isLoading,
        child: ListView(
          controller: _scrollController,
          shrinkWrap: true,
          children: [

            Row(
              children: [
                Flexible(
                  child: GlobalTextFormField(
                 //   margin: EdgeInsets.only(bottom: screenHeight/50.0),
                    enabled: true,
                    controller: _contactPersonController,
                    keyboardType: TextInputType.text,
                    hintText: "",
                    labelText: "Contact Person",
                    hintStyle: ConstantTextStyle.otpHintTextStyle,
                    // labelStyle: ConstantTextStyle.otpHintTextStyle,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter contact Person';}
                      return null;
                    },
                  ),
                ),
                constantWidth(context, 40.0),
                Flexible(
                  child: GlobalTextFormField(enabled: true,
                 //   margin: EdgeInsets.symmetric(vertical: screenHeight/50.0),
                    controller: _designationController,
                    keyboardType: TextInputType.text,
                    hintText: "",
                    labelText: "Designation",
                    hintStyle: ConstantTextStyle.otpHintTextStyle,
                    // labelStyle: ConstantTextStyle.otpHintTextStyle,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter designation';}
                      return null;
                    },
                  ),
                ),
              ],
            ),
            constantHeight(context, 50.0),
            Row(
              children: [
                Flexible(
                  child: GlobalTextFormField(
                    // margin: EdgeInsets.only(bottom: screenHeight/50.0),
                    enabled: true,
                    filled: true,
                    fillColor: _mobileUserController.text.isNotEmpty ? ConstantColor.textFieldColor:ConstantColor.primaryBackgroundMainColor,
                    readOnly: _mobileUserController.text.isNotEmpty ? true: false,
                    controller: _mobileController,
                    keyboardType: TextInputType.number,
                    hintText: "",
                    labelText: "Mobile Number",
                    hintStyle: ConstantTextStyle.otpHintTextStyle,
                    // labelStyle: ConstantTextStyle.otpHintTextStyle,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter mobile no.';}
                      return null;
                    },
                  ),
                ),
                constantWidth(context, 40.0),
                Flexible(
                  child: GlobalTextFormField(enabled: true,
                    // margin: EdgeInsets.symmetric(vertical: screenHeight/50.0),
                    controller: _whatsAppNumberController,
                    keyboardType: TextInputType.number,
                    hintText: "",
                    labelText: "Whatsapp Number",
                    hintStyle: ConstantTextStyle.otpHintTextStyle,
                    // labelStyle: ConstantTextStyle.otpHintTextStyle,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter whatsapp no.';}
                      return null;
                    },
                  ),
                ),
              ],
            ),
            constantHeight(context, 50.0),
            Row(
              children: [
                Flexible(
                  child: GlobalTextFormField(
                    // margin: EdgeInsets.only(bottom: screenHeight/50.0),
                    enabled: true,
                    filled: true,
                    fillColor: _emailIdUserController.text.isNotEmpty ? ConstantColor.textFieldColor:ConstantColor.primaryBackgroundMainColor,
                    readOnly: _emailIdUserController.text.isNotEmpty ? true: false,
                    controller: _emailIdController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "",
                    labelText: "Email",
                    hintStyle: ConstantTextStyle.otpHintTextStyle,
                    // labelStyle: ConstantTextStyle.otpHintTextStyle,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';}
                      return null;
                    },
                  ),
                ),
                constantWidth(context, 40.0),
                Flexible(
                  child:    GlobalTextFormField(enabled: true,
                    // margin: EdgeInsets.symmetric(vertical: screenHeight/50.0),
                    controller: _referralCodeController,
                    keyboardType: TextInputType.text,
                    hintText: "",
                    labelText: "Referral Code",
                    hintStyle: ConstantTextStyle.otpHintTextStyle,
                    // labelStyle: ConstantTextStyle.otpHintTextStyle,
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),

            constantHeight(context, 60.0),
            AppDropdownInput(
              margin: EdgeInsets.symmetric(vertical: screenHeight / 50.0),
              hintText: "Shop/Company Registration Type",
              options: _onRegistrationTypeList,
              // errorText: "Please select Shop/Company Registration Type",
              // validator: (value) {
              //   if (value == null || value.isEmpty|| value == 'Select') {
              //     return 'Please enter legal business name';}
              //   return null;
              // },
              value: _registrationTypeController.text.isEmpty || !_onRegistrationTypeList.contains(_registrationTypeController.text) ? rgTypeDefaultValue : _registrationTypeController.text,
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    _registrationTypeController.text = value;
                  });
                }
              },
              getLabel: (String value) => value,
            ),

            _registrationTypeController.text == "Any Other"
            ? GlobalTextFormField(
              margin: EdgeInsets.only(bottom: screenHeight/50.0),
              enabled: true,
              controller: _registrationNoTypeController,
              keyboardType: TextInputType.text,
              hintText: "",
              labelText: "Shop/Company Registration No. Type",
              hintStyle: ConstantTextStyle.otpHintTextStyle,
              // labelStyle: ConstantTextStyle.otpHintTextStyle,
              onChanged: (value) {},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Shop/Company registration no. type';}
                return null;
              },
            )
            : Container(),
            //_registrationTypeController.text

            AppDropdownInput(
              margin: EdgeInsets.symmetric(vertical: screenHeight / 50.0),
              hintText: "Sell/Provide on rent",
              options: _onRentList,
              value: _provideOnRentController.text.isEmpty || !_onRentList.contains(_provideOnRentController.text) ? defaultValue : _provideOnRentController.text,
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    _provideOnRentController.text = value;
                  });
                }
              },
              getLabel: (String value) => value,
            ),

            GlobalTextFormField(
              margin: EdgeInsets.only(bottom: screenHeight/50.0),
              enabled: true,
              controller: _registrationNoController,
              keyboardType: TextInputType.text,
              hintText: "",
              labelText: "Shop/Company Registration No",
              hintStyle: ConstantTextStyle.otpHintTextStyle,
              // labelStyle: ConstantTextStyle.otpHintTextStyle,
              onChanged: (value) {},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Shop/Company registration no.';}
                return null;
              },
            ),

            AppDropdownInput(
              margin: EdgeInsets.symmetric(vertical: screenHeight / 50.0),
              hintText: "Delivery Mode",
              options: _deliveryModeList,
              value: _deliveryModeController.text.isEmpty || !_deliveryModeList.contains(_deliveryModeController.text) ? modeDefaultValue : _deliveryModeController.text,
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    _deliveryModeController.text = value;
                  });
                }
              },
              getLabel: (String value) => value,
            ),

            GlobalTextFormField(
              margin: EdgeInsets.only(bottom: screenHeight/50.0),
              enabled: true,
              controller: _storeDescriptionController,
              keyboardType: TextInputType.text,
              hintText: "",
              maxLines: 5,
              labelText: "Store Description",
              hintStyle: ConstantTextStyle.otpHintTextStyle,
              // labelStyle: ConstantTextStyle.otpHintTextStyle,
              onChanged: (value) {},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter store description';}
                return null;
              },
            ),

            UploadRegistrationDocumentsScreen(
              buttonTitle: 'Upload Registration Documents',
              filePath: _selectedFilePath??"",
              onFileSelected: (filePath) {
                setState(() {_selectedFilePath = filePath;});}),

            constantHeight(context, 50.0),
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