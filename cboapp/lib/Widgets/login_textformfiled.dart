import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../Util/constaint_textstyle.dart';
import '../Util/constant_color.dart';
import 'Famous Market Widget/store_details_widget.dart';
import 'custome_text.dart';

Widget loginTextFormField1(
{controller,maxLength,
  enabled,
  fillColor,
  filled,
  initialValue,
  borderSideColor,
  obscuringCharacter,
     prefixIcon,
      cursorColor,
      onChanged,
      hintStyle,
      hintText,onTap,
      suffixIcon,
      suffixIconColor,
      validator,
      maxLines,autofocus,
      labelStyle,
      labelText,
      icon,inputFormatters,
      minLines,
      iconButton,prefix,
      keyboardType,
  autofillHints,
      context, suffix,focusNode}) {
  return
    Container(
    height:MediaQuery.of(context).size.height/18,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: borderSideColor,
            width: MediaQuery.of(context).size.width/100,
          ),
        ),
      ),
    child:
    TextFormField(
      onTap: onTap,
      inputFormatters: inputFormatters,
      maxLength:maxLength,
      autofocus: autofocus,
      enabled: enabled,
            style: ConstantTextStyle.textFormFildStyle2,
         controller: controller,
             validator:validator ,
         onChanged: onChanged,
         focusNode:focusNode ,
         cursorColor: cursorColor,
            keyboardType: keyboardType,
      autofillHints: autofillHints,
         autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            counterText: "",
           fillColor: fillColor,
           filled: filled,
            enabledBorder:  const OutlineInputBorder(
              borderSide: BorderSide(color: ConstantColor.textFieldColor),
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
              focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: ConstantColor.textFieldColor, ),
                borderRadius: BorderRadius.all(Radius.circular(0.0)),
              ),
           //   contentPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/40),
            labelText: labelText,
              labelStyle: labelStyle,
              hintStyle: hintStyle,
              hintText: hintText,
              prefix: prefix,
              isDense: true,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              suffixIconColor: suffixIconColor,
              icon:icon,

          ),
     ),
        );

}


Widget loginTextFormField2(
    {controller, textFormPaddingVertical, textFormPaddingHorizontal,
      enabled,
      fillColor,
      filled,
      initialValue,
      borderSideColor,
      prefixIcon,
      cursorColor,
      onChanged,
      hintStyle,
      hintText,
      suffixIcon,
      suffixIconColor,
      validator,
      maxLines,
      labelStyle,
      labelText,
      icon,
      helperText,
      minLines,
      obscureText = false,
      iconButton,
      maxLength,
      onSaved,
      obscuringCharacter = '•',
      keyboardType,height,inputFormatters,
      context, suffix,focusNode}) {
  return
    Container(
      //height:height,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: borderSideColor,
            width: MediaQuery.of(context).size.width/100,
          ),

        ),
      ),
      child:
      TextFormField(
        // inputFormatters:inputFormatters,
        obscuringCharacter: obscuringCharacter,
        onSaved: onSaved,
        obscureText: obscureText,
        minLines: minLines,
        maxLength: maxLength,
        maxLines: maxLines,
        enabled: enabled,
        initialValue: initialValue,
        style: ConstantTextStyle.textFormFildStyle2,
        controller: controller,
        validator:validator ,
        onChanged: onChanged,
        focusNode:focusNode ,
        cursorColor: cursorColor,
        keyboardType: keyboardType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          counterText: "",
          //  border: InputBorder.none,
          helperText: helperText,
          contentPadding:  EdgeInsets.symmetric(
               vertical: textFormPaddingVertical,
             horizontal: textFormPaddingHorizontal,
          ),
          fillColor: fillColor,
          filled: filled,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ConstantColor.textFieldColor,),
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: ConstantColor.textFieldColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
          ),
          //contentPadding: EdgeInsets.zero,
          labelText: labelText,
        //  floatingLabelBehavior: FloatingLabelBehavior.,
          labelStyle: labelStyle,
          hintStyle: hintStyle,
          hintText: hintText,
          isDense: true,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          suffixIconColor: suffixIconColor,
          icon:icon,

        ),
      ),
    );
}

