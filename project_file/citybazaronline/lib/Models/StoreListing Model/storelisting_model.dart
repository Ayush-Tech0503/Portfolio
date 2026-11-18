class StoreListingData {
  dynamic? status;
  dynamic? totalPages;
  dynamic? totalSellers;
  dynamic? page;
  dynamic? limit;
  dynamic? offset;
  List<SellerList>? sellerList;

  StoreListingData(
      {this.status,
        this.totalPages,
        this.totalSellers,
        this.page,
        this.limit,
        this.offset,
        this.sellerList});

  StoreListingData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalPages = json['total_pages'];
    totalSellers = json['total_sellers'];
    page = json['page'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['seller_list'] != null) {
      sellerList = <SellerList>[];
      json['seller_list'].forEach((v) {
        sellerList!.add(SellerList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['total_pages'] = totalPages;
    data['total_sellers'] = totalSellers;
    data['page'] = page;
    data['limit'] = limit;
    data['offset'] = offset;
    if (sellerList != null) {
      data['seller_list'] = sellerList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SellerList {
  dynamic? sellerId;
  dynamic? storeName;
  dynamic? storeSlug;
  dynamic? storeAddress;
  dynamic? storeDescription;
  dynamic? storeBannerName;
  dynamic? dealsIn;
  dynamic? contactNo;
  dynamic? storeLatitude;
  dynamic? storeLongitude;
  dynamic? facebookUrl;
  dynamic?twitterUrl;
  dynamic? instagramUrl;
  dynamic? userId;
  dynamic? email;
  dynamic? storeImageUrl;
  dynamic? todayStatus;
  dynamic? followedVal;
  dynamic? avgRating;
  dynamic? totalRateCount;
  dynamic? distanceInKm;
  dynamic? cashbackTag;
  dynamic? cashbackText;

  SellerList(
      {this.sellerId,
        this.storeName,
        this.storeSlug,
        this.storeAddress,
        this.storeDescription,
        this.storeBannerName,
        this.dealsIn,
        this.contactNo,
        this.storeLatitude,
        this.storeLongitude,
        this.facebookUrl,
        this.twitterUrl,
        this.instagramUrl,
        this.userId,
        this.email,
        this.storeImageUrl,
        this.todayStatus,
        this.followedVal,
        this.avgRating,
        this.totalRateCount,
        this.distanceInKm,
        this.cashbackTag,
        this.cashbackText});

  SellerList.fromJson(Map<String, dynamic> json) {
    sellerId = json['seller_id'];
    storeName = json['store_name'];
    storeSlug = json['store_slug'];
    storeAddress = json['store_address'];
    storeDescription = json['store_description'];
    storeBannerName = json['store_banner_name'];
    dealsIn = json['deals_in'];
    contactNo = json['contact_no'];
    storeLatitude = json['store_latitude'];
    storeLongitude = json['store_longitude'];
    facebookUrl = json['facebook_url'];
    twitterUrl = json['twitter_url'];
    instagramUrl = json['instagram_url'];
    userId = json['user_id'];
    email = json['email'];
    storeImageUrl = json['store_image_url'];
    todayStatus = json['today_status'];
    followedVal = json['followed_val'];
    avgRating = json['avg_rating'];
    totalRateCount = json['total_rate_count'];
    distanceInKm = json['distance_in_km'];
    cashbackTag = json['cashback_tag'];
    cashbackText = json['cashback_text'];
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
    data['contact_no'] = contactNo;
    data['store_latitude'] = storeLatitude;
    data['store_longitude'] = storeLongitude;
    data['facebook_url'] = facebookUrl;
    data['twitter_url'] = twitterUrl;
    data['instagram_url'] = instagramUrl;
    data['user_id'] = userId;
    data['email'] = email;
    data['store_image_url'] = storeImageUrl;
    data['today_status'] = todayStatus;
    data['followed_val'] = followedVal;
    data['avg_rating'] = avgRating;
    data['total_rate_count'] = totalRateCount;
    data['distance_in_km'] = distanceInKm;
    data['cashback_tag'] = cashbackTag;
    data['cashback_text'] = cashbackText;
    return data;
  }
}



