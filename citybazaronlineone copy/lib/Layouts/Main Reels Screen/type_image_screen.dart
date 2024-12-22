// ignore_for_file: prefer_typing_uninitialized_variables, library_private_types_in_public_api

import 'dart:io';

import 'package:awesome_icons/awesome_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../Util/constaint_textstyle.dart';
import '../../Util/constant_color.dart';
import '../../Util/constant_image.dart';
import '../../Widgets/custome_text.dart';
import '../../Widgets/landing_screen_slider.dart';
import '../../services/KPI Api Service /shop_addmin_permition_kpi_api.dart';

class ImageReelWidget extends StatefulWidget {
  final String sellerName;
  final  storeImage;
  final  shareLink;
  final  sellerId;
  final String sellerLogo;
  final String likeCount;
  final String imageUrl;
  final String view;
  final String followText;
  final iconFollow;
  final iconLiked;
  final iconLikedColor;
  // final iconShareReel;
  final iconSaveReelColor;
  final iconSaveReel;
  final Function() onTap;
  final Function() nameOnTap;
  final Function() onTapFollowReel;
  // final Function() onTapShareReel;
  final Function() onTapSaveReel;
  final Function() chatWithSellerOnPressed;
  final Function() visitStoreOnPressed;

  const ImageReelWidget(
      {super.key,
        required this.imageUrl,
        this.storeImage,
        this.shareLink,
        this.sellerId,
        required this.sellerName,
        required this.followText,
        required this.likeCount,
        required this.sellerLogo,
        required this.iconFollow,
        required this.view,
        required this.iconLiked,
        required this.iconLikedColor,
        // required this.iconShareReel,
        required this.iconSaveReel,
        required this.iconSaveReelColor,
        // required this.onTapShareReel,
        required this.onTap,
        required this.nameOnTap,
        required this.onTapSaveReel,
        required this.onTapFollowReel,
        required this.chatWithSellerOnPressed,
        required this.visitStoreOnPressed
      });

  @override
  _ImageReelWidgetState createState() => _ImageReelWidgetState();
}

class _ImageReelWidgetState extends State<ImageReelWidget> {
  final bool _isPlaying = false;


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isLoadingShare = false;

