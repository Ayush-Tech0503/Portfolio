import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../Util/constant_image.dart';
import 'asset_images_widget.dart';

Widget cachedImageWidget ({imageFile,fit,width,height,borderRadius,assetImageFit,context}){
  return ClipRRect(
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
  );
}