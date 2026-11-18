class DashBoardScreenData {
  DashboardData? dashboardData;

  DashBoardScreenData({this.dashboardData});

  DashBoardScreenData.fromJson(Map<String, dynamic> json) {
    dashboardData = json['dashboard_data'] != null
        ? DashboardData.fromJson(json['dashboard_data'])
        : null;
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
  dynamic? totLikedProduct;
  dynamic? totWishlistedProduct;
  dynamic? totWantBuyProduct;
  dynamic? totFollowedSeller;
  dynamic? totSellerReviews;
  dynamic? orderCount;
  dynamic? saveCount;

  DashboardData(
      {this.totLikedProduct,
        this.totWishlistedProduct,
        this.totWantBuyProduct,
        this.totFollowedSeller,
        this.totSellerReviews,
        this.orderCount,
        this.saveCount});

  DashboardData.fromJson(Map<String, dynamic> json) {
    totLikedProduct = json['tot_liked_product'];
    totWishlistedProduct = json['tot_wishlisted_product'];
    totWantBuyProduct = json['tot_want_buy_product'];
    totFollowedSeller = json['tot_followed_seller'];
    totSellerReviews = json['tot_seller_reviews'];
    orderCount = json['order_count'];
    saveCount = json['save_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tot_liked_product'] = totLikedProduct;
    data['tot_wishlisted_product'] = totWishlistedProduct;
    data['tot_want_buy_product'] = totWantBuyProduct;
    data['tot_followed_seller'] = totFollowedSeller;
    data['tot_seller_reviews'] = totSellerReviews;
    data['order_count'] = orderCount;
    data['save_count'] = saveCount;
    return data;
  }
}
