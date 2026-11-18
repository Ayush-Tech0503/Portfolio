import 'package:flutter/material.dart';

import '../Util/constaint_textstyle.dart';
import '../Util/constant_color.dart';

Widget searchbarBox({hintText,context,color,cursorColor,onPressed,prefixIcon,suffixIcon,
  icon, iconOnPressed,onSubmmitted,textInputAction,onEditingComlete,controller,labelText,autofocus,
onTap,onChanged }){
  var width = MediaQuery.of(context).size.width;
  return TextField(
    controller:controller,
    onEditingComplete: onEditingComlete,
    style: ConstantTextStyle.otpResendButtonText,
    textInputAction: textInputAction,
    onSubmitted: onSubmmitted,
    cursorColor: ConstantColor.primaryMainColor,
    onChanged:onChanged,
    autofocus: autofocus??false,
    readOnly: false,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: width/30.0),
      hintText: hintText??"",
      label: Text(labelText ??  "Search Products & Shops",style:ConstantTextStyle.becomeSellerDiscText,),
      suffixIcon: IconButton(
        icon:  icon,
        onPressed: iconOnPressed,
      ),
      prefixIcon: prefixIcon,
      fillColor: ConstantColor.searchBoxColor,
      filled: true,
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ConstantColor.primaryMainColor),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ConstantColor.primaryGreyColor),
      ),
      // prefix: prefix,
    ),
  );
  //   Container(
  //   decoration: BoxDecoration(
  //     color: color,
  //     borderRadius: const BorderRadius.all(Radius.circular(8.0)),
  //     // boxShadow: [
  //     //   BoxShadow(
  //     //     color: Colors.grey.withOpacity(0.5), // Shadow color
  //     //     spreadRadius: 1, // How spread out the shadow is
  //     //     blurRadius: 2, // How blurry the shadow is
  //     //     offset: const Offset(0, 0), // The position of the shadow
  //     //   ),
  //     // ],
  //
  //     // border: const Border(
  //     //   left: BorderSide(
  //     //     color: Color(0xffee5816),
  //     //     width: 3.5,
  //     //   ),
  //     // ),
  //     // borderRadius: BorderRadius.only()
  //   ),
  //  height: height/18,
  //   child: TextField(
  //     controller:controller,
  //     onEditingComplete: onEditingComlete,
  //     style: ConstantTextStyle.otpResendButtonText,
  //     textInputAction: textInputAction,
  //     onSubmitted: onSubmmitted,
  //     cursorColor: ConstantColor.primaryMainColor,
  //     onChanged:onChanged,
  //     autofocus: false,
  //     readOnly: false,
  //     decoration: InputDecoration(
  //       hintText: hintText,
  //       suffixIcon: IconButton(
  //         icon:  icon,
  //         onPressed: iconOnPressed,
  //       ),
  //       prefixIcon: prefixIcon,
  //       fillColor: ConstantColor.searchBoxColor,
  //       filled: true,
  //       focusedBorder: const OutlineInputBorder(
  //         borderSide: BorderSide(color: ConstantColor.primaryMainColor),
  //       ),
  //       enabledBorder: const OutlineInputBorder(
  //         borderSide: BorderSide(color: ConstantColor.primaryGreyColor),
  //       ),
  //       // prefix: prefix,
  //     ),
  //   ),
  // );
}
// Widget menuIcon ({context}){
//   return  Row(
//     children:  [
//       Padding(
//         padding: EdgeInsets.only(
//           top: MediaQuery.of(context).size.height/30,
//           left: MediaQuery.of(context).size.width/30,
//         ),
//         child: const Icon(Icons.menu,),
//       ),
//     ],
//   );
// }