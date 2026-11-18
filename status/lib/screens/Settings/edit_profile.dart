import 'dart:io';
import 'package:centavizers/helpers/string_helper.dart';
import 'package:centavizers/utils/globle_context.dart';
import 'package:centavizers/utils/toast_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../components/app_buttons.dart';
import '../../components/back_button.dart';
import '../../components/common_image_widget.dart';
import '../../components/text_fiels.dart';
import '../../cubits/edit_user_profile/edit_user_profile_cubit.dart';
import '../../cubits/edit_user_profile/image_upload_cubit.dart';
import '../../cubits/edit_user_profile/image_upload_state.dart';
import '../../helpers/color_helper.dart';
import '../../helpers/dimens_helper.dart';
import '../../helpers/font_helper.dart';
import '../../helpers/storage_helper.dart';
import '../../utils/app_images.dart';
import '../../utils/loading_indicator.dart';
import '../auth_screen/login_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {


  // ------ update profile pic function here -------
  // bool isImageLoading = false;
  // Future<void> pickProfileImage() async {
  //   try {
  //     File? tempImage;
  //     setLoading(true);
  //     final ImagePicker picker = ImagePicker();
  //     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  //     if (image != null) {
  //       tempImage = File(image.path);
  //       tempImage = await _cropImage(imageFile: tempImage);
  //       if (tempImage != null) {
  //         profilePicture = tempImage;
  //       }
  //       // profilePicture = File(image.path);
  //       profilePicController.text = image.name;
  //       update();
  //     }
  //   } catch (e) {
  //     print("Error picking image:------ $e");
  //   } finally {
  //     setLoading(false);
  //   }
  // }
  //
  //
  // Future<File?> _cropImage({required File imageFile}) async {
  //
  //   try {
  //     final CroppedFile? croppedFile = await ImageCropper().cropImage(
  //       sourcePath: imageFile.path,
  //       aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
  //       uiSettings: [
  //         AndroidUiSettings(
  //           toolbarTitle: 'Crop Image',
  //           toolbarColor: AppColor.scaffoldColor,
  //           toolbarWidgetColor: Colors.black,
  //           initAspectRatio: CropAspectRatioPreset.square,
  //           lockAspectRatio: false,
  //         ),
  //         IOSUiSettings(
  //           title: 'Crop Image',
  //         ),
  //       ],
  //     );
  //
  //     if (croppedFile != null) {
  //       return File(croppedFile.path);
  //     }
  //   } catch (e) {
  //     debugPrint('Error cropping image: $e');
  //   }
  //   return null;
  // }
  //



  final TextEditingController fullNameController = TextEditingController(text: StorageHelper().getUserName());
  final FocusNode fullNameFocusNode = FocusNode();
  final TextEditingController emailController = TextEditingController(text: StorageHelper().getUserEmail());
  final FocusNode emailFocusNode = FocusNode();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();
  final TextEditingController phoneController = TextEditingController(text: StorageHelper().getUserMobileNumber());

  // MaskedTextController(mask: "000-000-0000");
  final FocusNode phoneFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    fullNameFocusNode.dispose();
    emailFocusNode.dispose();
    phoneFocusNode.dispose();
    // fullNameController.dispose();
    // emailController.dispose();
    // phoneController.dispose();
    // passwordController.dispose();
    super.dispose();
  }

  // final FlCountryCodePicker flCountryCodePicker = const FlCountryCodePicker();
  File? imageFileData;

  @override
  Widget build(BuildContext context) {
    fullNameFocusNode.addListener(() {
      setState(() {});
    });
    // final stringHelper = StringHelper.of(context)!;

    return Scaffold(
      appBar: AppBar(
          leading: const BackButtonWidget()

      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: DimensHelper.dimens_20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                AppString.editProfile, style: TextStyle(color: ColorHelper.primaryColor, fontSize: FontHelper.size_22, fontWeight: FontHelper.bold),),

              const SizedBox(height: DimensHelper.dimens_20,),

              BlocListener<EditProfileCubit, EditProfileState>(
                listener: (context, state) {
                  if (state is EditProfileSuccess) {
                    imageFileData = state.profilePicture;
                    // toastMessage(AppString.profileUploaded);
                  } else if (state is EditProfileError) {
                    toastMessage(state.message);
                  }
                  StorageHelper().getProfileImage().toString();
                  print("updated========>${StorageHelper().getProfileImage().toString()}");
                },
                child: Center(
                  child: CircleAvatar(
                    radius: DimensHelper.dimens_60,
                    backgroundColor: ColorHelper.primaryColor,
                    child: Stack(
                      children: [
                        Center(
                          child: CircleAvatar(
                            backgroundColor: ColorHelper.whiteColor,
                            radius: DimensHelper.dimens_55,
                            child: BlocBuilder<EditProfileCubit, EditProfileState>(
                              builder: (context, state) {
                                if (state is EditProfileLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: ColorHelper.primaryColor,
                                      strokeWidth: 2,
                                    ),
                                  );
                                }
                                else if (state is EditProfileSuccess && state.profilePicture != null) {
                                  return CircleAvatar(
                                    radius: DimensHelper.dimens_55,
                                    backgroundImage: FileImage(state.profilePicture!),
                                  );
                                }
                                else{
                                  customNetworkImage(
                                    bgColor: Colors.transparent,
                                    radius: DimensHelper.dimens_55,
                                    width:  context.globalSize.width,
                                    height:  context.globalSize.height,
                                    fit: BoxFit.fill,
                                    imgUrl: StorageHelper().getProfileImage(),
                                  );
                                }
                                return
                                  customNetworkImage(
                                    bgColor: Colors.transparent,
                                    radius: DimensHelper.dimens_55,
                                    width:  context.globalSize.width,
                                    height:  context.globalSize.height,
                                    fit: BoxFit.fill,
                                    imgUrl: StorageHelper().getProfileImage(),
                                  );
                              },
                            ),
                          ),
                        ),


                        Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () {
                              _showImagePickerDialog(context:context,
                                cameraOnTap: () => context.read<EditProfileCubit>().pickAndCropProfileImage(pickerSource:  ImageSource.camera).then((value) => Navigator.pop(context)),
                                 galleryOnTap: () => context.read<EditProfileCubit>().pickAndCropProfileImage(pickerSource:  ImageSource.gallery).then((value) => Navigator.pop(context)),
                              );
                            },
                            child: const CircleAvatar(
                              radius: 18,
                              backgroundColor: ColorHelper.primaryColor,
                              child: Icon(
                                Icons.mode_edit_outlined,
                                color: ColorHelper.secondaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),


              const SizedBox(height: DimensHelper.dimens_40,),

              CommonTextField(
                  controller: fullNameController,
                  currentFocus: fullNameFocusNode,
                  nextFocus: emailFocusNode,
                  hintText: AppString.enterName,
                  errorMessage: AppString.pleasEnterName,
                  icon: Padding(
                    padding: const EdgeInsets.all(DimensHelper.dimens_10),
                    child: Image.asset(AppImages.userIcon,
                        color: fullNameFocusNode.hasFocus
                            ? ColorHelper.primaryColor
                            : ColorHelper.greyColor,
                        width: DimensHelper.dimens_1, height: DimensHelper.dimens_1, fit: BoxFit.contain
                    ),
                  )
              ),


              phoneController.text.toString() == 'null' ?
              const SizedBox() :
              const SizedBox(height: DimensHelper.dimens_20,),

              phoneController.text.toString() == 'null' ?
                const SizedBox() :
              PhoneNumberTextField(
                  readOnly:   true,
                  controller: phoneController,
                  focusNode: phoneFocusNode),

              const SizedBox(height: DimensHelper.dimens_20,),

              EmailTextField(
                readOnly: true,
                  controller: emailController,
                currentFocus: emailFocusNode,
                nextFocus: passwordFocusNode),

              // EmailTextField(
              //     controller: emailController,
              //     currentFocus: emailFocusNode
              // ),


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
      create: (_) => EditUserProfileCubit(),
      child: BlocBuilder<EditUserProfileCubit, EditUserProfileState>(

          builder: (context, state) {
    return Padding(
      padding: const EdgeInsets.only(
          left: DimensHelper.dimens_40,
          right: DimensHelper.dimens_40,
          bottom: DimensHelper.dimens_60
      ),
      child: CommonButton(
          onPress: () {
            // if(state is UserSignupLoading){
            //
            // }else{
              if(_formKey.currentState!.validate()){
                context.read<EditUserProfileCubit>().editProfile(
                    context,
                    imageFileData,
                    fullNameController.text.toString());
              }
            // }
          },
          child:
          state is EditUserProfileLoading? loadingButton():
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



  void _showImagePickerDialog({context, cameraOnTap,galleryOnTap}) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text("Choose Profile Image",
              style: TextStyle(color: ColorHelper.blackColor,
                  fontWeight: FontHelper.medium2, fontSize: FontHelper.size_16)),
          actions: [
            CupertinoActionSheetAction(
              onPressed: cameraOnTap??(){},
              child: const Text("Camera",
                  style: TextStyle(color: ColorHelper.primaryColor,
                      fontWeight: FontHelper.medium, fontSize: FontHelper.size_14)),
            ),
            CupertinoActionSheetAction(
              onPressed: galleryOnTap ?? (){},
              child: const Text("Gallery",
                  style: TextStyle(color: ColorHelper.primaryColor,
                      fontWeight: FontHelper.medium, fontSize: FontHelper.size_14)),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            isDestructiveAction: true,
            child: const Text("Cancel",
                style: TextStyle(color: ColorHelper.redColor,
                    fontWeight: FontHelper.medium, fontSize: FontHelper.size_14)),
          ),
        );
      },
    );
  }
}
