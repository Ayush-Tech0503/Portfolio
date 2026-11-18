import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Api Services/Order Listing Api Services/order_listing_api_services.dart';
import '../Models/Order Listing Model/order_listing_model.dart';
import '../Util/Const Toster/toster.dart';
import '../Util/constant_color.dart';

class OrderController extends GetxController {
  final OrderListingApiService apiService = OrderListingApiService();
  var orders = <OrderListData>[].obs;
  var isLoading = false.obs;
  var hasMore = true.obs; // To check if more data is available
  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }
  void fetchOrders() async {
    if (!hasMore.value) return;
    isLoading(true);
    try {
      final orderList = await apiService.fetchOrderListingData();
      if (orderList != null && orderList.data != null) {
        if (orderList.data!.isEmpty) {
          hasMore(false);
        } else {
          orders.addAll(orderList.data!);
        }
      } else {hasMore(false);}
    } catch (e) {
      Get.snackbar(
        "Error",
        "Error fetching orders: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      hasMore(false);
    } finally { isLoading(false);}
  }

  //-------------cancel order api controller -----------
  Future cancelOrder({orderId,status,context}) async {
    final success = await apiService.cancelOrder(orderId:orderId,status:status);
    if (success) {
      LoadingScaffoldMessage.showSnackbar(
        context,
        "Order canceled successfully",
        ConstantColor.primaryMainColor,
        const Duration(seconds: 2),
      );
      // orders.removeWhere((order) => order.orderId == orderId);
    } else {
      LoadingScaffoldMessage.showSnackbar(
        context,
        "Failed to cancel the order",
        ConstantColor.primaryMainColor,
        const Duration(seconds: 2),
      );
    }
  }
}
