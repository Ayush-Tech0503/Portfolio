import 'package:flutter/material.dart';
import '../Util/constaint_textstyle.dart';
import 'avatar_text.dart';
Widget avatarScrolls({onTap,widget1,context,text,itemCount,color,scrollDirection,width,height,borderRadius,image,boxShadow}) {
  return GestureDetector(
      onTap:onTap,
    child: widget1,
  );
}
Widget allHomeScreenAvatar({text,overFlow,textAlign, onTap,data,height,color,image,width,borderRadius,boxShadow,blurRadius,spreadRadius,offset}) {
  return Column(
      children: [
        GestureDetector(
          onTap:onTap,
          child: Container(
            width: width,
            height: width,
            padding:  const EdgeInsets.all(0),
            decoration:  BoxDecoration(
              boxShadow:boxShadow,
              color: color,
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius:borderRadius,
              child: image,
            ),
          ),
        ),
        const SizedBox(height: 5.0,),
        Flexible(
          child: SizedBox(
            width: 80,
                child: homeScreenAvatarText(
            text: text,
            textAlign:textAlign,
            style: ConstantTextStyle.allHomeScreenAvatarText),),
        ),
      ]
  );
}
