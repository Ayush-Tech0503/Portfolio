import 'dart:convert';
import 'package:dealshaq/models/about_us.dart';
import 'package:dealshaq/models/add_charity.dart';
import 'package:dealshaq/models/address_from_place_id_model.dart';
import 'package:dealshaq/models/auto_complete_places_model.dart';
import 'package:dealshaq/models/forgotpassword_resend_otp_model.dart';
import 'package:dealshaq/models/fotgot_password_model.dart';
import 'package:dealshaq/models/get_all_charity.dart';
import 'package:dealshaq/models/get_category.dart';
import 'package:dealshaq/models/get_user_charity_list.dart';
import 'package:dealshaq/models/get_user_details.dart';
import 'package:dealshaq/models/help_and_support.dart';
import 'package:dealshaq/models/notification.dart';
import 'package:dealshaq/models/order_detail.dart';
import 'package:dealshaq/models/order_rating.dart';
import 'package:dealshaq/models/products_by_category.dart';
import 'package:dealshaq/models/re_order.dart';
import 'package:dealshaq/models/related_products.dart';
import 'package:dealshaq/models/request_models/create_checkout.dart';
import 'package:dealshaq/models/resend_otp_model.dart';
import 'package:dealshaq/models/reset_password_model.dart';
import 'package:dealshaq/models/user_delete_account.dart';
import 'package:dealshaq/models/user_login_model.dart';
import 'package:dealshaq/models/user_signup_model.dart';
import 'package:dealshaq/models/verify_forgot_password_otp_model.dart';
import 'package:dealshaq/models/verify_otp_model.dart';
import 'package:dealshaq/network_manager/api_constant.dart';
import '../helpers/constant_helper.dart';
import '../models/add_location.dart';
import '../models/add_prefrences.dart';
import '../models/app_banners.dart';
import '../models/apply_charity.dart';
import '../models/apply_promo_code.dart';
import '../models/cancel_order.dart';
import '../models/cart_list.dart';
import '../models/category_list_with_products.dart';
import '../models/change_password_model.dart';
import '../models/create_checkout.dart';
import '../models/create_place_order.dart';
import '../models/delete_address.dart';
import '../models/delete_product_from_cart.dart';
import '../models/edit_user_profile.dart';
import '../models/frequently_asked_questions.dart';
import '../models/get_all_location.dart';
import '../models/get_preferences_list.dart';
import '../models/my_orders.dart';
import '../models/privacy_policy.dart';
import '../models/products_by_filter.dart';
import '../models/promo_code_list.dart';
import '../models/remove_charity_from_checkout.dart';
import '../models/remove_promocode_from_checkout.dart';
import '../models/set_default_address.dart';
import '../models/social_login.dart';
import '../models/terms_and_conditions.dart';
import '../models/total_cart_item.dart';
import '../models/update_location.dart';
import '../models/update_product_count.dart';
import 'http_helper.dart';

class RestClient {
  static final RestClient getInstance = RestClient._internal();
  RestClient._internal();

  factory RestClient() {
    return getInstance;
  }

  static final HttpHelper _httpHelper = HttpHelper();



  static Future<UserSignUpModel> userSignUp(String reqBody) async {
    var result = await _httpHelper.post(url: ApiConstant.signUp, body: reqBody);
    return UserSignUpModel.fromJson(result);
  }

  static Future<VerifyOTPModelModel> verifyOtp(String reqBody) async {
    var result = await _httpHelper.post(url: ApiConstant.verifyOTP, body: reqBody);
    return VerifyOTPModelModel.fromJson(result);
  }

  static Future<ResendOtpModel> resendOtp(String reqBody) async {
    var result = await _httpHelper.post(url: ApiConstant.resendOTP, body: reqBody);
    return ResendOtpModel.fromJson(result);
  }

  static Future<UserLogInModel> userLogIn(String reqBody) async {
    var result =await _httpHelper.post(url: ApiConstant.logIn, body: reqBody);
    return UserLogInModel.fromJson(result);
  }

  static Future<ForgotPasswordModel> forgotPassword(String reqBody) async {
    var result = await _httpHelper.post(url: ApiConstant.forgotPassword, body: reqBody);
    return ForgotPasswordModel.fromJson(result);
  }

