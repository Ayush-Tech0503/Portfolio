import 'package:flutter/material.dart';
import '../Utils/Theme/constant_colors.dart';
import 'custome_text_widget.dart';

Widget storeDetailGrid ({context,iconBoxHeight, iconBoxWidth, icons,headText, headTextStyle, subText, subTextStyle})
{
  var screenWidth = MediaQuery.of(context).size.width;
  return Center(
    child: ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: screenWidth/40),
      dense: true,
      leading: boxIcon(
        borderRadius: BorderRadius.circular(10.0),
        height:iconBoxHeight,
        width: iconBoxHeight,
        iconsize: 25.0,
        bgcolor:ConstantColor.locationIconColor,
        iconcolor: ConstantColor.primaryMainColor,
        icon: icons,
      ),
      title: customeText(
        text: headText,
        maxLines: 3,
        textAlign: TextAlign.start,
        style:headTextStyle,
      ),
      subtitle: customeText(
        text: subText,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        style: subTextStyle,
      ),
    ),
  );
}



Widget boxIcon ({height ,width, bgcolor, iconsize,iconcolor, icon , onTap,borderRadius, })
{
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      borderRadius: borderRadius,
      color: bgcolor,
    ),
    child: Icon(icon,
      size: iconsize,
      color: iconcolor,
    ),
  );
}


Widget profileGridView({context,borderRadius,title, subtitle, boxHeight,boxWidth,boxborderRadius,boxbgcolor,iconBox,iconsize, boxiconcolor,onTap })
{
  var screenWidth = MediaQuery.of(context).size.width;
  return Container(
    decoration: BoxDecoration(
        color: ConstantColor.profileGridBGolor,
        borderRadius: borderRadius,
        border: Border.all(color: Colors.black.withOpacity(0.05),width: 0.5)
    ),

    child: Center(
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: screenWidth/40),
        title: title,
        subtitle: subtitle,
        trailing: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.black.withOpacity(0.05),width: 0.5),
          ),
          child: boxIcon(
            onTap: onTap,
            height: boxHeight,
            width: boxWidth,
            borderRadius: boxborderRadius,
            bgcolor: boxbgcolor,
            icon: iconBox,
            iconsize: iconsize,
            iconcolor: boxiconcolor,
          ),
        ),
      ),
    ),
  );
}

