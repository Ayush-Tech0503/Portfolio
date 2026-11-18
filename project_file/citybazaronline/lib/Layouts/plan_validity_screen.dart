import 'package:Citybazar_app/Util/constant_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Models/Plan Validity Model/plan_validity_model.dart';
import '../Util/constaint_textstyle.dart';
import '../Util/constant_color.dart';
import '../Widgets/custome_text.dart';

class PlanValidityScreen extends StatefulWidget {
  final List<PlanValidityData>? dataList;

  const PlanValidityScreen({super.key, this.dataList});

  @override
  State<PlanValidityScreen> createState() => _PlanValidityScreenState();
}

class _PlanValidityScreenState extends State<PlanValidityScreen> {
  late String storeImage;
  late String storeName;
  late String storeAddress;
  late String storeNumber;

  @override
  void initState() {
    super.initState();
    if (widget.dataList != null && widget.dataList!.isNotEmpty) {
      storeImage = 'https://example.com/store_image.jpg'; // Use the appropriate image URL
      storeName = widget.dataList![0].storeName ?? "Store Name";
      storeAddress = widget.dataList![0].storeAddress ?? "Address Provided";
      storeNumber = widget.dataList![0].contactNo ?? "Contact Number";
    } else {
      storeImage = 'https://example.com/store_image.jpg'; // Use a default or placeholder image URL
      storeName = "Store Name";
      storeAddress = "Address Provided";
      storeNumber = "Contact Number";
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: ConstantColor.primaryBackgroundMainColor,
        ),
        backgroundColor: ConstantColor.drawerDividerColor,
        elevation: 0.0,
        centerTitle: true,
        title: customeText(
          text: storeName??"",
          style: ConstantTextStyle.topCategoryText3,
          overflow: TextOverflow.ellipsis,
        ),
        titleSpacing: 0.0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.blueGrey],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.asset( ConstantImage.noPlanAvailable??"",
                      height: 200.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        customeText(
                          text: 'The bussniss link is exparied, please contact the business directly.',
                          style: ConstantTextStyle.cardbottumText,
                          textAlign: TextAlign.center
                        ),
                        SizedBox(height: screenSize.height/80.0),

                        customeText(
                          text: storeName,
                          style: ConstantTextStyle.feedBackHeadText,
                            textAlign: TextAlign.center

                        ),
                         SizedBox(height: screenSize.height/80.0),
                        customeText(
                         text: 'Address :- $storeAddress',
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.black54,
                          ),
                            textAlign: TextAlign.center
                        ),
                        SizedBox(height: screenSize.height/80.0),
                        customeText(
                            text: 'Contact :- $storeNumber',
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.black54,
                          ),
                            textAlign: TextAlign.center
                        ),
                        SizedBox(height: screenSize.height/60.0),
                        ElevatedButton(
                          onPressed: () =>  Get.back(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ConstantColor.loginWithOtpButtonColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                          ),
                          child:  customeText(text: "Visit Us"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
