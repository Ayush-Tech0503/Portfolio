// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'dart:convert';

import 'package:Citybazar_app/Util/constaint_textstyle.dart';
import 'package:Citybazar_app/Util/constant_color.dart';
import 'package:Citybazar_app/Widgets/custome_imagies.dart';
import 'package:Citybazar_app/Widgets/custome_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Models/Pre Registration/registration_preview.dart';
import '../../../../Util/Const Toster/toster.dart';
import '../../../../Util/Constant APi Url/api_urls.dart';
import '../../../../Widgets/landing_screen_slider.dart';
import '../become_a_seller.dart';


class SellerSubmittedForm extends StatefulWidget {
  String id;
  String longitude;
  String latitude;
  String lName;
   SellerSubmittedForm({
    required this.id,
    required this.longitude,
    required this.latitude,
    required this.lName,
    super.key});

  @override
  State<SellerSubmittedForm> createState() => _SellerSubmittedFormState();
}

class _SellerSubmittedFormState extends State<SellerSubmittedForm> {

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
  TextEditingController paymentAcceptedModeController = TextEditingController();


bool isLoading = false;
var tokenAccess;
var is_seller;
var userId;
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
      // "https://citybazar.lab101.cloud/api/registration_preview",
      options: Options(
        headers: {
          "Authorization": tokenAccess,
          'Content-Type': 'application/json',
        },
      ),
    );
    if (response.statusCode == 200) {
      var responseData = json.decode(response.data.toString());
      preRegistration = PreRegistration.fromJson(responseData);
      if (preRegistration != null && preRegistration!.data != null) {
        childCat.addAll(preRegistration!.data!.childCat ?? []);
        nameController.text = preRegistration!.data!.userInfo!.firstName ?? "";
        emailController.text = preRegistration!.data!.userInfo!.email ?? "";
        contactNoController.text = preRegistration!.data!.userInfo!.mobile ?? "";
        storeNameController.text = preRegistration!.data!.seller!.storeName ?? "";
        legalBusinessNameController.text = preRegistration!.data!.seller!.legalBusinessName ?? "";
        storeSlugController.text = preRegistration!.data!.seller!.storeSlug ?? "";
        storeDetailController.text = preRegistration!.data!.seller!.storeDescription ?? "";
        storeAddressController.text = preRegistration!.data!.seller!.storeAddress ?? "";
        storeLocAddressController.text = preRegistration!.data!.seller!.storeLocAddress ?? "";
        referralCodeController.text = preRegistration!.data!.seller!.referralCode ?? "";
        storeLatitudeCodeController.text = preRegistration!.data!.seller!.storeLatitude ?? "";
        storeLongitudeCodeController.text = preRegistration!.data!.seller!.storeLongitude ?? "";
        countryIdCodeController.text = preRegistration!.data!.seller!.countryId ?? "";
        stateIdCodeController.text = preRegistration!.data!.seller!.stateId ?? "";
        cityIdCodeController.text = preRegistration!.data!.seller!.cityId ?? "";
        contactNoOptController.text = preRegistration!.data!.seller!.contactNoOpt ?? "";
        gstNoController.text = preRegistration!.data!.seller!.gstNo ?? "";
        scRegistrationFileController.text = preRegistration!.data!.seller!.scRegistrationFile ?? "";
        storeLogoNameController.text = preRegistration!.data!.seller!.storeLogoName ?? "";
        storeBannerNameController.text = preRegistration!.data!.seller!.storeBannerName ?? "";
        dealsInController.text = preRegistration!.data!.seller!.dealsIn ?? "";
        metaTitleController.text = preRegistration!.data!.seller!.metaTitle ?? "";
        metaKeywordController.text = preRegistration!.data!.seller!.metaKeyword ?? "";
        metaDescriptionController.text = preRegistration!.data!.seller!.metaDescription ?? "";
        landmarkController.text = preRegistration!.data!.seller!.landmark ?? "";
        pincodeController.text = preRegistration!.data!.seller!.pincode ?? "";
        designationController.text = preRegistration!.data!.seller!.designation ?? "";
        yoeController.text = preRegistration!.data!.seller!.yearOfEstablishment ?? "";
        scRegistrationTypeController.text = preRegistration!.data!.seller!.scRegistrationType ?? "";
        scRegistrationOtherController.text = preRegistration!.data!.seller!.otherScRegType ?? "";
        buyOrRentController.text = preRegistration!.data!.seller!.buyOrRent ?? "";
        deliveryModeController.text = preRegistration!.data!.seller!.deliveryMode ?? "";
        paymentAcceptedModeController.text = preRegistration!.data!.seller!.paymentModesAccepted ?? "";

        setState(() {
          List<dynamic>? sellerOpenHrs = preRegistration?.data?.sellerOpenHrs ?? [];
        });



        String? paymentModesString = preRegistration?.data?.seller?.paymentModesAccepted;

        sellerOpenHrs.addAll(
          (preRegistration!.data!.sellerOpenHrs as List<dynamic>)
              .map((item) => SellerOpenHrs.fromJson(item)).toList(),);
      }
      isLoading = false;
    } else {
      setState(() {
        isLoading = false;
      });
    }
  } catch (error) {
    isLoading = false;
  }
}
//--------------this preview api End--------------------

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPreview();
  }


  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: ConstantColor.loginWithOtpButtonColor,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ConstantColor.primaryBackgroundMainColor,
          iconTheme: const IconThemeData(
              color: ConstantColor.loginWithOtpButtonColor),
          title: customeText(
              textAlign: TextAlign.start,
              text: "Seller Form Submitted",
              style: ConstantTextStyle.secodHearText),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth / 40),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: iconTextButton(
              backgroundColor: ConstantColor.loginWithOtpButtonColor,
              icon: Icons.edit_outlined,
              iconColor: ConstantColor.primaryBackgroundMainColor,
              iconSize: 20.0,
              buttonOnPressed: (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => BecomeASellerform(
                    id: widget.id,
                    longitude:widget.longitude,
                    latitude:widget.latitude,
                    lName: widget.lName,
                  )),
                );
              },
              buttontext: "Edit",
              buttontextStyle: ConstantTextStyle.newiconButtonText,
              fixedSize: const Size(180, 1),
            ),
            title: iconTextButton(
              backgroundColor: ConstantColor.primaryMainColor,
              icon: Icons.save_outlined,
              iconColor: ConstantColor.primaryBackgroundMainColor,
              iconSize: 20.0,
              buttonOnPressed: () {
                Navigator.pop(context);
                LoadingScaffoldMessage.showSnackbar(
                  context,
                    "Successfully submitted!",
                  ConstantColor.primaryMainColor,
                  const Duration(seconds: 1),
                );
              },

              buttontext: "Save",
              buttontextStyle: ConstantTextStyle.newiconButtonText,
              // fixedSize: const Size(180, 1),
            ),
          ),
        ),
        body: Center(
          child: isLoading? const CircularProgressIndicator(color: ConstantColor.primaryMainColor): ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: screenHeight/80,horizontal: screenWidth/40),
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: customNetworkImg(
                  image:storeBannerNameController.text,
                  //    'https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                  width: screenWidth,
                  height: screenHeight/7.0,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: screenHeight/80,),
              Align(
                alignment: Alignment.centerLeft,
                child: ClipOval(
                  child: customNetworkImg(
                    image:scRegistrationFileController.text,
                //    'https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                    width: screenWidth/3.0,
                    height: screenHeight/7.0,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: screenHeight/80,),
              SizedBox(
                width: screenWidth,
                child: Card(
                  color: ConstantColor.textFieldColor,
                  child: Padding(
                    padding:EdgeInsets.symmetric(vertical: screenHeight/60,horizontal: screenWidth/30),
                    child: customeText(
                      textAlign: TextAlign.start,
                      text: "Shop Information",
                      style: ConstantTextStyle.passwordScreenLineTexStyle
                    ),
                  ),
                ),
              ),

          //---------------------------------------------------
              SizedBox(height: screenHeight/80,),

          sellRichText (
              titleText: "Store Name :- ",
              controllerText: storeNameController.text ?? "",),
          //-----------------------------------------------------------
                  sellRichText (
                    titleText: "Store Sluge :- ",
                    controllerText: storeSlugController.text ?? "",),

           //-----------------------------------------------------------
           sellRichText (
             titleText: "Designation :- ",
             controllerText: designationController.text ?? "",),

           //-----------------------------------------------------------
           sellRichText (
             titleText: "Store Address :- ",
             controllerText: storeAddressController.text ?? "",),

           //-----------------------------------------------------------
           sellRichText (
             titleText: "Store Description :- ",
             controllerText: storeDetailController.text ?? "",),

           //-----------------------------------------------------------
           sellRichText (
             titleText: "Location Address :- ",
             controllerText: storeLocAddressController.text ?? "",),

           //-----------------------------------------------------------
           sellRichText (
             titleText: "Referral Code :- ",
             controllerText: referralCodeController.text ?? "",),

           //-----------------------------------------------------------
           sellRichText (
             titleText: "Latitude :- ",
             controllerText: storeLatitudeCodeController.text ?? "",),

           //-----------------------------------------------------------
           sellRichText (
             titleText: "Longitude :- ",
             controllerText: storeLongitudeCodeController.text ?? "",),

           //-----------------------------------------------------------
           sellRichText (
             titleText: "Landmark :- ",
             controllerText: landmarkController.text ?? "",),
           //-----------------------------------------------------------
           sellRichText (
             titleText: "City :- ",
             controllerText: cityIdCodeController.text ?? "",),
          //-----------------------------------------------------------
              sellRichText (
                titleText: "State :- ",
                controllerText: stateIdCodeController.text ?? "",),
          //-----------------------------------------------------------
              sellRichText (
                titleText: "Country :- ",
                controllerText: countryIdCodeController.text ?? "",),
          //-----------------------------------------------------------
              sellRichText (
                titleText: "Contact No. :- ",
                controllerText: contactNoController.text ?? "",),
          //-----------------------------------------------------------
              sellRichText (
                titleText: "Contact No. (Optional) :- ",
                controllerText: contactNoOptController.text ?? "",),
          //-----------------------------------------------------------
              sellRichText (
                titleText: "Delivery Mode :- ",
                controllerText: deliveryModeController.text ?? "",),
          //-----------------------------------------------------------
              sellRichText (
                titleText: "Shop/Company Registration No. Type :- ",
                controllerText: scRegistrationTypeController.text ?? "",),
          //-----------------------------------------------------------
              sellRichText (
                titleText: "Shop/Company Registration No. Other Type :- ",
                controllerText: scRegistrationOtherController.text ?? "",),
          //-----------------------------------------------------------
              sellRichText (
                titleText: "Shop/Company Registration No. :- ",
                controllerText: gstNoController.text ?? "",),
          //-----------------------------------------------------------
              sellRichText (
                titleText: "Registration Document. :- ",
                controllerText: scRegistrationFileController.text ?? "",),
          //-----------------------------------------------------------
              sellRichText (
                titleText: "Deals In :- ",
                controllerText: dealsInController.text ?? "",),
          //-----------------------------------------------------------
              sellRichText (
                titleText: "Payment Modes Accepted :- ",
                controllerText: paymentAcceptedModeController.text ?? "",),

              SizedBox(height: screenHeight/80,),
              SizedBox(
                width: screenWidth,
                child: Card(
                  color: ConstantColor.textFieldColor,
                  child: Padding(
                    padding:EdgeInsets.symmetric(vertical: screenHeight/60,horizontal: screenWidth/30),
                    child: customeText(
                        textAlign: TextAlign.start,
                        text: "SEO Keyword",
                        style: ConstantTextStyle.passwordScreenLineTexStyle
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight/80,),
          //-----------------------------------------------------------
              sellRichText (
                titleText: "Meta Keyword :- ",
                controllerText: metaKeywordController.text == null || metaKeywordController.text == "null"
                    ? ''
                    : metaKeywordController.text),
          //-----------------------------------------------------------
              sellRichText (
                titleText: "Meta Description :- ",
                controllerText: metaDescriptionController.text == null || metaDescriptionController.text == "null"
              ? ''
                  : metaDescriptionController.text),
              SizedBox(height: screenHeight/80,),
              SizedBox(
                width: screenWidth,
                child: Card(
                  color: ConstantColor.textFieldColor,
                  child: Padding(
                    padding:EdgeInsets.symmetric(vertical: screenHeight/60,horizontal: screenWidth/30),
                    child: customeText(
                        textAlign: TextAlign.start,
                        text: "Open Hours",
                        style: ConstantTextStyle.passwordScreenLineTexStyle
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight/80,),
          //-----------------------------------------------------------
              ...buildSellRichTextWidgets(weekDays),
              SizedBox(height: screenHeight/80,),
              SizedBox(
                width: screenWidth,
                child: Card(
                  color: ConstantColor.textFieldColor,
                  child: Padding(
                    padding:EdgeInsets.symmetric(vertical: screenHeight/60,horizontal: screenWidth/30),
                    child: customeText(
                        textAlign: TextAlign.start,
                        text: "Email Address",
                        style: ConstantTextStyle.passwordScreenLineTexStyle
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight/80,),
          //-----------------------------------------------------------
              sellRichText (
                titleText: "Email ID :- ",
                controllerText: emailController.text ?? "",),
          //-----------------------------------------------------------
              SizedBox(
                width: screenWidth,
                child: Card(
                  color: ConstantColor.textFieldColor,
                  child: Padding(
                    padding:EdgeInsets.symmetric(vertical: screenHeight/60,horizontal: screenWidth/30),
                    child: customeText(
                        textAlign: TextAlign.start,
                        text: "Contact Number",
                        style: ConstantTextStyle.passwordScreenLineTexStyle
                    ),
                  ),
                ),
              ),
        sellRichText (
                titleText: "Contact Number :- ",
                controllerText: contactNoController.text ?? "",),
            ],
          ),
        ),
      ),
    );
  }
  List<Widget> buildSellRichTextWidgets(List<String> weekDays) {
    return weekDays.map((day) {
      return sellRichText(
        titleText: "$day :- ",
        controllerText: sellerOpenHrs!
            .where((item) => item.day == day)
            .map((item) {
          if (item.onOff == "1") {
            return "${item.opensAt ?? ''} - ${item.closesAt ?? ''}";
          } else {
            return "Closed";
          }
        })
            .join(", "),
      );
    }).toList();
  }

  Widget sellRichText ({titleText,controllerText}){
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: titleText,
            style: ConstantTextStyle.topCategoryText,
          ),
          TextSpan(
            text: controllerText,
            //storeNameController.text ?? "",
            style: ConstantTextStyle.tabButtonTextStyle,
          )

        ],
      ),
    );
  }

  List <String>weekDays = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
}

