import 'package:flutter/material.dart';

Widget assetImageWidget ({imageFile, fit = BoxFit.contain,width,height }){
  return  Image.asset(
    imageFile,
    width: width,
    height: height,
    fit: fit,
  );
}