//ignore_for_file: use_build_context_synchronously, empty_catches, deprecated_member_use, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/Theme/constant_colors.dart';
import '../../Widget/Scaffold Message/scaffold_message_widget.dart';
import '../Models/dashboard_model.dart';
import '../Utils/Constant Api Routs/constant_api_routs.dart';

class DashboardResponse {
  final DashboardData? dashboardData;
  // final SellerData? sellerData;
  final countSellerRating;
  final storeName;
  final storeAddress;
  final storeContactNo;
  final SubPlanName;
  final SubPlanExpDate;
  final SubPlanStartDate;
  final imageFile;
  final CountFollowerSeller? countFollowerSeller;

  DashboardResponse({this.imageFile,this.SubPlanName,this.SubPlanStartDate, this.SubPlanExpDate, this.storeAddress,this.storeContactNo, this.storeName, this.countSellerRating,this.dashboardData,this.countFollowerSeller});
}

class ApiService {
  static Future<DashboardResponse?> fetchDashboardData(BuildContext context) async {
    String? tokenAccess;
     var baseUrl = '${ConstantUrls.baseUriApi}${ConstantUrls.sellerDashboardEndPoint}';
    final dio = Dio();
    SharedPreferences preference = await SharedPreferences.getInstance();
    try {
      tokenAccess = preference.getString("access-token");
      final response = await dio.post(
        baseUrl,
        options: Options(
          headers: {
            "Authorization": tokenAccess,
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        var responseData = json.decode(response.data.toString());
        var storeAddress = responseData["seller_data"]["store_address"];
        var storeName = responseData["seller_data"]["store_name"];
        var storeContactNo = responseData["seller_data"]["contact_no"];
        var storeRating = responseData["countSellerRating"]["all"];
        var imageFile = responseData["seller_data"]["store_logo_name"];
        var countFollowerSeller = CountFollowerSeller.fromJson(responseData);
        var dashboardData = DashboardData.fromJson(responseData);

        String SubPlanName = "";
        String SubPlanExpDate = "";
        String SubPlanStartDate = "";

        if (responseData['msubs_data'] != null && responseData['msubs_data'].isNotEmpty) {
          SubPlanName = responseData['msubs_data'][0]["plan_details"]["subscription_name"];
          SubPlanExpDate = responseData['msubs_data'][0]["sbuscription_end_date"];
          SubPlanStartDate = responseData['msubs_data'][0]["sbuscription_start_date"];
        }
        return DashboardResponse(
            dashboardData: dashboardData,
            // sellerData: sellerData,
            countFollowerSeller: countFollowerSeller,
            countSellerRating:storeRating,
            storeAddress:storeAddress,
            storeContactNo:storeContactNo,
            storeName:storeName,
            SubPlanExpDate: SubPlanExpDate,
            imageFile:imageFile,
            SubPlanStartDate:SubPlanStartDate,
          SubPlanName: SubPlanName
        );
      }
      else {
        return null;
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout || e.type == DioErrorType.receiveTimeout || e.type == DioErrorType.sendTimeout || e.type == DioExceptionType.connectionError) {
        // Handle connection error
        LoadingScaffoldMessage.showSnackbar(
          context, "Please check your internet connection",
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