  static Future<ForgotPasswordResendOTPModel> forgotPasswordResendOTP(String reqBody) async {
    var result = await _httpHelper.post(url: ApiConstant.resendForgotPasswordOTP, body: reqBody);
    return ForgotPasswordResendOTPModel.fromJson(result);
  }

  static Future<VerifyForgotPasswordOTPModel> verifyForgotPasswordOTP(String reqBody) async {
    var result = await _httpHelper.post(url: ApiConstant.verifyForgotPassword, body: reqBody);
    return VerifyForgotPasswordOTPModel.fromJson(result);
  }

  static Future<ResetPasswordModel> resetPassword(String reqBody) async {
    var result = await _httpHelper.put(url: ApiConstant.changePassword, body: reqBody);
    return ResetPasswordModel.fromJson(result);
  }

  static Future<AutoCompletePlacesModel> autoCompletePlaces(String placeName) async {
    var result = await _httpHelper.get(url: 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&components=country:us&key=${ConstantHelper.gcpKey}');
    return AutoCompletePlacesModel.fromJson(result);
  }

  static Future<AddressFromPlaceIdModel> addressFromPlaceId(String placeId) async {
    var result = await _httpHelper.get(url: 'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=${ConstantHelper.gcpKey}');
    return AddressFromPlaceIdModel.fromJson(result);
  }


  static Future<UserDeleteAccountModel> deleteAccount() async {
    var result = await _httpHelper.delete(url: ApiConstant.deleteAccount, isRequireAuthorization: true);
    return UserDeleteAccountModel.fromJson(result);
  }


  static Future<ChangePasswordModel> changePassword(String body) async {
    var result = await _httpHelper.put(url: ApiConstant.changePassword, body: body);
    return ChangePasswordModel.fromJson(result);
  }


  static Future<EditUserProfileModel> editUserProfile(String body) async {
    var result = await _httpHelper.put(url: ApiConstant.editProfile, body: body, isRequireAuthorization: true);
    return EditUserProfileModel.fromJson(result);
  }


  static Future<GetUserDetailsModel> getUserDetails() async {
    var result = await _httpHelper.get(url: ApiConstant.userDetails, isRequireAuthorization: true);
    return GetUserDetailsModel.fromJson(result);
  }


  static Future<HelpAndSupportModel> helpAndSupport(String body) async {
    var result = await _httpHelper.post(url: ApiConstant.helpAndSupport, isRequireAuthorization: true,body: body);
    return HelpAndSupportModel.fromJson(result);
  }

  static Future<FrequentlyAskedQuestionsModel> frequentlyAskedQuestion() async {
    var result = await _httpHelper.get(url: ApiConstant.frequentlyAskedQuestions, isRequireAuthorization: true,);
    return FrequentlyAskedQuestionsModel.fromJson(result);
  }

  static Future<AboutUsModel> aboutUs() async {
    var result = await _httpHelper.get(url: ApiConstant.aboutUs, isRequireAuthorization: true,);
    return AboutUsModel.fromJson(result);
  }

  static Future<PrivacyPolicyModel> privacyPolicy() async {
    var result = await _httpHelper.get(url: ApiConstant.privacyPolicy, isRequireAuthorization: true,);
    return PrivacyPolicyModel.fromJson(result);
  }

  static Future<TermsAndConditionModel> termsAndConditions() async {
    var result = await _httpHelper.get(url: ApiConstant.termsAndConditions, isRequireAuthorization: true,);
    return TermsAndConditionModel.fromJson(result);
  }

  static Future<AddLocationModel> addLocation(String body) async {
    var result = await _httpHelper.post(url: ApiConstant.addLocation, body: body, isRequireAuthorization: true);
    return AddLocationModel.fromJson(result);
  }

  static Future<GetAllLocationModel> getAllLocations() async {
    var result = await _httpHelper.get(url: ApiConstant.getAllLocation, isRequireAuthorization: true);
    return GetAllLocationModel.fromJson(result);
  }

  static Future<UpdateLocationModel> updateLocation(String locationId, String body) async {
    var result = await _httpHelper.put(url: "${ApiConstant.updateLocation}/$locationId", isRequireAuthorization: true,body: body);
    return UpdateLocationModel.fromJson(result);
  }

  static Future<SetDefaultAddressModel> setDefaultAddress(String body) async {
    var result = await _httpHelper.post(url: ApiConstant.setDefaultLocation, isRequireAuthorization: true,body: body);
    return SetDefaultAddressModel.fromJson(result);
  }

  static Future<DeleteAddressModel> deleteAddress(String addressId) async {
    var result = await _httpHelper.delete(url: "${ApiConstant.deleteAddress}/$addressId", isRequireAuthorization: true);
    return DeleteAddressModel.fromJson(result);
  }


  static Future<GetCategoryModel> getCategory() async {
    var result = await _httpHelper.get(url: ApiConstant.getCategory, isRequireAuthorization: true);
    return GetCategoryModel.fromJson(result);
  }


  static Future<AddPreferencesModel> addPreferences(String body) async {
    var result = await _httpHelper.post(url: ApiConstant.addPreference, isRequireAuthorization: true, body: body);
    return AddPreferencesModel.fromJson(result);
  }


  static Future<GetPreferencesListModel> getPreferenceList() async {
    var result = await _httpHelper.get(url: ApiConstant.getPreference, isRequireAuthorization: true);
    return GetPreferencesListModel.fromJson(result);
  }

  static Future<GetAllCharityListModel> getAllCharityList() async {
    var result = await _httpHelper.get(url: ApiConstant.getAllCharityList, isRequireAuthorization: true);
    return GetAllCharityListModel.fromJson(result);
  }


  static Future<AddCharityModel> addCharity(String body) async {
    var result = await _httpHelper.post(url: ApiConstant.addCharity, isRequireAuthorization: true, body: body);
    return AddCharityModel.fromJson(result);
  }


  static Future<GetUserCharityListModel> getUserCharityList() async {
    var result = await _httpHelper.get(url: ApiConstant.getUserCharity, isRequireAuthorization: true);
    return GetUserCharityListModel.fromJson(result);
  }


  static Future<ProductsByCategoryModel> productsByCategory(String categoryId, int page) async {
    var result = await _httpHelper.get(url: "${ApiConstant.productsByCategory}$categoryId?&page=$page&limit=8", isRequireAuthorization: true);
    return ProductsByCategoryModel.fromJson(result);
  }

  static Future<UpdateProductCountModel> updateProductCount(String body) async {
    var result = await _httpHelper.post(url: ApiConstant.updateProductCount, isRequireAuthorization: true, body: body);
    return UpdateProductCountModel.fromJson(result);
  }

  static Future<ProductsByFilterModel> productsByFilter({required String productName, required String productType, required  String sortBy, required int page}) async {
    var result = await _httpHelper.get(url:"${ApiConstant.productsByFilter}page=$page&limit=10&productName=$productName&productType=$productType&sortBy=$sortBy", isRequireAuthorization: true);
    return ProductsByFilterModel.fromJson(result);
  }

  static Future<RelatedProductsModel> relatedProducts(String productId) async {
    var result = await _httpHelper.get(url:"${ApiConstant.relatedProducts}$productId", isRequireAuthorization: true);
    return RelatedProductsModel.fromJson(result);
  }


  static Future<CategoryListWithProductsModel> categoryListWithProducts() async {
    var result = await _httpHelper.get(url:ApiConstant.categoryListWithProducts, isRequireAuthorization: true);
    return CategoryListWithProductsModel.fromJson(result);
  }


  static Future<TotalCartItemModel> totalCartItem() async {
    var result = await _httpHelper.get(url:ApiConstant.totalCartItem, isRequireAuthorization: true);
    return TotalCartItemModel.fromJson(result);
  }

  static Future<CartListModel> cartList() async {
    var result = await _httpHelper.get(url:ApiConstant.cartList, isRequireAuthorization: true);
    return CartListModel.fromJson(result);
  }


  static Future<DeleteProductFromCartModel> deleteProductFromCart(String productId) async {
    var result = await _httpHelper.delete(url: "${ApiConstant.deleteProductFromCart}$productId", isRequireAuthorization: true);
    return DeleteProductFromCartModel.fromJson(result);
  }

  static Future<PromoCodeListModel> promoCodeList() async {
    var result = await _httpHelper.get(url:ApiConstant.promoCodeList, isRequireAuthorization: true);
    return PromoCodeListModel.fromJson(result);
  }


  static Future<CreateCheckOutModel> createCheckOut(String body) async {
    var result = await _httpHelper.post(url: ApiConstant.createCheckOut, isRequireAuthorization: true, body: body);
    return CreateCheckOutModel.fromJson(result);
  }


  static Future<ApplyPromoCodeModel> applyPromoCode(String body) async {
    var result = await _httpHelper.post(url: ApiConstant.applyPromoCode, isRequireAuthorization: true, body: body);
    return ApplyPromoCodeModel.fromJson(result);
  }

  static Future<ApplyCharityModel> applyCharity(String body) async {
    var result = await _httpHelper.post(url: ApiConstant.applyCharity, isRequireAuthorization: true, body: body);
    return ApplyCharityModel.fromJson(result);
  }


  static Future<RemoveCharityFromCheckOutModel> removeCharityFromCheckout() async {
    var result = await _httpHelper.delete(url: ApiConstant.removeCharityFromCheckout, isRequireAuthorization: true);
    return RemoveCharityFromCheckOutModel.fromJson(result);
  }

  static Future<RemovePromoCodeFromCheckOutModel> removePromoCodeFromCheckout() async {
    var result = await _httpHelper.delete(url: ApiConstant.removePromoCodeFromCheckout, isRequireAuthorization: true);
    return RemovePromoCodeFromCheckOutModel.fromJson(result);
  }

  static Future<SocialLogInModel> socialLogIn(String body) async {
    var result = await _httpHelper.post(url: ApiConstant.socialLogIn,body: body);
    return SocialLogInModel.fromJson(result);
  }


  static Future<NotificationModel> notifications() async {
    var result = await _httpHelper.get(url:ApiConstant.getNotifications, isRequireAuthorization: true);
    return NotificationModel.fromJson(result);
  }


  static Future<AppBannersModel> appBanners() async {
    var result = await _httpHelper.get(url:ApiConstant.appBanners, isRequireAuthorization: true);
    return AppBannersModel.fromJson(result);
  }


  static Future<CreateOrderPlaceModel> createOrderPlace(ReqCreateOrderPlaceModel reqCreateOrderPlaceModel) async {
    var result = await _httpHelper.post(url: ApiConstant.createOrderPlace,body: jsonEncode(reqCreateOrderPlaceModel), isRequireAuthorization: true);
    return CreateOrderPlaceModel.fromJson(result);
  }


  static Future<CancelOrderModel> cancelOrder(String orderId) async {
    var result = await _httpHelper.delete(url: "${ApiConstant.cancelOrder}$orderId", isRequireAuthorization: true);
    return CancelOrderModel.fromJson(result);
  }


  static Future<MyOrdersModel> activeOrders(int page) async {
    var result = await _httpHelper.get(url:"${ApiConstant.myOrders}${"status=active&page=$page&limit=10"}", isRequireAuthorization: true);
    return MyOrdersModel.fromJson(result);
  }

  static Future<MyOrdersModel> completeOrders(int page) async {
    var result = await _httpHelper.get(url:"${ApiConstant.myOrders}${"status=completed&page=$page&limit=10"}", isRequireAuthorization: true);
    return MyOrdersModel.fromJson(result);
  }

  static Future<MyOrdersModel> cancelledOrders(int page) async {
    var result = await _httpHelper.get(url:"${ApiConstant.myOrders}${"status=cancelled&page=$page&limit=10"}", isRequireAuthorization: true);
    return MyOrdersModel.fromJson(result);
  }


  static Future<OrderDetailModel> orderDetail(String orderId) async {
    var result = await _httpHelper.get(url:"${ApiConstant.orderDetail}$orderId", isRequireAuthorization: true);
    return OrderDetailModel.fromJson(result);
  }


  static Future<ReOrderModel> reOrder(String body) async {
    var result = await _httpHelper.post(url: ApiConstant.reOrder,body: body, isRequireAuthorization: true);
    return ReOrderModel.fromJson(result);
  }


  static Future<OrderRatingModel> orderRating(String body) async {
    var result = await _httpHelper.post(url: ApiConstant.orderRating,body: body, isRequireAuthorization: true);
    return OrderRatingModel.fromJson(result);
  }




}