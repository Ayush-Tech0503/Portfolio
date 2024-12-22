class DashBoardScreenData {
  DashboardData? dashboardData;

  DashBoardScreenData({this.dashboardData});

  DashBoardScreenData.fromJson(Map<String, dynamic> json) {
    dashboardData = json['dashboard_data'] != null
        ? DashboardData.fromJson(json['dashboard_data'])
        : DashboardData(); // Default to empty DashboardData if null
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dashboardData != null) {
      data['dashboard_data'] = dashboardData!.toJson();
    }
    return data;
  }
}

class DashboardData {
  String? totLikedProduct;
  String? totWishlistedProduct;
  String? totWantBuyProduct;
  String? totFollowedSeller;
  String? totSellerReviews;
  String? saveCount;

  DashboardData({
    this.totLikedProduct,
    this.totWishlistedProduct,
    this.totWantBuyProduct,
    this.totFollowedSeller,
    this.totSellerReviews,
    this.saveCount,
  });

  DashboardData.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      totLikedProduct = json['tot_liked_product'] as String? ?? '';
      totWishlistedProduct = json['tot_wishlisted_product'] as String? ?? '';
      totWantBuyProduct = json['tot_want_buy_product'] as String? ?? '';
      totFollowedSeller = json['tot_followed_seller'] as String? ?? '';
      totSellerReviews = json['tot_seller_reviews'] as String? ?? '';
      saveCount = json['save_count'] as String? ?? '';
    } else {
      // Handle case where json is null
      totLikedProduct = '';
      totWishlistedProduct = '';
      totWantBuyProduct = '';
      totFollowedSeller = '';
      totSellerReviews = '';
      saveCount = '';
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tot_liked_product'] = totLikedProduct;
    data['tot_wishlisted_product'] = totWishlistedProduct;
    data['tot_want_buy_product'] = totWantBuyProduct;
    data['tot_followed_seller'] = totFollowedSeller;
    data['tot_seller_reviews'] = totSellerReviews;
    data['save_count'] = saveCount;
    return data;
  }
}