Widget dropDownFormField ({containerLeftSideWidth, containerLeftSideColor,
  focusNode, borderRadius,  value, onChanged, items, hintText, hintStyle, labelText, labelStyle,prefixIcon,
  suffixIcon, leftDropdownButtonFormField,  rightDropdownButtonFormField }){
  return  Padding(
    padding:  const EdgeInsets.only(left:5.0),
    child: Container(
      decoration:  BoxDecoration(
        color: ConstantColor.primaryBackgroundMainColor,
        border: Border(
          left: BorderSide(
            width: containerLeftSideWidth,
            color: containerLeftSideColor,
          ),
          right: const BorderSide(
            color: ConstantColor.textFieldColor,
          ),
          top: const BorderSide(
            color: ConstantColor.textFieldColor,
          ),
          bottom: const BorderSide(
            color: ConstantColor.textFieldColor,
          ),
        ),
      ),
      child:  Form(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: leftDropdownButtonFormField,
                right: rightDropdownButtonFormField,
              ),
              child: DropdownButtonFormField<String>(
                menuMaxHeight: 200,
               // iconSize: 0.0,
                isExpanded: true,
                style: ConstantTextStyle.textFormFildStyle2,
                focusNode: focusNode,
                borderRadius:borderRadius,
                value: value,
                onChanged:onChanged,
                items: items,
                decoration:  InputDecoration(
                  filled: true,
                  fillColor: ConstantColor.primaryBackgroundMainColor,
                  hintText: hintText,
                  hintStyle: hintStyle,
                  labelText: labelText,
                  labelStyle:labelStyle,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: ConstantColor.primaryBackgroundMainColor,),
                    borderRadius: BorderRadius.all(Radius.circular(0.0)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ConstantColor.primaryBackgroundMainColor,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(0.0)),
                  ),
                  suffixIcon: suffixIcon,
                  prefixIcon: prefixIcon,
                ),
             icon: const Icon(Icons.arrow_drop_down_circle_outlined,
             color: ConstantColor.primaryMainColor,
             size: 25.0,),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


Widget dropDownForm({widthBorder,colorBorder,context,headText,menuMaxHeightFormField,focusNode,
  value,onChanged,items,hintText,
}){
  return  Container(
    decoration:  BoxDecoration(
      color: ConstantColor.primaryBackgroundMainColor,
      border: Border(
        left: BorderSide(
          color:colorBorder,
          width:widthBorder,
        ),
        top: const BorderSide(
          color: ConstantColor.transparent1,
        ),
        right: const BorderSide(
          color: ConstantColor.transparent1,
        ),
        bottom: const BorderSide(
          color: ConstantColor.transparent1,
        ),
      ),
    ),
    child:

    DropdownButtonFormField<String>(
      menuMaxHeight: menuMaxHeightFormField,
      isExpanded: true,
      elevation: 1,
      style: ConstantTextStyle.textFormFildStyle2,
      focusNode: focusNode,
      value: value,
      onChanged:onChanged,
      items: items,
      decoration:  InputDecoration(
        labelText: headText,
        labelStyle: ConstantTextStyle.lableRadioText,
        isDense: true,
        filled: true,
        fillColor: ConstantColor.primaryBackgroundMainColor,
        hintText:  hintText,
        hintStyle: ConstantTextStyle.textFormFildStyle2,
        enabledBorder:  const OutlineInputBorder(
          borderSide: BorderSide(color: ConstantColor.primaryBackgroundMainColor,),
          borderRadius: BorderRadius.zero,
        ),
        focusedBorder:  const OutlineInputBorder(
          borderSide: BorderSide(
            color: ConstantColor.textFieldColor,
          ),
         borderRadius: BorderRadius.zero,
        ),
      ),
      icon: const  Icon(Icons.arrow_drop_down_circle,
        color: ConstantColor.primaryMainColor,
        size: 25.0,),
      borderRadius: BorderRadius.circular(10.0),
      dropdownColor: ConstantColor.primaryBackgroundMainColor,
    ),
  );
}

Widget timeDropDownFormField ({
  formFieldStyle,
  value,hint,
  onChanged,
  items,
  focusNode,
  context,
  enabledBorderColor,
  focusedBorderColor,
}){
  return  Form(
    child: DropdownButtonFormField<String>(
      hint: hint,
      menuMaxHeight: 200,
      style: formFieldStyle,
      value: value,
      onChanged: onChanged,
      items: items,
      focusNode: focusNode,
      decoration: InputDecoration(
        filled: true,
        fillColor: ConstantColor.primaryBackgroundMainColor,
        contentPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 40,
          //  vertical: screenHeight/150
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: enabledBorderColor,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:  BorderSide(
            color:focusedBorderColor,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      iconEnabledColor: ConstantColor.primaryMainColor,
      icon: boxIcon(
        borderRadius: BorderRadius.circular(10.0),
        bgcolor: ConstantColor.searchBoxColor,
        icon: Icons.arrow_drop_down,
        iconsize: 20.0,
        iconcolor: ConstantColor.primaryMainColor,
      ),
      borderRadius: BorderRadius.circular(10.0),
      dropdownColor: ConstantColor.primaryBackgroundMainColor,
    ),
  );
}


Widget customeSwitch ({toggleColor, switchHeight, switchWidth,
  activeColor, inactiveColor,  inactiveToggleColor,  padding, toggleSize, borderRadius, value,  onToggle }) {
  return   FlutterSwitch(
    toggleColor:toggleColor,
    inactiveToggleColor: inactiveToggleColor,
    height:switchHeight,
    width: switchWidth,
    activeColor:activeColor,
    inactiveColor:inactiveColor,
    padding: padding,
    toggleSize: toggleSize,
    borderRadius:borderRadius,
    value: value,
    onToggle: onToggle,
  );
}

Widget radiobuttonContainer (
    {boarderColor, borderRadius, headText, headTextStyle, headTextPadding, radioButtonWidget,}) {
  return  Container(
    decoration: BoxDecoration(
      color: ConstantColor.primaryBackgroundMainColor,
      borderRadius: borderRadius,
      border: Border.all(color: boarderColor),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:headTextPadding,
          child: customeText(
            textAlign: TextAlign.start,
            text: headText,
            style:headTextStyle,
          ),
        ),
        radioButtonWidget,
      ],
    ),
  );
}

Widget radioButton ({text, style,value, groupValue, onChanged, }) {
  return Expanded(
    child: RadioListTile(
      visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
      dense: true,
      activeColor: ConstantColor.primaryMainColor,
      contentPadding: EdgeInsets.zero,
      title: customeText(text: text,style:style),
      value:  value,
      groupValue: groupValue,
      onChanged: onChanged,
    ),
  );
}


Widget calanderForm ({controller, textFormPaddingVertical, textFormPaddingHorizontal,
        enabled,
        fillColor,
        filled,
        initialValue,
        borderSideColor,
        obscuringCharacter,
        prefixIcon,
        cursorColor,
        onChanged,
        hintStyle,
        hintText,
        suffixIcon,
        suffixIconColor,
        validator,
        maxLines,
        labelStyle,
        labelText,
        icon,
        helperText,
        minLines, readOnly,
        obscureText,
        iconButton,
        onSaved,suffixIconOnTap, suffixIconBGColor,suffixIconData,suffixIconSize, suffixIconDataColor,
        keyboardType,height,
        context, suffix,focusNode}) {
  var screenWidth = MediaQuery.of(context).size.width;
  var screenHeight = MediaQuery.of(context).size.width;
    return
      Container(
        //height:height,
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: borderSideColor,
              width: MediaQuery.of(context).size.width/100,
            ),

          ),
        ),
        child:
        TextFormField(
          readOnly: readOnly,
          onSaved: onSaved,
          minLines: minLines,
          maxLines: maxLines,
          enabled: enabled,
          initialValue: initialValue,
          style: ConstantTextStyle.textFormFildStyle2,
          controller: controller,
          validator:validator ,
          onChanged: onChanged,
          focusNode:focusNode ,
          cursorColor: cursorColor,
          keyboardType: keyboardType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            //  border: InputBorder.none,
            helperText: helperText,
            contentPadding:  EdgeInsets.symmetric(
              vertical: textFormPaddingVertical,
              horizontal: textFormPaddingHorizontal,
            ),
            fillColor: fillColor,
            filled: filled,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: ConstantColor.textFieldColor,),
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: ConstantColor.textFieldColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
            //contentPadding: EdgeInsets.zero,
            labelText: labelText,
            //  floatingLabelBehavior: FloatingLabelBehavior.,
            labelStyle: labelStyle,
            hintStyle: hintStyle,
            hintText: hintText,
            isDense: true,
            suffixIcon: Container(
              padding: EdgeInsets.only(right: screenWidth/30, top: screenHeight/50, bottom: screenHeight/50),
              child: boxIcon(
                borderRadius: BorderRadius.circular(5.0),
                bgcolor: suffixIconBGColor,
                icon: suffixIconData,
                iconsize: suffixIconSize,
                iconcolor: suffixIconDataColor,
            onTap: suffixIconOnTap,
              ),
            ),
            prefixIcon: prefixIcon,
            suffixIconColor: suffixIconColor,
            icon:icon,

          ),
        ),
      );

  }

