import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../Models/Shop Info Preview Model/registration_preview_model.dart';
import '../../Services/Seller Forms Api Services/Seller Form Submit Api Services/step_1st_form_submit_api.dart';
import '../../Services/shop_registration_preview_api_services.dart';
import '../../Utils/Constant Api Routs/constant_api_routs.dart';
import '../../Utils/Constant Size /constant_sizes.dart';
import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Get Current Location/get_current_location.dart';
import '../../Utils/Theme/constant_colors.dart';
import '../../Widget/Custome Buttons/elevetion_button_widget.dart';
import '../../Widget/Text Form Fields/global_text_form_field.dart';

class Step1stSellerFormScreen extends StatefulWidget {
  final Function onNext;

  const Step1stSellerFormScreen({super.key, required this.onNext,});

  @override
  State<Step1stSellerFormScreen> createState() => _Step1stSellerFormScreenState();
}

class _Step1stSellerFormScreenState extends State<Step1stSellerFormScreen> {
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _legalBusinessNameController = TextEditingController();
  final TextEditingController _buildingNumberStreetController = TextEditingController();
  final TextEditingController _locationAddressController = TextEditingController();
  final TextEditingController _landMarkController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  final ScrollController _scrollController = ScrollController();


  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  ShopInfoPreviewModel? shopInfoPreviewModel;
  List<ShopInfoPreviewData>? data = [];
  bool isPullToRefreshEnabled = true;
  bool isLoading = false;


