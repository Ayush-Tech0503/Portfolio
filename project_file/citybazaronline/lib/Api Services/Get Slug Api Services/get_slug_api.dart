// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Layouts/Famous Market/Store Details/Store Details Screen/store_details.dart';
import '../../Layouts/Main Reels Screen/home_page_nav_reels_screen.dart';
import '../../Layouts/Product View Screens/product_Item_Details.dart';
import '../../Util/Constant APi Url/api_urls.dart';
import '../../collapsing_appbar.dart';

class GetSlugApiServices {
  static Future<GetSlugsData?>getSlugApi({context,slug,type}) async {
    String? tokenAccess;
    var baseUrl = '${ConstantUrls.baseUriApi}${ConstantUrls.getSlugsEndPoint}';
    final dio = Dio();
    SharedPreferences preference = await SharedPreferences.getInstance();
    try {
      final body = {"slug":slug,"type": type??""};
      tokenAccess = preference.getString("access-token");
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
        if (responseData['status'] == 'success'){
          String page = responseData['data']['page'] ?? '';
          String ids = responseData['data']['id'] ?? '';
          if (page == 'seller') {
            Navigator.pushReplacement(
              context!,
              MaterialPageRoute(builder: (_) => StoreDetailScreen(sellersId: ids, id: '', latitude: '', longitude: '', lName: '')),
            );
          }
          else if (page == 'product') {
            Navigator.pushReplacement(
              context!,
              MaterialPageRoute(builder: (_) => ProductDetailScreen(proId: ids, id: '', longitude: '', latitude: '', lName: '')),
            );
          }
          else if (page == 'reels') {
            Navigator.pushReplacement(
              context!, MaterialPageRoute(builder: (_) => HomePageNavReelScreen(
              myBannerReelId: ids,
              latitude: '',
              longitude: '',
              id: '',
              lName: '',
            )),
            );
          }
          else {
            Navigator.pushReplacement(
              context!,
              MaterialPageRoute(builder: (_) => MyHomePageDemo1(mobilenumber: '', lat: '', longitude: '', id: '', lName: '')),
            );
          }
        }else {
          Navigator.pushReplacement(
            context!,
            MaterialPageRoute(builder: (_) => MyHomePageDemo1(mobilenumber: '', lat: '', longitude: '', id: '', lName: '')),
          );
        }
        return GetSlugsData.fromJson(responseData);
      }
      else {
        return null;
      }
    } on DioError catch (e) {
      return null;
    } catch (error) {
      return null;
    }
  }
}


class GetSlugs {
  String? status;
  GetSlugsData? data;

  GetSlugs({this.status, this.data});

  GetSlugs.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? GetSlugsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GetSlugsData {
  String? page;
  String? id;

  GetSlugsData({this.page, this.id});

  GetSlugsData.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['id'] = id;
    return data;
  }
}
