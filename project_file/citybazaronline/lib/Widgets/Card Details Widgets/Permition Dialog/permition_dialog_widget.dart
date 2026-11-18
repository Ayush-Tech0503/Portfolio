// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import '../../../Util/constant_color.dart';

class YesNoPermissionDialog {
  static Future<bool> showExitConfirmationDialog({
    required BuildContext context,
    required String title,
    required String content,
    required List<Widget> actions,
  }) async {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return await showDialog(
      // barrierColor: Colors.transparent,
      context: context,
      builder: (context) => AlertDialog(
        iconPadding: EdgeInsets.zero,
        icon: IconButton(
          icon: const CircleAvatar(
            backgroundColor: ConstantColor.primaryGreyColor,
            radius: 25.0,
            child: Icon(
              Icons.question_mark_outlined,
              size: 30.0,
              color:ConstantColor.loginWithOtpButtonColor,
            ),
          ),
          onPressed: () {
            // Add your onPressed functionality here
          },
        ),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
        // backgroundColor: ConstantColor.primaryBackgroundMainColor,
        title: Text(title,textAlign: TextAlign.center,),
        content: Text(content,textAlign: TextAlign.center,),
        contentPadding: EdgeInsets.symmetric(horizontal: screenWidth / 30),
        titlePadding: EdgeInsets.symmetric(horizontal: screenWidth / 30,),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: EdgeInsets.symmetric(vertical: screenHeight /80),
        actions: actions,
      ),
    ) ??
        false;
  }
}


//  YesNoPermissionDialog.showExitConfirmationDialog(
//                                                         context:context, title: 'Please Confirm!', content: 'Are you sure want to remove this Product?',
//                                                         actions: [
//                                                           customeButton(
//                                                             textStyleButton: ConstantTextStyle.landingScreenAppbarText,
//                                                             onPressed:() async {
//                                                               Navigator.pop(context);
//                                                               await CardDeleteApiService.fetchCardDeleteData(
//                                                                 context: context,cartId: dataItems!.cartId??"",
//                                                                 onSuccess: (){
//                                                                   isLoading = true;
//                                                                   data!.clear();
//                                                                   fetchCardProductsListData();
//                                                                   fetchProductCount();
//                                                                   //  Navigator.pop(context);
//                                                                 },
//                                                               );
//                                                             },
//                                                             text: "Yes",
//                                                             backgroundColor: ConstantColor.loginWithOtpButtonColor,
//                                                             borderRadius: BorderRadius.circular(20.0),
//                                                             elevation: 0.0,
//                                                           ),
//                                                           SizedBox(width: screenW/100.0,),
//                                                           customeButton(
//                                                             textStyleButton: ConstantTextStyle.landingScreenAppbarText,
//                                                             onPressed:() => Navigator.pop(context),
//                                                             text: "No",
//                                                             backgroundColor: ConstantColor.primaryMainColor,
//                                                             borderRadius: BorderRadius.circular(20.0),
//                                                             elevation: 0.0,
//                                                           ),
//                                                         ],
//                                                       );