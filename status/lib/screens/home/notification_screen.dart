// import 'package:flutter/material.dart';
//
// import '../../components/back_button.dart';
// import '../../helpers/color_helper.dart';
// import '../../helpers/dimens_helper.dart';
// import '../../helpers/string_helper.dart';
//
// class NotificationScreen extends StatelessWidget {
//   const NotificationScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(leading: const BackButtonWidget()),
//         body:  Padding(
//           padding: const EdgeInsets.symmetric(horizontal: DimensHelper.dimens_20),
//           child: Column(
//             children: [
//               const Text(AppString.notification,
//                   style: TextStyle(
//                     fontSize: DimensHelper.dimens_20,
//                     color: ColorHelper.primaryColor,
//                     fontWeight: FontWeight.bold,
//                   )),
//
//
//
//              
//
//             ],
//           ),
//         ));
//   }
// }

import 'package:centavizers/utils/globle_context.dart';
import 'package:flutter/material.dart';

import '../../components/back_button.dart';
import '../../components/common_image_widget.dart';
import '../../helpers/color_helper.dart';
import '../../helpers/dimens_helper.dart';
import '../../helpers/font_helper.dart';
import '../../helpers/string_helper.dart';
import '../../utils/app_images.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonWidget(),
        title:const Text(AppString.notification),
        backgroundColor: Colors.white,
        titleSpacing: 0,
          titleTextStyle: const TextStyle(
              fontSize: DimensHelper.dimens_20,
              color: ColorHelper.primaryColor,
              fontWeight: FontWeight.bold,
            ),
      ),
      body: SingleChildScrollView(
        // padding: const EdgeInsets.all(DimensHelper.dimens_20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            NotificationSection(
              title: 'Unread',
              count: 2,
              notifications: List.generate(2, (index) => AppString.dummyNotificationTitle,
              ),
            ),
            const SizedBox(height: 20),
            NotificationSection(
              title: 'Yesterday',
              count: 2,
              notifications: List.generate(
                2, (index) => AppString.dummyNotificationTitle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationSection extends StatelessWidget {
  final String title;
  final int count;
  final List<String> notifications;

  const NotificationSection({super.key,
    required this.title,
    required this.count,
    required this.notifications,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: DimensHelper.dimens_20,vertical: DimensHelper.dimens_8),
          child: Row(
            children: [
              Text(
                '$title',
                style: const TextStyle(
                  fontSize: DimensHelper.dimens_16,
                  color: ColorHelper.blackColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal:  DimensHelper.dimens_4),
                margin: const EdgeInsets.only(left: DimensHelper.dimens_10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(DimensHelper.dimens_8)),
                  border: Border.all(color: ColorHelper.secondaryColor)
                ),
                child: Text(
                  '$count',
                  style: const TextStyle(
                    fontSize: DimensHelper.dimens_14,
                    color: ColorHelper.primaryColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          itemCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            // final notification = notifications[index];
            return const NotificationItem(
              notification: AppString.dummyNotificationTitle,
              time: '2 min ago',);
          },
        ),
        // Column(
        //   children: notifications.map((notification) {
        //     return NotificationItem(notification: notification);
        //   }).toList(),
        // ),
      ],
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String notification;
  final String time;

  const NotificationItem({super.key,
    required this.notification,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: DimensHelper.dimens_20,vertical: DimensHelper.dimens_8),
      // decoration: BoxDecoration(
        color: ColorHelper.secondaryGreyColor,
      //   borderRadius: BorderRadius.circular(8),
      // ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customAssetImage(
              bgColor:ColorHelper.whiteColor,
              imgName: AppImages.appLogoIcons,
              height: context.globalSize.height/DimensHelper.dimens_16
          ),
          // const Icon(Icons.notifications, color: Colors.blue), // Notification icon
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notification,
                  style: const TextStyle(
                      color: ColorHelper.blackColor,
                      fontSize: FontHelper.size_14,
                      fontWeight: FontHelper.regular
                  ),
                ),
                const SizedBox(height: 5),
                 Text(
                  time,
                  style: const TextStyle(
                      color: ColorHelper.greyIcon2Color,
                      fontSize: FontHelper.size_12,
                      fontWeight: FontHelper.regular
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}