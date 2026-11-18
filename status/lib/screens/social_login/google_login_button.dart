import 'package:centavizers/helpers/string_helper.dart';
import 'package:centavizers/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../components/app_buttons.dart';
import '../../cubits/social_sigin/social_google_sig_in_cubit.dart';
import '../../helpers/color_helper.dart';
import '../../helpers/dimens_helper.dart';
import '../../helpers/font_helper.dart';
import '../../utils/loading_indicator.dart';

class GoogleLogInButton extends StatelessWidget {
  final title;
  const GoogleLogInButton({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialGoogleSigInCubit(),
      child: BlocConsumer<SocialGoogleSigInCubit, SocialGoogleSigInState>(
        listener: (context, state)async{
          if(state is SocialGoogleSigInLoaded){
            await GoogleSignIn().signOut();
          }
        },
        builder: (context, state) {
          return ImageButton(
              onPress: (){
                context.read<SocialGoogleSigInCubit>().socialGoogleSignIn(context: context);
              },
              child:
              state is SocialGoogleSigInLoading?
            loadingButton(color: ColorHelper.primaryColor):
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(AppImages.googleIcon,height: DimensHelper.dimens_30,),
                    const SizedBox(width: DimensHelper.dimens_20),
                     Text(title ??AppString.withGoogle,
                      style:  const TextStyle(color: ColorHelper.black,
                          fontWeight: FontHelper.regular,
                          fontSize: FontHelper.size_16),),
                  ]
              )
          );
        }
      ),
    );
  }
}
