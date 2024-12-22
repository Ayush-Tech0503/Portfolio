// // ignore_for_file: non_constant_identifier_names, deprecated_member_use, library_private_types_in_public_api
//
//
// import 'package:citybazaronline_seller_app/Utils/Constant%20Size%20/constant_sizes.dart';
// import 'package:citybazaronline_seller_app/Utils/Font%20Style/text_styles.dart';
// import 'package:citybazaronline_seller_app/Widget/custome_text_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../../../../Utils/Theme/constant_colors.dart';
// import '../../../../../Widget/Custome Buttons/elevetion_button_widget.dart';
// import '../../../../../Widget/Text Form Fields/global_text_form_field.dart';
// import '../../../uploaded_products_dart.dart';
//
// class ImageUploadingScreen extends StatefulWidget {
//   const ImageUploadingScreen({super.key});
//
//   @override
//   State<ImageUploadingScreen> createState() => _ImageUploadingScreenState();
// }
//
// class _ImageUploadingScreenState extends State<ImageUploadingScreen> {
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//
//   // dynamic _pickedImagePath = '';
//
//   Future<void> _pickImage(int index) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         tableData[index]['pickedImagePath'] = pickedFile.path; // Store picked image path
//       });
//     } else {
//       // Handle no image picked scenario
//     }
//   }
//
//
//   int rowCount = 2;
//
//   List<Map<String, dynamic>> tableData = [
//     {
//       'isPrimary': false,
//       'pickedImagePath': '',
//       'imageOrder': '1',
//       'productName': '',
//     }
//   ]; // List to hold table row data
//   // int rowCount = 1;
//
//   void _addRow() {
//     if (rowCount < 7) {
//       setState(() {
//         tableData.add({
//           // 'sno': rowCount.toString(),
//           'isPrimary': false,
//           'pickedImagePath': '',
//           'imageOrder': rowCount.toString(),
//           'productName': '',
//         });
//         rowCount++;
//       });
//     }
//   }
//
//   void _removeRow(int index) {
//     setState(() {
//       tableData.removeAt(index);
//       rowCount--;
//     });
//   }
//
//   void _updateSno(int index, String newSno) {
//     if (newSno.isNotEmpty && int.tryParse(newSno) != null) {
//       setState(() {
//         tableData[index]['imageOrder'] = newSno;
//       });
//     } else {}
//   }
//
//
//   void _validateImages() {
//     // Check if at least one image is uploaded
//     bool isImageUploaded = tableData.any((rowData) => rowData['pickedImagePath'].isNotEmpty);
//     if (!isImageUploaded) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Please upload at least one image.'),
//           duration: Duration(seconds: 2),
//         ),
//       );
//     }
//     }
//
//   bool areImagesValid() {
//     return tableData.any((rowData) => rowData['pickedImagePath'].isNotEmpty);
//   }
//
//   TextEditingController snoController = TextEditingController();
//   void _selectPrimaryImage(int rowIndex) {
//     setState(() {
//       for (int i = 0; i < tableData.length; i++) {
//         if (i == rowIndex) {
//           tableData[i]['isPrimary'] = true;
//         } else {
//           tableData[i]['isPrimary'] = false;
//         }
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var screenHeight = MediaQuery.of(context).size.height;
//     var screenWidth = MediaQuery.of(context).size.width;
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Table(
//                 columnWidths: {
//                   0: FixedColumnWidth(screenWidth * 0.2),
//                   1: FixedColumnWidth(screenWidth * 0.25),
//                   2: FixedColumnWidth(screenWidth * 0.3),
//                   3: FixedColumnWidth(screenWidth * 0.3),
//                   4: FixedColumnWidth(screenWidth * 0.3),
//                 },
//                 children: [
//                   // Table header row
//                   TableRow(
//                     decoration:BoxDecoration(
//                       color: ConstantColor.calendarBGHeadColor,
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     children:  [
//                       TableCell(child: paddingText(context: context, title:"\t\t\t\t\tS.No.",)),
//                       TableCell(child: paddingText(context: context, title:"Primary",)),
//                       TableCell(child: paddingText(context: context, title:"Choose Image",)),
//                       TableCell(child: paddingText(context: context, title:"Image Order",)),
//                       TableCell(child: paddingText(context: context, title:"Action",)),
//                     ],
//                   ),
//                   // Data rows
//                   ...tableData.asMap().entries.map((entry) {
//                     int index = entry.key;
//                     Map<String, dynamic> rowData = entry.value;
//                     // int rowIndex = int.parse(rowData['sno']!);
//                     TextEditingController snoController = TextEditingController(text: rowData['imageOrder'].toString());
//                     return TableRow(
//                       decoration: const BoxDecoration(
//                         border: Border(bottom: BorderSide(color: Colors.grey)),
//                       ),
//                       children: [
//                         TableCell(
//                           child: Container(
//                             margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
//                             child: customeText(
//                               text: '\t\t\t\t\t${(index+1).toString()} .',
//                               textAlign: TextAlign.start,
//                               style: ConstantTextStyle.topCategoryText2,
//                             ),
//                           ),
//                         ),
//
//                         TableCell(
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: GestureDetector(
//                               onTap: () {
//                                 _selectPrimaryImage(index);
//                               },
//                               child: Radio(
//                                 activeColor: ConstantColor.primaryMainColor,
//                                 value: true,
//                                 groupValue: rowData['isPrimary'],
//                                 onChanged: (value) {
//                                   _selectPrimaryImage(index);
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//
//                         TableCell(
//                           child: GestureDetector(
//                             onTap: () {_pickImage(index);},
//                             child: Container(
//                               margin: EdgeInsets.symmetric(vertical: screenHeight/80.0),
//                               padding: const EdgeInsets.all(8.0),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8.0),
//                                 border: Border.all(color: ConstantColor.chipCompleteStatus),
//                                 color: ConstantColor.primaryBackgroundMainColor
//                               ),
//                               child: Row(
//                                 children: [
//                                    const Icon(Icons.upload, color: ConstantColor.chipCompleteStatus),
//                                   constantWidth(context, 80.0),
//                                   customeText(text: 'Upload', style: ConstantTextStyle.greenText
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//
//                         TableCell(
//                           child:  GlobalTextFormField(
//                             margin: EdgeInsets.symmetric(vertical: screenHeight/80.0,horizontal: screenWidth/30.0),
//                             enabled: true,
//                             controller: snoController,
//                             keyboardType: TextInputType.number,
//                             hintText: "",
//                             labelText: "",
//                             maxLines: 1,
//                             onChanged: (value) {_updateSno(index, value);},
//                           ),
//
//                         ),
//
//                         TableCell(
//                           child: index == 0
//                               ? Container(
//                             margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
//                             child: Text(
//                               rowData['productName']!,
//                               style: const TextStyle(fontSize: 16.0),
//                             ),
//                           )
//                               : Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: customButton(
//                                 textStyleButton: ConstantTextStyle.landingScreenAppbarText,
//                                 onPressed:() {_removeRow(index);},
//                                 text: "Delete",
//                                 backgroundColor: ConstantColor.loginWithOtpButtonColor,
//                                 borderRadius: BorderRadius.circular(8.0),
//                                 elevation: 0.0,
//                                 minimumSize: Size(screenWidth, screenHeight/24.0)
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   }),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 16.0),
//           ElevatedButton(
//             onPressed:() {_addRow();
//               print("tableData=-----------$tableData");
//               },
//             child: const Text('Add Row'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
//
//
