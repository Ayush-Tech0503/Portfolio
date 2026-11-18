import 'package:Citybazar_app/Util/constant_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../Util/constant_image.dart';
Widget promotionStore ({cardBorderRadius, imageRadius,image,imgHeight,context,
  imgWidth,fit,titleText,overflow,titleTextStyle,titleTextAlign, cardPadding,onTapped}){
  var screenHeight = MediaQuery.of(context).size.height;
  var screenWidth = MediaQuery.of(context).size.width;
  return Container(
    // padding: cardPadding,
    decoration: BoxDecoration( border: Border.all(width: 0.5,color: ConstantColor.carColor2),borderRadius: BorderRadius.circular(8.0)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTapped,
          child: ClipRRect(
            borderRadius: imageRadius,
            child:CachedNetworkImage(
              imageUrl: image,height: imgHeight,width: imgWidth,
              fit: fit,
              imageBuilder: (context, imageProvider) =>
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
              errorWidget: (context, url, error) =>
                  Image.asset(
                    ConstantImage.imageIsNotAvailable,
                    height: screenHeight /8,
                    width: screenWidth /2,
                    fit: BoxFit.fill,
                  ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: screenWidth/40),
          child: Text(
             titleText,style: titleTextStyle,overflow: overflow,
            textAlign: titleTextAlign,
          ),
        ),
      ],
    ),
  );
}