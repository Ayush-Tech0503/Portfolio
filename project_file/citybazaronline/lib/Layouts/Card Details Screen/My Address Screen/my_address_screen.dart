// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables
import 'package:Citybazar_app/Util/constaint_textstyle.dart';
import 'package:Citybazar_app/Util/constant_color.dart';
import 'package:Citybazar_app/Widgets/custome_button_.dart';
import 'package:Citybazar_app/Widgets/custome_text.dart';
import 'package:flutter/material.dart';
import '../../../Api Services/Card Api Services/My Addess Services/my_address_submit_api_services.dart';
import '../../../Api Services/Card Api Services/card_address_api_services.dart';
import '../../../Api Services/Card Api Services/get_card_product_count.dart';
import '../../../Models/Card Details Model/card_address_model.dart';
import '../../../Util/Constant APi Url/api_urls.dart';
import '../../../Widgets/Card Details Widgets/Permition Dialog/permition_dialog_widget.dart';
import '../../../Widgets/Famous Market Widget/store_details_widget.dart';
import '../../../collapsing_appbar.dart';
import 'add_new_address_screen.dart';

class MyAddressScreen extends StatefulWidget {
  final id;
  final lName;
  final lattude;
  final longitude;
  const MyAddressScreen({super.key, this.lattude, this.longitude, this.id, this.lName});

  @override
  State<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {

  @override
  void initState() {
    super.initState();
    fetchCardAddressData();
  }
  dynamic currentPage = 1;
  // final ScrollController _scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    // _scrollController.dispose();
    searchController.dispose();
    // selectedCheckBoxs = '';
    super.dispose();
  }

  bool isPullToRefreshEnabled = true;
  var limit = '12';
  bool isLoading = false;
  bool isHashLoad = false;

  // final RefreshController _refreshController = RefreshController(initialRefresh: false);

  //-------------------------------
  //CardAddressApiService
  CardAddressModel? cardAddressModel;
  List<CardAddressData>? cardAddressData = [];

