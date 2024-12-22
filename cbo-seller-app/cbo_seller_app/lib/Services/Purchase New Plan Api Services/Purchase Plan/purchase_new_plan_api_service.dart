// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utils/Constant Api Routs/constant_api_routs.dart';
import '../../../Utils/Payment Getway/payment_getway_screen.dart';
import '../../../Utils/Theme/constant_colors.dart';
import '../../../Widget/Scaffold Message/scaffold_message_widget.dart';
import 'package:flutter/material.dart';

class ApiOrderService {
  static Future<Map<String, dynamic>?> fetchOrderData({
    context,
    required String accode,
    required String subEndDate,
    required String orderAmount,
    required String planAmt,
    required String? referralCode,
    required String subscriptionId,
    required String cgstAmount,
    required String sgstAmount,
    required String? stateName,
    required String taxableAmt,
  }) async {
    String? tokenAccess;
    var baseUrl = '${ConstantUrls.baseUriApi}${ConstantUrls.subscriptionPlanOrderEndPoint}';
    final dio = Dio();
    SharedPreferences preference = await SharedPreferences.getInstance();

    try {
      tokenAccess = preference.getString("access-token");
      final body = {
        "accode": accode??"",
        "duration_month": "12",
        "duration_plan": "yearly_price",
        "existing_plan_discount": "0",
        "expiry_date": subEndDate,
        "orderAmount": orderAmount,
        "order_id": "0",
        "plan_amt": planAmt,
        "referral_code": referralCode,
        "subscription_id": subscriptionId,
        "tax_cgst_amt": cgstAmount,
        "tax_sgst_amt": sgstAmount,
        "tax_state": stateName ?? "Madhya Pradesh",
        "taxable_amt": taxableAmt,
      };
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
        if (responseData['status'] == 'success') {
          LoadingScaffoldMessage.showSnackbar(
            context, "Submitted Successfully",
            ConstantColor.primaryMainColor,
            const Duration(seconds: 2),
          );
          if (responseData['data']['url'] != null && responseData['data']['url'].isNotEmpty) {
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentGatewayScreen(
                  encryptedData: responseData['data']['encrypted_data'],
                  accessCode: responseData['data']['access_code'],
                  paymentUrl: responseData['data']['url'],
                ),
              ),
            );
          }
        }
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout || e.type == DioErrorType.receiveTimeout || e.type == DioErrorType.sendTimeout || e.type == DioErrorType.connectionError) {
        LoadingScaffoldMessage.showSnackbar(
          context, "Please check your internet connection",
          ConstantColor.primaryMainColor,
          const Duration(seconds: 3),
        );
      }
    } catch (error) {}
    return null;
  }
}

