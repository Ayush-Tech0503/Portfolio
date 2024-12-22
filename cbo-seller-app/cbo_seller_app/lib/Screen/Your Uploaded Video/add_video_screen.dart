// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously



import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../Layouts/constant_screen_layout.dart';
import '../../Models/Add Video Model/reels_dropdown_model.dart';
import '../../Services/Uploaded Video Api Services/get_reels_dropdown_api_services.dart';
import '../../Services/Uploaded Video Api Services/submit_video_data.dart';
import '../../Utils/Constant Api Routs/constant_api_routs.dart';
import '../../Utils/Constant Size /constant_sizes.dart';
import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';
import '../../Widget/Custome Buttons/elevetion_button_widget.dart';
import '../../Widget/Drop Down /drop_down_widget.dart';
import '../../Widget/Scaffold Message/scaffold_message_widget.dart';
import '../../Widget/Text Form Fields/global_text_form_field.dart';
import '../../Widget/custome_text_widget.dart';
import '../../Widget/divider_widget.dart';
import '../Become A Seller/upload_document_file_screen.dart';
import '../Video Screen/video_screen.dart';


class AddVideoScreen extends StatefulWidget {

  const AddVideoScreen({super.key});

  @override
  State<AddVideoScreen> createState() => _AddVideoScreenState();
}

class _AddVideoScreenState extends State<AddVideoScreen> {
  final TextEditingController _keywordsController = TextEditingController();
  final TextEditingController _mediaTypeController = TextEditingController();
  final TextEditingController _storeDescriptionController = TextEditingController();


  final ScrollController _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();




  final List<String> _mediaTypeList = ['video', 'image'];



  String selectedPCategoryID = '';
  String? _selectedFilePath;
  String? _selectedVideoPath;
  String? selectedItem;
  String? treeName;


  int currentPage = 1;
  bool isLoading = false;
  var userId = '';

  ReelsDropdownModel? reelsDropdownModel;
  List<ChildCat> data = [];
  // List<Map<String, dynamic>> data = [];

  Future<void> fetchReelDropdownListData() async {
    try {
      setState(() {
        isLoading = true;
        data?.clear(); // Clear existing data if any
      });

      // Replace this with your actual API call
      final dropdownResponse = await fetchReelDropdownData(context: context);

      if (dropdownResponse != null && dropdownResponse.data != null) {
        final List<ChildCat> dataList = dropdownResponse.data!.childCat ?? [];

        setState(() {
          data = dataList;
          isLoading = false;
        });
      } else {
        // No more data available or error handling
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }


//-------------

  // MultipartFile? thumbnailFile;
  // MultipartFile? videoFile;


  // Future<void> handleVideoUploadDuration({
  //   required File videoFile,
  //   required Function showToaster,
  //   required Function showSizeToaster,
  //   required Function setValue,
  // }) async {
  //   // Get file size in MB
  //   double fileSizeInMB = await _getFileSizeInMB(videoFile);
  //   if (fileSizeInMB > 200) {
  //     showSizeToaster();
  //     return;
  //   }
  //
  //   // Use video_player plugin to get video duration
  //   Duration? videoDuration = await _getVideoDuration(videoFile);
  //   if (videoDuration != null && videoDuration.inSeconds > 90) {
  //     showToaster();
  //   } else {
  //     setValue();
  //   }
  // }
  //
  // // Function to get file size in MB
  // Future<double> _getFileSizeInMB(File file) async {
  //   int fileSizeInBytes = await file.length();
  //   double fileSizeInMB = fileSizeInBytes / (1024 * 1024);
  //   return fileSizeInMB;
  // }
  //
  // // Function to get video duration using video_player plugin
  // Future<Duration?> _getVideoDuration(File videoFile) async {
  //   return null; // Replace with actual implementation
  // }




  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      FormData formData = FormData();
      if (selectedPCategoryID == null || selectedPCategoryID.isEmpty) {
        LoadingScaffoldMessage.showSnackbar(
          context,
          "Category is required.",
          Colors.red,
          const Duration(seconds: 2),
        );
        return;
      }
      formData.fields.addAll([
        MapEntry("category", selectedPCategoryID),
        MapEntry("keyword", _keywordsController.text),
        MapEntry("post_type", _mediaTypeController.text),
        MapEntry("description", _storeDescriptionController.text),
      ]);


      if (_selectedVideoPath == null || _selectedVideoPath!.isEmpty) {
        LoadingScaffoldMessage.showSnackbar(
          context, "Please upload video, it is required.",
          Colors.red,
          const Duration(seconds: 2),
        );
        return;
      }


      if (_selectedFilePath == null || _selectedFilePath!.isEmpty) {
        // Add an empty file for 'thumbnail' if no file is selected
        formData.files.addAll([
          MapEntry('thumbnail', MultipartFile.fromString('', filename: '')),
          MapEntry('post', await MultipartFile.fromFile(_selectedVideoPath!,
              filename: _selectedVideoPath!.split('/').last)),
        ]);
      } else {
        // Add both 'thumbnail' and 'post' files
        formData.files.addAll([
          MapEntry('thumbnail', await MultipartFile.fromFile(_selectedFilePath!,
              filename: _selectedFilePath!.split('/').last)),
          MapEntry('post', await MultipartFile.fromFile(_selectedVideoPath!,
              filename: _selectedVideoPath!.split('/').last)),
        ]);
      }

      await fetchSubmitReelVideoData(
        context: context,
        formData: formData,
        baseUrl: "${ConstantUrls.baseUriApi}${ConstantUrls.getAddReelsApi}",
        onSuccess: () {
          Navigator.pop(context); // Go back to the previous page
          Navigator.pushReplacementNamed(context, '/uploadVideoScreen');  // Destination route

          // Navigator.pushNamedAndRemoveUntil(context, '/uploadVideoScreen', (Route<dynamic> route) => false,);
        },
      );
    }
  }

