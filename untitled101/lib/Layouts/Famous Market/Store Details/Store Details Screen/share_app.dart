// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:Citybazar_app/Util/constant_color.dart';
import 'package:Citybazar_app/Widgets/Famous%20Market%20Widget/store_details_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../Models/Show Store Details Models/store_details.dart';
import '../../../../Util/Constant APi Url/api_urls.dart';
import '../../../../Util/constaint_textstyle.dart';
import '../../../../Util/constant_token.dart';
import '../../../../Widgets/Send Enquiry dialogBox/alert_dialog_box.dart';
import '../../../../Widgets/custome_text.dart';


class ShareAppScreen extends StatefulWidget {
  final String? sellerIds;
  const ShareAppScreen({super.key, this.sellerIds});

  @override
  State<ShareAppScreen> createState() => _ShareAppScreenState();
}

class _ShareAppScreenState extends State<ShareAppScreen> {

/*-------------------------whatsapp share start----------------------------------------------*/
  void _launchWhatsApp(String? phoneWhatsapp, sms) async {
    String url = 'https://wa.me/$phoneWhatsapp?text=${Uri.encodeComponent(sms)}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch WhatsApp $url';
    }
  }
/*-------------------------------whatsapp share end----------------------------------------*/
/*-------------------------------Facebook share start----------------------------------------*/
  void _launchFaceBook(String? facebookUrl) async {
    if (facebookUrl != null && facebookUrl.isNotEmpty) {
      String url = 'https://www.facebook.com/$facebookUrl';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }
/*-------------------------------Facebook share end----------------------------------------*/
  /*----------------------------- Email  redirect end--------------------------*/
  void _emailContact(String? email) async {
    if (email != null && email.isNotEmpty) {
      String url = 'mailto:$email'; // Add 'mailto:' to create a mail URL
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }
  /*----------------------------- Email  redirect end--------------------------*/
  /*----------------------------- LinkedIn redirect end--------------------------*/
  void _launchLinkedIn() async {
    const url = "https://www.linkedin.com/sharing/share-offsite/?url=https%3A%2F%2Fcitybazaronline.codioticdemo.com%2Findore%2Fabcd%3Fpage%3D1";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';} }

  /*----------------------------- LinkedIn redirect end--------------------------*/
  /*----------------------------- LinkedIn redirect end--------------------------*/
  void _launchTwitter(String? twitterUrl) async {
    if (twitterUrl != null && twitterUrl.isNotEmpty) {
      String url = "https://twitter.com/$twitterUrl";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
      }
    }
  }
  /*----------------------------- LinkedIn redirect end--------------------------*/
  /*----------------------------- Copy linked popup start--------------------------*/
  void _showPopUpAndCopyLink() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),),
          content: Text('Link copied!', style: ConstantTextStyle.richtext1),
        );
      },
    );
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pop();
    });
  }
  /*----------------------------- Copy linked popup end--------------------------*/

/*------------------------------icon and text data list start--------------------*/
  List sharingIcons = [
    FontAwesome.whatsapp,
    FontAwesome.facebook,
    FontAwesome.envelope,
    FontAwesome.linkedin,
    FontAwesome.twitter,
    FontAwesome.external_link,
  ];
  List sharingIconsText = [
    "whatsapp",
    "facebook",
    "Email",
    "linkedin",
    "twitter",
    "Copy Link",];
  List sharingIconBGColors = [
    ConstantColor.whatsappBGColor,
    ConstantColor.facebookBGColor,
    ConstantColor.emailBGColor,
    ConstantColor.linkedInBGColor,
    ConstantColor.twitterBGColor,
    ConstantColor.primaryBlackColor,
  ];
/*------------------------------icon and text data list end--------------------*/
  var userId;
