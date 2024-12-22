// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:convert';
import 'package:citybazaronline_seller_app/Models/shop_review_rating.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/Constant Api Routs/constant_api_routs.dart';
import '../../Utils/Theme/constant_colors.dart';
import '../../Widget/Scaffold Message/scaffold_message_widget.dart';


class ShopReviewRatingApiService {
  static Future<ShopReviewRatingModel?> fetchUploadedProductData({
    context,
    search,
    page,
    limit
  }) async {
    String? tokenAccess;
    dynamic sellerId;
    var baseUrl = '${ConstantUrls.baseUriApi}${ConstantUrls.shopReviewRatingEndPoint}';
    final dio = Dio();
    SharedPreferences preference = await SharedPreferences.getInstance();
    try {
      tokenAccess = preference.getString("access-token");
      sellerId = preference.getString("seller_id");
      final body = {"seller_id": sellerId?? "","order_by": "", "search":search,"page_no":page,"limit":limit};
      final response = await dio.post(
        baseUrl,
        options: Options(
          headers: {
            "Authorization": tokenAccess,
            'Content-Type': 'application/json',
          },
        ),
        data: json.encode(body),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.data);
        return ShopReviewRatingModel.fromJson(responseData);
      } else {
        LoadingScaffoldMessage.showSnackbar(
          context,
          "Something went wrong, try again later.",
          ConstantColor.primaryMainColor,
          const Duration(seconds: 2),
        );
        return null;
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout ||
          e.type == DioExceptionType.connectionError) {
        LoadingScaffoldMessage.showSnackbar(
          context,
          "Please check your internet connection",
          ConstantColor.primaryMainColor,
          const Duration(seconds: 3),
        );
      }
      return null;
    } catch (error) {
      LoadingScaffoldMessage.showSnackbar(
        context,
        "Something went wrong, please try again later!",
        ConstantColor.primaryMainColor,
        const Duration(seconds: 2),
      );
      return null;
    }
  }
}
