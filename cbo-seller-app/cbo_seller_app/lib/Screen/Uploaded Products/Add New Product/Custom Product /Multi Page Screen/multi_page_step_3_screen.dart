// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables, must_be_immutable

import 'dart:convert';
import 'package:citybazaronline_seller_app/Widget/custome_rich_text.dart';
import 'package:dio/dio.dart';
import 'package:citybazaronline_seller_app/Utils/Theme/constant_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:uuid/uuid.dart';
import '../../../../../Services/Custom Product Api Services/image_uploading_api_services.dart';
import '../../../../../Utils/Font Style/text_styles.dart';
import 'package:flutter/material.dart';
import '../../../../../Widget/Custome Buttons/elevetion_button_widget.dart';
import '../../../../../Widget/Scaffold Message/scaffold_message_widget.dart';
import '../../../../../Widget/Text Form Fields/global_text_form_field.dart';
import '../../../../../Widget/custome_text_widget.dart';
import '../../../../../Widget/images/cached_images_widget.dart';
import '../../../uploaded_products_dart.dart';

class MultiPageStep3rdScreen extends StatefulWidget {
  final Function onNext;
  final Function onPreview;
  final  currectPageValue;
  List<Map<String, dynamic>>  myColorList;
    MultiPageStep3rdScreen({super.key, required this.onNext, required this.onPreview, this.currectPageValue, required this.myColorList});

  @override
  State<MultiPageStep3rdScreen> createState() => _MultiPageStep3rdScreenState();
}

class _MultiPageStep3rdScreenState extends State<MultiPageStep3rdScreen> with TickerProviderStateMixin {

  @override
  void dispose() {
    // Clean up text editing controllers
    productImages.clear();
    primaryImageIndexes.clear();
    super.dispose();
  }


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, List<Map<String, dynamic>>> productImages = {};

  // Map to store primary image indexes per color
  Map<String, int> primaryImageIndexes = {};



  @override
  void initState() {
    super.initState();
    initializeProductImages();
    initializePrimaryImageIndexes();
  }

  void initializeProductImages() {
    if (widget.myColorList.isEmpty) {
      // Show static data if myColorList is empty
      productImages["defaultColor"] = [
        {
          "imageUrl": {"url": ""},
          "imageOrder": "1",
          "isPrimary": true,
          "color": "defaultColor",
          "uuid": const Uuid().v1(),
          "index": 0,
        }
      ];
    } else {
      // Initialize productImages with empty lists for each color in myColorList
      for (var colorMap in widget.myColorList) {
        var colorKey = colorMap.keys.first;
        productImages[colorKey] = [];
        // Example: Adding initial image for each color
        productImages[colorKey]!.add({
          "imageUrl": {"url": ""},
          "imageOrder": "1",
          "isPrimary": true,
          "color": colorKey,
          "uuid": const Uuid().v1(),
          "index": 0,
        });
      }
    }
  }

  // void initializeProductImages() {
  //   // Initialize productImages with empty lists for each color
  //   for (var colorMap in widget.myColorList) {
  //     var colorKey = colorMap.keys.first;
  //     productImages[colorKey] = [];
  //     uuid = const Uuid();
  //   }
  //
  //   // Example: Adding initial image for each color
  //   productImages.forEach((color, images) {
  //     images.add({
  //       "imageUrl": {"url": ""},
  //       "imageOrder": "1",
  //       "isPrimary": true,
  //       "color": color,
  //       "uuid": "${uuid.v1()}",
  //       "index": 0,
  //     });
  //   });
  //
  // }

  void initializePrimaryImageIndexes() {
    // Initialize primaryImageIndexes with default values
    for (var colorMap in widget.myColorList) {
      var colorKey = colorMap.keys.first;
      primaryImageIndexes[colorKey] = 0; // Set the initial primary image index for each color
    }
  }

  void _selectPrimaryImage(String color, int idx) {
    setState(() {
      // Update isPrimary for the selected index in productImages
      for (var image in productImages[color]!) {
        image['isPrimary'] = false; // Reset all to false initially
      }
      productImages[color]![idx]['isPrimary'] = true; // Set selected image as primary
    });
  }


