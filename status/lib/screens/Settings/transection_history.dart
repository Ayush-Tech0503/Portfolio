import 'package:centavizers/helpers/color_helper.dart';
import 'package:centavizers/utils/globle_context.dart';
import 'package:flutter/material.dart';
import '../../components/back_button.dart';
import '../../components/common_image_widget.dart';
import '../../helpers/dimens_helper.dart';
import '../../helpers/font_helper.dart';
import '../../helpers/string_helper.dart';
import '../../utils/app_images.dart';
import '../home/wallet_screen.dart';

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const  Text(AppString.transactionHistory, style: TextStyle(color: ColorHelper.primaryColor,
              fontSize: FontHelper.size_22, fontWeight: FontHelper.bold),),
          leading: const BackButtonWidget()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            _contentBuilder(context),

            SizedBox(height: context.globalSize.height/DimensHelper.dimens_30,)
          ],
        ),
      ),
    );
  }




  //-----list builder--------------

  Widget _contentBuilder(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
         return buildTransactionTile(context);
        });
  }

  //-------------------------------

  Widget buildTransactionTile(BuildContext context)
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
        leading: imageContainer(imgName:AppImages.trophyIcon),
        title: const Text('Walk 3k steps',
            style:  TextStyle(
              color: ColorHelper.blackColor,
              fontSize: DimensHelper.dimens_16,
              fontWeight: FontWeight.bold,
            )),
        subtitle: const Text('Feb 23,2025',
            style:  TextStyle(
              color: ColorHelper.greyIcon2Color,
              fontSize: DimensHelper.dimens_14,
              fontWeight:  FontHelper.medium,
            )),


        trailing: SizedBox(
          width: DimensHelper.dimens_120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
           const Text("+100", style:  TextStyle(
                  fontSize: FontHelper.size_14,
                  fontWeight: FontHelper.bold,
                  color: ColorHelper.secondaryColor)),
            const  SizedBox(width: DimensHelper.dimens_8),
              customAssetImage(imgName:AppImages.coinIcon, height: DimensHelper.dimens_20),

            ],
          ),
        ),
        // trailing:
      ),
    );
  }
}
