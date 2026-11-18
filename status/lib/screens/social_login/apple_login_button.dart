import 'dart:io';

import 'package:centavizers/components/app_buttons.dart';
import 'package:centavizers/helpers/string_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/social_sigin/social_apple_sign_in_cubit.dart';
import '../../helpers/color_helper.dart';
import '../../helpers/dimens_helper.dart';
import '../../helpers/font_helper.dart';
import '../../utils/app_images.dart';
import '../../utils/loading_indicator.dart';

class AppleLogInButton extends StatelessWidget {
  final title;
  const AppleLogInButton({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    if(Platform.isIOS){
      // final stringHelper = StringHelper.of(context)!;
      return BlocProvider(
        create: (BuildContext context) => SocialAppleSignInCubit(),
        child: BlocConsumer<SocialAppleSignInCubit, SocialAppleSignInState>(
            listener: (context, state)async{
              // if(state is SocialGoogleSigInLoaded){
              //   await GoogleSignIn().signOut();
              // }
            },
            builder: (context, state) {
              return ImageButton(
                  onPress: (){
                    context.read<SocialAppleSignInCubit>().socialAppleSignIn(context: context);
                  },
                  child:
                  state is SocialAppleSignInLoading?
                  loadingButton(color: ColorHelper.primaryColor):
                   Row(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       Image.asset(AppImages.appleIcon,height: DimensHelper.dimens_30,),
                       const SizedBox(width: DimensHelper.dimens_20),
                        Text(title ?? AppString.withApple,
                         style:  const TextStyle(color: ColorHelper.black,
                             fontWeight: FontHelper.regular,
                             fontSize: FontHelper.size_16),),
                     ]
                   )
              );
            }
        ),
      );
    }else{
      return const SizedBox();
    }

  }
}
