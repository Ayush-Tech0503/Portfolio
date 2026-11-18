import 'package:centavizers/components/common_image_widget.dart';
import 'package:centavizers/helpers/color_helper.dart';
import 'package:centavizers/helpers/dimens_helper.dart';
import 'package:centavizers/helpers/font_helper.dart';
import 'package:centavizers/utils/app_images.dart';
import 'package:centavizers/utils/globle_context.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/sync_model/post_sync_data_model.dart';


class CircularProgress extends StatelessWidget {
  const CircularProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [customAssetImage(imgName:  AppImages.progressCircle,
          bgColor: Colors.transparent,
          width: context.globalSize.width/1.7,
        ),
        containWidget(),

      ],
    );
  }
}
Widget containWidget(){
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      customAssetImage(imgName:  AppImages.footIcon,
          bgColor: Colors.transparent,
          width: 4.0.h
      ),

      const  SizedBox(height: DimensHelper.dimens_26),

      customAssetImage(imgName:  AppImages.dot1,
          bgColor: Colors.transparent,
          width: 10.0.h
      ),

     const  SizedBox(height: DimensHelper.dimens_12),

      customAssetImage(imgName:  AppImages.dot2,
          bgColor: Colors.transparent,
          width: 6.0.h
      ),
      // Text("Of -,---"),
      const  SizedBox(height: DimensHelper.dimens_20),


    ],
  );
}


//-----Loaded data widget ----------



class CircularProgressLoaded extends StatelessWidget {
  final loadedData ;
  const CircularProgressLoaded({super.key, this.loadedData});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [customAssetImage(imgName:  AppImages.progressCircle,
        bgColor: Colors.transparent,
        width: context.globalSize.width/1.7,
      ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            customAssetImage(imgName:  AppImages.footIcon,
                bgColor: Colors.transparent,
                width: 4.0.h
            ),

            const  SizedBox(height: DimensHelper.dimens_26),

            // customAssetImage(imgName:  AppImages.dot1,
            //     bgColor: Colors.transparent,
            //     width: 10.0.h
            // ),



            // Text(loadedData?.numericValue.toString()??'',
            //   style: const TextStyle(color: ColorHelper.blackColor,
            //       fontSize: FontHelper.size_20,
            //       fontWeight:FontHelper.medium2),),
            //
                  Text(loadedData?.steps.toString()??'',
              style: const TextStyle(color: ColorHelper.blackColor,
                  fontSize: FontHelper.size_20,
                  fontWeight:FontHelper.medium2),),




            // const  SizedBox(height: DimensHelper.dimens_20),

            // const  SizedBox(height: DimensHelper.dimens_12),

            // customAssetImage(imgName:  AppImages.dot2,
            //     bgColor: Colors.transparent,
            //     width: 6.0.h
            // ),
            Text("Of ${loadedData?.steps??''}",
            style: const TextStyle(color: ColorHelper.greyIcon2Color,
            fontSize: FontHelper.size_16,
            fontWeight:FontHelper.medium2),),
            const  SizedBox(height: DimensHelper.dimens_20),


          ],
        ),
      ],
    );
  }
}
