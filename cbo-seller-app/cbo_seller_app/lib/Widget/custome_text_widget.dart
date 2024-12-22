import 'package:flutter/material.dart';

Widget customeText ({
  maxLines,
  overflow = TextOverflow.clip,
  text = '',
  style,
  textAlign = TextAlign.start

}){
  return Text(
     text,
    style: style,
      overflow: overflow,
    maxLines: maxLines,
    textAlign: textAlign
  );
}