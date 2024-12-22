import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Widget ratingsStar ({initialRating,itemSize,minRating,allowHalfRating,itemCount,itemBuilder,onRatingUpdate, ignoreGestures = true}){
  return  RatingBar.builder(
    initialRating: initialRating,
    ignoreGestures: ignoreGestures,
    itemSize: itemSize,
    minRating: minRating,
    direction: Axis.horizontal,
    allowHalfRating: allowHalfRating,
    itemCount: itemCount,
    itemBuilder: itemBuilder,
    onRatingUpdate:onRatingUpdate,
  );
}