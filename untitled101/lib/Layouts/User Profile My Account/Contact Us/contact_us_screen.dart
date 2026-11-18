// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Util/Constant APi Url/api_urls.dart';
import '../../../Util/constaint_textstyle.dart';
import '../../../Util/constant_color.dart';
import '../../../Util/constant_image.dart';
import '../../../Util/constant_token.dart';
import '../../../Widgets/Famous Market Widget/store_details_widget.dart';
import '../../../Widgets/custome_button_.dart';
import '../../../Widgets/custome_imagies.dart';
import '../../../Widgets/custome_text.dart';
import '../../../Widgets/login_textformfiled.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen>
    with TickerProviderStateMixin {
  String location = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var tokenAccess;
  var userId;
  getAccessToken() async {
    SharedPreferences preference = await SharedPreferences.getInstance();

    setState(() {
      tokenAccess = preference.getString("access-token");
      userId = preference.getString("userId");
      //print("userId ${userId}");
      //print("tokenAccess ${tokenAccess}");
    });
  }

/*-------------------------form field nodes and string start --------------------------*/
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

  String name = '';
  String subject = '';
  String mobileNumber = '';
  String email = '';
  String address = '';
  String msg = '';

  get valuefirst => null;

  @override
  void initState() {
    super.initState();
    fetchContactUsApi();
    getAccessToken();

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

  bool isLoading = false;
  var responseData;
  List<String> _subText = [];

  fetchContactUsApi() async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.contactUsApi}",
        // options: Options(
        //   headers: {
        //     "Authorization": ConstantToken.authorizationToken,
        //     'Content-Type': 'text/plain',
        //   },
        // ),
      );
      if (response.statusCode == 200) {
        responseData = json.decode(response.data);
        _subText = [
          responseData["data"]["phone"],
          responseData["data"]["email"],
          responseData["data"]["whatsapp"],
          responseData["data"]["address"],
        ];
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      //print('Failed to fetch data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  fetchSaveContactUsApi({name, email, mobile, subject, query}) async {
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
                Text('Submitting...',
                  style: ConstantTextStyle.allHomeScreenAvatarText,
                ),
              ],
            ),
          );
        },
      );
      //final prefs = await SharedPreferences.getInstance();
      final body = {
        "name": name,
        "email": email,
        "mobile": mobile,
        "subject": subject,
        "query": query
      };

      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.saveContactUsApi}",
        options: Options(
          headers: {
            "Authorization": tokenAccess,
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
        data: json.encode(body),
      );
      Navigator.pop(context);
      // loader false when user come back
      if (response.statusCode == 200) {
        responseData = json.decode(response.data);
        if (responseData["status"] == "success") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Submitted Successfully"),
            backgroundColor: Colors.green,
          ));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const ContactUsScreen(),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(responseData["msg"]),
            backgroundColor: Colors.red,
          ));
        }
      }
    } catch (e) {
      //print('Failed to fetch data: ${e.toString()}');
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  /*-------------------------form field nodes and string end --------------------------*/

  /*-------------------------Contact List View data start --------------------------*/
  final List<String> _headText = [
    "Phone number".toUpperCase(),
    "email".toUpperCase(),
    "whatsapp".toUpperCase(),
    "Address".toUpperCase(),
  ];

  final List<IconData> _icons = [
    Icons.phone_outlined,
    Icons.email_outlined,
    FontAwesomeIcons.whatsapp,
    Icons.location_on_outlined,
    // Add more icons...
  ];

  /*----------------------------- Calling button redirect start--------------------------*/

  // final String phoneNumber = '18008892780'; // Replace with your desired phone number

  void _launchPhoneCall({urlPhone}) async {
    String phoneNumber = urlPhone ?? '18008892780';
    String url = 'tel:$phoneNumber';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  /*----------------------------- Calling button redirect end--------------------------*/
  /*----------------------------- Email  redirect end--------------------------*/
  _emailContact() async {
    var url = Uri.parse("mailto:contact@citybazaronline.com");
    // var url = Uri.parse(urlEmail);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  /*----------------------------- Email  redirect end--------------------------*/

  /*-------------------------Contact List View data end --------------------------*/

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: ConstantColor.loginWithOtpButtonColor,
      child: SafeArea(
        child:Scaffold(
          backgroundColor: ConstantColor.secondryBackgroundMainColor,
/*--------------------------------------appbar section start-------------------------------------*/
          key: _scaffoldKey,
          appBar: AppBar(
            elevation: 1,
            backgroundColor: ConstantColor.primaryBackgroundMainColor,
            iconTheme: const IconThemeData(color: ConstantColor.loginWithOtpButtonColor),
            title: customeText(textAlign: TextAlign.start,
                text: "Contact & Support", style: ConstantTextStyle.secodHearText),
          ),
/*--------------------------------------appbar section end-------------------------------------*/
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: screenWidth/20,vertical: screenHeight/40),
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customeText(
                text: "Contact Us".toUpperCase(),
                style: ConstantTextStyle.secodHearText,
              ),
              SizedBox(
                height: screenHeight / 50,
              ),
              customeText(
                text:
                "Are easy to find, so a visitor can quickly get in touch with you.",
                style: ConstantTextStyle.becomeSellerDiscText,
              ),

          /*-------------------------------Contact form start-------------------------------------------*/
              SizedBox(
                height: screenHeight / 50,
              ),
              Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: ConstantColor.primaryBackgroundMainColor,
                  borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: ConstantColor.progressBGolor)
                ),
                child: Form(
                  key: _formKey,
                  child: tokenAccess != null
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight / 100),
                      loginTextFormField1(
                        controller: subjectController,
                        autofocus: false,
                        borderSideColor: _isFocused3
                            ? ConstantColor.primaryMainColor
                            : ConstantColor.transparent1,
                        focusNode: _focusNode3,
                        context: context,
                        labelText: "Subject",
                        labelStyle:
                        ConstantTextStyle.lableTextStyle2,
                        hintStyle: ConstantTextStyle.hintTextStyle,
                        cursorColor: ConstantColor.primaryMainColor,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Subject';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            subject = value;
                          });
                        },
                      ),

          /*------------------------------Email filed end----------------------------------*/
                      SizedBox(height: screenHeight / 100),
          /*------------------------------Message filed start----------------------------------*/
                      loginTextFormField2(
                        controller: messageController,
                        textFormPaddingHorizontal: screenWidth / 40,
                        textFormPaddingVertical: screenHeight / 80,
                        minLines: 3,
                        maxLines: 3,
                        borderSideColor: _isFocused4
                            ? ConstantColor.primaryMainColor
                            : ConstantColor.transparent1,
                        focusNode: _focusNode4,
                        context: context,
                        fillColor: ConstantColor.primaryBackgroundMainColor,
                        filled: true,
                        iconButton: IconButton,
                        labelText: "Message",
                        labelStyle: ConstantTextStyle.lableTextStyle2,
                        cursorColor: ConstantColor.primaryMainColor,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Message';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            msg = value;
                          });
                        },
                      ),
                    ],
                  )
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
          /*------------------------------Name filed start----------------------------------*/
                      loginTextFormField1(
                        autofocus: false,
                        controller: nameController,
                        borderSideColor: _isFocused
                            ? ConstantColor.primaryMainColor
                            : ConstantColor.transparent1,
                        focusNode: _focusNode,
                        context: context,
                        labelText: "Full Name",
                        labelStyle:
                        ConstantTextStyle.lableTextStyle2,
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
                            name = value;
                          });
                        },
                      ),

          /*------------------------------Name filed end----------------------------------*/

                      SizedBox(height: screenHeight / 100),
          /*------------------------------Email filed start----------------------------------*/

                      loginTextFormField1(
                        controller: emailController,
                        autofocus: false,
                        borderSideColor: _isFocused1
                            ? ConstantColor.primaryMainColor
                            : ConstantColor.transparent1,
                        focusNode: _focusNode1,
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
                            email = value;
                          });
                        },
                      ),

          /*------------------------------Email filed end----------------------------------*/

                      SizedBox(height: screenHeight / 100),

          /*------------------------------Mo.no. filed start----------------------------------*/

                      loginTextFormField1(
                        controller: mobileController,
                        autofocus: false,
                        borderSideColor: _isFocused2
                            ? ConstantColor.primaryMainColor
                            : ConstantColor.transparent1,
                        focusNode: _focusNode2,
                        context: context,
                        labelText: "Mobile Number".toUpperCase(),
                        labelStyle:
                        ConstantTextStyle.lableTextStyle2,
                        hintStyle: ConstantTextStyle.hintTextStyle,
                        cursorColor: ConstantColor.primaryMainColor,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter yor mobile number';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            mobileNumber = value;
                          });
                        },
                      ),

          /*------------------------------Mo.no. filed end----------------------------------*/

                      SizedBox(height: screenHeight / 100),

          /*------------------------------Email filed start----------------------------------*/

                      loginTextFormField1(
                        controller: subjectController,
                        autofocus: false,
                        borderSideColor: _isFocused3
                            ? ConstantColor.primaryMainColor
                            : ConstantColor.transparent1,
                        focusNode: _focusNode3,
                        context: context,
                        labelText: "Subject",
                        labelStyle:
                        ConstantTextStyle.lableTextStyle2,
                        hintStyle: ConstantTextStyle.hintTextStyle,
                        cursorColor: ConstantColor.primaryMainColor,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Subject';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            subject = value;
                          });
                        },
                      ),

          /*------------------------------Email filed end----------------------------------*/
                      SizedBox(height: screenHeight / 100),
          /*------------------------------Message filed start----------------------------------*/
                      loginTextFormField2(
                        controller: messageController,
                        textFormPaddingHorizontal: screenWidth / 40,
                        textFormPaddingVertical: screenHeight / 80,
                        minLines: 3,
                        maxLines: 3,
                        borderSideColor: _isFocused4
                            ? ConstantColor.primaryMainColor
                            : ConstantColor.transparent1,
                        focusNode: _focusNode4,
                        context: context,
                        fillColor: ConstantColor
                            .primaryBackgroundMainColor,
                        filled: true,
                        iconButton: IconButton,
                        labelText: "Message",
                        labelStyle:
                        ConstantTextStyle.lableTextStyle2,
                        cursorColor: ConstantColor.primaryMainColor,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Message';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            msg = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

          /*------------------------------Message filed end----------------------------------*/
          /*-------------------------------Submit Button start---------------------------------------*/
              SizedBox(height: screenHeight / 60),
              customeButton(
                minimumSize: Size(screenWidth, screenHeight/25),
                elevation: 0.5,
                textStyleButton: ConstantTextStyle.loginButtonTextStyle,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    fetchSaveContactUsApi(
                        name: nameController.text.toString(),
                        email: emailController.text.toString(),
                        mobile: mobileController.text.toString(),
                        subject: subjectController.text.toString(),
                        query: messageController.text.toString());
                  }
                },
                text: "Submit",
                backgroundColor: ConstantColor.filedContainerColor,
                borderRadius: BorderRadius.circular(8.0),
              ),

          /*-------------------------------Submit Button end---------------------------------------*/
              SizedBox(
                height: screenHeight / 60,
              ),
          /*-----------------------------List view start----------------------------------------------*/
              isLoading
                  ? const Center(
                child: SpinKitCircle(
                  color: ConstantColor.primaryMainColor,
                  size: 30.0,
                ),
              )
                  : ListView.builder(
                physics: const PageScrollPhysics(),
                shrinkWrap: true,
                itemExtent: 100,
                itemCount: _subText.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {

                      // Handle individual icon press based on index
                      switch (index) {
                        case 0:
                          _launchPhoneCall(urlPhone: _subText[0]);
                          break;
                        case 1:
                          _emailContact();
                          break;
                        case 2:
                          break;
                        case 3:
                          break;
                      // case 4:
                      //   break;

                        default:
                          break;
                      }
                    },
                    child: Container(
                     margin: EdgeInsets.only(bottom: screenHeight /60),
                      decoration: BoxDecoration(
                        color: ConstantColor.primaryBackgroundMainColor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Center(
                        child: ListTile(
                          leading: boxIcon(
                            borderRadius:
                            BorderRadius.circular(8.0),
                            height: screenHeight / 15,
                            width: screenWidth /9,
                            bgcolor: ConstantColor.primaryMainColor,
                            icon: _icons[index],
                            iconsize: 25.0,
                            iconcolor: ConstantColor
                                .primaryBackgroundMainColor,
                          ),
                          title: customeText(
                            text: _headText[index],
                            textAlign: TextAlign.start,
                            style: ConstantTextStyle.secodHearText,
                          ),
                          subtitle: customeText(
                            text: _subText[index],
                            textAlign: TextAlign.start,
                            style: ConstantTextStyle.skyBlueColorText,
                            // style: ConstantTextStyle.skyBlueColorText,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
          /*-----------------------------------ListView end------------------------------------------*/
              SizedBox(
                height: screenHeight / 50,
              ),
          /*-----------------------------------Bottom image  start-----------------------------------*/

              customImg(
                  image: ConstantImage.contactUsImg,
                  fit: BoxFit.fill,
                  width: double.infinity),

          /*-----------------------------------Bottom image end--------------------------------------*/
            ],
          ),
        ),
      ),
    );
  }
}
