// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../Api Services/Card Api Services/card_api_services.dart';
// import '../../Models/Card Details Model/card_details_model.dart';
//
// class CardDetailController extends GetxController {
//   final CardDetailsApisService apiService = CardDetailsApisService();
//   var cardDetails = <Data>[].obs;
//   var isLoading = false.obs;
//   var hasMore = true.obs; // To check if more data is available
//   // var page = 1;
//   // final limit = 10;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchCardDetails();
//   }
//
//   void fetchCardDetails() async {
//     if (!hasMore.value) return;
//
//     isLoading(true);
//     try {
//       final cardDetailsListing = await apiService.fetchCardDetailsData();
//       if (cardDetailsListing != null && cardDetailsListing.data != null) {
//         if (cardDetailsListing.data!.isEmpty) {
//           hasMore(false);
//         } else {
//           cardDetails.addAll(cardDetailsListing.data!);
//           // Get.snackbar(
//           //   "Success",
//           //   "cardDetails loaded successfully",
//           //   snackPosition: SnackPosition.BOTTOM,
//           //   backgroundColor: Colors.green,
//           //   colorText: Colors.white,
//           // );
//         }
//       } else {
//         hasMore(false);
//       }
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         "Error fetching cardDetails: $e",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       hasMore(false);
//     } finally {
//       isLoading(false);
//     }
//   }
//   void refreshCardDetails() {
//     cardDetails.clear(); // Optionally clear current data
//     fetchCardDetails(); // Re-fetch the data
//   }
// }
//
//
