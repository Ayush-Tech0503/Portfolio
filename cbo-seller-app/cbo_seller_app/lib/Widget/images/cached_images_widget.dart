import 'package:cached_network_image/cached_network_image.dart';
import 'package:citybazaronline_seller_app/Widget/images/asset_images_widget.dart';
import 'package:flutter/material.dart';
import '../../Utils/Constant Images/constant_images.dart';
import '../Zooming Image/zoomable_image_widget.dart';
import '../page_navigation_animation_widget.dart';

Widget cachedImageWidget ({imageFile,fit,width,height,borderRadius,assetImageFit,context}){
  return GestureDetector(
    onTap: () async { await Navigator.of(context).push(pageAnimationWidget(begin: const Offset(0.0, 1.0), InteractiveViewerScreen(imageUrl: imageFile,)));},
    child: ClipRRect(
      borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(10.0)),
      child: CachedNetworkImage(
        imageUrl: imageFile,
        height: height,
        width: width,
        fit: BoxFit.fill,
        errorWidget: (context, url, error) =>
            assetImageWidget(imageFile: ConstantImage.imageIsNotAvailable,
              fit: assetImageFit ?? BoxFit.fill,
            ),
      ),
    ),
  );
}