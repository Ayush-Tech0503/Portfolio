
import 'package:flutter/material.dart';
import '../../../Api Services/Card Api Services/My Addess Services/my_address_submit_api_services.dart';
import '../../../Api Services/Card Api Services/card_address_api_services.dart';
import '../../../Models/Card Details Model/card_address_model.dart';
import '../../../Util/Constant APi Url/api_urls.dart';
import '../../../Util/constaint_textstyle.dart';
import '../../../Util/constant_color.dart';
import '../../../Widgets/custome_text.dart';
import 'checkout_card_add_address.dart';

class CheckoutChangeAddressScreen extends StatefulWidget {
  final Function? onSuccess;
  const CheckoutChangeAddressScreen({super.key,
    this.onSuccess
  });

  @override
  State<CheckoutChangeAddressScreen> createState() => _CheckoutChangeAddressScreenState();
}

class _CheckoutChangeAddressScreenState extends State<CheckoutChangeAddressScreen> {
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
    fetchCardAddressData();
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

  TextEditingController addressController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController homeNoController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController addressTypeController = TextEditingController();


  bool isLoading = false;

  //-------handle make as default funtion-------
  void _handleDefaultSubmit({addressId}) {
    if (_formKey.currentState!.validate()) {
      fetchSubmitFormApiService(
        context: context,
        baseUrl: '${ConstantUrls.baseUriApi}${ConstantUrls.makeDefaultMyAddressEndPoint}',
        body: {"address_id": addressId},
        onSuccess: () {
          Navigator.pop(context);
          if (widget.onSuccess != null) {
            widget.onSuccess!(); // Call the callback
          }
        },
      );
    }
  }


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
          "deflate": "1",
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
  int? selectedAddressIndex;
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      insetPadding: EdgeInsets.symmetric(vertical: screenHeight/12.0,horizontal: screenWidth/20.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child:Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: screenWidth/30.0,vertical: screenHeight/100.0),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cardAddressData?.length ?? 0,
                  itemBuilder: (context, index) {
                    selectedAddressIndex = cardAddressData?.indexWhere((address) => address.deflate == "1") ?? 0;

                    bool isDefault = cardAddressData![index].deflate == "1";
                    var cartAddressId = cardAddressData![index].addressId ?? "";
                    return Container(
                      // padding: EdgeInsets.symmetric(horizontal: screenWidth/40.0,vertical: screenHeight/60.0),
                      margin: EdgeInsets.symmetric(horizontal: screenWidth/30.0,vertical: screenHeight/100.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isDefault ? ConstantColor.primaryMainColor : ConstantColor.primaryGreyColor, // Use colors based on `isDefault`
                          width: 0.5, // Set the border width
                        ),
                        borderRadius: BorderRadius.circular(8.0), // Optional: to match the Card's border radius
                      ),
                      child: ListTile(
                        onTap: () => _handleDefaultSubmit(addressId: cartAddressId),
                        dense: true,
                        horizontalTitleGap: 0.0,
                        contentPadding: EdgeInsets.symmetric(vertical: screenHeight/80.0),
                        leading:Radio(
                          value: index,
                          groupValue: selectedAddressIndex,
                          onChanged: (int? value) {
                            setState(() {selectedAddressIndex = value;});
                          },
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customeText(text: cardAddressData![index].address??"",style: ConstantTextStyle.topCategoryText),
                            customeText(text: '${cardAddressData![index].houseNumber??""}, ${cardAddressData![index].landmark??""}',style: ConstantTextStyle.colorsHeadingText),
                            customeText(text: '${cardAddressData![index].city??""}, ${cardAddressData![index].state??""}, ${cardAddressData![index].pincode??""}',style: ConstantTextStyle.colorsHeadingText),
                            customeText(text: cardAddressData![index].country??"",style: ConstantTextStyle.colorsHeadingText),
                          ],
                        ),
                      ),
                    );

                  }
              ),
              Container(
                  width: screenWidth,
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: ConstantColor.primaryBackgroundMainColor,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: ConstantColor.progressBGolor)
                  ),
                  child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CheckoutAddAddressScreen(
                              onSuccess: (){
                                // Navigator.pop(context);
                                if (widget.onSuccess != null) {
                                  widget.onSuccess!(); // Call the callback
                                }
                              },
                            );
                          },
                        );
                      },
                      style: ButtonStyle(
                          side: MaterialStateProperty.all(const BorderSide(color: ConstantColor.primaryGreyColor, width: 1.0))),
                      child: customeText(text: '+ Add Address',style: ConstantTextStyle.homeScreenHeadingText3)

                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
