// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables, duplicate_ignore

import 'dart:convert';
import 'dart:io';
import 'package:Citybazar_app/Util/constant_color.dart';
import 'package:Citybazar_app/Widgets/Famous%20Market%20Widget/store_details_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Models/Show Store Details Models/store_details.dart';
import '../../../Util/Constant APi Url/api_urls.dart';
import '../../../Util/constaint_textstyle.dart';
import '../../../Util/constant_image.dart';
import '../../../Util/constant_token.dart';
import '../../../Widgets/Send Enquiry dialogBox/alert_dialog_box.dart';
import '../../../Widgets/custome_text.dart';
import '../../../services/KPI Api Service /shop_addmin_permition_kpi_api.dart';

class ShareAppScreen extends StatefulWidget {
  final String? sellerIds;
  final String? latitude;
  final String? longitude;
  final String? myStoreImage;
  const ShareAppScreen({super.key, this.sellerIds, this.latitude, this.longitude, this.myStoreImage});

  @override
  State<ShareAppScreen> createState() => _ShareAppScreenState();
}

class _ShareAppScreenState extends State<ShareAppScreen> {

/*-------------------------whatsapp share start----------------------------------------------*/

  void _launchWhatsApp(String url) async {
    var whatsappUrl = 'https://wa.me/?text=$url';
        //"whatsapp://send?text=$message : $url";
    await canLaunch(whatsappUrl)
        ? launch(whatsappUrl)
        : print('Could not launch $whatsappUrl');
    await storePageKpiApiServices(type: "store_share", sellerId: widget.sellerIds.toString());

  }
/*-------------------------------whatsapp share end----------------------------------------*/
/*-------------------------------Facebook share start----------------------------------------*/
  // void _launchFaceBook(String? facebookUrl) async {
  //   if (facebookUrl != null && facebookUrl.isNotEmpty) {
  //     String url = 'https://www.facebook.com/$facebookUrl';
  //     if (await canLaunch(url)) {
  //       await launch(url);
  //     }
  //     // else {
  //     //   // If Facebook app is not available, launch the web version
  //     //   String webUrl = 'https://www.facebook.com/sharer/sharer.php?u=$url';
  //     //   if (await canLaunch(webUrl)) {
  //     //     await launch(webUrl);
  //     //   } else {
  //     //     throw 'Could not launch $webUrl';
  //     //   }
  //     // }
  //   }
  // }
  // // void _launchFaceBook(String? facebookUrl) async {
  // //   if (facebookUrl != null && facebookUrl.isNotEmpty) {
  // //     String url = 'https://www.facebook.com/$facebookUrl';
  // //     if (await canLaunch(url)) {
  // //       await launch(url);
  // //     } else {
  // //       throw 'Could not launch $url';
  // //     }
  // //   }
  // // }

  void _launchFaceBook(String url) async {
    // If Facebook app is not available, launch the web version
    String webUrl = 'https://www.facebook.com/sharer/sharer.php?u=$url';
    if (await canLaunch(webUrl)) {
      await launch(webUrl);
    } else {
      throw 'Could not launch $webUrl';
    }
    await storePageKpiApiServices(type: "store_share", sellerId: widget.sellerIds.toString());

  }
/*-------------------------------Facebook share end----------------------------------------*/
  /*----------------------------- Email  redirect end--------------------------*/
  void _emailContact(String link) async {
      String url = 'mailto:?body=$link'; // Add 'mailto:' to create a mail URL
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
      await storePageKpiApiServices(type: "store_share", sellerId: widget.sellerIds.toString());
  }

  /*----------------------------- Email  redirect end--------------------------*/
  /*----------------------------- LinkedIn redirect end--------------------------*/
  void _launchLinkedIn(String shareUrl) async {
    String encodedUrl = Uri.encodeFull(shareUrl);
    String url = "https://www.linkedin.com/sharing/share-offsite/?url=$encodedUrl";
    if (await canLaunch(url)) {
      await launch(url);
    }
    await storePageKpiApiServices(type: "store_share", sellerId: widget.sellerIds.toString());

  }

