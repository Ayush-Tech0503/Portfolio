
import 'package:flutter/material.dart';

import '../../../Api Services/Card Api Services/My Addess Services/my_address_submit_api_services.dart';
import '../../../Util/Constant APi Url/api_urls.dart';
import '../../../Util/constaint_textstyle.dart';
import '../../../Util/constant_color.dart';
import '../../../Widgets/custome_button_.dart';
import '../../../Widgets/custome_text.dart';
import '../../../Widgets/login_textformfiled.dart';

class AddNewAddressScreen extends StatefulWidget {
  final String? address;
  final String? addressIds;
  final String? landmark;
  final String? homeNo;
  final String? city;
  final String? pincode;
  final String? stateName;
  final String? countryName;
  final String? addressType;
  final bool? isChecked;
  final Function? onSuccess;
  const AddNewAddressScreen({super.key,
    this.address,
    this.addressIds,
    this.landmark,
    this.homeNo,
    this.city,
    this.pincode,
    this.stateName,
    this.countryName,
    this.addressType,
    this.isChecked,
    this.onSuccess
  });

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();
  final FocusNode _focusNode6 = FocusNode();
  final FocusNode _focusNode7 = FocusNode();

  bool _isFocused = false;
  bool _isFocused1 = false;
  bool _isFocused2 = false;
  bool _isFocused3 = false;
  bool _isFocused4 = false;
  bool _isFocused5 = false;
  bool _isFocused6 = false;
  bool _isFocused7 = false;

  final _formKey = GlobalKey<FormState>();

  String address = '';
  String landmark = '';
  String homeNo = '';
  String city = '';
  String pincode = '';
  String stateName = '';
  String countryName = '';
  String addressType = '';


  @override
  void initState() {
    super.initState();
    addressController = TextEditingController(text: widget.address);
    landmarkController = TextEditingController(text: widget.landmark);
    homeNoController = TextEditingController(text: widget.homeNo);
    cityController = TextEditingController(text: widget.city);
    pincodeController = TextEditingController(text: widget.pincode);
    stateController = TextEditingController(text: widget.stateName);
    countryController = TextEditingController(text: widget.countryName);
    addressTypeController = TextEditingController(text: widget.addressType);
    _isChecked = widget.isChecked ?? false;
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
    _focusNode1.addListener(() {
      setState(() {
        _isFocused1 = _focusNode1.hasFocus;
      });
    });

    _focusNode2.addListener(() {
      setState(() {
        _isFocused2 = _focusNode2.hasFocus;
      });
    });

    _focusNode3.addListener(() {
      setState(() {
        _isFocused3 = _focusNode3.hasFocus;
      });
    });

    _focusNode4.addListener(() {
      setState(() {
        _isFocused4 = _focusNode4.hasFocus;
      });
    });

    _focusNode5.addListener(() {
      setState(() {
        _isFocused5 = _focusNode5.hasFocus;
      });
    });

    _focusNode6.addListener(() {
      setState(() {
        _isFocused6 = _focusNode6.hasFocus;
      });
    });

    _focusNode7.addListener(() {
      setState(() {
        _isFocused7 = _focusNode7.hasFocus;
      });
    });
  }

  late TextEditingController addressController;
  late TextEditingController landmarkController;
  late TextEditingController homeNoController;
  late TextEditingController cityController;
  late TextEditingController pincodeController;
  late TextEditingController stateController;
  late TextEditingController countryController;
  late TextEditingController addressTypeController;


  bool isLoading = false;
  bool _isChecked = false;

