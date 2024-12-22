// // ignore_for_file: non_constant_identifier_names
//
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import '../../Util/constant_color.dart';
// import '../custome_text.dart';
// final List<String> items = [
//   'Item1',
//   'Item2',
//   'Item3',
//   'Item4',
//   'Item5',
//   'Item6',
// ];
// String? selectedValue;
// Widget DropDownMenu ({hint, item, value,onChanged, buttonBorderRadius,dropDownborderColor,
//   dropDownborderRadius, buttonHeight,buttonColor, iconStyleData,menuItemStyleData, borderColor,
//   menuItemPadding, menuItemHeight,}) {
//   return DropdownButtonHideUnderline(
//     child: DropdownButton2(
//     //  isExpanded: true,
//       hint: hint,
//       items: item,
//       value: value,
//       onChanged: onChanged,
//       buttonStyleData: ButtonStyleData(
//         height: buttonHeight,
//         decoration: BoxDecoration(
//           borderRadius: buttonBorderRadius,
//           border: Border.all(
//             color: borderColor,
//           ),
//           color: buttonColor,
//         ),
//         elevation: 0,
//       ),
//
//       iconStyleData: iconStyleData,
//       dropdownStyleData: DropdownStyleData(
//         maxHeight: 200,
//         decoration: BoxDecoration(
//           borderRadius: dropDownborderRadius,
//           color: dropDownborderColor,
//         ),
//         elevation: 8,
//         scrollbarTheme: ScrollbarThemeData(
//           crossAxisMargin: 2.5,
//           trackBorderColor: MaterialStateProperty.all(ConstantColor.trackBGolor),
//           thumbColor: MaterialStateProperty.all(ConstantColor.primaryMainColor),
//           trackColor: MaterialStateProperty.all(ConstantColor.trackBGolor),
//           radius: const Radius.circular(8.0),
//           thickness: MaterialStateProperty.all(4),
//           mainAxisMargin: 8,
//           thumbVisibility: MaterialStateProperty.all(true),
//           trackVisibility: MaterialStateProperty.all(true),
//         ),
//       ),
//       menuItemStyleData:  MenuItemStyleData(
//         height: menuItemHeight,
//         padding:  menuItemPadding,
//       ),
//     ),
//   );
// }
//
//
// /*-------DashBoard Items inner Row data (:show : DropDown : Entry and search box)- section start-----------*/
// Widget dashBordItems ({context, searchBoxWidget ,dropDownWidget, text, style, entriesText , entriesTextStyle    }){
//   var screenWidth = MediaQuery.of(context).size.width;
//   return   Container(
//     padding: EdgeInsets.symmetric(horizontal: screenWidth/30, ),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(10.0),
//       color: ConstantColor.sellerBGColor,
//     ),
//     child: Row(
//       children: [
//         // customeText(text: text, style: style ),
//         // SizedBox(width: screenWidth/30),
//         // dropDownWidget,
//         SizedBox(width: screenWidth/40),
//         customeText(text: entriesText, style: entriesTextStyle),
//         SizedBox(width: screenWidth/30),
//         Expanded(
//           child:  searchBoxWidget,),
//       ],
//     ),
//   );
// }
//
// /*-------DashBoard Items inner Row data (:show : DropDown : Entry and search box)- section end-----------*/
//
// /*------------------------Scrolling Row and Column(Data Table) Start---------------------------------------*/
// Widget dataTableWidget ({context, backGroundColor, borderRadius, crossAxisMargin, thickness, trackBorderColor,
//   trackColor, thumbColor, scrollBarController, scrollViewController, scrollDirection, dataTableRowColumnWidget}) {
//   var screenHeight = MediaQuery.of(context).size.height;
//   var screenWidth = MediaQuery.of(context).size.width;
//   return  Padding(
//     padding:  EdgeInsets.symmetric(horizontal: screenWidth/30),
//     child: Container(
//       decoration: BoxDecoration(
//         color:backGroundColor,
//         borderRadius:borderRadius,
//       ),
//       padding: EdgeInsets.symmetric(horizontal: screenWidth/30, vertical: screenHeight/30),
//       child: ScrollbarTheme(
//         data: ScrollbarThemeData(
//           crossAxisMargin: crossAxisMargin,
//           radius: const Radius.circular(10.0),
//           thickness: thickness,
//           trackBorderColor: trackBorderColor,
//           thumbColor:thumbColor,
//           trackColor:trackColor,
//         ),
//         child: Scrollbar(
//           controller: scrollBarController,
//           trackVisibility: true,
//           thumbVisibility: true,
//           child: SingleChildScrollView(
//             controller:scrollViewController,
//             scrollDirection:scrollDirection,
//             child: dataTableRowColumnWidget,
//           ),
//         ),
//       ),
//     ),
//   );
// }
//
// /*------------------------Scrolling Row and Column(Data Table) end---------------------------------------*/
//
//
//
