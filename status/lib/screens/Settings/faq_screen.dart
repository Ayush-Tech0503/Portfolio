import 'package:centavizers/cubits/faqs/faq_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../components/back_button.dart';
import '../../components/faq_shimmer_loader.dart';
import '../../cubits/faqs/faq_state.dart';
import '../../helpers/color_helper.dart';
import '../../helpers/dimens_helper.dart';
import '../../helpers/font_helper.dart';
import '../../helpers/string_helper.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          leading: const BackButtonWidget()

      ),
      body:  SingleChildScrollView(
        padding:  const EdgeInsets.symmetric(horizontal: DimensHelper.dimens_20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const Text(
              AppString.faqs, style: TextStyle(color: ColorHelper.primaryColor,
                fontSize: FontHelper.size_22, fontWeight: FontHelper.bold),),

             const SizedBox(height: DimensHelper.dimens_20),

            // FAQTile(question: "data"),
            faqBuilderWidget(),

             const SizedBox(height: DimensHelper.dimens_20),


          ],
        ),
      ),
    );
  }

  faqBuilderWidget(){
    return  BlocBuilder<FAQCubit, FAQState>(
        builder: (context, state) {
          if(state is FAQLoading){
            return faqShimmerLoader();
          }
          else if (state is FAQError){
            // return  apiError();
          }else if (state is FAQLoaded){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Theme(
                  data: ThemeData(
                      dividerColor: Colors.transparent
                  ),
                  child: ListView.separated(
                      itemCount: state.faqModel.data?.length??0,
                      // itemCount: faqContent.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, i)=> const SizedBox(height: 20,),
                      itemBuilder: (context, index) {
                        var data = state.faqModel.data?[index];
                        return Column(
                          children: [
                            ExpansionTile(
                              tilePadding: EdgeInsets.zero,
                              expandedAlignment: Alignment.centerLeft,
                              backgroundColor: Colors.transparent,
                              onExpansionChanged: (bool expanded) {
                                setState(() => data?.isExpaned = expanded);
                              },
                              trailing: Icon(
                                data?.isExpaned == true  ? Icons.minimize_rounded : Icons.add,
                                color: ColorHelper.greyIcon2Color,
                              ),
                              dense: true,
                              title: Row(
                                children: [
                                  const Icon(
                                    Icons.circle,
                                    size: DimensHelper.dimens_12,
                                    color: ColorHelper.greyIcon2Color,
                                  ),
                                  const SizedBox(width: DimensHelper.dimens_6,),
                                  Text(data?.question.toString()??"",
                                    style: const TextStyle(
                                      fontSize: FontHelper.size_16,
                                      fontWeight: FontHelper.bold,
                                      color: ColorHelper.greyIcon2Color,
                                    ),
                                    // style: primaryColor26_700().copyWith(fontSize: 22).copyWith(color: black), maxLine: 10
                                  ),
                                ],
                              ),
                              children: [
                                 Text(data?.answer.toString()??"",
                                  style: const TextStyle(
                                    fontSize: FontHelper.size_14,
                                    fontWeight: FontHelper.medium,
                                    color: ColorHelper.greyIcon2Color,
                                  ),
                                  ),
                              ],
                            ),
                            const Divider()
                          ],
                        );
                      }
                  ),
                )
              ],
            );
          }
          return const SizedBox.shrink();
        }
    );
  }

}




