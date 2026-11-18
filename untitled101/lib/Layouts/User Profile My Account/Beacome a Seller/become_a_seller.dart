// ignore_for_file: deprecated_member_use, use_build_context_synchronously, prefer_typing_uninitialized_variables, non_constant_identifier_names, empty_catches, library_private_types_in_public_api, must_be_immutable, unnecessary_to_list_in_spreads

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../../Models/Pre Registration/registration_preview.dart';
import '../../../../Util/Constant APi Url/api_urls.dart';
import '../../../../Util/constaint_textstyle.dart';
import '../../../../Util/constant_color.dart';
import '../../../../Widgets/custome_button_.dart';
import '../../../../Widgets/custome_text.dart';
import '../../../../Widgets/login_textformfiled.dart';
import '../../../Models/Pre Registration/fourth_cat_checkboxlist.dart';
import '../../../Widgets/Image Pic widget/image_pic.dart';
import '../../Onboarding Screens/login_screen.dart';
import 'Beacome A Seeller Success Screen/seller_form_submitted_screen.dart';
import 'Get Location Funtion/get_location_fun.dart';

class BecomeASellerform extends StatefulWidget {
  String id;
  String longitude;
  String latitude;
  String lName;
  BecomeASellerform(
      {super.key,
      required this.id,
      required this.longitude,
      required this.latitude,
      required this.lName
      });
  @override
  _BecomeASellerformState createState() => _BecomeASellerformState();
}

class _BecomeASellerformState extends State<BecomeASellerform> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;
//---------------------------------------------
  String location = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
//---------------------------------------------
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();
  final FocusNode _focusNode6 = FocusNode();
  final FocusNode _focusNode7 = FocusNode();
  final FocusNode _focusNode8 = FocusNode();
  final FocusNode _focusNode9 = FocusNode();
  final FocusNode _focusNode10 = FocusNode();
  final FocusNode _focusNode11 = FocusNode();
  final FocusNode _focusNode12 = FocusNode();
  final FocusNode _focusNode13 = FocusNode();
  final FocusNode _focusNode14 = FocusNode();
  final FocusNode _focusNode15 = FocusNode();
  final FocusNode _focusNode16 = FocusNode();
  final FocusNode _focusNode17 = FocusNode();
  final FocusNode _focusNode18 = FocusNode();
  final FocusNode _focusNode19 = FocusNode();
  final FocusNode _focusNode20 = FocusNode();
  final FocusNode _focusNode24 = FocusNode();
  final FocusNode _focusNode25 = FocusNode();
  final FocusNode _focusNode26 = FocusNode();
  final FocusNode _focusNode27 = FocusNode();
  final FocusNode _focusNode28 = FocusNode();
  final FocusNode _focusNode29 = FocusNode();

  bool _isFocused = false;
  bool _isFocused1 = false;
  bool _isFocused2 = false;
  bool _isFocused3 = false;
  bool _isFocused4 = false;
  bool _isFocused5 = false;
  bool _isFocused7 = false;
  bool _isFocused8 = false;
  bool _isFocused9 = false;
  bool _isFocused10 = false;
  bool _isFocused11 = false;
  bool _isFocused12 = false;
  bool _isFocused13 = false;
  bool _isFocused14 = false;
  bool _isFocused17 = false;
  bool _isFocused18 = false;
  bool _isFocused19 = false;
  bool _isFocused20 = false;
  bool _isFocused24 = false;
  bool _isFocused25 = false;
  bool _isFocused26 = false;
  bool _isFocused27 = false;
  bool _isFocused28 = false;
  bool _isFocused29 = false;

  final _formKey = GlobalKey<FormState>();
//----------------------------payment mode data start---------------
  String name = '';
  String storeName = '';
  String legalBusinessName = '';
  String storeDetails = '';
  String storeAddress = '';
  String getLocation = '';
  String referalCode = '';
  String latitude = '';
  String longitude = '';
  String country = '';
  String state = '';
  String city = '';
  String email = '';
  String contactNo = '';
  String contactNoOptional = '';
  String landMark = '';
  String pinCode = '';
  String? _shopRegisterNumber;
  String? _sellOrRent;
  String? _deliveryMode;
  String registrationNoType = '';
  String registrationNoOther = '';
  String registrationNo2 = '';
  String registrationDocs = '';
  String storeLogo = '';
  String storeBanner = '';
  String dealsIN = '';
  String metaTitle = '';
  String metaKeyWord = '';
  String metaDesc = '';
  String designation = '';
  String yoe = '';

  get valuefirst => null;

  TextEditingController nameController = TextEditingController();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController legalBusinessNameController = TextEditingController();
  TextEditingController storeSlugController = TextEditingController();
  TextEditingController storeDetailController = TextEditingController();
  TextEditingController storeAddressController = TextEditingController();
  TextEditingController storeLocAddressController = TextEditingController();
  TextEditingController referralCodeController = TextEditingController();
  TextEditingController storeLatitudeCodeController = TextEditingController();
  TextEditingController storeLongitudeCodeController = TextEditingController();
  TextEditingController countryIdCodeController = TextEditingController();
  TextEditingController stateIdCodeController = TextEditingController();
  TextEditingController cityIdCodeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController contactNoOptController = TextEditingController();
  TextEditingController scRegistrationTypeController = TextEditingController();
  TextEditingController scRegistrationOtherController = TextEditingController();
  TextEditingController gstNoController = TextEditingController();
  TextEditingController scRegistrationFileController = TextEditingController();
  TextEditingController storeLogoNameController = TextEditingController();
  TextEditingController storeBannerNameController = TextEditingController();
  TextEditingController dealsInController = TextEditingController();
  TextEditingController metaTitleController = TextEditingController();
  TextEditingController metaKeywordController = TextEditingController();
  TextEditingController metaDescriptionController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController yoeController = TextEditingController();
  TextEditingController buyOrRentController = TextEditingController();
  TextEditingController deliveryModeController = TextEditingController();
  //----------------------------------payment mode controller ---------
  TextEditingController paymentModesAcceptedController =
      TextEditingController();
  TextEditingController openHrsController = TextEditingController();


  @override

  void initState() {
    super.initState();
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
      });
    });
    _focusNode7.addListener(() {
      setState(() {
        _isFocused7 = _focusNode7.hasFocus;
      });
    });
    _focusNode8.addListener(() {
      setState(() {
        _isFocused8 = _focusNode8.hasFocus;
      });
    });
    _focusNode9.addListener(() {
      setState(() {
        _isFocused9 = _focusNode9.hasFocus;
      });
    });
    _focusNode10.addListener(() {
      setState(() {
        _isFocused10 = _focusNode10.hasFocus;
      });
    });
    _focusNode11.addListener(() {
      setState(() {
        _isFocused11 = _focusNode11.hasFocus;
      });
    });
    _focusNode12.addListener(() {
      setState(() {
        _isFocused12 = _focusNode12.hasFocus;
      });
    });
    _focusNode13.addListener(() {
      setState(() {
        _isFocused13 = _focusNode13.hasFocus;
      });
    });
    _focusNode14.addListener(() {
      setState(() {
        _isFocused14 = _focusNode14.hasFocus;
      });
    });
    _focusNode15.addListener(() {
      setState(() {
      });
    });
    _focusNode16.addListener(() {
      setState(() {
      });
    });
    _focusNode17.addListener(() {
      setState(() {
        _isFocused17 = _focusNode17.hasFocus;
      });
    });
    _focusNode18.addListener(() {
      setState(() {
        _isFocused18 = _focusNode18.hasFocus;
      });
    });
    _focusNode19.addListener(() {
      setState(() {
        _isFocused19 = _focusNode19.hasFocus;
      });
    });
    _focusNode20.addListener(() {
      setState(() {
        _isFocused20 = _focusNode20.hasFocus;
      });
    });
    _focusNode24.addListener(() {
      setState(() {
        _isFocused24 = _focusNode24.hasFocus;
      });
    });
    _focusNode25.addListener(() {
      setState(() {
        _isFocused25 = _focusNode25.hasFocus;
      });
    });
    _focusNode26.addListener(() {
      setState(() {
        _isFocused26 = _focusNode26.hasFocus;
      });
    });
    _focusNode27.addListener(() {
      setState(() {
        _isFocused27 = _focusNode27.hasFocus;
      });
    });
    _focusNode28.addListener(() {
      setState(() {
        _isFocused28 = _focusNode28.hasFocus;
      });
    });
    _focusNode29.addListener(() {
      setState(() {
        _isFocused29 = _focusNode29.hasFocus;
      });
    });
    fetchPreview();
  }

  var userId;
  var tokenAccess;
  var is_seller;
//-----------------------Api Data Start------------------
  bool isLoading = false;
  PreRegistration? preRegistration;
  List<UserInfo> userInfo = [];
 List<Seller> SellerInfo = [];
  List<ChildCat> childCat = [];
  List<SellerOpenHrs> sellerOpenHrs = [];
