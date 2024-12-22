import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import '../../Layouts/constant_screen_layout.dart';
import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';

class InteractiveViewerScreen extends StatelessWidget {
  final String? imageUrl;

  const InteractiveViewerScreen({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;
    if (imageUrl!.startsWith('http://') || imageUrl!.startsWith('https://')) {
      imageProvider = CachedNetworkImageProvider(imageUrl!);
    } else {
      imageProvider = FileImage(File(imageUrl!));
    }
    var screenHeight = MediaQuery.of(context).size.height;
    return  AppLayout(
        title: "",
        titleStyle: ConstantTextStyle.landingScreenAppbarText,
        leading: IconButton(
        icon: const Icon(Icons.close_rounded,size: 30.0,), color: ConstantColor.drawerDividerColor,
    onPressed: () => Navigator.pop(context),
    ),
    scaffoldColor: ConstantColor.primaryBackgroundMainColor,
    appBarColor: ConstantColor.primaryBackgroundMainColor,
      body: SizedBox(
        height: screenHeight,
        child: PhotoView(
          backgroundDecoration: const BoxDecoration(color: ConstantColor.primaryBackgroundMainColor),
          imageProvider: imageProvider,
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 20,
        ),
      ),
    );
  }
}

