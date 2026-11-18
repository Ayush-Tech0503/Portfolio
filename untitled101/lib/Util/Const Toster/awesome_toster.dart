import 'package:Citybazar_app/Util/constaint_textstyle.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

 awesomeTost(BuildContext context,text) {
  var awesomeDialog = AwesomeDialog(
    context: context,
    animType: AnimType.scale,
    dialogType: DialogType.success,
    body: Center(
      child: Text( text,
        textAlign: TextAlign.center,
        style: ConstantTextStyle.topCategoryText4,
      ),
    ),
    // title: 'This is Ignored',
    // desc: 'This is also Ignored',
    btnOkOnPress: () {
      Navigator.pop(context);
    },
  )..show();
}
