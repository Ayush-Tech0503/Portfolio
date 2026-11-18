
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../Util/constant_color.dart';

Widget collectionCards(
    {context, itemCount, itemBuilder, image, gridDelegate, onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
     physics: const ScrollPhysics(),
      itemCount: itemCount,
      gridDelegate: gridDelegate,
      itemBuilder: itemBuilder,
    ),
  );
}

Widget collectionCardBody(
    {onTap,
    color,
    text1,
    cardchiptext,
    overflow1,
    style1,
    cardChipstyle,
    widget,
    widget1,
    image,
    context,
    cardchiptextAlign,
    textAlign1,
    height,
    width}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ConstantColor.bottonNavIcons,
          boxShadow: const [
            BoxShadow(color: ConstantColor.carColor, spreadRadius: 1),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width /4.5,
                top: MediaQuery.of(context).size.width / 50,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  color: color,
                ),
                height: MediaQuery.of(context).size.height /50,
                width: MediaQuery.of(context).size.width / 5,
                child: Text(
                  cardchiptext,
                  textAlign: cardchiptextAlign,
                  style: cardChipstyle,
                ),
              ),
            ),
            image,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 30,
                  ),
                  Text(
                    text1,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: overflow1,
                    style: style1,
                  ),
                  Container(
                      padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width / 10,
                         top: MediaQuery.of(context).size.height / 300,
                      ),
                      child: widget),
                  widget1,
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget secondryText({text2, overflow2, textAlign2, style2}) {
  return Text(
    text2,
    overflow: overflow2,
    textAlign: textAlign2,
    style: style2,
  );
}

Widget richText({
  text3,
  top,
  text4,
  style3,
  style4,
  textAlign,
  onPressed,
  text5,
  style5,
  btcolor,
  context,
  image,
  width,
  height,
  icon,
  color,
}) {
  return Column(
    children: [
      RichText(
        text: TextSpan(text: text3, style: style3, children: [
          TextSpan(
            text: text4,
            style: style4,
          ),
        ]),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: top,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: btcolor,
          ),
          height: height,
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height / 1000
                ),
                icon: Icon(
                  icon,
                  color: color,
                ),
                onPressed: onPressed,
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width / 50),
                child: Text(text5, style: style5, textAlign: textAlign),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget cashBackChip(
    {color,
    context,
    textAlign,
    text,
    style,
    width,
    height,
    borderRadius,
    padding}) {
  return Padding(
    padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height/150,
        bottom: MediaQuery.of(context).size.height/150,
        right:MediaQuery.of(context).size.width/5, ),
    child: Container(
    padding: padding,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: color,
      ),
      height: height,
      width: width,
      child: Text(
        text, textAlign: textAlign,
        style: style,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );
}



Widget produtListRichText2(
    {text1, style1, style2, text2, color, icon, widget, context}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: MediaQuery.of(context).size.height / 400,
      ),
      Text.rich(
        TextSpan(
          children: [
            WidgetSpan(
                child: Icon(
              icon,
              color: color,
              size: 14,
            )),
            TextSpan(text: text1, style: style1),
            TextSpan(text: text2, style: style2),
          ],
        ),
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height / 80,
      ),
      widget,
    ],
  );
}

Widget produtListRichText3({text1, context, style1, color, icon, recognizer}) {
  return Container(
    height: MediaQuery.of(context).size.height / 25,
    width: MediaQuery.of(context).size.width / 2.8,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: ConstantColor.filedContainerColor,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text.rich(
          TextSpan(
            children: [
              WidgetSpan(
                  child: Icon(
                icon,
                color: color,
                size: 18,
              )),
              TextSpan(
                text: text1,
                style: style1,
                recognizer: recognizer,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget ShineEffect({height, width, padding}) {
  return Container(
    padding: padding,
    child: Shimmer.fromColors(
      baseColor: ConstantColor.transparent1,
      highlightColor: ConstantColor.carColor,
      child: Container(
        height: height,
        width: width,
        color: ConstantColor.primaryMainColor,
      ),
    ),
  );
}
