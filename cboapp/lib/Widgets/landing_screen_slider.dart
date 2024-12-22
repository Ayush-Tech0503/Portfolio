import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../Util/constant_color.dart';
import 'Famous Market Widget/store_details_widget.dart';
import 'custome_text.dart';
Widget carouselSlider({controller,bannerHeight, viewportFraction,enlargeCenterPage, onPageChanged,data, dotsCount, position,reverse,autoPlay,color,})
{
  return CarouselSlider(
      options: CarouselOptions(
        onPageChanged: onPageChanged,
        height: bannerHeight,
        autoPlay: autoPlay,
        viewportFraction: viewportFraction,
        enlargeCenterPage: enlargeCenterPage,
      ),
      items:data,
  );
}
//-------------scrolling dots start--------
Widget dotS ({width,height,margin,shape,color}){
  return Flexible(
    child: Container(
      width:width,
      height:height,
      margin:margin,
      decoration: BoxDecoration(
      //  borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: ConstantColor.primaryMainColor, width: 0.5),
        shape:shape,
        color:color,
      ),
    ),
  );
}
//-------------scrolling dots end--------
Widget rowIconText ({icon , iconSize, iconColor, text,textstyle, textAlignment, textPaddingLeft, textWidth, context  }) {
  return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height/80,
          bottom: MediaQuery.of(context).size.height/80),
      decoration: BoxDecoration(
        color: ConstantColor.secondoryMarketColors,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child:
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 20,
            color: ConstantColor.primaryMainColor,
          ),
          Container(
            padding: EdgeInsets.only(
                left:textPaddingLeft,),
                 width :textWidth,
            child: customeText(
                text: text,
                style: textstyle,
                textAlign: textAlignment,
            ),
          ),
        ],
      )
  );
}
/*----------------------------------------------------------------------------------------*/

Widget iconTextButton ({fixedSize, elevation, backgroundColor, iconSize, icon,iconColor,buttonOnPressed, buttontext, buttontextStyle}) {
  return  ElevatedButton.icon(
    style: ElevatedButton.styleFrom(
      elevation: elevation,
      fixedSize:fixedSize,
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    icon: Icon(icon, size: iconSize, color: iconColor,),
    label: customeText(
      text: buttontext,
      style: buttontextStyle,
    ),
    onPressed: buttonOnPressed,
  );
}

/*--------------------------Slider linear start---------------------------------------------*/
Widget linearSlider ({onChanged, sliderValue, widget, sizeBoxwidth, thumbColor,activeTrackColor,trackHeight,enabledThumbRadius }) {
  return SliderTheme(
  data: SliderThemeData(
    trackHeight: trackHeight,
    activeTrackColor: activeTrackColor,
    thumbColor: thumbColor,
    thumbShape: RoundSliderThumbShape(
        enabledThumbRadius:enabledThumbRadius),
  ),
  child: SizedBox(
    width: sizeBoxwidth,
  child: widget,
  ),
  );
}
/*----------------------------------------------------------------------------------------*/
Widget buildGridView({gridOnTap,iconSize,context, icon, iconColor,textWidget}) {
  var screenWidth = MediaQuery.of(context).size.width;
  var screenHeight = MediaQuery.of(context).size.height;
  return   InkWell(
    onTap: gridOnTap,

    child: Padding(
        padding: EdgeInsets.symmetric(vertical: screenHeight/100, horizontal: screenWidth/100),
        child: Container(
          decoration: BoxDecoration(
          //  boxShadow: kElevationToShadow[1],

            border: Border.all(
              color: ConstantColor.secondoryCardeBoarder, width: 0.5,),
            borderRadius: BorderRadius.circular(10.0),
            color: ConstantColor.secondoryCardeColors,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Icon(icon, size: iconSize, color:iconColor,),

              textWidget,
            ],
          ),
        ),
    ),
  );
}

Widget profileGridView({borderRadius,title, subtitle, boxHeight,boxWidth,boxborderRadius,
  boxbgcolor,iconBox,iconsize, boxiconcolor,onTap }) {
  return Card(
    color: ConstantColor.profileGridBGolor,
  elevation: 1,
  shape: RoundedRectangleBorder(
  borderRadius: borderRadius,
  ),
    child: Center(
      child: ListTile(
        title: title,
        subtitle: subtitle,
        trailing: Card(
          shadowColor:  Colors.black.withOpacity(0.5),
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
/*-----------------------------------------------------------------*/
Widget faqExpansionTile ({collapsedShapeBoarder, collapsedBackgroundColor, backgroundColor, onExpansionChanged, subTextContainerColor, subTextContainerBoarder,
  headText, headStyle,subText, subTextStyle  }){
  return ExpansionTile(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    collapsedShape: RoundedRectangleBorder(
      borderRadius: collapsedShapeBoarder,
    ),
    collapsedBackgroundColor: collapsedBackgroundColor,
    backgroundColor: backgroundColor,
    title: Text(headText, style: headStyle, textAlign: TextAlign.start),
    textColor: ConstantColor.primaryMainColor,
    iconColor: ConstantColor.primaryMainColor,
    onExpansionChanged: onExpansionChanged,
    children: [
      Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: subTextContainerColor,
          borderRadius: subTextContainerBoarder,
        ),
        child: Html(
          data: subText,
          style: {
            "body": Style(
                fontSize: FontSize(14.0),
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal
            ),
            "h1": Style(
              fontSize: FontSize(14.0),
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal
            ),
            "p": Style(
        fontSize: FontSize(14.0),
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal
            ),
            // Add more styles as needed
          },
        ),
      ),
    ],
  );

}

/*-----------------------------------------------------------------*/

Widget storeDetailGrid ({iconBoxHeight, iconBoxWidth, iconBgcolor, icons,
  iconSize, iconColor, headText, headTextStyle, subText, subTextStyle}) {
  return Center(
    child: ListTile(
      //  contentPadding: EdgeInsets.zero,
      leading: boxIcon(
        borderRadius: BorderRadius.circular(10.0),
        height:iconBoxHeight,
        width: iconBoxHeight,
        bgcolor: iconBgcolor,
        icon: icons,
        iconsize: iconSize,
        iconcolor: iconColor,
      ),
      title: customeText(
        text: headText,
        textAlign: TextAlign.start,
        style:headTextStyle,
      ),
      subtitle: customeText(
        text: subText,
        textAlign: TextAlign.start,
        style: subTextStyle,
      ),
    ),
  );
}