//--------------this preview api Start--------------------
  fetchPreview() async {
    try {
      setState(() {
        isLoading = true;
      });
      SharedPreferences preference = await SharedPreferences.getInstance();
      tokenAccess = preference.getString("access-token");
      is_seller = preference.getInt("is_seller");
      userId = preference.getString("userId");
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.registrationPreviewApi}",
        options: Options(
          headers: {
            "Authorization": tokenAccess,
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        var responseData = json.decode(response.data.toString());
        isLoading = false;
        preRegistration = PreRegistration.fromJson(responseData);
        if (is_seller == 1){
          if (preRegistration != null && preRegistration!.data != null) {
            childCat.addAll(preRegistration!.data!.childCat ?? []);
            nameController.text = preRegistration!.data!.userInfo!.firstName.toString();
            emailController.text = preRegistration!.data!.userInfo!.email.toString();
            contactNoController.text = preRegistration!.data!.userInfo!.mobile.toString();
            storeNameController.text = preRegistration!.data!.seller!.storeName.toString();
            legalBusinessNameController.text = preRegistration!.data!.seller!.legalBusinessName.toString();
            storeSlugController.text = preRegistration!.data!.seller!.storeSlug.toString();
            storeDetailController.text = preRegistration!.data!.seller!.storeDescription.toString();
            storeAddressController.text = preRegistration!.data!.seller!.storeAddress.toString();
            storeLocAddressController.text = preRegistration!.data!.seller!.storeLocAddress.toString();
            referralCodeController.text = preRegistration!.data!.seller!.referralCode.toString();
            storeLatitudeCodeController.text = preRegistration!.data!.seller!.storeLatitude.toString();
            storeLongitudeCodeController.text = preRegistration!.data!.seller!.storeLongitude.toString();
            countryIdCodeController.text = preRegistration!.data!.seller!.countryId.toString();
            stateIdCodeController.text = preRegistration!.data!.seller!.stateId.toString();
            cityIdCodeController.text = preRegistration!.data!.seller!.cityId.toString();
            contactNoOptController.text = preRegistration!.data!.seller!.contactNoOpt.toString();
            gstNoController.text = preRegistration!.data!.seller!.gstNo.toString();
            scRegistrationFileController.text = preRegistration!.data!.seller!.scRegistrationFile.toString();
            storeLogoNameController.text = preRegistration!.data!.seller!.storeLogoName.toString();
            storeBannerNameController.text = preRegistration!.data!.seller!.storeBannerName.toString();
            dealsInController.text = preRegistration!.data!.seller!.dealsIn.toString();
            metaTitleController.text = preRegistration!.data!.seller!.metaTitle.toString();
            metaKeywordController.text = preRegistration!.data!.seller!.metaKeyword.toString();
            metaDescriptionController.text = preRegistration!.data!.seller!.metaDescription.toString();
            landmarkController.text = preRegistration!.data!.seller!.landmark.toString();
            pincodeController.text = preRegistration!.data!.seller!.pincode.toString();
            designationController.text = preRegistration!.data!.seller!.designation.toString();
            yoeController.text = preRegistration!.data!.seller!.yearOfEstablishment.toString();
            scRegistrationTypeController.text = preRegistration!.data!.seller!.scRegistrationType.toString();
            scRegistrationOtherController.text = preRegistration!.data!.seller!.otherScRegType.toString();
            buyOrRentController.text = preRegistration!.data!.seller!.buyOrRent.toString();
            deliveryModeController.text = preRegistration!.data!.seller!.deliveryMode.toString();
            String? paymentModesString = preRegistration?.data?.seller?.paymentModesAccepted;
            if (paymentModesString != null) {
              selectedPaymentModes = paymentModesString ?? '';
            }
            sellerOpenHrs.addAll(
              (preRegistration!.data!.sellerOpenHrs as List<dynamic>)
                  .map((item) => SellerOpenHrs.fromJson(item)).toList(),);
          }
        }
        else {
              childCat.addAll(preRegistration!.data!.childCat ?? []);
              nameController.text = preRegistration!.data!.userInfo!.firstName.toString();
            emailController.text = preRegistration!.data!.userInfo!.email.toString();
            contactNoController.text = preRegistration!.data!.userInfo!.mobile.toString();
              sellerOpenHrs.addAll(
                (preRegistration!.data!.sellerOpenHrs as List<dynamic>)
                    .map((item) => SellerOpenHrs.fromJson(item)).toList(),);


          }
        setState(() {
          var shopTimeInfoApi = getShopTimeInfo(shopTimeInfo, preRegistration!.data!.sellerOpenHrs);
          List<Map<String, dynamic>> shopTimeInfoTmp = [];
          shopTimeInfoApi.forEach((timeObj) {
            var day = timeObj["day"];
            var isOpen = timeObj["on_off"];
            var openTime = timeObj["opens_at"];
            var closeTime = timeObj["closes_at"];
            var dayObj = shopTimeInfo.where((timeInfo) {
              return timeInfo["day"] == day;}).toList();
            if (dayObj.isNotEmpty) {
              dayObj[0]["on_off"] = isOpen;
              dayObj[0]["opens_at"] = openTime;
              dayObj[0]["closes_at"] = closeTime;
              shopTimeInfoTmp.add(dayObj[0]);
            }
          });
          shopTimeInfo = shopTimeInfoTmp;
        });
      }
      else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      isLoading = false;
    }
    }
//--------------this preview api End--------------------
  List selectedOptions = [];
//--------------this registration_stap_fust api Start---------
  fetchRegistrationFirst(
      {newStore,
      addressLoc,
      landmark,
      pinCode,
      latitudeFist,
      longitudeFist,
      countryFist,
      stateFist,
      cityFist,
      buildingAddress,
      legalBusName}) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Row(
              children: [
                const CircularProgressIndicator(
                  color: ConstantColor.primaryMainColor,
                ),
                const SizedBox(width: 20),
                Text(
                  'Loading...',
                  style: ConstantTextStyle.allHomeScreenAvatarText,
                ),
              ],
            ),
          );
        },
      );
      //  isLoading = true;
      SharedPreferences preference = await SharedPreferences.getInstance();
      tokenAccess = preference.getString("access-token");

      userId = preference.getString("userId");
      final body = {
        "business_name": newStore ?? '',
        "legal_business_name": legalBusName ?? "",
        "building": buildingAddress ?? '',
        "saddress_loc": addressLoc ?? '',
        "landmark": landmark ?? '',
        "latitude": latitudeFist ?? '',
        "longitude": longitudeFist ?? "",
        "country": countryFist ?? '',
        "state": stateFist ?? '',
        "city": cityFist ?? '',
        "pincode": pinCode ?? '',
      };
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.registrationFirstApi}",
        options: Options(
          headers: {
            "Authorization": tokenAccess,
            'Content-Type': 'application/json',
          },
        ),
        data: json.encode(body),
      );
      Navigator.pop(context);
      if (response.statusCode == 200) {
        setState(() {
          _currentStep = 1;
        });
      } else {
        setState(() {
          _currentStep = 0;
        });
      }
    } catch (error) {
    }
  }

//--------------this registration_stap_fust api End---------
//--------------this registration_stap_Second api Start---------
  fetchRegistrationSecond({
    contactPersonName,
    designationPerson,
    referralCode,
    whatsappNumber,
    emailId,
    mobileNo,
    scRegno,
    scOtherType,
    gstNo,
    buyOrRent,
    deliveryMode,
    storeDescription,
  }) async {
    // Add a regular expression pattern for allowed characters (alphabetical and spaces)
    final namePattern = RegExp(r'[^a-zA-Z\s]');
    // Check if the "Contact Person Name" matches the pattern
    if (namePattern.hasMatch(contactPersonName)) {
      const errorMessage =
          "Contact Person Name should only contain alphabetical and characters";
      setState(() {
        _currentStep = 1;
      });
      showShrinkingToast(context, errorMessage);
      return;
    }
    if (namePattern.hasMatch(designationPerson)) {
      const errorMessage = "Person Designation should only contain characters ";
      setState(() {
        _currentStep = 1;
      });
      showShrinkingToast(context, errorMessage);
      return;
    }
    final requiredFields = {
      "Contact Person Name": contactPersonName ?? '',
      "Designation Person": designationPerson ?? '',
      // "Referral Code": referralCode,
      "WhatsApp Number": whatsappNumber ?? '',
      "Email ID": emailId ?? '',
      "Mobile No": mobileNo ?? '',
      "Shop Reg No": scRegno ?? '',
      // "Shop Other Type": scOtherType ?? '',
      "GST No": gstNo ?? '',
     // "Reg Document Value": "reg_document_value" ?? '',
      "Buy or Rent": buyOrRent ?? '',
      "Delivery Mode": deliveryMode ?? '',
      "Store Description": storeDescription ?? '',
    };
    // Check each field for null or empty values
    final emptyFields = requiredFields.entries.where((entry) {
      final value = entry.value;
      return value == null || value.isEmpty;
    });
    if (emptyFields.isNotEmpty) {
      final emptyFieldNames = emptyFields.map((entry) => entry.key).join(", ");
      final errorMessage = "$emptyFieldNames : field is required";
      setState(() {
        _currentStep = 1;
      });
      showShrinkingToast(context, errorMessage);
      return;
    }
    FormData formData = FormData.fromMap({
      "contact_person": contactPersonName ?? '',
      "designation": designationPerson ?? '',
      "referral_code": referralCode ?? '',
      "whatsapp_number": whatsappNumber ?? '',
      "email_id": emailId ?? '',
      "mobile": mobileNo ?? '',
      "sc_regno": scRegno ?? '',
      "sc_other_type": scOtherType ?? '',
      "gst_no": gstNo ?? '',
      "buy_or_rent": buyOrRent ?? '',
      "delivery_mode": deliveryMode ?? '',
      "store_description": storeDescription ?? '',
    });
    if (_fileData != null && _fileData?['_myFilePath'] != null) {
      formData.files.add(MapEntry("reg_document_value", await MultipartFile.fromFile(_fileData?['_myFilePath'].path),));
    }else{
      const errorMessage = "Please select a file.";
      setState(() {
        _currentStep = 1;
      });
      showShrinkingToast(context, errorMessage);
      return;
    }
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Row(
              children: [
                const CircularProgressIndicator(
                  color: ConstantColor.primaryMainColor,
                ),
                const SizedBox(width: 20),
                Text(
                  'Loading...',
                  style: ConstantTextStyle.allHomeScreenAvatarText,
                ),
              ],
            ),
          );
        },
      );
      SharedPreferences preference = await SharedPreferences.getInstance();
      tokenAccess = preference.getString("access-token");
      userId = preference.getString("userId");
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.registrationSecondtApi}",
        options: Options(
          headers: {
            "Authorization": tokenAccess,
          },
        ),
        data: formData,
      );
      Navigator.pop(context);

      if (response.statusCode == 200) {
        setState(() {
           _currentStep = 2;
        });
      } else {
        setState(() {
          _currentStep = 1;
        });
      }
    } catch (e) {
      Navigator.pop(context);
    }
  }