//--------------------------api data start----------------
  ShowStoreDetails? sellerStoreDetails;
  List<SellerDetails> sellerAllDetailsList=[];
  bool isLoading = false;
  bool isLoading2 = false;
  fetchSellerDataList({sIds}) async {
    try {
      SharedPreferences preference = await SharedPreferences.getInstance();
      userId = preference.getString("userId");
      setState(() {
        isLoading = true;
        isLoading2 = true;
      });
      final body = {
        "sid": sIds,
        "lat": 22.719568333333335,
        "long": 75.85772,
        "user_id": userId
      };

      final response = await Dio().post(
        "${ConstantUrls.baseUriApi}${ConstantUrls.getSellerDetails}",
        options: Options(
          headers: {
            "Authorization": ConstantToken.authorizationToken,
            'Content-Type': 'application/json',
          },
        ),
        data: json.encode(body),
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.data.toString());
        sellerStoreDetails = ShowStoreDetails.fromJson(responseData);
        setState(() {
          sellerAllDetailsList.add(sellerStoreDetails!.data!.sellerDetails!);
        });
      } else {
        // Handle the error case
      }
      setState(() {
        isLoading = false;
        isLoading2 = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
        isLoading2 = false;
      });
    }
  }
//--------------------------api data end----------------

  @override
  void initState() {
    super.initState();
    fetchSellerDataList(
      sIds: widget.sellerIds,
      // sIds: widget.storeDetails
    );
  }


  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      icon: circleIcon(
        onPressed: () {Navigator.of(context).pop();},
        backgroundColor:  ConstantColor.primaryMainColor,
        iconSize: 15.0, radius: 15.0,
        icons: Icons.close_outlined,
        iconcolor: ConstantColor.primaryBackgroundMainColor,),
      contentPadding: EdgeInsets.symmetric(vertical: screenHeight/80),
      iconPadding: EdgeInsets.only(left: screenWidth / 1.4, top: screenHeight/150),
      title: Center(
        child:customeText(
            text: "Share With Friends",
            style: ConstantTextStyle.topCategoryText2,
            textAlign: TextAlign.center),),
      content: customeText(
          text: "Select From The Options Below",
          style: ConstantTextStyle.lableTextStyle2,
          textAlign: TextAlign.center),
      actionsPadding: EdgeInsets.symmetric(horizontal: screenWidth /30,vertical: screenHeight/50),
      actions: [ isLoading
          ? const Center(
        child: CircularProgressIndicator(
          color: ConstantColor.primaryMainColor,
        ),
      )
          : SizedBox(
        height: screenHeight/6, width: double.maxFinite,
        child:GridView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: sharingIcons.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Rest of your code...
                ...sellerAllDetailsList.map((sellerDetails) {
                  return  boxIcon(
                      onTap: () {
                        switch (index) {
                          case 0:
                          // WhatsApp
                            String phoneWhatsapp = sellerDetails.contactNo ?? "";
                            String phoneWhatsappMessage = sellerDetails.whatsapptext ?? "";
                            if (phoneWhatsapp.isNotEmpty) {
                              _launchWhatsApp(phoneWhatsapp,phoneWhatsappMessage);
                            }
                            break;
                          case 1:
                          // Facebook
                            String phoneFacebook = sellerDetails.facebookUrl ?? "";
                            if (phoneFacebook.isNotEmpty) {
                              _launchFaceBook(phoneFacebook);
                            } else {
                            }
                            break;
                          case 2:
                          // Email
                            String phoneEmail = sellerDetails.email ?? "";
                            if (phoneEmail.isNotEmpty) {
                              _emailContact(phoneEmail);
                            }else {
                            }
                            break;
                          case 3:
                            _launchLinkedIn();
                            break;
                          case 4:
                          // Twitter
                            String phoneTwitter = sellerDetails.twitterUrl?? "";
                            if (phoneTwitter.isNotEmpty) {
                              _launchTwitter(phoneTwitter);
                            }else {
                            }
                            break;
                          case 5:
                          // Copy Link
                            _showPopUpAndCopyLink();
                            break;
                          default:
                            break;
                        }
                      },
                      height: screenHeight/25,width: screenWidth/10,
                      borderRadius: BorderRadius.circular(8.0),
                      bgcolor: (sharingIconBGColors[index]),
                      icon: (sharingIcons[index]),iconcolor: ConstantColor.primaryBackgroundMainColor
                  );}).toList(),
                // Rest of your code...
                customeText(text: (sharingIconsText[index]),style: ConstantTextStyle.becomeSellerDiscText, textAlign: TextAlign.center),
              ],
            );
          },
        ),
      ),
      ],
    );
/*---------------------------------Dialog Box end----------------------------------------*/
  }
}
