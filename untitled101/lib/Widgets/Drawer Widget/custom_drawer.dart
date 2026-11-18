import 'package:flutter/material.dart';
import '../../Util/constant_color.dart';
import '../custome_text.dart';
Widget myDrawer ({icon, closeIconSize , closeIconColor, context, onPressedCloseIcon,
  sizeBoxHeight,  drawerHeaderText, drawerHeaderTextStyle, centerDrawerColor,centerDrawerBorder,child, }){
  var screenWidth = MediaQuery.of(context).size.width;
  var screenHeight = MediaQuery.of(context).size.height;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(
            left: screenWidth/1.6
        ),
        child: IconButton(
          icon: Icon(
            icon,
            size: closeIconSize,
          color:closeIconColor,),
          onPressed: onPressedCloseIcon),
      ),
      SizedBox(
        height: sizeBoxHeight,
        child: DrawerHeader(
          child: Align(
             alignment: Alignment.topLeft,
            child: customeText(
              textAlign: TextAlign.start,
              text: drawerHeaderText,
              style: drawerHeaderTextStyle,
            ),
          ),
          //Text('Drawer Header',style: Constant,),
        ),
      ),
      Expanded(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: screenHeight/20,
             left: screenWidth/40,
             right: screenWidth/30,
          ),
          child: Container(
            decoration: BoxDecoration(
                color:centerDrawerColor,
                borderRadius: centerDrawerBorder,
            ),
            child: child,
          ),
        ),
      ),
    ],
  );
}



/*---------------------filter Drawer start----------------------*/
Widget filtersDrawer ({controller,context,headTitleText,headTitleTextStyle,
clearButtonOnTap,clearButtonText, clearButtonTextStyle,headDividerColor,
  scrollableTrackVisibility,scrollableThumbVisibility,scrollableController,scrollbarChildWidget }){
  var screenWidth = MediaQuery.of(context).size.width;
  return DrawerHeader(
    padding: EdgeInsets.zero,
    child: SingleChildScrollView(
      controller: controller,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            horizontalTitleGap: screenWidth/2.5,
            // minLeadingWidth: screenWidth/2.1,
            dense: true,
            leading: customeText(
              text: headTitleText,
              overflow: TextOverflow.ellipsis,
              style: headTitleTextStyle,
            ),
            title: GestureDetector(
              onTap: clearButtonOnTap,
              child: customeText(
                text: clearButtonText,
                textAlign: TextAlign.start,
                style: clearButtonTextStyle,
              ),
            ),
          ),
           Divider(
            color: headDividerColor,
            thickness: 1.0,
            height: 0.0,
          ),
          ScrollbarTheme(
            data: ScrollbarThemeData(
              thumbColor: MaterialStateProperty.all<Color>(ConstantColor.primaryMainColor),
              trackColor: MaterialStateProperty.all<Color>(ConstantColor.carColor),
            ),
            child: Scrollbar(
              trackVisibility: scrollableTrackVisibility,
              thumbVisibility: scrollableThumbVisibility,
              controller: scrollableController,
              thickness: 5.0,
              radius: const Radius.circular(10.0),
              child: scrollbarChildWidget,
            ),
          ),
        ],
      ),
    ),
  );
}


/*---------------------filter Drawer End----------------------*/