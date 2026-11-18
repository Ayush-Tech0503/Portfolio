import 'package:centavizers/utils/globle_context.dart';
import 'package:flutter/material.dart';
import '../../helpers/color_helper.dart';
import '../../helpers/dimens_helper.dart';
import '../../helpers/font_helper.dart';
import '../../utils/app_images.dart';

class Badge {
  final String title;
  final String subtitle;
  final String date;
  final bool isLocked;
  final String? stepsRemaining;

  Badge({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.isLocked,
    this.stepsRemaining,
  });
}

final List<Badge> badges = [
  Badge(title: "Elite Walker", subtitle: "Completed 100K Steps in a Month", date: "2 days ago", isLocked: false),
  Badge(title: "Elite Walker", subtitle: "Completed 100K Steps in a Month", date: "Today", isLocked: false),
  Badge(title: "Elite Walker", subtitle: "Completed 100K Steps in a Month", date: "Feb 26", isLocked: false),
  Badge(title: "Elite Walker", subtitle: "Completed 150K Steps in a Month", date: "Feb 26", isLocked: true, stepsRemaining: "50k"),
];


class BadgeCard extends StatelessWidget {
  final Badge badge;

  const BadgeCard({super.key, required this.badge});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildCardContainer(context),
        _buildBadgeImage(context),
      ],
    );
  }

  Widget _buildCardContainer(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: context.globalSize.width / DimensHelper.dimens_10,
      ),
      padding: EdgeInsets.fromLTRB(
        context.globalSize.width / DimensHelper.dimens_8,
        context.globalSize.height / DimensHelper.dimens_40,
        context.globalSize.width / DimensHelper.dimens_20,
        context.globalSize.height / DimensHelper.dimens_40,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: ColorHelper.secondaryGreyColor,
            spreadRadius: 1.0,
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Row(
        children: [
          _buildTextContent(),
          const SizedBox(width: DimensHelper.dimens_16),
          _buildProgressAndDateColumn(),
        ],
      ),
    );
  }

  Widget _buildTextContent() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            badge.title,
            style: TextStyle(
              fontSize: FontHelper.size_16,
              color: badge.isLocked
                  ? ColorHelper.blackColor.withOpacity(0.2)
                  : ColorHelper.black,
              fontWeight: FontHelper.bold,
            ),
          ),
          Text(
            badge.subtitle,
            style: TextStyle(
              fontSize: FontHelper.size_12,
              color: badge.isLocked
                  ? ColorHelper.blackColor.withOpacity(0.2)
                  : ColorHelper.greyIcon2Color,
              fontWeight: FontHelper.regular,
            ),
          ),
          if (badge.stepsRemaining != null)
            Text(
              "50k More Steps To Get This Badge",
              style: TextStyle(
                fontSize: 10.0,
                color: badge.isLocked
                    ? ColorHelper.blackColor.withOpacity(0.2)
                    : ColorHelper.greyIcon2Color,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProgressAndDateColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (badge.stepsRemaining != null)
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 40.0,
                height: 40.0,
                child: CircularProgressIndicator(
                  value: 0.3,
                  strokeWidth: 4.0,
                  backgroundColor: ColorHelper.secondaryColor.withOpacity(0.3),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    ColorHelper.primaryColor,
                  ),
                ),
              ),
              Text(
                badge.stepsRemaining!,
                style: TextStyle(
                  fontSize: FontHelper.size_14,
                  fontWeight: FontWeight.bold,
                  color: ColorHelper.blackColor.withOpacity(0.2),
                ),
              ),
            ],
          )
        else
          const SizedBox(),
        const SizedBox(height: DimensHelper.dimens_20),
        Text(
          badge.date,
          style: TextStyle(
            fontSize: FontHelper.size_10,
            color: badge.isLocked
                ? ColorHelper.blackColor.withOpacity(0.2)
                : ColorHelper.greyIcon2Color,
            fontWeight: FontHelper.regular,
          ),
        ),
      ],
    );
  }

  Widget _buildBadgeImage(BuildContext context) {
    return Positioned(
      left: -DimensHelper.dimens_6,
      top: 0.0,
      bottom: 0.0,
      child: Image.asset(
        AppImages.tempBadge,
        width: context.globalSize.height / DimensHelper.dimens_8,
      ),
    );
  }
}
