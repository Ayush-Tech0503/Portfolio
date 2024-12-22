import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';

Widget noDataFound (context){
  var screenWidth = MediaQuery.of(context).size.width;
  return Center(
    child: Padding(
      padding:EdgeInsets.symmetric(horizontal: screenWidth/5.5),
      child: EmptyWidget(
        image: null,
        packageImage: PackageImage.Image_2,
        title: 'No data available!',
        titleTextStyle: const TextStyle(
          fontSize: 16,
          color: Color(0xff9da9c4),
          fontWeight: FontWeight.bold,
        ),
        // styling the sub title

      ),
    ),
  );

}