  // if (_selectedFilePath == null || _selectedFilePath!.isEmpty) {
  //   LoadingScaffoldMessage.showSnackbar(
  //     context, "Please upload thumbnail, it is required.",
  //     Colors.red,
  //     const Duration(seconds: 2),
  //   );
  //   return;
  // }

  // Future<MultipartFile> createMultipartFile(String filePath) async {
  //   File file = File(filePath);
  //   String fileName = filePath.split('/').last;
  //   return MultipartFile.fromFile(
  //     file.path,
  //     filename: fileName,
  //     // contentType: MediaType('image', 'jpeg'), // Adjust content type if needed
  //   );
  // }



  // // Validate and add thumbnail file
  // if (_selectedFilePath != null && _selectedFilePath!.isNotEmpty) {
  //   thumbnailFile = await createMultipartFile(_selectedFilePath!);
  //   formData.files.add(MapEntry('thumbnail', thumbnailFile!));
  // } else {
  //   LoadingScaffoldMessage.showSnackbar(
  //     context, "Please upload thumbnail, it is required.",
  //     Colors.red,
  //     const Duration(seconds: 2),
  //   );
  //   return;
  // }
  //
  // // Validate and add video file
  // if (_selectedVideoPath != null && _selectedVideoPath!.isNotEmpty) {
  //   videoFile = await createMultipartFile(_selectedVideoPath!);
  //   formData.files.add(MapEntry('post', videoFile!));
  // } else {
  //   LoadingScaffoldMessage.showSnackbar(
  //     context, "Please upload video, it is required.",
  //     Colors.red,
  //     const Duration(seconds: 2),
  //   );
  //   return;
  // }

  // Send formData to API





  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    fetchReelDropdownListData();
    _focusNode.addListener(() {
      setState(() {
        _focusNode.hasFocus;
      });
    });
  }


  final TextEditingController _typeAheadController = TextEditingController();


