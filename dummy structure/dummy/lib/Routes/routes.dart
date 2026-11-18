import 'package:dealshaq/components/common_webview_screen.dart';
import 'package:dealshaq/cubits/all_charities_list/all_charities_list_cubit.dart';
import 'package:dealshaq/cubits/cart_list/cart_list_cubit.dart';
import 'package:dealshaq/cubits/frequently_asked_questions/frequently_asked_questions_cubit.dart';
import 'package:dealshaq/cubits/get_all_locations/get_all_locations_cubit.dart';
import 'package:dealshaq/cubits/get_user_details/get_user_details_cubit.dart';
import 'package:dealshaq/cubits/my_orders/complete_orders/complete_orders_cubit.dart';
import 'package:dealshaq/cubits/notification/notification_cubit.dart';
import 'package:dealshaq/cubits/preferences_list/preferences_list_cubit.dart';
import 'package:dealshaq/cubits/privacy_policy/privacy_policy_cubit.dart';
import 'package:dealshaq/cubits/products_by_category/products_by_category_cubit.dart';
import 'package:dealshaq/cubits/promo_code_list/promo_code_list_cubit.dart';
import 'package:dealshaq/cubits/rating/rating_cubit.dart';
import 'package:dealshaq/cubits/related_products/related_products_cubit.dart';
import 'package:dealshaq/cubits/search/search_cubit.dart';
import 'package:dealshaq/cubits/terms_of_services/terms_of_services_cubit.dart';
import 'package:dealshaq/screens/bottom_bar_tabs.dart';
import 'package:dealshaq/screens/cart_screen/cart_screen.dart';
import 'package:dealshaq/screens/cart_screen/checkout/add_promo_code_screen.dart';
import 'package:dealshaq/screens/cart_screen/checkout/donate/charity_screen.dart';
import 'package:dealshaq/screens/cart_screen/checkout.dart';
import 'package:dealshaq/screens/cart_screen/checkout/payment/credit_card.dart';
import 'package:dealshaq/screens/cart_screen/checkout/payment/payment_failed.dart';
import 'package:dealshaq/screens/cart_screen/checkout/payment/payment_webview.dart';
import 'package:dealshaq/screens/cart_screen/checkout/place_order/place_order.dart';
import 'package:dealshaq/screens/cart_screen/checkout/place_order/view_receipt.dart';
import 'package:dealshaq/screens/manage_products/filter_products/filter_products.dart';
import 'package:dealshaq/screens/forgot_password/forgot_password.dart';
import 'package:dealshaq/screens/forgot_password/reset_password.dart';
import 'package:dealshaq/screens/forgot_password/verification_code_for_forgot_password.dart';
import 'package:dealshaq/screens/home/filter_screen.dart';
import 'package:dealshaq/screens/location/conformation_location.dart';
import 'package:dealshaq/screens/location/location_screen.dart';
import 'package:dealshaq/screens/login/login_screen.dart';
import 'package:dealshaq/screens/manage_products/category/view_all_category.dart';
import 'package:dealshaq/screens/my_order/order_detail.dart';
import 'package:dealshaq/screens/my_order/rate_your_delivery_experience.dart';
import 'package:dealshaq/screens/my_order/track_order.dart';
import 'package:dealshaq/screens/on_boarding_screen.dart';
import 'package:dealshaq/routes/routes_name.dart';
import 'package:dealshaq/screens/no_route_found.dart';
import 'package:dealshaq/screens/manage_products/product_view_widget/product_detail.dart';
import 'package:dealshaq/screens/search_screen/search_screen.dart';
import 'package:dealshaq/screens/settings/address/update_address.dart';
import 'package:dealshaq/screens/settings/address/choose_address.dart';
import 'package:dealshaq/screens/settings/language/language.dart';
import 'package:dealshaq/screens/settings/legal/about_us.dart';
import 'package:dealshaq/screens/settings/legal/frequently_asked_questions.dart';
import 'package:dealshaq/screens/settings/legal/privacy_policy.dart';
import 'package:dealshaq/screens/settings/legal/terms_of_services.dart';
import 'package:dealshaq/screens/settings/notification/notification.dart';
import 'package:dealshaq/screens/settings/past_orders/past_orders.dart';
import 'package:dealshaq/screens/settings/preferences_list/preferences_list.dart';
import 'package:dealshaq/screens/settings/support/help_support.dart';
import 'package:dealshaq/screens/settings/user_profile/change_password.dart';
import 'package:dealshaq/screens/settings/user_profile/edit_profile.dart';
import 'package:dealshaq/screens/settings/user_profile/user_profile.dart';
import 'package:dealshaq/screens/signup/favorite_charities.dart';
import 'package:dealshaq/screens/signup/signup_screen.dart';
import 'package:dealshaq/screens/signup/verification_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import '../cubits/about_us/about_us_cubit.dart';
import '../cubits/create_checkout/create_checkout_cubit.dart';
import '../cubits/my_orders/cancelled_orders/cancelled_orders_cubit.dart';
import '../cubits/order_detail/order_detail_cubit.dart';
import '../cubits/products_by_filter/products_by_filter_cubit.dart';
import '../screens/cart_screen/checkout/choose_delivery_time/deliveryTime.dart';
import '../screens/cart_screen/checkout/payment/payment_method.dart';
import '../screens/manage_products/products_by_category.dart';
import '../screens/splash_screen.dart';


