import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_struture/routes/routes_name.dart';
import '../screens/bottom_bar_tabs.dart';
import '../screens/forgot_password/forgot_password.dart';
import '../screens/forgot_password/reset_password.dart';
import '../screens/forgot_password/verification_code_for_forgot_password.dart';
import '../screens/login/login_screen.dart';
import '../screens/no_route_found.dart';
import '../screens/signup/signup_screen.dart';
import '../screens/signup/verification_code.dart';
import '../screens/splash_screen.dart';

class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
    case RouteName.splash:
    return MaterialPageRoute(builder: (context) => const SplashScreen());

    // case RouteName.onBoarding:
    //   return PageTransition(type: PageTransitionType.bottomToTop, child: const OnBoardingScreen());

    case RouteName.logIn:
    return MaterialPageRoute(builder: (context) => const LoginScreen());

    case RouteName.signUp:
    return MaterialPageRoute(builder: (context) => const SignUpScreen());

    case RouteName.verificationCode:
    final args = settings.arguments as Map<String, dynamic>;
    return MaterialPageRoute(builder: (context) => VerificationCode(args: args));

    // case RouteName.favoriteCharitiesScreen:
    // return MaterialPageRoute(
    // builder: (context) => BlocProvider(
    // create: (BuildContext context) => AllCharitiesListCubit(),
    // child: const FavoriteCharitiesScreen()));

    case RouteName.forgotPassword:
    return MaterialPageRoute(builder: (context) => const ForgotPassword());

    case RouteName.verificationCodeForForgotPassword:
    final args = settings.arguments as Map<String, dynamic>;
    return MaterialPageRoute(builder: (context) => VerificationCodeForForgotPassword(args: args));

    case RouteName.resetPassword:
    final args = settings.arguments as Map<String, dynamic>;
    return MaterialPageRoute(builder: (context) => ResetPassword(args: args));




    case RouteName.bottomBarTabs:
    return MaterialPageRoute(
    builder: (context) => MultiBlocProvider(
    providers: [
    // BlocProvider(create: (BuildContext context) => CancelledOrdersCubit()),
    ],
    child: const BottomBarTabs(),
    ));



    default:
    return MaterialPageRoute(builder: (context) => const NoRouteFound());
    }
  }
}