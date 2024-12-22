
// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables, use_build_context_synchronously, deprecated_member_use, empty_catches
import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import '../../Api Services/Report And  Block Content Api Services/report_and_block_api.dart';
import '../../Util/constaint_textstyle.dart';
import '../../Util/constant_color.dart';
import '../../Util/constant_image.dart';
import '../../Widgets/Login Check Widget/login_check_widget.dart';
import '../../Widgets/Send Enquiry dialogBox/alert_dialog_box.dart';
import '../../Widgets/custome_text.dart';
import '../../Widgets/landing_screen_slider.dart';
import '../../services/KPI Api Service /shop_addmin_permition_kpi_api.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  // final String videoSize;
  final String view;
  // final  storeImage;
  final  shareLink;
  final String likeCount;
  final String sellerName;
  final String followText;
  final String sellerLogo;
  final  sellerId;
  final  reelId;
  final iconLiked;
  final iconFollow;
  final iconLikedColor;
  final iconSaveReelColor;
  final iconSaveReel;
  // final iconShareReel;
  final Function() onTap;
  final Function() nameOnTap;
  // final Function() onTapShareReel;
  final Function() onTapSaveReel;
  final Function() onTapFollowReel;
  final Function() chatWithSellerOnPressed;
  final Function() visitStoreOnPressed;
  // final VideoPlayerController videoPlayerController;
  // final Function() onDoubleTap;

  const VideoPlayerWidget(
      {super.key,
        // required this.videoPlayerController,
        required this.videoUrl,
         // this.storeImage,
         this.shareLink,
        // required this.videoSize,
        required this.sellerName,
        required this.sellerId,
        required this.reelId,
        required this.likeCount,
        required this.sellerLogo,
        required this.followText,
        required this.view,
        required this.iconLiked,
        required this.iconLikedColor,
        required this.iconFollow,
        // required this.iconShareReel,
        required this.iconSaveReelColor,
        required this.iconSaveReel,
        required this.onTap,
        required this.nameOnTap,
        required this.onTapSaveReel,
        // required this.onTapShareReel,
        required this.onTapFollowReel,
        required this.chatWithSellerOnPressed,
        required this.visitStoreOnPressed
      });

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> with WidgetsBindingObserver {
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;
  DateTime lastCacheClearTime = DateTime.now();
  bool _isPlaying = false;
  @override
  void initState() {
    super.initState();
    initializePlayer(widget.videoUrl);
    // Add the observer in the initState
    WidgetsBinding.instance.addObserver(this);
  }

  //Initialize Video Player
  void initializePlayer(String url) async {
    // final fileInfo = await checkCacheFor(url);
    // //print("data-------------1$fileInfo");
    try {
      // _controller = VideoPlayerController.networkUrl(Uri.parse(url));
      _controller = VideoPlayerController.network(url);
      _initializeVideoPlayerFuture = _controller!.initialize().then((_) {
        cachedForUrl(url);
        setState(() {});
        //print('Initialization successful for----------------- $url');
        setState(() {
          // Pause the video initially
          _controller!.play();
          _isPlaying = true;
        });
      });
      _controller!.setLooping(true);
      _controller!.addListener(() {if (_controller!.value.hasError) { }});
      _isPlaying = false;




    } catch (e) {}
    if (mounted) {
      setState(() {});
    }
  }

//: check for cache
  Future<FileInfo?> checkCacheFor(String url) async {
    final FileInfo? value = await DefaultCacheManager().getFileFromCache(url);
    return value;
  }

//:cached Url Data
  void cachedForUrl(String url) async {
    await DefaultCacheManager().getSingleFile(url).then((value) {
      //print('downloaded successfully done for------------- $url');
    });
  }

  @override
  void dispose() {
    // Remove the observer in the dispose
    WidgetsBinding.instance.removeObserver(this);
    // Check if the video is playing and pause it before disposing
    if (_controller != null && _controller!.value.isPlaying) {
      _controller!.pause();
    }
    _controller!.pause();
    _controller!.dispose();
    super.dispose();
  }

  // Override the didChangeAppLifecycleState method
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // Pause the video when the app goes into the background
    if (state == AppLifecycleState.paused) {
      if (_controller != null && _controller!.value.isPlaying) {
        _controller!.pause();
        setState(() {
          _isPlaying = false;
        });
      }
    }

    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      if (_controller != null) {
        // _controller!.pause();
        // _isPlaying = false;
        // _controller = null;
      }
    }

    // Resume the video when the app comes back to the foreground
    // if (state == AppLifecycleState.resumed) {
    //   if (_controller != null && !_controller!.value.isPlaying) {
    //     _controller!.play();
    //     setState(() {
    //       _isPlaying = true;
    //     });
    //   }
    // }
  }

  //old ------app cycle -----------------------------------

  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);
  //
  //   // Pause the video when the app goes into the background
  //   if (state == AppLifecycleState.paused) {
  //     if (_controller != null && _controller!.value.isPlaying) {
  //       _controller!.pause();
  //       setState(() {
  //         _isPlaying = false;
  //       });
  //     }
  //   }
  //
  //   // Resume the video when the app comes back to the foreground
  //   if (state == AppLifecycleState.resumed) {
  //     if (_controller != null && !_controller!.value.isPlaying) {
  //       _controller!.play();
  //       setState(() {
  //         _isPlaying = true;
  //       });
  //     }
  //   }
  // }


  bool isLoadingShare = false;

  // Future<void> shareFile(imageUrl,String shareText) async {
  //   try {
  //     setState(() {
  //       isLoadingShare = true;
  //     });
  //     if (imageUrl == "") {
  //       // If imageUrl is null, load an asset image
  //       final ByteData assetByteData = await rootBundle.load(ConstantImage.cityBazaarShareApp);
  //       final Uint8List bytes = assetByteData.buffer.asUint8List();
  //
  //       // Save the image to a temporary file
  //       final temp = await getTemporaryDirectory();
  //       final path = '${temp.path}/image1.jpg';
  //       File(path).writeAsBytesSync(bytes);
  //
  //       // Share the image
  //       await Share.shareFiles([path], text: shareText);
  //     }
  //     else {
  //       Dio dio = Dio();
  //       Response<List<int>> response = await dio.get<List<int>>(
  //         imageUrl.toString(),
  //         options: Options(responseType: ResponseType.bytes),
  //       );
  //
  //       Uint8List bytes = Uint8List.fromList(response.data!);
  //
  //       // Save the image to a temporary file
  //       final temp = await getTemporaryDirectory();
  //       final path = '${temp.path}/image1.jpg';
  //       File(path).writeAsBytesSync(bytes);
  //
  //       // Share the image
  //       await Share.shareFiles([path], text: shareText);
  //       setState(() {
  //         isLoadingShare = false;
  //       });
  //     }
  //   } catch (error) {
  //     setState(() {
  //       isLoadingShare = false;
  //     });
  //   }
  //   finally {
  //     setState(() {
  //       isLoadingShare = false; // Set loading to false when sharing is completed or error occurs
  //     });
  //   }
  // }

  Future<void> shareFile(String shareText) async {
    try {
      setState(() {
        isLoadingShare = true;
      });
      await Share.share(shareText);
    } catch (error) {
      setState(() {
        isLoadingShare = false;
      });
    } finally {
      setState(() {
        isLoadingShare = false;
      });
    }
  }


  bool isUserLoggedIn = false;
  var tokenAccess;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return  Container(
      color: ConstantColor.drawerDividerColor,
      child:
      SafeArea(
        child: Scaffold(
          backgroundColor: ConstantColor.primaryBlackColor,
          body: GestureDetector(
            // onDoubleTap: widget.onDoubleTap,
            onTap: () {
              setState(() {
                if (_controller!.value.isPlaying) {
                  _controller!.pause();
                  _isPlaying = false;
                } else {
                  _controller!.play();
                  _isPlaying = true;
                }
              });
            },
            child:  Stack(
              children: [
                SizedBox(
                  height: screenHeight / 1.15,
                  width: screenWidth,
                  child: FutureBuilder(
                    future: _initializeVideoPlayerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return
                          // Stack(
                          // children: [
                            VideoPlayer(_controller!);
                            // Positioned(
                            //   top: 0,
                            //   left: 0,
                            //   right: 0,
                            //   child:
                            //   VideoProgressIndicator(
                            //     _controller!,
                            //     allowScrubbing: true,
                            //     colors:  const VideoProgressColors(
                            //       bufferedColor: ConstantColor.carColor,
                            //       playedColor: ConstantColor.primaryMainColor,
                            //       backgroundColor: ConstantColor.iconBackTPColor,
                            //     ),
                            //   ),
                            // ),
                        //   ],
                        // );
                      } else if (snapshot.hasError) {
                        // Handle video initialization errors here
                        return const Center(
                          child: Text("Error loading video"),
                        );
                      } else {
                        return const Center(
                          child: SpinKitRipple(
                            color: ConstantColor.secondtryGrayColor,
                            size: 200,
                          ),
                        );
                      }
                    },
                  ),
                ),
                Center(
                  child: Visibility(
                    visible: !_isPlaying,
                    child: const Icon(
                      Icons.play_circle_rounded,
                      color: ConstantColor.primaryBackgroundMainColor,
                      size: 100.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.00,
                    horizontal: screenWidth * 0.03,
                  ),
                  child: ListTile(
                    onTap: (){
                      // Pause the video when the button is pressed
                      if (_controller != null && _controller!.value.isPlaying) {
                        _controller!.pause();
                        // Optionally, you can update the state to reflect the paused state
                        setState(() {
                          _isPlaying = false;
                        });
                      }
                      widget.nameOnTap();
                    },
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
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
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
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
                  bottom: screenHeight/10,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // customeText(
                      //   textAlign: TextAlign.start,
                      //   text: widget.videoSize,
                      //   overflow: TextOverflow.ellipsis,
                      //   maxLine: 1,
                      //   style: ConstantTextStyle.reviewsRatingsText,
                      // ),
                      // SizedBox(height: screenHeight * 0.01),
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
                        splashColor: ConstantColor.primaryMainColor,
                        hoverColor: ConstantColor.primaryGreyColor,
                        focusColor: ConstantColor.profileGridBGolor,
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
                        onPressed: () async {
                          //  if (_controller != null && _controller!.value.isPlaying) {
                             _controller!.pause();
                          //   setState(() {
                              _isPlaying = false;
                          //   });
                          // }
                           // onTapShareReel: () {
                           //   shareFile(widget.storeImage, widget.shareLink??"");
                            await shareFile("Hey! Check out ${widget.sellerName??""} store on CityBazaarOnline!\n ${widget.shareLink??""}");
                             await storePageKpiApiServices(type: 'store_share',sellerId: widget.sellerId.toString(),);

                          //   // shareFile(shareLink??"");
                           // },
                          // widget.onTapShareReel();
                        },
                        icon:  Icon(
                          isLoadingShare
                              ? Icons.change_circle_outlined
                              :FontAwesomeIcons.share,
                          //ShareAppScreen(sellerIds: widget.sellersId.toString(),  );
                          // widget.iconShareReel,
                          // FontAwesomeIcons.share,
                          color: ConstantColor.primaryBackgroundMainColor,
                          size: 30.0,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      IconButton(
                        onPressed: () async{
                          SharedPreferences preferences = await SharedPreferences.getInstance();
                          setState(() {
                            isUserLoggedIn = preferences.getBool("isLogin") ?? false;
                            tokenAccess = preferences.getString("access-token");
                          });
                          if (isUserLoggedIn) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return OptionDialog(
                                    // tokenAccess: tokenAccess,
                                    reelId: widget.reelId,
                                    sellerId: widget.sellerId,
                                    options: const [
                                      'Violent or repulsive content',
                                      'Hateful or abusive content',
                                      'Harassment or bullying',
                                      'Harmful or dangerous acts',
                                      'Misinformation',
                                      'Child abuse',
                                      'Promotes terrorism',
                                      'Spam or misleading',
                                      'Legal issue',
                                      'Captions issue',
                                      'Spam',
                                      'Fraud seller',
                                      'Other'
                                    ]);
                              },
                            );
                          }
                          else{
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return const CheckIsLogin();
                              },
                            );
                          }
                        },
                        icon:  const Icon(
                          Icons.more_vert,
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
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child:
                  VideoProgressIndicator(
                    _controller!,
                    allowScrubbing: true,
                    colors:  const VideoProgressColors(
                      bufferedColor: ConstantColor.carColor,
                      playedColor: ConstantColor.primaryMainColor,
                      backgroundColor: ConstantColor.iconBackTPColor,
                    ),
                  ),
                ),
                Positioned(
                  right: 0.0,
                  left: 0.0,
                  bottom: screenHeight/60.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: iconTextButton(
                          backgroundColor: ConstantColor.loginWithOtpButtonColor,
                          icon: Icons.store_outlined,
                          iconColor: ConstantColor.primaryBackgroundMainColor,
                          iconSize: 20.0,
                          buttonOnPressed: () {
                            // Pause the video when the button is pressed
                            if (_controller != null && _controller!.value.isPlaying) {
                              _controller!.pause();
                              // Optionally, you can update the state to reflect the paused state
                              setState(() {
                                _isPlaying = false;
                              });
                            }
                            // Call your visitStoreOnPressed method
                            widget.visitStoreOnPressed();
                          },
                          // buttonOnPressed: widget.visitStoreOnPressed,
                          buttontext: "Visit Store",
                          buttontextStyle: ConstantTextStyle.newiconButtonText,
                          fixedSize: const Size(190, 1),
                        ),
                      ),
                      SizedBox(width: screenWidth/50,),
                      Flexible(
                        child: iconTextButton(
                          backgroundColor: ConstantColor.filedContainerColor,
                          icon: Icons.message_sharp,
                          iconColor: ConstantColor.primaryBackgroundMainColor,
                          iconSize: 20.0,
                          buttonOnPressed: () {
                            // Pause the video when the button is pressed
                            if (_controller != null && _controller!.value.isPlaying) {
                              _controller!.pause();
                              // Optionally, you can update the state to reflect the paused state
                              setState(() {
                                _isPlaying = false;
                              });
                            }
                            // Call your visitStoreOnPressed method
                            widget.chatWithSellerOnPressed();
                          },
                          // buttonOnPressed: widget.chatWithSellerOnPressed,
                          buttontext: "Chat With Seller",
                          buttontextStyle: ConstantTextStyle.newiconButtonText,
                          fixedSize: const Size(190, 1),
                        ),
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




class OptionDialog extends StatefulWidget {
  final List<String> options;
  final reelId;
  final sellerId;
  // final tokenAccess;

  const OptionDialog({super.key, required this.options, this.reelId, this.sellerId});

  @override
  _OptionDialogState createState() => _OptionDialogState();
}

class _OptionDialogState extends State<OptionDialog> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return AlertDialog(
    contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      title: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: screenWidth/40,vertical: screenHeight/100),
        horizontalTitleGap: 5.0,
        dense: true,
        leading: customeText(text:'\u26D4',style:const TextStyle(fontSize: (30.0))),
        title: customeText(text:'Report this content', style: ConstantTextStyle.topCategoryText4,),
          subtitle: customeText(text: "You can report this seller's content. Please select from the options below.", style: ConstantTextStyle.lableTextStyle2),
      trailing: circleIcon(
        onPressed: () {Navigator.of(context).pop();},
        backgroundColor:  ConstantColor.primaryMainColor,
        iconSize: 16.0, radius: 15.0,
        icons: Icons.close,
        iconcolor: ConstantColor.primaryBackgroundMainColor,),
      ),
      // title: Text('Report this content',style: ConstantTextStyle.topCategoryText4),
      content:
      SizedBox(
        height: screenHeight/2,
        width: double.maxFinite,
        child: CupertinoScrollbar(
         child: ListView(
            shrinkWrap: true,
            children: _buildRadioListTiles(),
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: EdgeInsets.zero,
      actions: [
        const Divider(),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(_selectedOption);
                },
                child: const Text('Cancel'),
              ),
              const VerticalDivider(),
               TextButton(
                onPressed:  _selectedOption == null ? null :()
                {
                  ReportApi.fetchReportBlockContentApi(context:context,
                      type: 'reel',
                      typeId: '${widget.reelId}',
                      reportData: '$_selectedOption');
                  // Navigator.of(context).pop();
                },
                child:  Text('Report',style: _selectedOption == null ? null :ConstantTextStyle.tabButtonTextStyle,),
              ),
            ],
          ),
        ),
      ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
    );
  }

  List<Widget> _buildRadioListTiles() {
    return widget.options.map((option) {
      return Card(
        child: RadioListTile(
          dense: true,
          activeColor: ConstantColor.primaryMainColor,
          title: Text(option,style: ConstantTextStyle.allHomeScreenAvatarText,),
          value: option,
          groupValue: _selectedOption,
          onChanged: (value) {
            setState(() {
              _selectedOption = value;
            });
          },
        ),
      );
    }).toList();
  }
}