//--------------this registration_stap_Second api End---------
//--------------this registration_stap_Third api Start---------

  fetchRegistrationThirdData({yearOfEstable, paymentModeAcc}) async {
    try {
      String jsonShopTimeString = jsonEncode(shopTimeInfo.map((info) {
        return {
          'day': info['day'],
          'open_time': info['open_time'],
          'close_time': info['close_time'],
          'isOpen': info['isOpen'],
        };
      }).toList());
      SharedPreferences preference = await SharedPreferences.getInstance();
      tokenAccess = preference.getString("access-token");
      userId = preference.getString("userId");
      FormData formData = FormData.fromMap({
        "year_of_establishment": yearOfEstable,
        "payment_modes_accepted": paymentModeAcc,
        'shopTimeInfo': jsonShopTimeString,
      });

      if (_logofileData != null && _logofileData!['_myLogoFilePath'] != null) {
        formData.files.add(MapEntry("store_logo", await MultipartFile.fromFile(_logofileData!['_myLogoFilePath'].path)));
      } else {
        const errorMessage = "Please select a logo.";
        setState(() {
          _currentStep = 2;
        });
        showShrinkingToast(context, errorMessage);
        return;
      }
      if (_bannerFileData != null && _bannerFileData!['_mybannerFilePath'] != null) {
        formData.files.add(MapEntry("store_banner", await MultipartFile.fromFile(_bannerFileData!['_mybannerFilePath'].path)));
            } else {
            const errorMessage = "Please select a store_banner.";
            setState(() {
            _currentStep = 2;
            });
            showShrinkingToast(context, errorMessage);
            return;
            }

        final response = await Dio().post(
          "${ConstantUrls.baseUriApi}${ConstantUrls.registrationThirdApi}",
        options: Options(
          headers: {
            "Authorization": tokenAccess,
          },
        ),
        data: formData,
      );

   if (response.statusCode == 200) {
        _currentStep = 3;
        setState(() {});
      } else {
        setState(() {
          _currentStep = 2;
        });
      }
    }
    catch (e) {}
  }
//--------------this registration_stap_Third api End---------
  fetchRegistrationFourthData({childCategoriesList, parentCategoriesList}) async {
    try {
      final Map<String, dynamic> requestData = {
        "child_categories_list": childCategoriesList,
        "parent_categories_list": parentCategoriesList,
      };
      SharedPreferences preference = await SharedPreferences.getInstance();
      String? tokenAccess = preference.getString("access-token");
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.registrationFourthApi}",
        options: Options(
          headers: {
            "Authorization": tokenAccess,
            "Content-Type": "application/json",
          },
        ),
        data: requestData,
      );

      if (response.statusCode == 200) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>
                SellerSubmittedForm(
                     id: widget.id,
                     longitude:widget.longitude,
                     latitude:widget.latitude,
                     lName: widget.lName,
                )),
          );
        setState(() {
        });
      } else {

      }
    } catch (e) {
    }
  }

//--------------this registration_step_Fourth api End---------

  CatChackBoxList? catCheckBoxList;
  List<DataCheck> checkBoxListData = [];
  bool isLoading2 = false;
  fetchDataCheck({categoryId}) async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      tokenAccess = preference.getString("access-token");
      setState(() {
        isLoading2 = true;
      });
      final body = {"category_id": categoryId};
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.catCheckBoxApi}",
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
        catCheckBoxList = CatChackBoxList.fromJson(responseData);
        setState(() {
          checkBoxListData.addAll(catCheckBoxList!.data! ?? []);
          isLoading2 = false;
        });
      } else {
        isLoading2 = false;
      }
      setState(() {
        isLoading2 = false;
      });
    } catch (error) {
      setState(() {
        isLoading2 = false;
      });
    }
  }
//--------------this Fourth Cat_Check_Box api End---------

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
  List<Map<String, dynamic>> shopTimeInfo = [
    {
      "day": 'Monday',
      "open_time": "11:00 am",
      "close_time": "8:00 pm",
      "isOpen": true
    },
    {
      "day": 'Tuesday',
      "open_time": "11:00 am",
      "close_time": "8:00 pm",
      "isOpen": true
    },
    {
      "day": 'Wednesday',
      "open_time": "11:00 am",
      "close_time": "8:00 pm",
      "isOpen": true
    },
    {
      "day": 'Thursday',
      "open_time": "11:00 am",
      "close_time": "8:00 pm",
      "isOpen": true
    },
    {
      "day": 'Friday',
      "open_time": "11:00 am",
      "close_time": "8:00 pm",
      "isOpen": true
    },
    {
      "day": 'Saturday',
      "open_time": "11:00 am",
      "close_time": "8:00 pm",
      "isOpen": true
    },
    {
      "day": 'Sunday',
      "open_time": "11:00 am",
      "close_time": "8:00 pm",
      "isOpen": true
    },
  ];
//------------------------------------------------------------


  getShopTimeInfo (shopTimeInfo2, shopTimeInfoAnother){
    for (var anotherInfo in shopTimeInfoAnother) {
      var dayToUpdate = anotherInfo["day"];
      var indexToUpdate = shopTimeInfo2.indexWhere((element) => element["day"] == dayToUpdate);
      if (indexToUpdate != -1) {
        shopTimeInfo2[indexToUpdate]["isOpen"] = anotherInfo["on_off"]=="1"?true:false;
        shopTimeInfo2[indexToUpdate]["open_time"] =anotherInfo["opens_at"];
        shopTimeInfo2[indexToUpdate]["close_time"] =anotherInfo["closes_at"];
      }
    }
    return shopTimeInfo2;
  }

//------------------------------------------------------------
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
  bool selectAllChecked = false;
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
  //-------------------payment checkbox list--------
  //------------------Store Registration Type list start--------

  List<String> registrationTypeList = [
    'Gumasta',
    'Nagar Nigam',
    'Gst',
    'Any Other'
  ];
  //------------------Store Registration Type list end--------
  // --------Store Sell / provide on rent  list start--------
  List<String> buyOrRentList = [
    'Sell',
    'Provide On Rent',
    'Sell & Provide On Rent'
  ];
  //----------------Store Sell / provide on rent list end--------
  // --------Delivery Mode list start--------
  List<String> deliveryModeList = [
    'Pick up from store',
    'Home delivery available'
  ];
  //-------------Delivery Mode list end--------
  String? selectedItem;
  String selectedCategoryNamesString = '';
  String selectedPCategoryID = '';
//---------------------------------------------
   Map?  _fileData;
   _openFilePicker() async {
    try {
      final FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      );
      if (pickedFile != null) {
        final String filePath = pickedFile.files.single.path!;
        final String fileName = pickedFile.files.single.name;

        if (filePath.isNotEmpty) {
          setState(() {
             _fileData = {
              "_myFilePath" : File(pickedFile.files.single.path!),
              "_myFileName": pickedFile.files.single.name,
            };
          });
        } else {
        }
      }
    } catch (e) {
    }
  }
//--------------------------------------
  Map?  _logofileData;
  _logoFilePicker() async {
    try {
      final FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      );
      if (pickedFile != null) {
        final String filePath = pickedFile.files.single.path!;
        final String fileName = pickedFile.files.single.name;

        if (filePath.isNotEmpty) {
          setState(() {
            _logofileData = {
              "_myLogoFilePath" : File(pickedFile.files.single.path!),
              "_myLogoFileName": pickedFile.files.single.name,
            };
          });
        } else {
        }
      }
    } catch (e) {
    }
  }
//-------------------------------------------------
  Map?  _bannerFileData;
  _bannerFilePicker() async {
    try {
      final FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc'],
      );
      if (pickedFile != null) {
        final String bannerFilePath = pickedFile.files.single.path!;
        final String bannerFileName = pickedFile.files.single.name;

        if (bannerFilePath.isNotEmpty) {
          setState(() {
            _bannerFileData = {
              "_mybannerFilePath" : File(pickedFile.files.single.path!),
              "_mybannerFileName": pickedFile.files.single.name,
            };
          });
        } else {
        }
      }
    } catch (e) {
    }
  }
//----------------------------------------------
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: ConstantColor.loginWithOtpButtonColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ConstantColor.secondryBackgroundMainColor,
/*--------------------------------------appbar section start-------------------------------------*/
          key: _scaffoldKey,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ConstantColor.primaryBackgroundMainColor,
            iconTheme: const IconThemeData(
                color: ConstantColor.loginWithOtpButtonColor),
            title: customeText(
                textAlign: TextAlign.start,
                text: "Become a Seller",
                style: ConstantTextStyle.secodHearText),
          ),
