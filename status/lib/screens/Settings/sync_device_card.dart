import 'package:centavizers/components/common_image_widget.dart';
import 'package:centavizers/helpers/color_helper.dart';
import 'package:centavizers/helpers/dimens_helper.dart';
import 'package:centavizers/utils/app_images.dart';
import 'package:flutter/material.dart';

import '../../helpers/font_helper.dart';

class WatchCard extends StatelessWidget {
  const WatchCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DimensHelper.dimens_20),
      decoration: BoxDecoration(
        color: const Color(0xFF103B7F), // Dark blue background
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  value: 0.3,
                  strokeWidth: 4,
                  backgroundColor: Colors.grey.withOpacity(0.3),
                  valueColor: const AlwaysStoppedAnimation<Color>(ColorHelper.secondaryColor),
                ),
              ),
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: customAssetImage(
                    imgName: AppImages.setting,
                    boxFit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
         const  Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  "Apple Watch Ultra 2",
                  style: TextStyle(
                      color: ColorHelper.whiteColor,
                      fontSize: FontHelper.size_14,
                      fontWeight: FontHelper.bold
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      "25%",
                      style: TextStyle(
                          color: ColorHelper.whiteColor,
                          fontSize: FontHelper.size_14,
                          fontWeight: FontHelper.regular
                      ),
                    ),
                    Text(
                      "  |  Synced : 3 min ago",
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: FontHelper.size_12,
                          fontWeight: FontHelper.regular
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          CircleAvatar(
            backgroundColor: ColorHelper.secondaryColor,
            child: Icon(Icons.arrow_forward, color: ColorHelper.primaryColor),
          ),
        ],
      ),
    );
  }
}