  Future<void> _pickImage(String colorKey, int idx) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        // Update imageUrl for the selected index
        _handleUploadImageSubmit(colorKey, idx, pickedFile.path);
      });
    } else {
      // Handle no image picked scenario
    }
  }

  void _handleUploadImageSubmit(String colorKey, int idx, imageUrl) async {
    FormData formData = FormData();
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      try {
        // Extract file name from the path
        String fileName = imageUrl!.split('/').last;
        formData.files.add(MapEntry("image", await MultipartFile.fromFile(imageUrl!, filename: fileName)));
      } catch (e) {
        formData.fields.add(MapEntry("image", imageUrl!));
      }
    } else {
      LoadingScaffoldMessage.showSnackbar(
        context, "Please upload imageUrl file as it is required.",
        Colors.red,
        const Duration(seconds: 2),
      );
      return;
    }
    fetchUploadImageData(
      context: context,
      formData: formData,
      onSuccess: (imageUrl) {
        setState(() {
          productImages[colorKey]![idx]['imageUrl']['url'] = imageUrl;
        });
        // Handle successful upload
      },
    );
  }

  void addNewImage(String color) {
    setState(() {
      uuid = const Uuid();
      // Check if productImages already contains the color
      if (productImages.containsKey(color)) {
        // Get the list of images for the specified color
        List<Map<String, dynamic>> images = productImages[color]!;
        // Check if the maximum limit (6 images) has been reached
        if (images.length >= 6) {
          // Display a message to the user that the limit has been reached
          LoadingScaffoldMessage.showSnackbar(
            context, "Sorry!! you can only add up to 6 images per color",
            Colors.red, // Change color as per your theme
            const Duration(seconds: 2),
          );
          return; // Exit the function if the limit is reached
        }


        // Construct a new image object
        Map<String, dynamic> newImageObject = {
          "imageUrl": {"url": ""},
          "imageOrder": (images.length + 1).toString(),
          "isPrimary": primaryImageIndexes[color] == images.length,
          "color": color,
          "uuid": '${uuid.v1()??""}',
          "index": images.length,
        };

        // Push the new image object into the corresponding color array
        images.add(newImageObject);
      }
    });
  }

  void deleteImage(String color, int idx) {
    setState(() {
      // Check if productImages contains the color
      if (productImages.containsKey(color)) {
        // Get the list of images for the specified color
        List<Map<String, dynamic>> images = productImages[color]!;

        // Remove the image at the specified index
        images.removeAt(idx);

        // Update the imageOrder for the remaining images
        for (int i = 0; i < images.length; i++) {
          images[i]["imageOrder"] = (i + 1).toString();
        }

        // Adjust primaryImageIndexes if the deleted image was primary
        if (primaryImageIndexes[color] == idx) {
          // Set the first image as primary if available
          primaryImageIndexes[color] = images.isEmpty ? -1 : 0;
        } else if (primaryImageIndexes[color]! > idx) {
          // Decrement primaryImageIndexes for indexes greater than the deleted index
          primaryImageIndexes[color] = primaryImageIndexes[color]! - 1;
        }
      }
    });
  }


  void _updateImageOrder(String color, int imageIndex, String newOrder) {
    if (newOrder.isNotEmpty && int.tryParse(newOrder) != null) {
      setState(() {
        productImages[color]![imageIndex]["imageOrder"] = newOrder;
      });
    }
  }


  bool isLoading = false;
  bool hasImageError = false;
  dynamic uuid;

  void _handleSubmit() async {
    List<Map<String, dynamic>> updatedList = [];
    updatedList.add(productImages);
    if (_formKey.currentState!.validate()) {
      // Create FormData object
      // FormData formData = FormData();
      // formData.fields.addAll([
      //   MapEntry("product_img", updatedList.toString()),
      // ]);

      // Save data to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('product_img', jsonEncode(updatedList));
      widget.onNext();
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Form(
      key: _formKey,
      child: Skeletonizer(
        enabled: isLoading,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                padding: EdgeInsets.symmetric(vertical: screenHeight/40.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.myColorList.length,
                  itemBuilder: (context, colorIndex) {
                    var colorMap = widget.myColorList[colorIndex];
                    var colorKey = colorMap.keys.first;

                    List<Map<String, dynamic>> images = productImages[colorKey] ?? [];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customRichText(text1: "Images for color : ",
                            style1: ConstantTextStyle.storeDetailsText4,
                            text2: colorKey ??'',
                            style2: ConstantTextStyle.redeemButtonTextStyle,
                            textAlign: TextAlign.start),
                        SizedBox(height: screenHeight / 80.0),

                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Table(
                              columnWidths: {
                                0: FixedColumnWidth(screenWidth * 0.2),
                                1: FixedColumnWidth(screenWidth * 0.25),
                                2: FixedColumnWidth(screenWidth * 0.3),
                                3: FixedColumnWidth(screenWidth * 0.3),
                                4: FixedColumnWidth(screenWidth * 0.3),
                              },
                              children: [
                                // Table header row
                                TableRow(
                                  decoration:BoxDecoration(
                                    color: ConstantColor.calendarBGHeadColor,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  children:  [
                                    TableCell(child: paddingText(context: context, title:"\t\t\t\t\tS.No.",)),
                                    TableCell(child: paddingText(context: context, title:"Primary",)),
                                    TableCell(child: paddingText(context: context, title:"Choose Image",)),
                                    TableCell(child: paddingText(context: context, title:"Image Order",)),
                                    TableCell(child: paddingText(context: context, title:"Action",)),
                                  ],
                                ),
                                // Data rows

                                ...images.asMap().entries.map((entry) {
                                  int idx = entry.key;
                                  TextEditingController snoController = TextEditingController(text: images[idx]["imageOrder"].toString());
                                  return
                                    TableRow(
                                      decoration: const BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.grey)),
                                      ),
                                      children: [
                                        TableCell(
                                          child: Container(
                                            margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
                                            child: customeText(
                                              text: '\t\t\t\t\t${(idx+1).toString()} .',
                                              textAlign: TextAlign.start,
                                              style: ConstantTextStyle.topCategoryText2,
                                            ),
                                          ),
                                        ),

                                        TableCell(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: GestureDetector(
                                              onTap: () {
                                                _selectPrimaryImage(colorKey, idx);
                                              },
                                              child: Radio(
                                                activeColor: ConstantColor.primaryMainColor,
                                                value: true,
                                                groupValue: images[idx]['isPrimary'],
                                                onChanged: (value) {
                                                  _selectPrimaryImage(colorKey, idx);
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              // Conditionally show the uploaded image or the upload container
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    images[idx]["imageUrl"]["url"] = ''; // Clear the imageUrl
                                                  });
                                                },
                                                child: images[idx]["imageUrl"]["url"] != ''
                                                    ? Container(
                                                  alignment: Alignment.topLeft,
                                                  margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
                                                  child:
                                                  cachedImageWidget(
                                                    context: context,
                                                    imageFile: images[idx]["imageUrl"]["url"].toString(),
                                                    width: 80.0,
                                                    height: 80.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                                    : GestureDetector(
                                                  onTap: () {
                                                    _pickImage(colorKey, idx); // Call _pickImage with colorKey and idx
                                                  },
                                                  child:Tooltip(
                                                    message: "upload image",
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          alignment: Alignment.centerLeft,
                                                          margin: EdgeInsets.only(top: screenHeight / 80.0, bottom: screenHeight / 80.0, right: screenWidth / 20.0),
                                                          padding: const EdgeInsets.all(8.0),
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            border: Border.all(color: ConstantColor.chipCompleteStatus),
                                                            color: ConstantColor.primaryBackgroundMainColor,
                                                          ),
                                                          child: Row(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              const Icon(Icons.upload, color: ConstantColor.chipCompleteStatus),
                                                              const SizedBox(width: 8.0),
                                                              customeText(
                                                                text: 'Upload',
                                                                style: ConstantTextStyle.greenText,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        if (hasImageError)
                                                          customeText(text: 'This field is required.', style: ConstantTextStyle.locationText),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              // Cross icon to remove the image
                                              if (images[idx]["imageUrl"]["url"].isNotEmpty)
                                                Positioned(
                                                  top: screenHeight / 60.0,
                                                  right: screenWidth / 10.0,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        images[idx]["imageUrl"]["url"] = ''; // Clear the imageUrl
                                                      });
                                                    },
                                                    child: const CircleAvatar(
                                                      radius: 12.0,
                                                      backgroundColor: ConstantColor.primaryBackgroundMainColor,
                                                      child: Icon(Icons.close, color: ConstantColor.primaryMainColor),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                        // TableCell(
                                        //   child: Padding(
                                        //     padding: const EdgeInsets.all(8.0),
                                        //     child: Text(images[idx]["uuid"]),
                                        //   ),
                                        // ),
                                        TableCell(
                                          child:  GlobalTextFormField(
                                            margin: EdgeInsets.symmetric(vertical: screenHeight/80.0,horizontal: screenWidth/30.0),
                                            enabled: true,
                                            controller: snoController,
                                            keyboardType: TextInputType.number,
                                            hintText: "",
                                            labelText: "",
                                            maxLines: 1,
                                            onChanged: (newOrder) => _updateImageOrder(colorKey, idx, newOrder),
                                          ),

                                        ),

                                        TableCell(
                                          child: idx == 0
                                              ? Container(
                                              margin: const EdgeInsets.all(30.0),
                                              color: ConstantColor.loginWithOtpButtonColor,
                                              height: screenHeight/300.0)
                                              : Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: customButton(
                                                textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                                                onPressed:() => deleteImage(colorKey, idx),
                                                toolTipMessage: "delete product image",
                                                text: "Delete",
                                                backgroundColor: ConstantColor.loginWithOtpButtonColor,
                                                borderRadius: BorderRadius.circular(8.0),
                                                elevation: 0.0,
                                                minimumSize: Size(screenWidth, screenHeight/24.0)
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                }),
                              ],
                            ),
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(vertical: screenHeight/40.0),
                          alignment: Alignment.centerRight,
                          child: customButton(
                            textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                            onPressed:() {addNewImage(colorKey);
                            // print("uid-------------${uuid.v1()}");
                            },
                            toolTipMessage: "add more product image",
                            text: "Add More",
                            backgroundColor: ConstantColor.chipCompleteStatus,
                            borderRadius: BorderRadius.circular(8.0),
                            elevation: 0.0,
                            // minimumSize: Size(screenWidth/3, screenHeight/24.0)
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customButton(
                    toolTipMessage: "previous step 2.",
                    textStyleButton: ConstantTextStyle.topCategoryText4,
                    onPressed: () {
                      setState(() {
                        widget.onPreview();
                      });
                    },
                    text: 'Previous',
                    backgroundColor: ConstantColor.sellerBGColor,
                    borderRadius: BorderRadius.circular(20.0),
                    // minimumSize: Size(screenWidth/3.0, screenHeight/20.0),
                    elevation: 1.0,
                  ),
                  customButton(
                    textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                    onPressed: () async {
                      // Reset error state
                      setState(() {
                        hasImageError = false;
                      });

                      // Check each row in tableData for empty imageUrl
                      productImages.forEach((color, images) {
                        for (var image in images) {
                          if (image['imageUrl']['url'].isEmpty) {
                            hasImageError = true;
                          }
                        }
                      });
                      // If no image error found, proceed with submit logic
                      if (!hasImageError) {
                        _handleSubmit();
                      }
                    },
                    toolTipMessage: "next step 3.",
                    text: "NEXT",
                    backgroundColor: ConstantColor.primaryMainColor,
                    // minimumSize: Size(screenWidth/3.0, screenHeight/20.0),
                    borderRadius: BorderRadius.circular(20.0),
                    elevation: 1.0,
                  )
                ],
              ),


              SizedBox(height: screenHeight / 80.0),
            ],
          ),
        ),
      ),
    );
  }
}