  Future<void> fetchPreFiledData() async {
    try {
      if (!mounted) return; // Ensure the widget is still mounted before proceeding
        setState(() {
          isLoading = true;
          data?.clear(); // Clear data if it exists
        });
      final shopInfoResponse = await ApiShopInfoPreviewService.fetchShopInfoPreviewData(context: context);
      if (!mounted) return; // Ensure the widget is still mounted before proceeding
      if (shopInfoResponse != null && shopInfoResponse.data != null) {
        final dataList = shopInfoResponse.data!;
        setState(() {
          data = [dataList]; // Assign new data
          isLoading = false;
        });
        // Update text controllers only if mounted
        if (mounted) {
          setState(() {
            _businessNameController.text = data!.first.seller!.storeName ?? "";
            _legalBusinessNameController.text = data!.first.seller!.legalBusinessName ?? "";
            _buildingNumberStreetController.text = data!.first.seller!.storeAddress ?? "";
            _locationAddressController.text = data!.first.seller!.storeLocAddress ?? "";
            _landMarkController.text = data!.first.seller!.landmark ?? "";
            _cityController.text = data!.first.seller!.cityId ?? "";
            _pincodeController.text = data!.first.seller!.pincode ?? "";
            _stateController.text = data!.first.seller!.stateId ?? "";
            _countryController.text = data!.first.seller!.countryId ?? "";
            _latitudeController.text = data!.first.seller!.storeLatitude ?? "";
            _longitudeController.text = data!.first.seller!.storeLongitude ?? "";
          });
        }

      } else {
        if (mounted) {
          setState(() {
            isLoading = false;
            _refreshController.loadNoData();
            isPullToRefreshEnabled = false; // Disable pull-to-refresh
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _refreshController.loadNoData();
          isLoading = false;
        });
      }
    }
  }


  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      fetchSellerRegistrationBodyApi(
        context: context,
        baseUrl: '${ConstantUrls.baseUriApi}${ConstantUrls.registrationFirstApi}',
        body: {
          "business_name": _businessNameController.text,
          "legal_business_name": _legalBusinessNameController.text,
          "building": _buildingNumberStreetController.text,
          "saddress_loc": _locationAddressController.text,
          "landmark": _landMarkController.text,
          "latitude": _latitudeController.text,
          "longitude": _longitudeController.text,
          "country": _countryController.text,
          "state": _stateController.text,
          "city": _cityController.text,
          "pincode": _pincodeController.text,
        },
        onSuccess: () => widget.onNext(),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPreFiledData();
  }

  @override
  void dispose() {
    _businessNameController.dispose();
    _legalBusinessNameController.dispose();
    _buildingNumberStreetController.dispose();
    _locationAddressController.dispose();
    _landMarkController.dispose();
    _cityController.dispose();
    _pincodeController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _scrollController.dispose();
    super.dispose();
  }


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return   Form(
      key: _formKey,
      child: Skeletonizer(
        enabled: isLoading,
        child: ListView(
          controller: _scrollController,
          shrinkWrap: true,
          children: [
            GlobalTextFormField(
              margin: EdgeInsets.only(bottom: screenHeight/80.0),
              enabled: true,
              controller: _businessNameController,
              keyboardType: TextInputType.text,
              hintText: "",
              labelText: "Business Name",
              validator: (value) {
                if (value == null || value.isEmpty) {return 'Please enter business name';}
                return null;
              },
              hintStyle: ConstantTextStyle.otpHintTextStyle,
              // labelStyle: ConstantTextStyle.otpHintTextStyle,
              onChanged: (value) {},
            ),

            GlobalTextFormField(enabled: true,
              margin: EdgeInsets.symmetric(vertical: screenHeight/80.0),
              controller: _legalBusinessNameController,
              keyboardType: TextInputType.text,
              hintText: "",
              labelText: "Legal Business Name",
              validator: (value) {
                if (value == null || value.isEmpty) {return 'Please enter legal business name';}
                return null;
              },
              hintStyle: ConstantTextStyle.otpHintTextStyle,
              // labelStyle: ConstantTextStyle.otpHintTextStyle,
              onChanged: (value) {},
            ),

            GlobalTextFormField(enabled: true,
              margin: EdgeInsets.symmetric(vertical: screenHeight/80.0),
              controller: _buildingNumberStreetController,
              keyboardType: TextInputType.text,
              hintText: "",
              labelText: "Building Number,Street",
              validator: (value) {
                if (value == null || value.isEmpty) {return 'Please enter building number,street';}
                return null;
              },
              hintStyle: ConstantTextStyle.otpHintTextStyle,
              // labelStyle: ConstantTextStyle.otpHintTextStyle,
              onChanged: (value) {},
            ),

            GlobalTextFormField(enabled: true,
              margin: EdgeInsets.symmetric(vertical: screenHeight/80.0),
              controller: _locationAddressController,
              keyboardType: TextInputType.text,
              hintText: "",
              labelText: "Location address",
              hintStyle: ConstantTextStyle.otpHintTextStyle,
              validator: (value) {
                if (value == null || value.isEmpty) {return 'Please enter location address';}
                return null;
              },
              // labelStyle: ConstantTextStyle.otpHintTextStyle,
              onChanged: (value) {},
              suffixIcon:  Container(
                decoration: BoxDecoration(border: Border.all(color: ConstantColor.secondtryGrayColor)),
                child: customButton(
                  textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                  onPressed:()
                    async {
                      Map<String, String> locationData = await getCurrentLocation();
                      setState(() {
                        _locationAddressController.text = locationData['fullAddress']??"";
                        _cityController.text = locationData['city']??"";
                        _latitudeController.text = locationData['latitude']??"";
                        _longitudeController.text = locationData['longitude']??"";
                        _pincodeController.text = locationData['pincode']??"";
                        _stateController.text = locationData['state']??"";
                        _countryController.text = locationData['country']??"";
                      });
                  },
                  text: 'Get Location',
                  backgroundColor: ConstantColor.primaryMainColor,
                  borderRadius: BorderRadius.zero,
                  elevation: 0.0,
                ),
              ),
            ),

            GlobalTextFormField(enabled: true,
              margin: EdgeInsets.symmetric(vertical: screenHeight/80.0),
              controller: _landMarkController,
              keyboardType: TextInputType.text,
              hintText: "",
              labelText: "Landmark",
              hintStyle: ConstantTextStyle.otpHintTextStyle,
              validator: (value) {
                if (value == null || value.isEmpty) {return 'Please enter landmark';}
                return null;
              },
              // labelStyle: ConstantTextStyle.otpHintTextStyle,
              onChanged: (value) {},
            ),

            Row(
              children: [
                Flexible(
                  child: GlobalTextFormField(
                    filled: true,
                    fillColor: ConstantColor.imageBoxBoarderColor,
                    enabled: false,
                    margin: EdgeInsets.symmetric(vertical: screenHeight/80.0),
                    controller: _cityController,
                    keyboardType: TextInputType.text,
                    hintText: "",
                    labelText: "City",
                    hintStyle: ConstantTextStyle.otpHintTextStyle,
                    validator: (value) {
                      if (value == null || value.isEmpty) {return 'Please enter city';}
                      return null;
                    },
                    // labelStyle: ConstantTextStyle.otpHintTextStyle,
                    onChanged: (value) {},
                  ),
                ),
                constantWidth(context, 40.0),
                Flexible(
                  child: GlobalTextFormField(enabled: true,
                    margin: EdgeInsets.symmetric(vertical: screenHeight/80.0),
                    controller: _pincodeController,
                    keyboardType: TextInputType.text,
                    hintText: "",
                    labelText: "Pincode",
                    hintStyle: ConstantTextStyle.otpHintTextStyle,
                    validator: (value) {
                      if (value == null || value.isEmpty) {return 'Please enter pincode';}
                      return null;
                    },
                    // labelStyle: ConstantTextStyle.otpHintTextStyle,
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Flexible(
                  child: GlobalTextFormField(
                    filled: true,
                    fillColor: ConstantColor.imageBoxBoarderColor,
                    enabled: false,
                    margin: EdgeInsets.symmetric(vertical: screenHeight/80.0),
                    controller: _stateController,
                    keyboardType: TextInputType.text,
                    hintText: "",
                    labelText: "State",
                    hintStyle: ConstantTextStyle.otpHintTextStyle,
                    validator: (value) {
                      if (value == null || value.isEmpty) {return 'Please enter state';}
                      return null;
                    },
                    // labelStyle: ConstantTextStyle.otpHintTextStyle,
                    onChanged: (value) {},
                  ),
                ),
                constantWidth(context, 40.0),
                Flexible(
                  child: GlobalTextFormField(
                    filled: true,
                    fillColor: ConstantColor.imageBoxBoarderColor,
                    enabled: false,
                    margin: EdgeInsets.symmetric(vertical: screenHeight/80.0),
                    controller: _countryController,
                    keyboardType: TextInputType.text,
                    hintText: "",
                    labelText: "Country",
                    hintStyle: ConstantTextStyle.otpHintTextStyle,
                    validator: (value) {
                      if (value == null || value.isEmpty) {return 'Please enter country';}
                      return null;
                    },
                    // labelStyle: ConstantTextStyle.otpHintTextStyle,
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),

            constantHeight(context, 80.0),
            Align(
              alignment: Alignment.centerRight,
              child: customButton(
                  text: 'NEXT',
                  elevation: 1.0,
                  borderRadius: BorderRadius.circular(20.0),
                  backgroundColor: ConstantColor.primaryMainColor,
                  textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                onPressed: isLoading ? null : _handleSubmit,
              ),
            ),

          ],
        ),
      ),
    );
  }
}