///////////////////////////

Widget passwordTextFormField(
    {controller,
      enabled,
      fillColor,
      filled,
      initialValue,
      borderSideColor,
      obscuringCharacter,
      prefixIcon,
      cursorColor,
      onChanged,
      hintStyle,
      hintText,
      suffixIcon,
      suffixIconColor,
      validator,
      maxLines,
      labelStyle,
      labelText,
      icon,
      minLines,
      obscureText,maxLength,
      iconButton,
      keyboardType,
      context, suffix,focusNode}) {
  return
    Container(
      height:MediaQuery.of(context).size.height/18,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: borderSideColor,
            width: MediaQuery.of(context).size.width/100,
          ),
        ),
      ),
      child:
      TextFormField(
        maxLength: maxLength,
        autofocus: true,
        enabled: enabled,
        obscureText: obscureText,
        initialValue: initialValue,
        style: ConstantTextStyle.textFormFildStyle2,
        controller: controller,
        validator:validator ,
        onChanged: onChanged,
        focusNode:focusNode ,
        cursorColor: cursorColor,
        keyboardType: keyboardType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          counterText: "",
          fillColor: fillColor,
          filled: filled,
          enabledBorder:  const OutlineInputBorder(
            borderSide: BorderSide(color: ConstantColor.textFieldColor),
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ConstantColor.textFieldColor, ),
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
          ),
          //   contentPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/40),
          labelText: labelText,
          labelStyle: labelStyle,
          hintStyle: hintStyle,
          hintText: hintText,

          isDense: true,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          suffixIconColor: suffixIconColor,
          icon:icon,

        ),
      ),
    );

}


