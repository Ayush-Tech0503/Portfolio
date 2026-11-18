import 'package:carousel_slider/carousel_slider.dart';
import 'package:centavizers/components/back_button.dart';
import 'package:centavizers/components/common_image_widget.dart';
import 'package:centavizers/helpers/color_helper.dart';
import 'package:centavizers/helpers/dimens_helper.dart';
import 'package:centavizers/helpers/string_helper.dart';
import 'package:centavizers/routes/routes_name.dart';
import 'package:centavizers/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/font_helper.dart';


class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int _currentIndexCollectCentz = 0;
  int _currentIndexReferFriends = 0;


  final List<Map<String, String>> collectCentz = [
    {"title": "Daily Login", "points": "50", "action": "COLLECT"},
    {"title": "Complete Settings", "points": "30", "action": "COLLECT"},
  ];


  final List<Map<String, String>> referFriends = [
    {"title": "Refer a friend", "points": "100", "action": "INVITE"},
    {"title": "Refer a friend", "points": "10", "action": "INVITE"},
  ];

  final CarouselSliderController _carouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorHelper.whiteColor,
        leading: const BackButtonWidget(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: DimensHelper.dimens_20),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '12,000\t',
                        style: TextStyle(
                            fontSize: FontHelper.size_26,
                            color: ColorHelper.primaryColor,
                            fontWeight: FontHelper.bold),
                      ),
                      customAssetImage(imgName:AppImages.coinIcon, height: DimensHelper.dimens_30),
                    ],
                  ),

                  const SizedBox(height: DimensHelper.dimens_4),
                  const Text(AppString.currentBalance,
                    style: TextStyle(
                      fontSize: FontHelper.size_14,
                      color: ColorHelper.greyIcon2Color,
                      fontWeight: FontHelper.regular),
                  ),
                  const SizedBox(height: 10),
              const Text(AppString.currentBalanceDes,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: FontHelper.size_14,
                    color: ColorHelper.greyIcon2Color,
                    fontWeight: FontHelper.regular)
              ),
                ],
              ),
            ),
            const SizedBox(height: DimensHelper.dimens_20),
            _buildSectionTitle(AppString.collectCent),
            const SizedBox(height: DimensHelper.dimens_10),
            _buildCarouselSlider(
                currentIndex: _currentIndexCollectCentz,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndexCollectCentz = index;
                  });
                },
                listName : collectCentz),
            const SizedBox(height: DimensHelper.dimens_10),
            _buildIndicator(listCount : collectCentz, currentIndex: _currentIndexCollectCentz),
            const SizedBox(height: DimensHelper.dimens_20),
            _buildSectionTitle('Want to earn more coins ?'),
            const SizedBox(height: DimensHelper.dimens_10),
            _buildHorizontalcollectCentz(),
            const SizedBox(height: DimensHelper.dimens_20),
            _buildSectionTitle('Refer a friend'),


            _buildCarouselSlider(
                currentIndex: _currentIndexReferFriends,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndexReferFriends = index;
                  });
                },
                listName : referFriends),
            const SizedBox(height: DimensHelper.dimens_10),
            _buildIndicator(listCount : referFriends, currentIndex: _currentIndexReferFriends),

            const SizedBox(height: DimensHelper.dimens_20),
            _buildListTile('Transaction history',() => Navigator.pushNamed(context, RouteName.transactionHistory)),
            _buildListTile('About Centz Coins',() =>
                Navigator.pushNamed(context, RouteName.aboutCentzCoins,
                    arguments: {"title" : AppString.aboutCentCoins,  "content": "centzCoin"})),


                // Navigator.pushNamed(context, RouteName.aboutCentzCoins,
                // arguments: {"title" : AppString.aboutCentCoins,  "content": ""})),

            const SizedBox(height: DimensHelper.dimens_80),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
            fontSize: FontHelper.size_18,
            color: ColorHelper.blackColor,
            fontWeight: FontHelper.bold)
      ),
    );
  }

  Widget _buildRewardCard({required String title, required String points, required String action}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
        boxShadow: const [
          BoxShadow(
            color: ColorHelper.secondaryGreyColor,
            spreadRadius: 1.0,
            blurRadius: 4.0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(DimensHelper.dimens_12),
      margin: const EdgeInsets.all(DimensHelper.dimens_2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          title == "Refer a friend" ?
          imageContainer(imgName:  AppImages.customersIcon)
          : imageContainer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style:  const TextStyle(
                  fontSize: FontHelper.size_14,
                  color: ColorHelper.blackColor,
                  fontWeight: FontHelper.medium2)),
              Row(
                children: [
                  Text(points, style: const TextStyle(
                      fontSize: FontHelper.size_14,
                      fontWeight: FontHelper.medium,
                      height: 2,
                      color: ColorHelper.greyIcon2Color)),
                  const SizedBox(width: DimensHelper.dimens_4),
                  customAssetImage(imgName:AppImages.coinIcon,
                      height: DimensHelper.dimens_20),

                ],
              ),
            ],
          ),
        const  SizedBox(width: DimensHelper.dimens_10),
          Chip(
            side: const BorderSide(color: Colors.transparent),
            label:  Text(action,
              style: const TextStyle(
                  color: ColorHelper.whiteColor,
                  fontSize: FontHelper.size_12,
                  fontWeight: FontHelper.bold),
            ),
            backgroundColor: ColorHelper.primaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(DimensHelper.dimens_12)),
          )
        ],
      ),
    );
  }

  Widget _buildHorizontalcollectCentz() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildHorizontalCard('50K Steps Weekly', '100\t'),
          _buildHorizontalCard('50K Steps Weekly', '500\t'),
        ],
      ),
    );
  }

  Widget _buildHorizontalCard(String title, String points) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(DimensHelper.dimens_12),
      margin: const EdgeInsets.only(right: DimensHelper.dimens_12),
      decoration: BoxDecoration(
        color: ColorHelper.secondaryChipColor,
        borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
        boxShadow: const [
          BoxShadow(
            color: ColorHelper.secondaryGreyColor,
            spreadRadius: 1.0,
            blurRadius: 4.0,
          ),
        ],
      ),
      // padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageContainer(color: ColorHelper.primaryColor),
          const SizedBox(height: 10),
          Text(title, style:  const TextStyle(
              fontSize: FontHelper.size_14,
              color: ColorHelper.blackColor,
            fontWeight: FontHelper.medium2)),
          Row(
            children: [
              Text(points, style: const TextStyle(
                  fontSize: FontHelper.size_14,
                  fontWeight: FontHelper.medium,
                  height: 2,
                  color: ColorHelper.greyIcon2Color)),
              // const SizedBox(width: DimensHelper.dimens_4),
              customAssetImage(imgName:AppImages.coinIcon,
                  height: DimensHelper.dimens_20),

            ],
          ),
        ],
      ),
    );
  }

    Widget _buildCarouselSlider({
      required List<Map<String, String>> listName,
      required int currentIndex,
      required  onPageChanged}) {
      return CarouselSlider(
      carouselController: _carouselController,
      options: CarouselOptions(
        scrollPhysics: const BouncingScrollPhysics(),
        height: 10.h,
        viewportFraction: 1.0,
        autoPlay: false,
        onPageChanged: onPageChanged,
      ),
          items: listName.map((reward) {
            return Builder(
              builder: (BuildContext context) =>   _buildRewardCard(
            title: reward["title"]??"",
              points: reward["points"]??"",
              action: reward["action"]??"",
              ),
            );
          }).toList(),
    );
  }

    Widget _buildIndicator({required List<Map<String, String>> listCount,currentIndex}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: listCount.asMap().entries.map((entry) {
        return Container(
          height: DimensHelper.dimens_10,
          width: ( currentIndex == entry.key) ? DimensHelper.dimens_24 : DimensHelper.dimens_10,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(DimensHelper.dimens_10),
            color: (currentIndex == entry.key) ? ColorHelper.primaryColor : ColorHelper.greyIcon2Color,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildListTile(String title, onTap) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: DimensHelper.dimens_10),
      dense: true,
      title: Text(
          title,
          style: const TextStyle(
              fontSize: FontHelper.size_16,
              color: ColorHelper.blackColor,
              fontWeight: FontHelper.bold)
      ),
      trailing: const Icon(Icons.arrow_forward,color: ColorHelper.blackColor),
      onTap: onTap,
    );
  }
}



Widget imageContainer({color, imgName,height,width }){
  return Container(
    padding: const EdgeInsets.all(DimensHelper.dimens_10),
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(DimensHelper.dimens_10)),
      color: color ?? ColorHelper.secondaryChipColor,
    ),
      child: Image.asset(
           imgName ?? AppImages.trophyIcon,
          height: height ?? DimensHelper.dimens_26,
          width: width ?? DimensHelper.dimens_26,
        fit: BoxFit.cover,
      )
  );
}



// class RewardCarousel extends StatelessWidget {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
//
//
//
//   Widget imageContainer({String? imgName}) {
//     // Implement your image container logic here
//     return imgName != null
//         ? Image.asset(imgName, width: 50, height: 50) // Example implementation
//         : Container(width: 50, height: 50, color: Colors.grey);
//   }
// }