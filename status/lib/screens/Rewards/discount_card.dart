import 'package:centavizers/utils/globle_context.dart';
import 'package:flutter/material.dart';
import '../../helpers/color_helper.dart';
import '../../helpers/dimens_helper.dart';
import '../../helpers/font_helper.dart';
import '../../utils/app_images.dart';

class Discounts {
  final String title;
  final String subtitle;
  final String date;
  final bool isLocked;
  final String? stepsRemaining;

  Discounts({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.isLocked,
    this.stepsRemaining,
  });
}

final List<Discounts> discounts = [
  Discounts(title: "Apple",subtitle: "20% Off Running Watch", date: "Expires in 3 Days", isLocked: false),
  Discounts(title: "Apple",subtitle: "20% Off Running Watch", date: "Expires in 5 Days", isLocked: false),
];


class DiscountsCard extends StatelessWidget {
  final Discounts discounts;

  const DiscountsCard({super.key, required this.discounts});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildCardContainer(context),
        _buildDiscountsImage(context),
        _buildStatusChip(),
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
        context.globalSize.height / DimensHelper.dimens_80,
        context.globalSize.width / DimensHelper.dimens_20,
        context.globalSize.height / DimensHelper.dimens_80,
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
      child:_buildTextContent(),
    );
  }

  Widget _buildTextContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          discounts.title,
          style: TextStyle(
            fontSize: FontHelper.size_16,
            color: discounts.isLocked
                ? ColorHelper.blackColor.withOpacity(0.2)
                : ColorHelper.black,
            fontWeight: FontHelper.bold,
          ),
        ),
        Text(
          discounts.subtitle,
          style: TextStyle(
            fontSize: FontHelper.size_12,
            color: discounts.isLocked
                ? ColorHelper.blackColor.withOpacity(0.2)
                : ColorHelper.greyIcon2Color,
            fontWeight: FontHelper.regular,
          ),
        ),
        const SizedBox(height: DimensHelper.dimens_6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Chip(
              side: const BorderSide(color: Colors.transparent),
              label: const Text(
                "Redeem",
                style:  TextStyle(
                  color: ColorHelper.whiteColor,
                    fontSize: FontHelper.size_14,
                    fontWeight: FontHelper.bold),
              ),
                backgroundColor: ColorHelper.primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(DimensHelper.dimens_14)),
            ),
            Text(
              discounts.date,
              style: TextStyle(
                fontSize: FontHelper.size_10,
                color: discounts.isLocked
                    ? ColorHelper.blackColor.withOpacity(0.2)
                    : ColorHelper.greyIcon2Color,
                fontWeight: FontHelper.regular,
              ),
            )
          ],
        ),
      ],
    );
  }



  Widget _buildDiscountsImage(BuildContext context) {
    return Positioned(
      left: DimensHelper.dimens_14,
      top: 0.0,
      bottom: 0.0,
      child: CircleAvatar(
        radius: DimensHelper.dimens_30,
        backgroundColor: ColorHelper.secondaryChipColor.withOpacity(0.5),
        child: Image.asset(
          AppImages.appleIcon,
          width: context.globalSize.height / DimensHelper.dimens_30,
        ),
      ),
    );
  }

  Widget _buildStatusChip() {
    return  Positioned(
      right: DimensHelper.dimens_50,
      top: DimensHelper.dimens_12,
      child: Chip(
        side: const BorderSide(color: Colors.transparent),
        label: const Text(
          "Unused",
          style:  TextStyle(
              color: ColorHelper.whiteColor,
              fontSize: FontHelper.size_10,
              fontWeight: FontHelper.bold),
        ),
        backgroundColor: ColorHelper.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(DimensHelper.dimens_20)),
      ),
    );
  }
}
