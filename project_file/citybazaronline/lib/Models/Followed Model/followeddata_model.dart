class FollowedData {
  FollowedData({
     this.status,
     this.totalPages,
     this.pageNo,
     this.limit,
     this.offset,
     this.count,
     this.totalCount,
     this.data,
  });
  late final String? status;
  late final int? totalPages;
  late final int? pageNo;
  late final String? limit;
  late final int? offset;
  late final int? count;
  late final String? totalCount;
  late final List<FollowedDataList>? data;

  FollowedData.fromJson(Map<String, dynamic> json){
    status = json['status'];
    totalPages = json['total_pages'];
    pageNo = json['page_no'];
    limit = json['limit'];
    offset = json['offset'];
    count = json['count'];
    totalCount = json['total_count'];
    data = List.from(json['data']).map((e)=>FollowedDataList.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['total_pages'] = totalPages;
    _data['page_no'] = pageNo;
    _data['limit'] = limit;
    _data['offset'] = offset;
    _data['count'] = count;
    _data['total_count'] = totalCount;
    _data['data'] = data!.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class FollowedDataList {
  FollowedDataList({
     this.followedId,
     this.storeId,
     this.storeName,
     this.storeSlug,
     this.storeAddress,
     this.dealsIn,
     this.storeImageUrl,
    this.avgRating,
    this.todayStatus,
  });
  late final String? followedId;
  late final String? storeId;
  late final String? storeName;
  late final String? storeSlug;
  late final String? storeAddress;
  late final String? dealsIn;
  late final String? storeImageUrl;
  late final String? avgRating;
  late final String? todayStatus;

  FollowedDataList.fromJson(Map<String, dynamic> json){
    followedId = json['followed_id'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    storeSlug = json['store_slug'];
    storeAddress = json['store_address'];
    dealsIn = json['deals_in'];
    storeImageUrl = json['store_image_url'];
    avgRating = json['avg_rating'];
    todayStatus = json['today_status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['followed_id'] = followedId;
    _data['store_id'] = storeId;
    _data['store_name'] = storeName;
    _data['store_slug'] = storeSlug;
    _data['store_address'] = storeAddress;
    _data['deals_in'] = dealsIn;
    _data['store_image_url'] = storeImageUrl;
    _data['avg_rating'] = avgRating;
    _data['today_status'] = todayStatus;
    return _data;
  }
}