// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utils/Constant Api Routs/constant_api_routs.dart';
import '../../../Utils/Payment Getway/payment_getway_screen.dart';
import '../../../Utils/Theme/constant_colors.dart';
import '../../../Widget/Scaffold Message/scaffold_message_widget.dart';
import 'package:flutter/material.dart';

class ApiEMIOrderService {
  static Future<Map<String, dynamic>?> fetchEMIOrderData({
      context,
    required String emiAmountPM,
    required String emiDate,
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
    var baseUrl = '${ConstantUrls.baseUriApi}${ConstantUrls.subscriptionPlanEMIOrderEndPoint}';
    final dio = Dio();
    SharedPreferences preference = await SharedPreferences.getInstance();
    try {
      tokenAccess = preference.getString("access-token");
      final body = {
        "accode": "",
        "duration_month": "12",
        "duration_plan": "yearly_price",
        "emiAmountPM": emiAmountPM,
        "emi_date": emiDate,
        "existing_plan_discount": "0",
        "expiry_date": subEndDate,
        "orderAmount": orderAmount,
        "order_id": "0",
        "payment_duration": planAmt,
        "plan_amt": planAmt,
        "plan_type": "emi",
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
                  paymentUrl: responseData['data']['url'],
                  encryptedData: responseData['data']['encrypted_data'],
                  accessCode: responseData['data']['access_code'],
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


