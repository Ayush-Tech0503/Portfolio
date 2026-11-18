// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:Citybazar_app/Util/constant_color.dart';
import 'package:Citybazar_app/Util/constant_image.dart';
import 'package:Citybazar_app/Widgets/Famous%20Market%20Widget/store_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../Util/constaint_textstyle.dart';
import '../../../../Widgets/Send Enquiry dialogBox/alert_dialog_box.dart';
import '../../../../Widgets/custome_text.dart';


class CBOShareAppScreen extends StatefulWidget {
  const CBOShareAppScreen({super.key});

  @override
  State<CBOShareAppScreen> createState() => _CBOShareAppScreenState();
}

class _CBOShareAppScreenState extends State<CBOShareAppScreen> {

/*-------------------------whatsapp share start----------------------------------------------*/
  void _joinWhatsAppGroup() async {
    const groupLink = 'https://chat.whatsapp.com/https://chat.whatsapp.com/LN4ItKnPrW8Jtrdwby4Vsk';
    if (await canLaunch(groupLink)) {
      await launch(groupLink);
    } else {
      throw 'Could not launch WhatsApp group: $groupLink';
    }
  }
/*-------------------------------whatsapp share end----------------------------------------*/
/*-------------------------------Facebook share start----------------------------------------*/
  void _launchFaceBook() async {
   // if (facebookUrl != null && facebookUrl.isNotEmpty) {
      String url = 'https://www.facebook.com/citybazaronlinecom';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
   // }
  }
/*-------------------------------Facebook share end----------------------------------------*/
  /*----------------------------- LinkedIn redirect end--------------------------*/
  void _launchLinkedIn() async {
    const url = "https://www.linkedin.com/company/citybazaronline/";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';} }

  /*----------------------------- LinkedIn redirect end--------------------------*/
  /*----------------------------- twitter redirect end--------------------------*/
  void _launchTwitter() async {
    // if (twitterUrl != null && twitterUrl.isNotEmpty) {
      String url = "https://twitter.com/citybazaronline";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
    //  }
    }
  }
  /*----------------------------- twitter redirect end--------------------------*/

  /*----------------------------- youtube redirect start--------------------------*/
  void _openYoutubeChannel() async {
    String channelUrl = 'https://www.youtube.com/channel/UC52Sz9lGHUCJax7Q3RS9e6A';

    if (await canLaunch(channelUrl)) {
      await launch(channelUrl);
    } else {
      throw 'Could not launch $channelUrl';
    }
  }

  /*----------------------------- youtube redirect end--------------------------*/
  /*----------------------------- pinterest redirect start--------------------------*/
  void _openPinterest() async {
    String pinterestUrl = 'https://www.pinterest.com/citybazaronline/';
    if (await canLaunch(pinterestUrl)) {
      await launch(pinterestUrl);
    } else {
      throw 'Could not launch $pinterestUrl';
    }
  }
  /*----------------------------- pinterest redirect end--------------------------*/
  /*----------------------------- Instagram redirect start--------------------------*/
  void _openInstagram() async {
    String instagramUrl = 'https://www.instagram.com/indore_bazar_shopping';
    if (await canLaunch(instagramUrl)) {
      await launch(instagramUrl);
    } else {
      throw 'Could not launch $instagramUrl';
    }
  }
  /*----------------------------- Instagram redirect end--------------------------*/


  /*----------------------------- Copy linked popup start--------------------------*/
  void _showPopUpAndCopyLink() {
    // Your existing code to show the popup
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          content: Text('Link copied!', style: ConstantTextStyle.richtext1),
        );
      },
    );

    // Copy the Play Store link to the clipboard
    Clipboard.setData(const ClipboardData(
      text: 'https://play.google.com/store/apps/details?id=com.citybazaronline&hl=en_IN&gl=US',
    ));

    // Close the popup after a delay
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pop();
    });
  }

  /*----------------------------- Copy linked popup end--------------------------*/

/*------------------------------icon and text data list start--------------------*/
  List sharingIcons = [
    FontAwesome.whatsapp,
    FontAwesome.facebook,
    FontAwesome.instagram,
    // FontAwesome.envelope
    FontAwesome.linkedin,
    FontAwesome.twitter,
    FontAwesome.youtube,
    FontAwesome.pinterest,
    FontAwesome.external_link,
    // FontAwesome.share_square_o,
  ];
  List sharingIconsText = [
    "whatsapp",
    "facebook",
    'Instagram',
    // "Email",
    "linkedin",
    "twitter",
    "youtube",
    "pinterest",
    "Copy Link",
    // "All Apps",
  ];
  List sharingIconBGColors = [
    ConstantColor.whatsappBGColor,
    ConstantColor.facebookBGColor,
    ConstantColor.instagramBGColor,
    // ConstantColor.emailBGColor,
    ConstantColor.linkedInBGColor,
    ConstantColor.twitterBGColor,
    ConstantColor.youtubeBGColor,
    ConstantColor.pintrestBGColor,
    ConstantColor.primaryBlackColor,
    ConstantColor.secondtryGrayColor,
  ];
/*------------------------------icon and text data list end--------------------*/

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
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
      iconPadding: EdgeInsets.only(left: screenWidth / 1.5, top: screenHeight/100),
      title: Center(
        child:customeText(
            text: "You can follow us",
            style: ConstantTextStyle.cardbottumText,
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
        height: screenHeight/6,
        width: double.maxFinite,
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
                    boxIcon(
                      onTap: () {
                        switch (index) {
                          case 0:
                          // WhatsApp
                            _joinWhatsAppGroup();
                            break;
                          case 1:
                          // Facebook
                              _launchFaceBook();
                            break;
                          case 2:
                            // Instagram
                            _openInstagram();
                            break;
                          case 3:
                            // linkedIn
                            _launchLinkedIn();
                            break;
                          case 4:
                          // Twitter
                              _launchTwitter();
                            break;
                            case 5:
                          // Youtube
                              _openYoutubeChannel();
                            break;
                          case 6:
                          // Pinterest
                            _openPinterest();
                            break;
                            case 7:
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
                  ),
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
