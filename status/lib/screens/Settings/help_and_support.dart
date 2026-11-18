import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/app_buttons.dart';
import '../../components/back_button.dart';
import '../../components/text_fiels.dart';
import '../../cubits/hele_support/submit_help_support_cubit.dart';
import '../../cubits/hele_support/support_img_cubit.dart';
import '../../cubits/hele_support/support_img_state.dart';
import '../../helpers/color_helper.dart';
import '../../helpers/dimens_helper.dart';
import '../../helpers/font_helper.dart';
import '../../helpers/string_helper.dart';
import '../../utils/loading_indicator.dart';
import '../auth_screen/login_screen.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  _HelpSupportScreenState createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  String? selectedIssue;

  final List<String> issues = ["App Crash", "Login Issue", "App Bug", "Other"];


  // List<File> selectedImages = [];
  File? imageFileData;

  final TextEditingController descriptionController = TextEditingController();
  final FocusNode descriptionFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonWidget(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: DimensHelper.dimens_20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              const Text(
                AppString.helpAndSupport, style: TextStyle(color: ColorHelper.primaryColor, fontSize: FontHelper.size_22, fontWeight: FontHelper.bold),),

              const SizedBox(height: DimensHelper.dimens_20,),

          Container(
            decoration: BoxDecoration(
              border: Border.all(color: ColorHelper.grey300),
              borderRadius: BorderRadius.circular(DimensHelper.dimens_10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(

                value: selectedIssue,

                isExpanded: true,
                hint: const Text(
                  AppString.chooseAnIssue,
                  style: TextStyle(
                    color: ColorHelper.greyIcon2Color,
                    fontWeight: FontHelper.medium,
                    fontSize: FontHelper.size_16,
                  ),
                ),
                items: issues.map((String issue) {
                  return DropdownMenuItem<String>(
                    value: issue,
                    child: Text(
                      issue,
                      style: const TextStyle(
                        color: ColorHelper.greyIcon2Color,
                        fontWeight: FontHelper.medium,
                        fontSize: FontHelper.size_16,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedIssue = newValue;
                  });
                },

                dropdownStyleData: DropdownStyleData(
                  elevation: 0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
                    border: Border.all(color: ColorHelper.grey400),
                    color: ColorHelper.whiteColor,
                  ),
                  offset: const Offset(0, -DimensHelper.dimens_10),
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(Icons.keyboard_arrow_down_rounded),
                  iconEnabledColor: ColorHelper.greyIcon2Color,
                ),
              ),
            ),
          ),

              const SizedBox(height: DimensHelper.dimens_20),

              // Description Input

              CommonTextField(
                  controller: descriptionController,
                  currentFocus: descriptionFocusNode,
                  hintText: AppString.description,
                  errorMessage: AppString.pleasEnterDescription,
                commanStyle: const TextStyle(
                    color: ColorHelper.greyIcon2Color,
                    fontWeight: FontHelper.medium,
                    fontSize: FontHelper.size_16
                ),
                maxLine: 4,
              ),


              const SizedBox(height: DimensHelper.dimens_20),

              // Optional Label
              const Text("Optional", style: TextStyle(
                  color: ColorHelper.greyIcon2Color,
                  fontWeight: FontHelper.medium,
                  fontSize: FontHelper.size_14
              )),
              const SizedBox(height: DimensHelper.dimens_20),

          BlocBuilder<SupportImageCubit, SupportImageState>(
            builder: (context, state) {
              final cubit = context.read<SupportImageCubit>();
               imageFileData = cubit.selectedImage;

              return GestureDetector(
                onTap: () => cubit.pickAndCropSupportImage(),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height /6,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: state is SupportImageSuccess && cubit.selectedImage != null
                      ? Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          cubit.selectedImage!,
                          fit: BoxFit.contain,
                          width: double.maxFinite,
                          height: double.maxFinite,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () => cubit.removeImage(),
                          child: const CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 14,
                            child: Icon(Icons.close, size: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                      : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.cloud_upload,
                          size: 80, color: Colors.grey),
                      SizedBox(height: 8),
                      Text("Tap to upload an image",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 14)),
                    ],
                  ),
                ),
              );
            },
          ),
          // BlocBuilder<SupportImageCubit, SupportImageState>(
          //       builder: (context, state) {
          //         if (state is SupportImageSuccess) {
          //           selectedImages = state.supportImages;
          //         }
          //         return Column(
          //           children: [
          //             GestureDetector(
          //               onTap: () {
          //                 context.read<SupportImageCubit>().pickAndCropSupportImages();
          //               },
          //               child: Container(
          //                 width: double.maxFinite,
          //                 height: context.globalSize.height/3.4,
          //                 decoration: BoxDecoration(
          //                   border: Border.all(color: Colors.grey.shade300),
          //                   borderRadius: BorderRadius.circular(8),
          //                 ),
          //                 child: state is SupportImageSuccess && state.supportImages.isNotEmpty
          //                     ? Column(
          //                   children: [
          //                     Expanded(
          //                       child: GridView.builder(
          //                         padding: const EdgeInsets.all(8),
          //                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //                           crossAxisCount: 3,
          //                           crossAxisSpacing: 8,
          //                           mainAxisSpacing: 8,
          //                         ),
          //                         itemCount: state.supportImages.length,
          //                         itemBuilder: (context, index) {
          //                           return Stack(
          //                             children: [
          //                               ClipRRect(
          //                                 borderRadius: BorderRadius.circular(8),
          //                                 child: Image.file(
          //                                   File(state.supportImages[index].path),
          //                                   fit: BoxFit.cover,
          //                                   width: double.infinity,
          //                                 ),
          //                               ),
          //                               Positioned(
          //                                 top: 4,
          //                                 right: 4,
          //                                 child: GestureDetector(
          //                                   onTap: () {
          //                                     context.read<SupportImageCubit>().removeImage(index);
          //                                   },
          //                                   child: const CircleAvatar(
          //                                     backgroundColor: Colors.red,
          //                                     radius: 12,
          //                                     child: Icon(Icons.close, size: 16, color: Colors.white),
          //                                   ),
          //                                 ),
          //                               ),
          //                             ],
          //                           );
          //                         },
          //                       ),
          //                     ),
          //
          //                     // "Add More Images" Button
          //                     TextButton.icon(
          //                       onPressed: () => context.read<SupportImageCubit>().pickAndCropSupportImages(isAddingMore: true),
          //                       icon: const Icon(Icons.add_photo_alternate, color: ColorHelper.primaryColor),
          //                       label: const Text(AppString.addMore,
          //                           style: TextStyle(color: ColorHelper.primaryColor)),
          //                     ),
          //                   ],
          //                 )
          //                     : const Column(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: [
          //                     Icon(CupertinoIcons.cloud_upload,
          //                         size: DimensHelper.dimens_80,
          //                         color: ColorHelper.greyIcon2Color),
          //                     SizedBox(height: 8),
          //                     Text("Upload a screenshot",
          //                         style: TextStyle(
          //                             color: ColorHelper.greyIcon2Color,
          //                             fontWeight: FontHelper.medium,
          //                             fontSize: FontHelper.size_14)),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ],
          //         );
          //       },
          //     ),


            ],
          ),
        ),
      ),
      bottomNavigationBar: updateButton(),
    );
  }



  Widget updateButton() {
    // final stringHelper = StringHelper.of(context)!;

    return BlocProvider(
      create: (_) => SubmitHelpSupportCubit(),
      child: BlocBuilder<SubmitHelpSupportCubit, SubmitHelpSupportState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: DimensHelper.dimens_40,
                  right: DimensHelper.dimens_40,
                  bottom: DimensHelper.dimens_60
              ),
              child: CommonButton(
                  onPress: () {
                    if(state is SubmitHelpSupportLoading){

                    }else{
                    if(_formKey.currentState!.validate()){
                      context.read<SubmitHelpSupportCubit>().createSupport(
                          context: context,
                          imageFile: imageFileData,
                          type: selectedIssue,
                          title: "",
                          description: descriptionController.text.toString()
                      );
                    }
                    }
                  },
                  child:
                  state is SubmitHelpSupportLoading? loadingButton():
                  arrowButtonRow(
                      title: AppString.update,
                      leftIconColor: Colors.transparent,
                      rightIconColor: ColorHelper.secondaryColor
                  )),
            );

          }
      ),
    );
  }

}
