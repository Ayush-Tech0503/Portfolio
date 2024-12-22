import 'package:citybazaronline_seller_app/Utils/Theme/constant_colors.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../Utils/Font Style/text_styles.dart';
import 'package:flutter/material.dart';
import '../../../../../Widget/Custome Buttons/elevetion_button_widget.dart';
import '../../../../../Widget/Html Enhance Editor/html_editor_enhancement_widget.dart';
import '../../../../../Widget/Radio Button/radio_list_tile_widget.dart';
import '../../../../../Widget/Text Form Fields/global_text_form_field.dart';
import '../../../../../Widget/custome_text_widget.dart';
import '../../../../../Widget/gender_container_widget.dart';

class MultiPageStep2ndScreen extends StatefulWidget {
  final Function onNext;
  final Function onPreview;
  // List<Map<String, dynamic>>  myColorList;
    const MultiPageStep2ndScreen({super.key, required this.onNext, required this.onPreview});

  @override
  State<MultiPageStep2ndScreen> createState() => _MultiPageStep2ndScreenState();
}

class _MultiPageStep2ndScreenState extends State<MultiPageStep2ndScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController brandNameController = TextEditingController();
  final TextEditingController warrantyController = TextEditingController();
  final TextEditingController shortDescriptionController = TextEditingController();

  HtmlEditorController fullDescriptionController = HtmlEditorController();
  HtmlEditorController otherFeatureController = HtmlEditorController();


  bool isLoading = false;
  String selectedOption = '1';


  @override
  void initState() {
    super.initState();
    // Initialize text editing controllers for TextBox fields
  }

  @override
  void dispose() {
    // Clean up text editing controllers
    productNameController.dispose();
    brandNameController.dispose();
    warrantyController.dispose();
    shortDescriptionController.dispose();
    fullDescriptionController.clear();
    fullDescriptionController.clearFocus();
    otherFeatureController.clear();
    otherFeatureController.clearFocus();
    super.dispose();
  }

  Future<void> _saveFormDataToSharedPreferences(full, other) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('productName', productNameController.text);
    prefs.setString('brandName', brandNameController.text);
    prefs.setString('status', selectedOption);
    prefs.setString('warranty', warrantyController.text);
    prefs.setString('shortDescription', shortDescriptionController.text);

    prefs.setString('fullDescription', full);
    prefs.setString('otherFeatures', other);

  }


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      String fullDes = await fullDescriptionController.getText();
      String otherFea = await otherFeatureController.getText();
      setState(() {
        _saveFormDataToSharedPreferences(fullDes, otherFea);
      });
      widget.onNext();
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Form(
      key: _formKey,
      child: Skeletonizer(
        enabled: isLoading,
        child: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight / 80.0),
              GlobalTextFormField(
                margin: EdgeInsets.only(bottom: screenHeight / 80.0),
                enabled: true,
                controller: productNameController,
                keyboardType: TextInputType.text,
                hintText: "",
                labelText: "Product Name * ",
                labelStyle: ConstantTextStyle.lableRadioText,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product name';
                  }
                  return null;
                },
                hintStyle: ConstantTextStyle.otpHintTextStyle,
                onChanged: (value) {},
              ),
              GlobalTextFormField(
                margin: EdgeInsets.only(bottom: screenHeight / 80.0),
                enabled: true,
                controller: brandNameController,
                keyboardType: TextInputType.text,
                hintText: "",
                labelText: "Brand Name * ",
                labelStyle: ConstantTextStyle.lableRadioText,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter brand name';
                  }
                  return null;
                },
                hintStyle: ConstantTextStyle.otpHintTextStyle,
                onChanged: (value) {},
              ),


              radiobuttonContainer(
                context: context,
                headText: "Status *",
                radioButtonWidget: Row(
                  children: [
                    Flexible(
                      child: customRadioButtonTitle(
                        title: customeText(
                          text: "Active",
                          style: ConstantTextStyle.passwordScreenLineTexStyle,
                        ),
                        value: "1",
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value.toString();
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: customRadioButtonTitle(
                        title: customeText(
                          text: "Deactive",
                          style: ConstantTextStyle.passwordScreenLineTexStyle,
                        ),
                        value: "0",
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              GlobalTextFormField(
                margin: EdgeInsets.symmetric(vertical: screenHeight / 80.0),
                enabled: true,
                controller: warrantyController,
                keyboardType: TextInputType.text,
                hintText: "",
                maxLines: 5,
                labelText: "Warranty ",
                labelStyle: ConstantTextStyle.lableRadioText,
                hintStyle: ConstantTextStyle.otpHintTextStyle,
                onChanged: (value) {},
              ),
              GlobalTextFormField(
                margin: EdgeInsets.only(bottom: screenHeight / 80.0),
                enabled: true,
                controller: shortDescriptionController,
                keyboardType: TextInputType.text,
                hintText: "",
                maxLines: 5,
                labelText: "Short Description * ",
                labelStyle: ConstantTextStyle.lableRadioText,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter short description.';
                  }
                  return null;
                },
                hintStyle: ConstantTextStyle.otpHintTextStyle,
                onChanged: (value) {},
              ),
              customeText(
                text: "Full Description",
                style: ConstantTextStyle.lableRadioText,
              ),
              SizedBox(height: screenHeight/80.0,),
              htmlEnhanceWidget(controller: fullDescriptionController),
              SizedBox(height: screenHeight/80.0,),
              customeText(
                text: "Other Features",
                style: ConstantTextStyle.lableRadioText,
              ),
              SizedBox(height: screenHeight/80.0,),
              htmlEnhanceWidget(controller: otherFeatureController, hintText: "Type your other features",),

              SizedBox(height: screenHeight/80.0,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customButton(
                    textStyleButton: ConstantTextStyle.topCategoryText4,
                    onPressed: () {
                      setState(() {
                        widget.onPreview();
                      });
                    },
                    toolTipMessage: "previous step 1.",
                    text: 'Previous',
                    backgroundColor: ConstantColor.sellerBGColor,
                    borderRadius: BorderRadius.circular(20.0),
                    elevation: 1.0,
                  ),
                  customButton(
                    textStyleButton: ConstantTextStyle.landingScreenAppbarText,
                    onPressed: isLoading ? null : _handleSubmit,
                    toolTipMessage: "next step 2.",
                    text: "NEXT",
                    backgroundColor: ConstantColor.primaryMainColor,
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
