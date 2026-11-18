import 'package:centavizers/helpers/color_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/back_button.dart';
import '../../cubits/manage_notification/manage_notification.dart';
import '../../helpers/dimens_helper.dart';
import '../../helpers/font_helper.dart';
import '../../helpers/string_helper.dart';

class ManageNotification extends StatelessWidget {
  const ManageNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButtonWidget()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(AppString.manageNotification, style: TextStyle(color: ColorHelper.primaryColor,
                fontSize: FontHelper.size_22, fontWeight: FontHelper.bold),),
            const SizedBox(height: 20),
            BlocBuilder<ManageNotificationCubit, Map<String, bool>>(
              builder: (context, state) {
                return Column(
                  children: [
                    buildNotificationTile(context, AppString.allNotification, state['allPushNotifications']!, 'allPushNotifications'),
                    buildNotificationTile(context,AppString.challengeAlert, state['challengeAlert']!, 'challengeAlert'),
                    buildNotificationTile(context, AppString.rewardAlert, state['rewardAlert']!, 'rewardAlert'),
                    buildNotificationTile(context, AppString.deviceUpdates, state['deviceUpdates']!, 'deviceUpdates'),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNotificationTile(BuildContext context, String title, bool value, String key)
  {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: DimensHelper.dimens_14),
      margin: const EdgeInsets.symmetric(vertical: DimensHelper.dimens_10),
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

      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(title,
            style: const TextStyle(
              color: ColorHelper.greyIcon2Color,
              fontSize: DimensHelper.dimens_16,
              fontWeight: FontWeight.bold,
            )),
        trailing: Switch(
          activeColor: ColorHelper.whiteColor,
          activeTrackColor: ColorHelper.primaryColor,
          inactiveThumbColor: ColorHelper.whiteColor,
          inactiveTrackColor: ColorHelper.greyIcon2Color,
          splashRadius: 30.0,
          value: value,
          onChanged: (newValue) => context.read<ManageNotificationCubit>().toggleNotification(key, newValue),
        ),
      ),
    );
  }
}