//          Navigator.pushReplacementNamed(context, '/uploadVideoScreen');  // Destination route
  @override
  Widget build(BuildContext context) {
    if (_mediaTypeController.text.isEmpty) {_mediaTypeController.text = 'video';}
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return   AppLayout(
      title: "Upload Video",
      titleStyle: ConstantTextStyle.landingScreenAppbarText,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back), color: ConstantColor.primaryBackgroundMainColor,
        onPressed: () => Navigator.pop(context),
      ),
      scaffoldColor: ConstantColor.primaryBackgroundMainColor,
      appBarColor: ConstantColor.loginWithOtpButtonColor,
      body: Form(
        key: _formKey,
        child: Skeletonizer(
          enabled: isLoading,
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: screenHeight/20.0,horizontal: screenWidth/40.0),
            controller: _scrollController,
            shrinkWrap: true,
            children: [

              Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: ConstantColor.primaryMainColor ?? ConstantColor.transparent1,
                      width: screenWidth/100,
                    ),
                  ),
                ),
                child: TypeAheadFormField<Map<String, dynamic>>(
                  textFieldConfiguration: TextFieldConfiguration(
                    focusNode: _focusNode, // Attach the FocusNode
                    controller: _typeAheadController,
                    style: ConstantTextStyle.textFormFildStyle2,
                    decoration:  InputDecoration(
                      // contentPadding: EdgeInsets.symmetric(horizontal: screenWidth/40.0),
                      filled: true,
                      fillColor: ConstantColor.primaryBackgroundMainColor,
                      suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: ConstantColor.primaryMainColor),
                      // borderRadius: BorderRadius.circular(10.0),
                      disabledBorder: const OutlineInputBorder(borderSide: BorderSide(
                        color: ConstantColor.primaryGreyColor, width: 0.5,),
                        borderRadius: BorderRadius.zero,
                      ),
                      enabledBorder:  const OutlineInputBorder(
                        borderSide: BorderSide(color: ConstantColor.primaryGreyColor, width: 0.5,),
                        borderRadius: BorderRadius.zero,
                      ),
                      focusedBorder:  const OutlineInputBorder(
                        borderSide: BorderSide(color: ConstantColor.textFieldColor),
                        borderRadius: BorderRadius.zero,
                      ),
                      // border: OutlineInputBorder(),
                      hintText: 'Select Category',
                      labelStyle: ConstantTextStyle.lableRadioText,
                      hintStyle: ConstantTextStyle.lableRadioText,
                    ),
                  ),
                    suggestionsCallback: (pattern) {
                      // Filter and convert `data` to the required type
                      Iterable<Map<String, dynamic>> result = data.where((item) {
                        // Convert `ChildCat` to `Map<String, dynamic>`
                        Map<String, dynamic> itemMap = {
                          'cat': item.cat, // Assuming 'cat' is a property in `ChildCat`
                          'pcat3': item.pcat3,
                          'pcat2': item.pcat2,
                          'pcat1': item.pcat1,
                          'category_id': item.categoryId
                        };

                        // Retrieve fields and handle null cases
                        String cat = itemMap['cat'] ?? "";
                        String pcat3 = itemMap['pcat3']?.toString() ?? "";
                        String pcat2 = itemMap['pcat2']?.toString() ?? "";
                        String pcat1 = itemMap['pcat1']?.toString() ?? "";

                        // Build the display text
                        List<String> parts = [
                          cat,
                          (pcat3.isNotEmpty) ? " ($pcat3 >> " : ' ( ',
                          (pcat2.isNotEmpty) ? "$pcat2 >> " : '',
                          (pcat1.isNotEmpty) ? "$pcat1 >> " : '',
                          cat.isNotEmpty ? "$cat) " : ' ) ',
                        ];

                        String displayText = parts.where((part) => part.isNotEmpty).join('');
                        displayText = displayText.replaceAll(RegExp(r'[\d=]'), ''); // Remove numbers and equals signs

                        // Check if the pattern is contained in the display text
                        return displayText.toLowerCase().contains(pattern.toLowerCase());
                      }).map((item) {
                        // Convert each `ChildCat` instance to a `Map<String, dynamic>`
                        return {
                          'cat': item.cat,
                          'pcat3': item.pcat3,
                          'pcat2': item.pcat2,
                          'pcat1': item.pcat1,
                          'category_id': item.categoryId
                        };
                      });

                      return result;
                    },
                  itemBuilder: (context, item) {
                    List<String> parts = [
                      item['cat'] ?? "",
                      (item['pcat3'] != null && item['pcat3'].toString().isNotEmpty) ? " ( ${item['pcat3']}  >> " : ' ( ',
                      (item['pcat2'] != null && item['pcat2'].toString().isNotEmpty) ? "${item['pcat2']} >> " : '',
                      (item['pcat1'] != null && item['pcat1'].toString().isNotEmpty) ? "${item['pcat1']} >> " : '',
                      (item['cat'] != null && item['cat'].toString().isNotEmpty) ? "${item['cat']} ) " : ' ) ',
                    ];

                    String displayText = parts.where((part) => part.isNotEmpty).join('');
                    displayText = displayText.replaceAll(RegExp(r'[\d=]'), '');
                    String categoryId = item['category_id'].toString() ?? '';

                    return ListTile(
                      dense: true,
                      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                      contentPadding: EdgeInsets.symmetric(horizontal: screenWidth / 40.0),
                      onTap: () async {
                        setState(() {
                          treeName = parts.where((part) => part.isNotEmpty).join('');
                          treeName = treeName.toString().replaceAll(RegExp(r'[\d=]'), '');
                          _typeAheadController.text = treeName.toString().replaceAll(RegExp(r'[\d=]'), '');
                          selectedPCategoryID = categoryId; // Ensure categoryId is assigned
                          selectedItem = categoryId; // Ensure selectedItem is assigned
                        });
                        _focusNode.unfocus();
                      },
                      title: customeText(text: displayText, style: ConstantTextStyle.dropDownPrimeText),
                      subtitle: dividerWidget(),
                    );
                  },


                  onSuggestionSelected: (item) {
                    setState(() {
                      _focusNode.unfocus(); // Close the suggestion list by unfocusing
                      selectedItem = item['category_id'];
                    });
                    _typeAheadController.text = item['cat'];
                  },
                ),
              ),


              // dropDownForm(
              //   context: context,
              //   colorBorder: ConstantColor.primaryMainColor,
              //   headText: 'Select Category',
              //   value: selectedItem,
              //   items: data.map((ChildCat item) {
              //     List<String> parts = [
              //       item.cat ?? '',
              //       item.pcat1 ?? '',
              //       item.pcat2 ?? '',
              //       item.pcat3 ?? '',
              //     ];
              //
              //     String displayText =
              //     parts.where((part) => part.isNotEmpty).join(' >> ');
              //     displayText = displayText.replaceAll(RegExp(r'[\d=]'), '');
              //
              //     return DropdownMenuItem<String>(
              //       value: item.categoryId ?? '',
              //       child: Text(
              //         displayText,
              //         style: ConstantTextStyle.dropDownPrimeText,
              //       ),
              //     );
              //   }).toList(),
              //   onChanged: (newValue) async {
              //     setState(() {
              //       selectedItem = newValue;
              //       for (ChildCat item in data) {
              //         if (item.categoryId == selectedItem) {
              //           // Extract parts
              //           String cat = item.cat ?? '';
              //           String pcat1 = item.pcat1 ?? '';
              //           String pcat2 = item.pcat2 ?? '';
              //           String pcat3 = item.pcat3 ?? '';
              //           // Check conditions to determine selectedPCategoryID
              //           if (pcat3 != null && pcat3.isNotEmpty) {
              //             selectedPCategoryID = pcat3;
              //           }
              //           else if (pcat2 != null && pcat2.isNotEmpty) {
              //             selectedPCategoryID = pcat2;
              //           }
              //           else if (pcat1 != null && pcat1.isNotEmpty) {
              //             selectedPCategoryID = pcat1;
              //           }
              //           else {selectedPCategoryID = cat;}
              //           // Remove everything after the first '=' character
              //           if (selectedPCategoryID.contains('=')) {
              //             selectedPCategoryID = selectedPCategoryID.split('=')[0];
              //           }
              //           break; // Exit loop once found
              //         }
              //       }
              //     });
              //   },
              // ),


              constantHeight(context, 30.0),
              GlobalTextFormField(
                // margin: EdgeInsets.symmetric(vertical: screenHeight / 30.0),
                enabled: true,
                controller: _keywordsController,
                keyboardType: TextInputType.text,
                hintText: "",
                labelText: "Keyword",
                hintStyle: ConstantTextStyle.otpHintTextStyle,
                labelStyle: ConstantTextStyle.otpHintTextStyle,
                onChanged: (value) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter keyword';}
                  return null;
                },
              ),

              constantHeight(context, 30.0),
              AppDropdownInput(
                hintText: "Select Media Type",
                options: _mediaTypeList,
                value: _mediaTypeController.text.isEmpty ? 'video' : _mediaTypeController.text,
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      _mediaTypeController.text = value;
                    });
                  }
                },
                getLabel: (String value) => value,
              ),


              constantHeight(context, 30.0),
              GlobalTextFormField(
                // margin: EdgeInsets.symmetric(vertical: screenHeight / 60.0),
                enabled: true,
                controller: _storeDescriptionController,
                keyboardType: TextInputType.text,
                hintText: "",
                maxLines: 5,
                labelText: "Description",
                hintStyle: ConstantTextStyle.otpHintTextStyle,
                labelStyle: ConstantTextStyle.otpHintTextStyle,
                onChanged: (value) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';}
                  return null;
                },
              ),

              constantHeight(context, 30.0),

              UploadRegistrationDocumentsScreen(
                  buttonTitle: 'Upload Thumbnail',
                  allowedExtensions: const  ["jpg", "jpeg", "bmp", "png"],
                  filePath: _selectedFilePath??"",
                  onFileSelected: (filePath) {
                    setState(() {_selectedFilePath = filePath;});}),

              constantHeight(context, 30.0),

              UploadRegistrationDocumentsScreen(
                  buttonTitle: 'Upload Video',
                  allowedExtensions: const['gif', 'avi', 'flv', 'mkv', 'mov', 'mp4', 'mpeg', 'webm', 'wmv'],
                  filePath: _selectedVideoPath??"",
                  onFileSelected: (filePath) {
                    setState(() {_selectedVideoPath = filePath;});}),


              constantHeight(context, 30.0),

              customButton(
                textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                onPressed: isLoading ? null : _handleSubmit,
                text: "Upload",
                backgroundColor: ConstantColor.primaryMainColor,
                borderRadius: BorderRadius.circular(20.0),
                minimumSize: Size(screenWidth, screenHeight/22.0),
                elevation: 1.0,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
