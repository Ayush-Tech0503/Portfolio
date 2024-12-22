class FollowerSellerListingModel {
  String? status;
  int? totalPages;
  int? pageNo;
  String? limit;
  int? offset;
  int? count;
  String? totalCount;
  List<FollowerSellerListingData>? data;

  FollowerSellerListingModel(
      {this.status,
        this.totalPages,
        this.pageNo,
        this.limit,
        this.offset,
        this.count,
        this.totalCount,
        this.data});

  FollowerSellerListingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalPages = json['total_pages'];
    pageNo = json['page_no'];
    limit = json['limit'];
    offset = json['offset'];
    count = json['count'];
    totalCount = json['total_count'];
    if (json['data'] != null) {
      data = <FollowerSellerListingData>[];
      json['data'].forEach((v) {
        data!.add(FollowerSellerListingData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['total_pages'] = totalPages;
    data['page_no'] = pageNo;
    data['limit'] = limit;
    data['offset'] = offset;
    data['count'] = count;
    data['total_count'] = totalCount;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FollowerSellerListingData {
  String? followedId;
  String? storeId;
  String? storeName;
  String? storeSlug;
  String? storeAddress;
  String? storeLogoName;
  String? dealsIn;
  String? storeImageUrl;
  dynamic? avgRating;
  String? firstName;
  dynamic? lastName;
  String? email;
  String? mobile;
  String? gender;

  FollowerSellerListingData(
      {this.followedId,
        this.storeId,
        this.storeName,
        this.storeSlug,
        this.storeAddress,
        this.storeLogoName,
        this.dealsIn,
        this.storeImageUrl,
        this.avgRating,
        this.firstName,
        this.lastName,
        this.email,
        this.mobile,
        this.gender});

  FollowerSellerListingData.fromJson(Map<String, dynamic> json) {
    followedId = json['followed_id'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    storeSlug = json['store_slug'];
    storeAddress = json['store_address'];
    storeLogoName = json['store_logo_name'];
    dealsIn = json['deals_in'];
    storeImageUrl = json['store_image_url'];
    avgRating = json['avg_rating'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['followed_id'] = followedId;
    data['store_id'] = storeId;
    data['store_name'] = storeName;
    data['store_slug'] = storeSlug;
    data['store_address'] = storeAddress;
    data['store_logo_name'] = storeLogoName;
    data['deals_in'] = dealsIn;
    data['store_image_url'] = storeImageUrl;
    data['avg_rating'] = avgRating;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['mobile'] = mobile;
    data['gender'] = gender;
    return data;
  }
}
