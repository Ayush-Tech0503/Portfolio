
import 'package:flutter/material.dart';
import '../../Util/constaint_textstyle.dart';
import '../../Util/constant_color.dart';
import '../../Widgets/custome_button_.dart';
import '../../Widgets/custome_checkbox.dart';
import '../../Widgets/custome_richtext.dart';
import '../../Widgets/custome_text.dart';
import '../../Widgets/login_textformfiled.dart';

class PayoutScreen extends StatefulWidget {
  const PayoutScreen({super.key});

  @override
  State<PayoutScreen> createState() => _HowCashbackWorkState();
}

class _HowCashbackWorkState extends State<PayoutScreen> {

  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();

  bool _isFocused = false;
  bool _isFocused1 = false;
  bool _isFocused2 = false;
  bool _isFocused3 = false;
  bool _isFocused4 = false;


  final _formKey = GlobalKey<FormState>();
  bool _checkBoxValue = false;


  String _name = '';
  String _upiId = '';
  String _mobileNumber = '';
  String _email = '';
  String _address = '';
  String _points = '';

  get valuefirst => null;

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



  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: ConstantColor.primaryMainColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ConstantColor.primaryMainColor,
            elevation: 0.0,
            title: Text(
              'Payout',
              style: ConstantTextStyle.productScreenAppbar,
              overflow: TextOverflow.ellipsis,
            ),
            titleSpacing: 0.0,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: screenWidth / 10),
                child: Container(),
              ),
            ],
          ),
          extendBody: true,

/*----------------------------------Body area---------------------------------------------*/
          body: SingleChildScrollView(
            padding: EdgeInsets.only(
              top: screenWidth/10,
              left: screenWidth/10,right: screenWidth/10,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
/*-----------------------------------------------------------------------------------*/

                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: ConstantColor.primaryBackgroundMainColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                        Center(
                          child: customeText(
                            text: "Request Payout",
                            style: ConstantTextStyle.cashbackCoinsText,

                          ),
                        ),


/*------------------------------Name filed start----------------------------------*/
                          SizedBox(height: screenHeight/30),
                          loginTextFormField1(
                            autofocus:false,
                            borderSideColor: _isFocused
                                ? ConstantColor.primaryMainColor
                                : ConstantColor.transparent1,
                            focusNode: _focusNode,
                            context: context,
                            labelText: "Full Name",
                            labelStyle: ConstantTextStyle.lableTextStyle2,
                            hintStyle: ConstantTextStyle.hintTextStyle,
                            cursorColor: ConstantColor.primaryMainColor,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _name = value;
                              });
                            },
                          ),


/*------------------------------Name filed end----------------------------------*/

                          SizedBox(height: screenHeight/80),

/*------------------------------upi -id filed start----------------------------------*/

                          loginTextFormField1(
                            autofocus:false,
                            borderSideColor: _isFocused1
                                ? ConstantColor.primaryMainColor
                                : ConstantColor.transparent1,
                            focusNode: _focusNode1,

                            context: context,
                            labelText: "Upi id".toUpperCase(),
                            labelStyle: ConstantTextStyle.lableTextStyle2,
                            hintStyle: ConstantTextStyle.hintTextStyle,
                            cursorColor: ConstantColor.primaryMainColor,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Invalid UPI ID';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _upiId = value;
                              });
                            },
                          ),


/*------------------------------upi -id filed end----------------------------------*/
                         SizedBox(height: screenHeight/80),

/*------------------------------Mo.no. filed start----------------------------------*/

                          loginTextFormField1(
                            autofocus:false,
                            borderSideColor: _isFocused2
                                ? ConstantColor.primaryMainColor
                                : ConstantColor.transparent1,
                            focusNode: _focusNode2,

                            context: context,
                            labelText: "Mobile Number".toUpperCase(),
                            labelStyle: ConstantTextStyle.lableTextStyle2,
                            hintStyle: ConstantTextStyle.hintTextStyle,
                            cursorColor: ConstantColor.primaryMainColor,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Invalid UPI ID';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _mobileNumber = value;
                              });
                            },
                          ),


/*------------------------------Mo.no. filed end----------------------------------*/

                          SizedBox(height: screenHeight/80),

/*------------------------------Email filed start----------------------------------*/

                          loginTextFormField1(
                            autofocus:false,
                            borderSideColor: _isFocused3
                                ? ConstantColor.primaryMainColor
                                : ConstantColor.transparent1,
                            focusNode: _focusNode3,
                            context: context,
                            labelText: "Email ID",
                            labelStyle:
                            ConstantTextStyle.lableTextStyle2,
                            hintStyle: ConstantTextStyle.hintTextStyle,
                            cursorColor: ConstantColor.primaryMainColor,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email ID';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _email = value;
                              });
                            },
                          ),

/*------------------------------Email filed end----------------------------------*/

                         SizedBox(height: screenHeight/80),

/*------------------------------Points filed start----------------------------------*/


                          loginTextFormField1(
                            autofocus:false,
                            borderSideColor: _isFocused4
                                ? ConstantColor.primaryMainColor
                                : ConstantColor.transparent1,
                            focusNode: _focusNode4,
                            context: context,
                            labelText: "Points",
                            labelStyle:
                            ConstantTextStyle.lableTextStyle2,
                            hintStyle: ConstantTextStyle.hintTextStyle,
                            cursorColor: ConstantColor.primaryMainColor,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Your points';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _points = value;
                              });
                            },
                          ),
/*------------------------------Points filed end----------------------------------*/

                        SizedBox(height: screenHeight/50),

/*-------------------------------Check-Box and T&C start---------------------------------------*/
                          Row(
                            children: [
                              customeCheckbox(
                                checkColor:
                                ConstantColor.primaryBackgroundMainColor,
                                activeColor: ConstantColor.filedContainerColor,
                                value: _checkBoxValue,
                                onChanged: (newValue) {
                                  setState(() {
                                    _checkBoxValue = newValue!;
                                  });
                                },
                              ),
                              SizedBox(
                                width: screenWidth/2,
                                child: customRichText(
                                  text1: "I agree that above details are",
                                  TextAlign: TextAlign.start,
                                  style1: ConstantTextStyle.checkboxTextStyle1,
                                  text2: " Correct ton my end",
                                  style2: ConstantTextStyle.checkboxTextStyle2,
                                ),
                              ),
                            ],
                          ),

/*-------------------------------Check-Box and T&C end---------------------------------------*/

                          SizedBox(height: screenHeight/80),
/*-------------------------------Request Button start---------------------------------------*/

                      customeButton(
                          elevation: 0.5,
                          textStyleButton:
                          ConstantTextStyle.loginButtonTextStyle,
                          onPressed: (){
                            if (_formKey.currentState!.validate()) {
                              // Form is valid, submit the data
                              // _submitForm();
                            }
                          },
                          text: "Request",
                          backgroundColor: ConstantColor.filedContainerColor,
                          borderRadius: BorderRadius.circular(8.0),
                          minimumSize: Size(
                              screenWidth / 3,
                              screenHeight / 25.0)
                      ),
/*-------------------------------Request Button end---------------------------------------*/

                        ],
                      ),
                    ),
                ),

/*-----------------------------------------------------------------------------------*/


              ],
            ),
          ),
        ),
      ),
    );
  }
}