  //-------handle submit funtion-------

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      fetchSubmitFormApiService(
        context: context,
        baseUrl: '${ConstantUrls.baseUriApi}${ConstantUrls.addMyAddressEndPoint}',
        body: {
          "address": addressController.text,
          "address_type": addressTypeController.text,
          "city": cityController.text,
          "country": countryController.text,
          "deflate": _isChecked == true ? "1" : "0",
          "house_number": homeNoController.text,
          "landmark": landmarkController.text,
          "pincode": pincodeController.text,
          "state": stateController.text,
          "user_id": "",
        },
        onSuccess: () {
          Navigator.pop(context);
          if (widget.onSuccess != null) {
            widget.onSuccess!(); // Call the callback
          }
        },
      );
    }
  }
  //-------handle submit update funtion-------
  void _handleUpdateSubmit() {
    if (_formKey.currentState!.validate()) {
      fetchSubmitFormApiService(
        context: context,
        baseUrl: '${ConstantUrls.baseUriApi}${ConstantUrls.updateAddressEndPoint}',
        body: {
          "address": addressController.text,
          "address_type": addressTypeController.text,
          "address_id": widget.addressIds.toString(),
          "city": cityController.text,
          "country": countryController.text,
          "deflate": _isChecked == true ? "1" : "0",
          "house_number": homeNoController.text,
          "landmark": landmarkController.text,
          "pincode": pincodeController.text,
          "state": stateController.text
        },
        onSuccess: () {
          Navigator.pop(context);
          if (widget.onSuccess != null) {
            widget.onSuccess!(); // Call the callback
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      insetPadding: EdgeInsets.symmetric(vertical: screenHeight/16.0,horizontal: screenWidth/20.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child:ListView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth /40.0, vertical: screenHeight /60.0),
        children: [
          customeText(text: "Add Address",
            textAlign: TextAlign.start,
            style: ConstantTextStyle.topCategoryText4, // Use your constant text style here
          ),
          SizedBox(height: screenHeight / 40),
          Container(
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Colors.white, // Use your constant color here
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: ConstantColor.primaryGreyColor), // Use your constant color here
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Address Field
                  loginTextFormField2(
                    controller: addressController,
                    textFormPaddingHorizontal: screenWidth /40,
                    textFormPaddingVertical: screenHeight / 50,
                    minLines: 1,
                    maxLines: 1,
                    borderSideColor: _isFocused
                        ? ConstantColor.primaryMainColor
                        : ConstantColor.transparent1,
                    focusNode: _focusNode,
                    context: context,
                    fillColor: ConstantColor.primaryBackgroundMainColor,
                    filled: true,
                    iconButton: IconButton,
                    labelText: "Address *",
                    labelStyle: ConstantTextStyle.lableTextStyle2,
                    cursorColor: ConstantColor.primaryMainColor,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter address';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        address = value;
                      });
                    },
                  ),

                  SizedBox(height: screenHeight / 80),
                  // Email Field
                  loginTextFormField2(
                    controller: landmarkController,
                    textFormPaddingHorizontal: screenWidth / 40,
                    textFormPaddingVertical: screenHeight / 50,
                    minLines: 1,
                    maxLines: 1,
                    borderSideColor: _isFocused1
                        ? ConstantColor.primaryMainColor
                        : ConstantColor.transparent1,
                    focusNode: _focusNode1,
                    context: context,
                    fillColor: ConstantColor.primaryBackgroundMainColor,
                    filled: true,
                    iconButton: IconButton,
                    // hintText: "Email",
                    // hintStyle: ConstantTextStyle.sellerHintTextStyle,
                    labelText: "Landmark *",
                    labelStyle: ConstantTextStyle.lableTextStyle2,
                    cursorColor: ConstantColor.primaryMainColor,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter landmark';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        landmark = value;
                      });
                    },
                  ),
                  SizedBox(height: screenHeight / 80),
                  // home Number Field

                  loginTextFormField2(
                    controller: homeNoController,
                    textFormPaddingHorizontal: screenWidth / 40,
                    textFormPaddingVertical: screenHeight / 50,
                    minLines: 1,
                    maxLines: 1,
                    borderSideColor: _isFocused2
                        ? ConstantColor.primaryMainColor
                        : ConstantColor.transparent1,
                    focusNode: _focusNode2,
                    context: context,
                    fillColor: ConstantColor.primaryBackgroundMainColor,
                    filled: true,
                    iconButton: IconButton,
                    // hintText: "Email",
                    // hintStyle: ConstantTextStyle.sellerHintTextStyle,
                    labelText: "House Number *",
                    labelStyle: ConstantTextStyle.lableTextStyle2,
                    cursorColor: ConstantColor.primaryMainColor,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter home number';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        homeNo = value;
                      });
                    },
                  ),

                  SizedBox(height: screenHeight / 80),
                  // city Name Field

                  loginTextFormField2(
                    controller: cityController,
                    textFormPaddingHorizontal: screenWidth / 40,
                    textFormPaddingVertical: screenHeight / 50,
                    minLines: 1,
                    maxLines: 1,
                    borderSideColor: _isFocused3
                        ? ConstantColor.primaryMainColor
                        : ConstantColor.transparent1,
                    focusNode: _focusNode3,
                    context: context,
                    fillColor: ConstantColor.primaryBackgroundMainColor,
                    filled: true,
                    iconButton: IconButton,
                    // hintText: "Email",
                    // hintStyle: ConstantTextStyle.sellerHintTextStyle,
                    labelText: "City *",
                    labelStyle: ConstantTextStyle.lableTextStyle2,
                    cursorColor: ConstantColor.primaryMainColor,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter city';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        city = value;
                      });
                    },
                  ),

                  SizedBox(height: screenHeight / 80),
                  // pincodeController  Field

                  loginTextFormField2(
                    controller: pincodeController,
                    textFormPaddingHorizontal: screenWidth / 40,
                    textFormPaddingVertical: screenHeight / 50,
                    minLines: 1,
                    maxLines: 1,
                    borderSideColor: _isFocused4
                        ? ConstantColor.primaryMainColor
                        : ConstantColor.transparent1,
                    focusNode: _focusNode4,
                    context: context,
                    fillColor: ConstantColor.primaryBackgroundMainColor,
                    filled: true,
                    iconButton: IconButton,
                    labelText: "Pincode *",
                    labelStyle: ConstantTextStyle.lableTextStyle2,
                    cursorColor: ConstantColor.primaryMainColor,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter pincode';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        pincode = value;
                      });
                    },
                  ),

                  SizedBox(height: screenHeight / 80),
                  // state  Field

                  loginTextFormField2(
                    controller: stateController,
                    textFormPaddingHorizontal: screenWidth / 40,
                    textFormPaddingVertical: screenHeight / 50,
                    minLines: 1,
                    maxLines: 1,
                    borderSideColor: _isFocused5
                        ? ConstantColor.primaryMainColor
                        : ConstantColor.transparent1,
                    focusNode: _focusNode5,
                    context: context,
                    fillColor: ConstantColor.primaryBackgroundMainColor,
                    filled: true,
                    iconButton: IconButton,
                    labelText: "State *",
                    labelStyle: ConstantTextStyle.lableTextStyle2,
                    cursorColor: ConstantColor.primaryMainColor,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter state';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        stateName = value;
                      });
                    },
                  ),

                  SizedBox(height: screenHeight / 80),
                  // country  Field

                  loginTextFormField2(
                    controller: countryController,
                    textFormPaddingHorizontal: screenWidth / 40,
                    textFormPaddingVertical: screenHeight / 50,
                    minLines: 1,
                    maxLines: 1,
                    borderSideColor: _isFocused6
                        ? ConstantColor.primaryMainColor
                        : ConstantColor.transparent1,
                    focusNode: _focusNode6,
                    context: context,
                    fillColor: ConstantColor.primaryBackgroundMainColor,
                    filled: true,
                    iconButton: IconButton,
                    labelText: "Country *",
                    labelStyle: ConstantTextStyle.lableTextStyle2,
                    cursorColor: ConstantColor.primaryMainColor,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter country';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        countryName = value;
                      });
                    },
                  ),

                  SizedBox(height: screenHeight / 80),
                  // address type  Field

                  loginTextFormField2(
                    controller: addressTypeController,
                    textFormPaddingHorizontal: screenWidth / 40,
                    textFormPaddingVertical: screenHeight / 50,
                    minLines: 1,
                    maxLines: 1,
                    borderSideColor: _isFocused7
                        ? ConstantColor.primaryMainColor
                        : ConstantColor.transparent1,
                    focusNode: _focusNode7,
                    context: context,
                    fillColor: ConstantColor.primaryBackgroundMainColor,
                    filled: true,
                    iconButton: IconButton,
                    labelText: "Address Type *",
                    labelStyle: ConstantTextStyle.lableTextStyle2,
                    cursorColor: ConstantColor.primaryMainColor,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter address type';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        addressType = value;
                      });
                    },
                  ),

                  SizedBox(height: screenHeight / 80),

                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
                    activeColor: ConstantColor.primaryMainColor,
                    checkColor: ConstantColor.primaryBackgroundMainColor,
                    title: customeText(
                      textAlign: TextAlign.start,
                      text: 'Set default address',
                      style: ConstantTextStyle.homeScreenHeadingText3,
                    ),
                    value: _isChecked,
                    onChanged: (bool? newValue) {setState(() {_isChecked = newValue ?? false;});},
                    controlAffinity: ListTileControlAffinity.leading,
                  ),


                  Align(
                    alignment: Alignment.centerRight,
                    child: customeButton(
                      textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                      onPressed: () {
                        // Check if widget.addressIds is null
                        if (widget.addressIds == null) {_handleSubmit();}
                        // Check if widget.addressIds is an empty string
                        else if (widget.addressIds.toString().trim().isEmpty) {_handleSubmit();}
                        // Otherwise handle the update submit
                        else {_handleUpdateSubmit();}
                      },
                      text: "Submit",
                      backgroundColor: ConstantColor.primaryMainColor,
                      borderRadius: BorderRadius.circular(10.0),
                      elevation: 0.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
