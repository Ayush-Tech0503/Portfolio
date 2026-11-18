class UserReviewData {
  String? status;
  int? totalPages;
  int? pageNo;
  String? limit;
  int? offset;
  int? count;
  String? totalCount;
  List<Data>? data;

  UserReviewData(
      {this.status,
        this.totalPages,
        this.pageNo,
        this.limit,
        this.offset,
        this.count,
        this.totalCount,
        this.data});

  UserReviewData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalPages = json['total_pages'];
    pageNo = json['page_no'];
    limit = json['limit'];
    offset = json['offset'];
    count = json['count'];
    totalCount = json['total_count'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  dynamic storeName;
  dynamic storeSlug;
  dynamic storeLocAddress;
  dynamic storeLogoName;
  dynamic dealsIn;
  dynamic userId;
  dynamic sellerId;
  dynamic review;
  dynamic reviewId;
  dynamic ratingNumber;
  dynamic storeImageUrl;

  Data(
      {this.storeName,
        this.storeSlug,
        this.storeLocAddress,
        this.storeLogoName,
        this.dealsIn,
        this.userId,
        this.sellerId,
        this.review,
        this.reviewId,
        this.ratingNumber,
        this.storeImageUrl});

  Data.fromJson(Map<String, dynamic> json) {
    storeName = json['store_name'];
    storeSlug = json['store_slug'];
    storeLocAddress = json['store_loc_address'];
    storeLogoName = json['store_logo_name'];
    dealsIn = json['deals_in'];
    userId = json['user_id'];
    sellerId = json['seller_id'];
    review = json['review'];
    reviewId = json['review_id'];
    ratingNumber = json['rating_number'];
    storeImageUrl = json['store_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['store_name'] = storeName;
    data['store_slug'] = storeSlug;
    data['store_loc_address'] = storeLocAddress;
    data['store_logo_name'] = storeLogoName;
    data['deals_in'] = dealsIn;
    data['user_id'] = userId;
    data['seller_id'] = sellerId;
    data['review'] = review;
    data['review_id'] = reviewId;
    data['rating_number'] = ratingNumber;
    data['store_image_url'] = storeImageUrl;
    return data;
  }
}