/////////////////////////////////////////////////////////////////


Widget loginFlagTextField(
    {controller,maxLength,
      enabled,
      fillColor,
      filled,
      initialValue,
      borderSideColor,
      obscuringCharacter,
      prefixIcon,
      cursorColor,
      onChanged,
      hintStyle,
      hintText,onTap,
      suffixIcon,
      suffixIconColor,
      validator,
      maxLines,autofocus,
      labelStyle,
      labelText,
      icon,inputFormatters,
      minLines,
      obscureText,
      textInputAction,
      iconButton,prefix,
      keyboardType,
      context, suffix,focusNode,
      onFocusChange,
    }) {
  return
      Container(
        decoration: BoxDecoration(
          color: ConstantColor.primaryBackgroundMainColor,
          borderRadius: BorderRadius.circular(0.0),
          // border: Border.all(color: ConstantColor.primaryGreyColor),
          border: Border(
            left: BorderSide(
              color:  ConstantColor.primaryMainColor,
              width: MediaQuery.of(context).size.width/100,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0.5,
              blurRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        // elevation: 2,

        child: Focus(
          onFocusChange: onFocusChange,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Container(
              //     height:MediaQuery.of(context).size.height/18,
              //     decoration: BoxDecoration(
              //       border: Border(
              //         left: BorderSide(
              //           color: ConstantColor.primaryMainColor,
              //           width: MediaQuery.of(context).size.width/100,
              //         ),
              //       ),
              //     )),
              const SizedBox(width: 8),
              const Text(  '🇮🇳 ',
                style: TextStyle(fontSize: 18,),),
              // SizedBox(width: 8),
              const Text('+91',
                style: TextStyle(
                  fontWeight:FontWeight.w600,
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  color: ConstantColor.loginWithOtpButtonColor,),),
               Flexible(
                 child: TextFormField(
                   textInputAction:textInputAction,
                   //TextField
                  onTap: onTap,
                  inputFormatters: inputFormatters,
                  maxLength:maxLength,
                  autofocus: autofocus,
                  enabled: enabled,
                  // obscureText: obscureText,
                  initialValue: initialValue,
                  style: ConstantTextStyle.textFormFildStyle2,
                  controller: controller,
                  validator:validator ,
                  onChanged: onChanged,
                  focusNode:focusNode ,
                  cursorColor: cursorColor,
                  keyboardType: keyboardType,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    counterText: "",
                    fillColor: fillColor,
                    filled: filled,
                    enabledBorder:  const OutlineInputBorder(
                      borderSide: BorderSide(color: ConstantColor.transparent1),
                      borderRadius: BorderRadius.all(Radius.circular(0.0)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: ConstantColor.transparent1, ),
                      borderRadius: BorderRadius.all(Radius.circular(0.0)),
                    ),
                    //   contentPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/40),
                    labelText: labelText,
                    labelStyle: labelStyle,
                    hintStyle: hintStyle,
                    hintText: hintText,
                    prefix: prefix,
                    isDense: true,
                    suffixIcon: suffixIcon,
                    prefixIcon: prefixIcon,
                    suffixIconColor: suffixIconColor,
                    icon:icon,

                  ),
              ),
               ),
            ],
          ),
        ),
      );

}


//---------------------------------------------------


// Widget dropDownButton ({colorBorder,widthBorder,icons,hintText,style,items,value,onChanged,dropDownHeight,iconSize,padding,iconColor,
//   iconEnabledColor, iconDisabledColor,focusNode}){
//   return   Container(
//     decoration:  BoxDecoration(
//       color: ConstantColor.primaryBackgroundMainColor,
//       border: Border(
//         left: BorderSide(
//           color:colorBorder,
//           width:widthBorder,
//         ),
//         top: const BorderSide(
//           color: ConstantColor.transparent1,
//         ),
//         right: const BorderSide(
//           color: ConstantColor.transparent1,
//         ),
//         bottom: const BorderSide(
//           color: ConstantColor.transparent1,
//         ),
//       ),
//     ),
//     child: DropdownButtonHideUnderline(
//       child: DropdownButton2<String>(
//         focusNode: focusNode,
//         isDense:true,
//         isExpanded: true,
//         hint: Text( hintText),
//         style: style,
//         items: items,
//         value: value,
//         onChanged: onChanged,
//         buttonStyleData: ButtonStyleData(
//           height: dropDownHeight,
//           // padding:  padding,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5.0),
//             border: Border.all(
//               color: ConstantColor.primaryGreyColor,
//             ),
//             color: ConstantColor.primaryBackgroundMainColor,
//           ),
//           //  elevation: 2,
//         ),
//         // iconStyleData:  IconStyleData(
//         //   icon:customIconButton(
//         //     icon: icons,iconColor: iconColor,
//         //     iconSize: iconSize,
//         //   ),
//         //   // iconSize: iconSize,
//         //   iconEnabledColor: iconEnabledColor,
//         //   iconDisabledColor:iconDisabledColor,),
//         dropdownStyleData: DropdownStyleData(
//           padding:  padding,
//           maxHeight: 200,
//
//           // scrollPadding: EdgeInsets.symmetric(horizontal: 10),
//           // width: double.maxFinite,
//           decoration: BoxDecoration(
//             boxShadow: [
//               BoxShadow(
//                 color: ConstantColor.primaryBackgroundMainColor,
//                 blurRadius: 10,
//                 spreadRadius: 5,    // Adjust the spread radius as needed
//                 offset: Offset(0, 0), // Specify the shadow's position
//               ),
//             ],
//             border: Border.all(color: ConstantColor.primaryMainColor, width: 0.5),
//             borderRadius: BorderRadius.circular(8.0),
//             color:ConstantColor.primaryBackgroundMainColor,
//           ),
//           elevation: 0,
//
//           offset: const Offset(0, -10),
//           scrollbarTheme: ScrollbarThemeData(
//             radius: const Radius.circular(50),
//             thickness: MaterialStateProperty.all<double>(5.0),
//             thumbVisibility: MaterialStateProperty.all<bool>(true),
//           ),
//         ),
//         menuItemStyleData: const MenuItemStyleData(
//           //   height: 40,
//           padding: EdgeInsets.zero,
//         ),
//       ),
//     ),
//   );
// }
//
