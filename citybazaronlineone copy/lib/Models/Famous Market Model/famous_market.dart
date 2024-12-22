class FamousMarkets {
  String? status;
  int? limit;
  String? page;
  int? offset;
  List<MarketSellerList>? sellerList;
  FamousMarkets(
      {this.status, this.limit, this.page, this.offset, this.sellerList});

  FamousMarkets.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    limit = json['limit'];
    page = json['page'];
    offset = json['offset'];
    if (json['seller_list'] != null) {
      sellerList = <MarketSellerList>[];
      json['seller_list'].forEach((v) {
        sellerList!.add(MarketSellerList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['limit'] = limit;
    data['page'] = page;
    data['offset'] = offset;
    if (sellerList != null) {
      data['seller_list'] = sellerList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MarketSellerList {
  String? sellerId;
  String? storeName;
  String? storeSlug;
  String? storeAddress;
  String? storeDescription;
  String? storeBannerName;
  String? dealsIn;
  String? facebookUrl;
  String? twitterUrl;
  String? instagramUrl;
  String? contactNo;
  String? storeLatitude;
  String? storeLongitude;
  String? userId;
  String? email;
  String? storeImageUrl;
  String? followedVal;
  String? avgRating;
  String? totalRateCount;
  String? todayStatus;
  double? distanceInKm;

  MarketSellerList(
      {this.sellerId,
        this.storeName,
        this.storeSlug,
        this.storeAddress,
        this.storeDescription,
        this.storeBannerName,
        this.dealsIn,
        this.facebookUrl,
        this.twitterUrl,
        this.instagramUrl,
        this.contactNo,
        this.storeLatitude,
        this.storeLongitude,
        this.userId,
        this.email,
        this.storeImageUrl,
        this.followedVal,
        this.avgRating,
        this.totalRateCount,
        this.todayStatus,
        this.distanceInKm});

  MarketSellerList.fromJson(Map<String, dynamic> json) {
    sellerId = json['seller_id'];
    storeName = json['store_name'];
    storeSlug = json['store_slug'];
    storeAddress = json['store_address'];
    storeDescription = json['store_description'];
    storeBannerName = json['store_banner_name'];
    dealsIn = json['deals_in'];
    facebookUrl = json['facebook_url'];
    twitterUrl = json['twitter_url'];
    instagramUrl = json['instagram_url'];
    contactNo = json['contact_no'];
    storeLatitude = json['store_latitude'];
    storeLongitude = json['store_longitude'];
    userId = json['user_id'];
    email = json['email'];
    storeImageUrl = json['store_image_url'];
    followedVal = json['followed_val'];
    avgRating = json['avg_rating'];
    totalRateCount = json['total_rate_count'];
    todayStatus = json['today_status'];
    distanceInKm = json['distance_in_km'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['seller_id'] = sellerId;
    data['store_name'] = storeName;
    data['store_slug'] = storeSlug;
    data['store_address'] = storeAddress;
    data['store_description'] = storeDescription;
    data['store_banner_name'] = storeBannerName;
    data['deals_in'] = dealsIn;
    data['facebook_url'] = facebookUrl;
    data['twitter_url'] = twitterUrl;
    data['instagram_url'] = instagramUrl;
    data['contact_no'] = contactNo;
    data['store_latitude'] = storeLatitude;
    data['store_longitude'] = storeLongitude;
    data['user_id'] = userId;
    data['email'] = email;
    data['store_image_url'] = storeImageUrl;
    data['followed_val'] = followedVal;
    data['avg_rating'] = avgRating;
    data['total_rate_count'] = totalRateCount;
    data['today_status'] = todayStatus;
    data['distance_in_km'] = distanceInKm;
    return data;
  }
}