class Routes {

  static Route<dynamic> onGenerateRoute (RouteSettings settings) {

    switch(settings.name){

      case RouteName.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      // case RouteName.onBoarding:
      //   return PageTransition(type: PageTransitionType.bottomToTop, child: const OnBoardingScreen());

      case RouteName.logIn:
        return PageTransition(type: PageTransitionType.rightToLeft, child: const LoginScreen());

      case RouteName.signUp:
        return PageTransition(type: PageTransitionType.bottomToTop, child: const SignUpScreen());

      case RouteName.verificationCode:
        final args = settings.arguments as Map<String, dynamic>;
        return PageTransition(type: PageTransitionType.rightToLeft, child: VerificationCode(args: args));

      case RouteName.favoriteCharitiesScreen:
        return PageTransition(type: PageTransitionType.rightToLeft,
        child: BlocProvider(
            create: (BuildContext context) => AllCharitiesListCubit(),
            child: const FavoriteCharitiesScreen()));

      case RouteName.forgotPassword:
        return PageTransition(type: PageTransitionType.rightToLeft, child: const ForgotPassword());

      case RouteName.verificationCodeForForgotPassword:
        final args = settings.arguments as Map<String, dynamic>;
        return PageTransition(type: PageTransitionType.rightToLeft, child:  VerificationCodeForForgotPassword(args: args,));

      case RouteName.resetPassword:
        final args = settings.arguments as Map<String, dynamic>;
        return PageTransition(type: PageTransitionType.rightToLeft, child: ResetPassword(args: args));

      case RouteName.conformationLocation:
        return PageTransition(type: PageTransitionType.rightToLeft, child: const ConformationLocation());

      case RouteName.locationScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return PageTransition(type: PageTransitionType.rightToLeft, child: LocationScreen(args: args,));

      case RouteName.bottomBarTabs:
        return PageTransition(type: PageTransitionType.rightToLeft, child:
            MultiBlocProvider(providers: [
              BlocProvider(create: (BuildContext context) => GetUserDetailsCubit()),
              BlocProvider(create: (BuildContext context) => CancelledOrdersCubit()),
              BlocProvider(create: (BuildContext context) => CompleteOrdersCubit()),
              BlocProvider(create: (BuildContext context) => SearchCubit()),
            ],
                child: const BottomBarTabs()));

      case RouteName.helpSupport:
        return PageTransition(type: PageTransitionType.rightToLeft, child: const HelpSupport());

      case RouteName.userProfile:
        return PageTransition(type: PageTransitionType.rightToLeft, child: const UserProfile());

      case RouteName.editProfile:
        return PageTransition(type: PageTransitionType.rightToLeft, child: const EditProfile());

      case RouteName.changePassword:
        return PageTransition(type: PageTransitionType.rightToLeft, child: const ChangePassword());

      case RouteName.chooseAddress:
        return PageTransition(type: PageTransitionType.rightToLeft, child:
        BlocProvider(
            create: (BuildContext context) => GetAllLocationsCubit(),
            child: const ChooseAddress()));

      case RouteName.addAddress:
        final args = settings.arguments as Map<String, dynamic>;
        return PageTransition(type: PageTransitionType.rightToLeft, child:  UpdateAddress(args: args,));

      case RouteName.filterScreen:
        return PageTransition(type: PageTransitionType.rightToLeft, child:  const FilterScreen());

      case RouteName.filterProductsScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return PageTransition(type: PageTransitionType.rightToLeft, child:
        BlocProvider(
                create: (BuildContext context) => ProductsByFilterCubit(),
                child: FilterProductsScreen(args: args,)));

      case RouteName.cartScreen:
        return PageTransition(type: PageTransitionType.rightToLeft, child:
        MultiBlocProvider(
              providers: [
                BlocProvider(create: (BuildContext context) => CartListCubit()),
                BlocProvider(create: (BuildContext context) => RelatedProductsCubit()),
              ],
              child: const CartScreen()),
            );

      case RouteName.orderDetailScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return PageTransition(type: PageTransitionType.rightToLeft, child:
        BlocProvider(
                create: (BuildContext context) => OrderDetailCubit(),
                child: OrderDetail(args: args,)));

      case RouteName.trackOrder:
        return PageTransition(type: PageTransitionType.rightToLeft, child:  const TrackOrder());

      case RouteName.rateYourDeliveryExperience:
        final args = settings.arguments as Map<String, dynamic>;
        return PageTransition(type: PageTransitionType.rightToLeft, child:
        BlocProvider(
                create: (BuildContext context) => RatingCubit(),
                child: RateYourDeliveryExperience(args: args,)));

      case RouteName.pastOrders:
        return PageTransition(type: PageTransitionType.rightToLeft, child:
        BlocProvider(
                create: (BuildContext context) => CompleteOrdersCubit(),
                child: const PastOrders()));

      case RouteName.preferencesList:
        return PageTransition(type: PageTransitionType.rightToLeft, child:
        BlocProvider(
            create: (BuildContext context) => PreferencesListCubit(),
            child: const PreferencesList()));

      case RouteName.notificationScreen:
        return PageTransition(type: PageTransitionType.rightToLeft, child:
        BlocProvider(
            create: (BuildContext context) => NotificationCubit(),
            child: const NotificationScreen()));

      case RouteName.productDetail:
        final args = settings.arguments as Map<String, dynamic>;
        return PageTransition(type: PageTransitionType.bottomToTop, child:
        BlocProvider(
                create: (BuildContext context) => RelatedProductsCubit(),
                child: ProductDetailScreen(args: args,)));

      case RouteName.frequentlyAskedQuestions:
        return PageTransition(type: PageTransitionType.rightToLeft, child:
        BlocProvider(
                create: (BuildContext context) => FrequentlyAskedQuestionsCubit(),
            child: const FrequentlyAskedQuestions()));

      case RouteName.aboutUs:
        return PageTransition(type: PageTransitionType.rightToLeft, child:
        BlocProvider(
                create: (BuildContext context) => AboutUsCubit(),
                child: const AboutUs()));

      case RouteName.privacyPolicy:
        return PageTransition(type: PageTransitionType.rightToLeft, child:
        BlocProvider(
                create: (BuildContext context) => PrivacyPolicyCubit(),
            child: const PrivacyPolicy()));

      case RouteName.termsOfServices:
        return PageTransition(type: PageTransitionType.rightToLeft, child:
        BlocProvider(
                create: (BuildContext context) => TermsOfServicesCubit(),
            child: const TermsOfServices()));


      case RouteName.checkoutScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return PageTransition(type: PageTransitionType.rightToLeft, child:
        MultiBlocProvider(
            providers: [
              BlocProvider(create: (BuildContext context) => GetAllLocationsCubit(),),
              BlocProvider(create: (BuildContext context) => CreateCheckoutCubit(),),
            ],
            child: CheckOutScreen(args: args)));

      case RouteName.paymentMethod:
        return PageTransition(type: PageTransitionType.rightToLeft, child: const PaymentMethod());


      case RouteName.creditCardScreen:
        return PageTransition(type: PageTransitionType.rightToLeft, child:  const AddCreditCard());

      case RouteName.deliveryTimeScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return PageTransition(type: PageTransitionType.rightToLeft, child:  DeliveryTimeScreen(args: args));


      case RouteName.placeOrderScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return PageTransition(type: PageTransitionType.rightToLeft, child:  PlaceOrder(args: args));


      case RouteName.viewReceiptScreen:
        return PageTransition(type: PageTransitionType.rightToLeft, child: const ViewReceiptScreen());


      case RouteName.searchScreen:
        return PageTransition(type: PageTransitionType.rightToLeft, child:
        MultiBlocProvider(
              providers: [
                BlocProvider(create: (BuildContext context) => ProductsByFilterCubit()),
                BlocProvider(create: (BuildContext context) => ProductsByCategoryCubit()),
              ],
              child: const SearchScreen(),
            ),
        );


      case RouteName.charityScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return PageTransition(type: PageTransitionType.rightToLeft, child:
        BlocProvider(
              //  create: (BuildContext context) => UserCharityListCubit(),
                create: (BuildContext context) => AllCharitiesListCubit(),
                child: CharityScreen(args: args,)));

      case RouteName.selectLanguage:
        return PageTransition(type: PageTransitionType.rightToLeft, child:  const SelectLanguage());


      case RouteName.productsByCategory:
        final args = settings.arguments as Map<String, dynamic>;
        return PageTransition(type: PageTransitionType.rightToLeft, child:
        BlocProvider(
                create: (BuildContext context) => ProductsByCategoryCubit(),
                child: ProductsByCategoryScreen(args: args,)));


      case RouteName.viewAllCategory:
        return PageTransition(type: PageTransitionType.rightToLeft, child:  const ViewAllCategoryScreen());


      case RouteName.paymentScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return PageTransition(type: PageTransitionType.rightToLeft, child:  PaymentWebView(args: args,));


      case RouteName.paymentFailed:
        return PageTransition(type: PageTransitionType.rightToLeft, child:  const PaymentFailedScreen());


      case RouteName.addPromoCode:
        final args = settings.arguments as Map<String, dynamic>;
        return PageTransition(type: PageTransitionType.rightToLeft, child:
        BlocProvider(
                create: (BuildContext context) => PromoCodeListCubit(),
                child: AddPromoCodeScreen(args: args,)));


      case RouteName.webViewScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return PageTransition(type: PageTransitionType.rightToLeft, child:  CommonWebViewScreen(args: args));



      default:
        return PageTransition(type: PageTransitionType.bottomToTop, child:  const NoRouteFound());
    }
  }

}
