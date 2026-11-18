import 'package:centavizers/utils/globle_context.dart';
import 'package:flutter/material.dart';
import '../../components/common_image_widget.dart';
import '../../helpers/color_helper.dart';
import '../../helpers/dimens_helper.dart';
import '../../helpers/font_helper.dart';
import '../../helpers/string_helper.dart';
import '../../utils/app_images.dart';

Widget buildBannerContent(BuildContext context, {String? title, days, int? counts, dynamic profileList}) {

  return Align(
    alignment: Alignment.topLeft,
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.globalSize.width / DimensHelper.dimens_20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            title ?? AppString.mileChallenge,
            maxLines: 1,
            style: const TextStyle(
              color: ColorHelper.whiteColor,
              fontSize: FontHelper.size_18,
              fontWeight: FontHelper.bold,
            ),
          ),
          SizedBox(height: context.globalSize.height / DimensHelper.dimens_100),
           Text(
             days ?? '',
            style: const TextStyle(
              color: ColorHelper.whiteColor,
              fontSize: FontHelper.size_12,
              fontWeight: FontHelper.regular,
            ),
          ),

          SizedBox(height: context.globalSize.height / DimensHelper.dimens_60),

          counts.toString() == "0" ?
           SizedBox(height: context.globalSize.height / DimensHelper.dimens_30,) :
          ProfileImageList(counts: counts, profileList: profileList),
        ],
      ),
    ),
  );
}

class ProfileImageList extends StatelessWidget {
  final counts;
  final profileList;
  const ProfileImageList({super.key, this.counts, this.profileList});

  static const int _imageCount = 4;
  static const double _imageOverlap = -10.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildImageList(context),
        _buildParticipantsCount(counts: counts),
      ],
    );
  }

  Flexible _buildImageList(BuildContext context) {
    return Flexible(
      child: SizedBox(
        width: context.globalSize.width / DimensHelper.dimens_4,
        height: context.globalSize.height / DimensHelper.dimens_30,
        child:

        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: profileList.length?? _imageCount,
          itemExtent: 30,
          itemBuilder: (context, index) {
            return Transform.translate(
              offset: Offset(index * _imageOverlap, 0),
              child: profileCacheImage(
                imageUrl: profileList?[index].profilePicture??"",
              ),
              // customAssetImage(
              //   bgColor: ColorHelper.primaryColor,
              //   imgName: AppImages.userProfileIcon,
              //   height: MediaQuery.of(context).size.height / 20,
              // ),
            );
          },
        ),
      ),
    );
  }

  Flexible _buildParticipantsCount({counts}) {
    return  Flexible(
      child: Text(
        counts.toString() ?? '0',
        style: const TextStyle(
          color: ColorHelper.whiteColor,
          fontSize: FontHelper.size_12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}