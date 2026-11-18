import 'package:centavizers/utils/globle_context.dart';
import 'package:flutter/material.dart';
import '../../helpers/color_helper.dart';
import '../../helpers/dimens_helper.dart';
import '../../helpers/font_helper.dart';
import '../../utils/app_images.dart';

class Certificate {
  final String title;
  final String subtitle;
  final String date;
  final bool isLocked;
  final String? stepsRemaining;

  Certificate({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.isLocked,
    this.stepsRemaining,
  });
}

final List<Certificate> certificates = [
  Certificate(title: "Step Challenge Champion– January 2025",subtitle: "Walk 250,000 steps in a month", date: "Today", isLocked: false),
  Certificate(title: "Step Challenge Champion– January 2025",subtitle: "Walk 250,000 steps in a month", date: "2 days ago", isLocked: false),
  Certificate(title: "Step Challenge Champion– January 2025",subtitle: "Walk 250,000 steps in a month", date: "2 days ago", isLocked: false),
  Certificate(title: "Step Challenge Champion– January 2025",subtitle: "Walk 250,000 steps in a month", date: "2 days ago", isLocked: false),
];


class CertificateCard extends StatelessWidget {
  final Certificate certificate;

  const CertificateCard({super.key, required this.certificate});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildCardContainer(context),
        _buildCertificateImage(context),
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
            certificate.title,
            style: TextStyle(
              fontSize: FontHelper.size_16,
              color: certificate.isLocked
                  ? ColorHelper.blackColor.withOpacity(0.2)
                  : ColorHelper.black,
              fontWeight: FontHelper.bold,
            ),
          ),
          Text(
            certificate.subtitle,
            style: TextStyle(
              fontSize: FontHelper.size_12,
              color: certificate.isLocked
                  ? ColorHelper.blackColor.withOpacity(0.2)
                  : ColorHelper.greyIcon2Color,
              fontWeight: FontHelper.regular,
            ),
          ),
          if (certificate.stepsRemaining != null)
            Text(
              "50k More Steps To Get This Certificate",
              style: TextStyle(
                fontSize: 10.0,
                color: certificate.isLocked
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
        if (certificate.stepsRemaining != null)
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
                certificate.stepsRemaining!,
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
          certificate.date,
          style: TextStyle(
            fontSize: FontHelper.size_10,
            color: certificate.isLocked
                ? ColorHelper.blackColor.withOpacity(0.2)
                : ColorHelper.greyIcon2Color,
            fontWeight: FontHelper.regular,
          ),
        ),
      ],
    );
  }

  Widget _buildCertificateImage(BuildContext context) {
    return Positioned(
      left: DimensHelper.dimens_10,
      top: 0.0,
      bottom: 0.0,
      child: Image.asset(
        AppImages.tempCertificate,
        width: context.globalSize.height / DimensHelper.dimens_16,
      ),
    );
  }
}
