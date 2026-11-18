
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../Util/constant_color.dart';
import '../Util/constant_image.dart';
import 'custome_text.dart';

Widget homepageFamousMarketCard ({context, onTapped,cardBorderRadius, imgBorderRadius, img,
  fit, imgHeight, imgWidth,icon,iconColor,iconSize, marketTitleTextStyle, marketTitleText,}){
  var screenHeight = MediaQuery.of(context).size.height;
  var screenWidth = MediaQuery.of(context).size.width;
  return  Card(
    color: ConstantColor.secondoryMarketColors,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: cardBorderRadius,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: GestureDetector(
            onTap: onTapped,
            child: ClipRRect(
              borderRadius: imgBorderRadius,
              child: CachedNetworkImage(
                height:imgHeight,
                width:imgWidth,
                imageUrl: img,
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
                      height:screenHeight / 8,
                      width: screenWidth,
                      fit: BoxFit.fill,
                    ),
              ),
          
          
          
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: screenHeight/300,left: screenWidth/100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Icon(
                icon,
                color:iconColor,
                size: iconSize,
                             ),
              Flexible(
                child: customeText(
                  text:marketTitleText,
                  overflow: TextOverflow.ellipsis,
                  style: marketTitleTextStyle,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}



Widget startRating ({context,height,width,color,text2,style2,initialRating,minRating,itemSize,allowHalfRating,onRatingUpdate,itemCount,itemBuilder}){
  return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
           color: color,
          ),

          //padding: EdgeInsets.only(left: 50),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RatingBar.builder(
                initialRating: initialRating,
                itemSize: itemSize,
                minRating: minRating,
                ignoreGestures: true,
                direction: Axis.horizontal,
                allowHalfRating: allowHalfRating,
                itemCount: itemCount,
                itemBuilder: itemBuilder,
                onRatingUpdate:onRatingUpdate,
              ),
              Container(
                // padding: EdgeInsets.only(left: 10
                // ),
                  child: customeText(text: text2, style: style2, textAlign: TextAlign.start)
              ),


            ],
          ),

  );
}

// Widget iconTextRow ({text,style,icon,color,overflow}){
//   return  Row(
//     children: [
//       Icon(icon,color:color,),
//       customeText(text: text,overflow:overflow, style: style,),
//
//     ],
//   );
// }

Widget iconRichText ({text1,text2,icon,color,size,style2,style1}) {
  return Text.rich(
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    TextSpan(
      children: [
        TextSpan(text: text1, style: style1, ),
        WidgetSpan(child: Icon(icon,color:color, size: size, )),
        TextSpan(text: text2,style: style2,),
      ],
    ),
  );
}
/*------------------------------------start rating widget -----------------------*/
Widget ratingsStar ({width, height,bgColor, initialRating,itemSize,minRating,allowHalfRating,itemCount,itemBuilder,onRatingUpdate,
  ignoreGestures = false}){
  return  Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: bgColor,
    ),
    child: RatingBar.builder(
      initialRating: initialRating,
      ignoreGestures: ignoreGestures,
      itemSize: itemSize,
      minRating: minRating,
      direction: Axis.horizontal,
      allowHalfRating: allowHalfRating,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      onRatingUpdate:onRatingUpdate,
    ),
  );
}
/*-------------------------icon Rich text ----------------------------------*/

Widget iconRichText2 ({icon,color,size,text , style, context}) {
  var screenWidth = MediaQuery.of(context).size.width;
  return Text.rich(  overflow: TextOverflow.ellipsis,
    TextSpan(
      children: [
        WidgetSpan(child: Icon(icon,color:color, size: size, )),
        WidgetSpan(
          child: SizedBox(width: screenWidth/50 ), // Adjust the width as needed
        ),
        TextSpan(text: text,style: style,),
      ],
    ),
  );
}