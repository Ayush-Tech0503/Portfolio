    import 'package:centavizers/helpers/string_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../components/back_button.dart';
import '../../cubits/static_content/static_content_cubit.dart';
import '../../cubits/static_content/static_content_state.dart';
import '../../helpers/color_helper.dart';
import '../../helpers/dimens_helper.dart';
import '../../helpers/font_helper.dart';
import '../../utils/html_converter.dart';

class AboutCentzCoins extends StatelessWidget {
  final Map args;
  const AboutCentzCoins({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
             title: Text(args['title']??"",
              style: const TextStyle(color: ColorHelper.primaryColor,
                  fontSize: FontHelper.size_22, fontWeight: FontHelper.bold)
      ),
          leading: const BackButtonWidget()
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: DimensHelper.dimens_20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            const SizedBox(height: DimensHelper.dimens_10,),

       // Text(
       //    AppString.dummyText,
       //    style: TextStyle(
       //      color: ColorHelper.greyColor,
       //      fontSize: FontHelper.size_16,
       //      fontWeight: FontHelper.regular,
       //    ),
       //  ),
            BlocBuilder<StaticContentCubit, StaticContentState>(
              builder: (context, state) {
                if (state is StaticContentLoading) {
                  return _buildShimmerPlaceholder();
                } else if (state is StaticContentLoaded) {


                  return  HtmlTextConverterWidget(htmlData: state.staticContentModel.data?.content ?? 'No content available');
                //   Text(
                  //   htmlWidget(htmlData: state.staticContentModel.data?.content ?? 'No content available'),
                  //   style: const TextStyle(
                  //     color: ColorHelper.greyColor,
                  //     fontSize: FontHelper.size_16,
                  //     fontWeight: FontHelper.regular,
                  //   ),
                  // );
                } else if (state is StaticContentError) {
                  return const Text(
                    AppString.somethingWentWrong,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: FontHelper.size_16,
                      fontWeight: FontHelper.regular,
                    ),
                  );
                } else {
                  return const Text(
                    AppString.dummyText,
                    style: TextStyle(
                      color: ColorHelper.greyColor,
                      fontSize: FontHelper.size_16,
                      fontWeight: FontHelper.regular,
                    ),
                  );
                }
              },
            ),


            const SizedBox(height: DimensHelper.dimens_30,),


          ],
        ),
      ),
    );
  }


  Widget _buildShimmerPlaceholder() {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: const Text(AppString.dummyText)
    );
  }

}
