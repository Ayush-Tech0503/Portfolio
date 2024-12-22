// class ReelList {
//   dynamic? status;
//   dynamic? totalPages;
//   dynamic? pageNo;
//   dynamic? baseUrl;
//   dynamic? limit;
//   dynamic? offset;
//   dynamic? count;
//   dynamic? totalCount;
//   List<ReelListData>? reelDataList;
//
//   ReelList(
//       {this.status,
//         this.totalPages,
//         this.pageNo,
//         this.baseUrl,
//         this.limit,
//         this.offset,
//         this.count,
//         this.totalCount,
//         this.reelDataList});
//
//   ReelList.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     totalPages = json['total_pages'];
//     pageNo = json['page_no'];
//     baseUrl=json['base_url'];
//     limit = json['limit'];
//     offset = json['offset'];
//     count = json['count'];
//     totalCount = json['total_count'];
//     if (json['data'] != null) {
//       reelDataList = <ReelListData>[];
//       json['data'].forEach((v) {
//         reelDataList!.add(ReelListData.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['total_pages'] = totalPages;
//     data['page_no'] = pageNo;
//     data['base_url']=baseUrl;
//     data['limit'] = limit;
//     data['offset'] = offset;
//     data['count'] = count;
//     data['total_count'] = totalCount;
//     if (reelDataList != null) {
//       data['data'] = reelDataList!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class ReelListData {
//   String? id;
//   String? userId;
//   String? postLink;
//   String? postType;
//   String? category;
//   String? status;
//   String? thumbnail;
//   String? createdAt;
//   String? keyword;
//   String? deletedAt;
//   String? feed;
//   String? storeId;
//   String? share_link;
//   String? storeName;
//   String? storeImageUrl;
//   String? share;
//   String? likeCount;
//   String? commentCount;
//   String? views;
//   String? isLike;
//   String? isSave;
//   String? isFollow;
//   String? storeNumber;
//   String? isComment;
//
//   ReelListData(
//       {this.id,
//         this.userId,
//         this.postLink,
//         this.postType,
//         this.category,
//         this.status,
//         this.thumbnail,
//         this.createdAt,
//         this.keyword,
//         this.deletedAt,
//         this.feed,
//         this.storeId,
//         this.share_link,
//         this.storeName,
//         this.storeImageUrl,
//         this.share,
//         this.likeCount,
//         this.commentCount,
//         this.views,
//         this.isLike,
//         this.isSave,
//         this.isFollow,
//         this.storeNumber,
//         this.isComment});
//
//   ReelListData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     thumbnail = json['thumbnail'];
//     postLink = json['post_link'];
//     postType = json['post_type'];
//     category = json['category'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     keyword = json['keyword'];
//     deletedAt = json['deleted_at'];
//     share_link = json['share_link'];
//     feed = json['feed'];
//     storeId = json['store_id'];
//     storeName = json['store_name'];
//     storeImageUrl = json['store_image_url'];
//     share = json['share'];
//     likeCount = json['like_count'];
//     commentCount = json['comment_count'];
//     views = json['views'];
//     isLike = json['is_like'];
//     isSave = json['is_save'];
//     isFollow = json['follow_val'];
//     storeNumber = json['store_number'];
//     isComment = json['is_comment'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['user_id'] = userId;
//     data['post_link'] = postLink;
//     data['post_type'] = postType;
//     data['thumbnail'] = thumbnail;
//     data['category'] = category;
//     data['status'] = status;
//     data['created_at'] = createdAt;
//     data['keyword'] = keyword;
//     data['deleted_at'] = deletedAt;
//     data['feed'] = feed;
//     data['store_name'] = storeName;
//     data['store_image_url'] = storeImageUrl;
//     data['store_id'] = storeId;
//     data['share_link'] = share_link;
//     data['share'] = share;
//     data['like_count'] = likeCount;
//     data['comment_count'] = commentCount;
//     data['views'] = views;
//     data['is_like'] = isLike;
//     data['is_save'] = isSave;
//     data['follow_val'] = isFollow;
//     data['store_number'] = storeNumber;
//     data['is_comment'] = isComment;
//     return data;
//   }
// }
//


// ignore_for_file: non_constant_identifier_names

class ReelList {
  dynamic? status;
  dynamic? totalPages;
  dynamic? baseUrl;
  dynamic? pageNo;
  dynamic? limit;
  dynamic? offset;
  dynamic? count;
  dynamic? totalCount;
  List<ReelListData>? reelDataList;

  ReelList(
      {this.status,
        this.totalPages,
        this.baseUrl,
        this.pageNo,
        this.limit,
        this.offset,
        this.count,
        this.totalCount,
        this.reelDataList});

  ReelList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalPages = json['total_pages'];
    baseUrl = json['base_url'];
    pageNo = json['page_no'];
    limit = json['limit'];
    offset = json['offset'];
    count = json['count'];
    totalCount = json['total_count'];
    if (json['data'] != null) {
      reelDataList = <ReelListData>[];
      json['data'].forEach((v) {
        reelDataList!.add(ReelListData.fromJson(v));
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
    if (reelDataList != null) {
      data['data'] = reelDataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReelListData {
  dynamic? id;
  dynamic? postLink;
  dynamic? thumbnail;
  dynamic? status;
  dynamic? createdAt;
  dynamic? updatedAt;
  dynamic? keyword;
  dynamic? description;
  dynamic? userId;
  dynamic? postType;
  dynamic? category;
  dynamic? feed;
  dynamic? deletedAt;
  dynamic? numberoffiles;
  dynamic? lat;
  dynamic? long;
  dynamic? city;
  dynamic? scheduling;
  dynamic? storeId;
  dynamic? storeName;
  dynamic? storeNumber;
  dynamic? storeSlug;
  dynamic? storeImageUrl;
  dynamic? share_link;
  dynamic? followVal;
  dynamic? likeCount;
  dynamic? commentCount;
  dynamic? views;
  dynamic? isFollow;
  dynamic? isSave;
  dynamic? isLike;
  dynamic? isComment;

  ReelListData(
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
        this.scheduling,
        this.storeId,
        this.storeName,
        this.storeNumber,
        this.storeSlug,
        this.storeImageUrl,
        this.share_link,
        this.followVal,
        this.likeCount,
        this.commentCount,
        this.views,
        this.isFollow,
        this.isSave,
        this.isLike,
        this.isComment});

  ReelListData.fromJson(Map<String, dynamic> json) {
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
    scheduling = json['scheduling'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    storeNumber = json['store_number'];
    storeSlug = json['store_slug'];
    storeImageUrl = json['store_image_url'];
    share_link = json['share_link'];
    followVal = json['follow_val'];
    likeCount = json['like_count'];
    commentCount = json['comment_count'];
    views = json['views'];
    isSave = json['is_save'];
    isFollow = json['follow_val'];
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
    data['scheduling'] = scheduling;
    data['store_id'] = storeId;
    data['store_name'] = storeName;
    data['store_number'] = storeNumber;
    data['store_slug'] = storeSlug;
    data['store_image_url'] = storeImageUrl;
    data['share_link'] = share_link;
    data['follow_val'] = followVal;
    data['like_count'] = likeCount;
    data['comment_count'] = commentCount;
    data['views'] = views;
    data['follow_val'] = isFollow;
    data['is_save'] = isSave;
    data['is_like'] = isLike;
    data['is_comment'] = isComment;
    return data;
  }
}
