import 'package:flutter/material.dart';
import '../Util/constant_color.dart';

Widget filterSort ({text1,style1,padding,context,thickness,text2,style2}){
  var sw =  MediaQuery.of(context).size.width;
return Container(
  padding: padding,
  child:   IntrinsicHeight(
  child: Row(
    children: [
      Text(text1,style:style1,),
      SizedBox(width: sw/10,),
      VerticalDivider(
        color: Colors.black,
        thickness: thickness,),
      SizedBox(width: sw/10,),
      Text(text2,style: style2,),
       SizedBox(width: sw/10,),
    ],
  ),
  ),
);
}


Widget filterTextIcon ({text,height,  containerheight, containerwidth,bgcolor,width,style,context,color,icon,onTap,size}){
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color:bgcolor,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text,style: style,),
        InkWell(
          onTap: onTap,
          child: Container(
            height: containerheight,
            width: containerwidth,
            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: color,
            ),
            child: Icon(icon,
              color: ConstantColor.filedContainerColor,
              size: size,),

          ),
        ),
      ],
    ),
  );
}


Widget productDetailsSection  ({text1,style1,text2,context,style2,textAlign1,textAlign2,maxLines1,maxLines2}){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
     Flexible(fit: FlexFit.loose,
         child: Text( text1, style: style1,  textAlign: textAlign1, maxLines: maxLines1,overflow: TextOverflow.ellipsis,)),
      const SizedBox(width: 1.0,),
      Flexible(
          fit: FlexFit.loose,
          child: Text( text2, style: style2, textAlign: textAlign2, maxLines: maxLines2,overflow: TextOverflow.ellipsis,)),

    ],
  );
}


Widget readMoreText ({left,right,descriptiontext, descriptiontextStyle, ontap,
  maxLines, widget,desctexttextAlign ,context}){
  return  GestureDetector(
    onTap: ontap,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text( descriptiontext,textAlign: desctexttextAlign,
            style: descriptiontextStyle,
            maxLines: maxLines,
        ),
SizedBox(height: MediaQuery.of(context).size.height/100,),
         widget,
      ]
    ),
  );
}
