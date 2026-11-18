import 'package:centavizers/helpers/color_helper.dart';
import 'package:centavizers/helpers/dimens_helper.dart';
import 'package:centavizers/helpers/string_helper.dart';
import 'package:centavizers/screens/Rewards/discount_card.dart';
import 'package:flutter/material.dart';
import '../../components/stagger_widget.dart';
import '../../helpers/font_helper.dart';
import 'badge_card.dart';
import 'certificate_card.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({super.key});

  @override
  _RewardScreenState createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  int _selectedChipIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(DimensHelper.dimens_16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(2, (index) {
                var labelName = index == 0
                    ? AppString.badges
                    // : index == 1
                    // ? AppString.certificates
                    : AppString.discounts;
                return GestureDetector(
                  onTap: () => setState(() => _selectedChipIndex = index),
                  child: Padding(
                    padding: const EdgeInsets.only(right: DimensHelper.dimens_14),
                    child: Chip(
                      side: const BorderSide(color: Colors.transparent),
                      label: Text(
                        labelName,
                        style: const TextStyle(
                            fontSize: FontHelper.size_14,
                            fontWeight: FontHelper.bold),
                      ),
                      backgroundColor: _selectedChipIndex == index
                          ? ColorHelper.primaryColor
                          : ColorHelper.secondaryChipColor,
                      labelStyle: TextStyle(
                          color: _selectedChipIndex == index
                              ? ColorHelper.whiteColor
                              : ColorHelper.primaryColor),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(DimensHelper.dimens_20)),
                    ),
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: _buildContent(_selectedChipIndex),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(int index) {
    switch (index) {
      case 0:
        return AnimatedListView(
          itemCount: badges.length,
          itemBuilder: (context, index) {
            return BadgeCard(badge: badges[index]);
          },
        );
      // case 1:
      //   return AnimatedListView(
      //     itemCount: certificates.length,
      //     itemBuilder: (context, index) {
      //       return CertificateCard(certificate: certificates[index]);
      //     },
      //   );
        case 1:
        return AnimatedListView(
          itemCount: discounts.length,
          itemBuilder: (context, index) {
            return DiscountsCard(discounts: discounts[index]);
          },
        );
      default:
        return Container();
    }
  }




}


