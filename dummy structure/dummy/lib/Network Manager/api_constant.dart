import 'package:dealshaq/flavor_config/flavor_config.dart';
import 'package:dealshaq/helpers/env_helper.dart';

class ApiConstant {
  ApiConstant._();
  static final ApiConstant apiConstant = ApiConstant._();

  factory ApiConstant (){
    return apiConstant;
  }


  static String apiBaseUrl = '${EnvHelper.baseUrl}/api';
  static  String imageUrlBaseUrl = '${AppEnvironment.baseUrl}/files/';

  /// API Urls
  static String signUp = '$apiBaseUrl/users/signup';
  static String logIn = '$apiBaseUrl/users/login';
  static String verifyOTP = '$apiBaseUrl/verification/verify-otp';
  static String resendOTP = '$apiBaseUrl/verification/resend-otp';
  static String forgotPassword = '$apiBaseUrl/users/forget-password';
  static String verifyForgotPassword = '$apiBaseUrl/users/verify-forget-pass';
  static String resendForgotPasswordOTP = '$apiBaseUrl/users/forgot-resend-otp';
  static String socialLogIn = '$apiBaseUrl/users/social-login';

  static String changePassword = '$apiBaseUrl/users/change-password';
  static String deleteAccount = '$apiBaseUrl/users/user-account-delete';
  static String editProfile = '$apiBaseUrl/users/edit-user-profile';
  static String userDetails = '$apiBaseUrl/users/view-user-profile';
  static String helpAndSupport = '$apiBaseUrl/users/help-and-support';
  static String frequentlyAskedQuestions = '$apiBaseUrl/users/get-faqs';
  static String aboutUs = '$apiBaseUrl/users/get-about-us';
  static String privacyPolicy = '$apiBaseUrl/users/get-privacyPolicy';
  static String termsAndConditions = '$apiBaseUrl/users/get-terms-conditions';

  static String addLocation = '$apiBaseUrl/users/location';
  static String updateLocation = '$apiBaseUrl/users/edit-location';
  static String getAllLocation = '$apiBaseUrl/users/all-location';
  static String setDefaultLocation = '$apiBaseUrl/users/default-location';
  static String deleteAddress = '$apiBaseUrl/users/delete-location';

  static String addPreference = '$apiBaseUrl/users/add-preference';
  static String getPreference = '$apiBaseUrl/users/get-preference-list';
  static String getAllCharityList = '$apiBaseUrl/users/get-charity-list';
  static String addCharity = '$apiBaseUrl/users/add-multi-charity';
  static String getUserCharity = '$apiBaseUrl/users/get-multi-charity';

  static String getCategory = '$apiBaseUrl/users/get-category';
  static String productsByCategory = '$apiBaseUrl/users/get-single-category/';
  static String updateProductCount = '$apiBaseUrl/users/update-single-product';

  static String productsByFilter = '$apiBaseUrl/users/get-all-product?';
  static String relatedProducts = '$apiBaseUrl/users/get-related-item-product/';
  static String categoryListWithProducts = '$apiBaseUrl/users/category-list-with-product';
  static String totalCartItem = '$apiBaseUrl/users/cart-total-count';
  static String cartList = '$apiBaseUrl/users/get-cart-list';
  static String deleteProductFromCart = '$apiBaseUrl/users/remove-cart/';
  static String promoCodeList = '$apiBaseUrl/users/get-promo-code-list';
  static String createCheckOut = '$apiBaseUrl/users/create-checkout';
  static String applyPromoCode = '$apiBaseUrl/users/apply-promo-code';
  static String applyCharity = '$apiBaseUrl/users/apply-charity';
  static String removeCharityFromCheckout = '$apiBaseUrl/users/remove-charity-from-checkout';
  static String removePromoCodeFromCheckout = '$apiBaseUrl/users/remove-promo-code-from-checkout';
  static String getNotifications = '$apiBaseUrl/users//get-notifications';
  static String appBanners = '$apiBaseUrl/users/get-banner-list';

  static String createOrderPlace = '$apiBaseUrl/users/create-order-place';
  static String myOrders = '$apiBaseUrl/users/get-myOrder?';
  static String cancelOrder = '$apiBaseUrl/users/cancelled-my-order/';
  static String orderDetail = '$apiBaseUrl/users/get-Order-detail/';
  static String reOrder = '$apiBaseUrl/users/create-re-order';
  static String orderRating = '$apiBaseUrl/users/add-rating';

  // static const String notifications = '$baseUrl/users/notifications';
  // static const String notifications = '$baseUrl/users/notifications';
  // static const String notifications = '$baseUrl/users/notifications';
  // static const String notifications = '$baseUrl/users/notifications';
  // static const String addPreference = '$baseUrl/users/add-preference';



}