  Future<void> shareFile(imageUrl,String shareText) async {
    try {
      setState(() {
        isLoadingShare = true;
      });
      if (imageUrl == "") {
        // If imageUrl is null, load an asset image
        final ByteData assetByteData = await rootBundle.load(ConstantImage.cityBazaarShareApp);
        final Uint8List bytes = assetByteData.buffer.asUint8List();

        // Save the image to a temporary file
        final temp = await getTemporaryDirectory();
        final path = '${temp.path}/image1.jpg';
        File(path).writeAsBytesSync(bytes);

        // Share the image
        await Share.shareFiles([path], text: shareText);
      }
      else {
        Dio dio = Dio();
        Response<List<int>> response = await dio.get<List<int>>(
          imageUrl.toString(),
          options: Options(responseType: ResponseType.bytes),
        );

        Uint8List bytes = Uint8List.fromList(response.data!);

        // Save the image to a temporary file
        final temp = await getTemporaryDirectory();
        final path = '${temp.path}/image1.jpg';
        File(path).writeAsBytesSync(bytes);

        // Share the image
        await Share.shareFiles([path], text: shareText);
        setState(() {
          isLoadingShare = false;
        });
      }
    } catch (error) {
      setState(() {
        isLoadingShare = false;
      });
    }
    finally {
      setState(() {
        isLoadingShare = false; // Set loading to false when sharing is completed or error occurs
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: ConstantColor.drawerDividerColor,
      child: SafeArea(
        child: Scaffold(
          body: GestureDetector(
            onTap: () {},
            child:  Stack(
              children: [
                Positioned(
                  top: screenHeight/40,
                  child: SizedBox(
                    height: screenHeight/1.12,
                    width: screenWidth,
                    child: CachedNetworkImage(
                        imageUrl: widget.imageUrl ?? "",
                        fit: BoxFit.fill,
                        imageBuilder: (context, imageProvider) =>
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                        errorWidget:
                            (context, url, error) =>
                        const Center(
                          child: Text("Sorry No Image Found!"),
                        )
                      //     Image.asset(
                      //   ConstantImage.imageIsNotAvailable,
                      //   fit: BoxFit.fill,
                      // ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.00,
                    horizontal: screenWidth * 0.03,
                  ),
                  child: ListTile(
                    onTap: widget.nameOnTap,
                    contentPadding: EdgeInsets.zero,
                    leading:  CircleAvatar(
                      backgroundColor: ConstantColor.primaryBackgroundMainColor,
                      radius: 24,
                      child: CircleAvatar(
                        radius: 23,
                        backgroundColor: ConstantColor.primaryBackgroundMainColor,
                        backgroundImage: widget.sellerLogo != null && widget.sellerLogo is String && widget.sellerLogo.isNotEmpty
                            ? NetworkImage(widget.sellerLogo) // Cast storeImage to String
                            : AssetImage(ConstantImage.imageIsNotAvailable)as ImageProvider,
                      ),
                    ),
                    title: customeText(
                      text: widget.sellerName,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: ConstantTextStyle.reviewsRatingsText,
                    ),
                    trailing: ElevatedButton.icon(
                      onPressed: widget.onTapFollowReel,
                      icon: Icon(
                        widget.iconFollow,
                        size: 20.0,
                      ),
                      label: Text(
                        widget.followText,
                        style: ConstantTextStyle.reviewsRatingsText,
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          ConstantColor.whatsappBGColor,
                        ),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        side: MaterialStateProperty.all<BorderSide>(
                          const BorderSide(color:ConstantColor.primaryBackgroundMainColor, width: 0.5,),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: screenWidth/60,
                  bottom: screenHeight/9,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.remove_red_eye_rounded,
                        color: ConstantColor.primaryBackgroundMainColor,
                        size: 0.03 * screenHeight,
                      ),
                      customeText(
                        textAlign: TextAlign.start,
                        text: widget.view,
                        overflow: TextOverflow.ellipsis,
                        maxLine: 1,
                        style: ConstantTextStyle.reviewsRatingsText,
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      IconButton(
                        onPressed: widget.onTap,
                        icon: Icon(
                          widget.iconLiked,
                          color:widget.iconLikedColor,
                          size: 30.0,
                        ),
                      ),
                      customeText(
                        textAlign: TextAlign.start,
                        text: widget.likeCount,
                        overflow: TextOverflow.ellipsis,
                        maxLine: 1,
                        style: ConstantTextStyle.reviewsRatingsText,
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      IconButton(
                        onPressed: widget.onTapSaveReel,
                        icon: Icon(
                          widget.iconSaveReel,
                          color:widget.iconSaveReelColor,
                          size: 30.0,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      IconButton(
                        onPressed:() async {
                          await shareFile(widget.storeImage, widget.shareLink??"");
                          await storePageKpiApiServices(type: 'store_share',sellerId: widget.sellerId.toString(),);
                        },
                        // widget.onTapShareReel,
                        icon: Icon(
                          isLoadingShare
                              ? Icons.change_circle_outlined
                              :FontAwesomeIcons.share,
                          // widget.iconShareReel,
                          color: ConstantColor.primaryBackgroundMainColor,
                          size: 30.0,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                    ],
                  ),
                ),
/*-----------------------------------Row send enquiry and chat icon start------------------------------------*/
                Positioned(
                  right: 0.0,
                  left: 0.0,
                  bottom: screenHeight/50.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      iconTextButton(
                        backgroundColor: ConstantColor.loginWithOtpButtonColor,
                        icon: Icons.store_outlined,
                        iconColor: ConstantColor.primaryBackgroundMainColor,
                        iconSize: 20.0,
                        buttonOnPressed: widget.visitStoreOnPressed,
                        buttontext: "Visit Store",
                        buttontextStyle: ConstantTextStyle.newiconButtonText,
                        fixedSize: const Size(190, 1),
                      ),
                      SizedBox(width: screenWidth/100,),
                      iconTextButton(
                        backgroundColor: ConstantColor.filedContainerColor,
                        icon: Icons.message_sharp,
                        iconColor: ConstantColor.primaryBackgroundMainColor,
                        iconSize: 20.0,
                        buttonOnPressed:  widget.chatWithSellerOnPressed,
                        buttontext: "Chat With Seller",
                        buttontextStyle: ConstantTextStyle.newiconButtonText,
                        fixedSize: const Size(190, 1),
                      ),
                    ],
                  ),
                ),
/*-----------------------------------Row send enquiry and chat icon end------------------------------------*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}