  Future<void> fetchCardAddressData() async {
    try {
      setState(() {
        isLoading = true;
        cardAddressData!.clear();
      });

      final getCardAddressResponse = await CardAddressApiService.fetchCardAddressData(context: context);
      if (getCardAddressResponse != null && getCardAddressResponse.data != null) {
        setState(() {
          cardAddressData = getCardAddressResponse.data!.toList();
          // cardAddressData = getCardAddressResponse.data!.where((data) => data.deflate == "1").toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  //-------------------------------
  Future<void> _refreshData() async {
    cardAddressData!.clear();
    await fetchCardAddressData();
  }
  //-------------------------------
  void _handleDeleteAddress({addressId}) {
      fetchSubmitFormApiService(
        context: context,
        baseUrl: '${ConstantUrls.baseUriApi}${ConstantUrls.deleteMyAddressEndPoint}',
        body: {
          "address_id": addressId??"",
        },
        onSuccess: () => _refreshData(),
      );
    }
  //-------------------------------

  //CardDeleteApiService
  ProductCount? productCount;
  Future<void> fetchProductCount() async {
    setState(() {
      isLoading = true; // Set loading state
    });

    try {
      final productCountResponse = await CardProductCountApiService.cardProductCountData(context: context);

      setState(() {
        isLoading = false; // Reset loading state
        productCount = productCountResponse; // Update productCount with API response
      });
    } catch (e) {
      setState(() {
        isLoading = false; // Reset loading state on error
      });
    }
  }

  //--------home-page-navigation
  Future<bool> onWillPop() async {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => MyHomePageDemo1(mobilenumber: '', lat: '', longitude: '', id: '', lName: '')),);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var screenH = MediaQuery.of(context).size.height;
    var screenW = MediaQuery.of(context).size.width;
    return Container(
      color: ConstantColor.loginWithOtpButtonColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ConstantColor.secondryBackgroundMainColor,
          // backgroundColor: ConstantColor.primaryBackgroundMainColor,
          appBar: AppBar(
            elevation: 0,
            // leadingWidth: 24,
            backgroundColor: ConstantColor.primaryBackgroundMainColor,
            iconTheme: const IconThemeData(color: ConstantColor.loginWithOtpButtonColor),
            title: customeText(textAlign: TextAlign.start,
                text: "My Address", style: ConstantTextStyle.secodHearText),
            // centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenW/30.0,vertical: screenH/80.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customeText(text: "My Address",style: ConstantTextStyle.passwordScreenLineTexStyle),
                  SizedBox(height: screenH/80.0,),
                  // isLoading
                      // ?  const SpinKitCircle(color: ConstantColor.primaryMainColor, size: 40.0)
                      // : (data != null && data!.isNotEmpty && data!.toString().isNotEmpty)
                      // ?
                  Container(
                    width: screenW,
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        color: ConstantColor.primaryBackgroundMainColor,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: ConstantColor.progressBGolor)
                    ),
                    child: OutlinedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AddNewAddressScreen(
                                onSuccess: _refreshData,
                              );
                            },
                          );
                        },
                        style: ButtonStyle(
                            side: MaterialStateProperty.all(const BorderSide(color: ConstantColor.primaryGreyColor, width: 1.0))),
                        child: customeText(text: '+ Add Address',style: ConstantTextStyle.homeScreenHeadingText3)
        
                    )
                  ),
        
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cardAddressData?.length ?? 0,
                      itemBuilder: (context, index) {
                        bool isDefault = cardAddressData![index].deflate == "1";
        
                        return Card(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: screenW/30.0,vertical: screenH/60.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                customeText(text: isDefault ? 'Default : Yes' : 'Default : No',
                                    // customeText(text: 'Default : ${cardAddressData![index].deflate == "0" ? "" : cardAddressData![index].deflate == "1" ? "Yes" :""}',
                                style: ConstantTextStyle.skyBlueColorShopName),
                               const Divider(color: ConstantColor.primaryGreyColor),
                                customeText(text: cardAddressData![index].address??"",style: ConstantTextStyle.topCategoryText),
                                customeText(text: '${cardAddressData![index].houseNumber??""}, ${cardAddressData![index].landmark??""}',style: ConstantTextStyle.colorsHeadingText),
                                customeText(text: '${cardAddressData![index].city??""}, ${cardAddressData![index].state??""}, ${cardAddressData![index].pincode??""}',style: ConstantTextStyle.colorsHeadingText),
                                customeText(text: cardAddressData![index].country??"",style: ConstantTextStyle.colorsHeadingText),
        
                                SizedBox(height: screenH/80.0,),
                                Row(
                                  children: [
                                    boxIcon(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AddNewAddressScreen(
                                                address: cardAddressData![index].address??"",
                                                addressIds: cardAddressData![index].addressId??"",
                                                landmark: cardAddressData![index].landmark??"",
                                                homeNo: cardAddressData![index].houseNumber??"",
                                                city: cardAddressData![index].city??"",
                                                pincode: cardAddressData![index].pincode??"",
                                                stateName: cardAddressData![index].state??"",
                                                countryName: cardAddressData![index].country??"",
                                                addressType: cardAddressData![index].addressType??"",
                                                isChecked: (cardAddressData![index].deflate ?? "") == "1" ? true : false,
                                                onSuccess: _refreshData,
                                              );
                                            },
                                          );},
                                        borderRadius: BorderRadius.circular(8.0),
                                        bgcolor: ConstantColor.primaryMainColor,
                                        icon: Icons.edit_note,iconcolor: ConstantColor.primaryBackgroundMainColor
                                    ),
                                    SizedBox(width: screenW/20.0,),
                                    boxIcon(
                                        onTap: () => YesNoPermissionDialog.showExitConfirmationDialog(
                                          context:context, title: 'Please Confirm!', content: 'Are you sure want to remove this Product?',
                                          actions: [
                                            customeButton(
                                              textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                                              onPressed:() {
                                                Navigator.pop(context);
                                                _handleDeleteAddress(addressId: cardAddressData![index].addressId??"");},
                                              text: "Yes",
                                              backgroundColor: ConstantColor.loginWithOtpButtonColor,
                                              borderRadius: BorderRadius.circular(20.0),
                                              elevation: 0.0,
                                            ),
                                            SizedBox(width: screenW/100.0,),
                                            customeButton(
                                              textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                                              onPressed:() => Navigator.pop(context),
                                              text: "No",
                                              backgroundColor: ConstantColor.primaryMainColor,
                                              borderRadius: BorderRadius.circular(20.0),
                                              elevation: 0.0,
                                            ),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                        bgcolor: ConstantColor.primaryMainColor,
                                        icon: Icons.delete_forever_outlined,iconcolor: ConstantColor.primaryBackgroundMainColor
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
        
                      }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}




