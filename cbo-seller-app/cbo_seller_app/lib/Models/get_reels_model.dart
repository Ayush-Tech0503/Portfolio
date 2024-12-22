class GetReelsModel {
  String? status;
  int? totalPages;
  String? baseUrl;
  int? pageNo;
  String? limit;
  int? offset;
  int? count;
  String? totalCount;
  List<GetReelsData>? data;

  GetReelsModel(
      {this.status,
        this.totalPages,
        this.baseUrl,
        this.pageNo,
        this.limit,
        this.offset,
        this.count,
        this.totalCount,
        this.data});

  GetReelsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalPages = json['total_pages'];
    baseUrl = json['base_url'];
    pageNo = json['page_no'];
    limit = json['limit'];
    offset = json['offset'];
    count = json['count'];
    totalCount = json['total_count'];
    if (json['data'] != null) {
      data = <GetReelsData>[];
      json['data'].forEach((v) {
        data!.add(GetReelsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['total_pages'] = totalPages;
    data['base_url'] = baseUrl;
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

class GetReelsData {
  String? id;
  String? postLink;
  String? thumbnail;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? keyword;
  String? description;
  String? userId;
  String? postType;
  String? category;
  String? feed;
  String? deletedAt;
  String? numberoffiles;
  String? lat;
  String? long;
  String? city;
  String? storeId;
  String? storeName;
  String? storeNumber;
  String? storeSlug;
  String? storeImageUrl;
  String? shareLink;
  String? followVal;
  String? likeCount;
  String? commentCount;
  String? views;
  String? isSave;
  String? isLike;
  String? isComment;

  GetReelsData(
      {this.id,
        this.postLink,
        this.thumbnail,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.keyword,
        this.description,
        this.userId,
        this.postType,
        this.category,
        this.feed,
        this.deletedAt,
        this.numberoffiles,
        this.lat,
        this.long,
        this.city,
        this.storeId,
        this.storeName,
        this.storeNumber,
        this.storeSlug,
        this.storeImageUrl,
        this.shareLink,
        this.followVal,
        this.likeCount,
        this.commentCount,
        this.views,
        this.isSave,
        this.isLike,
        this.isComment});

  GetReelsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postLink = json['post_link'];
    thumbnail = json['thumbnail'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    keyword = json['keyword'];
    description = json['description'];
    userId = json['user_id'];
    postType = json['post_type'];
    category = json['category'];
    feed = json['feed'];
    deletedAt = json['deleted_at'];
    numberoffiles = json['numberoffiles'];
    lat = json['lat'];
    long = json['long'];
    city = json['city'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    storeNumber = json['store_number'];
    storeSlug = json['store_slug'];
    storeImageUrl = json['store_image_url'];
    shareLink = json['share_link'];
    followVal = json['follow_val'];
    likeCount = json['like_count'];
    commentCount = json['comment_count'];
    views = json['views'];
    isSave = json['is_save'];
    isLike = json['is_like'];
    isComment = json['is_comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['post_link'] = postLink;
    data['thumbnail'] = thumbnail;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['keyword'] = keyword;
    data['description'] = description;
    data['user_id'] = userId;
    data['post_type'] = postType;
    data['category'] = category;
    data['feed'] = feed;
    data['deleted_at'] = deletedAt;
    data['numberoffiles'] = numberoffiles;
    data['lat'] = lat;
    data['long'] = long;
    data['city'] = city;
    data['store_id'] = storeId;
    data['store_name'] = storeName;
    data['store_number'] = storeNumber;
    data['store_slug'] = storeSlug;
    data['store_image_url'] = storeImageUrl;
    data['share_link'] = shareLink;
    data['follow_val'] = followVal;
    data['like_count'] = likeCount;
    data['comment_count'] = commentCount;
    data['views'] = views;
    data['is_save'] = isSave;
    data['is_like'] = isLike;
    data['is_comment'] = isComment;
    return data;
  }
}