/*--------------------------------------appbar section end-------------------------------------*/
          body: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: screenWidth/18,top: screenHeight/50),
                  child: customeText(
                    text: "Sing Up your seller Account".toUpperCase(),
                    textAlign: TextAlign.start,
                    style: ConstantTextStyle.cardbottumText,
                  ),
                ),
                Flexible(
                  child: Theme(
                    data: ThemeData(
                      // canvasColor: Colors.yellow,
                      colorScheme: Theme.of(context).colorScheme.copyWith(
                           primary: ConstantColor.primaryMainColor,
                           background: ConstantColor.transparent1
                          ),
                    ),
                    child:
                    Center(
                      child: isLoading? const SpinKitCircle(
                        color: ConstantColor.primaryMainColor,
                        size: 40.0,
                      ):
                      CupertinoScrollbar(
                        child: Stepper(
                          elevation: 0,
                          type: stepperType,
                          // physics: const BouncingScrollPhysics(),
                          currentStep: _currentStep,
                          onStepTapped: (step) => tapped(step),
                          controlsBuilder: (context, _) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: customeButton(
                                    onPressed:  _currentStep == 0 ? null : () {
                                      _currentStep > 0
                                          ? setState(() => _currentStep -= 1)
                                          : null;
                                    },
                                    text: 'Back',
                                    backgroundColor:
                                    ConstantColor.primaryGreyColor,
                                    borderRadius: BorderRadius.circular(8.0),
                                    minimumSize:
                                    Size.fromHeight(screenHeight / 25),
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidth /25,
                                ),
                                Flexible(
                                  child: customeButton(
                            backgroundColor: ConstantColor.primaryMainColor,
                                    minimumSize:
                                    Size.fromHeight(screenHeight / 25),
                                    onPressed: () async {
                                      if (storeNameController.text.isEmpty) {
                                        showShrinkingToast(context,
                                            'Store Name field is required');
                                      } else if (legalBusinessNameController
                                          .text.isEmpty) {
                                        showShrinkingToast(context,
                                            'Legal Business Name field is required');
                                      } else if (storeAddressController
                                          .text.isEmpty) {
                                        showShrinkingToast(context,
                                            'Store Address field is required');
                                      } else if (landmarkController
                                          .text.isEmpty) {
                                        showShrinkingToast(context,
                                            'Landmark field is required');
                                      } else if (storeLocAddressController
                                          .text.isEmpty) {
                                        showShrinkingToast(context,
                                            'Store Location field is required');
                                      } else {
                                        if (_currentStep == 0) {
                                          fetchRegistrationFirst(
                                            newStore: storeNameController.text
                                                .toString(),
                                            legalBusName:
                                            legalBusinessNameController.text
                                                .toString(),
                                            buildingAddress:
                                            storeAddressController.text
                                                .toString(),
                                            addressLoc: storeLocAddressController
                                                .text
                                                .toString(),
                                            landmark: landmarkController.text
                                                .toString(),
                                            latitudeFist:
                                            storeLatitudeCodeController.text
                                                .toString(),
                                            longitudeFist:
                                            storeLongitudeCodeController.text
                                                .toString(),
                                            countryFist: countryIdCodeController
                                                .text
                                                .toString(),
                                            stateFist: stateIdCodeController.text
                                                .toString(),
                                            cityFist: cityIdCodeController.text
                                                .toString(),
                                            pinCode: pincodeController.text.toString(),
                                          );
                                        }
                        
                                        if (_currentStep == 1) {
                                          fetchRegistrationSecond(
                                            contactPersonName: nameController.text.toString(),
                                            designationPerson: designationController.text.toString(),
                                            referralCode: referralCodeController
                                                .text
                                                .toString(),
                                            whatsappNumber: contactNoOptController
                                                .text
                                                .toString(),
                                            emailId:
                                            emailController.text.toString(),
                                            mobileNo: contactNoController.text
                                                .toString(),
                                            scRegno: _shopRegisterNumber ??
                                                scRegistrationTypeController.text
                                                    .toString() ??
                                                '',
                                            gstNo:
                                            gstNoController.text.toString(),
                                            scOtherType: scRegistrationOtherController.text
                                                .toString(),
                                            buyOrRent: _sellOrRent ??
                                                buyOrRentController.text
                                                    .toString() ??
                                                '',
                                            deliveryMode: _deliveryMode ??
                                                deliveryModeController.text
                                                    .toString() ??
                                                '',
                                            storeDescription:
                                            storeDetailController.text
                                                .toString(),
                                          );
                                        }
                        
                                        if (_currentStep == 2){
                                          fetchRegistrationThirdData(
                                            paymentModeAcc: selectedPaymentModes,
                                            yearOfEstable: yoeController.text.toString(),
                                          );
                                        }
                        
                                        if (_currentStep == 3) {
                                          fetchRegistrationFourthData(
                                              parentCategoriesList:  selectedPCategoryID ?? '',
                                              childCategoriesList: selectedCategoryNamesString ?? "");
                                        }
                                      }
                                    },
                                    text: (_currentStep < 3 ? 'Next' : 'Submit'),
                            textStyleButton: ConstantTextStyle.loginButtonTextStyle,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ],
                            );
                        
                          },
                          steps: [
                        //-----------------------------------Step 1 start--------------------------------------
                            Step(
                              title:  Text('Personal',style: ConstantTextStyle.allHomeScreenAvatarText,),
                              content: Column(
                                children: [
                        /*--------------------------Store Name filed start----------------------------------*/
                                  loginTextFormField2(
                                    controller: storeNameController == null || storeNameController.text == "null"
                                        ? TextEditingController(text: "")
                                        : storeNameController,
                                    textFormPaddingHorizontal: screenWidth / 40,
                                    textFormPaddingVertical: screenHeight / 40,
                                    minLines: 1,
                                    maxLines: 1,
                                    borderSideColor: _isFocused
                                        ? ConstantColor.primaryMainColor
                                        : ConstantColor.transparent1,
                                    focusNode: _focusNode,
                                    context: context,
                                    fillColor:
                                        ConstantColor.primaryBackgroundMainColor,
                                    filled: true,
                                    enabled: true,
                                    iconButton: IconButton,
                                    hintText: "Store Name",
                                    hintStyle: ConstantTextStyle.sellerHintTextStyle,
                                    labelText: "Store Name",
                                    labelStyle: ConstantTextStyle.lableTextStyle,
                                    cursorColor: ConstantColor.primaryMainColor,
                                    keyboardType: TextInputType.name,
                                    onChanged: (value) {
                                      setState(() {
                                        storeName = value;
                                      });
                                    },
                        /*--------------------------Store Name filed Update button start----------------------------------*/
                                  ),
                        /*-------------------------Store Name filed end----------------------------------*/
                                  SizedBox(height: screenHeight / 50),
                        /*------------------------Legal Business Name field start----------------------------------*/
                                  loginTextFormField2(
                                    controller:  legalBusinessNameController == null || legalBusinessNameController.text == "null"
                                        ? TextEditingController(text: "")
                                        : legalBusinessNameController,
                                    textFormPaddingHorizontal: screenWidth / 40,
                                    textFormPaddingVertical: screenHeight / 40,
                                    minLines: 1,
                                    maxLines: 1,
                                    borderSideColor: _isFocused29
                                        ? ConstantColor.primaryMainColor
                                        : ConstantColor.transparent1,
                                    focusNode: _focusNode29,
                                    context: context,
                                    fillColor:
                                        ConstantColor.primaryBackgroundMainColor,
                                    filled: true,
                                    iconButton: IconButton,
                                    hintText: "Legal Business Name",
                                    hintStyle:
                                        ConstantTextStyle.sellerHintTextStyle,
                                    labelText: "Legal Business Name",
                                    labelStyle: ConstantTextStyle.lableTextStyle,
                                    cursorColor: ConstantColor.primaryMainColor,
                                    keyboardType: TextInputType.text,
                                    onChanged: (value) {
                                      setState(() {
                                        legalBusinessName = value;
                                      });
                                    },
                                  ),
                        /*--------------------------Legal Business Name field end----------------------------------*/
                                  SizedBox(height: screenHeight / 50),
                        /*------------------------------Store Slug field start----------------------------------*/
                                  loginTextFormField2(
                                    controller:  storeSlugController == null || storeSlugController.text == "null"
                                        ? TextEditingController(text: "")
                                        : storeSlugController,
                                    textFormPaddingHorizontal: screenWidth / 40,
                                    textFormPaddingVertical: screenHeight / 60,
                                    minLines: 1,
                                    maxLines: 1,
                                    borderSideColor: ConstantColor.transparent1,
                                    context: context,
                                    fillColor:
                                        ConstantColor.textformFieldDisableColor,
                                    filled: true,
                                    enabled: false,
                                    iconButton: IconButton,
                                    hintText: "Store Slug",
                                    hintStyle:
                                        ConstantTextStyle.sellerHintTextStyle,
                                    labelText: "Store Slug",
                                    labelStyle: ConstantTextStyle.lableTextStyle,
                                    cursorColor: ConstantColor.primaryMainColor,
                                    //   keyboardType: TextInputType.multiline,
                                    onChanged: (value) {
                                      setState(() {
                                        latitude = value;
                                      });
                                    },
                                  ),
                        /*------------------------------Store Slug field end----------------------------------*/
                                  SizedBox(height: screenHeight / 50),
                        /*------------------------------Store Address field start----------------------------------*/
                                  loginTextFormField2(
                                    controller: storeAddressController == null || storeAddressController.text == "null"
                                        ? TextEditingController(text: "")
                                        : storeAddressController,
                                    textFormPaddingHorizontal: screenWidth / 40,
                                    textFormPaddingVertical: screenHeight / 40,
                                    minLines: 1,
                                    maxLines: 1,
                                    borderSideColor: _isFocused2
                                        ? ConstantColor.primaryMainColor
                                        : ConstantColor.transparent1,
                                    focusNode: _focusNode2,
                                    context: context,
                                    fillColor:
                                        ConstantColor.primaryBackgroundMainColor,
                                    filled: true,
                                    iconButton: IconButton,
                                    hintText: "Store Address",
                                    hintStyle:
                                        ConstantTextStyle.sellerHintTextStyle,
                                    labelText: "Store Address",
                                    labelStyle: ConstantTextStyle.lableTextStyle,
                                    cursorColor: ConstantColor.primaryMainColor,
                                    keyboardType: TextInputType.multiline,
                                    onChanged: (value) {
                                      setState(() {
                                        storeAddress = value;
                                      });
                                    },
                                  ),
                         /*------------------------------Store Address field end----------------------------------*/
                                  SizedBox(height: screenHeight / 50),
                        /*------------------------------Store Location field start----------------------------------*/
                                  SizedBox(height: screenHeight / 50),
                                  loginTextFormField2(
                                    controller:storeLocAddressController == null || storeLocAddressController.text == "null"
                                        ? TextEditingController(text: "")
                                        : storeLocAddressController,
                                    textFormPaddingHorizontal: screenWidth / 40,
                                    textFormPaddingVertical: screenHeight / 50,
                                    minLines: 1,
                                    maxLines: 1,
                                    borderSideColor: _isFocused3
                                        ? ConstantColor.primaryMainColor
                                        : ConstantColor.transparent1,
                                    focusNode: _focusNode3,
                                    context: context,
                                    fillColor:
                                    ConstantColor.primaryBackgroundMainColor,
                                    filled: true,
                                    iconButton: IconButton,
                                    hintText: "Location",
                                    hintStyle:
                                    ConstantTextStyle.sellerHintTextStyle,
                                    labelText: "Location",
                                    labelStyle: ConstantTextStyle.lableTextStyle,
                                    cursorColor: ConstantColor.primaryMainColor,
                                    keyboardType: TextInputType.name,
                                    onChanged: (value) {
                                      setState(() {
                                        getLocation = value;
                                      });
                                    },
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.only(
                                        right: screenWidth / 40,
                                        top: screenWidth / 40,
                                        bottom: screenWidth / 40,
                                      ),
                                      child: customeButton(
                                        textStyleButton: ConstantTextStyle
                                            .loginButtonTextStyle,
                                        onPressed: () async {
                                          try {
                                            // Call a function to get the current location
                                            String currentLocation = await getCurrentLocation(context);
                                            List<String> locationParts = currentLocation.split(", ");
                                            if (locationParts.length >= 4) {
                                              pinCode = locationParts[2];
                                              city = locationParts[3];
                                              state = locationParts[4];
                                              country = locationParts[5];
                                            }
                                            setState(() {
                                              isLoading = true;
                                              storeLocAddressController.text = currentLocation;
                                              pincodeController.text = pinCode;
                                              cityIdCodeController.text = city;
                                              stateIdCodeController.text = state;
                                              countryIdCodeController.text = country;
                                            });
                                          } catch (e) {}
                                          finally {
                                            // Set loading to false when the operation is complete
                                            setState(() {
                                              isLoading = false;
                                            });
                                          }
                                        },
                                        text: "Get Location",
                                        backgroundColor:
                                        ConstantColor.primaryMainColor,
                                        borderRadius: BorderRadius.circular(8.0),
                                        elevation: 3.0,
                                      ),
                                    ),
                                  ),
                        /*------------------------------Store Location field end----------------------------------*/
                                  SizedBox(height: screenHeight / 50),
                        /*------------------------------LandMark field start----------------------------------*/
                                  Row(
                                    children: [
                                      Flexible(
                                        child: loginTextFormField2(
                                          controller:landmarkController == null || landmarkController.text == "null"
                                              ? TextEditingController(text: "")
                                              : landmarkController,
                                          textFormPaddingHorizontal:
                                              screenWidth / 40,
                                          textFormPaddingVertical:
                                              screenHeight / 40,
                                          minLines: 1,
                                          maxLines: 1,
                                          borderSideColor: _isFocused24
                                              ? ConstantColor.primaryMainColor
                                              : ConstantColor.transparent1,
                                          focusNode: _focusNode24,
                                          context: context,
                                          fillColor: ConstantColor
                                              .primaryBackgroundMainColor,
                                          filled: true,
                                          enabled: true,
                                          iconButton: IconButton,
                                          hintText: "LandMark",
                                          hintStyle: ConstantTextStyle
                                              .sellerHintTextStyle,
                                          labelText: "LandMark",
                                          labelStyle:
                                              ConstantTextStyle.lableTextStyle,
                                          cursorColor:
                                              ConstantColor.primaryMainColor,
                                          keyboardType: TextInputType.text,
                                          onChanged: (value) {
                                            setState(() {
                                              landMark = value;
                                            });
                                          },
                                        ),
                                      ),
                        /*------------------------------LandMark field end----------------------------------*/
                                      SizedBox(width: screenWidth / 30),
                        /*-----------------------------Pincode field  start----------------------------------*/

                                      Flexible(
                                        child: loginTextFormField2(
                                          controller:pincodeController == null || pincodeController.text == "null"
                                              ? TextEditingController(text: "")
                                              : pincodeController,
                                          textFormPaddingHorizontal:
                                              screenWidth / 40,
                                          textFormPaddingVertical:
                                              screenHeight / 40,
                                          minLines: 1,
                                          maxLines: 1,
                                          borderSideColor: _isFocused25
                                              ? ConstantColor.primaryMainColor
                                              : ConstantColor.transparent1,
                                          focusNode: _focusNode25,
                                          context: context,
                                          fillColor: ConstantColor
                                              .primaryBackgroundMainColor,
                                          filled: true,
                                          enabled: true,
                                          iconButton: IconButton,
                                          hintText: "Pincode",
                                          hintStyle: ConstantTextStyle
                                              .sellerHintTextStyle,
                                          labelText: "Pincode",
                                          labelStyle:
                                              ConstantTextStyle.lableTextStyle,
                                          cursorColor:
                                              ConstantColor.primaryMainColor,
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            setState(() {
                                              pinCode = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                        /*--------------------------Pincode field  end----------------------------------*/
                                  SizedBox(height: screenHeight / 50),
                        /*------------------------------City field start----------------------------------*/
                                  Row(
                                    children: [
                                      Flexible(
                                        child: loginTextFormField2(
                                          controller:cityIdCodeController == null || cityIdCodeController.text == "null"
                                              ? TextEditingController(text: "")
                                              : cityIdCodeController,
                                          textFormPaddingHorizontal:
                                              screenWidth / 40,
                                          textFormPaddingVertical:
                                              screenHeight / 60,
                                          minLines: 1,
                                          maxLines: 1,
                                          borderSideColor: _isFocused9
                                              ? ConstantColor.primaryMainColor
                                              : ConstantColor.transparent1,
                                          focusNode: _focusNode9,
                                          context: context,
                                          fillColor: ConstantColor
                                              .textformFieldDisableColor,
                                          filled: true,
                                          enabled: false,
                                          iconButton: IconButton,
                                          hintText: "City",
                                          hintStyle: ConstantTextStyle
                                              .sellerHintTextStyle,
                                          labelText: "City",
                                          labelStyle:
                                              ConstantTextStyle.lableTextStyle,
                                          cursorColor:
                                              ConstantColor.primaryMainColor,
                                          //   keyboardType: TextInputType.multiline,
                                          onChanged: (value) {
                                            setState(() {
                                              city = value;
                                            });
                                          },
                                        ),
                                      ),

                        /*------------------------------City field end----------------------------------*/
                                      SizedBox(
                                        width: screenWidth / 30,
                                      ),
                        /*-----------------------------State- field start----------------------------------*/
                                      Flexible(
                                        child: loginTextFormField2(
                                          controller:stateIdCodeController == null || stateIdCodeController.text == "null"
                                              ? TextEditingController(text: "")
                                              : stateIdCodeController,
                                          textFormPaddingHorizontal:
                                              screenWidth / 40,
                                          textFormPaddingVertical:
                                              screenHeight / 60,
                                          minLines: 1,
                                          maxLines: 1,
                                          borderSideColor: _isFocused8
                                              ? ConstantColor.primaryMainColor
                                              : ConstantColor.transparent1,
                                          focusNode: _focusNode8,
                                          context: context,
                                          fillColor: ConstantColor
                                              .textformFieldDisableColor,
                                          filled: true,
                                          enabled: false,
                                          iconButton: IconButton,
                                          hintText: "State",
                                          hintStyle: ConstantTextStyle
                                              .sellerHintTextStyle,
                                          labelText: "State",
                                          labelStyle:
                                              ConstantTextStyle.lableTextStyle,
                                          cursorColor:
                                              ConstantColor.primaryMainColor,
                                          //  keyboardType: TextInputType.multiline,
                                          onChanged: (value) {
                                            setState(() {
                                              state = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                        /*------------------------------State field End----------------------------------*/
                                  SizedBox(height: screenHeight / 50),
                        /*------------------------------Referal Code field start----------------------------------*/
                                  Row(
                                    children: [
                                      Flexible(
                                        child: loginTextFormField2(
                                          controller:referralCodeController == null || referralCodeController.text == "null"
                                              ? TextEditingController(text: "")
                                              : referralCodeController,
                                          textFormPaddingHorizontal:
                                              screenWidth / 40,
                                          textFormPaddingVertical:
                                              screenHeight / 45,
                                          minLines: 1,
                                          maxLines: 1,
                                          borderSideColor: _isFocused4
                                              ? ConstantColor.primaryMainColor
                                              : ConstantColor.transparent1,
                                          focusNode: _focusNode4,
                                          context: context,
                                          fillColor: ConstantColor
                                              .primaryBackgroundMainColor,
                                          filled: true,
                                          iconButton: IconButton,
                                          hintText: "Referal Code",
                                          hintStyle: ConstantTextStyle
                                              .sellerHintTextStyle,
                                          labelText: "Referal Code",
                                          labelStyle:
                                              ConstantTextStyle.lableTextStyle,
                                          cursorColor:
                                              ConstantColor.primaryMainColor,
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            setState(() {
                                              referalCode = value;
                                            });
                                          },
                                        ),
                                      ),
                        /*------------------------------Referal Code field start----------------------------------*/
                                      SizedBox(
                                        width: screenWidth / 30,
                                      ),
                        /*----------------------------Country field start----------------------------------*/
                                      Flexible(
                                        child: loginTextFormField2(
                                          controller:countryIdCodeController == null || countryIdCodeController.text == "null"
                                              ? TextEditingController(text: "")
                                              : countryIdCodeController,
                                          textFormPaddingHorizontal:
                                              screenWidth / 40,
                                          textFormPaddingVertical:
                                              screenHeight / 60,
                                          minLines: 1,
                                          maxLines: 1,
                                          borderSideColor: _isFocused7
                                              ? ConstantColor.primaryMainColor
                                              : ConstantColor.transparent1,
                                          focusNode: _focusNode7,
                                          context: context,
                                          fillColor: ConstantColor
                                              .textformFieldDisableColor,
                                          filled: true,
                                          enabled: false,
                                          iconButton: IconButton,
                                          hintText: "Country",
                                          hintStyle: ConstantTextStyle
                                              .sellerHintTextStyle,
                                          labelText: "Country",
                                          labelStyle:
                                              ConstantTextStyle.lableTextStyle,
                                          cursorColor:
                                              ConstantColor.primaryMainColor,
                                          //   keyboardType: TextInputType.multiline,
                                          onChanged: (value) {
                                            setState(() {
                                              country = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                        /*------------------------------Country field  end----------------------------------*/
                                  SizedBox(height: screenHeight / 50),
                                ],
                              ),
                              isActive: _currentStep >= 0,
                              state: _currentStep >= 0
                                  ? StepState.complete
                                  : StepState.disabled,
                            ),
                        //-----------------------------------Step 1 End--------------------------------------
                        //-----------------------------------Step 2 Start--------------------------------------
                            Step(
                              title: Text('Store',style: ConstantTextStyle.allHomeScreenAvatarText,),
                              content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                        /*---------------------Contact Person field start----------------------------------*/
                                    loginTextFormField2(
                                      controller:nameController == null || nameController.text == "null"
                                          ? TextEditingController(text: "")
                                          : nameController,
                                      inputFormatters: [
                                        // Add the custom input formatter with a maxLength
                                        // PersonNameFormatter(), // Adjust the maxLength as needed
                                      ],
                                      textFormPaddingHorizontal: screenWidth / 40,
                                      textFormPaddingVertical: screenHeight / 40,
                                      minLines: 1,
                                      maxLines: 1,
                                      borderSideColor: _isFocused26
                                          ? ConstantColor.primaryMainColor
                                          : ConstantColor.transparent1,
                                      focusNode: _focusNode26,
                                      context: context,
                                      fillColor: ConstantColor
                                          .primaryBackgroundMainColor,
                                      filled: true,
                                      iconButton: IconButton,
                                      hintText: "Person Name",
                                      //    helperText: 'Example: john@example.com',
                        
                                      hintStyle:
                                          ConstantTextStyle.sellerHintTextStyle,
                                      labelText: "Person Name",
                                      labelStyle:
                                          ConstantTextStyle.lableTextStyle,
                                      cursorColor: ConstantColor.primaryMainColor,
                                      keyboardType: TextInputType.name,
                                      onChanged: (value) {
                                        setState(() {
                                          name = value;
                                        });
                                      },
                                    ),
                        
                        /*----------------------Contact Person field end----------------------------------*/
                                    SizedBox(height: screenHeight / 50),
                        /*---------------------designation  field start----------------------------------*/
                                    loginTextFormField2(
                                      controller: designationController,
                                      textFormPaddingHorizontal: screenWidth / 40,
                                      textFormPaddingVertical: screenHeight / 40,
                                      minLines: 1,
                                      maxLines: 1,
                                      borderSideColor: _isFocused27
                                          ? ConstantColor.primaryMainColor
                                          : ConstantColor.transparent1,
                                      focusNode: _focusNode27,
                                      context: context,
                                      fillColor: ConstantColor
                                          .primaryBackgroundMainColor,
                                      filled: true,
                                      iconButton: IconButton,
                                      hintText: "Designation",
                                      hintStyle:
                                          ConstantTextStyle.sellerHintTextStyle,
                                      labelText: "Designation",
                                      labelStyle:
                                          ConstantTextStyle.lableTextStyle,
                                      cursorColor: ConstantColor.primaryMainColor,
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {
                                        setState(() {
                                          designation = value;
                                        });
                                      },
                                    ),
                        
                        /*---------------------- designation field end----------------------------------*/
                                    SizedBox(height: screenHeight / 50),
                        /*------------------------------Email field start----------------------------------*/
                                    loginTextFormField2(
                                      controller: emailController,
                                      textFormPaddingHorizontal: screenWidth / 40,
                                      textFormPaddingVertical: screenHeight / 40,
                                      minLines: 1,
                                      maxLines: 1,
                                      borderSideColor: _isFocused10
                                          ? ConstantColor.primaryMainColor
                                          : ConstantColor.transparent1,
                                      focusNode: _focusNode10,
                                      context: context,
                                      fillColor: ConstantColor
                                          .primaryBackgroundMainColor,
                                      filled: true,
                                      iconButton: IconButton,
                                      hintText: "Email",
                                      //    helperText: 'Example: john@example.com',
                                      hintStyle:
                                          ConstantTextStyle.sellerHintTextStyle,
                                      labelText: "Email *",
                                      labelStyle:
                                          ConstantTextStyle.lableTextStyle,
                                      cursorColor: ConstantColor.primaryMainColor,
                                      keyboardType: TextInputType.emailAddress,
                                      onChanged: (value) {
                                        setState(() {
                                          email = value;
                                        });
                                      },
                                    ),
                        
                        /*------------------------------Email field end----------------------------------*/
                                    SizedBox(height: screenHeight / 50),
                        /*------------------------------Contact field start----------------------------------*/
                                    Row(
                                      children: [
                                        Flexible(
                                          child:
                                          loginTextFormField2(
                                            controller: contactNoController,
                                            textFormPaddingHorizontal: screenWidth / 40,
                                            textFormPaddingVertical:contactNoController.text.length == 10
                                                ? screenHeight / 60
                                            :screenHeight / 40,
                                            minLines: 1,
                                            maxLines: 1,
                                            borderSideColor: _isFocused11
                                                ? ConstantColor.primaryMainColor
                                                : ConstantColor.transparent1,
                                            focusNode: _focusNode11,
                                            context: context,
                                            fillColor: contactNoController.text.length == 10
                                                ? ConstantColor.textformFieldDisableColor
                                                : ConstantColor.primaryBackgroundMainColor,
                                            filled: true,
                                            enabled: contactNoController.text.length != 10,
                                            iconButton: IconButton,
                                            hintText: "Contact no.",
                                            hintStyle: ConstantTextStyle.sellerHintTextStyle,
                                            labelText: "Contact no.",
                                            labelStyle: ConstantTextStyle.lableTextStyle,
                                            cursorColor: ConstantColor.primaryMainColor,
                                            keyboardType: TextInputType.number,
                                            onChanged: (value) {
                                              setState(() {
                                                contactNo = value;
                                              });
                                            },
                                          )
                                        ),
                        /*------------------------------Contact field end----------------------------------*/
                        /*------------------------------Optional Contact field  start----------------------------------*/
                                        Flexible(
                                          child: loginTextFormField2(
                                            maxLength: 10,
                                            controller:contactNoOptController == null || contactNoOptController.text == "null"
                                                ? TextEditingController(text: "")
                                                : contactNoOptController,
                                            textFormPaddingHorizontal:
                                                screenWidth / 40,
                                            textFormPaddingVertical: screenHeight / 40,
                                            minLines: 1,
                                            maxLines: 1,
                                            borderSideColor: _isFocused12
                                                ? ConstantColor.primaryMainColor
                                                : ConstantColor.transparent1,
                                            focusNode: _focusNode12,
                                            context: context,
                                            fillColor: ConstantColor.primaryBackgroundMainColor,
                                            filled: true,
                                            enabled: true,
                                            iconButton: IconButton,
                                            hintText: "Whatsapp Number",
                                            hintStyle: ConstantTextStyle
                                                .sellerHintTextStyle,
                                            labelText: "Whatsapp Number",
                                            labelStyle:
                                                ConstantTextStyle.lableTextStyle,
                                            cursorColor:
                                                ConstantColor.primaryMainColor,
                                            keyboardType: TextInputType.number,
                                            onChanged: (value) {
                                              setState(() {
                                                contactNoOptional = value;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                        /*------------------------------Optional Contact field  end----------------------------------*/
                                    SizedBox(height: screenHeight / 50),
                        /*-------------------------Registration noType. drop down  start ---------------------------------*/
                                    dropDownForm(
                                      context: context,
                                      widthBorder: _isFocused13
                                          ? screenWidth / 100
                                          : screenWidth / 500,
                                      colorBorder: _isFocused13
                                          ? ConstantColor.primaryMainColor
                                          : ConstantColor.textFieldColor,
                                      hintText: scRegistrationTypeController.text
                                          .toString(),
                                      headText: 'Shop/Company Registration Type',
                                      menuMaxHeightFormField: screenHeight / 4,
                                      focusNode: _focusNode13,
                                      value: _shopRegisterNumber,
                                      items: registrationTypeList
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _shopRegisterNumber = newValue;
                                        });
                                      },
                                    ),
                        /*-------------------------Registration noType. drop down  end ---------------------------------*/
                                    SizedBox(height: screenHeight / 50),
                        /*-------------------------Registration Other Type start ---------------------------------*/
                        
                                    Visibility(
                                      visible: _shopRegisterNumber == "Any Other",
                                      child: loginTextFormField2(
                                        controller:scRegistrationOtherController == null || scRegistrationOtherController.text == "null"
                                            ? TextEditingController(text: "")
                                            : scRegistrationOtherController,
                                        textFormPaddingHorizontal:
                                            screenWidth / 40,
                                        textFormPaddingVertical:
                                            screenHeight / 40,
                                        minLines: 1,
                                        maxLines: 1,
                                        borderSideColor: _isFocused5
                                            ? ConstantColor.primaryMainColor
                                            : ConstantColor.transparent1,
                                        focusNode: _focusNode5,
                                        context: context,
                                        fillColor: ConstantColor
                                            .primaryBackgroundMainColor,
                                        filled: true,
                                        iconButton: IconButton,
                                        hintText:
                                            "Shop/Company Registration No.Type",
                                        hintStyle:
                                            ConstantTextStyle.sellerHintTextStyle,
                                        labelText:
                                            "Shop/Company Registration No.Type",
                                        labelStyle:
                                            ConstantTextStyle.lableTextStyle,
                                        cursorColor:
                                            ConstantColor.primaryMainColor,
                                        onChanged: (value) {
                                          setState(() {
                                            registrationNoOther = value;
                                          });
                                        },
                                      ),
                                    ),
                        /*-------------------------Registration Other Type end ---------------------------------*/
                                    Visibility(
                                        visible:
                                            _shopRegisterNumber == "Any Other",
                                        child:
                                            SizedBox(height: screenHeight / 50)),
                        /*-------------------------Registration no.  (2) start ---------------------------------*/
                        
                                    loginTextFormField2(
                                      controller: gstNoController,
                                      textFormPaddingHorizontal: screenWidth / 40,
                                      textFormPaddingVertical: screenHeight / 40,
                                      minLines: 1,
                                      maxLines: 1,
                                      borderSideColor: _isFocused14
                                          ? ConstantColor.primaryMainColor
                                          : ConstantColor.transparent1,
                                      focusNode: _focusNode14,
                                      context: context,
                                      fillColor: ConstantColor
                                          .primaryBackgroundMainColor,
                                      filled: true,
                                      iconButton: IconButton,
                                      hintText: "Shop/Company Registration no.",
                                      hintStyle:
                                          ConstantTextStyle.sellerHintTextStyle,
                                      labelText: "Shop/Company Registration no.",
                                      labelStyle:
                                          ConstantTextStyle.lableTextStyle,
                                      cursorColor: ConstantColor.primaryMainColor,
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {
                                        setState(() {
                                          registrationNo2 = value;
                                        });
                                      },
                                    ),
                        /*-------------------------Registration no.  (2) end ---------------------------------*/
                                    SizedBox(
                                      height: screenHeight / 50,
                                    ),
                        /*------------------------------Store Registration Docs field start----------------------------------*/
                                    customeText(
                                      text: "Upload Registration Documents*",
                                      style: const TextStyle(
                                        fontFamily: 'Montserrat',
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(
                                      height: screenHeight / 80,
                                    ),
                             filePickerWidget(
                                context: context,
                                heightContain: screenHeight / 15,
                                imageChild:  _fileData != null
                                    ?  _fileData!["_myFileName"].toLowerCase().endsWith('.pdf')
                                     ? SfPdfViewer.file(File( _fileData!["_myFilePath"].path))
                                    : Image.file(
                                   _fileData!["_myFilePath"],
                                  height: screenHeight,
                                  width: screenWidth,
                                  fit: BoxFit.fill,
                                )
                                    : Image.network(scRegistrationFileController.text, fit: BoxFit.contain),
                                buttonText: "Choose File",
                                textStyleButton: ConstantTextStyle.loginButtonTextStyle,
                                onPressedButton: () {
                                  setState(() {
                                    _openFilePicker();
                                  });
                                },
                              ),
                                    customeText(
                                      text: 'Upload only (images,pdf,doc,docx) of max size 5MB',
                                      style: ConstantTextStyle.becomeSellerDiscText,
                                      textAlign: TextAlign.start,
                                    ),
                        /*------------------------------Store Registration Docs field start----------------------------------*/
                                    SizedBox(
                                      height: screenHeight / 50,
                                    ),
                        /*------------------------------Sell/Provides Buy or rent field start----------------------------------*/
                                    dropDownForm(
                                      context: context,
                                      widthBorder: _isFocused19
                                          ? screenWidth / 100
                                          : screenWidth / 500,
                                      colorBorder: _isFocused19
                                          ? ConstantColor.primaryMainColor
                                          : ConstantColor.textFieldColor,
                                      hintText:
                                          buyOrRentController.text.toString(),
                                      headText: 'Sell/Provide on rent *',
                                      menuMaxHeightFormField: screenHeight / 4,
                                      focusNode: _focusNode19,
                                      value: _sellOrRent,
                                      items: buyOrRentList.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _sellOrRent = newValue;
                                        });
                                      },
                                    ),
                        
                        /*------------------------------Sell/Provide Boy on rent field end----------------------------------*/
                                    SizedBox(height: screenHeight / 50),
                                    // SizedBox(width: screenWidth / 30,),
                        /*------------------------------Delivery Mode field  start----------------------------------*/
                                    dropDownForm(
                                      context: context,
                                      widthBorder: _isFocused20
                                          ? screenWidth / 100
                                          : screenWidth / 500,
                                      colorBorder: _isFocused20
                                          ? ConstantColor.primaryMainColor
                                          : ConstantColor.textFieldColor,
                                      hintText:
                                          deliveryModeController.text.toString(),
                                      headText: 'Delivery Mode *',
                                      menuMaxHeightFormField: screenHeight / 4,
                                      focusNode: _focusNode20,
                                      value: _deliveryMode,
                                      items: deliveryModeList
                                          .toSet()
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                        
                                      // items: deliveryModeList.map((String value) {
                                      //   return DropdownMenuItem<String>(
                                      //     value: value,
                                      //     child: Text(value),
                                      //   );
                                      // }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _deliveryMode = newValue;
                                        });
                                      },
                                    ),
                        /*------------------------------Delivery Mode field  end----------------------------------*/
                                    SizedBox(height: screenHeight / 50),
                        /*------------------------------Store Details field start----------------------------------*/
                                    loginTextFormField2(
                                      controller:storeDetailController == null || storeDetailController.text == "null"
                                          ? TextEditingController(text: "")
                                          : storeDetailController,
                                      textFormPaddingHorizontal: screenWidth / 40,
                                      textFormPaddingVertical: screenHeight / 50,
                                      minLines: 4,
                                      maxLines: 4,
                                      borderSideColor: _isFocused1
                                          ? ConstantColor.primaryMainColor
                                          : ConstantColor.transparent1,
                                      focusNode: _focusNode1,
                                      context: context,
                                      fillColor: ConstantColor
                                          .primaryBackgroundMainColor,
                                      filled: true,
                                      iconButton: IconButton,
                                      hintText: "Store Details",
                                      hintStyle:
                                          ConstantTextStyle.sellerHintTextStyle,
                                      labelText: "Store Details",
                                      labelStyle:
                                          ConstantTextStyle.lableTextStyle,
                                      cursorColor: ConstantColor.primaryMainColor,
                                      keyboardType: TextInputType.multiline,
                                      onChanged: (value) {
                                        setState(() {
                                          storeDetails = value;
                                        });
                                      },
                                    ),
                        /*------------------------------Store Details field end----------------------------------*/
                                    SizedBox(height: screenHeight / 50),
                                  ]),
                              isActive: _currentStep >= 0,
                              state: _currentStep >= 1
                                  ? StepState.complete
                                  : StepState.disabled,
                            ),
                        //---------------------------Step 3 Start--------------------
                        
                            Step(
                              title: Text('Image',style: ConstantTextStyle.allHomeScreenAvatarText,),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                        /*------------------------------Store LOGO field start----------------------------------*/
                                  customeText(
                                    text: "Select Store Logo*",
                                    style: const TextStyle(
                                      fontFamily: 'Montserrat',
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(
                                    height: screenHeight / 80,
                                  ),
                                  filePickerWidget(
                                    boarderColor: _isFocused17
                                        ? ConstantColor.primaryMainColor
                                        : ConstantColor.transparent1,
                                    context: context,
                                    heightContain: screenHeight / 15,
                                    imageChild:  _logofileData != null
                                        ?  _logofileData!["_myLogoFileName"].toLowerCase().endsWith('.pdf')
                                        ? SfPdfViewer.file(File( _logofileData!["_myLogoFilePath"].path))
                                        : Image.file(
                                      _logofileData!["_myLogoFilePath"],
                                      height: screenHeight,
                                      width: screenWidth,
                                      fit: BoxFit.fill,
                                    )
                                        : Image.network(storeLogoNameController.text, fit: BoxFit.contain),
                                    buttonText: "Choose File",
                                    textStyleButton: ConstantTextStyle.loginButtonTextStyle,
                                    onPressedButton: () {
                                      setState(() {
                                        _logoFilePicker();
                                      });
                                    },
                                  ),
                        
                        /*------------------------------Store LOGO field end----------------------------------*/
                                  SizedBox(height: screenHeight / 50),
                        /*------------------------------Store Banner field start----------------------------------*/
                        
                                  customeText(
                                    text: "Select Store Banner*",
                                    style: const TextStyle(
                                      fontFamily: 'Montserrat',
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(
                                    height: screenHeight / 80,
                                  ),
                                  filePickerWidget(
                                    boarderColor: _isFocused17
                                        ? ConstantColor.primaryMainColor
                                        : ConstantColor.transparent1,
                                    context: context,
                                    heightContain: screenHeight / 15,
                                    imageChild:  _bannerFileData != null
                                        ?  _bannerFileData!["_mybannerFileName"].toLowerCase().endsWith('.pdf')
                                        ? SfPdfViewer.file(File( _bannerFileData!["_mybannerFilePath"].path))
                                        : Image.file(
                                      _bannerFileData!["_mybannerFilePath"],
                                      height: screenHeight,
                                      width: screenWidth,
                                      fit: BoxFit.fill,
                                    )
                                        : Image.network(storeBannerNameController.text, fit: BoxFit.contain),
                                    buttonText: "Choose File",
                                    textStyleButton: ConstantTextStyle.loginButtonTextStyle,
                                    onPressedButton: () {
                                      setState(() {
                                        _bannerFilePicker();
                                      });
                                    },
                                  ),
                        /*------------------------------Store Banner field end----------------------------------*/
                                  SizedBox(height: screenHeight / 50),
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
                                    child: Scrollbar(
                                      controller: _scrollController,
                                      trackVisibility: true,
                                      thumbVisibility: true,
                                      child: SingleChildScrollView(
                                        controller: _scrollController,
                                        scrollDirection: Axis.horizontal,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                        
                                            DataTable(
                                              columnSpacing: screenWidth/20,
                                              dividerThickness: screenHeight/200,
                                              headingRowColor:
                                              MaterialStateColor.resolveWith((states) => ConstantColor.calendarBGHeadColor),
                                              dataRowHeight: screenHeight/16,
                                              columns:  [
                                                DataColumn(label: customeText(
                                                  text:
                                                  'Day'.toUpperCase(),
                                                  style: ConstantTextStyle
                                                      .passwordScreenLineTexStyle,
                                                  textAlign: TextAlign.start,),),
                                                DataColumn(label: customeText(
                                                  text:
                                                  'Close/open'.toUpperCase(),
                                                  style: ConstantTextStyle
                                                      .passwordScreenLineTexStyle,
                                                  textAlign: TextAlign.start,),),
                                                DataColumn(label: customeText(
                                                  text:
                                                  'Open Time'.toUpperCase(),
                                                  style: ConstantTextStyle
                                                      .passwordScreenLineTexStyle,
                                                  textAlign: TextAlign.start,),),
                                                DataColumn(label: customeText(
                                                  text:
                                                  'Close Time'.toUpperCase(),
                                                  style: ConstantTextStyle
                                                      .passwordScreenLineTexStyle,
                                                  textAlign: TextAlign.start,),),
                                              ],
                                              rows: List.generate(shopTimeInfo.length, (dayIndex) {
                        
                                                String day = shopTimeInfo[dayIndex]['day'];
                                                bool isOpen=shopTimeInfo[dayIndex]['isOpen'];
                                                String openTime=shopTimeInfo[dayIndex]['open_time'];
                                                String closeTime=shopTimeInfo[dayIndex]['close_time'];
                                                return DataRow(cells: [
                                                  DataCell(
                                                    Text(day.toUpperCase(),
                                                      style: ConstantTextStyle.allHomeScreenAvatarText,),
                                                  ),
                                                  DataCell(
                                                    customeSwitch(
                                                      toggleColor: ConstantColor.primaryMainColor,
                                                      inactiveToggleColor: ConstantColor.primaryBackgroundMainColor,
                                                      activeColor: ConstantColor.switchActiveColor,
                                                      inactiveColor: ConstantColor.switchActiveColor,
                                                      switchHeight: screenHeight / 50,
                                                      switchWidth: screenWidth / 10,
                                                      padding: 2.5,
                                                      toggleSize: 15.0,
                                                      borderRadius: 10.0,
                                                      value: isOpen,
                                                      onToggle: (value) {
                                                        setState(() {
                                                          shopTimeInfo[dayIndex]['isOpen'] = value;
                                                        });
                                                      },
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
                                                        items: _timeOptions1.map((openHrs) {
                                                          return DropdownMenuItem<String>(
                                                            value: openHrs,
                                                            child: Text(
                                                              openHrs.toString(),
                                                            ),
                                                          );
                                                        }).toList(),
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
                                                            shopTimeInfo[dayIndex]['close_time']  = newValue;
                                                          });
                        
                                                        },
                                                        items: _timeOptions1.map((openHrs) {
                                                          return DropdownMenuItem<String>(
                                                            value: openHrs,
                                                            child: Text(
                                                              openHrs.toString(),
                                                            ),
                                                          );
                                                        }).toList(),
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
                                  SizedBox(height: screenHeight / 50),
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
                                    title: customeButton(
                                      text: "Select All",
                                      style: ConstantTextStyle.loginButtonTextStyle,
                                     backgroundColor: ConstantColor.primaryBackgroundMainColor,
                                      onPressed: () {
                                        setState(() {
                                          selectAllChecked = !selectAllChecked;
                                          if (selectAllChecked) {
                                           selectedPaymentModes =paymentTextName.join(',');
                                          } else {selectedPaymentModes = "";
                                          }
                                        });
                                      },
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  // SizedBox(height: screenHeight / 80),
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
                                  SizedBox(height: screenHeight / 50),
                        /*------------------------Year Of Establishment Field start ---------------------------------*/
                                  loginTextFormField2(
                                    controller:yoeController == null || yoeController.text == "null"
                                        ? TextEditingController(text: "")
                                        : yoeController,
                                    textFormPaddingHorizontal: screenWidth / 40,
                                    textFormPaddingVertical: screenHeight / 40,
                                    minLines: 1,
                                    maxLines: 1,
                                    borderSideColor: _isFocused28
                                        ? ConstantColor.primaryMainColor
                                        : ConstantColor.transparent1,
                                    focusNode: _focusNode28,
                                    context: context,
                                    fillColor:
                                        ConstantColor.primaryBackgroundMainColor,
                                    filled: true,
                                    iconButton: IconButton,
                                    hintText: "Year Of Establishment",
                                    hintStyle: ConstantTextStyle.sellerHintTextStyle,
                                    labelText: "Year Of Establishment",
                                    labelStyle: ConstantTextStyle.lableTextStyle,
                                    cursorColor: ConstantColor.primaryMainColor,
                                    keyboardType: TextInputType.text,
                                    onChanged: (value) {
                                      setState(() {
                                        yoe = value;
                                      });
                                    },
                                  ),
                                  SizedBox(height: screenHeight / 50),
                        /*-------------------------Year Of Establishment Field end ---------------------------------*/
                                ],
                              ),
                              isActive: _currentStep >= 0,
                              state: _currentStep >= 2
                                  ? StepState.complete
                                  : StepState.disabled,
                            ),
                        //----------------------------------Step 4--------------------------
                            Step(
                              title: Text('Finish',style: ConstantTextStyle.allHomeScreenAvatarText,),
                              content:
                               Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                        /*-------------------------Deals In Field start ---------------------------------*/
                                  customeText(
                                    text: "Deals In *",
                                    style: const TextStyle(
                                      fontFamily: 'Montserrat',
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(
                                    height: screenHeight / 80,
                                  ),
                                  dropDownForm(
                                    menuMaxHeightFormField:
                                        MediaQuery.of(context).size.height / 3,
                                    context: context,
                                    focusNode: _focusNode18,
                                    widthBorder: _isFocused18
                                        ? screenWidth / 100
                                        : screenWidth / 500,
                                    colorBorder: _isFocused18
                                        ? ConstantColor.primaryMainColor
                                        : ConstantColor.transparent1,
                                    headText: 'Select Category',
                                    value: selectedItem,
                                    items: childCat.map((ChildCat item) {
                                      List<String> parts = [];
                                      if (item.cat != null) {
                                        parts.add(item.cat!);
                                      }
                                      if (item.pcat1 != null) {
                                        parts.add(item.pcat1!);
                                      }
                                      if (item.pcat2 != null) {
                                        parts.add(item.pcat2!);
                                      }
                                      if (item.pcat3 != null) {
                                        parts.add(item.pcat3!);
                                      }
                        
                                      String displayText = parts.join(' >> ');
                                      displayText = displayText.replaceAll(RegExp(r'[0-9=]'), '');
                                      return DropdownMenuItem<String>(
                                        value: item.categoryId,
                                        child: Text(
                                          displayText,
                                          style: ConstantTextStyle.dropDownPrimeText,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedItem = newValue;
                                        if (selectedItem != null) {
                                          if (selectedPCategoryID.isNotEmpty) {
                                            selectedPCategoryID += ', ';
                                          }
                                          selectedPCategoryID += selectedItem!;
                                        }
                                      });
                                      fetchDataCheck(categoryId: newValue);
                                    },
                                  ),
                        /*-------------------------Child category ---------------------------------*/
                                  ...checkBoxListData.map((categoryName) {
                                    return Visibility(
                                      visible: selectedItem != null,
                                      child: Card(
                                        elevation:
                                            categoryName.isSelected ?? false
                                                ? 0
                                                : .2,
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                            color: ConstantColor
                                                .primaryBackgroundMainColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: CheckboxListTile(
                                          contentPadding: EdgeInsets.zero,
                                          dense: true,
                                          checkboxShape: RoundedRectangleBorder(
                                              borderRadius:   BorderRadius.circular(5)),
                                          activeColor: ConstantColor.filedContainerColor,
                                          checkColor: ConstantColor
                                              .primaryBackgroundMainColor,
                                          title: customeText(
                                            text: categoryName.categoryName ?? '',
                                            overflow: TextOverflow.ellipsis,
                                            style: ConstantTextStyle
                                                .allHomeScreenAvatarText,
                                          ),
                                          value: categoryName.isSelected ?? false,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              categoryName.isSelected = value;
                                              //  store check box data in string
                                              if (value == true) {
                                                selectedCategoryNamesString += (selectedCategoryNamesString.isNotEmpty ? ', ' : '') +
                                                        (categoryName.categoryName ?? '');
                                              } else {
                                                final removedName = (categoryName.categoryName ?? '');
                                                final List<dynamic> sringName;
                                                sringName = selectedCategoryNamesString.split(',');
                                                sringName.removeLast();
                                                selectedCategoryNamesString = sringName.join(',');
                                              }
                                            });
                                          },
                                     controlAffinity: ListTileControlAffinity.leading,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                        /*-------------------------Deals In Field end ---------------------------------*/
                                ],
                              ),
                              isActive: _currentStep >= 0,
                              state: _currentStep >= 3
                                  ? StepState.complete
                                  : StepState.disabled,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  void save() {}
//------------------------------------------
}