  /*----------------------------- LinkedIn redirect end--------------------------*/
  /*----------------------------- LinkedIn redirect end--------------------------*/
  void _launchTwitter(String shareUrl) async {
      String url = "https://twitter.com/intent/tweet?url=${Uri.encodeFull(shareUrl)}";
      if (await canLaunch(url)) {
        await launch(url);
    }
      await storePageKpiApiServices(type: "store_share", sellerId: widget.sellerIds.toString());
  }

  /*----------------------------- LinkedIn redirect end--------------------------*/
  /*----------------------------- Copy linked popup start--------------------------*/
  void _showPopUpAndCopyLink(String urlToCopy) {
    // Show AlertDialog
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
    // Copy URL to clipboard
    Clipboard.setData(ClipboardData(text: urlToCopy));
    // Close AlertDialog after 1 second
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pop();
    });
  }
  /*----------------------------- Copy linked popup end--------------------------*/

  shareFile(shareText) async {
    String networkImageUrl = widget.myStoreImage ?? ConstantImage.cityBazaarShareApp??"";
      HttpClient client = HttpClient();
      final Uri uri = Uri.parse(networkImageUrl);
      HttpClientRequest request = await client.getUrl(uri);
      HttpClientResponse response = await request.close();
      List<int> imageBytes = await consolidateHttpClientResponseBytes(response);
      final temp = await getTemporaryDirectory();
      final path = '${temp.path}/image1.jpg';
      File(path).writeAsBytesSync(imageBytes);
      await Share.shareFiles([path], text: shareText??"" );
      await storePageKpiApiServices(type: "store_share", sellerId: widget.sellerIds.toString());
  }


/*------------------------------icon and text data list start--------------------*/
  List sharingIcons = [
    FontAwesome.whatsapp,
    FontAwesome.facebook,
    FontAwesome.envelope,
    FontAwesome.linkedin,
    FontAwesome.twitter,
    FontAwesome.external_link,
    FontAwesome.share_square_o,
  ];
  List sharingIconsText = [
    "whatsapp",
    "facebook",
    "Email",
    "linkedin",
    "twitter",
    "Copy Link",
    "All Apps"];
  List sharingIconBGColors = [
  ConstantColor.whatsappBGColor,
  ConstantColor.facebookBGColor,
  ConstantColor.emailBGColor,
  ConstantColor.linkedInBGColor,
  ConstantColor.twitterBGColor,
  ConstantColor.primaryBlackColor,
    ConstantColor.secondtryGrayColor,
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
        "sid": widget.sellerIds,
        "lat": widget.latitude ?? 22.7177,
        "long": widget.longitude ?? 75.85772,
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
    fetchSellerDataList();
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
            String phoneWhatsappText1 = sellerStoreDetails!.shareLink ?? "";
            String phoneWhatsappText2 = phoneWhatsappText1!.replaceAll("api.", "");
            String shareOnLink = phoneWhatsappText2.replaceAll(".lab101.cloud", ".com");
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Rest of your code...
                  boxIcon(
                  onTap: () {
                    switch (index) {
                      case 0:
                      // WhatsApp
                        _launchWhatsApp('I found you on CItyBazaarOnline : $shareOnLink');
                        break;
                      case 1:
                      // Facebook
                        _launchFaceBook(shareOnLink??"");
                        break;
                      case 2:
                      // Email
                          _emailContact(shareOnLink??"");
                        break;
                      case 3:
                      _launchLinkedIn(shareOnLink??"");
                        break;
                      case 4:
                      // Twitter
                    _launchTwitter(shareOnLink??"");
                        break;
                      case 5:
                      // Copy Link
                        _showPopUpAndCopyLink(shareOnLink??"");
                        break;
                      case 6:
               //share link
                        shareFile("I found you on CityBazaarOnline : ${shareOnLink ?? ''}");
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





