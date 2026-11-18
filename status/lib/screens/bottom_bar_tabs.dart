import 'package:cached_network_image/cached_network_image.dart';
import 'package:centavizers/helpers/dimens_helper.dart';
import 'package:centavizers/helpers/string_helper.dart';
import 'package:centavizers/routes/routes_name.dart';
import 'package:centavizers/utils/app_images.dart';
import 'package:centavizers/utils/globle_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/common_image_widget.dart';
import '../components/double_press_to_back.dart';
import '../helpers/color_helper.dart';
import '../helpers/font_helper.dart';
import '../helpers/storage_helper.dart';
import '../network_manager/local_storage_cubit.dart';
import '../utils/loading_indicator.dart';
import 'Rewards/reward_screen.dart';
import 'Settings/profile_screen.dart';
import 'challenge/challenge_screen.dart';
import 'home/home_screen.dart';

class BottomBarTabs extends StatefulWidget {
  const BottomBarTabs({super.key});

  @override
  State<BottomBarTabs> createState() => _BottomBarTabsState();
}

class _BottomBarTabsState extends State<BottomBarTabs> {
  // late TutorialCoachMark tutorialCoachMark;

  // void showTutorial() {
  //   tutorialCoachMark.show(context: context);
  // }


  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = [
    const HomeScreen(),
    const ChallengeScreen(),
     const RewardScreen(),
    const SettingScreen(),
  ];
  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   context.read<GetUserDetailsCubit>().getUserDetails(context);
    //   if(StorageHelper().getTutorialCoachMark()){
    //     createTutorial();
    //   }
    // });
    getGreeting();
    super.initState();
  }


  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 18) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  @override
  Widget build(BuildContext context) {
    return userDataLoaded ();}


  Widget userDataLoaded () {
    return DoublePressToExit(
      child: Scaffold(
        appBar:AppBar(
          backgroundColor: ColorHelper.whiteColor,
          elevation: DimensHelper.dimens_0,
          automaticallyImplyLeading: false,
           title: switch (_selectedIndex) {
              0 => ListTile(
                onTap: () => Navigator.pushNamed(context, RouteName.editProfile),
                contentPadding: EdgeInsets.zero,
                dense: true,
                leading:
                context.watch<StorageCubit>().storage.profileImage.isNotEmpty ?
                profileCacheImage(
                    width: context.globalSize.height / DimensHelper.dimens_20,
                    height:  context.globalSize.height / DimensHelper.dimens_20,
                    imageUrl: context.watch<StorageCubit>().storage.profileImage) :
                StorageHelper().getProfileImage().toString().isNotEmpty &&
                        StorageHelper().getProfileImage().toString() != "null"
                    ? profileCacheImage(
                    width: context.globalSize.height / DimensHelper.dimens_20,
                    height:  context.globalSize.height / DimensHelper.dimens_20,
                    imageUrl: StorageHelper().getProfileImage())
                : customAssetImage(
                  bgColor: ColorHelper.primaryColor,
                  imgName: AppImages.userProfileIcon,
                  height: context.globalSize.height / DimensHelper.dimens_22,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                context.watch<StorageCubit>().storage.name.isNotEmpty ?
                 "${getGreeting()} ${context.watch<StorageCubit>().storage.name}" :
                      StorageHelper().getUserName().toString().isEmpty || StorageHelper().getUserName().toString() == "null"
                          ? "${getGreeting()} User"
                          : '${getGreeting()} ${StorageHelper().getUserName()}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: DimensHelper.dimens_14,
                        color: ColorHelper.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Row(
                      children: [
                        Text(
                          AppString.lastSynced,
                          style: TextStyle(
                            color: ColorHelper.greyColor,
                            fontSize: FontHelper.size_12,
                            fontWeight: FontHelper.regular,
                          ),
                        ),
                        SizedBox(width: DimensHelper.dimens_4),
                        Text(
                          'Just Now',
                          style: TextStyle(
                            color: ColorHelper.blackColor,
                            fontSize: FontHelper.size_12,
                            fontWeight: FontHelper.regular,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              1 => const Text('${AppString.challenge}s',
                  style: TextStyle(
                    fontSize: DimensHelper.dimens_20,
                    color: ColorHelper.primaryColor,
                    fontWeight: FontWeight.bold,
                  )),
              2 => const Text('${AppString.rewardAchievement}s',
                  style: TextStyle(
                    fontSize: DimensHelper.dimens_20,
                    color: ColorHelper.primaryColor,
                    fontWeight: FontWeight.bold,
                  )),
              3 => const Text(AppString.setting,
                  style: TextStyle(
                    fontSize: DimensHelper.dimens_20,
                    color: ColorHelper.primaryColor,
                    fontWeight: FontWeight.bold,
                  )),
              _ => null, // Default case for all other values
            },

          actions: switch (_selectedIndex) {
            0 => [
              customAssetImage(
                  onTap: () => Navigator.pushNamed(context, RouteName.wallet),
                  imgName: AppImages.goldCoinIcon,
                  height: context.globalSize.height/DimensHelper.dimens_18),
              const SizedBox(width: DimensHelper.dimens_12),
              customAssetImage(
                  onTap: () => Navigator.pushNamed(context, RouteName.notifications),
                  imgName: AppImages.notifyBallIcon,
                  height: context.globalSize.height/DimensHelper.dimens_16),
              const SizedBox(width: DimensHelper.dimens_12)
            ],
            1 => [],
            2 => [customAssetImage(imgName: AppImages.goldCoinIcon,
                onTap: () => Navigator.pushNamed(context, RouteName.wallet),
                height: context.globalSize.height/DimensHelper.dimens_18),
              const SizedBox(width: DimensHelper.dimens_12)],
            3 => [],
            _ => null, // Default case for all other values
          },

        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: _widgetOptions,
          // child: Center(child: _widgetOptions[_selectedIndex])),
        ),
        // body: _widgetOptions[_selectedIndex],
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: ColorHelper.primaryColor,
            borderRadius:  BorderRadius.only(
                topRight: Radius.circular(DimensHelper.dimens_20),
                topLeft: Radius.circular(DimensHelper.dimens_20)
            ),
          ),
          child: BottomNavigationBar(
            selectedFontSize: 12.0,
            unselectedFontSize: 12.0,
            // backgroundColor: AppColor.bgColor,
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            elevation: 0.0,
            selectedItemColor: ColorHelper.whiteColor,
            unselectedItemColor: ColorHelper.whiteColor,
            items:  [
              BottomNavigationBarItem(
                // key: homeKey,
                  icon: barImageIcons(image: AppImages.homeIcon),
                  activeIcon:  barImageIcons(
                      image: AppImages.homeIcon,
                      color: ColorHelper.whiteColor
                  ),
                  label: AppString.home),
              BottomNavigationBarItem(
                // key: homeKey,
                  icon: barImageIcons(image: AppImages.challengeIcon),
                  activeIcon:  barImageIcons(
                      image: AppImages.challengeIcon,
                      color: ColorHelper.whiteColor
                  ),
                  label: AppString.challenge),
              BottomNavigationBarItem(
                // key: homeKey,
                  icon: barImageIcons(image: AppImages.rewardIcon),
                  activeIcon:  barImageIcons(
                      image: AppImages.rewardIcon,
                      color: ColorHelper.whiteColor
                  ),
                  label: AppString.rewards),
              BottomNavigationBarItem(
                // key: homeKey,
                  icon: barImageIcons(image: AppImages.settingIcon),
                  activeIcon:  barImageIcons(
                      image: AppImages.settingIcon,
                      color: ColorHelper.whiteColor
                  ),
                  label: AppString.setting),

            ],
          ),
        ),
      ),
    );
  }

  Widget userDataLoading () {
    return Scaffold(
      backgroundColor: ColorHelper.whiteColor,
      body: Center(
        child: loadingIndicator(),
      ),
    );
  }

  Widget userDataError () {
    return  const Scaffold(
      backgroundColor: ColorHelper.whiteColor,
      body: Center(
        child: Text(AppString.somethingWentWrong, style: TextStyle(fontWeight: FontHelper.medium, color: ColorHelper.blackColor, fontSize:
        FontHelper.size_18),),
      ),
    );
  }


  barImageIcons({image,color}){
    return Image.asset(
      image,
      height: DimensHelper.dimens_22,
      color: color ?? ColorHelper.greyIcon2Color,
    );
  }



}


