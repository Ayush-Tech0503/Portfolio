import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../Util/constant_image.dart';
Widget customImg({image, height, width, fit, ontap}) {
  return GestureDetector(
    onTap: ontap,
    child: Image.asset(
      image,
      height: height,
      width: width,
      fit: fit,
    ),
  );
}
/////////////////////////////////////////////////

Widget customNetworkImg({image, height, width, fit, ontap}) {
  return GestureDetector(
    onTap: ontap,
    child: Image.network(
      image,
      height: height,
      width: width,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          ConstantImage.imageIsNotAvailable,
          fit: BoxFit.fill,
          height: height,
          width: width,
        );
      },
    ),
  );
}

/*---------------------------------boxImage with Border and Shadow Widget -----------------*/

Widget boxImage(
    {backGroundColor,
    backGroundborderRadius,
    fit, image,
    shadowColor,
    blurRadius,
    borderColor,
    imageHeight,
    imageWidth,
      boxHeight,
      errorImageHeight,
      errorImageWidth,
      boxwidth,
      onTap,
    fitImage = BoxFit.fill}) {
  return GestureDetector(
    onTap: onTap,
    child: CachedNetworkImage(
      imageUrl: image,
      height: imageHeight,
      width: imageWidth,
      fit: fitImage,
      errorWidget: (context, url, error) =>
          Image.asset(
            ConstantImage.imageIsNotAvailable,
            height: errorImageHeight,
            width: errorImageWidth,
            fit: BoxFit.fill,
          ),
    )
  );
}
