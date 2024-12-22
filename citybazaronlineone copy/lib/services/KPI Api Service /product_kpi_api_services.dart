
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Util/Constant APi Url/api_urls.dart';

    productPageKpiApiServices({type,productId}) async {
  String? tokenAccess;
  var baseUrl = '${ConstantUrls.baseUriApi}${ConstantUrls.forProductsKpiApi}';
  SharedPreferences preferences = await SharedPreferences.getInstance();
  Dio dio = Dio();

  try {
    tokenAccess = preferences.getString("access-token");
    final body = {"type": type, "product_id": productId,"source":"app"};

    final response = await dio.get(
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
      return json.decode(response.data);
    } else {
      return null;
    }
  } catch (error) {
    return null;
  }
}
