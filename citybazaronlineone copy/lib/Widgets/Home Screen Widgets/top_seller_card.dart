import 'package:Citybazar_app/Util/constant_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../Util/constant_image.dart';

Widget topSellerCard ({context,cardBorderRadius,img,imgWidth, imgHeight, fit,
  titleText,textAlign,maxLines,imgBorderRadius,borderColor,onTap,
  titleTextStyle,}){
  var screenHeight = MediaQuery.of(context).size.height;
  var screenWidth = MediaQuery.of(context).size.height;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
            width: 1.0,
          ),
          color: ConstantColor.secondoryWhiteColors,
          borderRadius: cardBorderRadius,
        ),
        child:GestureDetector(
          onTap: onTap,
          child: ClipRRect(
            borderRadius: imgBorderRadius,
            child: CachedNetworkImage(
              imageUrl: img,
              width: imgWidth,
              height: imgHeight,
              fit: fit,
              imageBuilder: (context, imageProvider) =>
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
              errorWidget: (context, url, error) =>
                  Image.asset(
                    ConstantImage.imageIsNotAvailable,
                    width: screenWidth/4,
                    height: screenHeight/10,
                    fit: BoxFit.fill,
                  ),
            ),
          ),
        ),
      ),
      SizedBox(height: screenHeight/300,),
      Flexible(
        child: SizedBox(
          width: screenWidth/10,
          child: Text(
            titleText,
            textAlign:textAlign,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            style: titleTextStyle,
          ),
        ),
      ),
    ],
  );
}