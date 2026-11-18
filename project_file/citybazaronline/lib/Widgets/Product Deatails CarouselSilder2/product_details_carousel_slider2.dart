import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

Widget productDetailsCarouselSlider2 ({context, autoPlay, carouselSliderOnPageChange,items,dotWidget,dotWidgetTop,
  shareIcon, shareIconSize, favoriteIcon, favoriteIconSize , shareIconColor,favoriteIconColor, favoriteIconOnTap,
   leftPositionedFavoriteIcon,
}){
  return Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
            //  height: carouselHeight,
              viewportFraction: 1.0,
                aspectRatio: 16/12,
              autoPlay: autoPlay,
              initialPage: 0,
              onPageChanged:carouselSliderOnPageChange,
            ),
            items: items,
          ),
          Positioned(
            left:leftPositionedFavoriteIcon,
                // :screenWidth / 1.15,
            child: IconButton(
              icon: Icon(favoriteIcon,
                size: favoriteIconSize,
                color: favoriteIconColor,
              ),
              onPressed: favoriteIconOnTap,
            ),
          ),
        ],
      );
}

Widget slidingDots2  ({slidingDotsColor, slidingDotsMargin,onTap}) {
  return  GestureDetector(
    onTap: onTap,
    child: Container(
      width: 8.0,
      height: 8.0,
      margin: slidingDotsMargin,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: slidingDotsColor,
      ),
    ),
  );}

