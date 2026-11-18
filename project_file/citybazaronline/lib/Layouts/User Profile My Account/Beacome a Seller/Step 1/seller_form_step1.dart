// import 'dart:convert';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../../Models/Pre Registration/registration_preview.dart';
// import '../../../../Util/Constant APi Url/api_urls.dart';
// import '../../../../Util/constaint_textstyle.dart';
// import '../../../../Util/constant_color.dart';
// import '../../../../Widgets/Drop Down Menu/drop_down_button.dart';
// import '../../../../Widgets/custome_button_.dart';
// import '../../../../Widgets/custome_checkbox.dart';
// import '../../../../Widgets/custome_richtext.dart';
// import '../../../../Widgets/custome_text.dart';
// import '../../../../Widgets/login_textformfiled.dart';
// import '../Get Location Funtion/get_location_fun.dart';
//
// class StepperDemo extends StatefulWidget {
//   @override
//   _StepperDemoState createState() => _StepperDemoState();
// }
//
// class _StepperDemoState extends State<StepperDemo> {
//   int _currentStep = 0;
//   StepperType stepperType = StepperType.horizontal;
// //---------------------------------------------
//   String location = '';
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final ScrollController _scrollController = ScrollController();
// //---------------------------------------------
//
//
//   final List<String> _timeOptions = [
//     '8:00 AM',
//     '9:00 AM',
//     '10:00 AM',
//     '11:00 AM',
//     '12:00 PM',
//     '1:00 PM',
//     '2:00 PM',
//     '3:00 PM',
//     '4:00 PM',
//     '5:00 PM',
//     '6:00 PM',
//     '7:00 PM',
//     '8:00 PM',
//     '9:00 PM',
//     '10:00 PM',
//   ];
//
//   bool _switchValue = false;
//   bool _switchValue1 = false;
//   bool _switchValue2 = false;
//   bool _switchValue3 = false;
//   bool _switchValue4 = false;
//   bool _switchValue5 = false;
//   bool _switchValue6 = false;
//   String? _selectedTime;
//
//   final FocusNode _focusNode = FocusNode();
//   final FocusNode _focusNode1 = FocusNode();
//   final FocusNode _focusNode2 = FocusNode();
//   final FocusNode _focusNode3 = FocusNode();
//   final FocusNode _focusNode4 = FocusNode();
//   final FocusNode _focusNode5 = FocusNode();
//   final FocusNode _focusNode6 = FocusNode();
//   final FocusNode _focusNode7 = FocusNode();
//   final FocusNode _focusNode8 = FocusNode();
//   final FocusNode _focusNode9 = FocusNode();
//   final FocusNode _focusNode10 = FocusNode();
//   final FocusNode _focusNode11 = FocusNode();
//   final FocusNode _focusNode12 = FocusNode();
//   final FocusNode _focusNode13 = FocusNode();
//   final FocusNode _focusNode14 = FocusNode();
//   final FocusNode _focusNode15 = FocusNode();
//   final FocusNode _focusNode16 = FocusNode();
//   final FocusNode _focusNode17 = FocusNode();
//   final FocusNode _focusNode18 = FocusNode();
//   final FocusNode _focusNode19 = FocusNode();
//   final FocusNode _focusNode20 = FocusNode();
//   final FocusNode _focusNode21 = FocusNode();
//   final FocusNode _focusNode22 = FocusNode();
//   final FocusNode _focusNode23 = FocusNode();
//   final FocusNode _focusNode24 = FocusNode();
//   final FocusNode _focusNode25 = FocusNode();
//   final FocusNode _focusNode26 = FocusNode();
//   final FocusNode _focusNode27 = FocusNode();
//   final FocusNode _focusNode28 = FocusNode();
//   final FocusNode _focusNode29 = FocusNode();
//
//   bool _isFocused = false;
//   bool _isFocused1 = false;
//   bool _isFocused2 = false;
//   bool _isFocused3 = false;
//   bool _isFocused4 = false;
//   bool _isFocused5 = false;
//   bool _isFocused6 = false;
//   bool _isFocused7 = false;
//   bool _isFocused8 = false;
//   bool _isFocused9 = false;
//   bool _isFocused10 = false;
//   bool _isFocused11 = false;
//   bool _isFocused12 = false;
//   bool _isFocused13 = false;
//   bool _isFocused14 = false;
//   bool _isFocused15 = false;
//   bool _isFocused16 = false;
//   bool _isFocused17 = false;
//   bool _isFocused18 = false;
//   bool _isFocused19 = false;
//   bool _isFocused20 = false;
//   bool _isFocused21 = false;
//   bool _isFocused22 = false;
//   bool _isFocused23 = false;
//   bool _isFocused24 = false;
//   bool _isFocused25 = false;
//   bool _isFocused26 = false;
//   bool _isFocused27 = false;
//   bool _isFocused28 = false;
//   bool _isFocused29 = false;
//
//   final _formKey = GlobalKey<FormState>();
// //----------------------------payment mode data start---------------
//   bool _checkBoxValue = false;
//
//   String name = '';
//   String storeName = '';
//   String legalBusinessName = '';
//   String storeDetails = '';
//   String storeAddress = '';
//   String getLocation = '';
//   String referalCode = '';
//   String latitude = '';
//   String longitude = '';
//   String country = '';
//   String state = '';
//   String city = '';
//   String email = '';
//   String contactNo = '';
//   String contactNoOptional = '';
//   String landMark = '';
//   String pinCode = '';
//   String? _shopRegisterNumber ;
//   String? _sellOrRent;
//   String? _deliveryMode;
//   String registrationNoType = '';
//   String registrationNo2 = '';
//   String registrationDocs = '';
//   String storeLogo = '';
//   String storeBanner = '';
//   String dealsIN = '';
//   String metaTitle = '';
//   String metaKeyWord = '';
//   String metaDesc = '';
//   String designation = '';
//   String yoe = '';
//
//   get valuefirst => null;
//
//   TextEditingController nameController = TextEditingController();
//   TextEditingController storeNameController = TextEditingController();
//   TextEditingController legalBusinessNameController = TextEditingController();
//   TextEditingController storeSlugController = TextEditingController();
//   TextEditingController storeDetailController = TextEditingController();
//   TextEditingController storeAddressController = TextEditingController();
//   TextEditingController storeLocAddressController = TextEditingController();
//   TextEditingController referralCodeController = TextEditingController();
//   TextEditingController storeLatitudeCodeController = TextEditingController();
//   TextEditingController storeLongitudeCodeController = TextEditingController();
//   TextEditingController countryIdCodeController = TextEditingController();
//   TextEditingController stateIdCodeController = TextEditingController();
//   TextEditingController cityIdCodeController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController designationController = TextEditingController();
//   TextEditingController contactNoController = TextEditingController();
//   TextEditingController contactNoOptController = TextEditingController();
//   TextEditingController scRegistrationTypeController = TextEditingController();
//   TextEditingController gstNoController = TextEditingController();
//   TextEditingController scRegistrationFileController = TextEditingController();
//   TextEditingController storeLogoNameController = TextEditingController();
//   TextEditingController storeBannerNameController = TextEditingController();
//   TextEditingController dealsInController = TextEditingController();
//   TextEditingController metaTitleController = TextEditingController();
//   TextEditingController metaKeywordController = TextEditingController();
//   TextEditingController metaDescriptionController = TextEditingController();
//   TextEditingController landmarkController = TextEditingController();
//   TextEditingController pincodeController = TextEditingController();
//   TextEditingController yoeController = TextEditingController();
//   TextEditingController buyOrRentController = TextEditingController();
//   TextEditingController deliveryModeController = TextEditingController();
//   //----------------------------------payment mode controller ---------
//   TextEditingController paymentModesAcceptedController = TextEditingController();
//
//
//   @override
//   void initState() {
//     super.initState();
//
//     _focusNode.addListener(() {
//       setState(() {
//         _isFocused = _focusNode.hasFocus;
//       });
//     });
//     _focusNode1.addListener(() {
//       setState(() {
//         _isFocused1 = _focusNode1.hasFocus;
//       });
//     });
//
//     _focusNode2.addListener(() {
//       setState(() {
//         _isFocused2 = _focusNode2.hasFocus;
//       });
//     });
//
//     _focusNode3.addListener(() {
//       setState(() {
//         _isFocused3 = _focusNode3.hasFocus;
//       });
//     });
//
//     _focusNode4.addListener(() {
//       setState(() {
//         _isFocused4 = _focusNode4.hasFocus;
//       });
//     });
//
//     _focusNode5.addListener(() {
//       setState(() {
//         _isFocused5 = _focusNode5.hasFocus;
//       });
//     });
//
//     _focusNode6.addListener(() {
//       setState(() {
//         _isFocused6 = _focusNode6.hasFocus;
//       });
//     });
//
//     _focusNode7.addListener(() {
//       setState(() {
//         _isFocused7 = _focusNode7.hasFocus;
//       });
//     });
//
//     _focusNode8.addListener(() {
//       setState(() {
//         _isFocused8 = _focusNode8.hasFocus;
//       });
//     });
//     _focusNode9.addListener(() {
//       setState(() {
//         _isFocused9 = _focusNode9.hasFocus;
//       });
//     });
//     _focusNode10.addListener(() {
//       setState(() {
//         _isFocused10 = _focusNode10.hasFocus;
//       });
//     });
//     _focusNode11.addListener(() {
//       setState(() {
//         _isFocused11 = _focusNode11.hasFocus;
//       });
//     });
//     _focusNode12.addListener(() {
//       setState(() {
//         _isFocused12 = _focusNode12.hasFocus;
//       });
//     });
//     _focusNode13.addListener(() {
//       setState(() {
//         _isFocused13 = _focusNode13.hasFocus;
//       });
//     });
//     _focusNode14.addListener(() {
//       setState(() {
//         _isFocused14 = _focusNode14.hasFocus;
//       });
//     });
//     _focusNode15.addListener(() {
//       setState(() {
//         _isFocused15 = _focusNode15.hasFocus;
//       });
//     });
//     _focusNode16.addListener(() {
//       setState(() {
//         _isFocused16 = _focusNode16.hasFocus;
//       });
//     });
//     _focusNode17.addListener(() {
//       setState(() {
//         _isFocused17 = _focusNode17.hasFocus;
//       });
//     });
//     _focusNode18.addListener(() {
//       setState(() {
//         _isFocused18 = _focusNode18.hasFocus;
//       });
//     });
//     _focusNode19.addListener(() {
//       setState(() {
//         _isFocused19 = _focusNode19.hasFocus;
//       });
//     });
//     _focusNode20.addListener(() {
//       setState(() {
//         _isFocused20 = _focusNode20.hasFocus;
//       });
//     });
//     _focusNode21.addListener(() {
//       setState(() {
//         _isFocused21 = _focusNode21.hasFocus;
//       });
//     });
//     _focusNode22.addListener(() {
//       setState(() {
//         _isFocused22 = _focusNode22.hasFocus;
//       });
//     });
//     _focusNode23.addListener(() {
//       setState(() {_isFocused23 = _focusNode23.hasFocus;
//       });
//     });
//     _focusNode24.addListener(() {
//       setState(() {_isFocused24 = _focusNode24.hasFocus;
//       });
//     });
//     _focusNode25.addListener(() {
//       setState(() {_isFocused25 = _focusNode25.hasFocus;
//       });
//     });
//     _focusNode26.addListener(() {
//       setState(() {_isFocused26 = _focusNode26.hasFocus;
//       });
//     });
//     _focusNode27.addListener(() {
//       setState(() {_isFocused27 = _focusNode27.hasFocus;
//       });
//     });
//     _focusNode28.addListener(() {
//       setState(() {_isFocused28 = _focusNode28.hasFocus;
//       });
//     });
//     _focusNode29.addListener(() {
//       setState(() {_isFocused29 = _focusNode29.hasFocus;
//       });
//     });
//     fetchPreview();
//   }
//
//   var userId;
//   var tokenAccess;
//
// //-----------------------Api Data Start------------------
//
//   bool isLoading = false;
//   PreRegistration? preRegistration;
//   List<UserInfo> userInfo = [];
//   List<Seller> SellerInfo = [];
// //--------------this preview api Start--------------------
//   fetchPreview() async {
//     try {
//       setState(() {
//         isLoading = true;
//       });
//       //  isLoading = true;
//       SharedPreferences preference = await SharedPreferences.getInstance();
//       tokenAccess = preference.getString("access-token");
//
//       userId = preference.getString("userId");
//       final body = {
//         "user_id": userId,
//       };
//       print("body data $body");
//       final response = await Dio().post(
//         "${ConstantUrls.baseUriApi}${ConstantUrls.registrationPreviewApi}",
//         options: Options(
//           headers: {
//             "Authorization": tokenAccess,
//             'Content-Type': 'application/json',
//           },
//         ),
//         data: json.encode(body),
//       );
//       if (response.statusCode == 200) {
//         // final responseData = response.data;
//         var responseData = json.decode(response.data.toString());
//         print("responseData ------------${responseData}");
//         preRegistration = PreRegistration.fromJson(responseData);
//         nameController.text = preRegistration!.data!.userInfo!.firstName.toString();
//         storeNameController.text = preRegistration!.data!.seller!.storeName.toString();
//         legalBusinessNameController.text = preRegistration!.data!.seller!.legalBusinessName.toString();
//         storeSlugController.text = preRegistration!.data!.seller!.storeSlug.toString();
//         storeDetailController.text = preRegistration!.data!.seller!.storeDescription.toString();
//         storeAddressController.text = preRegistration!.data!.seller!.storeAddress.toString();
//         storeLocAddressController.text = preRegistration!.data!.seller!.storeLocAddress.toString();
//         referralCodeController.text = preRegistration!.data!.seller!.referralCode.toString();
//         storeLatitudeCodeController.text = preRegistration!.data!.seller!.storeLatitude.toString();
//         storeLongitudeCodeController.text = preRegistration!.data!.seller!.storeLongitude.toString();
//         countryIdCodeController.text = preRegistration!.data!.seller!.countryId.toString();
//         stateIdCodeController.text = preRegistration!.data!.seller!.stateId.toString();
//         cityIdCodeController.text = preRegistration!.data!.seller!.cityId.toString();
//         emailController.text = preRegistration!.data!.seller!.email.toString();
//         contactNoController.text = preRegistration!.data!.seller!.contactNo.toString();
//         contactNoOptController.text = preRegistration!.data!.seller!.contactNoOpt.toString();
//         gstNoController.text = preRegistration!.data!.seller!.gstNo.toString();
//         scRegistrationFileController.text = preRegistration!.data!.seller!.scRegistrationFile.toString();
//         storeLogoNameController.text = preRegistration!.data!.seller!.storeLogoName.toString();
//         storeBannerNameController.text = preRegistration!.data!.seller!.storeBannerName.toString();
//         dealsInController.text = preRegistration!.data!.seller!.dealsIn.toString();
//         metaTitleController.text = preRegistration!.data!.seller!.metaTitle.toString();
//         metaKeywordController.text = preRegistration!.data!.seller!.metaKeyword.toString();
//         metaDescriptionController.text = preRegistration!.data!.seller!.metaDescription.toString();
//         landmarkController.text = preRegistration!.data!.seller!.landmark.toString();
//         pincodeController.text = preRegistration!.data!.seller!.pincode.toString();
//         designationController.text = preRegistration!.data!.seller!.designation.toString();
//         yoeController.text = preRegistration!.data!.seller!.yearOfEstablishment.toString();
//         scRegistrationTypeController.text = preRegistration!.data!.seller!.scRegistrationType.toString();
//         buyOrRentController.text = preRegistration!.data!.seller!.buyOrRent.toString();
//         deliveryModeController.text = preRegistration!.data!.seller!.deliveryMode.toString();
//         // Extract payment modes accepted and split them by a separator (e.g., comma)
//         List<String> paymentModesAccepted = preRegistration!.data!.seller!.paymentModesAccepted!.split(',');
//         // Add the extracted payment modes to selectedPaymentModes list
//         selectedPaymentModes.addAll(paymentModesAccepted);
//         // paymentModesAcceptedController.text = preRegistration!.data!.seller!.paymentModesAccepted.toString();
//         print("text ---------------${paymentModesAcceptedController.text}");
//
//         setState(() {
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           isLoading = false;
//         });
//       }
//     } catch (error) {
//       throw Exception('Failed to fetch data');
//     }
//   }
// //--------------this preview api End--------------------
//
// //--------------this registration_stap_fust api Start---------
//   fetchRegistrationFirst({newStore, addressLoc, landmark, pinCode,
//     latitudeFist, longitudeFist,countryFist, stateFist,cityFist,buildingAddress,legalBusName }) async {
//     try {
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             content: Row(
//               children: [
//                 const CircularProgressIndicator(
//                   color: ConstantColor.primaryMainColor,
//                 ),
//                 const SizedBox(width: 20),
//                 Text(
//                   'Loading...',
//                   style: ConstantTextStyle.allHomeScreenAvatarText,
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//       //  isLoading = true;
//       SharedPreferences preference = await SharedPreferences.getInstance();
//       tokenAccess = preference.getString("access-token");
//
//       userId = preference.getString("userId");
//       final body =
//       {
//         "business_name": newStore,
//         "legal_business_name": legalBusName,
//         "building": buildingAddress,
//         "saddress_loc": addressLoc,
//         "landmark": landmark,
//         "latitude": latitudeFist,
//         "longitude": longitudeFist,
//         "country": countryFist,
//         "state": stateFist,
//         "city": cityFist,
//         "pincode": pinCode,
//       };
//       print("body data $body");
//       final response = await Dio().post(
//         "${ConstantUrls.baseUriApi}${ConstantUrls.registrationFirstApi}",
//         options: Options(
//           headers: {
//             "Authorization": tokenAccess,
//             'Content-Type': 'application/json',
//           },
//         ),
//         data: json.encode(body),
//       );
//       Navigator.pop(context);
//       if (response.statusCode == 200) {
//         // final responseData = response.data;
//         var responseData = json.decode(response.data.toString());
//         print("responseData ------------${responseData}");
//
//         // rfCodeController.text=getProfileData!.data!.roleId.toString();
//       } else {}
//     } catch (error) {
//       throw Exception('Failed to fetch data');
//     }
//   }
// //--------------this registration_stap_fust api End---------
// //--------------this registration_stap_Second api Start---------
//   fetchRegistrationSecond({
//     String? contactPersonName,
//     String? designationPerson,
//     String? referralCode,
//     String? whatsappNumber,
//     String? emailId,
//     String? mobileNo,
//     String? scRegno,
//     String? scOtherType,
//     String? gstNo,
//     String? regDocumentValue,
//     String? buyOrRent,
//     String? deliveryMode,
//     String? storeDescription,
//   }) async {
//     try {
//       // Create FormData object to send form data
//       FormData formData = FormData.fromMap({
//         "contact_person": contactPersonName,
//         "designation": designationPerson ?? '',
//         "referral_code": referralCode ?? '',
//         "whatsapp_number": whatsappNumber ?? '',
//         "email_id": emailId ?? '',
//         "mobile": mobileNo ?? '',
//         "sc_regno": scRegno ?? '',
//         "sc_other_type": scOtherType ?? '',
//         "gst_no": gstNo ?? '',
//         "reg_document_value": regDocumentValue ?? '',
//         "buy_or_rent": buyOrRent ?? '',
//         "delivery_mode": deliveryMode ?? '',
//         "store_description": storeDescription ?? '',
//       });
//       print("formData: $formData");
//
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             content: Row(
//               children: [
//                 const CircularProgressIndicator(
//                   color: ConstantColor.primaryMainColor,
//                 ),
//                 const SizedBox(width: 20),
//                 Text(
//                   'Loading...',
//                   style: ConstantTextStyle.allHomeScreenAvatarText,
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//
//       SharedPreferences preference = await SharedPreferences.getInstance();
//       tokenAccess = preference.getString("access-token");
//       userId = preference.getString("userId");
//
//       final response = await Dio().post(
//         "${ConstantUrls.baseUriApi}${ConstantUrls.registrationSecondtApi}",
//         options: Options(
//           headers: {
//             "Authorization": tokenAccess,
//           },
//         ),
//         data: formData, // Use formData to send the form data
//       );
//
//       Navigator.pop(context);
//
//       if (response.statusCode == 200) {
//         var responseData = response.data;
//         print("responseData second: $responseData");
//
//         if (responseData['status'] == 'error') {
//           // Handle the API error message
//           var errorMessage = responseData['msg'];
//           print('API Error: $errorMessage');
//           // You can display the error message to the user or take appropriate action.
//         } else {
//           // Handle a successful response
//         }
//       } else {
//         // Handle other status codes as needed
//         print('API Request Failed with Status Code: ${response.statusCode}');
//       }
//
//     } catch (error) {
//       throw Exception('Failed to fetch data');
//     }
//   }
//
//
//   List<String> selectedPaymentModes = [];
//   List<String> paymentTextName = [
//     "Cash",
//     "Money Orders",
//     "G Pay",
//     'Payumoney',
//     'RuPay Card',
//     'Master Card',
//     'Cheques',
//     'UPI',
//     'PhonePe',
//     'Visa Card',
//     'Credit Card',
//     'BHIM',
//     'NEFT',
//     'Debit Cards',
//     'Paytm',
//     'Cash on Delivery',
//     'Pockets by ICICI',
//   ];
//   bool selectAllChecked = false;
//   void updateSelectedPaymentMode(String paymentMode, bool isChecked) {
//     setState(() {
//       if (isChecked) {
//         selectedPaymentModes.add(paymentMode);
//       } else {
//         selectedPaymentModes.remove(paymentMode);
//       }
//     });
//   }
//   //-------------------payment checkbox list--------
//
// //---------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     var screenHeight = MediaQuery.of(context).size.height;
//     var screenWidth = MediaQuery.of(context).size.width;
//     print("DAta -------------$selectedPaymentModes--");
//     return Scaffold(
// /*--------------------------------------appbar section start-------------------------------------*/
//       key: _scaffoldKey,
//       appBar: AppBar(
//         elevation: 1,
//         backgroundColor: ConstantColor.primaryBackgroundMainColor,
//         iconTheme: const IconThemeData(color: ConstantColor.loginWithOtpButtonColor),
//         title: customeText(textAlign: TextAlign.start,
//             text: "Become a Seller", style: ConstantTextStyle.secodHearText),
//       ),
// /*--------------------------------------appbar section end-------------------------------------*/
//       body: Container(
//         padding: EdgeInsets.only(
//           top: screenHeight /100,
//         ),
//         color: ConstantColor.secondryBackgroundMainColor,
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: screenWidth/40),
//                 child: customeText(
//                   text: "Sing Up your seller Account".toUpperCase(),
//                   textAlign: TextAlign.start,
//                   style: ConstantTextStyle.cardbottumText,
//                 ),
//               ),
//               SizedBox(height: screenHeight/80,),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: screenWidth/40),
//                 child: customeText(
//                   text:"Lorem ipsum is a pseudo-Latin text used in web design, typography, layout and printing.\n\n",
//                   textAlign: TextAlign.start,
//                   style: ConstantTextStyle.becomeSellerDiscText,
//                 ),
//               ),
//               Flexible(
//                 child: Theme(
//           data: ThemeData(
//             // canvasColor: Colors.yellow,
//             colorScheme: Theme.of(context).colorScheme.copyWith(
//               primary: ConstantColor.primaryMainColor,
//             ),
//           ),
//                   child: Stepper(
//                     elevation: 0,
//                     margin: EdgeInsets.all(0),
//                     type: stepperType,
//                     physics: BouncingScrollPhysics(),
//                     currentStep: _currentStep,
//                     onStepTapped: (step) => tapped(step),
//                     onStepContinue: continued,
//                     onStepCancel: cancel,
//                     steps: [
// //-----------------------------------Step 1 start--------------------------------------
//                       Step(
//                         title: Text('Personal'),
//                         content: Column(
//                           children: [
//
// /*--------------------------Store Name filed start----------------------------------*/
//
//                             loginTextFormField2(
//                               controller: storeNameController,
//                               // initialValue: userInfo.isNotEmpty ? userInfo[0].username : '',
//                               textFormPaddingHorizontal: screenWidth / 40,
//                               textFormPaddingVertical: screenHeight / 60,
//                               minLines: 1,
//                               maxLines: 1,
//                               borderSideColor: _isFocused
//                                   ? ConstantColor.primaryMainColor
//                                   : ConstantColor.transparent1,
//                               focusNode: _focusNode,
//                               context: context,
//                               fillColor:
//                               ConstantColor.primaryBackgroundMainColor,
//                               filled: true,
//                               enabled: true,
//                               iconButton: IconButton,
//                               hintText: "Store Name",
//                               hintStyle:
//                               ConstantTextStyle.sellerHintTextStyle,
//                               labelText: "Store Name",
//                               labelStyle: ConstantTextStyle.lableTextStyle,
//                               cursorColor: ConstantColor.primaryMainColor,
//                               keyboardType: TextInputType.name,
//                               validator: (value) {
//                                 if (value.isEmpty) {
//                                   return 'This field is required';
//                                 }
//                                 // You can add additional validation logic here if needed.
//                                 return null; // Return null if the input is valid.
//                               },
//                               onChanged: (value) {
//                                 setState(() {
//                                   storeName = value;
//                                 });
//                               },
// /*--------------------------Store Name filed Update button start----------------------------------*/
//                               suffixIcon: Padding(
//                                 padding: EdgeInsets.only(
//                                   right: screenWidth / 40,
//                                   top: screenWidth / 60,
//                                   bottom: screenWidth / 60,
//                                 ),
//                                 child: customeButton(
//                                   textStyleButton:
//                                   ConstantTextStyle.loginButtonTextStyle,
//                                   onPressed: () {},
//                                   text: "Update",
//                                   backgroundColor:
//                                   ConstantColor.primaryMainColor,
//                                   borderRadius: BorderRadius.circular(8.0),
//                                   elevation: 3.0,
//                                 ),
//                               ),
//                             ),
// /*-------------------------Store Name filed Update button end----------------------------------*/
//                             SizedBox(height: screenHeight / 50),
// /*------------------------Legal Business Name field start----------------------------------*/
//                             loginTextFormField2(
//                               controller: legalBusinessNameController,
//                               textFormPaddingHorizontal: screenWidth / 40,
//                               textFormPaddingVertical: screenHeight / 40,
//                               minLines: 1,
//                               maxLines: 1,
//                               borderSideColor: _isFocused29
//                                   ? ConstantColor.primaryMainColor
//                                   : ConstantColor.transparent1,
//                               focusNode: _focusNode29,
//                               context: context,
//                               fillColor: ConstantColor.primaryBackgroundMainColor,
//                               filled: true,
//                               iconButton: IconButton,
//                               hintText: "Legal Business Name",
//                               hintStyle: ConstantTextStyle.sellerHintTextStyle,
//                               labelText: "Legal Business Name",
//                               labelStyle: ConstantTextStyle.lableTextStyle,
//                               cursorColor: ConstantColor.primaryMainColor,
//                               keyboardType: TextInputType.multiline,
//                               onChanged: (value) {
//                                 setState(() {
//                                   legalBusinessName = value;
//                                 });
//                               },
//                             ),
// /*--------------------------Legal Business Name field end----------------------------------*/
//                             SizedBox(height: screenHeight / 50),
// /*------------------------------Store Slug field start----------------------------------*/
//                             loginTextFormField2(
//                               controller: storeSlugController,
//                               textFormPaddingHorizontal: screenWidth / 40,
//                               textFormPaddingVertical: screenHeight / 60,
//                               minLines: 1,
//                               maxLines: 1,
//                               borderSideColor: ConstantColor.transparent1,
//                               context: context,
//                               fillColor:
//                               ConstantColor.textformFieldDisableColor,
//                               filled: true,
//                               enabled: false,
//                               iconButton: IconButton,
//                               hintText: "Store Slug",
//                               hintStyle:
//                               ConstantTextStyle.sellerHintTextStyle,
//                               labelText: "Store Slug",
//                               labelStyle: ConstantTextStyle.lableTextStyle,
//                               cursorColor: ConstantColor.primaryMainColor,
//                               //   keyboardType: TextInputType.multiline,
//                               onChanged: (value) {
//                                 setState(() {
//                                   latitude = value;
//                                 });
//                               },
//                             ),
// /*------------------------------Store Slug field end----------------------------------*/
//                             SizedBox(height: screenHeight / 50),
// /*------------------------------Store Address field start----------------------------------*/
//                             loginTextFormField2(
//                               controller: storeAddressController,
//                               textFormPaddingHorizontal: screenWidth / 40,
//                               textFormPaddingVertical: screenHeight / 40,
//                               minLines: 1,
//                               maxLines: 1,
//                               borderSideColor: _isFocused2
//                                   ? ConstantColor.primaryMainColor
//                                   : ConstantColor.transparent1,
//                               focusNode: _focusNode2,
//                               context: context,
//                               fillColor: ConstantColor.primaryBackgroundMainColor,
//                               filled: true,
//                               iconButton: IconButton,
//                               hintText: "Store Address",
//                               hintStyle: ConstantTextStyle.sellerHintTextStyle,
//                               labelText: "Store Address",
//                               labelStyle: ConstantTextStyle.lableTextStyle,
//                               cursorColor: ConstantColor.primaryMainColor,
//                               keyboardType: TextInputType.multiline,
//                               onChanged: (value) {
//                                 setState(() {
//                                   storeAddress = value;
//                                 });
//                               },
//                             ),
// /*------------------------------Store Address field end----------------------------------*/
//                             SizedBox(height: screenHeight / 50),
// /*------------------------------Store Location field start----------------------------------*/
//
//                             SizedBox(height: screenHeight / 50),
//                             loginTextFormField2(
//                               controller: storeLocAddressController,
//                               textFormPaddingHorizontal: screenWidth / 40,
//                               textFormPaddingVertical: screenHeight / 50,
//                               minLines: 1,
//                               maxLines: 1,
//                               borderSideColor: _isFocused3
//                                   ? ConstantColor.primaryMainColor
//                                   : ConstantColor.transparent1,
//                               focusNode: _focusNode3,
//                               context: context,
//                               fillColor: ConstantColor.primaryBackgroundMainColor,
//                               filled: true,
//                               iconButton: IconButton,
//                               hintText: "Location",
//                               hintStyle: ConstantTextStyle.sellerHintTextStyle,
//                               labelText: "Location",
//                               labelStyle: ConstantTextStyle.lableTextStyle,
//                               cursorColor: ConstantColor.primaryMainColor,
//                               keyboardType: TextInputType.name,
//                               onChanged: (value) {
//                                 setState(() {
//                                   getLocation = value;
//                                 });
//                               },
//                               suffixIcon: Padding(
//                                 padding: EdgeInsets.only(
//                                   right: screenWidth / 40,
//                                   top: screenWidth / 40,
//                                   bottom: screenWidth / 40,
//                                 ),
//                                 child: customeButton(
//                                   textStyleButton: ConstantTextStyle.loginButtonTextStyle,
//                                   onPressed: () async {
//                                     try {
//                                       print("Button pressed");
//                                       // Call a function to get the current location
//                                       String currentLocation = await getCurrentLocation();
//                                       List<String> locationParts = currentLocation.split(", ");
//                                       if (locationParts.length >= 4) {
//                                         city = locationParts[1];
//                                         state = locationParts[2];
//                                       }
//
//                                       setState(() {
//                                         storeLocAddressController.text = currentLocation;
//                                         cityIdCodeController.text = city;
//                                         stateIdCodeController.text = state;
//                                       });
//                                     } catch (e) {
//                                       print("Error getting location: $e");
//                                     }
//                                   },
//                                   text: "Get Location",
//                                   backgroundColor: ConstantColor.primaryMainColor,
//                                   borderRadius: BorderRadius.circular(8.0),
//                                   elevation: 3.0,
//                                 ),
//                               ),
//                             ),
//
// /*------------------------------Store Location field end----------------------------------*/
//                             SizedBox(height: screenHeight / 50),
// /*------------------------------LandMark field start----------------------------------*/
//                             Row(
//                               children: [
//                                 Flexible(
//                                   child: loginTextFormField2(
//                                     controller: landmarkController,
//                                     textFormPaddingHorizontal: screenWidth / 40,
//                                     textFormPaddingVertical: screenHeight / 40,
//                                     minLines: 1,
//                                     maxLines: 1,
//                                     borderSideColor: _isFocused24
//                                         ? ConstantColor.primaryMainColor
//                                         : ConstantColor.transparent1,
//                                     focusNode: _focusNode24,
//                                     context: context,
//                                     fillColor:
//                                     ConstantColor.primaryBackgroundMainColor,
//                                     filled: true,
//                                     enabled: true,
//                                     iconButton: IconButton,
//                                     hintText: "LandMark",
//                                     hintStyle:
//                                     ConstantTextStyle.sellerHintTextStyle,
//                                     labelText: "LandMark",
//                                     labelStyle: ConstantTextStyle.lableTextStyle,
//                                     cursorColor: ConstantColor.primaryMainColor,
//                                     keyboardType: TextInputType.text,
//                                     onChanged: (value) {
//                                       setState(() {
//                                         landMark = value;
//                                       });
//                                     },
//                                   ),
//                                 ),
// /*------------------------------LandMark field end----------------------------------*/
//
//                                 SizedBox(width: screenWidth / 30),
// /*-----------------------------Pincode field  start----------------------------------*/
//
//                                 Flexible(
//                                   child: loginTextFormField2(
//                                     controller: pincodeController,
//                                     textFormPaddingHorizontal: screenWidth / 40,
//                                     textFormPaddingVertical: screenHeight / 40,
//                                     minLines: 1,
//                                     maxLines: 1,
//                                     borderSideColor: _isFocused25
//                                         ? ConstantColor.primaryMainColor
//                                         : ConstantColor.transparent1,
//                                     focusNode: _focusNode25,
//                                     context: context,
//                                     fillColor:
//                                     ConstantColor.primaryBackgroundMainColor,
//                                     filled: true,
//                                     enabled: true,
//                                     iconButton: IconButton,
//                                     hintText: "Pincode",
//                                     hintStyle:
//                                     ConstantTextStyle.sellerHintTextStyle,
//                                     labelText: "Pincode",
//                                     labelStyle: ConstantTextStyle.lableTextStyle,
//                                     cursorColor: ConstantColor.primaryMainColor,
//                                     keyboardType: TextInputType.number,
//                                     onChanged: (value) {
//                                       setState(() {
//                                         pinCode = value;
//                                       });
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
// /*--------------------------Pincode field  end----------------------------------*/
//                             SizedBox(height: screenHeight / 50),
// /*------------------------------City field start----------------------------------*/
//                             Row(
//                               children: [
//                                 Flexible(
//                                   child: loginTextFormField2(
//                                     controller: cityIdCodeController,
//                                     textFormPaddingHorizontal: screenWidth / 40,
//                                     textFormPaddingVertical: screenHeight / 60,
//                                     minLines: 1,
//                                     maxLines: 1,
//                                     borderSideColor: _isFocused9
//                                         ? ConstantColor.primaryMainColor
//                                         : ConstantColor.transparent1,
//                                     focusNode: _focusNode9,
//                                     context: context,
//                                     fillColor:
//                                     ConstantColor.textformFieldDisableColor,
//                                     filled: true,
//                                     enabled: false,
//                                     iconButton: IconButton,
//                                     hintText: "City",
//                                     hintStyle:
//                                     ConstantTextStyle.sellerHintTextStyle,
//                                     labelText: "City",
//                                     labelStyle: ConstantTextStyle.lableTextStyle,
//                                     cursorColor: ConstantColor.primaryMainColor,
//                                     //   keyboardType: TextInputType.multiline,
//                                     onChanged: (value) {
//                                       setState(() {
//                                         city = value;
//                                       });
//                                     },
//                                   ),
//                                 ),
//
// /*------------------------------City field end----------------------------------*/
//                                 SizedBox(width: screenWidth / 30,),
// /*-----------------------------State- field start----------------------------------*/
//                                 Flexible(
//                                   child: loginTextFormField2(
//                                     controller: stateIdCodeController,
//                                     textFormPaddingHorizontal: screenWidth / 40,
//                                     textFormPaddingVertical: screenHeight / 60,
//                                     minLines: 1,
//                                     maxLines: 1,
//                                     borderSideColor: _isFocused8
//                                         ? ConstantColor.primaryMainColor
//                                         : ConstantColor.transparent1,
//                                     focusNode: _focusNode8,
//                                     context: context,
//                                     fillColor:
//                                     ConstantColor.textformFieldDisableColor,
//                                     filled: true,
//                                     enabled: false,
//                                     iconButton: IconButton,
//                                     hintText: "State",
//                                     hintStyle:
//                                     ConstantTextStyle.sellerHintTextStyle,
//                                     labelText: "State",
//                                     labelStyle: ConstantTextStyle.lableTextStyle,
//                                     cursorColor: ConstantColor.primaryMainColor,
//                                     //  keyboardType: TextInputType.multiline,
//                                     onChanged: (value) {
//                                       setState(() {
//                                         state = value;
//                                       });
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
// /*------------------------------State field End----------------------------------*/
//                             SizedBox(height: screenHeight / 50),
// /*------------------------------Referal Code field start----------------------------------*/
//                             Row(
//                               children: [
//                                 Flexible(
//                                   child: loginTextFormField2(
//                                     controller: referralCodeController,
//                                     textFormPaddingHorizontal: screenWidth / 40,
//                                     textFormPaddingVertical: screenHeight / 45,
//                                     minLines: 1,
//                                     maxLines: 1,
//                                     borderSideColor: _isFocused4
//                                         ? ConstantColor.primaryMainColor
//                                         : ConstantColor.transparent1,
//                                     focusNode: _focusNode4,
//                                     context: context,
//                                     fillColor:
//                                     ConstantColor.primaryBackgroundMainColor,
//                                     filled: true,
//                                     iconButton: IconButton,
//                                     hintText: "Referal Code",
//                                     hintStyle:
//                                     ConstantTextStyle.sellerHintTextStyle,
//                                     labelText: "Referal Code",
//                                     labelStyle: ConstantTextStyle.lableTextStyle,
//                                     cursorColor: ConstantColor.primaryMainColor,
//                                     keyboardType: TextInputType.number,
//                                     onChanged: (value) {
//                                       setState(() {
//                                         referalCode = value;
//                                       });
//                                     },
//                                   ),
//                                 ),
// /*------------------------------Referal Code field start----------------------------------*/
//                                 SizedBox(width: screenWidth / 30,),
// /*----------------------------Country field start----------------------------------*/
//                                 Flexible(
//                                   child: loginTextFormField2(
//                                     controller: countryIdCodeController,
//                                     textFormPaddingHorizontal: screenWidth / 40,
//                                     textFormPaddingVertical: screenHeight / 60,
//                                     minLines: 1,
//                                     maxLines: 1,
//                                     borderSideColor: _isFocused7
//                                         ? ConstantColor.primaryMainColor
//                                         : ConstantColor.transparent1,
//                                     focusNode: _focusNode7,
//                                     context: context,
//                                     fillColor:
//                                     ConstantColor.textformFieldDisableColor,
//                                     filled: true,
//                                     enabled: false,
//                                     iconButton: IconButton,
//                                     hintText: "Country",
//                                     hintStyle:
//                                     ConstantTextStyle.sellerHintTextStyle,
//                                     labelText: "Country",
//                                     labelStyle: ConstantTextStyle.lableTextStyle,
//                                     cursorColor: ConstantColor.primaryMainColor,
//                                     //   keyboardType: TextInputType.multiline,
//                                     onChanged: (value) {
//                                       setState(() {
//                                         country = value;
//                                       });
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
// /*------------------------------Country field  end----------------------------------*/
//                             SizedBox(height: screenHeight / 50),
//                           ],
//                         ),
//                         isActive: _currentStep >= 0,
//                         state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
//                       ),
// //-----------------------------------Step 1 End--------------------------------------
// //-----------------------------------Step 2 Start--------------------------------------
//                       Step(
//                         title: Text('Store'),
//                         content: Column(
//                           children: [
//
//
//  /*---------------------Contact Person field start----------------------------------*/
//                           loginTextFormField2(
//                           controller: nameController,
//                           textFormPaddingHorizontal: screenWidth / 40,
//                           textFormPaddingVertical: screenHeight / 40,
//                           minLines: 1,
//                           maxLines: 1,
//                           borderSideColor: _isFocused26
//                               ? ConstantColor.primaryMainColor
//                               : ConstantColor.transparent1,
//                           focusNode: _focusNode26,
//                           context: context,
//                           fillColor: ConstantColor.primaryBackgroundMainColor,
//                           filled: true,
//                           iconButton: IconButton,
//                           hintText: "Person Name",
//                           //    helperText: 'Example: john@example.com',
//
//                           hintStyle: ConstantTextStyle.sellerHintTextStyle,
//                           labelText: "Person Name",
//                           labelStyle: ConstantTextStyle.lableTextStyle,
//                           cursorColor: ConstantColor.primaryMainColor,
//                           keyboardType: TextInputType.name,
//                           // validator: (value) {
//                           //   if (value.isEmpty) {
//                           //     return 'Please enter an email address';
//                           //   }
//                           //   // Regular expression pattern for email validation
//                           //   String emailPattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
//                           //   RegExp regex = RegExp(emailPattern);
//                           //   if (!regex.hasMatch(value)) {
//                           //     return 'Please enter a valid email address';
//                           //   }
//                           //   return null;
//                           // },
//                           onChanged: (value) {
//                             setState(() {
//                               name = value;
//                             });
//                           },
//                         ),
//
// /*----------------------Contact Person field end----------------------------------*/
//                         SizedBox(height: screenHeight / 50),
// /*---------------------designation  field start----------------------------------*/
//                         loginTextFormField2(
//                           controller: designationController,
//                           textFormPaddingHorizontal: screenWidth / 40,
//                           textFormPaddingVertical: screenHeight / 40,
//                           minLines: 1,
//                           maxLines: 1,
//                           borderSideColor: _isFocused27
//                               ? ConstantColor.primaryMainColor
//                               : ConstantColor.transparent1,
//                           focusNode: _focusNode27,
//                           context: context,
//                           fillColor: ConstantColor.primaryBackgroundMainColor,
//                           filled: true,
//                           iconButton: IconButton,
//                           hintText: "Designation",
//                           //    helperText: 'Example: john@example.com',
//
//                           hintStyle: ConstantTextStyle.sellerHintTextStyle,
//                           labelText: "Designation",
//                           labelStyle: ConstantTextStyle.lableTextStyle,
//                           cursorColor: ConstantColor.primaryMainColor,
//                           keyboardType: TextInputType.name,
//                           // validator: (value) {
//                           //   if (value.isEmpty) {
//                           //     return 'Please enter an email address';
//                           //   }
//                           //   // Regular expression pattern for email validation
//                           //   String emailPattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
//                           //   RegExp regex = RegExp(emailPattern);
//                           //   if (!regex.hasMatch(value)) {
//                           //     return 'Please enter a valid email address';
//                           //   }
//                           //   return null;
//                           // },
//                           onChanged: (value) {
//                             setState(() {
//                               designation = value;
//                             });
//                           },
//                         ),
//
// /*---------------------- designation field end----------------------------------*/
//                         SizedBox(height: screenHeight / 50),
// /*------------------------------Email field start----------------------------------*/
//
//                         loginTextFormField2(
//                           controller: emailController,
//                           textFormPaddingHorizontal: screenWidth / 40,
//                           textFormPaddingVertical: screenHeight / 40,
//                           minLines: 1,
//                           maxLines: 1,
//                           borderSideColor: _isFocused10
//                               ? ConstantColor.primaryMainColor
//                               : ConstantColor.transparent1,
//                           focusNode: _focusNode10,
//                           context: context,
//                           fillColor: ConstantColor.primaryBackgroundMainColor,
//                           filled: true,
//                           iconButton: IconButton,
//                           hintText: "Email",
//                           //    helperText: 'Example: john@example.com',
//
//                           hintStyle: ConstantTextStyle.sellerHintTextStyle,
//                           labelText: "Email",
//                           labelStyle: ConstantTextStyle.lableTextStyle,
//                           cursorColor: ConstantColor.primaryMainColor,
//                           keyboardType: TextInputType.emailAddress,
//                           // validator: (value) {
//                           //   if (value.isEmpty) {
//                           //     return 'Please enter an email address';
//                           //   }
//                           //   // Regular expression pattern for email validation
//                           //   String emailPattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
//                           //   RegExp regex = RegExp(emailPattern);
//                           //   if (!regex.hasMatch(value)) {
//                           //     return 'Please enter a valid email address';
//                           //   }
//                           //   return null;
//                           // },
//                           onChanged: (value) {
//                             setState(() {
//                               email = value;
//                             });
//                           },
//                         ),
//
// /*------------------------------Email field end----------------------------------*/
//                         SizedBox(height: screenHeight / 50),
// /*------------------------------Contact field start----------------------------------*/
//                         Row(
//                           children: [
//                             Flexible(
//                               child: loginTextFormField2(
//                                 controller: contactNoController,
//                                 textFormPaddingHorizontal: screenWidth / 40,
//                                 textFormPaddingVertical: screenHeight / 40,
//                                 minLines: 1,
//                                 maxLines: 1,
//                                 borderSideColor: _isFocused11
//                                     ? ConstantColor.primaryMainColor
//                                     : ConstantColor.transparent1,
//                                 focusNode: _focusNode11,
//                                 context: context,
//                                 fillColor:
//                                 ConstantColor.primaryBackgroundMainColor,
//                                 filled: true,
//                                 enabled: true,
//                                 iconButton: IconButton,
//                                 hintText: "Contact no.",
//                                 hintStyle:
//                                 ConstantTextStyle.sellerHintTextStyle,
//                                 labelText: "Contact no.",
//                                 labelStyle: ConstantTextStyle.lableTextStyle,
//                                 cursorColor: ConstantColor.primaryMainColor,
//                                 keyboardType: TextInputType.number,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     contactNo = value;
//                                   });
//                                 },
//                               ),
//                             ),
// /*------------------------------Contact field end----------------------------------*/
// /*------------------------------Optional Contact field  start----------------------------------*/
//                             Flexible(
//                               child: loginTextFormField2(
//                                 controller: contactNoOptController,
//                                 textFormPaddingHorizontal: screenWidth / 40,
//                                 textFormPaddingVertical: screenHeight / 40,
//                                 minLines: 1,
//                                 maxLines: 1,
//                                 borderSideColor: _isFocused12
//                                     ? ConstantColor.primaryMainColor
//                                     : ConstantColor.transparent1,
//                                 focusNode: _focusNode12,
//                                 context: context,
//                                 fillColor:
//                                 ConstantColor.primaryBackgroundMainColor,
//                                 filled: true,
//                                 enabled: true,
//                                 iconButton: IconButton,
//                                 hintText: "Contact no.",
//                                 hintStyle:
//                                 ConstantTextStyle.sellerHintTextStyle,
//                                 labelText: "Contact no.(Optional)",
//                                 labelStyle: ConstantTextStyle.lableTextStyle,
//                                 cursorColor: ConstantColor.primaryMainColor,
//                                 keyboardType: TextInputType.number,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     contactNoOptional = value;
//                                   });
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
// /*------------------------------Optional Contact field  end----------------------------------*/
//                           SizedBox(height: screenHeight / 50),
// /*-------------------------Registration noType. drop down  start ---------------------------------*/
//                           dropDownForm(
//                             context:context,
//                             widthBorder: _isFocused13
//                                 ? screenWidth / 100
//                                 : screenWidth / 500,
//                             colorBorder: _isFocused13
//                                 ? ConstantColor.primaryMainColor
//                                 : ConstantColor.textFieldColor,
//                             hintText:  scRegistrationTypeController.text.toString(),
//                             headText: 'Shop/Company Registration no.Type',
//                             menuMaxHeightFormField:screenHeight/4,
//                             focusNode: _focusNode13,
//                             value:_shopRegisterNumber,
//                             items: items.map((String value) {
//                               return DropdownMenuItem<String>(
//                                 value: value,
//                                 child: Text(value),
//                               );
//                             }).toList(),
//                             onChanged:(String? newValue) {
//                               setState(() {
//                                 _shopRegisterNumber = newValue;
//                               });
//                             },
//                           ),
// /*-------------------------Registration noType. drop down  end ---------------------------------*/
//                           SizedBox(height: screenHeight / 50),
// /*-------------------------Registration no.  (2) start ---------------------------------*/
//
//                           loginTextFormField2(
//                             controller: gstNoController,
//                             textFormPaddingHorizontal: screenWidth / 40,
//                             textFormPaddingVertical: screenHeight / 40,
//                             minLines: 1,
//                             maxLines: 1,
//                             borderSideColor: _isFocused14
//                                 ? ConstantColor.primaryMainColor
//                                 : ConstantColor.transparent1,
//                             focusNode: _focusNode14,
//                             context: context,
//                             fillColor: ConstantColor.primaryBackgroundMainColor,
//                             filled: true,
//                             iconButton: IconButton,
//                             hintText: "Shop/Company Registration no.",
//                             hintStyle: ConstantTextStyle.sellerHintTextStyle,
//                             labelText: "Shop/Company Registration no.",
//                             labelStyle: ConstantTextStyle.lableTextStyle,
//                             cursorColor: ConstantColor.primaryMainColor,
//                             keyboardType: TextInputType.number,
//                             onChanged: (value) {
//                               setState(() {
//                                 registrationNo2 = value;
//                               });
//                             },
//                           ),
// /*-------------------------Registration no.  (2) end ---------------------------------*/
//                   SizedBox(height: screenHeight/50,),
// /*------------------------------Sell/Provides Buy or rent field start----------------------------------*/
//                             Row(
//                               children: [
//                                 Flexible(
//                                   child: dropDownForm(
//                                     context:context,
//                                     widthBorder: _isFocused19
//                                         ? screenWidth / 100
//                                         : screenWidth / 500,
//                                     colorBorder: _isFocused19
//                                         ? ConstantColor.primaryMainColor
//                                         : ConstantColor.textFieldColor,
//                                     hintText:  buyOrRentController.text.toString(),
//                                     headText: 'Buy on Rent',
//                                     menuMaxHeightFormField:screenHeight/4,
//                                     focusNode: _focusNode19,
//                                     value:_sellOrRent,
//                                     items: items.map((String value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Text(value),
//                                       );
//                                     }).toList(),
//                                     onChanged:(String? newValue) {
//                                       setState(() {
//                                         _sellOrRent = newValue;
//                                       });
//                                     },
//                                   ),
//                                 ),
//
// /*------------------------------Sell/Provide Boy on rent field end----------------------------------*/
//
//                                 SizedBox(width: screenWidth / 30,),
// /*------------------------------Delivery Mode field  start----------------------------------*/
//                                 Flexible(
//                                   child: dropDownForm(
//                                     context:context,
//                                     widthBorder: _isFocused20
//                                         ? screenWidth / 100
//                                         : screenWidth / 500,
//                                     colorBorder: _isFocused20
//                                         ? ConstantColor.primaryMainColor
//                                         : ConstantColor.textFieldColor,
//                                     hintText:  deliveryModeController.text.toString(),
//                                     headText: 'Delivery Mode',
//                                     menuMaxHeightFormField:screenHeight/4,
//                                     focusNode: _focusNode20,
//                                     value:_deliveryMode,
//                                     items: items.map((String value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Text(value),
//                                       );
//                                     }).toList(),
//                                     onChanged:(String? newValue) {
//                                       setState(() {
//                                         _deliveryMode = newValue;
//                                       });
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
// /*------------------------------Delivery Mode field  end----------------------------------*/
//                             SizedBox(height: screenHeight / 50),
// /*------------------------------Store Details field start----------------------------------*/
//                             SizedBox(height: screenHeight / 50),
//                             loginTextFormField2(
//                               controller: storeDetailController,
//                               textFormPaddingHorizontal: screenWidth / 40,
//                               textFormPaddingVertical: screenHeight / 15,
//                               minLines: 1,
//                               maxLines: 1,
//                               borderSideColor: _isFocused1
//                                   ? ConstantColor.primaryMainColor
//                                   : ConstantColor.transparent1,
//                               focusNode: _focusNode1,
//                               context: context,
//                               fillColor: ConstantColor.primaryBackgroundMainColor,
//                               filled: true,
//                               iconButton: IconButton,
//                               hintText: "Store Details",
//                               hintStyle: ConstantTextStyle.sellerHintTextStyle,
//                               labelText: "Store Details",
//                               labelStyle: ConstantTextStyle.lableTextStyle,
//                               cursorColor: ConstantColor.primaryMainColor,
//                               keyboardType: TextInputType.multiline,
//                               onChanged: (value) {
//                                 setState(() {
//                                   storeDetails = value;
//                                 });
//                               },
//                             ),
// /*------------------------------Store Details field end----------------------------------*/
//                             SizedBox(height: screenHeight / 50),
// /*------------------------------Store Registration Docs field start----------------------------------*/
//                             loginTextFormField2(
//                               controller: scRegistrationFileController,
//                               textFormPaddingHorizontal: screenWidth / 40,
//                               textFormPaddingVertical: screenHeight / 40,
//                               minLines: 1,
//                               maxLines: 1,
//                               borderSideColor: _isFocused15
//                                   ? ConstantColor.primaryMainColor
//                                   : ConstantColor.transparent1,
//                               focusNode: _focusNode15,
//                               context: context,
//                               fillColor: ConstantColor.primaryBackgroundMainColor,
//                               filled: true,
//                               iconButton: IconButton,
//                               helperText:
//                               "Upload only (image, pdf, doc, docx) of Max Size 5MB",
//                               hintText: "Upload Registration Documents",
//                               hintStyle: ConstantTextStyle.sellerHintTextStyle,
//                               labelText: "Upload Registration Documents",
//                               labelStyle: ConstantTextStyle.lableTextStyle,
//                               cursorColor: ConstantColor.primaryMainColor,
//                               keyboardType: TextInputType.name,
//                               onChanged: (value) {
//                                 setState(() {
//                                   registrationDocs = value;
//                                 });
//                               },
//                               suffixIcon: Padding(
//                                 padding: EdgeInsets.only(
//                                   right: screenWidth / 40,
//                                   top: screenWidth / 40,
//                                   bottom: screenWidth / 40,
//                                 ),
//                                 child: customeButton(
//                                   textStyleButton:
//                                   ConstantTextStyle.loginButtonTextStyle,
//                                   onPressed: () {},
//                                   text: "Upload",
//                                   backgroundColor: ConstantColor.primaryMainColor,
//                                   borderRadius: BorderRadius.circular(8.0),
//                                   elevation: 3.0,
//                                 ),
//                               ),
//                             ),
// /*------------------------------Store Registration Docs field start----------------------------------*/
//                           ]
//                         ),
//                         isActive: _currentStep >= 0,
//                         state: _currentStep >= 1 ? StepState.complete : StepState.disabled,
//
//                       ),
// //---------------------------Step 3 Start--------------------
//                       Step(
//                         title: Text('Image'),
//                         content: Column(
//                           children: [
// /*------------------------------Store LOGO field start----------------------------------*/
//                             loginTextFormField2(
//                               controller: storeLogoNameController,
//                               textFormPaddingHorizontal: screenWidth / 40,
//                               textFormPaddingVertical: screenHeight / 40,
//                               minLines: 1,
//                               maxLines: 1,
//                               borderSideColor: _isFocused16
//                                   ? ConstantColor.primaryMainColor
//                                   : ConstantColor.transparent1,
//                               focusNode: _focusNode16,
//                               context: context,
//                               fillColor: ConstantColor.primaryBackgroundMainColor,
//                               filled: true,
//                               iconButton: IconButton,
//                               helperText:
//                               "Upload only (jpg, jpeg, png) of Max Size 1MB",
//                               hintText: "Select Store Logo",
//                               hintStyle: ConstantTextStyle.sellerHintTextStyle,
//                               labelText: "Select Store Logo",
//                               labelStyle: ConstantTextStyle.lableTextStyle,
//                               cursorColor: ConstantColor.primaryMainColor,
//                               keyboardType: TextInputType.name,
//                               onChanged: (value) {
//                                 setState(() {
//                                   storeLogo = value;
//                                 });
//                               },
//                               suffixIcon: Padding(
//                                 padding: EdgeInsets.only(
//                                   right: screenWidth / 40,
//                                   top: screenWidth / 40,
//                                   bottom: screenWidth / 40,
//                                 ),
//                                 child: customeButton(
//                                   textStyleButton:
//                                   ConstantTextStyle.loginButtonTextStyle,
//                                   onPressed: () {},
//                                   text: "Upload",
//                                   backgroundColor: ConstantColor.primaryMainColor,
//                                   borderRadius: BorderRadius.circular(8.0),
//                                   elevation: 3.0,
//                                 ),
//                               ),
//                             ),
//
// /*------------------------------Store LOGO field end----------------------------------*/
//                             SizedBox(height: screenHeight / 50),
// /*------------------------------Store Banner field start----------------------------------*/
//                             loginTextFormField2(
//                               controller: storeBannerNameController ,
//                               textFormPaddingHorizontal: screenWidth / 40,
//                               textFormPaddingVertical: screenHeight / 40,
//                               minLines: 1,
//                               maxLines: 1,
//                               borderSideColor: _isFocused17
//                                   ? ConstantColor.primaryMainColor
//                                   : ConstantColor.transparent1,
//                               focusNode: _focusNode17,
//                               context: context,
//                               fillColor: ConstantColor.primaryBackgroundMainColor,
//                               filled: true,
//                               iconButton: IconButton,
//                               helperText:
//                               "Upload only (jpg, jpeg, png) of Max Size 1MB",
//                               hintText: "Select Store Banner",
//                               hintStyle: ConstantTextStyle.sellerHintTextStyle,
//                               labelText: "Select Store Banner",
//                               labelStyle: ConstantTextStyle.lableTextStyle,
//                               cursorColor: ConstantColor.primaryMainColor,
//                               keyboardType: TextInputType.text,
//                               onChanged: (value) {
//                                 setState(() {
//                                   storeBanner = value;
//                                 });
//                               },
//                               suffixIcon: Padding(
//                                 padding: EdgeInsets.only(
//                                   right: screenWidth / 40,
//                                   top: screenWidth / 40,
//                                   bottom: screenWidth / 40,
//                                 ),
//                                 child: customeButton(
//                                   textStyleButton:
//                                   ConstantTextStyle.loginButtonTextStyle,
//                                   onPressed: () {},
//                                   text: "Upload",
//                                   backgroundColor: ConstantColor.primaryMainColor,
//                                   borderRadius: BorderRadius.circular(8.0),
//                                   elevation: 3.0,
//                                 ),
//                               ),
//                             ),
// /*------------------------------Store Banner field end----------------------------------*/
//                             SizedBox(height: screenHeight / 50),
//  /*--------------------------------Calendar Section start  -------------------------------------*/
//                             ScrollbarTheme(
//                               data: ScrollbarThemeData(
//                                 crossAxisMargin: 2.5,
//                                 radius: const Radius.circular(10.0),
//                                 thickness: MaterialStateProperty.all(7.0),
//                                 trackBorderColor: MaterialStateProperty.all(ConstantColor.trackBGolor),
//                                 thumbColor: MaterialStateProperty.all(ConstantColor.primaryMainColor),
//                                 trackColor: MaterialStateProperty.all(ConstantColor.trackBGolor),
//                               ),
//                               child: Scrollbar(
//                                 controller: _scrollController,
//                                 trackVisibility: true,
//                                 thumbVisibility: true,
//                                 child: SingleChildScrollView(
//                                   controller: _scrollController,
//                                   scrollDirection: Axis.horizontal,
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: screenWidth/30,
//                                             vertical: screenHeight/120
//                                         ),
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(8.0),
//                                           color: ConstantColor.calendarBGHeadColor,
//                                         ),
//
//                                         child: Row(
//                                           crossAxisAlignment: CrossAxisAlignment.center,
//                                           children: [
//                                             customeText(
//                                               text: "Day".toUpperCase(),
//                                               textAlign: TextAlign.start,
//                                               style:
//                                               ConstantTextStyle.passwordScreenLineTexStyle,
//                                             ),
//                                             SizedBox(
//                                               width: screenWidth/5,
//                                             ),
//
//                                             customeText(
//                                               text: "close/open".toUpperCase(),
//                                               textAlign: TextAlign.start,
//                                               style: ConstantTextStyle
//                                                   .passwordScreenLineTexStyle,
//                                             ),
//                                             SizedBox(
//                                               width: screenWidth/5,
//                                             ),
//                                             customeText(
//                                               text: "open/at".toUpperCase(),
//                                               style:
//                                               ConstantTextStyle.passwordScreenLineTexStyle,
//                                               textAlign: TextAlign.start,
//                                             ),
//                                             SizedBox(
//                                               width: screenWidth/5,
//                                             ),
//                                             customeText(
//                                               text: "close/at".toUpperCase(),
//                                               style:
//                                               ConstantTextStyle.passwordScreenLineTexStyle,
//                                               textAlign: TextAlign.start,
//                                             ),
//
//                                           ],
//                                         ),
//
//                                       ),
//                                       _createDataTable(
//                                         columns: _createColumns(
//                                         ),
//                                         rows:_createRows(),
//                                       ),
//                                       SizedBox(height: screenHeight/30,),
//                                     ],),
//                                 ),
//                               ),
//                             ),
// /*--------------------------------Calendar Section end  -------------------------------------*/
//                             SizedBox(height: screenHeight / 50),
// /*----------------------------Payment Mode  Start----------------------------------*/
//
//                             ListTile(
//                               dense: true,
//                               contentPadding: EdgeInsets.zero,
//                               leading: customeText(
//                                 text: "Payment Modes Accepted By You*",
//                                 style: TextStyle(fontFamily: 'Montserrat',),
//                                 textAlign: TextAlign.start,
//                               ),
//                               title: customeButton(
//                                 text: "Select All",
//                                 backgroundColor: ConstantColor.primaryMainColor,
//                                 onPressed: () {
//                                   setState(() {
//                                     selectAllChecked = !selectAllChecked;
//                                     if (selectAllChecked) {
//                                       selectedPaymentModes.addAll(paymentTextName);
//                                     } else {
//                                       selectedPaymentModes.clear();
//                                     }
//                                   });
//                                 },
//                                 borderRadius: BorderRadius.circular(8.0),
//                               ),
//                             ),
//                             // SizedBox(height: screenHeight / 80),
// //*------------------------------Payment Row 1 start---------------------------
//                             Column(
//                               children: paymentTextName.map((paymentMode) {
//                                 return Row(
//                                   children: [
//                                     customeCheckbox(
//                                       checkColor: ConstantColor.primaryBackgroundMainColor,
//                                       activeColor: ConstantColor.filedContainerColor,
//                                       value: selectedPaymentModes.contains(paymentMode),
//                                       onChanged: (newValue) {
//                                         print("Clicked on $paymentMode checkbox. Current value: ${selectedPaymentModes.contains(paymentMode)}");
//                                         updateSelectedPaymentMode(paymentMode, newValue!);
//                                         print("Updated value for $paymentMode: $newValue. Updated selectedPaymentModes: $selectedPaymentModes");
//                                       },
//                                     ),
//
//                                     customeText(
//                                       textAlign: TextAlign.start,
//                                       text: paymentMode,
//                                       style: ConstantTextStyle.secondryLocationText,
//                                     ),
//                                   ],
//                                 );
//                               }).toList(),
//                             ),
// /*----------------------------Payment Mode  Start----------------------------------*/
//                             SizedBox(height: screenHeight / 50),
// /*------------------------Year Of Establishment Field start ---------------------------------*/
//
//                             loginTextFormField2(
//                               controller: yoeController,
//                               textFormPaddingHorizontal: screenWidth / 40,
//                               textFormPaddingVertical: screenHeight / 40,
//                               minLines: 1,
//                               maxLines: 1,
//                               borderSideColor: _isFocused28
//                                   ? ConstantColor.primaryMainColor
//                                   : ConstantColor.transparent1,
//                               focusNode: _focusNode28,
//                               context: context,
//                               fillColor: ConstantColor.primaryBackgroundMainColor,
//                               filled: true,
//                               iconButton: IconButton,
//                               hintText: "Year Of Establishment",
//                               hintStyle: ConstantTextStyle.sellerHintTextStyle,
//                               labelText: "Year Of Establishment",
//                               labelStyle: ConstantTextStyle.lableTextStyle,
//                               cursorColor: ConstantColor.primaryMainColor,
//                               keyboardType: TextInputType.text,
//                               onChanged: (value) {
//                                 setState(() {
//                                   yoe = value;
//                                 });
//                               },
//                             ),
//
// /*-------------------------Year Of Establishment Field end ---------------------------------*/
//
//                           ],
//                         ),
//                         isActive: _currentStep >= 0,
//                         state: _currentStep >= 2 ? StepState.complete : StepState.disabled,
//                       ),
// //----------------------------------Step 4--------------------------
//                       Step(
//                         title: Text('Finish'),
//                         content: Column(
//                           children: [
// /*-------------------------Deals In Field start ---------------------------------*/
//                             loginTextFormField2(
//                               controller: dealsInController,
//                               textFormPaddingHorizontal: screenWidth / 40,
//                               textFormPaddingVertical: screenHeight / 40,
//                               minLines: 1,
//                               maxLines: 1,
//                               borderSideColor: _isFocused18
//                                   ? ConstantColor.primaryMainColor
//                                   : ConstantColor.transparent1,
//                               focusNode: _focusNode18,
//                               context: context,
//                               fillColor: ConstantColor.primaryBackgroundMainColor,
//                               filled: true,
//                               iconButton: IconButton,
//                               hintText: "Type key and Press Enter Key",
//                               hintStyle: ConstantTextStyle.sellerHintTextStyle,
//                               labelText: "Deals In",
//                               labelStyle: ConstantTextStyle.lableTextStyle,
//                               cursorColor: ConstantColor.primaryMainColor,
//                               keyboardType: TextInputType.text,
//                               onChanged: (value) {
//                                 setState(() {
//                                   dealsIN = value;
//                                 });
//                               },
//                             ),
//
// /*-------------------------Deals In Field end ---------------------------------*/
//                             SizedBox(height: screenHeight / 50),
// /*-------------------------Meta title Field start ---------------------------------*/
//                             loginTextFormField2(
//                               controller: metaTitleController,
//                               textFormPaddingHorizontal: screenWidth / 40,
//                               textFormPaddingVertical: screenHeight / 40,
//                               minLines: 1,
//                               maxLines: 1,
//                               borderSideColor: _isFocused21
//                                   ? ConstantColor.primaryMainColor
//                                   : ConstantColor.transparent1,
//                               focusNode: _focusNode21,
//                               context: context,
//                               fillColor: ConstantColor.primaryBackgroundMainColor,
//                               filled: true,
//                               iconButton: IconButton,
//                               hintText: "Enter Title",
//                               hintStyle: ConstantTextStyle.sellerHintTextStyle,
//                               labelText: "Meta Title",
//                               labelStyle: ConstantTextStyle.lableTextStyle,
//                               cursorColor: ConstantColor.primaryMainColor,
//                               keyboardType: TextInputType.text,
//                               onChanged: (value) {
//                                 setState(() {
//                                   metaTitle = value;
//                                 });
//                               },
//                             ),
//
// /*-------------------------Meta title Field end ---------------------------------*/
//                             SizedBox(height: screenHeight / 50),
// /*------------------------------Meta KeyWord field start----------------------------------*/
//                             Row(
//                               children: [
//                                 Flexible(
//                                   child: loginTextFormField2(
//                                     controller: metaKeywordController,
//                                     textFormPaddingHorizontal: screenWidth / 40,
//                                     textFormPaddingVertical: screenHeight / 40,
//                                     minLines: 1,
//                                     maxLines: 1,
//                                     borderSideColor: _isFocused22
//                                         ? ConstantColor.primaryMainColor
//                                         : ConstantColor.transparent1,
//                                     focusNode: _focusNode22,
//                                     context: context,
//                                     fillColor:
//                                     ConstantColor.primaryBackgroundMainColor,
//                                     filled: true,
//                                     enabled: true,
//                                     iconButton: IconButton,
//                                     hintText: "Words",
//                                     hintStyle:
//                                     ConstantTextStyle.sellerHintTextStyle,
//                                     labelText: "Meta Key Words",
//                                     labelStyle: ConstantTextStyle.lableTextStyle,
//                                     cursorColor: ConstantColor.primaryMainColor,
//                                     keyboardType: TextInputType.text,
//                                     onChanged: (value) {
//                                       setState(() {
//                                         metaKeyWord = value;
//                                       });
//                                     },
//                                   ),
//                                 ),
// /*------------------------------Meta Key Word field end----------------------------------*/
//                                 SizedBox(width: screenWidth / 30,),
// /*------------------------------Meta Description field  start----------------------------------*/
//                                 Flexible(
//                                   child: loginTextFormField2(
//                                     controller: metaDescriptionController,
//                                     textFormPaddingHorizontal: screenWidth / 40,
//                                     textFormPaddingVertical: screenHeight / 40,
//                                     minLines: 1,
//                                     maxLines: 1,
//                                     borderSideColor: _isFocused23
//                                         ? ConstantColor.primaryMainColor
//                                         : ConstantColor.transparent1,
//                                     focusNode: _focusNode23,
//                                     context: context,
//                                     fillColor:
//                                     ConstantColor.primaryBackgroundMainColor,
//                                     filled: true,
//                                     enabled: true,
//                                     iconButton: IconButton,
//                                     hintText: "Description",
//                                     hintStyle:
//                                     ConstantTextStyle.sellerHintTextStyle,
//                                     labelText: "Meta Description",
//                                     labelStyle: ConstantTextStyle.lableTextStyle,
//                                     cursorColor: ConstantColor.primaryMainColor,
//                                     keyboardType: TextInputType.number,
//                                     onChanged: (value) {
//                                       setState(() {
//                                         metaDesc = value;
//                                       });
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
// /*------------------------------Meta Description field  end----------------------------------*/
//                             SizedBox(height: screenHeight / 50),
// /*-------------------------------Check-Box and T&C start---------------------------------------*/
//                             Row(
//                               children: [
//                                 customeCheckbox(
//                                   checkColor:
//                                   ConstantColor.primaryBackgroundMainColor,
//                                   activeColor: ConstantColor.filedContainerColor,
//                                   value: _checkBoxValue,
//                                   onChanged: (newValue) {
//                                     setState(() {
//                                       _checkBoxValue = newValue!;
//                                     });
//                                   },
//                                 ),
//                                 customRichText(
//                                   text1: "I agree the ",
//                                   TextAlign: TextAlign.start,
//                                   style1: ConstantTextStyle.secondryLocationText,
//                                   text2: " Terms and Conditions",
//                                   style2: ConstantTextStyle.sellerHintTextStyle,
//                                 ),
//                               ],
//                             ),
// /*-------------------------------Check-Box and T&C end---------------------------------------*/
//                           ],
//                         ),
//                         isActive: _currentStep >= 0,
//                         state: _currentStep >= 3 ? StepState.complete : StepState.disabled,
//
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               // Padding(
//               //   padding: EdgeInsets.all(16.0),
//               //   child: Row(
//               //     mainAxisAlignment: MainAxisAlignment.spaceAround,
//               //     children: <Widget>[
//               //       ElevatedButton(
//               //         onPressed: _currentStep == 0 ? null : cancel,
//               //         child: Text('Cancel'),
//               //       ),
//               //       ElevatedButton(
//               //         onPressed: _currentStep == 3 ? save : continued,
//               //         child: _currentStep == 3 ? Text('Save') : Text('Next'),
//               //       ),
//               //     ],
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   child: Icon(Icons.list),
//       //   onPressed: switchStepsType,
//       // ),
//     );
//   }
//
//   // switchStepsType() {
//   //   setState(() => stepperType == StepperType.vertical
//   //       ? stepperType = StepperType.horizontal
//   //       : stepperType = StepperType.vertical);
//   // }
//
//   tapped(int step) {
//     setState(() => _currentStep = step);
//   }
//
//   continued() {
//     _currentStep < 3 ? setState(() => _currentStep += 1) : null;
//     print("pressed continued button ");
//
//     if (_formKey.currentState!.validate()) {
//       fetchRegistrationFirst(
//         newStore: storeNameController.text.toString(),
//         legalBusName: legalBusinessNameController.text.toString(),
//         buildingAddress: storeAddressController.text.toString(),
//         addressLoc: storeLocAddressController.text.toString(),
//         landmark: landmarkController.text.toString(),
//         latitudeFist: storeLatitudeCodeController.text.toString(),
//         longitudeFist: storeLongitudeCodeController.text.toString(),
//         countryFist: countryIdCodeController.text.toString(),
//         stateFist: stateIdCodeController.text.toString(),
//         cityFist: cityIdCodeController.text.toString(),
//         pinCode: pincodeController.text.toString(),
//       );
//
//       // Check the condition for calling the second registration API
//       if (_currentStep == 3) {
//         // Call the second registration API here
//         fetchRegistrationSecond(
//           contactPersonName: nameController.text.toString(),
//           designationPerson: designationController.text.toString(),
//           referralCode: referralCodeController.text.toString(),
//           // Add other parameters as needed
//         );
//       }
//     }
//   }
//
//
//   cancel() {
//     _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
//   }
//
//   void save() {
//     // Implement your save logic here
//     // This function is called when the "Save" button is pressed
//     // You can handle saving data or performing other actions here
//   }
// //----------------------------------------------------------------------
//   _createDataTable({columns, rows }) {
//     return DataTable(
//       dataRowHeight: 70,
//       dividerThickness:0.5,
//       headingRowHeight: 0,
//       columns: columns,
//       rows: rows,
//     );
//   }
//
//   List<DataColumn> _createColumns() {
//     return [
//       const DataColumn(label: Text(''),),
//       const DataColumn(label: Text('')),
//       const DataColumn(label: Text('')),
//       const DataColumn(label: Text(''))
//     ];
//
//   }
//   List<DataRow> _createRows() {
//     var screenWidth =MediaQuery.of(context).size.width;
//     var screenHeight= MediaQuery.of(context).size.height;
//
//     return [
//
// /*---------------------------------Monday, Button and Time start------------------------------*/
//
//       DataRow( cells:[
//         DataCell( customeText(
//           text: "Monday".toUpperCase(),
//           textAlign: TextAlign.start,
//           style: ConstantTextStyle.allHomeScreenAvatarText,
//         ),
//         ),
//
//         DataCell(
//           customeSwitch(
//             toggleColor: ConstantColor.primaryMainColor,
//             inactiveToggleColor: ConstantColor.primaryBackgroundMainColor,
//             activeColor: ConstantColor.switchActiveColor,
//             inactiveColor: ConstantColor.switchActiveColor,
//             switchHeight:  screenHeight  / 50,
//             switchWidth:  screenWidth  / 10,
//             padding: 2.5,
//             toggleSize: 15.0,
//             borderRadius: 10.0,
//             value: _switchValue,
//             onToggle: (value) {
//               setState(() {
//                 _switchValue = value;
//               });
//             },
//           ),
//
//           // customSwitch(
//           //   animationDuration: const Duration(milliseconds: 100),
//           //   value: _switchValue,
//           //   height : screenHeight  / 50.0,
//           //   width: screenWidth/10.0,
//           //   onChanged: (bool value) {setState(() {_switchValue = value;});},
//           //   onTap:(){},
//           //   contentSize: 15.0,
//           //   background : ConstantColor.switchActiveColor,
//           //   buttonColor : _switchValue ? ConstantColor.primaryMainColor: ConstantColor.primaryBackgroundMainColor,
//           // ),
//         ),
//         DataCell(
//           SizedBox(
//             height:  screenHeight  / 25,
//             child:timeDropDownFormField(
//               formFieldStyle: ConstantTextStyle.allHomeScreenAvatarText,
//               value: _selectedTime,
//               onChanged: (newValue) {
//                 setState(() {
//                   _selectedTime = newValue;
//                 });
//               },
//               items: _timeOptions.map((time) {
//                 return DropdownMenuItem<String>(
//                   value: time,
//                   child: Text(time),
//                 );
//               }).toList(),
//               context: context,
//               enabledBorderColor: ConstantColor.textFieldColor,
//               focusedBorderColor: ConstantColor.textFieldColor,
//             ),
//           ),
//         ),
//         DataCell(
//           SizedBox(
//             height:  screenHeight  / 25,
//             child:timeDropDownFormField(
//               formFieldStyle: ConstantTextStyle.allHomeScreenAvatarText,
//               value: _selectedTime,
//               onChanged: (newValue) {
//                 setState(() {
//                   _selectedTime = newValue;
//                 });
//               },
//               items: _timeOptions.map((time) {
//                 return DropdownMenuItem<String>(
//                   value: time,
//                   child: Text(time),
//                 );
//               }).toList(),
//               context: context,
//               enabledBorderColor: ConstantColor.textFieldColor,
//               focusedBorderColor: ConstantColor.textFieldColor,
//             ),
//           ),
//         ),
//       ]),
//
// /*---------------------------------Monday, Button and Time end--------------------------------*/
//
// /*---------------------------------Tuesday, Button and Time start------------------------------*/
//
//       DataRow(cells: [
//         DataCell(  customeText(
//           text: "Tuesday".toUpperCase(),
//           textAlign: TextAlign.start,
//           style: ConstantTextStyle.allHomeScreenAvatarText,
//         ),
//         ),
//         DataCell(
//           customeSwitch(
//             toggleColor: ConstantColor.primaryMainColor,
//             inactiveToggleColor: ConstantColor.primaryBackgroundMainColor,
//             activeColor: ConstantColor.switchActiveColor,
//             inactiveColor: ConstantColor.switchActiveColor,
//             switchHeight:  screenHeight  / 50,
//             switchWidth:  screenWidth  / 10,
//             padding: 2.5,
//             toggleSize: 15.0,
//             borderRadius: 10.0,
//             value: _switchValue1,
//             onToggle: (value) {
//               setState(() {
//                 _switchValue1 = value;
//               });
//             },
//           ),
//           // customSwitch(
//           //   animationDuration: const Duration(milliseconds: 100),
//           //   value: _switchValue1,
//           //   height : screenHeight  / 50.0,
//           //   width: screenWidth/10.0,
//           //   onChanged: (bool value) {setState(() {_switchValue1 = value;});},
//           //   onTap:(){},
//           //   contentSize: 15.0,
//           //   background : ConstantColor.switchActiveColor,
//           //   buttonColor : _switchValue1 ? ConstantColor.primaryMainColor: ConstantColor.primaryBackgroundMainColor,
//           // ),
//         ),
//         DataCell(     SizedBox(
//           //width:  screenWidth  / 4,
//           height:  screenHeight  / 25,
//           child:timeDropDownFormField(
//             formFieldStyle: ConstantTextStyle.allHomeScreenAvatarText,
//             value: _selectedTime,
//             onChanged: (newValue) {
//               setState(() {
//                 _selectedTime = newValue;
//               });
//             },
//             items: _timeOptions.map((time) {
//               return DropdownMenuItem<String>(
//                 value: time,
//                 child: Text(time),
//               );
//             }).toList(),
//             context: context,
//             enabledBorderColor: ConstantColor.textFieldColor,
//             focusedBorderColor: ConstantColor.textFieldColor,
//           ),
//         ),
//         ),
//         DataCell(
//           SizedBox(
//             //width:  screenWidth  / 4,
//             height:  screenHeight  / 25,
//             child:timeDropDownFormField(
//               formFieldStyle: ConstantTextStyle.allHomeScreenAvatarText,
//               value: _selectedTime,
//               onChanged: (newValue) {
//                 setState(() {
//                   _selectedTime = newValue;
//                 });
//               },
//               items: _timeOptions.map((time) {
//                 return DropdownMenuItem<String>(
//                   value: time,
//                   child: Text(time),
//                 );
//               }).toList(),
//               context: context,
//               enabledBorderColor: ConstantColor.textFieldColor,
//               focusedBorderColor: ConstantColor.textFieldColor,
//             ),
//           ),
//         ),
//       ]),
//
// /*---------------------------------Tuesday, Button and Time end--------------------------------*/
//
// /*---------------------------------Wednesday, Button and Time start------------------------------*/
//
//       DataRow(cells: [
//         DataCell(
//           customeText(
//             text: "Wednesday".toUpperCase(),
//             textAlign: TextAlign.start,
//             style: ConstantTextStyle.allHomeScreenAvatarText,
//           ),
//         ),
//
//         DataCell(
//           customeSwitch(
//             toggleColor: ConstantColor.primaryMainColor,
//             inactiveToggleColor: ConstantColor.primaryBackgroundMainColor,
//             activeColor: ConstantColor.switchActiveColor,
//             inactiveColor: ConstantColor.switchActiveColor,
//             switchHeight:  screenHeight  / 50,
//             switchWidth:  screenWidth  / 10,
//             padding: 2.5,
//             toggleSize: 15.0,
//             borderRadius: 10.0,
//             value: _switchValue2,
//             onToggle: (value) {
//               setState(() {
//                 _switchValue2 = value;
//               });
//             },
//           ),
//           // customSwitch(
//           //   animationDuration: const Duration(milliseconds: 100),
//           //   value: _switchValue2,
//           //   height : screenHeight  / 50.0,
//           //   width: screenWidth/10.0,
//           //   onChanged: (bool value) {setState(() {_switchValue2 = value;});},
//           //   onTap:(){},
//           //   contentSize: 15.0,
//           //   background : ConstantColor.switchActiveColor,
//           //   buttonColor : _switchValue2 ? ConstantColor.primaryMainColor: ConstantColor.primaryBackgroundMainColor,
//           // ),
//         ),
//
//         DataCell(   SizedBox(
//           //width:  screenWidth  / 4,
//           height:  screenHeight  / 25,
//           child:timeDropDownFormField(
//             formFieldStyle: ConstantTextStyle.allHomeScreenAvatarText,
//             value: _selectedTime,
//             onChanged: (newValue) {
//               setState(() {
//                 _selectedTime = newValue;
//               });
//             },
//             items: _timeOptions.map((time) {
//               return DropdownMenuItem<String>(
//                 value: time,
//                 child: Text(time),
//               );
//             }).toList(),
//             context: context,
//             enabledBorderColor: ConstantColor.textFieldColor,
//             focusedBorderColor: ConstantColor.textFieldColor,
//           ),
//         ),
//         ),
//         DataCell(
//           SizedBox(
//             //width:  screenWidth  / 4,
//             height:  screenHeight  / 25,
//             child:timeDropDownFormField(
//               formFieldStyle: ConstantTextStyle.allHomeScreenAvatarText,
//               value: _selectedTime,
//               onChanged: (newValue) {
//                 setState(() {
//                   _selectedTime = newValue;
//                 });
//               },
//               items: _timeOptions.map((time) {
//                 return DropdownMenuItem<String>(
//                   value: time,
//                   child: Text(time),
//                 );
//               }).toList(),
//               context: context,
//               enabledBorderColor: ConstantColor.textFieldColor,
//               focusedBorderColor: ConstantColor.textFieldColor,
//             ),
//           ),
//         ),
//       ]),
//
// /*---------------------------------Wednesday, Button and Time end--------------------------------*/
//
// /*---------------------------------Thursday, Button and Time start------------------------------*/
//       DataRow(cells: [
//         DataCell(   customeText(
//           text: "Thursday".toUpperCase(),
//           textAlign: TextAlign.start,
//           style: ConstantTextStyle.allHomeScreenAvatarText,
//         ),
//         ),
//
//         DataCell(
//           customeSwitch(
//             toggleColor: ConstantColor.primaryMainColor,
//             inactiveToggleColor: ConstantColor.primaryBackgroundMainColor,
//             activeColor: ConstantColor.switchActiveColor,
//             inactiveColor: ConstantColor.switchActiveColor,
//             switchHeight:  screenHeight  / 50,
//             switchWidth:  screenWidth  / 10,
//             padding: 2.5,
//             toggleSize: 15.0,
//             borderRadius: 10.0,
//             value: _switchValue3,
//             onToggle: (value) {
//               setState(() {
//                 _switchValue3 = value;
//               });
//             },
//           ),
//           // customSwitch(
//           //   animationDuration: const Duration(milliseconds: 100),
//           //   value: _switchValue3,
//           //   height : screenHeight  / 50.0,
//           //   width: screenWidth/10.0,
//           //   onChanged: (bool value) {setState(() {_switchValue3 = value;});},
//           //   onTap:(){},
//           //   contentSize: 15.0,
//           //   background : ConstantColor.switchActiveColor,
//           //   buttonColor : _switchValue3 ? ConstantColor.primaryMainColor: ConstantColor.primaryBackgroundMainColor,
//           // ),
//         ),
//
//         DataCell( SizedBox(
//           //width:  screenWidth  / 4,
//           height:  screenHeight  / 25,
//           child:timeDropDownFormField(
//             formFieldStyle: ConstantTextStyle.allHomeScreenAvatarText,
//             value: _selectedTime,
//             onChanged: (newValue) {
//               setState(() {
//                 _selectedTime = newValue;
//               });
//             },
//             items: _timeOptions.map((time) {
//               return DropdownMenuItem<String>(
//                 value: time,
//                 child: Text(time),
//               );
//             }).toList(),
//             context: context,
//             enabledBorderColor: ConstantColor.textFieldColor,
//             focusedBorderColor: ConstantColor.textFieldColor,
//           ),
//         ),
//         ),
//         DataCell(
//           SizedBox(
//             // width: screenWidth  / 4,
//             height:  screenHeight  / 25,
//             child:timeDropDownFormField(
//               formFieldStyle: ConstantTextStyle.allHomeScreenAvatarText,
//               value: _selectedTime,
//               onChanged: (newValue) {
//                 setState(() {
//                   _selectedTime = newValue;
//                 });
//               },
//               items: _timeOptions.map((time) {
//                 return DropdownMenuItem<String>(
//                   value: time,
//                   child: Text(time),
//                 );
//               }).toList(),
//               context: context,
//               enabledBorderColor: ConstantColor.textFieldColor,
//               focusedBorderColor: ConstantColor.textFieldColor,
//             ),
//           ),
//         ),
//       ]),
//
// /*---------------------------------Thursday, Button and Time end--------------------------------*/
//
// /*---------------------------------Friday, Button and Time start------------------------------*/
//       DataRow(cells: [
//         DataCell(  customeText(
//           text: "Friday".toUpperCase(),
//           textAlign: TextAlign.start,
//           style: ConstantTextStyle.allHomeScreenAvatarText,
//         ),
//         ),
//
//         DataCell(
//           customeSwitch(
//             toggleColor: ConstantColor.primaryMainColor,
//             inactiveToggleColor: ConstantColor.primaryBackgroundMainColor,
//             activeColor: ConstantColor.switchActiveColor,
//             inactiveColor: ConstantColor.switchActiveColor,
//             switchHeight:  screenHeight  / 50,
//             switchWidth:  screenWidth  / 10,
//             padding: 2.5,
//             toggleSize: 15.0,
//             borderRadius: 10.0,
//             value: _switchValue4,
//             onToggle: (value) {
//               setState(() {
//                 _switchValue4 = value;
//               });
//             },
//           ),
//           // customSwitch(
//           //   animationDuration: const Duration(milliseconds: 100),
//           //   value: _switchValue4,
//           //   height : screenHeight  / 50.0,
//           //   width: screenWidth/10.0,
//           //   onChanged: (bool value) {setState(() {_switchValue4 = value;});},
//           //   onTap:(){},
//           //   contentSize: 15.0,
//           //   background : ConstantColor.switchActiveColor,
//           //   buttonColor : _switchValue4 ? ConstantColor.primaryMainColor: ConstantColor.primaryBackgroundMainColor,
//           // ),
//         ),
//         DataCell(   SizedBox(
//           //width:  screenWidth  / 4,
//           height:  screenHeight  / 25,
//           child:timeDropDownFormField(
//             formFieldStyle: ConstantTextStyle.allHomeScreenAvatarText,
//             value: _selectedTime,
//             onChanged: (newValue) {
//               setState(() {
//                 _selectedTime = newValue;
//               });
//             },
//             items: _timeOptions.map((time) {
//               return DropdownMenuItem<String>(
//                 value: time,
//                 child: Text(time),
//               );
//             }).toList(),
//             context: context,
//             enabledBorderColor: ConstantColor.textFieldColor,
//             focusedBorderColor: ConstantColor.textFieldColor,
//           ),
//         ),
//         ),
//         DataCell(
//           SizedBox(
//             //width:  screenWidth  / 4,
//             height:  screenHeight  / 25,
//             child:timeDropDownFormField(
//               formFieldStyle: ConstantTextStyle.allHomeScreenAvatarText,
//               value: _selectedTime,
//               onChanged: (newValue) {
//                 setState(() {
//                   _selectedTime = newValue;
//                 });
//               },
//               items: _timeOptions.map((time) {
//                 return DropdownMenuItem<String>(
//                   value: time,
//                   child: Text(time),
//                 );
//               }).toList(),
//               context: context,
//               enabledBorderColor: ConstantColor.textFieldColor,
//               focusedBorderColor: ConstantColor.textFieldColor,
//             ),
//           ),
//         ),
//       ]),
//
// /*---------------------------------Friday, Button and Time end--------------------------------*/
//
// /*---------------------------------Saturday, Button and Time start------------------------------*/
//       DataRow(cells: [
//         DataCell(   customeText(
//           text: "Saturday".toUpperCase(),
//           textAlign: TextAlign.start,
//           style: ConstantTextStyle.allHomeScreenAvatarText,
//         ),
//         ),
//
//         DataCell(
//           customeSwitch(
//             toggleColor: ConstantColor.primaryMainColor,
//             inactiveToggleColor: ConstantColor.primaryBackgroundMainColor,
//             activeColor: ConstantColor.switchActiveColor,
//             inactiveColor: ConstantColor.switchActiveColor,
//             switchHeight:  screenHeight  / 50,
//             switchWidth:  screenWidth  / 10,
//             padding: 2.5,
//             toggleSize: 15.0,
//             borderRadius: 10.0,
//             value: _switchValue5,
//             onToggle: (value) {
//               setState(() {
//                 _switchValue5 = value;
//               });
//             },
//           ),
//           //   customSwitch(
//           //     animationDuration: const Duration(milliseconds: 100),
//           //     value: _switchValue5,
//           //     height : screenHeight  / 50.0,
//           //     width: screenWidth/10.0,
//           //     onChanged: (bool value) {setState(() {_switchValue5 = value;});},
//           //     onTap:(){},
//           //     contentSize: 15.0,
//           //     background : ConstantColor.switchActiveColor,
//           //     buttonColor : _switchValue5 ? ConstantColor.primaryMainColor: ConstantColor.primaryBackgroundMainColor,
//           //   ),
//         ),
//
//         DataCell(  SizedBox(
//           //width:  screenWidth  / 4,
//           height:  screenHeight  / 25,
//           child:timeDropDownFormField(
//             formFieldStyle: ConstantTextStyle.allHomeScreenAvatarText,
//             value: _selectedTime,
//             onChanged: (newValue) {
//               setState(() {
//                 _selectedTime = newValue;
//               });
//             },
//             items: _timeOptions.map((time) {
//               return DropdownMenuItem<String>(
//                 value: time,
//                 child: Text(time),
//               );
//             }).toList(),
//             context: context,
//             enabledBorderColor: ConstantColor.textFieldColor,
//             focusedBorderColor: ConstantColor.textFieldColor,
//           ),
//         ),
//         ),
//         DataCell(
//           SizedBox(
//             //width:  screenWidth  / 4,
//             height:  screenHeight  / 25,
//             child:timeDropDownFormField(
//               formFieldStyle: ConstantTextStyle.allHomeScreenAvatarText,
//               value: _selectedTime,
//               onChanged: (newValue) {
//                 setState(() {
//                   _selectedTime = newValue;
//                 });
//               },
//               items: _timeOptions.map((time) {
//                 return DropdownMenuItem<String>(
//                   value: time,
//                   child: Text(time),
//                 );
//               }).toList(),
//               context: context,
//               enabledBorderColor: ConstantColor.textFieldColor,
//               focusedBorderColor: ConstantColor.textFieldColor,
//             ),
//           ),
//         ),
//       ]),
//
// /*---------------------------------Saturday, Button and Time end--------------------------------*/
//
// /*---------------------------------Sunday, Button and Time start------------------------------*/
//
//       DataRow(cells: [
//         DataCell(  customeText(
//           text: "Sunday".toUpperCase(),
//           textAlign: TextAlign.start,
//           style: ConstantTextStyle.allHomeScreenAvatarText,
//         ),
//         ),
//         DataCell(
//
//           customeSwitch(
//             toggleColor: ConstantColor.primaryMainColor,
//             inactiveToggleColor: ConstantColor.primaryBackgroundMainColor,
//             activeColor: ConstantColor.switchActiveColor,
//             inactiveColor: ConstantColor.switchActiveColor,
//             switchHeight:  screenHeight  / 50,
//             switchWidth:  screenWidth  / 10,
//             padding: 2.5,
//             toggleSize: 15.0,
//             borderRadius: 10.0,
//             value: _switchValue6,
//             onToggle: (value) {
//               setState(() {
//                 _switchValue6 = value;
//               });
//             },
//           ),
//           //
//           // customSwitch(
//           //   animationDuration: const Duration(milliseconds: 100),
//           //   value: _switchValue6,
//           //   height : screenHeight  / 50.0,
//           //   width: screenWidth/10.0,
//           //   onTap: () {},
//           //  onChanged: (value){setState(() {_switchValue6 = value;});},
//           //   contentSize: 15.0,
//           //   background : ConstantColor.switchActiveColor,
//           //   buttonColor : _switchValue6 ? ConstantColor.primaryMainColor: ConstantColor.primaryBackgroundMainColor,
//           // ),
//         ),
//         DataCell(  SizedBox(
//           //width:  screenWidth  / 4,
//           height:  screenHeight  / 25,
//           child:timeDropDownFormField(
//             formFieldStyle: ConstantTextStyle.allHomeScreenAvatarText,
//             value: _selectedTime,
//             onChanged: (newValue) {
//               setState(() {
//                 _selectedTime = newValue;
//               });
//             },
//             items: _timeOptions.map((time) {
//               return DropdownMenuItem<String>(
//                 value: time,
//                 child: Text(time),
//               );
//             }).toList(),
//             context: context,
//             enabledBorderColor: ConstantColor.textFieldColor,
//             focusedBorderColor: ConstantColor.textFieldColor,
//           ),
//         ),
//         ),
//         DataCell(
//           SizedBox(
//             //width:  screenWidth  / 4,
//             height:  screenHeight  / 25,
//             child:timeDropDownFormField(
//               formFieldStyle: ConstantTextStyle.allHomeScreenAvatarText,
//               value: _selectedTime,
//               onChanged: (newValue) {
//                 setState(() {
//                   _selectedTime = newValue;
//                 });
//               },
//               items: _timeOptions.map((time) {
//                 return DropdownMenuItem<String>(
//                   value: time,
//                   child: Text(time),
//                 );
//               }).toList(),
//               context: context,
//               enabledBorderColor: ConstantColor.textFieldColor,
//               focusedBorderColor: ConstantColor.textFieldColor,
//             ),
//           ),
//         ),
//       ]),
// /*---------------------------------Sunday, Button and Time end--------------------------------*/
//
//     ];
//   }
// //----------------------------------------------------------------------
// }
//
//
//
